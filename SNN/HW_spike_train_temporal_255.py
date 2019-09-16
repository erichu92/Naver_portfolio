######################################################## README #############################################################

# This file generates rate based spike train from the potential map.

############################################################################################################################


import numpy as np
from numpy import interp
#from neuron import neuron
import random
from matplotlib import pyplot as plt
from recep_field import rf
import cv2
#from rl import rl
#from rl import update
import math
from HW_parameters_200N_5t_50step import param as par


def tempo(pot):
    # initializing spike train
    train = np.zeros((par.pixel_x * par.pixel_x, par.T))
    for l in range(par.pixel_x * par.pixel_x):
        train[l, math.floor(((par.T) - 1) * (1 - pot[l]))] = 1



        # calculating firing rate proportional to the membrane potential
        # freq = interp(pot[l], [-1.069, 2.781], [1, 20])

        # print freq
        # if freq <= 0:
        #    print("error")

        # freq1 = math.ceil(600 / freq)  # 올림

        # generating spikes according to the firing rate
        # k = freq1
        # if (pot[l] > 0):
        #    while k < (par.T + 1):
        #         temp[k] = 1
        #         k = k + freq1
        #train.append(temp)  # temp 를 train 맨 뒤에 추가
    # print sum(temp)
    return train


if __name__ == '__main__':
    # m = []
    # n = []
    img = cv2.imread("mnist1/6/" + str(15) + ".png", 0)

    pot = rf(img)

    # for i in pot:
    # 	m.append(max(i))
    # 	n.append(min(i))

    # print max(m), min(n)
    train = encode(pot)
    f = open('look_ups/train6.txt', 'w')
    print(np.shape(train))

    for i in range(201):
        for j in range(784):
            f.write(str(int(train[j][i])))
        f.write('\n')

    f.close()
