###################################################### README #####################################################

# This file is used to leverage the generative property of a Spiking Neural Network. reconst_weights function is used
# for that purpose. Looking at the reconstructed images helps to analyse training process.

####################################################################################################################


import numpy as np
from numpy import interp
import cv2
from recep_field import rf
from Temporal_coding_parameters import param as par


def reconst_weights(synapse, nn):
    img = np.zeros(((par.pixel_x * 20), (par.pixel_x * 10)))
    for k in range(20):
        for l in range(10):
            m = k * 10 + l
            weights = np.array(synapse[m])
            weights = np.reshape(weights, (par.pixel_x, par.pixel_x))

            for i in range(par.pixel_x):
                for j in range(par.pixel_x):
                    p = k * par.pixel_x + i
                    q = l * par.pixel_x + j
                    img[p][q] = int(interp(weights[i][j], [par.w_min, par.w_max], [0, 255]))

    cv2.imwrite('neuron' + str(nn) + '.png', img)
    return img

def reconst_weights_airplane(synapse, nn):
    img = np.zeros(((63*10), (32*10)))
    for k in range(10):
        for l in range(10):
            m = k * 10 + l
            weights = np.array(synapse[m])
            weights = np.reshape(weights, (63, 32))

            for i in range(63):
                for j in range(32):
                    p = k * 63 + i
                    q = l * 32 + j
                    img[p][q] = int(interp(weights[i][j], [par.w_min, par.w_max], [0, 255]))

    cv2.imwrite('neuron' + str(nn) + '.png', img)
    return img

#def reconst_confusion(confusion, nn):
#    img = np.zeros(((par.n*30, 10*30))
#    img = confusion
#    for i in range((par.n)*30):
#        for j in range(10*30):
#            img[(i//30)][(j//30)] = int(interp(confusion[(i//30)][(j//30)], [0, 100], [0, 255]))
#
#    img = np.reshape(confusion, (par.n*30, 10*30))
#    cv2.imwrite('confusion' + str(nn) + '.png', img)
#    return img


def reconst_rf(weights, num):
    weights = np.array(weights)
    weights = np.reshape(weights, (par.pixel_x, par.pixel_x))
    img = np.zeros((par.pixel_x, par.pixel_x))
    for i in range(par.pixel_x):
        for j in range(par.pixel_x):
            img[i][j] = int(interp(weights[i][j], [-2, 3.625], [0, 255]))

    cv2.imwrite('neuron' + str(num) + '.png', img)
    return img


if __name__ == '__main__':
    img = cv2.imread("images2/" + "69" + ".png", 0)
    pot = rf(img)
    reconst_rf(pot, 12)
