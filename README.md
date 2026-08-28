# cr_cylo — Cyclostationary Spectrum Detector for Cognitive Radio (FPGA/FAM)

This repository contains the implementation of an FPGA-based **cyclostationary feature detector** for **Cognitive Radio (CR)** spectrum sensing, built around the **FFT Accumulation Method (FAM)** for estimating the **Spectral Correlation Density (SCD)** of a received signal. The project is developed as part of an undergraduate/graduate thesis and combines custom RTL (SystemVerilog/Verilog), Python-based golden modeling and verification, and hardware deployment on a Xilinx Zynq platform (ZedBoard, XC7Z020).

> **Status:** Work in progress. This README summarizes the project as currently understood and will be expanded as more source material, results, and documentation are uploaded.

---

## 1. Motivation

Cognitive Radio systems need to reliably detect whether a licensed (primary) user occupies a given spectrum band before a secondary user transmits. Simple energy detection is fast but performs poorly at low SNR and cannot distinguish signal types. **Cyclostationary detection** exploits the periodic statistical structure (hidden periodicities from symbol rates, carrier frequencies, chip rates, etc.) present in most modulated communication signals — structure that is generally absent in stationary noise. This makes cyclostationary detectors far more robust at low SNR and capable of signal classification, at the cost of significantly higher computational complexity.

The **FFT Accumulation Method (FAM)** is one of the most widely used efficient algorithms for estimating the Spectral Correlation Density (SCD), the two-dimensional function (over spectral frequency *f* and cyclic frequency *α*) that reveals this cyclostationary structure. Because FAM is computationally intensive (multiple FFT stages, windowing, phase correction, and correlation across many frequency/cyclic-frequency bins), a hardware implementation is attractive for real-time or low-power CR spectrum sensing — motivating an FPGA realization rather than a pure software one.

---

## 2. Repository Structure

```
cr_cylo/
├── complete_det_final/   # Final/consolidated detector implementation (Vivado project, RTL, supporting files, etc.)
├── files/                # Supporting files (data, scripts, reference material)
├── workspace/            # Working / development area (Vitis project)
└── README.md
```

*(Folder contents will be documented in more detail as material is uploaded and organized.)*

---

## 3. System Architecture

The detector pipeline follows the classical FAM structure, implemented as an FSM-controlled, multi-stage custom datapath (rather than a fully AXI-Stream-pipelined design — only the FFT cores and the complex multiplier use AXI-Stream interfaces; the rest of the pipeline is sequenced by dedicated control logic):

```
Input samples
   │
   ▼
Windowing (input framing + window function, e.g. Hamming/Blackman)
   │
   ▼
BRAM buffer
   │
   ▼
FFT #1 (per-block spectral estimate)
   │
   ▼
BRAM transpose (column-write / row-read pattern)
   │
   ▼
Phase correction
   │
   ▼
Conjugate product (cross-multiplication of frequency-shifted pairs)
   │
   ▼
FFT #2 (cyclic-frequency spectrum)
   │
   ▼
SCD output
```
---

## 4. Hardware Deployment

The design targets a **Xilinx ZedBoard (XC7Z020)**, using the Zynq **Processing System (PS)** as a bridge between a host PC and the **Programmable Logic (PL)** detector core:

- A UART-based relay firmware running on the PS implements a framed binary protocol (`[CMD][LEN_LO][LEN_HI][PAYLOAD]`) supporting register and FIFO read/write, FIFO status queries, and FIFO clearing.
- A GUI supports configurable signal sources (BPSK, sine, AWGN, or file-based), automated trial execution, probability-of-detection (Pd) computation, and results export.
- Integrated an ICTP Core-ComBlock IP for PC↔FPGA communication over USB/UART, with a custom adapter bridging ComBlock signals to the detector's RTL ports.

---

## 5. Author / Thesis Context

This project is developed as an undergraduate/graduate thesis on FPGA-based cyclostationary spectrum sensing for Cognitive Radio applications. Additional thesis documentation (background theory, full results, and formal write-up) will be added as it becomes available.

---
