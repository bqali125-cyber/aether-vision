# 🌌 Aether Vision
## Adaptive AI Image Restoration & Super-Resolution Platform

[![Python Version](https://img.shields.io/badge/python-3.11%20%7C%203.12-blue.svg)](https://www.python.org/)
[![License](https://img.shields.io/badge/license-Apache--2.0-green.svg)](LICENSE)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.0%2B-orange.svg)](https://pytorch.org/)
![Tests Passing](https://img.shields.io/badge/tests-24%20passed-brightgreen.svg)

> **Engineering Mission:** Design and implement a practical, modular, and extensible platform for intelligent image analysis, restoration, and super-resolution, guided by empirical evidence and precise hardware resource management.

---

## 📋 Table of Contents

1. [Project Architecture](#-project-architecture)
2. [Implemented Features](#-implemented-features)
3. [Two Main Restoration Modes: Faithful vs. Creative](#-two-main-restoration-modes)
4. [Hardware Requirements and Accelerators](#-hardware-requirements)
5. [Installation and Setup](#-installation-and-setup)
6. [Usage: Web UI, CLI, Batch, and Benchmarking](#-usage)
7. [Model Management and Licensing](#-model-management-and-licensing)
8. [Troubleshooting and Memory Issues](#-troubleshooting-and-memory-issues)

---

## 🏛️ Project Architecture

The project is organized into independent layers with stable software contracts based on **Abstract Base Classes (ABCs)**.

```text
aether-vision/
├── app/                      # Application and user interface layer
│   ├── main.py               # Main web application entry point
│   ├── config.py             # Centralized configuration management
│   └── ui/                   # Gradio 6 user interface
├── aether/                   # Processing core and algorithms
│   ├── io/                   # ImageIO, security validation, EXIF, and alpha-channel handling
│   ├── analysis/             # Non-destructive image quality analysis and degradation estimation
│   ├── routing/              # Intelligent router for model selection
│   ├── engine/               # Orchestration engine and seam-free tiled processing
│   ├── models/               # Model adapter contracts and central registry
│   │   └── adapters/         # Real-ESRGAN, NAFNet, Restormer, GFPGAN, and classical adapters
│   ├── quality/              # Empirical quality evaluation: PSNR, SSIM, MAE, color drift, and halo checks
│   ├── performance/          # PerformanceManager for CUDA/MPS/CPU and memory detection
│   ├── benchmarks/           # Standardized benchmark suite with Markdown and JSON reports
│   ├── training/             # Controlled degradation pipeline and training/fine-tuning framework
│   └── utilities/            # Structured logging
├── configs/                  # System configuration files
├── scripts/                  # CLI utilities, secure weight downloads, and benchmarking
├── tests/                    # 24 unit and integration tests
├── MODEL_LICENSES.md         # Model licensing audit and usage restrictions
└── SECURITY.md               # Local security and privacy policy
```

---

## ⚡ Implemented Features

### 1. Intelligent Image Analysis (`ImageQualityAnalyzer`)

- Quantitative blur estimation using Laplacian variance and Tenengrad gradient energy.
- Sensor noise estimation using Median Absolute Deviation (MAD) in smooth image regions.
- JPEG block artifact estimation using the Wang–Bovik Blockiness Index.
- Brightness evaluation in the Lab color space and detection of underexposed images.
- Face presence detection using OpenCV Haar cascades to help select face-restoration tools.

### 2. Intelligent Restoration Router (`RestorationRouter`)

- Avoids blindly passing images through every available model.
- Prioritizes processing operations: removes noise and compression artifacts first, followed by detail restoration and super-resolution, helping prevent noise amplification.
- Provides transparent explanations for route selection, with support for manual user overrides.

### 3. Seam-Free Tiled Processing (`TileProcessor`)

- Divides very large images into overlapping tiles.
- Blends tiles using a smooth 2D cosine/Hann window to minimize visible seams.
- **Automatic recovery from out-of-memory (OOM) errors:** Reduces tile size and retries processing when GPU memory is insufficient.

### 4. Advanced Image Formats and Preprocessing (`ImageIO`)

- Automatically handles EXIF orientation using `exif_transpose`.
- Preserves RGBA alpha channels by separating, processing, and recombining them.
- Supports grayscale images and different color spaces.
- Helps prevent unintended cropping, color changes, and aspect-ratio distortion.

### 5. Empirical Quality Evaluation and Benchmarking (`QualityEvaluator` & `BenchmarkSuite`)

- Computes reference-based quality metrics: PSNR (dB), SSIM, MAE, and color difference (ΔE).
- Tracks perceptual artifacts without a reference image, including halos, ringing, and edge oversharpening.
- Measures latency percentiles (mean, median, and P95) and frame rate (FPS).

---

## 🎨 Two Main Restoration Modes

### Mode A — Faithful Restoration

- **Goal:** Preserve image geometry, natural textures, and facial identity as faithfully as possible.
- **Behavior:** Avoids aggressive oversharpening, controls edge halos, and avoids deliberately introducing artificial or fabricated textures.
- **Use cases:** Historical documents, personal photographs, identification documents, nature photography, and architectural imagery where geometric accuracy matters.

### Mode B — Creative Enhancement

- **Goal:** Improve perceived image quality, increase contrast, and recover or synthesize fine-looking details using generative models.
- **Transparency commitment:** Creative outputs are never presented as absolute truth. Users are informed that some details may be simulated or generated rather than faithfully recovered from the original image.

---

## 🖥️ Hardware Requirements

- **Minimum CPU configuration:** A multi-core Intel or AMD processor with at least 8 GB of RAM for FP32 inference.
- **Recommended NVIDIA CUDA GPU:**
  - GPUs with at least 4 GB of VRAM, such as the GeForce RTX 3050 Laptop GPU.
  - The system automatically adjusts tile size according to available VRAM, typically using tiles between 384 and 512 pixels to help prevent out-of-memory errors.
- **Apple Silicon (MPS):** Automatic hardware acceleration support for M1, M2, and M3 devices through Apple's Metal backend.

Actual hardware requirements depend on the selected model, input image dimensions, upscaling factor, precision, and tile settings.

---

## 🚀 Installation and Setup

### Prerequisites

The project uses `uv` for fast Python package management and isolated environments.

The following PowerShell commands configure Python's encoding and activate an existing project virtual environment:

```powershell
# On Windows (PowerShell)
$env:PYTHONUTF8="1"
$env:PYTHONIOENCODING="utf-8"

# Activate the project's virtual environment
.\.venv\Scripts\Activate.ps1
```

If you need to reinstall the core packages in an environment where `uv` is already installed:

```bash
uv pip install numpy pillow opencv-python-headless scipy gradio pydantic pyyaml tqdm rich pytest torch torchvision
```

Make sure the installed package versions are compatible with your Python version, operating system, and selected hardware accelerator.

---

## 💻 Usage

### 1. Launch the Web Interface (Gradio UI)

```powershell
python app/main.py
```

Then open the following address in your browser:

`http://127.0.0.1:7860`

### 2. Restore a Single Image Using the CLI

Faithful restoration with 2× upscaling:

```powershell
python scripts/run_cli.py examples/sample_photo.png --mode faithful --scale 2 --output outputs/
```

Creative enhancement with 4× upscaling:

```powershell
python scripts/run_cli.py examples/sample_photo.png --mode creative --scale 4 --output outputs/
```

### 3. Batch Processing

Process a directory of images:

```powershell
python scripts/run_cli.py D:\photos_folder --mode auto --scale 2 --output outputs/batch/
```

### 4. Run a Performance Benchmark

```powershell
python scripts/run_benchmark.py --models classical_faithful --iterations 3 --output-dir outputs/benchmarks/
```

### 5. Run Automated Tests

Run the unit and integration test suite:

```powershell
pytest -v
```

---

## ⚖️ Model Management and Licensing

Detailed licensing information is available in [`MODEL_LICENSES.md`](MODEL_LICENSES.md).

- **Classical Engine (`classical_faithful`):** Uses classical image-processing methods and does not require downloaded model weights. The applicable code and dependency licenses are documented as Apache-2.0 and/or BSD.
- **Real-ESRGAN (`real_esrgan_x4`, `real_esrgan_x2`):** The project identifies BSD-3-Clause licensing for the upstream code. Review the terms applicable to each specific checkpoint and dependency before commercial use or redistribution.
- **NAFNet (`nafnet_deblur`, `nafnet_denoise`):** The upstream code is identified as MIT-licensed. Check the specific pretrained weights and dependencies separately.
- **GFPGAN (`gfpgan`):** Used for specialized face restoration. Review the upstream license and the separate terms applicable to third-party components and artifacts.
- **HYPIR (`hypir`):** **Important licensing restriction:** The project has non-commercial-use restrictions. It is excluded from commercial workflows by default, and its use requires explicit user confirmation for research purposes. Review the upstream licensing terms before use or redistribution.

### Secure Weight Downloads

Download supported model weights with integrity checks:

```powershell
python scripts/download_weights.py --model real_esrgan_x4
python scripts/download_weights.py --model nafnet_deblur
```

Model availability depends on the project's supported model registry and the weight-download configuration.

---

## 🛠️ Troubleshooting and Memory Issues

### 1. CUDA Out-of-Memory Errors

- Reduce the tile size in the user interface or CLI, for example by using `--tile-size 256`.
- The system is designed to retry processing with a smaller tile size when GPU memory pressure causes an out-of-memory error.

### 2. PyTorch Does Not Detect the GPU

To install a CUDA-enabled PyTorch build for a compatible NVIDIA GPU, use the appropriate PyTorch installation command for your system. For example, the following command installs a CUDA 12.4 build where supported:

```powershell
uv pip install torch torchvision --index-url https://download.pytorch.org/whl/cu124
```

- If CUDA is unavailable, the system can fall back to CPU execution where supported by the implementation.

### 3. Deblurring Limitations

When high-frequency information has been completely lost, faithful restoration cannot guarantee recovery of the original details. The Faithful mode prioritizes preserving the image's underlying geometry and avoiding fabricated detail. For a more perceptually enhanced result, use Creative mode while keeping in mind that some details may be generated or simulated rather than recovered from the original image.
