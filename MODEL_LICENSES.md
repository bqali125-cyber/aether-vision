# Aether Vision — Model Licenses and Legal Audit

This document provides a rigorous legal, provenance, and licensing audit for all image restoration and super-resolution models integrated or interfaced in Aether Vision.

---

## 1. Legal Principle & Compliance Architecture

Aether Vision adheres to strict intellectual property and licensing standards:
1. **Separation of Code vs. Weights**: Code licenses (e.g. Apache-2.0, MIT, BSD) do not automatically grant commercial rights to neural network checkpoints trained on third-party, non-commercial, or copyrighted datasets.
2. **Explicit Research Gating**: Models whose foundation architectures or pre-trained checkpoints are restricted to academic or non-commercial research (such as **HYPIR** and **GFPGAN**) are strictly gated. They cannot be executed in commercial production routes without explicit user consent.
3. **No Unproven Claims**: No claims of superiority over proprietary software (such as Topaz Photo AI) are made without verified, reproducible empirical benchmarks conducted on identical test sets.

---

## 2. Comprehensive Model Audit Matrix

| Model ID | Architecture | Code License | Checkpoint / Weights License | Commercial Allowed? | Research Only Gating? | Repository / Source |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **`classical_faithful`** | Mathematical Signal Processing (Bilateral, CLAHE, Lanczos-4, Unsharp Mask) | Apache-2.0 / BSD-3-Clause | Pure algorithm (No weights required) | **YES** | None | Built-in / OpenCV / SciPy |
| **`real_esrgan_x4`** / **`real_esrgan_x2`** | RRDBNet (Wang et al.) | BSD-3-Clause | BSD-3-Clause (Synthetic degradation data) | **YES** | No | [xinntao/Real-ESRGAN](https://github.com/xinntao/Real-ESRGAN) |
| **`nafnet_deblur`** / **`nafnet_denoise`** | NAFNet (Megvii Research) | MIT | MIT (Trained on GoPro / SIDD) | **YES** | No | [megvii-research/NAFNet](https://github.com/megvii-research/NAFNet) |
| **`restormer_deblur`** / **`restormer_denoise`** | Restormer (Zamir et al.) | Apache-2.0 | Apache-2.0 | **YES** | No | [swz30/Restormer](https://github.com/swz30/Restormer) |
| **`gfpgan`** | GFPGAN v1.4 (Tencent ARC) | Apache-2.0 | Non-Commercial / Academic Research Terms | **NO** (Without specific vendor agreement) | **YES** (Flagged in UI & CLI) | [TencentARC/GFPGAN](https://github.com/TencentARC/GFPGAN) |
| **`hypir`** | Generative Blind Restoration (XPixelGroup) | CC-BY-NC-SA 4.0 / Research Only | CC-BY-NC-SA 4.0 (Diffusion Prior) | **NO** (Strictly Non-Commercial) | **YES** (Raises `PermissionError` without consent) | [XPixelGroup/HYPIR](https://github.com/XPixelGroup/HYPIR) |

---

## 3. Specific Model Notes & Legal Boundaries

### A. HYPIR (Hyper-Parameter-Free Image Restoration)
- **Source**: [https://github.com/XPixelGroup/HYPIR](https://github.com/XPixelGroup/HYPIR)
- **Status**: Research-only generative blind restoration model.
- **Legal Warning**: HYPIR builds upon diffusion-based foundation models. In Aether Vision, `HYPIRAdapter` requires explicit user confirmation (`confirm_non_commercial_research=True`). It is completely excluded from default automated commercial restoration paths.

### B. Real-ESRGAN
- **Source**: [https://github.com/xinntao/Real-ESRGAN](https://github.com/xinntao/Real-ESRGAN)
- **Status**: Permissive BSD-3-Clause code and weights trained with pure synthetic degradation models.

### C. NAFNet
- **Source**: [https://github.com/megvii-research/NAFNet](https://github.com/megvii-research/NAFNet)
- **Status**: Permissive MIT license from Megvii Research. Suitable for commercial denoising and deblurring.

### D. GFPGAN
- **Source**: [https://github.com/TencentARC/GFPGAN](https://github.com/TencentARC/GFPGAN)
- **Status**: Facial priors are subject to non-commercial academic restrictions from Tencent ARC Lab.
