# 8-Point FFT using Verilog

## Overview
This project implements an 8-point Fast Fourier Transform (FFT) using Verilog HDL. The design follows the Radix-2 Decimation-In-Time (DIT) algorithm.

FFT is widely used in Digital Signal Processing (DSP) applications such as communication systems, audio processing, and image analysis.

---

## Key Concepts
- FFT (Fast Fourier Transform)
- Radix-2 DIT Algorithm
- Butterfly Operations
- Bit Reversal
- 3 Stages (log2(8) = 3)

---

## Project Structure
```
├── Verilog_code/
├── Datapath.png
├── State Machine.png
├── Implementing an 8-point FFT using Verilog.pdf
└── README.md
```

---

## Features
- 8-point FFT implementation
- Modular design
- FSM and Datapath architecture
- Simulation ready

---

## Algorithm Flow
1. Input 8 samples
2. Bit reversal
3. 3-stage butterfly computation
4. Twiddle factor multiplication
5. Frequency-domain output

---

## How to Run
```bash
vlog *.v
vsim work.testbench
```

---

## Output
- Frequency-domain output
- Complex values (Real and Imaginary)

---

## Applications
- Communication systems
- Audio processing
- Image processing
- Spectrum analysis

---

## Tools Used
- Verilog HDL
- ModelSim / EDA Playground

---

## Author
Karthikeya Nayak G

---

## License
MIT License
