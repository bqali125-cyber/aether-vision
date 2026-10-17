# 🌌 Aether Vision
## Adaptive AI Image Restoration & Super-Resolution Platform

[![Python Version](https://img.shields.io/badge/python-3.11%20%7C%203.12-blue.svg)](https://www.python.org/)
[![License](https://img.shields.io/badge/license-Apache--2.0-green.svg)](LICENSE)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.0%2B-orange.svg)](https://pytorch.org/)
[![Tests Passing](https://img.shields.io/badge/tests-24%20passed-brightgreen.svg)]()

> **مأموریت مهندسی:** طراحی و پیاده‌سازی یک پلتفرم واقعی، ماژولار و قابل توسعه برای تحلیل هوشمند، بازسازی تصویر و Super-Resolution با تکیه بر شواهد تجربی و کنترل دقیق منابع سخت‌افزاری.

---

## 📋 فهرست مطالب (Table of Contents)
1. [معرفی معماری و لایه‌ها](#معماری-پروژه)
2. [امکانات پیاده‌سازی‌شده](#امکانات-واقعاً-پیادهسازیشده)
3. [دو حالت اصلی بازسازی (Faithful vs. Creative)](#دو-حالت-اصلی-بازسازی)
4. [الزامات سخت‌افزاری و شتاب‌دهنده‌ها](#الزامات-سختافزاری)
5. [راهنمای راه‌اندازی و نصب](#راهنمای-راهاندازی-و-نصب)
6. [دستورات اجرا (Web UI, CLI, Batch, Benchmark)](#دستورات-اجرا)
7. [مدیریت وزن‌ها و بررسی مجوزها](#مدیریت-مدلها-و-مجوزهای-حقوقی)
8. [خطایابی و رفع مشکلات رایج حافظه](#خطایابی-و-رفع-مشکلات-رایج)

---

## 🏛️ معماری پروژه (Architecture)

پروژه به لایه‌های کاملاً مستقل با قراردادهای نرم‌افزاری پایدار (`Abstract Base Classes`) تقسیم شده است:

```text
aether-vision/
├── app/                      # لایه برنامه و رابط کاربری
│   ├── main.py               # نقطه ورود اصلی وب‌اپلیکیشن
│   ├── config.py             # مدیریت تنظیمات مرکزی
│   └── ui/                   # رابط حرفه‌ای Gradio 6
├── aether/                   # هسته پردازشی و الگوریتم‌ها
│   ├── io/                   # ImageIO، اعتبارسنجی امنیتی، EXIF و مدیریت کانال آلفا
│   ├── analysis/             # تحلیلگر غیرمخرب کیفیت و تخمین خرابی‌ها (Blur, Noise, Blockiness)
│   ├── routing/              # روتر هوشمند برای انتخاب بهینه مدل‌ها بر اساس تشخیص
│   ├── engine/               # موتور هماهنگ‌کننده و پردازش قطعه‌ای (Seam-free Tile Processor)
│   ├── models/               # قراردادهای آداپتور و رجیستری مرکزی مدل‌ها
│   │   └── adapters/         # آداپتورهای Real-ESRGAN، NAFNet، Restormer، GFPGAN و Classical
│   ├── quality/              # کیفیت‌سنجی تجربی (PSNR, SSIM, MAE, Color Drift, Halo Check)
│   ├── performance/          # PerformanceManager (تشخیص خودکار CUDA/MPS/CPU و حافظه)
│   ├── benchmarks/           # سوئیت بنچمارک استاندارد با گزارش‌های Markdown و JSON
│   ├── training/             # پایپلاین تخریب کنترل‌شده و چارچوب آموزش/Fine-Tuning
│   └── utilities/            # لاگینگ ساختاریافته
├── configs/                  # فایل‌های پیکربندی سیستم
├── scripts/                  # اسکریپت‌های CLI، دانلود ایمن وزن‌ها و بنچمارک
├── tests/                    # ۲۴ تست واحد و یکپارچه واقعی
├── MODEL_LICENSES.md         # مستندات حسابرسی حقوقی و محدودیت‌های مدل‌ها
└── SECURITY.md               # خط‌مشی حریم خصوصی و امنیت محلی
```

---

## ⚡ امکانات واقعاً پیاده‌سازی‌شده

1. **تحلیل هوشمند تصویر (`ImageQualityAnalyzer`)**:
   - محاسبه ریاضی شدت تاری با واریانس لاپلاسین و انرژی گرادیان Tenengrad.
   - تخمین نویز سنسور بر پایه Median Absolute Deviation (MAD) در نواحی هموار.
   - محاسبه خطای قطعه‌بندی و بلوک‌های JPEG (Wang-Bovik Blockiness Index).
   - ارزیابی روشنایی در فضای رنگی Lab و تشخیص تصاویر کم‌نور.
   - تشخیص حضور چهره با OpenCV Haar Cascades برای انتخاب ابزار بازسازی چهره.

2. **روتر هوشمند بازسازی (`RestorationRouter`)**:
   - جلوگیری از عبور کورکورانه تصویر از تمام مدل‌ها.
   - اولویت‌بندی عملیات: ابتدا حذف نویز و آرتیفکت فشرده‌سازی، سپس بازسازی وضوح و Super-Resolution برای جلوگیری از بزرگ‌نمایی نویز.
   - ارائه گزارش شفاف برای دلایل انتخاب هر مسیر با امکان Override دستی توسط کاربر.

3. **پردازش قطعه‌ای بدون درز (`TileProcessor`)**:
   - تقسیم تصاویر بسیار بزرگ به کاشی‌های با هم‌پوشانی (Overlap).
   - ترکیب با پنجره هموار ۲ بعدی کسینوسی/هَن (Hann 2D Window Blending) بدون خطوط مرزی.
   - **بازیابی خودکار از خطای OOM**: در صورت کمبود VRAM، اندازه تایل به صورت خودکار کاهش یافته و دوباره تلاش می‌شود.

4. **مدیریت پیشرفته فرمت‌ها و پیش‌پردازش (`ImageIO`)**:
   - مدیریت خودکار چرخش EXIF (`exif_transpose`).
   - حفظ کامل کانال آلفا (RGBA) و تفکیک، بازسازی و ترکیب دقیق آن.
   - پشتیبانی از تصاویر سیاه و سفید (Grayscale) و فضاهای رنگی مختلف.
   - جلوگیری از برش ناخواسته، تغییر رنگ یا تغییر نسبت ابعاد.

5. **کیفیت‌سنجی و بنچمارک تجربی (`QualityEvaluator` & `BenchmarkSuite`)**:
   - محاسبه معیارهای دارای مرجع: PSNR (dB)، SSIM، MAE و انحراف رنگ $\Delta E$.
   - ردیابی آرتیفکت‌های بدون مرجع: تشخیص Halo / Ringing و اورشارپنینگ در لبه‌ها.
   - اندازه‌گیری صدک‌های تأخیر (Mean, Median, P95) و نرخ فریم (FPS).

---

## 🎨 دو حالت اصلی بازسازی (Modes)

### Mode A — Faithful Restoration (حالت وفادار)
- **هدف**: حفظ حداکثری هندسه واقعی، بافت طبیعی و هویت چهره.
- **رفتار**: جلوگیری از اورشارپ کردن تهاجمی، کنترل هاله در لبه‌ها و عدم تزریق بافت‌های مصنوعی یا ساختگی.
- **کاربرد**: اسناد تاریخی، عکس‌های یادگاری، مدارک شناسایی، طبیعت و معماری دقیق.

### Mode B — Creative Enhancement (حالت خلاقانه)
- **هدف**: غنی‌سازی ادراکی، افزایش کنتراست و بازیابی بافت‌های ریز از دست رفته با مدلهای مولد.
- **تعهد شفافیت**: خروجی خلاقانه هرگز به عنوان حقیقت مطلق تصویر معرفی نمی‌شود و کاربر از احتمال تولید جزئیات شبیه‌سازی‌شده مطلع می‌گردد.

---

## 🖥️ الزامات سخت‌افزاری (Hardware)

- **حداقل سیستم (CPU)**: پردازنده چند هسته‌ای Intel/AMD، حداقل 8GB رم (Inference به صورت FP32).
- **کارت گرافیک پیشنهادی (NVIDIA CUDA)**:
  - کارت‌های با حداقل 4GB VRAM (نظیر GeForce RTX 3050 Laptop).
  - سیستم به صورت خودکار اندازه Tile را بر اساس VRAM تنظیم می‌کند (384px تا 512px برای جلوگیری از OOM).
- **اپل سیلیکون (Apple Silicon MPS)**: پشتیبانی خودکار از دستگاه‌های M1/M2/M3 با شتاب سخت‌افزاری Metal.

---

## 🚀 راهنمای راه‌اندازی و نصب

### پیش‌نیازها
پروژه از ابزار سریع `uv` برای ساخت محیط ایزوله استفاده می‌کند:

```powershell
# در ویندوز (PowerShell)
$env:PYTHONUTF8="1"
$env:PYTHONIOENCODING="utf-8"

# فعال‌سازی محیط مجازی پروژه
.\.venv\Scripts\Activate.ps1
```

در صورت نیاز به نصب مجدد در یک محیط تمیز:
```bash
# نصب بسته‌های اصلی
uv pip install numpy pillow opencv-python-headless scipy gradio pydantic pyyaml tqdm rich pytest torch torchvision
```

---

## 💻 دستورات اجرا (Usage)

### ۱. اجرای رابط کاربری تحت وب (Gradio Web UI)
```powershell
python app/main.py
```
سپس مرورگر خود را در آدرس `http://127.0.0.1:7860` باز کنید.

### ۲. پردازش مستقیم یک تصویر از طریق CLI
```powershell
# بازسازی وفادار با ۲ برابر افزایش رزولوشن
python scripts/run_cli.py examples/sample_photo.png --mode faithful --scale 2 --output outputs/

# بازسازی با ۴ برابر افزایش رزولوشن
python scripts/run_cli.py examples/sample_photo.png --mode creative --scale 4 --output outputs/
```

### ۳. پردازش گروهی (Batch Processing)
```powershell
python scripts/run_cli.py D:\photos_folder --mode auto --scale 2 --output outputs/batch/
```

### ۴. اجرای بنچمارک عملکرد و سرعت
```powershell
python scripts/run_benchmark.py --models classical_faithful --iterations 3 --output-dir outputs/benchmarks/
```

### ۵. اجرای آزمون‌های خودکار (Unit & Integration Tests)
```powershell
pytest -v
```

---

## ⚖️ مدیریت مدل‌ها و مجوزهای حقوقی

جزئیات کامل در [MODEL_LICENSES.md](MODEL_LICENSES.md) مستند شده است:

- **Classical Engine (`classical_faithful`)**: کاملاً رایگان و آزاد برای استفاده تجاری (Apache-2.0 / BSD). بدون نیاز به دانلود وزن.
- **Real-ESRGAN (`real_esrgan_x4`, `real_esrgan_x2`)**: لایسنس BSD-3-Clause، مجاز برای کاربردهای عمومی و تجاری.
- **NAFNet (`nafnet_deblur`, `nafnet_denoise`)**: لایسنس MIT، با عملکرد عالی در رفع تاری حرکتی و نویز.
- **GFPGAN (`gfpgan`)**: بازسازی تخصصی چهره. لایسنس تحقیقاتی غیرتجاری.
- **HYPIR (`hypir`)**: **توجه مهم حقوقی:** مدل HYPIR تحت مجوز غیرتجاری CC-BY-NC-SA قرار دارد. به صورت پیش‌فرض در مسیرهای تجاری فعال نمی‌شود و اجرای آن مستلزم تأیید صریح کاربر برای مقاصد تحقیقاتی است.

### دریافت ایمن وزن‌ها:
```powershell
# دانلود وزن‌های مجاز با بررسی یکپارچگی
python scripts/download_weights.py --model real_esrgan_x4
python scripts/download_weights.py --model nafnet_deblur
```

---

## 🛠️ خطایابی و رفع مشکلات رایج

1. **خطای حافظه (CUDA Out of Memory)**:
   - در رابط کاربری یا خط فرمان، اندازه Tile را کاهش دهید (مثلاً `--tile-size 256`).
   - سیستم به صورت پیش‌فرض دارای لایه Retry خودکار است که در صورت مشاهده فشار VRAM، اندازه تایل را کوچک می‌کند.
2. **عدم شناسایی GPU در PyTorch**:
   - برای دریافت بیلد با شتاب‌دهنده CUDA روی کارت RTX 3050:
     ```powershell
     uv pip install torch torchvision --index-url https://download.pytorch.org/whl/cu124
     ```
   - سیستم در صورت عدم دسترسی به CUDA، به صورت بی‌نقص و ایمن روی CPU fallback می‌کند.
3. **محدودیت‌های رفع تاری (Deblurring)**:
   - تصاویری که اطلاعات فرکانس بالای آن‌ها به کلی از بین رفته است، در حالت Faithful تا مرز حفظ هندسه واقعی بازیابی می‌شوند. برای جزئیات فرضی می‌توانید از حالت Creative استفاده کنید.
