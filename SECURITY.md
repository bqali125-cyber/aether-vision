# Security & Privacy Policy — Aether Vision

## 1. Local-First Guarantees
- **Zero Remote Telemetry**: Aether Vision is engineered to execute 100% locally on the host machine.
- **No External Image Transmission**: User images are never uploaded or transmitted to any third-party cloud service or external API.
- **Strict Decoupling**: Weight downloading (`scripts/download_weights.py`) and image restoration (`aether/engine/`) are completely separate operations.

## 2. Input Validation and Defense in Depth
- **Path Sanitization**: Filenames are strictly sanitized to prevent Directory Traversal attacks (e.g. `../` and control characters are stripped).
- **Format Restrictions**: Only validated image formats are decoded (`.jpg`, `.jpeg`, `.png`, `.webp`, `.bmp`, `.tiff`).
- **File & Memory Limits**:
  - Maximum single file byte size: 150 MB.
  - Maximum image dimensions: 16,384 x 16,384 px.
  - Malformed or corrupted image files are intercepted before reaching neural network layers.

## 3. Reporting Vulnerabilities
If you discover a security vulnerability in Aether Vision, please file an issue or contact the development team directly with details and reproduction steps.
