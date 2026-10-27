# Artificial Intelligence: Breadth-First Search (BFS) Visualizer

[![Language](https://img.shields.io/badge/Language-R-blue.svg)](https://www.r-project.org/)
[![Framework](https://img.shields.io/badge/Framework-Shiny-brightgreen.svg)](https://shiny.rstudio.com/)
[![Visualization](https://img.shields.io/badge/Visualization-visNetwork-orange.svg)](https://datastorm-open.github.io/visNetwork/)

---

### Language / Bahasa
- [English (Default)](#english)
- [Bahasa Indonesia](#bahasa-indonesia)

---

<a name="english"></a>
## English

### Overview
This project is an interactive web-based simulator for the **Breadth-First Search (BFS)** algorithm in Artificial Intelligence, developed using **R**, **Shiny**, and **visNetwork**. It visually demonstrates how BFS explores an unweighted and undirected graph level-by-level to guarantee the shortest path between any chosen start and goal nodes.

### Key Features
- **Interactive Graph Canvas**: Powered by vis.js physics engine with stabilized layout (`barnesHut`) to prevent jitter.
- **Shortest Path Highlighting**: Start node (Green), Goal node (Red), Same Start & Goal (Orange), Path Nodes (Deep Sky Blue), and Path Edges (Bold Blue).
- **Early Goal Test**: Optimized BFS exploration that verifies goal attainment the moment a neighbor node is discovered, reflecting modern AI theory.
- **Dynamic Neighbor Shuffling**: Demonstrates how changing the order of neighbor queues impacts the order of exploration while still guaranteeing the shortest path cost.
- **Multi-Variation Files**: Includes 5 distinct scripts (`BFS_1.R` through `BFS_5.R`) with different initial permutations and extreme shuffles of adjacency lists (`graph_base`).

### Project Structure
```text
BFS/
├── BFS_1.R        # Standard alphabetical adjacency list (A to J)
├── BFS_2.R        # Extreme shuffle permutation (starts with J, D, A...)
├── BFS_3.R        # Extreme shuffle permutation (starts with F, I, B...)
├── BFS_4.R        # Extreme shuffle permutation (starts with H, C, I...)
├── BFS_5.R        # Extreme shuffle permutation (starts with B, G, I...)
└── README.md      # Multi-language documentation
```

### Graph Structure (10 Nodes, 13 Edges)
- **Nodes**: `A, B, C, D, E, F, G, H, I, J`
- **Edges**: `A-B`, `A-C`, `A-H`, `B-D`, `B-E`, `C-F`, `C-G`, `D-I`, `E-I`, `F-J`, `G-J`, `H-I`, `I-J`

### Prerequisites
Ensure you have R and RStudio installed. Then, install the required packages:
```r
install.packages(c("shiny", "visNetwork"))
```

### How to Run
Open R or RStudio and execute any variation script:
```r
library(shiny)
runApp("BFS_1.R")
```
*(Replace `"BFS_1.R"` with `"BFS_2.R"`, `"BFS_3.R"`, `"BFS_4.R"`, or `"BFS_5.R"` to test other variations).*

---

<a name="bahasa-indonesia"></a>
## Bahasa Indonesia

### Ringkasan
Proyek ini adalah simulator berbasis web interaktif untuk algoritma **Breadth-First Search (BFS)** dalam bidang Kecerdasan Buatan (Artificial Intelligence), dibangun menggunakan **R**, **Shiny**, dan **visNetwork**. Aplikasi ini memvisualisasikan bagaimana BFS menjelajahi graf tanpa bobot dan tidak berarah lapis demi lapis untuk menjamin penemuan rute terpendek antara titik awal dan titik tujuan.

### Fitur Utama
- **Visualisasi Graf Interaktif**: Menggunakan *physics engine* vis.js dengan konfigurasi stabil (`barnesHut`) agar graf tidak bergetar berlebihan.
- **Penyorotan Jalur Solusi**: Titik Awal (Hijau), Titik Tujuan (Merah), Titik Sama (Oranye), Simpul Jalur (Biru Langit Muda), dan Sisi Jalur Solusi (Biru Tebal).
- **Early Goal Test**: Algoritma BFS yang dioptimalkan untuk menguji simpul tujuan seketika saat simpul tetangga dibangkitkan, sesuai standar teori AI modern.
- **Pengacak Urutan Tetangga**: Menunjukkan bahwa urutan antrean tetangga dapat menghasilkan urutan penelusuran yang dinamis namun tetap konsisten pada biaya lintasan terpendek.
- **5 File Variasi**: Menyediakan 5 file R terpisah (`BFS_1.R` s.d `BFS_5.R`) dengan urutan `graph_base` yang diacak secara ekstrem.

### Struktur Proyek
```text
BFS/
├── BFS_1.R        # Adjacency list standar terurut abjad (A sampai J)
├── BFS_2.R        # Variasi acak ekstrem (dimulai dari J, D, A...)
├── BFS_3.R        # Variasi acak ekstrem (dimulai dari F, I, B...)
├── BFS_4.R        # Variasi acak ekstrem (dimulai dari H, C, I...)
├── BFS_5.R        # Variasi acak ekstrem (dimulai dari B, G, I...)
└── README.md      # Dokumentasi multibahasa
```

### Struktur Graf (10 Simpul, 13 Sisi)
- **Simpul (Nodes)**: `A, B, C, D, E, F, G, H, I, J`
- **Sisi (Edges)**: `A-B`, `A-C`, `A-H`, `B-D`, `B-E`, `C-F`, `C-G`, `D-I`, `E-I`, `F-J`, `G-J`, `H-I`, `I-J`

### Kebutuhan Sistem / Dependensi
Pastikan R atau RStudio telah terpasang, lalu jalankan perintah berikut di console R untuk memasang pustaka yang dibutuhkan:
```r
install.packages(c("shiny", "visNetwork"))
```

### Cara Menjalankan
Buka RStudio atau console R, lalu jalankan salah satu file:
```r
library(shiny)
runApp("BFS_1.R")
```
*(Ganti `"BFS_1.R"` dengan `"BFS_2.R"`, `"BFS_3.R"`, `"BFS_4.R"`, atau `"BFS_5.R"` untuk mencoba variasi graf lainnya).*
