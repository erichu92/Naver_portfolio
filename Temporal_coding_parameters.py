################################################ README #########################################################

# This file contains all the parameters of the network.

#################################################################################################################

class param:
    scale = 1
    T = 256
    t_back = -1
    t_fore = 1
    Trest = T

    pixel_x = 28
    Prest = 0
    m = pixel_x * pixel_x  # Number of neurons in first layer
    n = 200  # Number of neurons in second layer
    Pmin = -100             ##########
    Pth = 1  # 원래 주석처리
    # D = 0.7
    alpha_p = 0.721e-9
    beta_p = 1.47
    alpha_d = 2.1e-9
    beta_d = 5.8
    # alpha = 0.10, beta = 1.5
    # alpha = 0.18, beta = 2.5

    w_max = 51e-9 * scale
    w_min = 3.16e-9 * scale
    sigma = 0.1  # 0.02
    A_plus = 0.5  # time difference is positive i.e negative reinforcement
    A_minus = 0.5  # 0.01 # time difference is negative i.e positive reinforcement
    tau_plus = 5
    tau_minus = 5

    epoch = 1

    fr_bits = 12
    int_bits = 12
