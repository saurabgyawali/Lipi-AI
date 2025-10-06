# 🧠 LIPI AI  
### Tibetan–English OCR and Neural Machine Translation System  

LIPI-AI is a research-oriented project that automates the conversion of **Tibetan script images into English text** through an integrated **Computer Vision (CV)** and **Natural Language Processing (NLP)** pipeline.  
It combines image preprocessing, OCR extraction, and Transformer-based translation within a unified, modular architecture.

---

## 🚀 Overview

Developed under the **Student Research Council Nepal**, this project explores multilingual AI applications in **low-resource language translation**.  
The system performs three major tasks:

1. **Image Preprocessing** – using OpenCV for denoising, normalization, and segmentation of Tibetan text images.  
2. **Optical Character Recognition (OCR)** – extracting raw Tibetan text from processed images.  
3. **Neural Machine Translation (NMT)** – converting Tibetan text to English using a pretrained Transformer model.  

A lightweight **Flask API** connects the backend model to a **Flutter frontend**, enabling real-time translation demos for research and testing.

---

## 🧩 System Architecture

```text
Tibetan Image
     │
     ▼
[1] Preprocessing (OpenCV)
     │
     ▼
[2] OCR (Character Extraction)
     │
     ▼
[3] Transformer Model (NMT)
     │
     ▼
[4] Flask API → Flutter Frontend
