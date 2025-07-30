# Communications Systems Lab

## Overview
This repository contains MATLAB scripts for experiments conducted as part of a **Communications Systems Laboratory** course. The experiments cover fundamental and advanced concepts in digital and analog communication systems, including signal processing, modulation techniques, channel modeling, and error correction. The scripts are designed for educational purposes, providing hands-on experience with communication system simulations.

## Repository Contents
The repository includes a series of MATLAB scripts (`*.m` files) organized by experiment number. Each script corresponds to a specific lab exercise, with some experiments split into multiple parts (e.g., `exp5_1.m`, `exp5_2.m`). Key experiments include:

- **exp1.m to exp9.m**: Cover foundational topics such as signal generation, modulation (e.g., AM, FM, BPSK, QPSK), and channel effects (e.g., noise, fading).
- **exp10.m**: Implements a convolutional encoder and Viterbi decoder to simulate error correction in digital communications, including performance metrics like Bit Error Rate (BER) vs. Signal-to-Noise Ratio (SNR).
- Additional sub-experiments (e.g., `exp1_1.m`, `exp5_2.m`) provide variations or extensions of main experiments.

## Prerequisites
To run the scripts, you need:
- **MATLAB**: Version R2016a or later (ensure compatibility with your version).
- **Toolboxes**:
  - Signal Processing Toolbox
  - Communications Toolbox
- Basic understanding of communication systems concepts (e.g., modulation, encoding, noise).

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/siddharth-sekhar/Communications_Systems_Lab.git
   ```
2. Open MATLAB and navigate to the cloned repository folder:
   ```matlab
   cd path/to/Communications_Systems_Lab
   ```
3. Ensure the required MATLAB toolboxes are installed. Check by running:
   ```matlab
   ver
   ```

## Usage
1. Open the desired experiment script (e.g., `exp10.m`) in MATLAB.
2. Run the script:
   ```matlab
   run('exp10.m')
   ```
3. Each script typically:
   - Generates or processes signals.
   - Simulates communication system components (e.g., encoder, decoder, channel).
   - Visualizes results using plots (e.g., waveforms, BER curves).
4. Review comments within each script for specific instructions or parameters to modify (e.g., SNR values, modulation order).

### Example: Running `exp10.m`
- **Purpose**: Simulates a convolutional encoder and Viterbi decoder.
- **Steps**:
  1. Open `exp10.m` in MATLAB.
  2. Run the script to encode a bit stream, simulate a noisy channel (e.g., AWGN), and decode using the Viterbi algorithm.
  3. Observe outputs, such as BER vs. SNR plots.
- **Expected Output**: Plots showing error performance and decoded signal accuracy.

## Experiment List
Below is a likely overview of the experiments (based on file naming and context):
1. **Experiment 1**: Signal generation and analysis (e.g., sinusoidal signals, Fourier transforms).
2. **Experiment 2-4**: Analog modulation (AM, FM) and demodulation.
3. **Experiment 5-7**: Digital modulation (BPSK, QPSK, etc.) and channel effects.
4. **Experiment 8-9**: Advanced topics like equalization or multi-carrier systems.
5. **Experiment 10**: Convolutional encoding and Viterbi decoding for error correction.

For detailed objectives, refer to comments within each `.m` file.

## Contributing
This repository is primarily for educational purposes. Contributions (e.g., bug fixes, additional experiments) are welcome:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit changes (`git commit -m "Add feature"`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details. (Note: If no LICENSE file exists, you may add one or contact the repository owner for clarification.)

## Contact
For questions or issues, please open an issue on GitHub or contact the repository owner, [siddharth-sekhar](https://github.com/siddharth-sekhar).