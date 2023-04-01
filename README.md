# Forward Shooting Grid Method and Finite Difference Explicit Scheme for Option Pricing

This repository contains MATLAB code for pricing financial derivatives using finite difference methods. The following files are included:

- `EdsI_Am_Call.m`: Explicit difference scheme for pricing American call options
- `EdsI_Eu_Call.m`: Explicit difference scheme for pricing European call options
- `LinearInterpolate.m`: Function for performing linear interpolation on a given set of data points.
- `fsgm_fixed_AA_call.m`: Pricing method for arithmetic average call options using the forward shooting grid method.
- `fsgm_fixed_LB_put.m`: Pricing method for fixed lookback put options using the forward shooting grid method.

## Usage

To use the code in this repository, simply download the files and run them in MATLAB. Each file contains a function that takes in the necessary inputs for the corresponding pricing method. The inputs and outputs for each function are documented in the code.

## Contributions

Contributions to this repository are welcome. If you find any bugs or have suggestions for improvements, please open an issue or submit a pull request.

## Acknowledgements

The finite difference method is a popular numerical technique for pricing financial derivatives. The code in this repository is based on various finite difference schemes and interpolation methods. The forward shooting grid method is a specific finite difference scheme that is well-suited for pricing American options, as well as certain types of exotic options such as arithmetic average and fixed lookback options.
