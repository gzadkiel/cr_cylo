# cr_cylo — Cyclostationary Spectrum Detector for Cognitive Radio (FPGA/FAM)

This repository contains the implementation of an FPGA-based **cyclostationary feature detector** for **Cognitive Radio (CR)** spectrum sensing, built around the **FFT Accumulation Method (FAM)** for estimating the **Spectral Correlation Density (SCD)** of a received signal. The project is developed as part of an undergraduate/graduate thesis and combines custom RTL (SystemVerilog/Verilog), Python-based golden modeling and verification, and hardware deployment on a Xilinx Zynq platform (ZedBoard, XC7Z020).

> **Status:** Work in progress. This README summarizes the project as currently understood and will be expanded as more source material, results, and documentation are uploaded.

---

## 1. Motivation

Cognitive Radio systems need to reliably detect whether a licensed (primary) user occupies a given spectrum band before a secondary user transmits. Simple energy detection is fast but performs poorly at low SNR and cannot distinguish signal types. **Cyclostationary detection** exploits the periodic statistical structure (hidden periodicities from symbol rates, carrier frequencies, chip rates, etc.) present in most modulated communication signals — structure that is generally absent in stationary noise. This makes cyclostationary detectors far more robust at low SNR and capable of signal classification, at the cost of significantly higher computational complexity.

The **FFT Accumulation Method (FAM)** is one of the most widely used efficient algorithms for estimating the Spectral Correlation Density (SCD), the two-dimensional function (over spectral frequency *f* and cyclic frequency *α*) that reveals this cyclostationary structure. Because FAM is computationally intensive (multiple FFT stages, windowing, phase correction, and correlation across many frequency/cyclic-frequency bins), a hardware implementation is attractive for real-time or low-power CR spectrum sensing — motivating an FPGA realization rather than a pure software one.

---

## 2. Project Goals

- Implement the FAM/SCD estimation pipeline as synthesizable RTL targeting a Xilinx Zynq-7000 SoC (ZedBoard, XC7Z020).
- Build a bit-accurate Python **golden model** of the same pipeline for verification and algorithm development.
- Validate the RTL against the golden model at each pipeline stage (vector-level matching) and at the system level (end-to-end SCD comparison).
- Characterize detector performance empirically via **Monte Carlo simulation**, including detection threshold estimation under the noise-only hypothesis (H₀) and probability-of-detection (Pd) measurement under signal-present conditions.
- Deploy and exercise the design on real ZedBoard hardware, with a host-side (PS/Python) control and data-acquisition path for automated trial orchestration.

---

## 3. Repository Structure

```
cr_cylo/
├── complete_det_final/   # Final/consolidated detector implementation (RTL + supporting files)
├── files/                 # Supporting files (data, scripts, reference material)
├── workspace/              # Working / development area (Vivado project, in-progress modules, etc.)
└── README.md
```

*(Folder contents will be documented in more detail as material is uploaded and organized. If you'd like, I can expand this section with a full file-by-file breakdown once I can see what's inside each directory.)*

---

## 4. System Architecture

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
SCD output (full-resolution and reduced-depth variants)
```

Key implementation details:
- **AXI-Stream convention:** for 32-bit FFT1 `tdata`, the low half-word carries the imaginary part and the high half-word carries the real part; FFT2 `tdata` is 64-bit under the same convention.
- **BRAM transpose:** a dedicated finite-state machine handles the column-write/row-read transpose between FFT stages, with carefully aligned write/read timing to absorb synchronous BRAM read latency.
- **Fixed-point arithmetic:** the design uses fixed-point (Q-format) representations throughout (e.g., Q(12,11) for test vectors), with a parameterized rounding/truncation block supporting multiple rounding modes and saturation logic.

---

## 5. Verification Methodology

Verification follows a layered strategy combining Python-based modeling with SystemVerilog testbenches:

### 5.1 Golden Model (Python)
A cycle-accurate/bit-accurate Python golden model reproduces the RTL pipeline stage by stage, dumping intermediate results (input frames, FFT1 output, phase-corrected data, conjugate products, full-resolution SCD, and reduced-depth SCD) for direct comparison against RTL simulation output.

### 5.2 Module-Level Behavioral Emulation
Individual SystemVerilog modules (e.g., the input windowing block) have matching Python behavioral models that replicate exact hardware semantics — including non-blocking assignment (NBA) timing, saturating truncation, and symmetric window-coefficient lookup — connected via a `tick(enable, data, ...) → (valid, data)` interface convention, allowing module-by-module chaining and validation in software before/alongside RTL simulation.

### 5.3 Vector-Level Matching
A SystemVerilog testbench monitor captures internal signals during Vivado simulation and compares them against the golden model's dumped vectors to catch discrepancies at each pipeline stage rather than only at the final output.

### 5.4 Signal Validation
Sine-wave and modulated (BPSK, rectangular and root-raised-cosine pulse shaping) test signals are used to validate correct SCD behavior, visualized via 2D SCD heatmaps, PSD slices, cyclic-power-vs-α plots, and per-pair FFT2 slices.

### 5.5 Monte Carlo Threshold Estimation
A dedicated Monte Carlo testbench environment drives the design with AWGN (Box-Muller-generated) under many independent trials to empirically characterize detector statistics:
- Per-trial maximum-statistic export from RTL simulation.
- Empirical CCDF construction, Gumbel tail fitting, and Kolmogorov–Smirnov goodness-of-fit testing.
- Threshold tables (per target false-alarm probability) with reliability warnings where the empirical sample size limits confidence.

---

## 6. Hardware Deployment

The design targets a **Xilinx ZedBoard (XC7Z020)**, using the Zynq **Processing System (PS)** as a bridge between a host PC and the **Programmable Logic (PL)** detector core:

- A UART-based relay firmware running on the PS implements a framed binary protocol (`[CMD][LEN_LO][LEN_HI][PAYLOAD]`) supporting register and FIFO read/write, FIFO status queries, and FIFO clearing.
- A Python host-side client drives this protocol to orchestrate Monte Carlo trials directly against the physical hardware (as opposed to simulation-only characterization), including both "repeat noise" and "fresh noise" trial modes.
- A Tkinter-based GUI supports configurable signal sources (BPSK, sine, AWGN, or file-based), automated trial execution, probability-of-detection (Pd) computation, and results export (`.npz`).
- Earlier infrastructure integrated an ICTP Core-ComBlock IP for PC↔FPGA communication over USB/UART, with a custom adapter bridging ComBlock signals to the detector's RTL ports.

---

## 7. Tools & Technologies

| Category | Tools / Languages |
|---|---|
| RTL | SystemVerilog, Verilog |
| Synthesis / Implementation | Xilinx Vivado |
| Target hardware | Xilinx Zynq-7000 (ZedBoard, XC7Z020) |
| Golden modeling & verification | Python (NumPy, `fxpmath` for fixed-point analysis) |
| Host↔FPGA communication | UART, custom framed binary protocol, PS-side C firmware |
| Host tooling / GUI | Python, Tkinter |
| Statistical analysis | Empirical CCDF, Gumbel tail fitting, Kolmogorov–Smirnov testing |

---

## 8. Current Status / Known Issues

- Core FAM/SCD pipeline (windowing → FFT1 → transpose → phase correction → conjugate product → FFT2) is implemented and verified against the Python golden model at the vector level.
- Monte Carlo simulation framework for empirical detection threshold estimation under H₀ is in active development.
- Standalone hardware deployment is being debugged: intermittent/anomalous results have been observed across consecutive Monte Carlo runs on hardware, suspected to be related to incomplete board reset between runs. A manual reset control is planned for the GUI.
- Packaging the GUI application as a standalone Windows executable (no separate Python install required) is planned.

---

## 9. Roadmap

- [ ] Resolve inter-run reset inconsistency on ZedBoard hardware.
- [ ] Add manual board-reset control to the host GUI, decoupled from full test-run initiation.
- [ ] Package the GUI as a standalone Windows `.exe`.
- [ ] Complete and validate the empirical detection threshold / ROC (Pd vs. Pfa) characterization.
- [ ] Expand documentation with detailed module-level descriptions, block diagrams, and resource utilization reports.

---

## 10. Author / Thesis Context

This project is developed as an undergraduate/graduate thesis on FPGA-based cyclostationary spectrum sensing for Cognitive Radio applications. Additional thesis documentation (background theory, full results, and formal write-up) will be added as it becomes available.

---

## 11. License

*No license specified yet.*

---

**Note:** This README was generated from project context and will be revised as more source files, documentation, and results are uploaded to the repository.
