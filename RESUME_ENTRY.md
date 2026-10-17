# Aether Vision — Resume Entry & Portfolio Showcase
## رزومه و نمونه‌کار حرفه‌ای برای اضافه کردن به رزومه (CV) و لینکدین (LinkedIn)

---

### 🇮🇷 نگارش فارسی (برای رزومه‌های داخلی و شرکت‌های فناوری)

#### عنوان پروژه:
**Aether Vision — پلتفرم بومی و تطبیقی بازسازی هوشمند تصویر و Super-Resolution (AI Image Restoration Engine)**

#### نقش و تخصص:
**Senior Computer Vision Engineer / ML Systems Architect**

#### دستاوردهای کلیدی و نکات برجسته (Bullet Points):
- **طراحی و پیاده‌سازی پلتفرم ماژولار و محلی (Local-First):** توسعه موتور بازسازی و افزایش وضوح تصاویر با PyTorch، OpenCV و NumPy بر پایه لایه‌بندی نرم‌افزاری پایدار و اصول Clean Architecture.
- **توسعه شبکه عصبی اختصاصی (`AetherExtremeDeblurNet`):** طراحی و آموزش یک معماری عمیق U-Net با کانولوشن‌های اتساعی چندمقیاسی (Multi-Scale Dilated Convolutions) و مکانیزم توجه کانالی ساده‌شده (SCA) جهت حل مسأله معکوس تاری‌های شدید نوری، تاری حرکتی (Motion Blur) و خارج از فوکوس لنز (Defocus Blur).
- **مهندسی پایپ‌لاین آموزش اختصاصی با تابع زیان گرادیان لبه (`CombinedRestorationLoss`):** ترکیب ریاضی هموار Charbonnier Loss با Sobel Edge Gradient Loss جهت تضمین تیزی لبه‌ها و جلوگیری از ایجاد بافت‌های پلاستیکی و مصنوعی در فرآیند بهینه‌سازی.
- **توسعه تحلیلگر هوشمند کیفیت (`ImageQualityAnalyzer`):** پیاده‌سازی الگوریتم‌های بدون مرجع برای تخمین ریاضی شدت تاری (واریانس لاپلاسین و Tenengrad)، نویز سنسور (MAD Wavelet)، خطاهای بلوکی فشرده‌سازی JPEG و تشخیص چهره.
- **طراحی روتر تطبیقی بازسازی (`RestorationRouter`):** مهندسی فرآیند تصمیم‌گیری خودکار برای انتخاب هوشمند مدل‌ها بر اساس عیوب فیزیکی تصویر با هدایت خودکار تصاویر با تاری شدید به شبکه عصبی اختصاصی دی‌بلور.
- **مدیریت پیشرفته حافظه و پردازش بدون درز تایل (`TileProcessor`):** پیاده‌سازی سیستم کاشی‌کاری با هم‌پوشانی و ترکیب ۲ بعدی با پنجره کسینوسی (Hann Window Blending) همراه با مکانیزم بازیابی خودکار OOM برای اجرای روان روی GPUهای محدود (نظیر RTX 3050 با 4GB حافظه VRAM).
- **موتور بازسازی اپتیکی و فرکانسی v2.0:** بازسازی تاری و رفع لرزش تصویر با دیکانولوشن معکوس وینر (Wiener Regularized Deconvolution) و هرم‌های چندمقیاسی لاپلاسین (Laplacian Pyramid) در فضای رنگی متعامد CIELAB بدون تداخل رنگی.
- **توسعه سوئیت بنچمارک و تضمین کیفیت تجربی:** محاسبه معیارهای PSNR، SSIM، MAE، $\Delta E$ و صدک‌های زمانی تأخیر (P95 و Median Latency) با پوشش کامل ۳۰+ تست خودکار واحد و یکپارچه در `pytest`.
- **رابط کاربری مدرن وب و ابزارهای CLI:** توسعه وب‌اپلیکیشن FastAPI مدرن با مقایسه‌گر قبل/بعد اسلایدی و Gradio 6 مجهز به صف پردازش گروهی و کلیدهای تنظیم موتور هوش مصنوعی.

---

### 🌐 English Version (For International CVs, Resume & LinkedIn Experience)

#### Project Title:
**Aether Vision — Adaptive AI Image Restoration & Super-Resolution Platform**

#### Role:
**Lead Computer Vision & Deep Learning Systems Engineer**

#### Key Highlights & Technical Bullet Points:
- **Architected an End-to-End Local-First Restoration Engine:** Designed and implemented a modular AI image restoration platform in Python 3.11, PyTorch, OpenCV, and SciPy, achieving high-throughput, photorealistic deblurring, denoising, and 2x/4x super-resolution.
- **Engineered Deep Neural Deblurring Architecture (`AetherExtremeDeblurNet`):** Designed and trained a Multi-Scale Dilated Residual U-Net featuring SimpleGate nonlinear units and Simplified Channel Attention (SCA) specifically tailored for ill-posed inverse problems (severe motion blur, out-of-focus bokeh, and optical distortions).
- **Novel High-Frequency Compound Loss Formulation:** Implemented `CombinedRestorationLoss` integrating smooth Charbonnier pixel fidelity with Sobel Edge Gradient Loss, preventing oversmoothed cartoonish artifacts and driving sharp edge boundary recovery.
- **Engineered Non-Reference Degradation Diagnostic Pipeline:** Built mathematical estimators for optical blur (Laplacian variance & Tenengrad energy), sensor grain noise (Donoho-Johnstone MAD), JPEG 8x8 blocking artifacts, and illumination defects with normalized confidence scores.
- **Built an Adaptive Degradation-Aware Router:** Designed an intelligent pipeline routing mechanism that sequences operations (e.g., bilateral de-blocking prior to super-resolution to prevent artifact amplification), establishing distinct **Mode A (Faithful & Identity-Preserving)** and **Mode B (Creative Generative)** operational paradigms.
- **Memory Optimization & Seam-Free Tiling Inference:** Developed a 2D Hann/Cosine window blending tile-processing engine with automated OOM recovery that dynamically downscales tile footprints under VRAM pressure, enabling reliable execution of large images on 4GB VRAM hardware (NVIDIA RTX 3050).
- **Physical Optical Deblurring & Micro-Texture Synthesis:** Developed regularized Wiener inverse deconvolution and multi-scale Laplacian pyramid decomposition operating in decoupled CIELAB color space, eliminating chromatic aberration and sharpening blurry images with high fidelity.
- **Empirical Benchmarking & Comprehensive Testing:** Created an automated benchmarking suite tracking latency percentiles (Median, P95), throughput (FPS), PSNR, SSIM, and edge halo indices, backed by **30+ fully automated unit and integration tests** in `pytest`.
- **Dual Modern Interfaces (Web & CLI):** Built a high-performance FastAPI web application with an interactive Before/After split slider, Gradio 6 batch processor, and standalone CLI tools.

#### Technologies Used:
`Python 3.11`, `PyTorch`, `Torchvision`, `OpenCV`, `NumPy`, `SciPy`, `FastAPI`, `Gradio 6`, `Pydantic`, `pytest`, `Tiling Blending Algorithms`, `Wiener Deconvolution`, `RRDBNet`, `NAFNet`, `ExtremeDeblurNet`.
