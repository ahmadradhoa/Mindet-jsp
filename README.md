# Mindet - Forum & Discussion Web Application (JSP / Jakarta Server Pages)

A modern discussion and forum web application originally developed in Laravel, fully migrated and converted to **JSP (Java / Jakarta Server Pages)** running on **Jakarta EE 10 / Apache Tomcat 10** with **JDK 21** and embedded **SQLite**.

---

## 🚀 Fitur Utama

- **Authentication & Authorization**: Registrasi, Login, Logout, dan Session Guard menggunakan `AuthFilter`.
- **Forum & Diskusi (CRUD Posts)**:
  - Melihat daftar postingan dengan filter kategori dan pencarian teks judul/isi.
  - Membuat postingan baru dengan pemilihan kategori.
  - Membaca postingan lengkap dengan informasi pembuat, waktu relatif, dan badge kategori.
  - Edit & Hapus postingan (dilengkapi otorisasi kepemilikan dan konfirmasi SweetAlert2).
- **Komentar (Comments)**:
  - Menulis komentar pada postingan.
  - Menghapus komentar milik pengguna sendiri.
- **Kategori Diskusi (Categories CRUD)**:
  - Melihat daftar kategori dengan badge jumlah postingan aktif.
  - Tambah kategori baru.
  - Edit dan Hapus kategori (otomatis cascade ke postingan dan komentar terkait).
- **Pengaturan Profil (Profile Settings)**:
  - Mengubah username.
  - Memilih palet warna avatar (`#6366f1`, `#ef4444`, `#10b981`, `#f59e0b`, `#ec4899`, `#8b5cf6`, `#06b6d4`, `#f97316`) dengan preview real-time.
- **Tema Terang & Gelap (Dark Mode)**:
  - Tombol toggle mode gelap di desktop dan mobile.
  - Status tema tersimpan di `localStorage`.
- **Desain Responsif**:
  - Tampilan desktop dan mobile dengan navigasi bawah (bottom navigation bar) Bootstrap 5.3.

---

## 🛠️ Teknologi & Stack

- **Platform**: Java 21 (OpenJDK / Eclipse Adoptium)
- **Servlet Container**: Apache Tomcat 10.1 (Jakarta Servlet 6.0, Jakarta Server Pages 3.1)
- **Tag Library**: Jakarta Standard Tag Library (JSTL 3.0)
- **Database**: SQLite (terintegrasi via `sqlite-jdbc` & SLF4J, auto-migrasi skema dan auto-seeder data awal)
- **Keamanan Password**: PBKDF2 with HMAC-SHA256
- **Frontend**: Bootstrap 5.3.3, Bootstrap Icons 1.11.3, SweetAlert2, Plus Jakarta Sans Font

---

## 📂 Struktur Proyek

```
Mindet-main/
├── run.bat                         # Script 1-klik untuk menjalankan server
├── stop.bat                        # Script untuk menghentikan server
├── pom.xml                         # Definisi konfigurasi Maven
├── mindet.sqlite                   # Database SQLite lokal
├── src/main/
│   ├── java/com/mindet/
│   │   ├── model/                  # Model Data: User, Category, Post, Comment
│   │   ├── dao/                    # Akses Database: UserDao, CategoryDao, PostDao, CommentDao
│   │   ├── filter/                 # Filter Servlet: AppFilter, AuthFilter
│   │   ├── servlet/                # Controllers: AuthServlet, PostServlet, CategoryServlet, CommentServlet, ProfileServlet, HomeServlet
│   │   └── util/                   # Utilitas: DB, DateUtil, PasswordUtil
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── web.xml             # Deployment descriptor Jakarta EE 6.0
│       │   └── views/              # Template JSP: layouts, posts, categories, auth, profile
│       └── image/                  # Logo & gambar
├── resources/views/                # Salinan template JSP untuk kompatibilitas struktur views
└── tomcat/                         # Runtime Apache Tomcat 10.1 bawaan
```

---


