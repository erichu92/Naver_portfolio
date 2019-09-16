import numpy as np
from HW_neuron_200N_5t import neuron
import random
from matplotlib import pyplot as plt
# from recep_field import rf
import cv2
from HW_spike_train_200N_5t import encode
from HW_spike_train_temporal_255 import tempo
# from rl_200N_5t import rl
# from rl_200N_5t import update
from HW_reconstruct_all_ext import reconst_weights
#from HW_reconstruct_all_ext import reconst_confusion
from Temporal_coding_parameters import param as par  ####### 50, 50 steps
# from var_th import threshold
# import os
from load_MNIST import mnist  # 추가
import datetime  # 추가
import time as tt
import math
from numpy import interp
import torch
import tensorflow as tf
import pickle
import torch.nn as nn

Datetime1 = datetime.datetime.now()
start = tt.time()

#parameter 선언
train_data_num = 60000
test_data_num = 10000

fire = 0
fire_time = 0
classify_period = 60000
homeostasis_term = 0.005

coeff = 0.07
train_images, train_labels, test_images, test_labels = mnist()  # 추가
result = np.zeros((par.n, 10))
confusion = np.zeros((par.n, 10))
amplitude = 0.8*30*1e-6 # (read voltage x read time)
cap = 1e-13
cap_coeff = 540

#행렬 선언
total_mem_sum = 0
synapse = par.w_min * np.ones((par.n, par.m)) + (par.w_max - coeff * par.w_min) * np.random.rand(par.n, par.m) # 200행 784열 synapse matrix 생성
Pth = np.ones(par.n)
z = np.arange(train_data_num)

for k in range(17):
    permutation = np.random.permutation(z.shape[0]) #Random number generation
    total_mem_sum = 0
    train_images_shuffle = train_images[permutation] #Random 한 순서로 set 제시
    train_labels_shuffle = train_labels[permutation]
    labeling = np.zeros((par.n, 10))

    for i in range(60000):
        if (i + 1) % 10000 == 0:
            print("Training Date Num :", i + 1, "epoch :", k + 1)
            fire = 0
            reconst_weights(synapse, 400)

        #Generate Spike Train
        pot = train_images_shuffle[i]
        train = np.zeros((par.pixel_x * par.pixel_x, par.T))
        for l in range(par.pixel_x * par.pixel_x):
            train[l, math.floor(((par.T) - 1) * (1 - pot[l]))] = 1

        #Matrix Initialization
        active_pot = np.zeros(par.n)
        P = par.Prest * np.ones(par.n)
        t_rest = -1 * np.ones(par.n)
        P_rest = par.Prest * np.ones(par.n)
        input_sum = np.zeros(par.m)
        mem_sum = 0

        #Weight Sum (휴지기에 해당하지 않는 것만)
        for t in range(par.T):
            X = amplitude * np.dot(synapse, train[:, t])/(cap*cap_coeff)
            #mem_sum += sum(amplitude * np.dot(synapse, train[:, t])/(cap * cap_coeff))
            a = np.where(t_rest < t)
            P[a] += X[a]
            active_pot = P - Pth
            input_sum += train[:, t]

            #Check for spikes & Weight Update
            high_pot = max(active_pot)
            if high_pot >= 0:
                winner = np.argmax(active_pot) # maximum index 찾기
                if ((i + 1) > 50000 & (i + 1) < 60000):
                    labeling[winner] += train_labels_shuffle[i]
                fire += 1 # fire 수 check
                fire_time = (fire_time * i + t) / (i+1)
                P = par.Pmin * np.ones(par.n) # 다른 neuron 들 membrane 초기화
                P[winner] = par.Prest # fire neuron membrane 휴지상태
                Pth -= homeostasis_term * (1/par.n) * np.ones(par.n) #Homeostasis
                Pth[winner] += homeostasis_term * ((par.n+1)/par.n)
                t_rest[winner] += par.Trest #휴지기
                c = np.where(input_sum == 1)
                d = np.where(input_sum == 0)
                synapse[winner][c] += par.alpha_p * np.exp(-par.beta_p * (synapse[winner][c] - par.w_min) / (par.w_max - par.w_min))
                synapse[winner][d] -= par.alpha_d * np.exp(-par.beta_d * (par.w_max - synapse[winner][d]) / (par.w_max - par.w_min))
                synapse = np.where(synapse > par.w_max, par.w_max, synapse)
                synapse = np.where(synapse < par.w_min, par.w_min, synapse)
        #total_mem_sum += mem_sum

        #Inference
        if (i+1) % classify_period == 0:
            print("    [Classification]", )
            result = np.zeros((par.n, 10))
            fire2 = 0
            t_fire_avg = 0
            t_fire = np.zeros(par.T)
            #t_fire_neuron = np.zeros(par.n)
            #total_mem_sum_infer = 0

            for q in range(test_data_num):
                #Generate Spike Train
                pot2 = test_images[q]
                #mem_sum_infer = 0
                train2 = np.zeros((par.pixel_x * par.pixel_x, par.T))
                for l in range(par.pixel_x * par.pixel_x):
                    train2[l, math.floor(((par.T) - 1) * (1 - pot2[l]))] = 1

                #Matrix Initialization
                active_pot_infer = np.zeros(par.n)
                P_infer = par.Prest * np.ones(par.n)

                # Weight Sum
                for tt in range(par.T):
                    P_infer += amplitude * np.dot(synapse, train2[:, tt]) / (cap*cap_coeff)
                    active_pot_infer = P_infer - Pth
                    #mem_sum_infer += sum(amplitude * np.dot(synapse, train2[:, tt]) / (cap*cap_coeff))

                    # Check for spikes
                    high_pot = max(active_pot_infer)
                    if high_pot >= 0:
                        winner_infer = np.argmax(active_pot_infer)  # maximum index 찾기
                        result[winner_infer] += test_labels[q]
                        confusion[winner_infer] += test_labels[q]
                        t_fire[tt] += 1
                        #t_fire_neuron[winner_infer] += 1
                        fire2 += 1  # fire 수 check
                        #total_mem_sum_infer += mem_sum_infer
                        break
                    elif tt == par.T - 1:
                        winner_infer = np.argmax(active_pot_infer)
                        result[winner_infer] += test_labels[q]
                        t_fire[tt] += 1
                        fire2 += 0.0001
                        #total_mem_sum_infer += mem_sum_infer
                        break

            #Fire time Check
            correct_answer = 0
            for m in range(par.T):
                t_fire_avg += m * np.sum(t_fire[m])
            t_fire_avg = t_fire_avg / 10000

            #Accuracy Check
            for m in range(par.n):
                g = np.argmax(labeling[m])
                correct_answer += result[m][g]

            #print Accuracy
            print(correct_answer * 100 / test_data_num, "%")

            #Check inadequate spike
            if fire2 != 10000:
                print("  warning ")

            #print(total_mem_sum/100)


