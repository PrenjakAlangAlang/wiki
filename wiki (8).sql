-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 13, 2025 at 04:24 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wiki`
--

-- --------------------------------------------------------

--
-- Table structure for table `content`
--

CREATE TABLE `content` (
  `id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `author_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tag` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `instance_id` int DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `deleted_at` datetime DEFAULT NULL,
  `view_count` int DEFAULT '0',
  `rejection_reason` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `content`
--

INSERT INTO `content` (`id`, `title`, `description`, `author_id`, `created_at`, `updated_at`, `tag`, `instance_id`, `status`, `deleted_at`, `view_count`, `rejection_reason`) VALUES
(14, 'Dinas Komunikasi dan Informatika DIY 2', '<p>Halaman index wiki Diskominfo DIY</p>', 2, '2024-11-01 02:43:39', '2025-02-13 04:09:02', 'diskominfo', 1, 'approved', NULL, 447, NULL),
(15, 'Badan Kepegawaian Daerah 2', NULL, 2, '2024-11-01 02:55:33', '2025-02-13 03:36:45', 'bkd', 2, 'approved', NULL, 53, NULL),
(16, 'Badan Kesatuan Bangsa dan Politik', NULL, 3, '2024-11-01 03:04:09', '2025-02-11 07:49:23', 'bakesbangpol', 3, 'approved', NULL, 7, NULL),
(17, 'Badan Penanggulangan Bencana Daerah', 'Badan Perencanaan Pembangunan Daerah Daerah Istimewa Yogyakarta (BAPPEDA DIY) ', 2, '2024-11-01 03:53:32', '2024-11-13 02:51:07', 'bpbd', 4, 'pending', NULL, 0, NULL),
(18, 'Badan Pendidikan dan Pelatihan', 'Berdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 102 Tahun 2022 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Badan Pendidikan dan Pelatihan disebutkan tentang tugas pokok dan fungsi Badan Diklat DIY sebagai berikut:', 2, '2024-11-01 03:53:32', '2025-02-05 16:10:21', 'bandiklat', 5, 'pending', NULL, 2, NULL),
(19, 'Badan Pengelola Keuangan dan Aset Daerah Istimewa Yogyakarta', 'Selamat datang di halaman Badan Pengelola Keuangan dan Aset Daerah Istimewa Yogyakarta  \r\n\r\nBerdasarkan Peraturan Gubernur DIY Nomor 4 Tahun 2023 tentang tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi dan Tata Kerja Badan Pengelola Keuangan dan Aset DIY,  tugas dan fungsi BPKA DIY sebagai berikut:', 2, '2024-11-01 05:56:01', '2024-11-13 02:51:07', 'bpka', 6, 'pending', NULL, 0, NULL),
(20, 'Badan Penghubung Daerah', 'Jl. Pangeran Diponegoro No.52, RT.15/RW.5, Menteng, Kec. Menteng, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10310', 2, '2024-11-01 06:02:34', '2024-11-13 02:51:07', 'banhubda', 7, 'pending', NULL, 0, NULL),
(21, 'Badan Perencanaan Pembangunan Daerah', 'Badan Perencanaan Pembangunan Daerah Daerah Istimewa Yogyakarta (BAPPEDA DIY) ', 2, '2024-11-01 06:04:24', '2024-11-13 02:51:07', 'bappeda', 8, 'pending', NULL, 0, NULL),
(22, 'Biro Administrasi Perekonomian dan Sumber Daya Alam', 'Kompleks Kepatihan Danurejan Jl. Malioboro No.16, Suryatmajan, Kec. Danurejan, Kota Yogyakarta, Daerah Istimewa Yogyakarta 55213', 2, '2024-11-01 06:04:24', '2024-11-13 02:51:07', 'biro-apsda', 9, 'pending', NULL, 0, NULL),
(23, 'Biro Bina Mental Spiritual', 'Berdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 105 Tahun 2022 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Sekretariat Daerah, Biro Bina Mental Spiritual Setda DIY memiliki,', 2, '2024-11-01 06:22:38', '2024-12-05 08:55:08', 'biro-bina-mental', 10, 'pending', NULL, 0, NULL),
(24, 'Biro Bina Pemberdayaan Masyarakat', NULL, 2, '2024-11-01 06:26:58', '2024-11-13 02:51:07', 'biro-bermas', 11, 'pending', NULL, 0, NULL),
(25, 'Biro Hukum', NULL, 2, '2024-11-01 06:29:54', '2024-11-13 02:51:07', 'biro-hukum', 12, 'pending', NULL, 0, NULL),
(26, 'Biro Organisasi', '<p>Sebagaimana tercantum di dalam Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 136 Tahun 2021 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, Dan Tata Kerja Sekretariat Daerah, Biro Organisasi mempunyai tugas melaksanakan fungsi pendukung perumusan kebijakan strategis bidang organisasi. Untuk melaksanakan tugas tersebut, Biro Organisasi mempunyai fungsi: </p><ol><li>Penyusunan program kerja Biro Organisasi; </li><li>Penyiapan bahan kebijakan bidang kelembagaan dan tatalaksana, standardisasi dan pelayanan publik serta reformasi birokrasi Pemerintah Daerah; </li><li>Penyiapan bahan koordinasi bidang kelembagaan dan tatalaksana, standardisasi dan pelayanan publik serta reformasi birokrasi Pemerintah Daerah; </li><li>Perumusan kebijakan strategis, perencanaan dan pengendaliaan urusan keistimewaan bidang kelembagaan Pemerintah Daerah; </li><li>Penataan kelembagaan dan tatalaksana, standardisasi dan pelayanan publik serta reformasi birokrasi Pemerintah Daerah; </li><li>Fasilitasi pelaksanaan reformasi birokrasi Pemerintah Daerah; </li><li>Pelaksanaan koordinasi pembinaan, pengawasan dan pengendalian terhadap urusan kelembagaan yang menjadi kewenangan Kabupaten/Kota; </li><li>Pemantauan dan pengevaluasian pelaksanaan kebijakan bidang kelembagaan, tatalaksana dan pelayanan publik, serta reformasi birokrasi Pemerintah Daerah; </li><li>Penyusunan laporan pelaksanaan tugas Biro; </li><li>pelaksanaan kegiatan ketatausahaan; dan 11. pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Biro.</li></ol>', 2, '2024-11-01 06:37:46', '2025-02-05 04:55:19', 'biro-organisasi', 13, 'approved', NULL, 9, NULL),
(27, 'Biro Pengembangan Infrastruktur Wilayah Dan Pembiayaan Pembangunan', '<p>BIRO PENGEMBANGAN INFRASTRUKTUR WILAYAH DAN PEMBIAYAAN PEMBANGUNAN SEKRETARIAT DAERAH DAERAH ISTIMEWA YOGYAKARTA</p>', 2, '2024-11-01 06:39:23', '2025-02-11 08:13:49', 'biro-piwp2,kkk', 14, 'approved', NULL, 14, NULL),
(28, 'Biro Tata Pemerintahan', NULL, 2, '2024-11-01 06:56:59', '2024-11-13 02:51:07', 'biro-tapem', 15, 'pending', NULL, 0, NULL),
(29, 'Biro Umum, Hubungan Masyarakat dan Protokol SETDA DIY', NULL, 2, '2024-11-01 07:03:41', '2024-11-13 02:51:07', 'biro-uhp', 16, 'pending', NULL, 0, NULL),
(30, 'Dinas Kebudayaan (Kundha Kabudayan)', 'Urusan Kebudayaan DIY pada mulanya menjadi wewenang Dinas Pendidikan dan Kebudayaan DIY. Melalui Keputusan Gubernur Daerah Istimewa Yogyakarta nomor: 353/KPTS/1994 tanggal 26 Oktober 1994 tentang Pembentukan Dinas Kebudayaan Provinsi DIY, maka urusan Kebudayaan menjadi dinas tersendiri . Dinas Pendidikan dan Kebudayaan DIY menjadi Dinas Kebudayaan DIY dan Dinas Pendidikan dan Pengajaran. Pada mulanya kepalai Dinas dilaksanakan oleh Plt oleh Drs. Wahyuntana yang sekaligus masih merangkap di Dinas Pendidikan dan Pengajaran, dan pada tahun ini belum ada pejabat eselon III dan IV serta belum ada kantor resmi. Baru pada 26 November 1997 di lakukan peresmian Dinas Kebudayaan DIY, peresmian Kantor Dinas di sisi timur lapangan kepatihan, dan pada 27 November 1997 di lakukan pelantikan pejabat eselon II, III, dan IV. Pada saat itu Drs. Wahyuntana resmi menjadi pelaksana harian. Pada tahun 1998 Kepala Dinas dijabat oleh KMT Putronagoro sampai pensiun pada tahun 2000, yang selanjutnya ketugasan kepala dinas dilaksanakan oleh Ir. Kismo Sukirdo Sesuai kebijakan Pemerintah mengenai otonomi daerah, penyerahan kewenangan, dan urusan, pada tahun 2001 Dinas Kebudayaan DIY bergabung dengan Dinas Pariwisata DIY, Kanwil Pariwisata DIY, Kanwil Pendidikan dan Kebudayaan DIY (Bidang Sejarah dan Nilai tradisi dan Bidang Museum dan Purbakala) menjadi Dinas Kebudayaan dan Pariwisata DIY dengan Kepala Dinas Ir. Djoko Budhi Sulistyo (Oktober 2001- 30 September 2006). selanjutnya Kepala Dinas Kebudayaan dari masa - kemasa adalah sebagai berikut:\r\n\r\n30 September 2006 - 23 Juli 2008,  Ir. Condroyono sebagai Kepala Dinas\r\n\r\n23  Juli 2008 - 22 Desember 2008 Dra. Dyan Anggraini (plt)\r\n\r\n22 Desember 2008 - 2010 Drs. Djoko Dwiyanto Mhum.\r\n\r\n2010 - 2014 Drs. GBPH Yudaningrat, MM\r\n\r\n2014 - 2018 Drs. Umar Priyono,MPd.\r\n\r\n2018 - 2020 Aris Eko Nugroho, S.P. M.Si\r\n\r\n2020 - sekarang Dian Lakshmi Pratiwi, SS. M.A.', 2, '2024-11-01 07:08:10', '2024-11-13 02:51:07', 'disbud', 17, 'pending', NULL, 0, NULL),
(31, 'Dinas Kelautan dan Perikanan', 'Dinas Kelautan dan Perikanan Daerah Istimewa Yogyakarta dibentuk berdasarkan Peraturan Daerah Nomor 5 Tahun 2001 tanggal 23 Juli 2001, Jo. Peraturan Daerah Nomor 3 Tahun 2004 tentang Pembentukan dan Organisasi Dinas Daerah di Lingkungan Pemerintah Provinsi Daerah Istimewa Yogyakarta. Dinas Kelautan dan Perikanan berkedudukan di Jalan Sagan III/4, Terban, Gondokusuman, Yogyakarta.\r\n\r\nDinas Kelautan dan Perikanan Daerah Istimewa Yogyakarta mempunyai tugas melaksanakan urusan Pemerintah Daerah di bidang kelautan dan perikanan, kewenangan Dekonsentrasi serta Tugas Pembantuan, yang diberikan oleh Pemerintah Pusat. Untuk melaksanakan tugas sebagaimana dimaksud, Dinas Kelautan dan Perikanan memiliki fungsi:\r\n\r\n1. Penyusunan program dan pengendalian di bidang kelautan dan perikanan\r\n2. Perumusan kebijaksanaan teknis di bidang  kelautan dan perikanan\r\n3. Pelaksanaan, pengembangan, pengolahan dan pemasaran kelautan dan perikanan, wilayah pesisir\r\n4. Pelaksanaan koordinasi perizinan di bidang kelautan dan perikanan\r\n5. Pengujian dan pengawasan mutu perikanan\r\n6. Pemberian fasilitasi penyelenggaraan bidang kelautan dan perikanan kabupaten/kota\r\n7. Pelaksanaan pelayanan umum sesuai kewenangannya\r\n8. Penyelenggaraan kegiatan kelautan dan perikanan lintas kabupaten/kota\r\n9. Pemberdayaan sumberdaya dan mitra kerja di bidang kelautan dan perikanan\r\n10. elaksanaan kegiatan ketatausahaan\r\n11. Pelaksanaan tugas lain yang diberikan oleh Gubernur DIY sesuai dengan tugas dan fungsi.\r\n\r\nDinas Kelautan dan Perikanan Daerah Istimewa Yogyakarta memiliki 2 kantor Unit Pelaksana Teknis Dinas (UPTD), yaitu:\r\n\r\n1. Balai Pengembangan Teknologi Perikanan Budidaya (BPTPB) Cangkringan \r\n\r\n2. Pelabuhan Perikanan Pantai (PPP) Sadeng.\r\n\r\nUPTD adalah unit organisasi di lingkungan Dinas Kelautan dan Perikanan, yang melaksanakan tugas teknis penunjang dan/atau tugas teknis operasional. UPTD BPTPB berkedudukan di Cangkringan, Sleman. Sedangkan UPTD PPP berkedudukan di Sadeng, Girisubo, Gunungkidul.', 2, '2024-11-01 07:12:25', '2024-11-13 02:51:07', 'dislautkan', 18, 'pending', NULL, 0, NULL),
(32, 'Dinas Kesehatan', NULL, 2, '2024-11-01 07:12:55', '2024-11-13 02:51:07', 'diskes', 19, 'pending', NULL, 0, NULL),
(33, 'Dinas Koperasi dan Usaha Kecil Menengah', NULL, 2, '2024-11-16 04:59:20', '2024-11-22 01:26:17', 'diskop-umkm', 20, 'pending', NULL, 0, NULL),
(35, 'Dinas Lingkungan Hidup dan Kehutanan', NULL, 2, '2024-11-16 05:17:36', '2024-12-05 08:57:53', 'dlhk', 21, 'pending', NULL, 0, NULL),
(36, 'Dinas Pariwisata DIY', NULL, 2, '2024-11-16 05:22:09', '2024-11-25 06:41:18', 'dispar', 22, 'pending', NULL, 0, NULL),
(37, 'Dinas Pekerjaan Umum, Perumahan dan Energi Sumber Daya Mineral', 'Dinas Pekerjaan Umum Perumahan dan Energi Sumber Daya Mineral DIY dibentuk berdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 69 Tahun 2023 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, Dan Tata Kerja Dinas Pekerjaan Umum, Perumahan Dan Energi Sumber Daya Mineral.', 2, '2024-11-16 06:44:53', '2024-11-25 06:48:47', 'dpupesdm', 23, 'pending', NULL, 0, NULL),
(38, 'Dinas Pemberdayaan Perempuan, Perlindungan Anak dan Pengendalian Penduduk', 'Perempuan, Perlindungan Anak dan Pengendalian Penduduk Daerah Istimewa Yogyakarta dibentuk berdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 5 Tahun 2023 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Perempuan, Perlindungan Anak dan Pengendalian Penduduk.', 2, '2024-11-18 04:45:39', '2024-11-25 08:16:39', 'dp3ap2', 24, 'pending', NULL, 0, NULL),
(39, 'Dinas Pendidikan, Pemuda dan Olahraga', NULL, 2, '2024-11-18 07:41:37', '2024-11-25 08:18:46', 'disdikpora', 25, 'pending', NULL, 0, NULL),
(40, 'Dinas Perhubungan', 'Sesuai Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 115 Tahun 2022 Tanggal 30 Desember 2022 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Dinas Perhubungan, menetapkan bahwa Dinas Perhubungan DIY mempunyai tugas membantu Gubernur melaksanakan urusan Pemerintah  bidang Perhubungan.\n\nDalam melaksanakan tugas Dinas Perhubungan DIY mempunyai fungsi:\n\n1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis bidang angkutan, lalu lintas, prasarana transportasi dan pengendalian operasional;\n3. Pelaksanaan kebijakan bidang angkutan, lalu lintas, prasarana transportasi dan pengendalian operasional;\n4. Pengembangan dan pengelolaan terminal dan perparkiran;\n5. Fasilitasi pembinaan reformasi birokrasi Dinas;\n6. Fasilitasi penyusunan kebijakan proses bisnis Dinas;\n7. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik lingkup Dinas;\n8. Pemantauan, pengevaluasian, dan pelaporan pelaksanaan kebijakan bidang perhubungan;\n9. Pelaksanaan kegiatan kesekretariatan;\n10. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n11. Pelaksanaan evaluasi dan pelaporan tugas Dinas; dan\n12. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.\n13. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.', 2, '2024-11-18 08:01:03', '2024-11-25 08:27:54', 'dishub', 26, 'pending', NULL, 0, NULL),
(41, 'Dinas Perindustrian dan Perdagangan', 'Dinas Perindustrian dan Perdagangan Daerah Istimewa Yogyakarta dibentuk berdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 99 Tahun 2022 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Dinas Perindustrian dan perdagangan.', 2, '2024-11-21 07:52:38', '2024-11-27 09:15:42', 'disperindag', 27, 'pending', NULL, 0, NULL),
(42, 'Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu', 'Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu (DPMPTSP) merupakan organisasi di bawah Pemerintah Daerah D.I.Yogyakarta, dimana secara kedudukan susunan organisasi tugas fungsi dan tata kerja diatur melalui Peraturan Gubernur DIY Nomor 108 Tahun 2022 tentang Kedudukan, Susunan Organisasi, Tugas Fungsi dan Tata Kerja Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu. Pada BAB III Pasal 4 Pergub DIY Nomor 108 Tahun 2022 dijelaskan bahwa Dinas mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan penanaman modal dan pelayanan terpadu satu pintu. Fungsi DPMPTSP D.I.Yogyakarta dijabarkan pada Pasal 5, meliputi :\n\npenyusunan dan perumusan kebijakan penanaman modal dan pelayanan terpadu satu pintu;\npelaksanaan kebijakan penanaman modal dan pelayanan terpadu satu pintu;\nfasilitasi pembinaan reformasi birokrasi Dinas;\npenyusunan kebijakan proses bisnis Dinas;\npengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik dalam lingkup Dinas;\npelaksanaan administrasi Dinas Penanaman Modal Dan Pelayanan Terpadu Satu Pintu;\npelaksanaan dan penataan pelayanan perizinan; perizinan berusaha; dan non perizinan\npelaksanaan tata kelola penanaman modal\npelaksanaan evaluasi dan pelaporan penanaman modal dan pelayanan terpadu satu pintu;\npelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi dinas.', 2, '2024-11-22 03:10:22', '2024-11-29 01:03:25', 'dpmptsp', 28, 'pending', NULL, 0, NULL),
(43, 'Dinas Perpustakaan dan Arsip Daerah', 'Berdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 91 Tahun 2021 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi dan Tata Kerja Dinas Perpustakaan dan Arsip Daerah, (Pasal 4) Dinas mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang perpustakaan dan urusan pemerintahan bidang kearsipan.\n\nUntuk melaksanakan tugas sebagaimana dimaksud Dinas Perpustakaan dan Arsip Daerah DIY mempunyai fungsi :\n\n1. Penyusunan program kerja Dinas.\n2. Perumusan kebijakan teknis bidang perpustakaan dan kearsipan.\n3. Pelaksanaan koordinasi, pembinaan, pengawasan dan pengendalian bidang kearsipan kabupaten/kota.\n4. Pelaksanaan koordinasi bidang perpustakaan kabupaten/kota.\n5. Pengelolaan, pelestarian, dan pemanfaatan bahan pustaka dan arsip.\n6. Pembinaan perpustakaan Perangkat Daerah.\n7. Pembinaan dan fasilitasi perpustakaan dan kearsipan pada Satuan Pendidikan Menengah dan Sekolah Luar Biasa di lingkungan Pemerintah Daerah.\n8. Fasilitasi penyelenggaraan urusan perpustakaan dan kearsipan Pemerintah Kabupaten/Kota.\n9. Pengelolaan arsip sesuai ketentuan peraturan perundang-undangan.\n10. Pembinaan dan pengawasan kearsipan pada pencipta arsip di lingkungan Pemerintah Daerah dan lembaga kearsipan daerah kabupaten/kota.\n11. Pelindungan, pelestarian, pengembangan, pemanfaatan bahan pustaka dan dokumen/arsip sebagai warisan budaya.\n12. Fasilitasi pengelolaan bahan pustaka dan arsip kasultanan dan kadipaten.\n13. Pemberdayaan sumberdaya dan mitra kerja bidang perpustakaan dan kearsipan.\n14. Pelayanan perpustakaan dan kearsipan.\n15. Pembinaan jabatan fungsional pustakawan dan arsiparis di lingkungan Pemerintah Daerah.\n16. Penyelenggaraan kegiatan kesekretariatan.\n17. Pelaksanaan koordinasi, pembinaan, dan pengawasan urusan pemerintahan bidang perpustakaan dan kearsipan yang menjadi kewenangan kabupaten/kota.\n18. Pemantauan, pengevaluasian, dan pelaporan pelaksanaan kebijakan bidang perpustakaan dan kearsipan.\n19. Pelaksanaan dekonsentrasi dan tugas pembantuan.\n20. Penyusunan laporan pelaksanaan tugas Dinas.\n21. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.', 2, '2024-11-22 03:11:29', '2024-11-29 01:09:02', 'dpad', 29, 'pending', NULL, 0, NULL),
(44, 'Dinas Pertanahan dan Tata Ruang', 'Dinas Pertanahan dan Tata Ruang (Kundha Niti Mandala Sarta Tata Sasana) Daerah Istimewa Yogyakarta dibentuk berdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 19 Tahun 2020 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Dinas Pertanahan dan Tata Ruang.', 2, '2024-11-29 01:17:40', '2024-11-29 01:27:59', 'dispertaru', 30, 'pending', NULL, 0, NULL),
(45, 'Dinas Pertanian dan Ketahanan Pangan', 'Dinas Pertanian dan Ketahanan Pangan Daerah Istimewa Yogyakarta dibentuk berdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 95 Tahun 2022 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Dinas Pertanian dan Ketahanan Pangan', 2, '2024-11-29 01:28:47', '2025-02-11 08:10:45', 'dpkp', 31, 'approved', NULL, 9, NULL),
(46, 'Dinas Sosial', 'Berdasarkan Peraturan Gubernur Nomor 106 Tahun 2022 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi dan Tata kerja Dinas Sosial, di Bab III Pasal 4 dan 5, Tugas dan Fungsi Dinas yaitu:', 2, '2024-11-29 01:53:57', '2025-01-31 15:52:18', 'dissos', 32, 'approved', NULL, 2, NULL),
(47, 'Dinas Tenaga Kerja dan Transmigrasi DIY', 'Selamat Datang di Halaman Wiki Dinas Tenaga Kerja dan Transmigrasi Daerah Istimewa Yogyakarta \nBerlokasi di Jl. Ring Road Utara Meguwo, Maguwoharjo, Kec. Depok, Kabupaten Sleman,\nDaerah Istimewa Yogyakarta 55282\n\n(0274) 885147 disnakertrans@jogjaprov.go.id\n\nBerdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 93 Tahun 2022 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi dan Tata Kerja Dinas Tenaga Kerja dan Transmigrasi', 2, '2024-11-29 01:55:28', '2024-11-29 01:55:28', 'disnakertrans', 33, 'pending', NULL, 0, NULL),
(48, 'Inspektorat', 'Inspektorat mempunyai tugas membantu Gubernur dalam melaksanakan pembinaan dan pengawasan pelaksanaan urusan pemerintahan yang menjadi kewenangan Pemerintah Daerah dan tugas pembantuan oleh Perangkat Daerah.\n\nDalam melaksanakan tugas Inspelrtorat mempunyai fungsi:\n\n1. Perencanaan program kerja Inspektorat\n2. Perumusan kebljakan dan fasilitasi pengawasan\n3. Pembinaan dan pengawasan terhadap pelaksanaan urusan pemerintahan daerah\n4. Pengawasan pelaksanaan urusan keistimewaan\n5. Pemeriksaan, pengusutan, pengujian, dan penilaian tugas pengawasan\n6. Pelaksanaan koordinasi pencegahan tindak pidana korupsi\n7. Pengawasan pelaksanaan program reformasi birokrasi\n8. Pemantauan, pengevaluasian dan pelaporan pelaksanaan pengawasan\n9. Pengoordinasian, pembinaan dan pengawasan atas penyelenggaraan pemerintahan daerah Kabupaten/Kota, dan pelaksanaan urusan pemerintahan di daerah Kabupaten/Kota\n10. Pengoordinasian, pembinaan dan pengawasan urusan pemerintahan di bidang pengawasan penyelenggaraan pemerintahan di daerah yang menjadi kewenangan Pemerintah Kabupaten/ Kota\n11. Penyelenggaraan kegiatan kesekretariatan\n12. Fasilitasi pembinaan reformasi birokrasi Inspektorat\n13. Fasilitasi penyusunan kebijakan proses bisnis Inspektorat\n14. Pengembangan teknologi informasi dal komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elelrtronik dalam lingkup Inspektorat\n15. Penyusunan laporan pelaksanaan tugas Inspektorat\n16. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Inspektorat', 2, '2024-11-29 01:58:46', '2025-02-11 08:11:31', 'inspektorat', 34, 'approved', NULL, 1, NULL),
(49, 'Paniradya Kaistimewan', 'Paniradya Kaistimewanmempunyai tugas membantu dan bertanggung jawabkepadaGubernur melalui Sekretaris Daerah dalam penyusunan kebijakan urusan keistimewaan, perencanaan, dan pengendalian urusan keistimewaan serta pengoordinasian administrasiurusan keistimewaan.\n\nUntuk melaksanakan tugas tersebut Paniradya Kaistimewan mempunyai fungsi:\n\n1. Perumusan Program Kerja Paniradya Kaistimewan;\n2. Pengordinasian Penyusunan Kebijakan Urusan Keistimewaan\n3. Pengkoordinasian Penyusunan Perencanaan Program Keistimewaan;\n4. Penyelenggaraan Pembinaan Di Bidang Perencanaan Programkeistimewaan;\n5. Penyelenggaraan Pengendalian Program Keistimewaan;\n6. Penyelenggaraan Kegiatan Kesekretariatan;\n7. Fasilitasi dan Koordinasi Pelaksanaan Hubungan Antar Lembaga;\n8. Penyelenggaraan Pelayanan Parampara Praja;\n9. Penyusunan Laporan Pelaksanaan Tugas Paniradya Kaistimewan; dan\n10. Pelaksanaan Tugas Lain Yang Diberikan Oleh Gubernur Sesuai Dengantugasdanfungsi Paniradya Kaistimewan.\n\nTugas dan Fungsi masing-masing bagian di Paniradya Kaistimewan berdasarkan Peraturan Gubernur DIY Nomor 20 Tahun 2020 adalah sebagai berikut :\n\n- Bagian Pelayanan dan Umum\nBagian Pelayanan dan Umum mempunyai tugas menyelenggarakanpelayananParampara Praja, hubungan antar lembaga, ketatausahaan, penyusunanprogram, kepegawaian, pengelolaan keuangan, rumah tangga, perlengkapan, ketatausahaan, pemantauan, evaluasi serta pelaporan kinerja Paniradya Kaistimewan.\n\n- Bidang Perencanaan dan Pengendalian Urusan Keistimewaan\nBidang Perencanaan dan Pengendalian Urusan Keistimewaan mempunyai tugasmelaksanakan penyusunan kebijakan perencanaan dan pengendalian programkegiatanurusan keistimewaan untuk meningkatkan capaian realisasi pelaksanaanprogramkeistimewaan.\n\n- Bidang Urusan Kebudayaan\nBidang Urusan Kebudayaan mempunyai tugas melaksanakan penyusunan kebijakan perencanaan dan pengendalian program kegiatan keistimewaan urusan kebudayaanuntuk meningkatkan capaian program yang berkualitas.\n\n- Bidang Urusan Tata Cara Pengisian Jabatan Gubernur dan Wakil Gubernur, Kelembagaan, Pertanahan dan Tata Ruang\nBidang Urusan Tata Cara Pengisian Jabatan Gubernur dan Wakil Gubernur, Kelembagaan, Pertanahan dan Tata Ruang mempunyai tugas melaksanakan penyusunankebijakanperencanaan dan pengendalian program kegiatan urusan keistimewaan bidangtatacarapengisian jabatan Gubernur dan Wakil Gubernur, kelembagaan, pertanahandantataruang untuk meningkatkan capaian program urusan keistimewaan urusan kelembagaandan tata cara, dan urusan pertanahan dan tata ruang yang berkualitas.\n\n\n\nSalah satu cara untuk mewujudkan keistimewaan DIY tersebut di Bidang Kelembagaan, pada tanggal 30 Juli 2018 disahkan Peraturan Daerah Istimewa DaerahIstimewaYogyakarta Nomor 1 tahun 2018 tentang Kelembagaan Pemerintah DaerahDaerahIstimewa Yogyakarta. Perdais tersebut telah mereduksi sekretariat ParamparaPrajamenjadi bagian dari lembaga baru yaitu Paniradya Kaistimewan dan selanjutnyafungsifasilitasinya dilaksanakan oleh Sub. Bagian Pelayanan Parampara Praja yang secararincitugas dan fungsinya telah diatur dalam Peraturan Gubernur DIY Nomor 51 Tahun2018Tentang Kedudukan, Struktur Organisasi, Tugas, Fungsi dan Tata Kerja PaniradyaKaistimewan. Sedangkan Parampara Praja merupakan organisasi non struktural yangberkedudukan dan bertanggungjawab kepada Gubernur dan secara administratifdikoordinasikan oleh Sekretaris Daerah melalui Paniradya Kaistimewan. Parampara Praja mempunyai tugas memberikan pertimbangan, saran danpendapatkepada Gubernur DIY dalam rangka penyelenggaraan urusan keistimewaan, baikdiminta maupun tidak diminta gubernur', 2, '2024-11-29 02:02:56', '2025-01-31 03:59:48', 'paniradya', 35, 'approved', NULL, 2, NULL),
(50, 'Satuan Polisi Pamong Praja', 'PERATURAN GUBERNUR DAERAH ISTIMEWA YOGYAKARTA\n\nNOMOR 100 TAHUN 2022\n\nTENTANG KEDUDUKAN, SUSUNAN ORGANISASI, TUGAS, FUNGSI DAN TATA KERJA SATUAN POLISI PAMONG PRAJA', 2, '2024-11-29 02:04:12', '2025-02-05 04:47:57', 'satpol-pp', 36, 'approved', NULL, 1, NULL),
(51, 'Sekretariat Dewan Perwakilan Rakyat Daerah', 'TUGAS DAN FUNGSI SEKRETARIAT DPRD DIY\n\n(Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 90 Tahun 2022)', 2, '2024-11-29 02:06:47', '2025-02-05 08:49:42', 'setwan', 37, 'pending', NULL, 6, NULL),
(52, 'Dinas Sosial', 'aa', 2, '2024-12-04 07:43:17', '2025-01-23 07:44:05', 'a', 13, 'approved', NULL, 0, NULL),
(53, 'Dinas kesehatan 2', 'berikut adalah halaman dinas kesehatan', 2, '2024-12-19 02:13:29', '2025-02-11 07:49:38', 'diskess', 19, 'approved', NULL, 9, NULL),
(57, 'halo', '<p>halo2 bismillah</p>', 9, '2025-01-14 08:19:34', '2025-01-14 08:19:34', 'bismillah', 10, 'approved', NULL, 0, NULL),
(58, 'halo', '<p>ddd</p>', 9, '2025-01-14 08:21:31', '2025-01-14 08:21:31', 'ddd', 10, 'approved', NULL, 0, NULL),
(59, 'pp', '<p>pp</p>', 9, '2025-01-14 08:37:43', '2025-01-14 08:37:43', 'pp', 10, 'approved', NULL, 0, NULL),
(60, 'bismillah', '<p>bismillah</p>', 9, '2025-01-14 08:41:28', '2025-02-05 01:47:10', 'bismillah', 10, 'approved', NULL, 1, NULL),
(61, 'bismillah', '<p>bismillah</p>', 9, '2025-01-14 08:44:41', '2025-01-14 08:44:41', '22', 10, 'approved', NULL, 0, NULL),
(62, 'p', '<p>p</p>', 9, '2025-01-14 08:47:10', '2025-01-14 08:47:10', 'p', 10, 'approved', NULL, 0, NULL),
(63, 'dinas 2', '<p>addd</p>', 2, '2025-01-15 03:01:36', '2025-02-01 10:09:03', 'aff', 15, 'approved', NULL, 2, NULL),
(64, 'halo', '<h1>halo</h1><ol><li>dc</li><li>fc</li></ol>', 9, '2025-01-15 04:07:49', '2025-02-12 13:46:42', 'ww', 10, 'approved', NULL, 1, NULL),
(65, 'cobacoba ', '<p>bismillah</p>', 2, '2025-01-15 04:28:07', '2025-01-20 03:05:14', 'aa', 14, 'approved', NULL, 0, NULL),
(66, 'bisimillah2', '<p>bismillah</p>', 2, '2025-01-15 04:37:16', '2025-02-02 14:34:04', 'ss', 18, 'approved', NULL, 1, NULL),
(67, 'fds g', '<p>fds</p>', 2, '2025-01-15 04:44:25', '2025-02-05 04:48:28', 'ds', 18, 'approved', NULL, 11, NULL),
(68, 'gg', '<p>approve</p>', 2, '2025-01-15 04:49:00', '2025-01-15 04:49:00', 'app', 15, 'approved', NULL, 0, NULL),
(69, 'halo', '<p>halo</p>', 2, '2025-01-15 04:55:58', '2025-01-15 04:55:58', 'halo', 37, 'approved', NULL, 0, NULL),
(72, 'coba adnim', NULL, 2, '2025-01-15 07:16:47', '2025-02-05 04:48:32', 'coan', 6, 'approved', NULL, 4, NULL),
(73, 'COBA123', NULL, 2, '2025-01-15 07:53:44', '2025-01-15 07:53:44', 'CC', 18, 'approved', NULL, 0, NULL),
(74, 'coba124', NULL, 2, '2025-01-15 07:59:23', '2025-01-19 14:06:41', 'c124', 18, 'approved', NULL, 0, NULL),
(76, 'jdjd', '<p>dndjd</p>', 2, '2025-01-15 08:13:16', '2025-01-22 03:07:30', 'jd', 18, 'approved', '2025-01-22 03:07:30', 0, NULL),
(79, 'lll', '<p>lll</p>', 9, '2025-01-21 06:31:43', '2025-01-29 01:51:00', 'lll', 10, 'approved', '2025-01-29 08:51:00', 0, NULL),
(80, 'haloasn', '<p>halo</p>', 9, '2025-01-23 03:08:24', '2025-02-04 01:36:43', 'ss', 10, 'approved', NULL, 1, NULL),
(81, '222', '<p>222</p>', 2, '2025-01-23 03:10:01', '2025-01-24 07:11:34', '222', 19, 'approved', '2025-01-24 14:11:34', 0, NULL),
(82, 'd', '<p>d</p>', 2, '2025-01-23 06:40:56', '2025-01-23 06:40:56', 'd', 19, 'approved', NULL, 0, NULL),
(83, 'aa', '<p>a</p>', 9, '2025-01-23 06:59:14', '2025-01-29 02:03:30', 'a', 10, 'approved', '2025-01-29 09:03:30', 0, NULL),
(84, 'b', '<p>tt</p>', 9, '2025-01-23 07:06:39', '2025-01-29 01:48:09', 'b', 10, 'approved', NULL, 0, NULL),
(85, 'c test', '<p>c</p>', 9, '2025-01-23 07:06:57', '2025-01-29 01:38:43', 'c', 10, 'approved', '2025-01-29 08:38:43', 0, NULL),
(86, 'd', '<p>d</p>', 9, '2025-01-23 07:07:13', '2025-01-28 01:38:32', 'd', 10, 'approved', '2025-01-28 08:38:32', 0, NULL),
(87, 'bbdbd', '<p>dhdhdh</p>', 9, '2025-01-23 07:21:29', '2025-01-28 01:08:58', 'hdhd', 10, 'approved', '2025-01-28 08:08:58', 0, NULL),
(88, 'wdjxn ', '<p>dhsxjn</p>', 9, '2025-01-23 07:21:40', '2025-01-28 01:08:53', 'ied', 10, 'approved', '2025-01-28 08:08:53', 0, NULL),
(89, 'djd', '<p>djdd</p>', 9, '2025-01-23 07:23:14', '2025-01-28 01:06:18', 'dd', 10, 'approved', '2025-01-28 08:06:18', 0, NULL),
(90, 'hbdbcx', '<p>dbejs</p>', 9, '2025-01-23 07:24:37', '2025-01-28 01:04:46', 'dhsn', 10, 'approved', '2025-01-28 08:04:46', 0, NULL),
(91, 'fff', '<p>ffff</p>', 9, '2025-01-23 07:26:24', '2025-01-24 07:15:50', 'fff', 10, 'approved', '2025-01-24 14:15:50', 0, NULL),
(92, 'rrrrrrr', '<p>rrrrrr</p>', 9, '2025-01-23 07:28:15', '2025-01-24 07:12:38', 'rrrr', 10, 'approved', '2025-01-24 14:12:38', 0, NULL),
(93, 'bbb', '<p>bb</p>', 9, '2025-01-23 07:37:32', '2025-01-23 07:37:41', 'bb', 10, 'rejected', NULL, 0, NULL),
(94, 'reject', '<p>reject</p>', 9, '2025-01-23 07:57:46', '2025-01-23 07:58:39', 'r', 10, 'rejected', NULL, 0, NULL),
(95, 'testing', '<p>tesr</p>', 9, '2025-01-29 01:37:54', '2025-01-29 01:44:00', 'ffff', 10, 'approved', NULL, 0, NULL),
(96, 'test2', NULL, 9, '2025-01-29 01:44:31', '2025-01-29 01:44:41', 'fff', 10, 'rejected', NULL, 0, NULL),
(97, 'testtttt', '<p>ff2</p>', 16, '2025-01-29 01:48:41', '2025-02-05 01:47:01', 'ffff', 11, 'approved', NULL, 1, NULL),
(98, 'gggg', '<p>gggg</p>', 14, '2025-01-29 01:56:13', '2025-02-05 16:24:01', 'gggg', 12, 'rejected', NULL, 21, 'kurang detail'),
(99, 'create test', '<p>fff h12b</p>', 2, '2025-01-29 02:00:24', '2025-02-02 16:50:18', 'ct', 1, 'pending', NULL, 18, NULL),
(100, 'ttttt', '<p>tttttt</p>', 14, '2025-01-29 02:22:55', '2025-02-04 03:56:51', 'ttt', 12, 'approved', NULL, 1, NULL),
(101, 'ttferwt', '<p>etreftg</p>', 14, '2025-01-29 02:23:04', '2025-02-05 16:18:22', 'hehg', 12, 'rejected', NULL, 2, 'banyak plagiat'),
(102, 'gg', '<p>ggg23</p>', 20, '2025-01-29 02:26:28', '2025-01-29 02:32:30', 'ggg', 15, 'approved', '2025-01-29 09:32:30', 0, NULL),
(103, 'dddfff', '<p>1234</p>', 13, '2025-01-29 02:31:43', '2025-01-29 08:31:18', 'df', 17, 'approved', '2025-01-29 15:31:18', 0, NULL),
(104, 'fgdfdf', '<p>dfdfdf</p>', 14, '2025-01-29 02:37:44', '2025-02-05 16:19:50', 'dfdf', 12, 'rejected', NULL, 4, 'konten anda tidak jelas'),
(105, 'halo', '<p>aaaa</p>', 14, '2025-01-29 08:30:18', '2025-01-29 08:37:47', 'a', 12, 'approved', NULL, 0, NULL),
(106, 'ddsd', '<p>sfcdsf</p>', 14, '2025-01-29 08:38:03', '2025-01-29 08:47:06', 'sdfsdf', 12, 'approved', NULL, 0, NULL),
(107, 'afsfa', '<p>asfafa</p>', 14, '2025-01-29 08:38:10', '2025-01-29 08:47:13', 'asffa', 12, 'rejected', NULL, 0, NULL),
(108, 'asfasfas', '<p>asfasfas</p>', 14, '2025-01-29 08:38:17', '2025-01-29 08:38:26', 'asfaf', 12, 'rejected', NULL, 0, NULL),
(109, 'newtt', NULL, 16, '2025-01-29 08:41:36', '2025-01-29 08:42:17', 'ff', 11, 'approved', '2025-01-29 15:42:17', 0, NULL),
(110, 'fewfwf', '<p>wedwftgf11212</p>', 24, '2025-01-29 08:44:52', '2025-01-29 08:45:10', 'werrw', 17, 'approved', NULL, 0, NULL),
(111, 'ffgaku', '<p>akuaku</p>', 26, '2025-01-29 08:45:38', '2025-02-03 06:48:49', '3rd', 12, 'pending', NULL, 4, NULL),
(112, 'n123', NULL, 14, '2025-01-29 08:48:25', '2025-01-29 08:48:56', '111', 12, 'rejected', NULL, 0, NULL),
(113, 'hhhao', '<p>dd</p>', 2, '2025-01-29 08:52:41', '2025-01-29 08:53:20', 'efwe', 1, 'approved', '2025-01-29 15:53:20', 0, NULL),
(114, 'ddd', '<p>ddd</p>', 14, '2025-01-29 08:56:25', '2025-02-03 06:39:28', 'ddd', 12, 'pending', NULL, 0, NULL),
(115, 'sdsd', '<p>sdsds</p>', 13, '2025-01-29 08:59:14', '2025-01-29 08:59:43', 'dd', 17, 'approved', '2025-01-29 15:59:43', 0, NULL),
(116, 'aaa', '<p>aaa</p>', 30, '2025-01-29 09:01:35', '2025-01-29 09:01:35', 'a', 13, 'approved', NULL, 0, NULL),
(117, 'Updated Title', 'Updated body content', 14, '2025-01-29 09:02:11', '2025-02-05 16:09:46', 'updated-tag', 1, 'approved', NULL, 0, NULL),
(118, 'cc', '<p>cc</p>', 14, '2025-01-29 09:02:18', '2025-01-29 09:03:13', 'c', 12, 'approved', NULL, 0, NULL),
(119, 'R22', '<p>222b</p>', 14, '2025-01-29 15:43:30', '2025-02-02 16:23:25', '22', 12, 'approved', NULL, 15, NULL),
(120, 'coba reject berhasil', '<p>berhasil</p>', 14, '2025-02-02 13:05:49', '2025-02-05 08:54:25', 'bb', 12, 'rejected', NULL, 9, 'konten anda banyak plagiat'),
(121, 'coba test edit', '<p>hhhp42343</p>', 14, '2025-02-02 15:57:16', '2025-02-04 02:06:47', 'cbd', 12, 'approved', '2025-02-04 09:06:47', 34, 'melanggar'),
(122, 'test terr', '<p>666</p>', 14, '2025-02-02 15:57:32', '2025-02-11 08:11:39', 'tret', 12, 'approved', NULL, 9, 'salah'),
(123, 'ss', '<p>ss</p>', 13, '2025-02-02 16:27:06', '2025-02-02 16:27:06', 'ss', 17, 'approved', NULL, 1, NULL),
(124, 's2', '<p>s234</p>', 14, '2025-02-02 16:28:21', '2025-02-05 04:48:20', 's2', 12, 'approved', NULL, 11, NULL),
(125, 'ddfwedf', '<p><br></p>', 14, '2025-02-02 16:36:25', '2025-02-02 16:54:59', 'efwwec', 12, 'approved', NULL, 16, 'salah'),
(126, 'lkk', '<p>xx</p>', 13, '2025-02-02 16:55:55', '2025-02-05 04:48:13', 'k', 16, 'approved', NULL, 6, NULL),
(127, 'kaki', '<p>fff</p>', 14, '2025-02-02 17:09:33', '2025-02-05 16:09:44', 'ff', 12, 'approved', NULL, 4, 'mendo'),
(128, 'kaki 255 anjay', '<p>f</p>', 14, '2025-02-02 17:12:03', '2025-02-12 07:51:20', 'ff', 12, 'approved', NULL, 20, 'dewfef'),
(129, 'sqsq', '<p>sq2</p>', 14, '2025-02-02 17:16:23', '2025-02-05 16:09:42', 'qs', 12, 'approved', NULL, 24, 'jhfhfhdhfh'),
(130, 'cooooo', '<p>gg bb</p>', 14, '2025-02-03 12:07:18', '2025-02-03 12:09:38', 'co', 12, 'approved', NULL, 11, 'gfg'),
(131, 'g barui 2', NULL, 13, '2025-02-03 12:09:52', '2025-02-04 08:15:33', 'gdg', 17, 'approved', NULL, 7, NULL),
(132, 'rtgeg', '<p>ergeg</p>', 14, '2025-02-03 12:10:16', '2025-02-04 03:29:07', 'ger', 12, 'approved', NULL, 3, NULL),
(133, 'dwd kk1', '<p>wdwe</p>', 14, '2025-02-03 12:14:02', '2025-02-04 03:34:47', 'wdw', 12, 'approved', NULL, 17, 'ddd'),
(134, 'benar 1', '<p>bb</p>', 14, '2025-02-03 13:26:09', '2025-02-05 04:57:36', 'b', 12, 'approved', NULL, 6, 'fwfw'),
(135, 'lkknvhgb   3', '<p>ddvvv</p>', 13, '2025-02-03 13:35:09', '2025-02-05 06:49:14', 'kk', 15, 'approved', NULL, 89, NULL),
(136, 'kckckc', '<p>ckck</p>', 14, '2025-02-04 02:05:54', '2025-02-04 03:23:33', 'cjckck', 12, 'approved', '2025-02-04 10:23:33', 3, NULL),
(137, 'ckcck', '<p>c</p>', 16, '2025-02-04 02:29:40', '2025-02-04 02:30:33', 'cc', 11, 'approved', '2025-02-04 09:30:33', 9, NULL),
(138, 'bb', '<p>bb</p>', 2, '2025-02-04 02:39:22', '2025-02-04 02:41:32', 'bb', 1, 'approved', '2025-02-04 09:41:32', 10, NULL),
(139, 'apt', NULL, 2, '2025-02-04 03:08:29', '2025-02-04 03:08:50', 'ppp', 1, 'approved', '2025-02-04 10:08:50', 2, NULL),
(140, 'b', '<p>a</p>', 13, '2025-02-04 03:53:11', '2025-02-04 03:53:38', 'ba', 18, 'approved', '2025-02-04 10:53:38', 7, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `content_edit_history`
--

CREATE TABLE `content_edit_history` (
  `id` int NOT NULL,
  `content_id` int DEFAULT NULL,
  `editor_id` int DEFAULT NULL,
  `edited_at` datetime DEFAULT NULL,
  `action` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `content_edit_history`
--

INSERT INTO `content_edit_history` (`id`, `content_id`, `editor_id`, `edited_at`, `action`) VALUES
(17, 65, 2, '2025-01-20 10:05:14', 'Approving'),
(18, 76, 2, '2025-01-20 10:19:52', 'Editing'),
(19, 26, 2, '2025-01-21 11:57:05', 'Approving'),
(20, 27, 2, '2025-01-21 11:58:07', 'Approving'),
(21, 79, 9, '2025-01-21 13:31:43', 'Createing'),
(22, 80, 9, '2025-01-23 10:08:24', 'Creating'),
(23, 80, 2, '2025-01-23 10:09:42', 'Approving'),
(24, 81, 2, '2025-01-23 10:10:01', 'Creating'),
(25, 26, 2, '2025-01-23 11:47:27', 'Editing'),
(26, 82, 2, '2025-01-23 13:40:56', 'Creating'),
(27, 83, 9, '2025-01-23 13:59:14', 'Creating'),
(28, 83, 2, '2025-01-23 13:59:47', 'Approving'),
(29, 46, 2, '2025-01-23 14:00:02', 'Approving'),
(30, 84, 9, '2025-01-23 14:06:39', 'Creating'),
(31, 85, 9, '2025-01-23 14:06:57', 'Creating'),
(32, 86, 9, '2025-01-23 14:07:13', 'Creating'),
(33, 86, 2, '2025-01-23 14:08:53', 'Approving'),
(34, 85, 2, '2025-01-23 14:09:13', 'Rejecting'),
(35, 84, 2, '2025-01-23 14:10:45', 'Approving'),
(36, 45, 2, '2025-01-23 14:14:13', 'Approving'),
(37, 79, 2, '2025-01-23 14:16:48', 'Approving'),
(38, 63, 2, '2025-01-23 14:17:28', 'Approving'),
(39, 53, 2, '2025-01-23 14:20:41', 'Approving'),
(40, 87, 9, '2025-01-23 14:21:29', 'Creating'),
(41, 88, 9, '2025-01-23 14:21:40', 'Creating'),
(42, 88, 2, '2025-01-23 14:21:57', 'Approving'),
(43, 87, 2, '2025-01-23 14:21:59', 'Rejecting'),
(44, 89, 9, '2025-01-23 14:23:14', 'Creating'),
(45, 89, 2, '2025-01-23 14:23:35', 'Rejecting'),
(46, 90, 9, '2025-01-23 14:24:37', 'Creating'),
(47, 90, 2, '2025-01-23 14:24:47', 'Rejecting'),
(48, 91, 9, '2025-01-23 14:26:24', 'Creating'),
(49, 91, 2, '2025-01-23 14:26:43', 'Rejecting'),
(50, 92, 9, '2025-01-23 14:28:15', 'Creating'),
(51, 92, 2, '2025-01-23 14:28:26', 'Rejecting'),
(52, 93, 9, '2025-01-23 14:37:32', 'Creating'),
(53, 93, 2, '2025-01-23 14:37:41', 'Rejecting'),
(54, 52, 2, '2025-01-23 14:44:05', 'Approving'),
(55, 94, 9, '2025-01-23 14:57:46', 'Creating'),
(56, 94, 2, '2025-01-23 14:58:39', 'Rejecting'),
(57, 14, 2, '2025-01-23 15:15:37', 'Editing'),
(58, 81, 7, '2025-01-24 13:58:11', 'Editing'),
(59, 81, 7, '2025-01-24 13:58:20', 'Editing'),
(60, 81, 7, '2025-01-24 14:11:42', 'Deleting'),
(61, 92, 7, '2025-01-24 14:12:39', 'Deleting'),
(62, 91, 7, '2025-01-24 14:15:50', 'Deleting'),
(63, 90, 13, '2025-01-28 08:04:51', 'Deleting'),
(64, 89, 13, '2025-01-28 08:06:21', 'Deleting'),
(65, 88, 13, '2025-01-28 08:08:53', 'Deleting'),
(66, 87, 13, '2025-01-28 08:08:58', 'Deleting'),
(67, 86, 13, '2025-01-28 08:38:32', 'Deleting'),
(68, 85, 9, '2025-01-29 08:36:09', 'Editing'),
(69, 85, 9, '2025-01-29 08:36:37', 'Editing'),
(70, 85, 9, '2025-01-29 08:37:19', 'Editing'),
(71, 85, 9, '2025-01-29 08:37:22', 'Editing'),
(72, 95, 9, '2025-01-29 08:37:54', 'Creating'),
(73, 85, 9, '2025-01-29 08:38:43', 'Deleting'),
(74, 95, 9, '2025-01-29 08:44:00', 'Approving'),
(75, 96, 9, '2025-01-29 08:44:31', 'Creating'),
(76, 96, 9, '2025-01-29 08:44:41', 'Rejecting'),
(77, 84, 16, '2025-01-29 08:48:09', 'Editing'),
(78, 97, 16, '2025-01-29 08:48:41', 'Creating'),
(79, 97, 16, '2025-01-29 08:49:57', 'Editing'),
(80, 97, 16, '2025-01-29 08:50:14', 'Editing'),
(81, 97, 16, '2025-01-29 08:50:17', 'Editing'),
(82, 79, 16, '2025-01-29 08:51:00', 'Deleting'),
(83, 48, 16, '2025-01-29 08:55:04', 'Approving'),
(84, 98, 14, '2025-01-29 08:56:13', 'Creating'),
(85, 98, 16, '2025-01-29 08:57:51', 'Rejecting'),
(86, 97, 2, '2025-01-29 09:00:00', 'Editing'),
(87, 99, 2, '2025-01-29 09:00:24', 'Creating'),
(88, 99, 2, '2025-01-29 09:01:29', 'Editing'),
(89, 99, 2, '2025-01-29 09:01:48', 'Editing'),
(90, 99, 2, '2025-01-29 09:01:56', 'Editing'),
(91, 99, 2, '2025-01-29 09:03:02', 'Editing'),
(92, 83, 2, '2025-01-29 09:03:30', 'Deleting'),
(93, 49, 2, '2025-01-29 09:20:58', 'Approving'),
(94, 100, 14, '2025-01-29 09:22:55', 'Creating'),
(95, 101, 14, '2025-01-29 09:23:04', 'Creating'),
(96, 101, 2, '2025-01-29 09:23:17', 'Rejecting'),
(97, 102, 20, '2025-01-29 09:26:28', 'Creating'),
(98, 102, 20, '2025-01-29 09:26:33', 'Editing'),
(99, 102, 13, '2025-01-29 09:31:20', 'Editing'),
(100, 103, 13, '2025-01-29 09:31:43', 'Creating'),
(101, 102, 13, '2025-01-29 09:31:58', 'Editing'),
(102, 102, 13, '2025-01-29 09:32:18', 'Editing'),
(103, 102, 13, '2025-01-29 09:32:30', 'Deleting'),
(104, 100, 13, '2025-01-29 09:36:32', 'Approving'),
(105, 104, 14, '2025-01-29 09:37:44', 'Creating'),
(106, 104, 13, '2025-01-29 09:37:59', 'Rejecting'),
(107, 99, 13, '2025-01-29 13:47:37', 'Editing'),
(108, 99, 13, '2025-01-29 13:48:14', 'Editing'),
(109, 105, 14, '2025-01-29 15:30:18', 'Creating'),
(110, 103, 14, '2025-01-29 15:30:45', 'Editing'),
(111, 103, 14, '2025-01-29 15:31:18', 'Deleting'),
(112, 105, 14, '2025-01-29 15:37:47', 'Approving'),
(113, 106, 14, '2025-01-29 15:38:03', 'Creating'),
(114, 107, 14, '2025-01-29 15:38:10', 'Creating'),
(115, 108, 14, '2025-01-29 15:38:17', 'Creating'),
(116, 108, 14, '2025-01-29 15:38:26', 'Rejecting'),
(117, 109, 16, '2025-01-29 15:41:36', 'Creating'),
(118, 109, 16, '2025-01-29 15:41:55', 'Editing'),
(119, 109, 16, '2025-01-29 15:42:17', 'Deleting'),
(120, 110, 24, '2025-01-29 15:44:52', 'Creating'),
(121, 110, 24, '2025-01-29 15:45:00', 'Approving'),
(122, 111, 26, '2025-01-29 15:45:38', 'Creating'),
(123, 106, 16, '2025-01-29 15:47:06', 'Approving'),
(124, 107, 16, '2025-01-29 15:47:13', 'Rejecting'),
(125, 112, 14, '2025-01-29 15:48:25', 'Creating'),
(126, 112, 16, '2025-01-29 15:48:56', 'Rejecting'),
(127, 113, 2, '2025-01-29 15:52:41', 'Creating'),
(128, 113, 2, '2025-01-29 15:52:58', 'Editing'),
(129, 113, 2, '2025-01-29 15:53:20', 'Deleting'),
(130, 50, 2, '2025-01-29 15:55:27', 'Approving'),
(131, 114, 14, '2025-01-29 15:56:25', 'Creating'),
(132, 114, 2, '2025-01-29 15:56:47', 'Rejecting'),
(133, 115, 13, '2025-01-29 15:59:14', 'Creating'),
(134, 115, 13, '2025-01-29 15:59:27', 'Editing'),
(135, 115, 13, '2025-01-29 15:59:43', 'Deleting'),
(136, 116, 30, '2025-01-29 16:01:35', 'Creating'),
(137, 117, 14, '2025-01-29 16:02:11', 'Creating'),
(138, 118, 14, '2025-01-29 16:02:18', 'Creating'),
(139, 118, 13, '2025-01-29 16:03:13', 'Approving'),
(140, 117, 13, '2025-01-29 16:03:26', 'Rejecting'),
(141, 119, 16, '2025-01-29 22:44:06', 'Approving'),
(142, 15, 13, '2025-02-01 17:07:36', 'Editing'),
(143, 15, 13, '2025-02-01 17:08:06', 'Editing'),
(144, 99, 13, '2025-02-01 17:14:48', 'Editing'),
(145, 14, 13, '2025-02-01 20:48:43', 'Editing'),
(146, 14, 13, '2025-02-01 21:41:09', 'Editing'),
(147, 111, 13, '2025-02-01 22:34:15', 'Editing'),
(148, 120, 13, '2025-02-02 20:06:23', 'Rejecting'),
(149, 121, 13, '2025-02-02 22:57:56', 'Rejecting'),
(150, 121, 13, '2025-02-02 23:13:15', 'Approving'),
(151, 120, 13, '2025-02-02 23:15:35', 'Approving'),
(152, 121, 13, '2025-02-02 23:23:07', 'Editing'),
(153, 121, 13, '2025-02-02 23:23:12', 'Editing'),
(154, 120, 13, '2025-02-02 23:23:33', 'Editing'),
(155, 123, 13, '2025-02-02 23:27:06', 'Creating'),
(156, 121, 13, '2025-02-02 23:27:16', 'Approving'),
(157, 124, 13, '2025-02-02 23:28:35', 'Approving'),
(158, 124, 13, '2025-02-02 23:28:43', 'Editing'),
(159, 121, 13, '2025-02-02 23:31:23', 'Approving'),
(160, 121, 13, '2025-02-02 23:31:31', 'Editing'),
(161, 121, 13, '2025-02-02 23:31:31', 'Editing'),
(162, 124, 13, '2025-02-02 23:31:53', 'Approving'),
(163, 124, 13, '2025-02-02 23:32:07', 'Editing'),
(164, 122, 13, '2025-02-02 23:32:30', 'Rejecting'),
(165, 125, 13, '2025-02-02 23:36:54', 'Rejecting'),
(166, 125, 13, '2025-02-02 23:44:54', 'Approving'),
(167, 125, 13, '2025-02-02 23:45:45', 'Approving'),
(168, 99, 13, '2025-02-02 23:49:11', 'Approving'),
(169, 99, 13, '2025-02-02 23:49:33', 'Approving'),
(170, 125, 13, '2025-02-02 23:53:22', 'Approving'),
(171, 126, 13, '2025-02-02 23:55:55', 'Creating'),
(172, 126, 13, '2025-02-02 23:56:06', 'Editing'),
(173, 127, 13, '2025-02-03 00:09:49', 'Rejecting'),
(174, 128, 13, '2025-02-03 00:14:56', 'Rejecting'),
(175, 129, 13, '2025-02-03 00:20:42', 'Rejecting'),
(176, 129, 13, '2025-02-03 11:08:11', 'Rejecting'),
(177, 129, 14, '2025-02-03 12:16:46', 'Approving'),
(178, 128, 14, '2025-02-03 12:17:21', 'Rejecting'),
(179, 128, 14, '2025-02-03 12:18:31', 'Rejecting'),
(180, 128, 13, '2025-02-03 13:20:34', 'Rejecting'),
(181, 128, 13, '2025-02-03 13:50:06', 'Rejecting'),
(182, 128, 14, '2025-02-03 13:56:43', 'Rejecting'),
(183, 130, 14, '2025-02-03 19:07:18', 'Creating'),
(184, 130, 13, '2025-02-03 19:07:40', 'Rejecting'),
(185, 130, 13, '2025-02-03 19:08:35', 'Rejecting'),
(186, 130, 13, '2025-02-03 19:09:21', 'Approving'),
(187, 130, 13, '2025-02-03 19:09:31', 'Editing'),
(188, 131, 13, '2025-02-03 19:09:52', 'Creating'),
(189, 132, 14, '2025-02-03 19:10:16', 'Creating'),
(190, 133, 14, '2025-02-03 19:14:02', 'Creating'),
(191, 133, 13, '2025-02-03 19:14:20', 'Rejecting'),
(192, 132, 13, '2025-02-03 19:14:27', 'Approving'),
(193, 133, 13, '2025-02-03 19:15:34', 'Rejecting'),
(194, 133, 13, '2025-02-03 19:17:44', 'Approving'),
(195, 133, 14, '2025-02-03 19:18:07', 'Editing'),
(196, 14, 14, '2025-02-03 19:18:21', 'Editing'),
(197, 134, 14, '2025-02-03 20:26:09', 'Creating'),
(198, 134, 13, '2025-02-03 20:26:27', 'Rejecting'),
(199, 134, 13, '2025-02-03 20:27:21', 'Approving'),
(200, 135, 13, '2025-02-03 20:35:09', 'Creating'),
(201, 135, 13, '2025-02-03 20:35:20', 'Editing'),
(202, 135, 2, '2025-02-04 09:13:55', 'Editing'),
(203, 135, 14, '2025-02-04 09:16:26', 'Editing'),
(204, 135, 16, '2025-02-04 09:29:09', 'Editing'),
(205, 137, 16, '2025-02-04 09:29:40', 'Creating'),
(206, 137, 16, '2025-02-04 09:29:57', 'Editing'),
(207, 137, 16, '2025-02-04 09:30:05', 'Editing'),
(208, 137, 16, '2025-02-04 09:30:17', 'Editing'),
(209, 137, 16, '2025-02-04 09:30:33', 'Deleting'),
(210, 135, 16, '2025-02-04 09:33:20', 'Editing'),
(211, 136, 16, '2025-02-04 09:33:38', 'Approving'),
(212, 129, 16, '2025-02-04 09:33:51', 'Rejecting'),
(213, 15, 2, '2025-02-04 09:38:42', 'Editing'),
(214, 15, 2, '2025-02-04 09:38:50', 'Editing'),
(215, 138, 2, '2025-02-04 09:39:22', 'Creating'),
(216, 138, 2, '2025-02-04 09:40:58', 'Editing'),
(217, 138, 2, '2025-02-04 09:41:32', 'Deleting'),
(218, 139, 2, '2025-02-04 10:08:29', 'Creating'),
(219, 139, 2, '2025-02-04 10:08:50', 'Deleting'),
(220, 136, 2, '2025-02-04 10:23:33', 'Deleting'),
(221, 135, 2, '2025-02-04 10:25:51', 'Editing'),
(222, 128, 2, '2025-02-04 10:26:12', 'Approving'),
(223, 127, 2, '2025-02-04 10:26:30', 'Rejecting'),
(224, 133, 2, '2025-02-04 10:34:47', 'Editing'),
(225, 131, 2, '2025-02-04 10:35:07', 'Editing'),
(226, 135, 13, '2025-02-04 10:35:30', 'Editing'),
(227, 14, 13, '2025-02-04 10:36:15', 'Editing'),
(228, 140, 13, '2025-02-04 10:53:11', 'Creating'),
(229, 140, 13, '2025-02-04 10:53:24', 'Editing'),
(230, 140, 13, '2025-02-04 10:53:38', 'Deleting'),
(231, 67, 13, '2025-02-04 10:57:01', 'Editing'),
(232, 126, 13, '2025-02-04 10:59:40', 'Approving'),
(233, 120, 13, '2025-02-04 10:59:54', 'Rejecting'),
(234, 27, 13, '2025-02-05 08:12:15', 'Editing'),
(235, 14, 13, '2025-02-05 10:48:17', 'Editing'),
(236, 120, 13, '2025-02-05 15:54:25', 'Rejecting'),
(237, 129, 13, '2025-02-05 23:09:42', 'Approving'),
(238, 127, 13, '2025-02-05 23:09:44', 'Approving'),
(239, 117, 13, '2025-02-05 23:09:46', 'Approving'),
(240, 104, 13, '2025-02-05 23:18:10', 'Rejecting'),
(241, 101, 13, '2025-02-05 23:18:22', 'Rejecting'),
(242, 98, 13, '2025-02-05 23:18:35', 'Rejecting'),
(243, 27, 13, '2025-02-11 14:49:49', 'Editing');

-- --------------------------------------------------------

--
-- Table structure for table `instance`
--

CREATE TABLE `instance` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instance`
--

INSERT INTO `instance` (`id`, `name`) VALUES
(1, 'Dinas Komunikasi dan Informatika DIY'),
(2, 'Badan Kepegawaian Daerah'),
(3, 'Badan Kesatuan Bangsa dan Politik'),
(4, 'Badan Penanggulangan Bencana Daerah'),
(5, 'Badan Pendidikan dan Pelatihan'),
(6, 'Badan Pengelola Keuangan dan Aset'),
(7, 'Badan Penghubung Daerah'),
(8, 'Badan Perencanaan Pembangunan Daerah'),
(9, 'Biro Administrasi Perekonomian dan Sumber Daya Alam'),
(10, 'Biro Bina Mental Spiritual'),
(11, 'Biro Bina Pemberdayaan Masyarakat'),
(12, 'Biro Hukum'),
(13, 'Biro Organisasi'),
(14, 'Biro Pengembangan Infrastruktur Wilayah dan Pembiayaan Pembangunan'),
(15, 'Biro Tata Pemerintahan'),
(16, 'Biro Umum, Hubungan Masyarakat dan Protokol\r\n'),
(17, 'Dinas Kebudayaan (Kundha Kabudayan)'),
(18, 'Dinas Kelautan dan Perikanan'),
(19, 'Dinas Kesehatan'),
(20, 'Dinas Koperasi dan Usaha Kecil Menengah'),
(21, 'Dinas Lingkungan Hidup dan Kehutanan'),
(22, 'Dinas Pariwisata'),
(23, 'Dinas Pekerjaan Umum, Perumahan dan Energi Sumber Daya Mineral'),
(24, 'Dinas Pemberdayaan Perempuan, Perlindungan Anak dan Pengendalian Penduduk'),
(25, 'Dinas Pendidikan, Pemuda dan Olahraga'),
(26, 'Dinas Perhubungan'),
(27, 'Dinas Perindustrian dan Perdagangan'),
(28, 'Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu'),
(29, 'Dinas Perpustakaan dan Arsip Daerah'),
(30, 'Dinas Pertanahan dan Tata Ruang (Kundha Niti Mandala sarta Tata Sasana)'),
(31, 'Dinas Pertanian dan Ketahanan Pangan'),
(32, 'Dinas Sosial'),
(33, 'Dinas Tenaga Kerja dan Transmigrasi'),
(34, 'Inspektorat'),
(35, 'Paniradya Kaistimewan'),
(36, 'Satuan Polisi Pamong Praja'),
(37, 'Sekretariat Dewan Perwakilan Rakyat Daerah');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `description`) VALUES
(1, 'view_contents', 'Permission ini mengizinkan pengguna untuk mendapatkan id dan Title dari semua konten yang sudah di approve'),
(2, 'view_drafts', 'Permission ini mengizinkan pengguna untuk melihat semua konten yang berstatus pending (draft)'),
(3, 'search_contents', 'Permission ini mengizinkan pengguna untuk mencari konten berdasarkan kata kunci (search term)'),
(4, 'view_content', 'Permission ini mengizinkan pengguna untuk melihat detail konten berdasarkan ID, termasuk informasi penulis dan subheading, serta mencatat jumlah tampilan'),
(5, 'edit_content', 'Permission ini mengizinkan pengguna untuk mengedit konten berdasarkan ID, memperbarui informasi konten seperti judul, deskripsi, instance, dan tag, serta memperbarui subheading terkait dengan konten tersebut'),
(6, 'create_content', 'Permission ini mengizinkan pengguna untuk membuat konten baru dalam sistem'),
(7, 'create_subheading', 'Permission ini mengizinkan pengguna untuk membuat subheading baru yang terkait dengan konten yang sudah ada'),
(8, 'delete_subheading', 'Permission ini mengizinkan pengguna untuk menghapus subheading berdasarkan ID yang diberikan'),
(9, 'delete_content', 'Permission ini mengizinkan pengguna untuk menghapus konten berdasarkan ID yang diberikan'),
(10, 'view_user_contents', 'Permission ini mengizinkan pengguna untuk melihat daftar konten yang dibuat oleh seorang penulis'),
(11, 'view_instances', 'Permission ini mengizinkan pengguna untuk melihat semua data instance (seperti ID dan nama) yang tersimpan dalam database'),
(12, 'view_user', 'Permission ini mengizinkan pengguna untuk melihat detail informasi pengguna berdasarkan ID, termasuk nama, NIP, email, peran, dan instance'),
(13, 'view_all_users', 'Permission ini mengizinkan pengguna untuk melihat daftar semua pengguna yang ada dalam sistem, lengkap dengan informasi terkait seperti nama, NIP, email, peran, dan instance'),
(14, 'view_roles', 'Permission ini mengizinkan pengguna untuk melihat daftar semua peran (roles) yang tersedia dalam sistem'),
(15, 'create_user', 'Permission ini mengizinkan pengguna untuk membuat pengguna baru'),
(16, 'edit_user', 'Permission ini mengizinkan pengguna untuk mengedit data pengguna'),
(17, 'delete_user', 'Permission ini mengizinkan pengguna untuk menghapus data pengguna'),
(18, 'add_history', 'Permission ini mengizinkan pengguna untuk mencatat riwayat perubahan konten'),
(19, 'view_history_user', 'Permission ini mengizinkan pengguna untuk melihat histori perubahan konten yang dilakukan oleh pengguna'),
(20, 'view_latest_editor', 'Permission ini mengizinkan pengguna untuk melihat nama editor terakhir yang mengedit konten'),
(21, 'approve_content', 'Permission ini mengizinkan pengguna untuk mengubah status konten (Approve)'),
(22, 'reject_content', 'Permission ini mengizinkan pengguna untuk mengubah status konten menjadi \"rejected\" (Menolak pengajuan konten) dengan alasan tertentu'),
(23, 'manage_role', 'Permission ini mengizinkan pengguna untuk mengambil daftar seluruh permission yang tersedia'),
(24, 'view_active_content', 'Permission ini mengizinkan pengguna untuk melihat daftar konten yang belum dihapus dengan status \"approved\"'),
(25, 'view_permission', 'Permission ini mengizinkan pengguna untuk melihat daftar izin (permissions) berdasarkan peran (role) mereka.'),
(26, 'view_role_permission', 'Permission ini memungkinkan pengguna tertentu untuk menampilkan izin (permissions) dari peran (role) mereka sesuai dengan yang diminta.'),
(27, 'add_permission', 'Permission ini mengizinkan pengguna untuk menambahkan izin (permission) ke dalam peran (role) berdasarkan ID role dan ID permission yang diberikan'),
(28, 'remove_permission', 'Permission ini mengizinkan pengguna untuk menghapus izin (permission) ke dalam peran (role) berdasarkan ID role dan ID permission yang diberikan'),
(29, 'view_contents_notReject', 'Permission ini mengizinkan pengguna untuk melihat semua konten yang belum ditolak berdasarkan ID dan judul, termasuk informasi penulis, deskripsi, status, dan jumlah tampilan.'),
(30, 'resubmit_content', 'Permission ini mengizinkan pengguna untuk mengirim ulang konten yang ditolak setelah dilakukan pembaruan, dengan memperbarui statusnya menjadi \"pending\" dan mencatat pembaruan yang dilakukan.');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'Admin'),
(2, 'Manajer Konten'),
(3, 'Pengguna Terdaftar (ASN)'),
(4, 'Pengguna Tidak Terdaftar'),
(5, 'Superadmin');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(1, 2),
(2, 2),
(5, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3),
(1, 4),
(2, 4),
(3, 4),
(4, 4),
(5, 4),
(1, 5),
(2, 5),
(3, 5),
(5, 5),
(1, 6),
(2, 6),
(3, 6),
(5, 6),
(1, 7),
(2, 7),
(3, 7),
(5, 7),
(1, 8),
(2, 8),
(3, 8),
(5, 8),
(1, 9),
(2, 9),
(3, 9),
(5, 9),
(3, 10),
(4, 10),
(1, 11),
(2, 11),
(3, 11),
(4, 11),
(5, 11),
(1, 12),
(2, 12),
(3, 12),
(5, 12),
(1, 13),
(5, 13),
(1, 14),
(2, 14),
(3, 14),
(5, 14),
(1, 15),
(2, 15),
(3, 15),
(5, 15),
(1, 16),
(2, 16),
(3, 16),
(5, 16),
(1, 17),
(2, 17),
(3, 17),
(5, 17),
(1, 18),
(2, 18),
(3, 18),
(4, 18),
(5, 18),
(1, 19),
(2, 19),
(3, 19),
(5, 19),
(1, 20),
(2, 20),
(3, 20),
(4, 20),
(5, 20),
(1, 21),
(2, 21),
(5, 21),
(1, 22),
(2, 22),
(5, 22),
(5, 23),
(1, 24),
(2, 24),
(3, 24),
(4, 24),
(5, 24),
(1, 25),
(2, 25),
(3, 25),
(5, 25),
(1, 26),
(3, 26),
(5, 26),
(5, 27),
(5, 28),
(1, 29),
(3, 29),
(5, 29),
(1, 30),
(3, 30),
(5, 30);

-- --------------------------------------------------------

--
-- Table structure for table `subheadings`
--

CREATE TABLE `subheadings` (
  `id` int NOT NULL,
  `content_id` int NOT NULL,
  `subheading` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `subheading_description` text COLLATE utf8mb4_general_ci NOT NULL,
  `author_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subheadings`
--

INSERT INTO `subheadings` (`id`, `content_id`, `subheading`, `subheading_description`, `author_id`, `created_at`, `updated_at`) VALUES
(29, 14, 'Profil ', '<p>Berdasarkan Peraturan Gubernur DIY Nomor 113 Tahun 2022 tentang tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi dan Tata Kerja Dinas Komunikasi dan Informatika DIY, tugas dan fungsi Diskominfo DIY sebagai berikut:</p>', 2, '2024-11-01 02:54:15', '2025-02-05 03:48:34'),
(30, 14, 'Tugas', '<p>Dinas Komunikasi dan Informatika mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang komunikasi dan informatika dan urusan pemerintahan bidang persandian.</p>', 2, '2024-11-01 02:54:15', '2025-02-05 03:48:34'),
(31, 14, 'Fungsi', '<ol><li>Penyusunan program kerja Dinas;</li><li>Perumusan kebijakan teknis bidang komunikasi dan informatika serta urusan persandian;</li><li>Pelayanan pengelolaan informasi dan komunikasi publik;</li><li>Penyelenggaraan ekosistem provinsi cerdas;</li><li>Penyelenggaraan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik;</li><li>Pelayanan keamanan informasi dan persandian;</li><li>Fasilitasi integrasi data dan informasi elektronik;</li><li>Pelaksanaan koordinasi, pembinaan, dan pengawasan urusan pemerintahan bidang komunikasi dan informatika dan persandian yang menjadi kewenangan Pemerintah Kabupaten/Kota;</li><li>Pelaksanaan kegiatan kesekretariatan;</li><li>Pelaksanaan dekonsentrasi dan tugas pembantuan;</li><li>Fasilitasi pembinaan reformasi birokrasi Dinas;</li><li>Fasilitasi penyusunan kebijakan proses bisnis Dinas;</li><li>Pemantauan, evaluasi, dan penyusunan laporan pelaksanaan kebijakan bidang komunikasi informatika dan persandian;</li><li>Penyusunan laporan pelaksanaan tugas Dinas;</li><li>Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas</li></ol>', 2, '2024-11-01 02:54:15', '2025-02-05 03:48:34'),
(32, 14, 'Layanan', '<p>Diskominfo DIY berkomitmen memberikan layanan TIK untuk seluruh OPD Pemda DIY dan masyarakat guna mendukung tercapainya Rencana Pembangunan DIY di berbagai sektor.</p><ol><li>Rekomendasi SPBE</li><li>Sistem Penghubung Layanan Pemerintah Daerah</li><li>Informasi Eksekutif</li><li>Layanan permintaan informasi (PPID Utama)</li><li>Layanan permintaan informasi (PPID Pembantu)</li><li>Alur Pengajuan Hosting dan Domain</li><li>Email OPD</li><li>Jaringan Komunikasi</li><li>Keamanan Informasi</li><li>Penyimpanan Awan</li><li>Tanda tangan Elektronik OPD</li><li>Jaringan Intra Pemerintah</li><li>Jogjagovroam</li><li>Virtual Private Network (VPN) OPD 15. Saluran informasi digital 16. Gangguan TIK</li></ol>', 2, '2024-11-01 02:54:15', '2025-02-05 03:48:34'),
(33, 15, 'Tugas', '<p>Sesuai Peraturan Gubernur DIY Nomor 101 Tahun 2022 Tentang KEDUDUKAN, SUSUNAN ORGANISASI, TUGAS, FUNGSI, DAN TATA KERJA BADAN KEPEGAWAIAN DAERAH, Badan Kepegawaian Daerah mempunyai tugas melaksanakan fungsi penunjang urusan pemerintahan di bidang kepegawaian daerah</p>', 2, '2024-11-01 03:01:07', '2025-02-04 03:29:28'),
(34, 15, 'Fungsi', '<p>Untuk melaksanakan tugas sebagaimana dimaksud dalam Pasal 4, Badan Kepegawaian Daerah mempunyai fungsi:</p><p>1. Penyusunan program kerja Badan;</p><p>2. Perumusan kebijakan teknis bidang kepegawaian;</p><p>3. Penyelenggaraan pemerintahan daerah di bidang kepegawaian;</p><p>4. Pembinaan dan pelaksanaan tugas di bidang kepegawaian;</p><p>5. Penilaian dan sertifikasi kompetensi pegawai;</p><p>6. Pemberian fasilitasi penyelenggaraan kepegawaian Pemerintah Kabupaten / Kota;</p><p>7. Pelaksanaan kegiatan kesekretariatan;</p><p>8. Fasilitasi pembinaan reformasi birokrasi Badan;</p><p>9. Fasilitasi penyusunan kebijakan proses bisnis Badan;</p><p>10. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik dalam lingkup Badan; 11. Pemantauan, pengevaluasian dan pelaporan pelaksanaan kebijakan bidang kepegawaian; 12. Fasilitasi kesekretariatan Dewan Pengurus Korps Pegawai Negeri Republik Indonesia /Korps Profesi Pegawai Aparatur Sipil Negara Daerah Istimewa Yogyakarta; 13. Pelaksanaan dekonsentrasi dan tugas pembantuan; 14. Pelaksanaan koordinasi, pembinaan dan pengawasan fungsi penunjang urusan pemerintahan bidang kepegawaian yang menjadi kewenangan kabupaten/ kota; dan 15. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Badan.</p>', 2, '2024-11-01 03:01:07', '2025-02-04 03:29:28'),
(35, 15, 'Struktur Organisasi', '<p>1. Kepala Badan; 2. Sekretariat; 3. Bidang Perencanaan Pengadaan dan Sistem Informasi Pegawai; 4. Bidang Pengembangan Pegawai; 5. Bidang Kedudukan Hukum dan Kesejahteraan Pegawai; 6. Bidang Administrasi Kepegawaian; 7. Balai Pengukuran Kompetensi Pegawai; 8. Kelompok Jabatan Fungsional.</p>', 2, '2024-11-01 03:01:07', '2025-02-04 03:29:28'),
(36, 15, 'Ruang Lingkup Kegiatan', '<p>Ruang lingkup Badan Kepegawaian Daerah Daerah Istimewa Yogyakarta meliputi: 1. Penempatan PNS dalam jabatan; 2. Penyusunan Daftar Susunan Pegawai pada masing-masing SKPD; 3. Penyusunan dan Penetapan formasi PNS, CPNS dan Tenaga Bantu; 4. Pengadaan CPNS dan Tenaga Bantu; 5. Analisis dan Penyusunan Program Diklat; 6. Pengukuran Kompetensi Jabatan; 7. Evaluasi Kinerja; 8. Pengangkatan, Kepangkatan dan Pemindahan PNS; 9. Pemberhentian PNS; 10. Kesejahteraan PNS; 11. Pembinaan hak dan kewajiban serta penghargaan PNS; 12. Pengelolaan arsip dan dokumen kepegawaian; 13. Pengelolaan Sistem Informasi Manajemen Kepegawaian Daerah; 14. Pelayanan internal BKD.</p>', 2, '2024-11-01 03:01:07', '2025-02-04 03:29:28'),
(37, 16, 'TUGAS', 'Berdasarkan Peraturan Gubernur DIY Nomor 103 Tahun 2022 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi dan Tata Kerja Badan Kesatuan Bangsa dan Politik, Badan Kesatuan Bangsa dan Politik mempunyai tugas menyelenggarakan fungsi penunjang urusan pemerintahan bidang kesatuan bangsa dan politik. .', 2, '2024-11-01 03:06:42', '2024-11-01 03:11:44'),
(38, 16, 'FUNGSI', 'Badan Kesatuan Bangsa dan Politik mempunyai fungsi:\r\n\r\n1. Penyusunan program kerja Badan\r\n2. Perumusan kebijakan teknis dan pembinaan urusan bina ideologi, wawasan kebangsaan, karakter bangsa, politik dalam negeri, ketahanan ekonomi, sosial, budaya, agama, organisasi kemasyarakatan, penanganan konflik, dan kewaspadaan nasional\r\n3. Pelaksanaan fasilitasi dan koordinasi penyelenggaraan urusan bina ideologi, wawasan kebangsaan, karakter bangsa, politik dalam negeri, ketahanan ekonomi, sosial, budaya, agama, organisasi kemasyarakatan, penanganan konflik, dan kewaspadaan nasional\r\n4. Fasilitasi pembinaan reformasi birokrasi Badan\r\n5. Penyusunan kebijakan proses bisnis Badan\r\n6. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik dalam lingkup Badan\r\n7. Pelaksanaan koordinasi, pembinaan, dan pengawasarr urusan pemerintahan bidang kesatuan bangsa dan politik yang menjadi kewenangan Kabupaten/Kota\r\n8. Pelaksanaan dekonsentrasi dan tugas pembantuan\r\n9. Pemantauan, evaluasi, dan pelaporan pelaksanaan kebijakan bidang bina ideologi, wawasan kebangsaan, karakter bangsa, politik dalam negeri, ketahanan ekonomi, sosial, budaya, agama, organisasi kemasyarakatan, penanganan konflik, dan kewaspadaan nasional\r\n10. Penyelenggaraan kegiatan kesekretariatan\r\n11. Penyusunan laporan pelaksanaan tugas Badan\r\n12. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Badan.', 2, '2024-11-01 03:06:42', '2024-11-01 03:11:44'),
(56, 17, 'TUJUAN DAN SASARAN', 'Tujuan organisasi BAPPEDA DIY sebagaimana yang tertulis dalam Rencana Strategis Bappeda DIY  Tahun 2023-2026 (Peraturan Gubernur Nomor 8 Tahun 2022 tentang Rencana Strategis Perangkat Daerah Tahun 2023-2026)  adalah “Terwujudnya Perencanaan Pembangunan yang Berorientasi Hasil” Tujuan BAPPEDA DIY Terwujudnya Perencanaan Pembangunan yang Berorientasi Hasil mempunyai makna bahwa Bappeda DIY harus mampu mengarahkan perencanaan dan menjamin pelaksanaan program kegiatan dalam kerangka pencapaian tujuan Pemerintah Daerah DIY yang lebih mengedepankan hasil pembangunan untuk peningkatan kesejahteraan masyarakat. Selain itu, Bappeda DIY harus mampu menjadi pengendali pelaksanaan pembangunan daerah agar selaras dengan rencana yang ditetapkan.dengan sasaran yang akan dicapai adalah “Terwujudnya Integrasi, Sinkronisasi, dan Efektifitas Perencanaan Pembangunan ”.\r\n\r\nTujuan tersebut akan diwujudkan melalui 2 (dua) sasaran, yaitu: (1) Terwujudnya Integrasi, Sinkronisasi, dan Efektivitas Perencanaan Pembangunan;  dan (2) Meningkatnya Tata Kelola Penyelenggaraan Urusan Pemerintahan di Perangkat Daerah \r\n\r\nSasaran “Terwujudnya Integrasi, Sinkronisasi, dan Efektivitas Perencanaan Pembangunan”  bermakna bahwa Bappeda DIY harus mampu menjadi clearing house bagi perencanaan pembangunan di tingkat daerah untuk memastikan program-program yang dilaksanakan dalam kerangka mendukung capaian target tujuan dan sasaran dalam Rencana Pembangunan Daerah. Perencanaan yang disusun termasuk dalam menentukan strategi dan arah kebijakan pembangunan harus didasarkan pada pertimbangan-pertimbangan rasional serta sumber daya yang dimiliki. Sedangkan sasaran “Meningkatnya Tata Kelola Penyelenggaraan Urusan Pemerintahan di Perangkat Daerah” merupakan pendukung tercapainya perencanaan pembangunan yang berorientasi hasil. Bappeda DIY harus mampu memenuhi kriteria indeks Reformasi Birokrasi yang Baik. \r\n\r\nTujuan, sasaran  dan program Bappeda  dalam Renstra Bappeda mengacu pada Peraturan Gubernur Nomor 7 Tahun 2022 tentang Rencana Pembangunan Daerah Daerah Istimewa Yogyakarta 2023-2026. Keberhasilan dari tujuan Bappeda Terwujudnya Perencanaan Pembangunan yang Berorientasi Hasil dilihat dari ketercapaian tujuan Perangkat Daerah DIY, sedangkan keberhasil sasaran Terwujudnya Integrasi, Sinkronisasi, dan Efektivitas Perencanaan Pembangunan dilihat dari ketercapaian sasaran Perangkat Daerah DIY dan sasaran Meningkatnya Tata Kelola Penyelenggaraan Urusan Pemerintahan di Perangkat Daerah diwujudkan  dengan Kategori Reformasi Birokrasi Perangkat Daerah yang Baik.', 2, '2024-11-01 04:03:28', '2024-11-01 04:03:28'),
(57, 17, 'Tugas', 'Berdasarkan Peraturan Gubernur DIY Nomor 116 Tahun 2022 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Badan Perencanaan Pembangunan Daerah, Bappeda mempunyai tugas menyelenggarakan fungsi unsur penunjang urusan pemerintahan perencanaan, penelitian dan pengembangan serta urusan pemerintahan bidang statistik.', 2, '2024-11-01 04:05:18', '2024-11-01 04:05:18'),
(58, 17, 'Fungsi', 'Untuk melaksanakan tugas tesebut Bappeda mempunyai fungsi :\r\n\r\na.  penyusunan rencana kerja Badan;\r\n\r\nb.  perumusan kebijakan teknis perencanaan, penelitian dan pengembangan, serta bidang statistik; \r\n\r\nc.  pelaksanaan koordinasi penyusunan perencanaan, penelitian dan pengembangan, serta bidang statistik; \r\n\r\nd.  pembinaan dan pelaksanaan tugas perencanaan, penelitian dan pengembangan, serta bidang statistik; \r\n\r\ne.  penyelenggaraan pengendalian program pembangunan daerah; \r\n\r\nf.  pelaksanaan kebijakan perencanaan dan pengendalian pembangunan; \r\n\r\ng.  penyelenggaraan statistik daerah; \r\n\r\nh.  penyiapan bahan laporan pertanggungjawaban Gubernur dan laporan akuntabilitas kinerja Pemerintah Daerah; \r\n\r\ni.   penyelenggaraan kegiatan kesekretariatan; \r\n\r\nj.   pelaksanaan dekonsentrasi dan tugas pembantuan; \r\n\r\nk.  pembinaan reformasi birokrasi Badan; \r\n\r\nl.  penyusunan kebijakan proses bisnis Badan; \r\n\r\nm. pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik dalam lingkup Badan; \r\n\r\nn. pemantauan, evaluasi, dan penJrusunan laporan pelaksanaan kebijakan perencanaan pembangunan daerah, penelitian dan pengembangan, serta statistik; \r\n\r\no. pelaksanaan koordinasi pembinaan dan pengawasan urusan pemerintahan perencanaan pembangunan daerah KabupatenlKota; \r\n\r\np. penyusunan laporan pelaksanaan tugas Badan; dan \r\n\r\nq. pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Badan.', 2, '2024-11-01 04:05:18', '2024-11-01 04:05:18'),
(59, 17, 'Susunan Organisasi', 'a. Kepala Badan; \r\nb. Sekretariat, terdiri atas:  1. Subbagian Umum; dan  2. Subbagian Keuangan; \r\nc. Bidang Perencanaan; \r\nd. Bidang Pemerintahan; \r\ne. Bidang Perekonomian; \r\nf. Bidang Sosial Budaya; \r\ng. Bidang Sarana dan Prasarana; \r\nh. Bidang Pengendalian; \r\ni. Unit Pelaksana Teknis; dan \r\nj. Kelompok Jabatan Fungsional.', 2, '2024-11-01 04:05:18', '2024-11-01 04:05:18'),
(60, 17, 'Alamat dan Kontak', 'Kompleks Kepatihan, Danurejan, Yogyakarta\r\n(0274)589583, (0274)557418\r\n(0274)562811\r\n(0274)586712\r\nhttp://bappeda.jogjaprov.go.id\r\nbappeda@jogjaprov.go.id\r\n\r\nwebsite : https://bappeda.jogjaprov.go.id/\r\n\r\ninstagram: https://www.instagram.com/bappedadiy/\r\n\r\npermohonan informasi:  https://bappeda.jogjaprov.go.id/permohonan_informasi', 2, '2024-11-01 04:05:18', '2024-11-01 04:05:18'),
(61, 18, 'Tugas', 'Badan mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang pendidikan dan pelatihan.', 2, '2024-11-01 05:55:05', '2024-11-01 05:55:05'),
(62, 18, 'Fungsi', '1. Penyusunan program kerja Badan;\r\n2. Perumusan kebijakan teknis bidang pengembangan kompetensi dalam bentuk pelatihan;\r\n3. Pengembangan kompetensi melalui pelatihan teknis, fungsional, manajerial, dan sosia kultural ASN;\r\n4. Pelaksanaan kerjasama urusan bidang pelatihan;\r\n5. Pelaksanaan fasilitasi pelatihan bagi instansi/lembaga/provinsi, kabupaten/kota dalam dan luar DIY untuk pelaksanaan pelatihan;\r\n6. Pengkajian dan pengembangan pelatihan;\r\n7. Peningkatan standarisasi dan penjaminan mutu pelatihan;\r\n8. Pengelolaan dan pengembangan kapasitas perpustakaan;\r\n9. Pelaksanaan koordinasi, pembinaan, dan pengawasan kediklatan/pelatihan Kabupaten/Kota;\r\n10. Pelaksanaan kegiatan kesekretariatan;\r\n11. Pelaksanaan dekonsentrasi dan tugas pembantuan;\r\n12. Fasilitasi pembinaan reformasi birokrasi Badan;\r\n13. Fasilitasi penyusunan kebijakan proses bisnis Badan;\r\n14. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam sistem pemerintahan berbasis elektronik dalam lingkup Badan;\r\n15. Pemantauan, evaluasi, dan penyusunan laporan pelaksanaan kebijakan bidang pengembangan kompetensi dalam bentuk pelatihan;\r\n16. Penyusunan laporan pelaksanaan tugas Badan; dan\r\n17. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Badan.', 2, '2024-11-01 05:55:05', '2024-11-01 05:55:05'),
(63, 19, 'Tugas', 'Menyelenggarakan fungsi penunjang urusan pemerintahan bidang pendapatan, pengelolaan keuangan dan aset. ', 2, '2024-11-01 06:01:56', '2024-11-01 06:01:56'),
(64, 19, 'Fungsi', '1. Penyusunan rencana kerja Badan;\r\n2. Perumusan kebijakan teknis bidang pengelolaan anggaran pendapatan, anggaran belanja, pengelolaan kas daerah, akuntansi, dan pembinaan administrasi keuangan daerah, serta barang milik daerah;\r\n3. Pengelolaan pajak daerah, retribusi, dan pendapatan lain-lain, serta pendapatan transfer;\r\n4. Penyusunan Rencana Anggaran Pendapatan dan Belanja Daerah dan Pertanggungjawaban Anggaran Pendapatan dan Belanja Daerah;\r\n5. Pelaksanaan pengelolaan keuangan;\r\n6. Pelaksanaan pembinaan administrasi keuangan Kabupaten/Kota, Badan Layanan Umum Daerah, Badan Usaha Milik Daerah, dan dana non Anggaran Pendapatan dan Belanja Daerah;\r\n7. Pengelolaan kas daerah dan akuntansi;\r\n8. Pengelolaan barang milik daerah;\r\n9. Pelaksanaan dan tuntutan ganti rugi;\r\n10. Pemberdayaan sumber daya dan mitra kerja urusan keuangan dan pengelolaan barang milik daerah;\r\n11. Pelaksanaan kegiatan kesekretariatan;\r\n12. Pelaksanaan dekonsentrasi dan tugas pembantuan;\r\n13. Fasilitasi pembinaan reformasi birokrasi Badan;\r\n14. Fasilitasi penyusunan kebijakan proses bisnis Badan;\r\n15. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik dalam lingkup Badan;\r\n16. Pemantauan, evaluasi, dan penyusunan laporan pelaksanaan kebijakan bidang pengelolaan keuangan dan aset;\r\n17. Pelaksanaan koordinasi, pembinaan, dan/atau pengawasan urusan pemerintahan bidang keuangan yang menjadi kewenangan Kabupaten/Kota;\r\n18. Penyusunan laporan pelaksanaan tugas Badan; dan\r\n19. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Badan.', 2, '2024-11-01 06:01:56', '2024-11-01 06:01:56'),
(65, 19, 'Sistem Dan Prosedur', 'Peraturan Gubernur DIY Nomor 113 Tahun 2020 Tentang Sistem Dan Prosedur Pengelolaan Keuangan Daerah\r\nPeraturan Gubernur DIY Nomor 33 Tahun 2021 Tentang Perubahan Atas Peraturan Gubernur DIY Nomor 113 Tahun 2020 Tentang Sistem Dan Prosedur Pengelolaan Keuangan Daerah\r\nPeraturan Gubernur DIY Nomor 71 Tahun 2021 Tentang sistem akuntansi Pemerintah Daerah\r\nPeraturan Gubernur DIY Nomor 83 Tahun 2017 Pedoman sistem akuntansi Dan Pelaporan Keuangan Pada Badan Layanan Umum Daerah\r\nKeputusan Gubernur DIY Nomor 136/KEP/2020 Tentang Penetapan Status Penggunaan Barang Milik Daerah Pada Badan Pengelola Keuangan Dan Aset Daerah Istimewa Yogyakarta Tahun 2020\r\n- Sisdur Akuntansi\r\n  - Prosedur a\r\n  - Prosedur b\r\n- Sisdur Pendapatan\r\n  - Prosedur a\r\n  - Prosedur b\r\n- Sisdur Aset\r\n  - Prosedur a\r\n  - Prosedur b', 2, '2024-11-01 06:01:56', '2024-11-01 06:01:56'),
(66, 21, 'TUJUAN DAN SASARAN', 'Tujuan organisasi BAPPEDA DIY sebagaimana yang tertulis dalam Rencana Strategis Bappeda DIY  Tahun 2023-2026 (Peraturan Gubernur Nomor 8 Tahun 2022 tentang Rencana Strategis Perangkat Daerah Tahun 2023-2026)  adalah “Terwujudnya Perencanaan Pembangunan yang Berorientasi Hasil” Tujuan BAPPEDA DIY Terwujudnya Perencanaan Pembangunan yang Berorientasi Hasil mempunyai makna bahwa Bappeda DIY harus mampu mengarahkan perencanaan dan menjamin pelaksanaan program kegiatan dalam kerangka pencapaian tujuan Pemerintah Daerah DIY yang lebih mengedepankan hasil pembangunan untuk peningkatan kesejahteraan masyarakat. Selain itu, Bappeda DIY harus mampu menjadi pengendali pelaksanaan pembangunan daerah agar selaras dengan rencana yang ditetapkan.dengan sasaran yang akan dicapai adalah “Terwujudnya Integrasi, Sinkronisasi, dan Efektifitas Perencanaan Pembangunan ”.\r\n\r\nTujuan tersebut akan diwujudkan melalui 2 (dua) sasaran, yaitu: (1) Terwujudnya Integrasi, Sinkronisasi, dan Efektivitas Perencanaan Pembangunan;  dan (2) Meningkatnya Tata Kelola Penyelenggaraan Urusan Pemerintahan di Perangkat Daerah \r\n\r\nSasaran “Terwujudnya Integrasi, Sinkronisasi, dan Efektivitas Perencanaan Pembangunan”  bermakna bahwa Bappeda DIY harus mampu menjadi clearing house bagi perencanaan pembangunan di tingkat daerah untuk memastikan program-program yang dilaksanakan dalam kerangka mendukung capaian target tujuan dan sasaran dalam Rencana Pembangunan Daerah. Perencanaan yang disusun termasuk dalam menentukan strategi dan arah kebijakan pembangunan harus didasarkan pada pertimbangan-pertimbangan rasional serta sumber daya yang dimiliki. Sedangkan sasaran “Meningkatnya Tata Kelola Penyelenggaraan Urusan Pemerintahan di Perangkat Daerah” merupakan pendukung tercapainya perencanaan pembangunan yang berorientasi hasil. Bappeda DIY harus mampu memenuhi kriteria indeks Reformasi Birokrasi yang Baik. \r\n\r\nTujuan, sasaran  dan program Bappeda  dalam Renstra Bappeda mengacu pada Peraturan Gubernur Nomor 7 Tahun 2022 tentang Rencana Pembangunan Daerah Daerah Istimewa Yogyakarta 2023-2026. Keberhasilan dari tujuan Bappeda Terwujudnya Perencanaan Pembangunan yang Berorientasi Hasil dilihat dari ketercapaian tujuan Perangkat Daerah DIY, sedangkan keberhasil sasaran Terwujudnya Integrasi, Sinkronisasi, dan Efektivitas Perencanaan Pembangunan dilihat dari ketercapaian sasaran Perangkat Daerah DIY dan sasaran Meningkatnya Tata Kelola Penyelenggaraan Urusan Pemerintahan di Perangkat Daerah diwujudkan  dengan Kategori Reformasi Birokrasi Perangkat Daerah yang Baik.', 2, '2024-11-01 06:06:20', '2024-11-01 06:06:20'),
(67, 21, 'Tugas', 'Berdasarkan Peraturan Gubernur DIY Nomor 116 Tahun 2022 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Badan Perencanaan Pembangunan Daerah, Bappeda mempunyai tugas menyelenggarakan fungsi unsur penunjang urusan pemerintahan perencanaan, penelitian dan pengembangan serta urusan pemerintahan bidang statistik.', 2, '2024-11-01 06:06:20', '2024-11-01 06:06:20'),
(68, 21, 'Fungsi', 'Untuk melaksanakan tugas tesebut Bappeda mempunyai fungsi :\r\n\r\na.  penyusunan rencana kerja Badan;\r\n\r\nb.  perumusan kebijakan teknis perencanaan, penelitian dan pengembangan, serta bidang statistik; \r\n\r\nc.  pelaksanaan koordinasi penyusunan perencanaan, penelitian dan pengembangan, serta bidang statistik; \r\n\r\nd.  pembinaan dan pelaksanaan tugas perencanaan, penelitian dan pengembangan, serta bidang statistik; \r\n\r\ne.  penyelenggaraan pengendalian program pembangunan daerah; \r\n\r\nf.  pelaksanaan kebijakan perencanaan dan pengendalian pembangunan; \r\n\r\ng.  penyelenggaraan statistik daerah; \r\n\r\nh.  penyiapan bahan laporan pertanggungjawaban Gubernur dan laporan akuntabilitas kinerja Pemerintah Daerah; \r\n\r\ni.   penyelenggaraan kegiatan kesekretariatan; \r\n\r\nj.   pelaksanaan dekonsentrasi dan tugas pembantuan; \r\n\r\nk.  pembinaan reformasi birokrasi Badan; \r\n\r\nl.  penyusunan kebijakan proses bisnis Badan; \r\n\r\nm. pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik dalam lingkup Badan; \r\n\r\nn. pemantauan, evaluasi, dan penJrusunan laporan pelaksanaan kebijakan perencanaan pembangunan daerah, penelitian dan pengembangan, serta statistik; \r\n\r\no. pelaksanaan koordinasi pembinaan dan pengawasan urusan pemerintahan perencanaan pembangunan daerah KabupatenlKota; \r\n\r\np. penyusunan laporan pelaksanaan tugas Badan; dan \r\n\r\nq. pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Badan.', 2, '2024-11-01 06:06:20', '2024-11-01 06:06:20'),
(69, 21, 'Susunan Organisasi', 'a. Kepala Badan; \r\n\r\nb. Sekretariat, terdiri atas:  1. Subbagian Umum; dan  2. Subbagian Keuangan; \r\n\r\nc. Bidang Perencanaan; \r\n\r\nd. Bidang Pemerintahan; \r\n\r\ne. Bidang Perekonomian; \r\n\r\nf. Bidang Sosial Budaya; \r\n\r\ng. Bidang Sarana dan Prasarana; \r\n\r\nh. Bidang Pengendalian; \r\n\r\ni. Unit Pelaksana Teknis; dan \r\n\r\nj. Kelompok Jabatan Fungsional.', 2, '2024-11-01 06:06:20', '2024-11-01 06:06:20'),
(70, 21, 'Alamat dan Kontak', 'Kompleks Kepatihan, Danurejan, Yogyakarta\r\n(0274)589583, (0274)557418\r\n(0274)562811\r\n(0274)586712\r\nhttp://bappeda.jogjaprov.go.id\r\nbappeda@jogjaprov.go.id\r\n\r\nwebsite : https://bappeda.jogjaprov.go.id/\r\n\r\ninstagram: https://www.instagram.com/bappedadiy/\r\n\r\npermohonan informasi:  https://bappeda.jogjaprov.go.id/permohonan_informasi', 2, '2024-11-01 06:06:20', '2024-11-01 06:06:20'),
(71, 22, 'Sejarah Singkat', 'Biro Administrasi Perekonomian dan Sumber Daya Alam (Biro APSDA) Setda DIY merupakan instansi di bawah Sekretariat Daerah DIY yang berperan sebagai pendukung perumusan kebijakan strategis bidang perekonomian dan sumber daya alam di DIY. Berikut ini adalah sejarah singkat pembentukan Biro APSDA Setda DIY:\r\n\r\nLatar Belakang Pembentukan\r\nBiro APSDA Setda DIY dibentuk untuk mengoptimalkan fungsi koordinasi, sinkronisasi, dan harmonisasi dalam penyelenggaraan pemerintahan daerah khususnya di bidang perekonomian dan sumber daya alam. Biro APSDA Setda DIY juga bertujuan untuk meningkatkan kualitas pelayanan publik dan akuntabilitas kinerja instansi pemerintah daerah.\r\n\r\nTujuan Pembentukan\r\nBiro APSDA Setda DIY memiliki tujuan untuk melaksanakan fungsi pendukung perumusan kebijakan strategis bidang perekonomian dan sumber daya alam; melaksanakan fungsi pengelolaan administrasi umum, keuangan, kepegawaian, perlengkapan, dan rumah tangga; serta melaksanakan fungsi pengawasan internal dan evaluasi pelaksanaan kebijakan strategis bidang perekonomian dan sumber daya alam.\r\n\r\nDasar Hukum Pembentukan\r\nBiro APSDA Setda DIY dibentuk berdasarkan Peraturan Daerah Provinsi Daerah Istimewa Yogyakarta Nomor 5 Tahun 2008 Tentang Organisasi Dan Tata Kerja Sekretariat Daerah Dan Sekretariat Dewan Perwakilan Rakyat Daerah Provinsi Daerah Istimewa Yogyakarta.\r\n\r\nCakupan Kewenangan\r\nBiro APSDA Setda DIY memiliki kewenangan untuk melaksanakan tugas dan fungsi sesuai dengan peraturan perundang-undangan yang berlaku. Adapun tugas dan fungsi Biro APSDA Setda DIY meliputi: pengelolaan stabilitas perekonomian daerah; rekayasa perekonomian; pengelolaan sumber daya perekonomian; analisis kebijakan ekonomi hijau; analisis kebijakan perlindungan sumber daya alam; serta pengendalian inflasi daerah.\r\n\r\nRiwayat Struktur Organisasi\r\nPada saat pembentukan Biro APSDA Setda DIY memiliki struktur organisasi yang terdiri atas Kepala Biro, tiga bagian, dan enam sub bagian. Adapun susunan organisasi Biro APSDA Setda DIY adalah sebagai berikut:\r\n\r\n- Kepala Biro\r\n  - Bagian Pengelolaan Stabilitas Perekonomian Daerah\r\n    - Subbagian Pengendalian Inflasi Daerah\r\n    - Subbagian Analisis Kebijakan Percepatan Pemerataan Pembangunan Ekonomi Wilayah\r\n- Bagian Rekayasa Perekonomian\r\n  - Subbagian Analisis Kebijakan Pengembangan Ekonomi Daerah\r\n  - Subbagian Tata Usaha\r\n- Bagian Pengelolaan Sumber Daya Perekonomian\r\n  - Subbagian Analisis Kebijakan Ekonomi Hijau\r\n  - Subbagian Analisis Kebijakan Perlindungan Sumber Daya Alam\r\n\r\nStruktur organisasi terbaru menurut Peraturan Gubernur Nomor 105 Tahun 2022 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Sekretariat Daerah.Sumber Daya Alam terdiri atas:\r\n\r\n1. Kepala Biro\r\n2. Bagian Rekayasa Perekonomian, terdiri atas Seubbagian Tata Usaha; dan\r\n3. Kelompok Jabatan Fungsional', 2, '2024-11-01 06:13:29', '2024-11-01 06:13:29'),
(72, 22, 'Tugas Dan Fungsi', 'Tugas dan fungsi Biro Administrasi Perekonomian dan Sumber Daya Alam Setda DIY berdasarkan atas Peraturan Gubernur Nomor 105 Tahun 2022 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Sekretariat Daerah.\r\n\r\nBiro Administrasi Perekonomian dan .Sumber Daya Alam mempunyai tugas melaksanakan fungsi pendukung perumusan kebijakan strategis bidang perekonomian dan sumber daya alam.\r\n\r\nUntuk melaksanakan tugas tersebut, Biro Administrasi Perekonomian dan Sumber Daya Alam mempunyai fungsi:\r\n\r\n1. Penyusunan program kerja Biro;\r\n2. Penyusunan bahan perumusan kebijakan pengelolaan stabilitas perekonomian, rekayasa\r\nperekonomian, dan pengelolaan sumber daya perekonomian;\r\n3. Pengoordinasian perumusan kebijakan pengelolaan stabilitas perekonomian, rekayasa perekonomian, dan pengelolaan sumber daya perekonomian;\r\n4. Pemantauan dan evaluasi pelaksanaan kebijakan pengelolaan stabilitas perekonomian, rekayasa perekonomian, dan pengelolaan sumber daya perekonomian;\r\n5. Pengoordinasian rumusan bahan kebijakan strategis badan usaha milik daerah;\r\n6. Evaluasi rumusan bahan kebijakan strategis badan usaha milik daerah;\r\n7. Fasilitasi pembinaan reformasi birokrasi Biro;\r\n8. Fasilitasi penyusunan kebijakan proses bisnis Biro;\r\n9. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik;\r\n10. Penyusunan laporan pelaksanaan tugas Biro;\r\n11. Pelaksanaan kegiatan ketatausahaan; dan\r\n12. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Biro.', 2, '2024-11-01 06:13:29', '2024-11-01 06:13:29'),
(73, 22, 'Struktur Organisasi', 'Susunan organisasi Biro Administrasi Perekonomian dan Setda DIY menurut Peraturan Gubernur Nomor 105 Tahun 2022 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Sekretariat Daerah.Sumber Daya Alam terdiri atas:\r\n\r\n1. Kepala Biro\r\n2. Bagian Rekayasa Perekonomian, terdiri atas Seubbagian Tata Usaha; dan\r\n3. Kelompok Jabatan Fungsional\r\n\r\n', 2, '2024-11-01 06:13:29', '2024-11-01 06:13:29'),
(74, 22, 'Alamat dan Media Sosial', 'Biro Administrasi Perekonomian dan Setda DIY beralamat di:\r\n\r\nKompleks Kepatihan, Danurejan, Yogyakarta, Kode Pos 55213\r\n\r\nTelepon: (0274) 562811\r\n\r\nFaximile: (0274) 555460\r\n\r\nSurat Elektronik: biro.perekonomian@jogjaprov.go.id\r\n\r\nWebsite: biroperekonomian.jogjaprov.go.id\r\n\r\nInstagram: www.instagram.com/biroperekonomiandiy\r\n\r\nYoutube: https://www.youtube.com/channel/UCx5zr1FhOVvJ_cYWTehmlGw', 2, '2024-11-01 06:13:29', '2024-11-01 06:13:29'),
(75, 23, 'VISI', '“Terwujudnya Peningkatan Kemuliaan Martabat Manusia Jogja”', 2, '2024-11-01 06:23:52', '2024-12-05 08:55:08'),
(76, 23, 'MISI', '1. Meningkatkan kualitas hidup, kehidupan dan penghidupan masyarakat yang berkeadilan dan berkeadaban.\r\n2. Mewujudkan tata pemerintahan yang demokratis', 2, '2024-11-01 06:23:52', '2024-12-05 08:55:08'),
(77, 23, 'TUGAS', 'Melaksanakan fungsi pendukung perumusan kebijakan strategis bidang bina mental spiritual', 2, '2024-11-01 06:25:53', '2024-12-05 08:55:08'),
(78, 23, 'FUNGSI', '1. Penyusunan program kerja Biro;\r\n2. Penyiapan bahan kebijakan bidang kebijakan bidang bina mental spiritual, fasilitasi kehidupan beragama, kebudayaan, kesehatan masyarakat, pelayanan kesehatan, pendidikan, pemuda dan olahraga, serta perpustakaan kearsipan;\r\n3. Penyiapan bahan koordinasi perumusan kebijakan bidang bina mental spiritual, fasilitasi kehidupan beragama, kebudayaan, kesehatan masyarakat, pelayanan kesehatan, pendidikan, pemuda dan olahraga, serta perpustakaan kearsipan;\r\n4. Fasilitasi kehidupan beragama;\r\n5. Pelaksanaan pemantauan dan pengevaluasian pelaksanaan kebijakan bidang bina mental spiritual, fasilitasi kehidupan beragama, kebudayaan, kesehatan masyarakat, pelayanan kesehatan, pendidikan, pemuda dan olahraga, serta perpustakaan kearsipan;\r\n6. Pelaksanaan kegiatan ketatausahaan;\r\n7. Penyusunan laporan pelaksanaan tugas Biro;\r\n8. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Biro.', 2, '2024-11-01 06:25:53', '2024-12-05 08:55:08'),
(79, 24, 'TUGAS', 'Biro Bina Pemberdayaan Masyarakat Setda DIY sebagaimana dimaksud dalam pasal 194 ayat (1) Peraturan Gubernur Nomor 136 Tahun 2021 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Sekretariat Daerah mempunyai tugas melaksanakan fungsi pendukung perumusan kebijakan strategis dan pelaksanaan urusan pemberdayaan masyarakat dan desa.', 2, '2024-11-01 06:28:22', '2024-11-01 06:28:22'),
(80, 24, 'FUNGSI', 'Sesuai pasal 194 ayat (2) Peraturan Gubernur Nomor 136 Tahun 2021 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Sekretariat Daerah mempunyai fungsi antara lain:\r\n\r\n1. Penyusunan program kerja Biro Bina Pemberdayaan Masyarakat Setda DIY;\r\n2. Penyiapan bahan kebijakan bidang sosial, pemberdayaan perempuan, pelindungan anak, pengendalian penduduk dan keluarga berencana;\r\n3. Koordinasi perumusan kebijakan bidang sosial, pemberdayaan perempuan, pelindungan anak, pengendalian penduduk dan keluarga berencana;\r\n4. Fasilitasi pelaksanaan tugas bidang pengembangan sumber daya masyarakat, penguatan kelembagaan dan potensi masyarakat serta pemberdayaan;\r\n5. Pemantauan dan pengevaluasian pelaksanaan kebijakan bidang sosial, pemberdayaan perempuan, pelindungan anak, pengendalian penduduk, dan keluarga berencana;\r\n6. Pelaksanaan kegiatan ketatausahaan;\r\n7. Penyusunan laporan pelaksanaan tugas Biro; dan\r\n8. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Biro.', 2, '2024-11-01 06:28:22', '2024-11-01 06:28:22'),
(81, 25, 'Tugas', 'Melaksanakan fungsi pendukung perumusan kebijakan strategis bidang hukum.', 2, '2024-11-01 06:34:26', '2024-11-01 06:34:26'),
(82, 25, 'Fungsi', '1. Penyusunan program kerja Biro;\r\n2. Penyiapan bahan perumusan kebijakan bidang peraturan perundang-undangan, dokumentasi hukum, pembinaan dan pengawasan produk hukum kabupaten/kota, bantuan hukum, dan layanan hukum;\r\n3. Koordinasi pelaksanaan tugas dan wewenang Gubernur sebagai Wakil Pemerintah di bidang pembinaan dan pengawasan produk hukum Kabupaten/Kota;\r\n4. Pelaksanaan penelaahan, monitoring, dan evaluasi peraturan perundang-undangan;\r\n5. Pengelolaan sistem jaringan dokumentasi dan informasi hukum;\r\n6. Penataan produk hukum daerah;\r\n7. Fasilitasi penyesuaian peraturan di lingkungan Kasultanan dan Kadipaten;\r\n8. Pelaksanaan pembinaan dan pengawasan produk hukum kabupaten/kota;\r\n9. Penyiapan bahan pertimbangan dan bantuan hukum serta layanan hukum kepada Pemerintah Daerah;\r\n10. Fasilitasi pembinaan reformasi birokrasi Biro;\r\n11. Fasilitasi penyusunan kebijakan proses bisnis Biro;\r\n12. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik dalam lingkup Biro;\r\n13. Pelaksanaan pemantauan dan pengevaluasian pelaksanaan kebijakan bidang peraturan perundang-undangan, dokumentasi hukum, pembinaan dan pengawasan produk hukum Kabupaten/Kota, bantuan hukum, dan layanan hukum;\r\n14. Penyusunan laporan pelaksanaan tugas Biro;\r\n15. Pelaksanaan kegiatan kesekretariatan; dan\r\n16. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Biro.\r\n\r\nSumber : Pergub DIY No. 105 Tahun 2022 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, Dan Tata Kerja Sekretariat Daerah', 2, '2024-11-01 06:34:26', '2024-11-01 06:34:26'),
(83, 27, 'Tentang Kami', '<p>Biro PIWP2 Setda DIY merupakan Organisasi Perangkat Daerah yang berkedudukan di bawah dan bertanggung jawab kepada Sekretaris Daerah. Biro PIWP2 Setda DIY struktrur organisasinya mempunyai 4 unit Bagian (Eselon III A) dan 9 subbagian (eselon IV). Adapun ketugasan dari masing-masing bagian dan Sub bagian adalah sebagai berikut : 1. Bagian Pengelolaan Kebijakan Infrastruktur Daerah mempunyai tugas menyiapkan bahan perumusan kebijakan, mengoordinasikan, dan memfasilitasi, serta memantau dan mengevaluasi pengelolaan kebijakan pengembangan infrastruktur daerah.Bagian ini dibantu oleh 2 sub bagian yaitu : - Subbagian Analisis Kebijakan Infrastruktur Daerah mempunyai tugas menyiapkan bahan perumusan kebijakan, pengoordinasian, pembinaan, fasilitasi, pemantauan dan pengevaluasian pengelolaan kebijakan pengembangan infrastruktur daerah; - Subbagian Monitoring dan Evaluasi Kebijakan Infrastruktur mempunyai tugas menyiapkan bahan perumusan kebijakan, pengoordinasian, pembinaan, fasilitasi, pemantauan dan pengevaluasian pengembangan infrastruktur daerah. 2. Bagian Pengelolaan Kebijakan Pembangunan Berkelanjutan mempunyai tugas menyiapkan bahan perumusan kebijakan, pengoordinasian, pembinaan, fasilitasi, pemantauan dan pengevaluasian pengelolaan kebijakan pembangunan berkelanjutan untuk meningkatkan persentase rumusan bahan kebijakan pembangunan berkelanjutan yang ditindaklanjuti. Bagian ini dibantu oleh 2 sub bagian yaitu : - Subbagian Analisis Kebijakan Pembangunan Berkelanjutan mempunyai tugas menyiapkan bahan perumusan kebijakan, pengoordinasian, pembinaan, fasilitasi, pemantauan dan pengevaluasian pengelolaan kebijakan pembangunan berkelanjutan - Subbagian Monitoring dan Evaluasi Kebijakan Pembangunan Berkelanjutan mempunyai tugas menyiapkan bahan perumusan kebijakan, pengoordinasian, pembinaan, fasilitasi, pemantauan dan pengevaluasian pengelolaan kebijakan pembangunan berkelanjutan 3. Bagian Pembiayaan Pembangunan Non Pemerintah mempunyai tugas menyiapkan bahan perumusan kebijakan, pengoordinasian, pembinaan, fasilitasi, pemantauan dan pengevaluasian pengelolaan dan pengembangan pembiayaan non pemerintah untuk meningkatkan persentase rumusan bahan kebijakan pembiayaan pembangunan non pemerintah yang ditindaklanjuti. Bagian ini dibantu oleh 2 sub bagian yaitu : - Subbagian Analisis, Monitoring, dan Evaluasi Kebijakan Pengembangan Sumber-Sumber Pembiayaan Non Pemerintah mempunyai tugas menyiapkan bahan perumusan kebijakan, pengoordinasian, pembinaan, fasilitasi, pemantauan dan pengevaluasian pengelolaan dan pengembangan kebijakan pembiayaan non pemerintah. - Subbagian Tata Usaha mempunyai tugas menyelenggarakan ketatausahaan Biro. 4. Bagian Layanan Pengadaan Barang/Jasa mempunyai tugas menyelenggarakan dukungan pengadaan barang dan jasa pada Pemerintah Daerah untuk meningkatkan persentase paket pengadaan barang dan jasa yang terselesaikan. Bagian ini dibantu oleh 3 sub bagian yaitu : - Subbagian Pembinaan dan Advokasi Pengadaan Barang/Jasa mempunyai tugas melaksanakan fasilitasi pembinaan sumber daya manusia, kelembagaan, dan advokasi pengadaan barang/jasa; - Subbagian Pengelolaan Pengadaan Barang/Jasa mempunyai tugas mengelola pengadaan barang/jasa; - Subbagian Pengelolaan Layanan Pengadaan Secara Elektronik mempunyai tugas menyelenggarakan pelaksanaan pengelolaan layanan pengadaan secara elektronik.</p>', 2, '2024-11-01 06:44:22', '2025-02-11 07:49:54'),
(84, 27, 'Tugas dan Fungsi', '<p>https://biropiwpp.jogjaprov.go.id/index.php/2022/10/24/tugas-pokok/</p>', 2, '2024-11-01 06:44:22', '2025-02-11 07:49:54'),
(85, 28, 'Tugas', 'Melaksanakan fungsi pendukung di bidang perumusan kebijakan strategis bidang tata pemerintahan dan pelaksanaan urusan pemerintahan bidang administrasi kependudukan dan pencatatan sipil.', 2, '2024-11-01 07:01:26', '2024-11-01 07:01:26'),
(86, 28, 'Fungsi', 'Sedangkan untuk melaksanakan tugas tersebut, dalam pasal 9 ayat 2 Pergub No. 105 Tahun 2022 Biro Tata Pemerintahan Setda DIY  mempunyai fungsi sebagai berikut :\r\n\r\n1. Penyusunan program kerja biro;\r\n2. Penyiapan bahan perumusan kebijakan bidang otonomi daerah dan kerja sama daerah, pemerintahan umum, ketentraman, ketertiban umum, dan perlindungan masyarakat, serta penanggulangan bencana, pemerintahan kalurahan/kelurahan dan kapanewon/kemantren, serta kependudukan dan pencatatan sipil;\r\n3. Koordinasi pelaksanaan kebijakan bidang otonomi daerah dan kerja sama daerah, pemerintahan umum, ketentraman, ketertiban umum, dan perlindungan masyarakat, serta penanggulangan bencana, pemerintahan kalurahan/kelurahan dan kapanewon/kemantren, serta kependudukan dan pencatatan sipil;\r\n4. Pelaksanaan pemantauan bidang otonomi daerah dan kerja sama daerah, pemerintahan umum, ketentraman, ketertiban umum, dan perlindungan masyarakat, serta penanggulangan bencana, pemerintahan kalurahan/kelurahan dan kapanewon/kemantren, serta kependudukan dan pencatatan sipil;\r\n5. Pengevaluasian dan pelaporan pelaksanaan kebijakan bidang otonomi daerah dan kerja sama daerah, pemerintahan umum, ketentraman, ketertiban umum, dan perlindungan masyarakat, serta penanggulangan bencana, pemerintahan kalurahan/kelurahan dan kapanewon/kemantren, serta kependudukan dan pencatatan sipil;\r\n6. Pelaksanaan kebijakan urusan keistimewaan bidang tata cara pengisian jabatan, kedudukan, tugas, dan wewenang Gubernur dan Wakil Gubernur;\r\n7. Fasilitasi dan koordinasi proses pengusulan, pengangkatan dan pemberhentian Gubernur, Wakil Gubernur dan Dewan Perwakilan Rakyat Daerah.\r\n8. Koordinasi pelaksanaan tugas dan wewenang Gubernur Sebagai Wakil Pemerintah Pusat;\r\n9. Fasilitasi dan koordinasi penyusunan laporan penyelenggaraan pemerintahan daerah;\r\n10. Pelaksanaan koordinasi, pembinaan dan pengawasan terhadap urusan pemerintahan yang menjadi kewenangan kabupaten/kota;\r\n11. Pelaksanaan kegiatan ketatausahaan;\r\n12. pembinaan penyelenggaraan reformasi birokrasi kalurahan;\r\n13. Fasilitasi pembinaan reformasi birokrasi Biro;\r\n14. Fasilitasi penyusunan kebijakan proses bisnis Biro;\r\n15. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik dalam lingkup Biro;\r\n16. Penyusunan laporan pelaksanaan tugas Biro; dan\r\n17. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Biro.', 2, '2024-11-01 07:01:26', '2024-11-01 07:01:26'),
(87, 29, 'TUJUAN BIRO UMUM, HUBUNGAN MASYARAKAT DAN PROTOKOL', 'Berdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 105 Tahun 2022 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, Dan Tata Kerja Sekretariat Daerah, Biro Umum, Hubungan Masyarakat, dan Protokol sebagaimana dimaksud dalam Pasal 53 mempunyai tugas melaksanakan fungsi pendukung perumusan kebijakan strategis bidang umum, kehumasan, dan keprotokolan. Untuk melaksanakan tugas sebagaimana dimaksud, Biro Umum, Hubungan Masyarakat, dan Protokol mempunyai fungsi:\r\n\r\na. penyusunan program kerja Biro; \r\n\r\nb. penyiapan pelayanan bidang administrasi perkantoran, tata usaha pimpinan, rumah tangga, kendaraan, kehumasan, serta keprotokolan; \r\n\r\nc. pelaksanaan, pemantauan, dan evaluasi pelayanan bidang administrasi perkantoran; \r\n\r\nd. penyiapan bahan koordinasi bidang administrasi perkantoran, tata usaha pimpinan, rumah tangga, kendaraan, kehumasan, serta keprotokolan; \r\n\r\ne. penyelenggaraan pelayanan kehumasan Pemerintah Daerah; \r\n\r\nf. penyelenggaraan pelayanan keprotokolan dan tamu Pemerintah Daerah;\r\n\r\ng. penyelenggaraan kerumahtanggaan pimpinan Pemerintah Daerah; \r\n\r\nh. pengelolaan sarana dan prasarana Biro; \r\n\r\ni. pelaksanaan kegiatan ketatausahaan pimpinan Pemerintah Daerah; \r\n\r\nj. pembinaan dan penyelenggaraan kearsipan Sekretariat Daerah; \r\n\r\nk. fasilitasi pelantikan Gubernur dan Wakil Gubernur; \r\n\r\nl. fasilitasi pembinaan reformasi birokrasi Biro;\r\n\r\nm. fasilitasi penyusunan kebijakan proses bisnis Biro; \r\n\r\nn. pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik dalam lingkup Biro; \r\n\r\no. pemantauan dan pengevaluasian pelaksanaan kebijakan bidang administrasi perkantoran, tata usaha pimpinan, rumah tangga, kendaraan, hubungan masyarakat, serta keprotokolan;\r\n\r\np. penyusunan laporan pelaksanaan tugas Biro; \r\n\r\nq. pelaksanaan kegiatan ketatausahaan; dan \r\n\r\nr. pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Biro.\r\n\r\n', 2, '2024-11-01 07:07:31', '2024-11-01 07:07:31'),
(88, 29, 'RENSTRA dan RENJA BIRO UHP', 'Rencana Strategis Satuan Organisasi Perangkat Daerah (Renstra-SOPD) Biro Umum, Humas dan Protokol Setda DIY Tahun 2017-2022 merupakan Dokumen Perencanaan yang berisi rencana program dan kegiatan, dan digunakan sebagai acuan dalam pelaksanaan tugas pokok dan fungsi, serta sebagai tolok ukur pencapaian kinerja dalam kurun waktu tertentu. Renstra ini disusun berdasarkan pemahaman terhadap lingkungan baik dalam skala nasional, regional maupun lokal dengan memperhitungkan potensi, peluang dan kendala yang ada atau timbul serta memuat visi dan misi kepala daerah yang dijabarkan dalam membina unit kerja serta kebijaksanaan sasaran dan prioritas sasaran sampai dengan tahun 2022 yang mengacu pada Rencana Pembangunan Jangka Menengah Daerah (RPJMD) DIY Tahun 2017 – 2022. Kinerja instansi pemerintah semakin menjadi sorotan masyarakat sejalan dengan iklim yang semakin demokratis dalam pemerintahan. Dalam upaya meningkatkan kinerja instansi pemerintah, perencanaan strategis merupakan langkah awal yang harus dilakukan oleh instansi pemerintah agar mampu menjawab tuntutan lingkungan strategis lokal, nasional, dan global. Dengan pendekatan perencanaan strategis yang jelas dan sinergis, instansi pemerintah lebih dapat menyelaraskan visi dan misinya dengan potensi, peluang dan kendala yang dihadapi.', 2, '2024-11-01 07:07:31', '2024-11-01 07:07:31'),
(89, 32, 'Tugas', 'Dinas mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang kesehatan.', 2, '2024-11-01 07:16:57', '2024-11-01 07:16:57'),
(90, 32, 'Fungsi ', 'a.  Penyusunan program kerja Dinas;\r\n\r\nb.  Perumusan kebijakan teknis bidang kesehatan;\r\n\r\nc.  Penyelenggaraan pencegahan dan pengendalian penyakit;\r\n\r\nd.  Penyelenggaraan pelayanan kesehatan dasar, rujukan,dan kesehatan khusus, mutu dan akreditasi fasilitas pelayanan kesehatan primer, rujukan, dan fasilitas pelayanan kesehatan lain;\r\n\r\ne.  Penyelenggaraan kesehatan masyarakat;\r\n\r\nf.  Pengelolaan sumber daya kesehatan;\r\n\r\ng.  Pengembangan upaya kesehatan tradisional;\r\n\r\nh.  Pemberian fasilitasi penyelenggaraan urusan kesehatan Kabupaten/Kota;\r\n\r\ni.   Pemberdayaan sumber daya dan mitra kerja urusan  kesehatan;\r\n\r\nj.   Pelaksanaan koordinasi, pemaJrtauan, evaluasi, pembinaan, dan pengawasan urusaJr pemerintahan bidang Kesehatan yang menjadi kewenangan Kabupaten/Kota;\r\n\r\nk.  Pelaksanaan kegiatan kesekretariatan;\r\n\r\nl.   Pelaksanaan dekonsentrasi dan tugas pembantuan;\r\n\r\nm.  Pemantauan, evaluasi, dan penyusunan laporan pelaksanaan kebdakan bidang kesehatan;\r\n\r\nn.  Penyusunan laporan pelaksanaan tugas Dinas; dan\r\n\r\no.  Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.\r\n\r\n \r\n\r\nUntuk selengkapnya klik Pergub PB 90 2021 Dinas Kesehatan_Tupoksi', 2, '2024-11-01 07:16:57', '2024-11-01 07:16:57'),
(91, 32, 'Balai Laboratorium Kesehatan dan Kalibrasi', 'Tugas UPT Balai Laboratorium Kesehatan dan Kalibrasi\r\n\r\nMelaksanakan pelayanan laboratorium klinik dan laboratorium kesehatan masyarakat, penunjang medis, laboratorium kesehatan lingkungan, kalibrasi alat laboratorium dan/atau alat kesehatan dan pemantapan mutu eksternal untuk meningkatkan jumlah layanan pengembangan laboratorium untuk mendukung program, rujukan dan kebutuhan masyarakat\r\n\r\nFungsi UPT Balai Laboratorium Kesehatan dan Kalibrasi\r\n\r\na.  Penyusunan program kerja Balai;\r\n\r\nb.  Pengelolaan sarana dan prasarana Balai;\r\n\r\nc.  Pelayanan pemeriksaan klinis, medis, penunjang medis, laboratorium kesehatan lingkungan dan rujukan laboratorium;\r\n\r\nd.  Pelayanan pemeriksaan laboratorium kesehatan masyarakat, individu dan institusi;\r\n\r\ne.  Penyelenggaraan pembinaan dan pengawasan mutu laboratorium kesehatan;\r\n\r\nf.  Penyelenggaraan kerja sama pendidikan dan pelatihan teknis laboratorium, konsultasi laboratorium dan penelitian;\r\n\r\ng.  Pelayanan kalibrasi alat laboratorium dan pengujian kalibrasi alat kesehatan;\r\n\r\nh.  Pemantapan mutu eksternal laboratorium;\r\n\r\ni.  Pelaksanaan pemasaran produk Balai;\r\n\r\nj.  Pelaksanaan ketatausahaan;\r\n\r\nk.  Pemantauan, evaluasi dan penyusunan laporan pelaksanaan program Balai; dan\r\n\r\nl.  Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi UPT.\r\n\r\nUntuk selengkapnya klik Pergub DIY No. 87 Tahun 2018 Tupoksi UPT Dinkes', 2, '2024-11-01 07:16:57', '2024-11-01 07:16:57'),
(92, 32, 'Balai Pelatihan Kesehatan', 'Tugas UPT Balai Pelatihan Kesehatan\r\n\r\nMerencanakan, menyelenggarakan, dan mengevaluasi pelatihan kesehatan bagi tenaga kesehatan dan masyarakat untuk meningkatkan persentase mantan linatih yang meningkat kompetensinya.\r\n\r\nFungsi UPT Balai Pelatihan Kesehatan\r\n\r\na. Penyusunan program kerja Balai;\r\n\r\nb. Penyelenggaraan pelatihan manajemen dan teknis kesehatan bagi tenaga kesehatan serta pelatihan keterampilan kesehatan bagi masyarakat;\r\n\r\nc. Pengembangan pelatihan bidang kesehatan;\r\n\r\nd. Penyelenggaraan pengelolaan laboratorium lapangan serta laboratorium kelas untuk pelatihan kesehatan;\r\n\r\ne. Penyelenggaraan pengembangan metode pelatihan;\r\n\r\nf. Pengembangan kemitraan pelatihan bidang kesehatan;\r\n\r\ng. Pelaksanaan ketatausahaan;\r\n\r\nh. Pemantauan, evaluasi, dan penyusunan laporan pelaksanaan program Balai; dan\r\n\r\ni. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi UPT.\r\n\r\nj. Untuk selengkapnya klik Pergub DIY No. 87 Tahun 2018 Tupoksi UPT Dinkes', 2, '2024-11-01 07:16:57', '2024-11-01 07:16:57'),
(93, 32, 'Balai Penyelenggara Jaminan Kesehatan Sosial', 'Tugas UPT Balai Penyelenggara Jaminan Kesehatan Sosial\r\n\r\nMenyelenggarakan kegiatan di bidang jaminan kesehatan bagi masyarakat DIY untuk meningkatkan persentase penduduk miskin yang mendapatkan layanan jaminan kesehatan.\r\n\r\nFungsi UPT Balai Penyelenggara Jaminan Kesehatan Sosial\r\n\r\na. Penyusunan program kerja Balai;\r\n\r\nb. Penyelenggaraan manajemen kepesertaan dan pengembangan jaminan kesehatan sosial;\r\n\r\nc. Penyelenggaraan manajemen pelayanan jaminan kesehatan;\r\n\r\nd. Penyelenggaraan manajemen klaim;\r\n\r\ne. Pelaksanaan ketatausahaan;\r\n\r\nf. Pemantauan, evaluasi dan penyusunan laporan pelaksanaan program Balai; dan\r\n\r\ng. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi UPT.\r\n\r\nUntuk selengkapnya klik Pergub DIY No. 87 Tahun 2018 Tupoksi UPT Dinkes', 2, '2024-11-01 07:16:57', '2024-11-01 07:16:57'),
(94, 32, 'Rumah Sakit Paru Respira', 'Tugas UPT Rumah Sakit Paru Respira\r\n\r\nMenyelenggarakan pelayanan kesehatan perorangan secara paripurna, khususnya kesehatan paru, pernapasan, dan kesehatan lainnya untuk:\r\n\r\na. Meningkatkan angka keberhasilan pengobatan (success rate) Tuberculossis;\r\n\r\nb. Menurunkan angka kematian pasien lebih dari 48 (empat puluh delapan) jam;\r\n\r\nc. Meningkatkan rata-rata kunjungan rawat jalan per hari;\r\n\r\nd. Meningkatkan Bed Occupancy Rate; dan\r\n\r\ne. Menurunkan Length of Stay.\r\n\r\nFungsi UPT Rumah Sakit Paru Respira\r\n\r\na. Penyusunan program Rumah Sakit dalam melaksanakan pelayanan kesehatan perorangan, khususnya kesehatan paru, pernapasan, dan kesehatan lainnya;\r\n\r\nb. Penyusunan teknis operasional bidang pelayanan kesehatan paru, pernapasan, dan kesehatan lainnya;\r\n\r\nc. Penyelenggaraan pelayanan pengobatan dan pemulihan; kesehatan paru, pernapasan, dan kesehatan lainnya sesuai dengan standar pelayanan Rumah Sakit;\r\n\r\nd. Pemeliharaan dan peningkatan kesehatan perorangan melalui pelayanan kesehatan paru, pernapasan, dan kesehatan lainnya secara paripurna sesuai kebutuhan medis;\r\n\r\ne. Pengembangan sumber daya manusia Rumah Sakit;\r\n\r\nf. Pelaksanaan kegiatan ketatausahaan; dan\r\n\r\ng. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Rumah Sakit.\r\n\r\n \r\nUntuk selengkapnya klik Pergub DIY No. 89 Tahun 2018 Tupoksi RS Respira', 2, '2024-11-01 07:16:57', '2024-11-01 07:16:57');
INSERT INTO `subheadings` (`id`, `content_id`, `subheading`, `subheading_description`, `author_id`, `created_at`, `updated_at`) VALUES
(95, 32, 'Rumah Sakit Jiwa Grhasia', 'Tugas Rumah Sakit Jiwa Grhasia\r\n\r\nMenyelenggarakan pelayanan kesehatan perorangan secara paripurna, khususnya kesehatan jiwa dan narkotika, psikotropika, dan zat adiktif, serta kesehatan lainnya untuk:\r\n\r\na. Meningkatkan persentase pasien yang mampu ADL (activity daily living);\r\n\r\nb. Menurunkan angka pasien cidera karena fiksasi;\r\n\r\nc. Meningkatkan waktu tunggu pelayanan obat jadi kurang dari atau sama dengan 30 (tiga puluh) menit;\r\n\r\nd. Meningkatkan rata-rata jam pelatihan karyawan per tahun;\r\n\r\ne. Meningkatkan waktu tunggu pelayanan rawat jalan jiwa kurang dari atau sama dengan 60 (enam puluh) menit;\r\n\r\nf. Meningkatkan tingkat penggunaan tempat tidur/ Bed Occupancy Rate;\r\n\r\ng. Meningkatkan penyelesaian berkas pengajuan klaim pasien jaminan kesehatan;\r\n\r\nh. Meningkatkan kualitas penyusunan laporan tahunan Rumah Sakit;\r\n\r\ni. Meningkatkan pemenuhan sumber daya manusia sesuai analisis beban kerja; dan\r\n\r\nj. Meningkatkan kesesuaian inventarisasi barang Rumah Sakit.\r\n\r\n \r\n\r\nFungsi Rumah Sakit Jiwa Grhasia\r\n\r\na. Penyusunan program dan pengendalian di Rumah Sakit;\r\n\r\nb. Penyelenggaraan pelayanan pengobatan dan rehabilitasi khususnya kesehatan jiwa dan narkotika, psikotropika, dan zat adiktif, serta kesehatan lainnya sesuai dengan standar pelayanan Rumah Sakit;\r\n\r\nc. Penyelenggaraan pendidikan dan pelatihan sumber daya manusia dalam rangka peningkatan kemampuan dalam pemberian pelayanan kesehatan jiwa dan narkotika, psikotropika, dan zat adiktif, serta kesehatan lainnya;\r\n\r\nd. Penyelenggaraan penelitian dan pengembangan serta penapisan teknologi bidang kesehatan dalam rangka peningkatan pelayanan kesehatan jiwa dan narkotika, psikotropika dan zat adiktif, serta kesehatan lainnya dengan memperhatikan etika ilmu pengetahuan bidang kesehatan jiwa dan narkotika, psikotropika, dan zat adiktif, serta kesehatan lainnya;\r\n\r\ne. Penyelenggaraan promosi kesehatan, khususnya kesehatan jiwa dan narkotika, psikotropika, dan zat adiktif;\r\n\r\nf. Penyelenggaraan kegiatan ketatausahaan;\r\n\r\ng. Penyusunan laporan pelaksanaan tugas Rumah Sakit; dan\r\n\r\nh. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Rumah Sakit.\r\n\r\n \r\n\r\nUntuk selengkapnya klik Pergub DIY No. 88 Tahun 2018 Tupoksi RS Jiwa Grahsia', 2, '2024-11-01 07:16:57', '2024-11-01 07:16:57'),
(99, 33, 'Tugas', 'Sesuai Peraturan Gubernur DIY Nomor 96 Tahun 2022 tentang KEDUDUKAN, SUSUNAN ORGANISASI, TUGAS, FUNGSI, DAN TATA KERJA DINAS KOPERASI DAN USAHA KECIL MENENGAH, Dinas Koperasi dan UKM DIY mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang koperasi, usaha kecil dan menengah.', 2, '2024-11-18 00:47:01', '2024-11-22 01:26:17'),
(101, 33, 'Fungsi', 'Untuk melaksanakan tugas sebagaimana dimaksud dalam Pasal 5, Dinas Koperasi dan UKM DIY mempunyai fungsi:\n\n1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis bidang koperasi, usaha kecil dan menengah;\n3. Pelaksanaan kerja sama koperasi, usaha kecil dan menengah;\n4. Pembinaan, pelindungan, pemasaran, pembiayaan dan pengembangan koperasi, usaha kecil dan menengah;\n5. Pelayanan bidang koperasi, usaha kecil dan menengah;\n6. Pemberdayaan mitra kerja bidang koperasi, usaha kecil dan menengah;\n7. Pengelolaan layanan usaha terpadu usaha mikro kecil dan menengah;\n8. Penumbuhkembangan wirausaha dan inkubasi wirausaha;\n9. Pelaksanaan koordinasi, pembinaan, dan pengawasan urusan pemerintahan bidang koperasi, usaha kecil dan menengah yang menjadi kewenangan pemerintah Kabupaten/ Kota;\n10. Pelaksanaan kegiatan kesekretariatan;\n11. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n12. Fasilitasi pembinaan reformasi birokrasi Dinas;\n13. Fasilitasi penyusunan kebijakan proses bisnis Dinas;\n14. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam sistem pemerintahan berbasis elektronik lingkup Dinas;\n15. pemantauan, evaluasi, dan penyusunan laporan pelaksanaan kebijakan bidang koperasi, usaha kecil dan menengah;\n16. Penyusunan laporan pelaksanaan tugas Dinas; dan\n17. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.', 2, '2024-11-21 06:37:51', '2024-11-22 01:26:17'),
(105, 35, 'Tugas', 'Sesuai dengan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 111 Tahun 2022 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi dan Tata kerja Dinas Lingkungan Hidup dan Kehutanan DIY, mempunyai tugas untuk melaksanakan urusan pemerintahan bidang lingkungan hidup dan urusan bidang kehutanan.', 2, '2024-11-25 06:35:44', '2024-12-05 08:57:53'),
(106, 35, 'Fungsi', 'Untuk melaksanakan ketugasan sebagaimana dimaksud dalam Pasal 4, Dinas Lingkungan Hidup dan Kehutanan DIY mempunyai fungsi:\n\n1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis bidang lingkungan hidup dan kehutanan;\n3. Penyelenggaraan penaatan, pengkajian, dan pengembangan kapasitas lingkungan hidup;\n4. Penyelenggaraan pengendalian pencemaran dan kerusakan lingkungan hidup;\n5. Penyelenggaraan planologi dan produksi hutan;\n6. Penyelenggaraan rehabilitasi dan konservasi alam;\n7. Pengelolaan persampahan;\n8. Pengelolaan laboratorium lingkungan;\n9. Pengelolaan perbenihan kehutanan;\n10. Pengelolaan hutan produksi dan hutan lindung;\n11. Pengelolaan Taman Hutan Raya Bunder;\n12. Penyelenggaraan kegiatan ketatausahaan;\n13. Fasilitasi pembinaan reformasi birokrasi Dinas;\n14. Fasilitasi penyusunan kebijakan proses bisnis Dinas;\n15. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik lingkup Dinas;\n16. Pemantauan, pengevaluasian dan pelaporan pelaksanaan kebijakan bidang lingkungan hidup dan kehutanan;\n17. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n18. Pelaksanaan koordinasi pembinaan dan pengawasan urusan pemerintahan bidang lingkungan hidup yang menjadi kewenangan kabupaten/kota; dan\n19. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.', 2, '2024-11-25 06:37:18', '2024-12-05 08:57:53'),
(107, 35, 'Pemanfaatan TIK', 'Berikut merupakan layanan dalam mendukung Sistem Pemerintahan Berbasis Elektronik (SPBE) di Dinas Lingkungan Hidup dan Kehutanan DIY :\n\n1. Layanan Buku Tamu\nLayanan dari Dinas Lingkungan Hidup dan Kehutanan DIY secara elektronik untuk mempermudah dalam mengajukan permohonan perizinan magang/PKL dan penelitian bagi mahasiswa, kunjungan tamu, pengajuan informasi atau data bagi masyarakat/instansi, layanan pengaduan dan survey kepuasan masyarakat.\n\n2. Layanan Laboratorium Lingkungan\nLayanan laboratorium lingkungan merupakan sistem pelayanan pengujian secara online dari Balai Laboratorium Lingkungan, Dinas Lingkungan Hidup dan Kehutanan DIY yang bertujuan untuk mempermudah pelanggan dalam mendapatkan informasi pelayanan dan mendaftarkan permintaan pengujian. Pelayanan meliputi pengujian dan pengambilan contoh uji air dan udara. Dengan adanya layanan berbasis sistem website ini, pelayanan pengujian untuk pelanggan dan personil laboratorium dpat dilakukan lebih mudah dan cepat.\n\n3. SIPARI\nAplikasi Sistem Informasi Pengelolaan Sampah Mandiri (SIPARI) berbasis website, android dan iOS yang diharapkan dapat membantu Pemerintah Daerah DIY dalam rangka menghitung capaian Jakstrada Pengelolaan Sampah Rumah Tangga (SRT) dan Sampah Sejenis Rumah Tangga (SSRT) dengan menginventarisasi capaian pengurangan sampah dari Pengelola Sampah Mandiri (PSM). Aplikasi ini menampilkan jumlah timbulan sampah yang masuk di PSM, sampah terkelola oleh PSM dan data PSM di DIY.\n\n4. Virtual Exhibition Produk Olahan Hutan\nVirtual Exhibition Produk Olahan Hutan Istimewa merupakan kegiatan fasilitasi pemasaran produk olahan hasil hutan dari pelaku usaha/kelompok tani hutan di DIY berbasis website. Pameran virtual ini bertujuan untuk membantu masyarakat dalam strategi peningkatan pemasaran prduk olahan. Pameran berisi rangkaian acara talkshow/dialog interaktif, bimbingan teknis promosi produk olahan hasil hutan, promosi produk dan transaksi komunikasi langsung antara pelaku/kelompok tani hutan dengan pengunjung pameran. Pengunjung website dapat melihat video promosi, dokumen katalog, flyer dari masing-masing pelaku usaha/kelompok tani hutan dan menyaksikan rekaman acara pameran virtual. \n\n5. SIKARYO\nAplikasi Sistem Informasi Kayu Rakyat Yogyakarta (SIKARYO) adalah sistem informasi berbasis website sebagai sarana pencatatan dan pelaporan secara elektronik pada setiap segmen penatausahaan hasil hutan kayu yang berasal dari hutan rakyat. Penatausahaan adalah kegiatan pencatatan dan pelaporan perencanaan produksi, pemanenan atau penebangan, pengukuran dan pengujian, penandaan, pengangkutan/peredaran, serta pengolahan hasil hutan kayu. Melalui sistem ini produksi kayu rakyat dapat dipantau penatausahaan hasil hutan kayu dan melacak hasil hutan kayu yang berasal dari hutan rakyat di wilayah DIY.', 2, '2024-11-25 06:38:47', '2024-12-05 08:57:53'),
(108, 35, 'Unit Pelaksana Teknis (UPT)', 'Dalam melaksanakan ketugasan, terdapat Unit Pelaksana Teknis (UPT) yang diatur dalam Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 95 Tahun 2018 Tentang Pembentukan, Susunan Organisasi, Tugas, Fungsi dan Tata Kerja Unit Pelaksana Teknis pada Dinas Lingkungan Hidup dan Kehutanan DIY.\n\n1. Balai Laboratorium Lingkungan\n\nBalai Laboratorium Lingkungan mempunyai tugas melaksanakan kegiatan operasional dan/atau kegiatan teknis penunjang Dinas dalam pelaksanaan pengujian parameter kualitas lingkungan meliputi contoh uji air dan udara. Lokasi kantor berada di Jl. Wiyoro Lor, Kalangan, Baturetno, Banguntapan, Bantul, DIY.\n\n2. Balai Pengelolaan Sampah\n\nBalai Pengelolaan Sampah mempunyai tugas melaksanakan kegiatan operasional dan/atau kegiatan teknis penunjang Dinas dalam pelaksanaan pengelolaan sampah untuk meningkatkan pengelolaan sampah di Tempat Pemrosesan Akhir Piyungan (ton/hari).\n\n3. Balai Perbenihan Kehutanan\n\nBalai Perbenihan Kehutanan mempunyai tugas melaksanakan teknis operasional Dinas bidang perbenihan tanaman kehutanan untuk meningkatkan produksi bibit tanaman bersertifikat yang ditanam (batang). Lokasi persemaian bibit berada di Persemaian Bunder, Gading, Playen, Gunungkidul, DIY.\n\n4. Balai Taman Hutan Raya (TAHURA) Bunder\n\nBalai Taman Hutan Raya Bunder mempunyai tugas melaksanakan teknis operasional Dinas dalam pengelolaan Taman Hutan Raya Bunder untuk meningkatkan persentase hutan konservasi terkelola. Lokasi berada di Gading III, Gading, Playen, Gunung Kidul, DIY.\n\n5. Balai Kesatuan Pengelolaan Hutan Rakyat\n\nBalai Kesatuan Pengelolaan Hutan Yogyakarta mempunyai tugas menyelenggarakan pengelolaan hutan produksi dan hutan lindung untuk meningkatkan rasio pemanfaatan sumber daya hutan. ', 2, '2024-11-25 06:39:31', '2024-12-05 08:57:53'),
(109, 36, 'Struktur Organisasi', 'Sebagaimana Peraturan Gubernur Nomor 112 Tahun 2022 Dinas Pariwisata DIY terdiri atas :\n\na. Kepala Dinas;\n\nb. Sekretariat, terdiri atas Subbagian Umum;\n\nc. Bidang pengembangan Destinasi Wisata;\n\nd. Bidang Pengembangan Sumber Daya Pariwisata;\n\ne. Bidang pengembangan Ekonomi Kreatif;\n\nf. Bidang Pemasaran Pariwisata;\n\ng. Unit Pelaksana Teknis; dan\n\nh. Kelompok Jabatan Fungsional.', 2, '2024-11-25 06:40:36', '2024-11-25 06:41:18'),
(110, 36, 'Tugas', 'Dinas Pariwisata DIY mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang pariwisata dan ekonomi kreatif', 2, '2024-11-25 06:41:39', '2024-11-25 06:41:39'),
(111, 36, 'Fungsi', 'Dinas Pariwisata DIY mempunyai fungsi:\n\n1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis pengembangan destinasi, pengembangan ekonomi kreatif, pengembangan sumber daya pariwisata dan pemasaran pariwisata;\n3. Fasilitasi pengelolaan destinasi, ekonomi kreatif, sumber daya pariwisata dan pemasaran pariwisata;\n4. Pelaksanaan kerjasama lintas sektor dalam pengelolaan destinasi wisata, ekonomi kreatif, pengembangan sumber daya pariwisata dan pemasaran pariwisata;\n5. Pemasaran pariwisata dan ekonomi kreatif;\n6. Pelaksanaan analisis kepariwisataan dan ekonomi kreatif yang mendukung pengembangan pariwisata dan ekonomi kreatif;\n7. Penyediaan dan penyebarluasan informasi kepada masyarakat untuk kepentingan pengembangan pariwisata dan ekonomi kreatif;\n8. Pengembangan kapasitas sumber daya manusia dan kelembagaan pariwisata dan ekonomi kreatif;\n9. Pemantauan dan evaluasi pelaksanaan program pengembangan destinasi, ekonomi kreatif, sumber daya pariwisata dan pemasaran;\n10. Pelaksanaan kegiatan kesekretariatan;\n11. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n12. Fasilitasi pembinaan reformasi birokrasi Dinas;\n13. Fasilitasi penyusunan kebijakan proses bisnis Dinas;\n14. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik lingkup Dinas;\n15. Pemantauan, pengevaluasian dan pelaporan pelaksanaan kebijakan bidang pariwisata dan ekonomi kreatif;\n16. Pelaksanaan koordinasi, pemantatlan, evaluasi, pembinaan dan pengawasan urusan pemerintahan bidang pariwisata dan ekonomi kreatif yang menjadi kewenangan kabupaten/kota; dan\n17. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai tugas dan fungsi Dinas.', 2, '2024-11-25 06:44:57', '2024-11-25 06:44:57'),
(112, 36, 'Layanan Informasi Pariwisata ', '1. Website : visitingjogja.jogjaprov.go.id\nPortal informasi pariwisata Daerah Istimewa Yogyakarta yang menyajikan beragam informasi meliputi: Destinasi Wisata, Kuliner, Event, Info wisata, dan  Akomodasi yang disajikan dalam bahasa Indonesia, English, Korea dan Jepang.\n\npranala : http://visitingjogja.jogjaprov.go.id/\n\n2. Apps Visiting Jogja\nAplikasi yang dikembangkan oleh Dinas Pariwisata DIY bekerjasama dengan Bank Indonesia untuk memberikan kemudahan para wisatawan untuk memperoleh informasi pariwisata, yang dapat diunduh melalui App Store \n\n3. Tourism Information Center\n- TIC Malioboro\nBerlokasi di : \n\nJln. Malioboro No. 16 Yogyakarta\n\nTelepon (0274) 566 000\n\n- TIS Bandara YIA \nBerlokasi di : \n\nPintu Kedatangan Bagian Timur Yogyakarta Internasional Airport Kulon Progo\n\nCP. 0812-2501-3771\n\n- TIS Stasiun Tugu\nBerlokasi di : \n\nPintu Kedatangan Stasiun Tugu Yogyakarta\n\nCP. 0822-2665-5273\n\n- ITIC Bali\nBerlokasi di : \n\nJln. Kuta No. 2 Kuta, Badung, Bali\n\nTelepon (0361) 766181', 2, '2024-11-25 06:47:07', '2024-11-25 06:47:07'),
(113, 36, 'Alamat dan Kontak', 'Jl. Janti KM 4, Banguntapan, Bantul, Daerah Istimewa Yogyakarta.\n\nTelepon : (0274) 587486\nFax : (0274) 565437\nEmail : dispar@jogjaprov.go.id\nWebsite : visitingjogja.jogjaprov.go.id', 2, '2024-11-25 06:47:31', '2024-11-25 06:47:31'),
(114, 37, 'Tugas', 'Membantu Gubernur melaksanakan urusan pemerintahan bidang pekerjaan umum, urusan pemerintahan bidang perumahan dan kawasan permukiman serta urusan pemerintahan bidang energi dan sumber daya mineral', 2, '2024-11-25 06:49:05', '2024-11-25 06:49:05'),
(115, 37, 'Fungsi', 'Untuk melaksanakan tugas sebagaimana dimaksud dalam Pasal 4, Dinas mempunyai fungsi:\n\n1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis urusan pekerjaan umum, perumahan dan kawasan permukiman, serta energi sumber daya mineral;\n3. Penyiapan bahan dan pembinaan urusan pekerjaan umum, perumahan dan kawasan permukiman, serta energi sumber daya mineral;\n4. Pengembangan dan pengelolaan urusan pekerjaan umum, perumahan dan kawasan permukiman, serta energi sumber daya mineral;\n5. Pengawasan dan pengendalian urusan pekerjaan umum, perumahan dan kawasan permukiman, serta energi sumber daya mineral;\n6. Fasilitasi pembinaan standar pelayanan minimal urusan pekerjaan umum dan penataan ruang serta urusan perumahan rakyat dan kawasan permukiman.\n7. Pelaksanaan koordinasi dan fasilitasi pembinaan urusan di bidang pekerjaan umum dan perumahan serta kawasan permukiman yang menjadi kewenangan Kabupaten/Kota;\n8. Pemberdayaan sumber daya dan mitra kerja urusan di bidang pekerjaan umum, perumahan dan kawasan permukiman, serta energi sumber daya mineral;\n9. Pelaksanaan pelayanan umum urusan pekerjaan umum, perumahan dan kawasan permukiman, serta energi sumber daya mineral;\n10. Fasilitasi pembinaan standar pelayanan minimal urusan pekerjaan umum dan penataan ruang seta urusan perumahan rakyat dan kawasan permukiman.\n11. Pelaksanaan kegiatan kesekretariatan;\n12. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n13. Fasilitasi pembinaan reformasi birokrasi Dinas;\n14. Fasilitasi penyusunan kebijakan proses bisnis Dinas;\n15. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik lingkup Dinas;\n16. Pemantauan, pengevaluasian, dan pelaporan pelaksanaan kebijakan bidang pekerjaan umum, perumahan dan kawasan permukiman serta energi sumber daya mineral.\n17. Penyusunan laporan pelaksanaan tugas Dinas; dan\n18. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan fungsi dan tugas Dinas.', 2, '2024-11-25 06:54:08', '2024-11-25 06:54:08'),
(116, 37, 'Dasar Hukum ', '1. Keputusan Gubernur Daerah Istimewa Yogyakarta Nomor 163 Tahun 2002 tentang Uraian Tugas dan Tata Kerja Unit Pelaksana Teknis Dinas di Lingkungan Dinas Permukiman Prasarana Wilayah Provinsi Daerah Istimewa Yogyakarta; dan\n2. Keputusan Gubernur Daerah Istimewa Yogyakarta Nomor 97 Tahun 2004 tentang Uraian Tugas dan Tata Kerja Dinas Permukiman Prasarana Wilayah Provinsi Daerah Istimewa Yogyakarta\n3. Peraturan Daerah Provinsi Daerah Istimewa Yogyakarta Nomor 6 Tahun 2008 Tentang Organisasi Dan Tata Kerja Dinas Daerah Provinsi Daerah Istimewa Yogyakarta\n4. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 41 Tahun 2008 Rincian Tugas Dan Fungsi Dinas Dan Unit Pelaksana Teknis Pada Dinas Pekerjaan Umum, Perumahan Dan Energi Sumber Daya Mineral\n5. Peraturan Daerah Istimewa Daerah Istimewa Yogyakarta Nomor 3 Tahun 2015 Tentang Kelembagaan Pemerintah Daerah Daerah Istimewa Yogyakarta\n6. Nomor 6 Tahun 2015 Tentang Perubahan Kedua Atas Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 41 Tahun 2008 Tentang Rincian Tugas Dan Fungsi Dinas Dan Unit Pelaksana Teknis Pada Dinas Pekerjaan Umum, Perumahan Dan Energi Sumber Daya Mineral\n7. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 60 Tahun 2015 Tentang Rincian Tugas Dan Fungsi Dinas Pekerjaan Umum, Perumahan, Dan Energi Sumber Daya Mineral\n8. Peraturan Daerah Istimewa Daerah Istimewa Yogyakarta Nomor 1 Tahun 2018 Tentang Kelembagaan Pemerintah Daerah Daerah Istimewa Yogyakarta\n9. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 63 Tahun 2018 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, Dan Tata Kerja Dinas Pekerjaan Umum, Perumahan, Dan Energi Sumber Daya Mineral\n10. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 93 Tahun 2018 Tentang Pembentukan, Susunan Organisasi, Tugas, Fungsi, Dan Tata Kerja Unit Pelaksana Teknis Pada Dinas Pekerjaan Umum, Perumahan Dan Energi Sumber Daya Mineral\n11. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 8 Tahun 2021 Tentang Perubahan Atas Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 93 Tahun 2018 Tentang Pembentukan, Susunan Organisasi, Tugas, Fungsi, Dan Tata Kerja Dinas Pekerjaan Umum, Perumahan Dan Energi Sumber Daya Mineral\n12. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 98 Tahun 2022 Tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Dinas Pekerjaan Umum, Perumahan Dan Energi Sumber Daya Mineral\n\nDinas Pekerjaan Umum, Perumahan dan Energi Sumber Daya Mineral DIY sebelumnya bernama Dinas Permukiman Prasarana Wilayah (Kimpraswil) berdasarkan Keputusan Gubernur Daerah Istimewa Yogyakarta Nomor 97 Tahun 2004. Kemudian dengan terbitnya Peraturan Daerah Provinsi DIY Nomor 6 Tahun 2008 tentang Organisasi dan Tata Kerja Dinas Daerah Provinsi Daerah Istimewa Yogyakarta, nama Dinas Permukiman Prasarana Wilayah berubah menjadi Dinas Pekerjaan Umum, Perumahan dan Energi Sumber Daya Mineral DIY, yang Rincian Tugas dan Fungsi Dinas dan UPT nya tertuang dalam Peraturan Gubernur DIY Nomor 41 Tahun 2008.\n\n \n\nSeiring dengan penataan kelembagaan baru Pemerintah Daerah Daerah Istimewa Yogyakarta sesuai dengan Peraturan Daerah Istimewa Derah Istimewa Yogyakarta Nomor 1 Tahun 2018, Susunan Organisasi, Tugas, Fungsi dan Tata Kerja Dinas Pekerjaan mengalami Perubahan yang dituangkan dalam Peraturan Gubernur DIY Nomor 63 Tahun 2018, dimana tugas dari Dinas PUPESDM membantu Gubernur melaksanakan urusan pemerintahan bidang pekerjaan umum, urusan pemerintahan bidang perumahan dan kawasan permukiman serta urusan pemerintahan bidang energi dan sumber daya mineral.', 2, '2024-11-25 06:56:14', '2024-11-25 06:56:14'),
(117, 37, 'Dasar Hukum UPT', '1. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 36 Tahun 2008 tentang Organisasi dan Tatakerja Unit Pelaksana Teknis Dinas dan Unit Pelaksana Teknis Lembaga Teknis Daerah Provinsi Daerah Istimewa Yogyakarta (Berita Daerah Provinsi Daerah Istimewa Yogyakarta Tahun 2008 Nomor 37);\n2. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 6 Tahun 2013 tentang Perubahan Keempat Atas Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 36 Tahun 2008 tentang Organisasi dan Tatakerja Unit Pelaksana Teknis Dinas dan Unit Pelaksana Teknis Lembaga Teknis Daerah Provinsi Daerah Istimewa Yogayakarta (Berita Daerah Provinsi Daerah Istimewa Yogyakarta Tahun 2013 Nomor 6);\n3. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 82 Tahun 2014 tentang Perubahan Kelima Atas Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 36 Tahun 2008 tentang Organisasi dan Tatakerja Unit Pelaksana Teknis Dinas dan Unit Pelaksana Teknis Lembaga Teknis Daerah Provinsi Daerah Istimewa Yogayakarta (Berita Daerah Provinsi Daerah Istimewa Yogyakarta Tahun 2014 Nomor 82);\n4. Nomor 6 Tahun 2015 Tentang Perubahan Kedua Atas Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 41 Tahun 2008 Tentang Rincian Tugas Dan Fungsi Dinas Dan Unit Pelaksana Teknis Pada Dinas Pekerjaan Umum, Perumahan Dan Energi Sumber Daya Mineral\n5. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 92 Tahun 2015 Tentang Pembentukan, Susunan Organisasi, Uraian Tugas Dan Fungsi Serta Tatakerja Unit Pelaksana Teknis Pada Dinas Pekerjaan Umum, Perumahan Dan Energi Sumber Daya Mineral\n6. Peraturan Gubernur Daerah Istimewayogyakarta Nomor 93 Tahun 2018 Tentang Pembentukan, Susunan Organisasi, Tugas, Fungsi, Dan Tata Kerja Unit Pelaksana Teknis Pada Dinas Pekerjaan Umum, Perumahan Dan Energi Sumber Daya Mineral\n7. Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 8 Tahun 2021 Tentang Perubahan Atas Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 93 Tahun 2018 Tentang Pembentukan, Susunan Organisasi, Tugas, Fungsi, Dan Tata Kerja Unit Pelaksana Teknis Pada Dinas Pekerjaan Umum, Perumahan Dan Energi Sumber Daya Mineral', 2, '2024-11-25 06:57:48', '2024-11-25 06:57:48'),
(118, 38, 'Tugas', 'Berdasarkan Peraturan Gubernur Daerah Istimewa Yogyakarta Nomor 5 Tahun 2023 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, dan Tata Kerja Dinas Pemberdayaan Perempuan, Perlindungan Anak, dan Pengendalian Penduduk (DP3AP2 DIY), DP3AP2 DIYmempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang pemberdayaan perempuan dan perlindungan anak serta urusan pemerintahan bidang pengendalian penduduk dan Keluarga Berencana. ', 2, '2024-11-25 06:59:45', '2024-11-25 08:16:39'),
(119, 38, 'Fungsi', 'Untuk melaksanakan tugas sebagaimana di atas Dinas Pemberdayaan Perempuan, Perlindungan Anak dan Pengendalian Penduduk Daerah Istimewa Yogyakarta (DP3AP2 DIY) mempunyai fungsi sebagai berikut :\n\n1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis bidang pemberdayaan perempuan, perlindungan anak,  pengendalian penduduk dan Keluarga Berencana;\n3. Pelaksanaan sinkronisasi kebijakan pemerintah dengan Pemerintah Daerah dalam bidang Pemberdayaan perempuan, perlindungan, pengendalian penduduk dan Keluarga Berencana;\n4. Pelaksanaan koordinasi dan fasilitasi pelaksanaan bidang pemberdayaan perempuan, perlindungan anak, pengendalian penduduk dan Keluarga Berencana;\n5. Pelaksanaan fasilitasi kelembagaan bidang pemberdayaan perempuan, perlindungan anak, pengendalian penduduk dan Keluarga Berencana;\n6. Pelaksanaan koordinasi, fasilitasi, penyediaan, pengelolaan, dan pemanfaatan data dan informasi pemberdayaan perempuan, perlindungan anak, pengendalian penduduk dan Keluarga Berencana;\n7. Pelaksanaan program pengarusutamaan gender dan pemberdayaan perempuan;\n8. Pelaksanaan program perlindungan perempuan;\n9. Pelaksanaan Program Peningkatan Kualitas Keluarga;\n10. Pelaksanaan Program Pengelolaan sistem data gender dan anak;\n11. Pelaksanaan program pemenuhan hak anak;\n12. Pelaksanaan program perlindungan khusus anak;\n13. Pelaksanaan program pengendalian penduduk;\n14. Pelaksanaan program pembinaan keluarga berencana;\n15. Pelaksanaan program pemberdayaan dan peningkatan keluarga sejahtera;\n16. Pelaksanaan kegiatan kesekretariatan;\n17. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n18. Penyusunan kebijakan proses bisnis Dinas;\n19. Fasilitasi pembinaan reformasi birokrasi Dinas;\n20. Fasilitasi penyusunan kebijakan proses bisnis Dinas;\n21. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik lingkup Dinas;\n22. Pemantauan, evaluasi, dan penyusunan laporan pelaksanaan kebijakan bidang pemberdayaan perempuan, perlindungan anak, dan pengendalian penduduk;\n13. Penyusunan laporan pelaksanaan tugas Dinas; dan\n14. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.', 2, '2024-11-25 08:15:33', '2024-11-25 08:16:39'),
(120, 38, 'Struktur Organisasi', 'Dinas Pemberdayaan Perempuan, Perlindungan Anak dan Pengendalian Penduduk Daerah Istimewa Yogyakarta (DP3AP2 DIY) mempunyai struktur organisasi sebagai berikut :\n\na. Kepala Dinas;\n\nb. Sekretariat, terdiri atas:\n\n    1. Subbagian Umum;\n\n    2. Subbagian Keuangan; dan\n\n    3. Kelompok Substansi Program;\n\nc. Bidang Kesetaraan Gender dan Pemberdayaan Perempuan, terdiri atas:\n\n    1. Kelompok Substansi Peningkatan Kualitas Hidup Perempuan dan Pengarusutamaan Gender; dan\n\n    2. Kelompok Substansi Data, Informasi, Gender, dan Kerja Sama.\n\nd. Bidang Perlindungan Perempuan dan Anak, terdiri atas:\n\n   1. Kelompok Substansi Perlindungan Perempuan; dan\n\n   2. Kelompok Substansi Perlindungan dan Pemenuhan Hak Anak.\n\ne. Bidang Pengendalian Penduduk dan Keluarga Berencana, terdiri atas:\n\n   1. Kelompok Substansi Pengendalian Penduduk; dan\n\n   2. Kelompok Substansi Keluarga Berencana.\n\nf. Bidang Peningkatan Kualitas Keluarga, terdiri atas:\n\n  1. Kelompok Substansi Keluarga Sejahtera; dan\n\n  2. Kelompok Substansi Advokasi dan Komunikasi, Informasi, Edukasi.\n\ng. Unit Pelaksana Teknis; dan\n\nh. Jabatan Fungsional.', 2, '2024-11-25 08:16:26', '2024-11-25 08:16:39'),
(121, 39, 'Dinas mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang pendidikan dan urusan pemerintahan bidang kepemudaan dan olahraga.', 'Untuk melaksanakan tugas sebagaimana dimaksud Dinas mempunyai fungsi:\n\n1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis bidang pendidikan, pemuda, dan olahraga;\n3. Penyelenggaraan dan/atau pengelolaan Pendidikan menengah dan pendidikan khusus;\n4. Penyediaan satuan pendidikan menengah dan Pendidikan khusus;\n5. Fasilitasi dan pembinaan penyelenggaraan Pendidikan layanan khusus;\n6. Penyediaan pendidik dan tenaga kependidikan, Pendidikan menengah, dan pendidikan khusus;\n7. Penyediaan sarana dan prasarana pendidikan menengah dan pendidikan khusus;\n8. Pelaksanaan kurikulum muatan lokal pendidikan menengah dan pendidikan khusus;\n9. Penyusunan silabus dan buku teks pelajaran/modul pembelqjaran pendidikan menengah dan pendidikan khusus;', 2, '2024-11-25 08:20:58', '2024-11-25 08:20:58'),
(122, 39, 'Unit Kerja SKPD', '1. Balai Pemuda dan Olah Raga\n2. Balai Teknologi Komunikasi Pendidikan\n3. Balai Latihan Pendidikan Teknik', 2, '2024-11-25 08:21:40', '2024-11-25 08:21:40'),
(123, 41, 'Tugas', 'Sesuai dengan Peraturan Gubernur No, 99 tahun 2022 tentang Kedudukan, Susunan Organisasi, Tugas, Fungsi, Dan Tata Kerja Dinas Perindustrian Dan Perdagangan, tugas Disperindag Prov. DIY adalah membantu Gubernur melaksanakan urusan pemerintahan bidang perindustrian dan perdagangan. (Pasal 4)', 2, '2024-11-25 08:31:13', '2024-11-27 09:15:42'),
(124, 41, 'Fungsi', 'Untuk melaksanakan tugas tersebut maka Disperindag Prov. DIY memiliki fungsi (Pasal 5):\n\n1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis bidang perindustrian dan perdagangan;\n3. Pengembangan sumber daya manusia industri dan perdagangan;\n4. Peningkatan pemanfaatan teknologi industri dan mutu standardisasi;\n5. Peningkatan kerja sama industri dan perdagangan;\n6. Fasilitasi penerbitan rekomendasi perizinan industri dan perdagangan;\n7. Pengelolaan dan pelaporan data industri dan perdagangan;\n8. Pembinaan dan pengawasan perusahaan industri dan perusahaan kawasan industri;\n9. Fasilitasi pengembangan wilayah pusat pertumbuhan industri, kawasan peruntukan industri, kawasan industri, dan infrastruktur industri;\n10. Fasilitasi sarana dan prasarana industri\n11. Pembinaan dan pengembangan industri kreatif;\n12. Penyediaan layanan/fasilitasi konsultasi input dan sistem informasi industri nasional untuk perusahaan industri dan perusahaan kawasan industri di lingkup Kabupaten/Kota sesuai dengan kewenangannya;\n13. Fasilitasi rekayasa dan produksi alat tepat guna, layanan perbengkelan, konsultasi teknis dan informasi rekayasa alat tepat guna\n14. Fasilitasi kemasan dan produk kulit\n15. Pengawasan distribusi bahan berbahaya;\n16. Penerbitan surat keterangan asal dan fasilitasi angka pengenal impor;\n17. Pelayanan pelaksanaan pembangunan dan pengelolaan pusat distribusi regional dan pusat distribusi provinsi;\n18. Pengawasan ketersediaan dan harga barang kebutuhan pokok dan barang penting;\n19. Fasilitasi pengembangan dan promosi dalam negeri dan luar negeri;\n20. Pelayanan perlindungan dan pemberdayaan konsumen;\n21. Koordinasi dan fasilitasi peningkatan penggunaan produk dalam negeri;\n22. Pelaksanaan kegiatan kesekretariatan;\n23. Fasilitasi pembinaan reformasi birokrasi Dinas;\n24. Fasilitasi penyusunan kebijakan proses bisnis Dinas;\n25. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam sistem pemerintahan berbasis elektronik lingkup Dinas;\n26. Pelaksanaan koordinasi, pembinaan dan pengawasan urusan pemerintahan bidang perindustrian dan perdagangan yang menjadi kewenangan Kabupaten/Kota;\n27. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n28. Pemantauan, pengevaluasian, dan pelaporan pelaksanaan kebijakan bidang perindustrian dan perdagangan; dan\n29. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.', 2, '2024-11-25 08:38:40', '2024-11-27 09:15:42'),
(126, 41, 'Struktur Organisasi', '1. Kepala Dinas\n2. Sekretariat\n3. Bidang Sarana dan Prasarana Industri\n4. Bidang Pengembangan Sumber Daya Industri\n5. Bidang Perdagangan Dalam Negeri\n6. Bidang Perdagangan Luar Negeri\n7. Kelompok Jabatan Fungsional\n8. Balai Pengembangan Teknologi Tepat Guna\n9. Balai Pengelolaan Kekayaan Intelektual', 2, '2024-11-25 08:47:11', '2024-11-27 09:15:42'),
(127, 44, 'TUGAS', 'Dinas Pertanahan dan Tata Ruang (Kundha Niti Mandala Sarta Tata Sasana) Daerah Istimewa Yogyakarta mempunyai tugas membantu Gubernur menyelenggarakan urusan pemerintahan dan urusan keistimewaan bidang tata ruang serta urusan pemerintahan dan urusan keistimewaan bidang pertanahan.', 2, '2024-11-29 01:17:54', '2024-11-29 01:27:59'),
(128, 44, 'FUNGSI', '1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis bidang pertanahan dan tata ruang;\n3. Penyusunan perencanaan teknis urusan keistimewaan bidang pertanahan dan tata ruang;\n4. Penyiapan bahan pengendalian pelaksanaan urusan keistimewaan bidang pertanahan dan tata ruang;\n5. Fasilitasi pengelolaan dan pemanfaatan Tanah Kasultanan dan Tanah Kadipaten;\n6. Fasilitasi administrasi, pengendalian, dan penanganan permasalahan pertanahan;\n7. Fasilitasi pengadaan tanah untuk kepentingan umum;\n8. Fasilitasi pengendalian pemanfaatan Tanah Desa;\n9. Penyiapan bahan rekomendasi izin lokasi lintas Kabupaten/Kota;\n10. Penyiapan bahan penetapan lokasi pengadaan tanah untuk kepentingan umum;\n11. Fasilitasi penyelesaian sengketa tanah garapan lintas Kabupaten/Kota;\n12. Fasilitasi penyelesaian masalah ganti kerugian dan santunan tanah untuk pembangunan oleh Pemerintah Daerah;\n13. Fasilitasi penetapan subjek dan objek redistribusi tanah, serta ganti kerugian tanah kelebihan maksimum dan tanah absentee lintas Kabupaten/Kota;\n14. Fasilitasi penyelesaian masalah tanah kosong lintas Kabupaten/Kota;\n15. Inventarisasi dan pemanfaatan tanah kosong lintas Kabupaten/Kota;\n16. Perencanaan penggunaan tanah lintas Kabupaten/Kota;\n17. Penyelenggaraan penataan ruang kawasan tanah Kasultanan dan tanah Kadipaten;\n18. Penyelenggaraan sarana prasarana keistimewaan urusan pertanahan dan tata ruang; \n19. Pelaksanaan koordinasi, pemantauan, evaluasi, pembinaan, dan pengawasan urusan pemerintahan bidang pertanahan dan urusan pemerintahan bidang tata ruang yang menjadi kewenangan Kabupaten/Kota;\n20. Pelaksanaan kegiatan kesekretariatan;\n21. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n22. Penyusunan laporan pelaksanaan tugas Dinas; dan\n23. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan fungsi dan tugas Dinas. \n\nA. SEKRETARIAT \n\nTugas:\n\nSekretariat mempunyai tugas menyelenggarakan kesekretariatan Dinas dan mengkoordinasikan pelaksanaan tugas satuan organisasi dilingkungan Dinas.\n\nFungsi:\n\n1. Penyusunan program kerja Sekretariat;\n2. Perumusan kebijakan teknis kesekretariatan;\n3. Penyusunan program Dinas;\n4. Fasilitasi perumusan kebijakan teknis bidang pertanahan dan tata ruang;\n5. Penyelenggaraan kearsipan, kerumahtanggaan, pengelolaan barang, kehumasan, kepustakaan, dan ketatalaksanaan Dinas;\n6. Penyelenggaraan kepegawaian Dinas;\n7. Pengelolaan keuangan Dinas;\n8. Pengelolaan data dan pengembangan sistem informasi;\n9. Pelaksanaan program pelayanan administrasi perkantoran;\n10. Pelaksanaan program peningkatan sarana dan prasarana aparatur;\n11. Pelaksanaan program peningkatan pengembangan sistem pelaporan capaian kinerja dan keuangan;\n12. Fasilitasi perencanaan dan pengendalian urusan keistimewaan pertanahan dan tata ruang;\n13. Pelaksanaan program sarana prasarana keistimewaan urusan pertanahan dan tata ruang;\n14. Pemantauan dan evaluasi program serta penyusunan laporan kinerja Dinas;\n15. Fasilitasi pelaksanaan koordinasi dan pengembangan kerja sama teknis;\n16. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n17. Pemantauan, evaluasi, dan penyusunan laporan program Sekretariat; dan\n18. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai tugas dan fungsi Dinas.\n \n\nB. BIDANG PENATUSAHAAN DAN PENGENDALIAN PERTANAHAN\n\nTugas:\n\nBidang Penatausahaan dan Pengendalian Pertanahan mempunyai tugas penatausahaan dan pengendalian pertanahan untuk meningkatkan persentase penyelenggaraan administrasi pertanahan sesuai regulasi dan pengajuan permohonan Serat Kekancingan yang ditindaklanjuti.\n\nFungsi:\n\n1. Penyusunan program kerja Bidang Penatausahaan dan Pengendalian Pertanahan;\n2. Penyiapan bahan rumusan kebijakan teknis penatausahaan dan pengendalian pertanahan;\n3. Fasilitasi pengelolaan tanah Kasultanan dan tanah Kadipaten;\n4. Fasilitasi dan koordinasi penatausahaan dan pengendalian pertanahan;\n5. Penyiapan bahan pertimbangan teknis izin lokasi lintas daerah Kabupaten/Kota;\n6. Perencanaan penggunaan tanah yang hamparannya lintas daerah Kabupaten/Kota;\n7. Fasilitasi pelaksanaan survei pemetaan tanah dalam rangka penatausahaan dan pengendalian pertanahan;\n8. Fasilitasi pelaksanaan administrasi tanah Kasultanan dan Kadipaten serta Tanah Desa;\n9. Fasilitasi pelaksanaan pendaftaran Tanah Kasultanan dan Tanah Kadipaten serta Tanah Desa;\n10. Fasilitasi dan koordinasi pengalihan fungsi Tanah Kasultanan dan Tanah Kadipaten serta Tanah Desa;\n11. Penelusuran riwayat perolehan tanah, peruntukan, dan hak penguasaan Tanah Kasultanan dan Tanah Kadipaten serta Tanah Desa;\n12. Fasilitasi penetapan subjek dan objek redistribusi tanah serta ganti kerugian tanah kelebihan maksimum dan tanah absentee lintas daerah Kabupaten/Kota;\n13. Pemantauan, evaluasi, dan penyusunan laporan program Bidang Penatausahaan dan Pengendalian Pertanahan; dan\n14. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Dinas.\n \n\nC. BIDANG PEMANFAATAN, PENANGANAN PERMASALAHAN DAN PENGAWASAN PERTANAHAN\n\nTugas:\n\nBidang Pemanfaatan, Penanganan Permasalahan, dan Pengawasan Pertanahan mempunyai tugas melaksanakan fasilitasi pemanfaatan, penanganan permasalahan dan pengawasan pertanahan untuk meningkatkan persentase desa yang sudah mempunyai Peraturan Desa tentang Pemanfaatan Tanah Desa.\n\nFungsi:\n\n1. Penyusunan program kerja Bidang Pemanfaatan, Penanganan Permasalahan, dan Pengawasan Pertanahan;\n2. Perumusan kebijakan teknis pemanfaatan, penanganan permasalahan dan pengawasan pertanahan;\n3. Penyiapan bahan dan fasilitasi pemanfaatan tanah kosong lintas daerah Kabupaten/Kota;\n4. Pelaksanaan validasi data subjek dan objek pemanfaatan tanah kosong;\n5. Fasilitasi pengawasan dan penertiban pemanfaatan Tanah Kasultanan dan Tanah Kadipaten;\n6. Fasilitasi perlindungan terhadap Tanah Kasultanan dan Tanah Kadipaten serta Tanah Desa;\n7. Fasilitasi penggunaan pemanfaatan Tanah Desa;\n8. Fasilitasi pelepasan Tanah Desa untuk kepentingan umum;\n9. Pengkajian fungsi pertanahan;\n10. Penyiapan bahan pertimbangan teknis izin Tanah Desa;\n11. Fasilitasi penanganan dan penyelesaian permasalahan pertanahan;\n12. Fasilitasi penyelesaian sengketa tanah garapan lintas daerah Kabupaten/Kota;\n13. Fasilitasi penataan dan pengawasan pemanfaatan pertanahan;\n14. Fasilitasi pengawasan pemanfaatan tanah Kasultanan dan Kadipaten serta Tanah Desa;\n15. Pemantauan, evaluasi, dan penyusunan laporan program Bidang Pemanfaatan, Penanganan Permasalahan dan Pengawasan Pertanahan; dan\n16. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Dinas.\n \n\nD. BIDANG PENGATURAN DAN PEMBINAAN TATA RUANG\n\nTugas:\n\nBidang Pengaturan dan Pembinaan Tata Ruang mempunyai tugas Melaksanakan pengaturan dan pembinaan tata ruang untuk meningkatkan persentase ketersediaan dokumen perencanaan pada satuan ruang strategis Kasultanan dan Kadipaten.\n\nFungsi:\n\n1. Penyusunan program kerja Bidang Pengaturan dan Pembinaan Tata Ruang;\n2. Penyiapan bahan rumusan kebijakan teknis pengaturan dan pembinaan rencana tata ruang wilayah provinsi, rencana tata ruang kawasan strategis provinsi dan arahan peraturan zonasi sistem provinsi;\n3. Penyiapan bahan rekomendasi rencana tata ruang kabupaten/kota;\n4. Pelaksanaan koordinasi penyelenggaraan penataan ruang;\n5. Pelaksanaan pengembangan sistem informasi dan komunikasi penataan ruang;\n6. Penyebarluasan informasi penataan ruang;\n7. Pemantauan, evaluasi, dan penyusunan laporan program Bidang Pengaturan dan Pembinaan Tata Ruang; dan\n8. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai dengan tugas dan fungsi Dinas\n \n\nE. BIDANG PELAKSANAAN DAN PENGAWASAN TATA RUANG\n\nTugas:\n\nBidang Pelaksanaan dan Pengawasan Tata Ruang mempunyai tugas menyelenggarakan pelaksanaan dan pengawasan ruang untuk meningkatkan persentase kesesuaian pemanfaatan ruang pada satuan ruang.\n\nFungsi:\n\n1. Penyusunan program kerja Bidang Pelaksanaan Dan Pengawasan Tata Ruang;\n2. Penyiapan bahan rumusan kebijakan teknis pemanfaatan dan pengendalian pemanfaatan ruang;\n3. Pengawasan teknis terhadap penyelenggaraan penataan ruang;\n4. Pengawasan khusus terhadap permasalahan khusus penyelenggaraan penataan ruang;\n5. Pelaksanaan pengendalian pemanfaatan ruang;\n6. Fasilitasi dan koordinasi Penyidik Pegawai Negeri Sipil (PPNS) Tata Ruang;\n7. Pemantauan, evaluasi, dan penyusunan laporan program Bidang Pengendalian dan Pemanfaatan Ruang; dan\n8. Pelaksanaan tugas lain yang diberikan oleh atasan sesuai tugas dan fungsi Dinas.', 2, '2024-11-29 01:21:07', '2024-11-29 01:27:59'),
(130, 45, 'TUGAS', 'DPKP DIY mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang pertanian dan urusan pemerintahan bidang pangan.', 2, '2024-11-29 01:29:00', '2024-11-29 01:29:00'),
(131, 45, 'FUNGSI ', 'Untuk melaksanakan tugas sebagaimana dimaksud dalam Pasal 4, Dinas mempunyai fungsi::\n\n1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis bidang tanaman pangan,hortikultura, perkebunan, peternakan, dan kesehatan hewan serta ketahanan pangan;\n3. Pelaksanaan fasilitasi dan pengembangan produksi tanaman pangan, hortikultura, perkebunan, serta peternakan dan kesehatan hewan;\n4. Pelaksanaan fasilitasi dan pengembangan ketahanan pangan;\n5. Pelaksanaan pengembangan pasca panen, pengolahan, mutu dan pemasaran hasil tanaman pangan, hortikultura, perkebunan, serta peternakan dan kesehatan hewan;\n6. Fasilitasi pembiayaan usaha tanaman pangan, hortikultura, perkebunan, peternakan dan kesehatan hewan serta ketahanan pangan;\n7. Pemberian fasilitasi penyelenggaraan bidang tanaman pangan, hortikultura, perkebunan, peternakan dan kesehatan hewan, serta ketahanan pangan Kabupaten/Kota;\n8. Penyelenggaraan kegiatan bidang tanaman pangan, hortikultura, perkebunan, peternakan dan kesehatan hewan serta ketahanan pangan lintas Kabupaten/Kota;\n9. Pelestarian tradisi tanaman pangan, hortikultura, perkebunan, peternakan dan kesehatan hewan, serta ketahanan pangan;\n10. Pengembangan kemitraan bidang tanaman pangan, hortikultura, perkebunan, peternakan dan kesehatanhewan, serta ketahanan pangan;\n11. Fasilitasi, pelayanan, sertifikasi komoditas tanaman pangan, hortikultura, perkebunan, peternakan dan kesehatan hewan, serta ketahanan pangan;\n12. Fasilitasi sarana dan prasarana tanaman pangan, hortikultura, perkebunan, peternakan dan kesehatan hewan, serta ketahanan pangan;\n13. Penyelenggaraan pembinaan, sertifikasi, dan pengawasan benih tanaman pangan, hortikultura dan perkebunan;\n14. Penyelenggaraan perlindungan tanaman terhadap organisme pengganggu tumbuhan;\n15. Penyelenggaraan pengujian mutu dan keamanan pangan tanaman pangan, hortikultura, perkebunan, dan peternakan;\n16. Penyelenggaraan produksi benih sumber tanaman pangan, hortikultura, dan perkebunan;\n17. Penyelenggaraan produksi bibit ternak dan bibit pakan ternak;\npenyelenggaraan diagnostik kesehatan hewan dan kesehatan masyarakat veteriner;\n19. Pengembangan sumber daya manusia pertanian;\n20. Penyelenggaraan penyuluhan tanaman pangan,hortikultura, perkebunan, peternakan dan kesehatan hewan serta ketahanan pangan;\n21. Penyelenggaraan kelembagaan dan ketenagaan penyuluhan;\n22. Pelaksanaan kegiatan kesekretariatan;\n23. Pelaksanaan pelayanan umum sesuai dengankewenangannya;\n24. Fasilitasi pembinaan reformasi birokrasi Dinas;\n25. Fasilitasi penyusunan kebijakan proses bisnis Dinas;\n26. engembangan teknologi informasi dan komunikasi yang terintegrasi dalam sistem pemerintahan berbasis elektronik lingkup Dinas;\n27. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n28. Pemantauan, pengevaluasian dan pelaporan pelaksanaan kebijakan bidang pertanian dan ketahanan pangan;\n29. Pelaksanaan koordinasi, pemantauan, evaluasi,pembinaan dan pengawasan urusan pemerintahan bidang pertanian dan urusan pemerintahan bidang pangan yang menjadi kewenangan Kabupaten/Kota; dan\n20. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.', 2, '2024-11-29 01:53:13', '2024-11-29 01:53:13'),
(132, 46, 'TUGAS DAN FUNGSI DINAS DINAS SOSIAL DIY', 'Pasal 4\nDinas mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang sosial.\n\nPasal 5\nUntuk melaksanakan tugas sebagaimana dimaksud dalam Pasal 4, Dinas mempunyai fungsi:\na. penyusunan program kerja Dinas;\nb. perumusan kebijakan teknis bidang sosial;\nc. penyelenggaraan rehabilitasi sosial, perlindungan sosial, jaminan sosial, dan pemberdayaan sosial;\nd. pemberian fasilitasi penyelenggaraan kesejahteraan sosial Kabupaten/ Kota;\ne. pelaksanaan pelayanan umum sesuai dengan kewenangannya;\nf. pemberdayaan sumber daya dan mitra kerja bidang sosial;\ng. penguatan, pengembangan, dan pemanfaatan nilai-nilai, norma, dan tradisi luhur dalam penanganan masalah sosial;\nh. pengembangan program bidang sosial;\ni. pelaksanaan kegiatan kesekretariatan;\nj. pelaksanaan dekonsentrasi dan tugas pembantuan;\nk. fasilitasi pembinaan reformasi birokrasi Dinas;\n1. fasilitasi penyusunan kebijakan proses bisnis Dinas;\nm. pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik lingkup Dinas;\nn. pemantauan, pengevaluasian, dan pelaporan pelaksanaan kebijakan bidang sosial;\no. pelaksanaan koodinasi, pembinaan, dan pengawasan urusan pemerintahan bidang sosial yang menjadi\nkewenangan kabupaten/ kota;\np. penyusunan laporan pelaksanaan tugas Dinas; dan\nq. pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.', 2, '2024-11-29 01:54:33', '2024-11-29 01:54:41'),
(133, 47, 'Tugas', 'Membantu Gubernur melaksanakan urusan pemerintahan bidang tenaga kerja dan urusan pemeintahan bidang transmigrasi', 2, '2024-11-29 01:55:37', '2024-11-29 01:55:37'),
(134, 47, 'Fungsi', '1. Penyusunan program kerja Dinas;\n2. Perumusan kebijakan teknis bidang ketenagakerjaan dan transmigrasi;\n3. Pelaksanaan pelatihan kerja berdasarkan kluster kompetensi;\n4. Pelaksanaan pelatihan Higiene Perusahaan, ergonomi, kesehatan kerja dan keselamatan kerja;\n5. Pelaksanaan pembinaan lembaga pelatihan, lembaga sertifikasi profesi, dan tempat uji kompetensi;\n6. Pelaksanaan sertifikasi dan standarisasi kompetensi serta pengukuran dan konsultansi produktivitas;\n7. Pelaksanaan dan pembinaan program pemagangan dalm dan luar negeri;\n8. Penciptaan dan pembinaan perluasan kesempatan kerja di luar hubungan kerja;\n9. Pelindungan pekerja migran Indonesia sebelum dan sesudah bekerja;\n10. Pengelolaan penempatan tenaga kerja dan pembinaan kelembagaan penempatan dan pasar kerja;\n11. Pelaksanaan pembinaan hubungan industrial;\n12. Pembinaan pengupahan dan penyiapan penetapan upah minimum;\n13. Pelaksanaan pengawasan ketenagakerjaan, kewselamatan dan kesehatan kerja;\n14. Pelaksanaan pengujian higiene perusahaan, ergonomi, kesehatan kerja, dan keselamatan kerja;\n15. Pelaksanaan fasilitasi pelaksanaan urusan pemeintahan bidang transmigrasi;\n16. Pelaksanaan Kegiatan kesekretariatan;\n17. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n18. Fasilitasi Pembinaan reformasi birokrasi Dinas;\n19. Fasilitasi penyusnan kebijakan proses bisnis Dinas;\n20. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasi Elektronik lingkud Dinas;\n21. Pemantauan, evaluasi dan penyusunan laporan pelaksanaan kebijakan bidang ketenagakerjaan dan transmigrasi;\n22. Pelaksanaan koordinasi, pemantauan, evaluasi, pembinaan, dan pegnawasan urusan pemerintahan bidan ketenagakerjaan dan transmigrasi yang menjadi kewenangan Kabupaten/Kota;\n23. Penyusunan laporan pelaksanaan tugas Dinas; dan\n24. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Dinas.', 2, '2024-11-29 01:57:09', '2024-11-29 01:57:09'),
(135, 50, 'Tugas Pokok', 'Satpol PP mempunyai tugas membantu Gubernur melaksanakan urusan pemerintahan bidang ketenteraman, ketertiban umum dan perlindungan masyarakat.', 2, '2024-11-29 02:04:27', '2024-11-29 02:04:27'),
(136, 50, 'Fungsi', 'Untuk melaksanakan tugas sebagaimana dimaksud dalam Pasal 4, Satpol PP mempunyai fungsi:\n\n1. Penyusunan program kerja Satpol PP;\n2. Perumusan kebijakan teknis bidang ketenteraman, ketertiban umum, dan perlindungan masyarakat;\n3. Penanganan gangguan ketertiban umum dan ketenteraman serta pelindungan masyarakat lintas Kabupaten/Kota;\n4. Pengamanan aset Pemerintah Daerah serta objek vital daerah;\n5. Penegakan Peraturan Daerah, Peraturan Daerah Istimewa, Peraturan Gubernur;\n6. Pembinaan dan koordinasi Penyidik Pegawai Negeri Sipil;\n7. Pelaksanaan fasilitasi pengembangan kapasitas aparatur, kelembagaan dan kemitraan Satpol PP;\n8. Fasilitasi pembinaan upacara dan Korps Musik;\n9. Pembinaan dan penegakan kode etik profesi\n10. Pelaksanaan fasilitasi dan asistensi pengamanan kediaman Gubernur dan Wakil Gubernur;\n11. Pelaksanaan koordinasi dengan mitra kerja;\n12. Pelaksanaan dekonsentrasi dan tugas pembantuan;\n13. Pelaksanaan kegiatan kesekretariatan;\n14. Pelaksanaan standar pelayanan minimal urusan ketertiban umum dan ketenteraman masyarakat Kabupaten/Kota;\n15. Fasilitasi pembinaan standar pelayanan minimal urusan ketertiban umum dan ketenteraman masyarakat Kabupaten/Kota;\n16. Fasilitasi pembinaan reformasi birokrasi;\n17. Fasilitasi penyusunan kebijakan proses bisnis;\n18. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik;\n19. Pemantauan, evaluasi, dan pelaporan pelaksanaan kebijakan bidang ketenteraman, ketertiban umum, dan pelindungan masyarakat;\n20. Pelaksanaan koordinasi, pembinaan, dan pengawasan urusan pemerintahan bidang ketenteramanm, ketertiban umum, dan perlindungan masyarakat yang menjadi kewenangan Kabupaten/Kota;\n21. Penyusunan laporan pelaksanaan tugas Satpol PP; dan\n22. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Satpol PP.', 2, '2024-11-29 02:06:13', '2024-11-29 02:06:13'),
(137, 51, 'Tugas Sekretariat DPRD DIY', 'Sekretariat DPRD mempunyai tugas membantu dan mendukung kelancaran pelaksanaan tugas, wewenang, fungsi,  hak, kewajiban, tanggung jawab, kedudukan protokoler, dan keuangan DPRD sesuai dengan ketentuan peraturan perundang-undangan.', 2, '2024-11-29 02:06:59', '2024-11-29 02:09:37');
INSERT INTO `subheadings` (`id`, `content_id`, `subheading`, `subheading_description`, `author_id`, `created_at`, `updated_at`) VALUES
(138, 51, 'Sekretariat DPRD DIY Mempunyai Fungsi', '1. Penyusunan program kerja Sekretariat DPRD;\n2. Penyelenggaraan administrasi kesekretariatan;\n3. Penyelenggaraan administrasi keuangan;\n4. Penyiapan tenaga ahli yang diperlukan oleh DPRD;\n5. Penyelenggaraan persidangan dan penyiapan bahan risalah rapat DPRD;\n6. Fasilitasi pelaksanaan pembentukan produk hukum, dokumentasi dan penyebarluasan produk hukum, serta pengkajian dan pengawasan;\n7. Fasilitasi alat kelengkapan DPRD;\n8. Fasilitasi penetapan dan pelantikan Gubernur dan Wakil Gubernur;\n9. Penyelenggaraan administrasi Pergantian Antar Waktu Anggota DPRD;\n10. Fasilitasi pelantikan pimpinan dan anggota DPRD;\n11. Pelaksanaan hubungan masyarakat, data dan teknologi informasi, keprotokolan dan pelayanan aspirasi masyarakat;\n12. Fasilitasi pembinaan reformasi birokrasi Sekretariat DPRD;\n13. Fasilitasi penyusunan kebijakan proses bisnis Sekretariat DPRD;\n14. Pengembangan teknologi informasi dan komunikasi yang terintegrasi dalam Sistem Pemerintahan Berbasis Elektronik dalam lingkup Sekretariat DPRD;\n15. Pemantauan, pengevaluasian, dan pelaporan pelaksanaan tugas Sekretariat DPRD; dan\n16. Pelaksanaan tugas lain yang diberikan oleh Gubernur sesuai dengan tugas dan fungsi Sekretariat DPRD.', 2, '2024-11-29 02:08:44', '2024-11-29 02:09:37'),
(139, 51, 'Visi ', '“Menjadi Institusi yang profesional, antisipatif dan responsif dalam mendukung serta memfasilitasi kinerja dan hasil kerja DPRD”.', 2, '2024-11-29 02:08:56', '2024-11-29 02:09:37'),
(140, 51, 'Misi ', '1. Mewujudkan Peningkatan Pelayanan Internal\n2. Mewujudkan Peningkatan Pelayanan Eksternal\n3. Menjadi sumber informasi kegiatan DPRD dan studi bidang Politik', 2, '2024-11-29 02:09:15', '2024-11-29 02:09:37'),
(141, 52, 's1', '111', 7, '2024-12-05 01:01:43', '2024-12-05 08:42:19'),
(142, 60, 'ss', '<p>sss</p>', 9, '2025-01-19 13:40:47', '2025-01-19 13:40:47'),
(143, 77, 'dd', '<p>dd</p>', 3, '2025-01-19 13:43:09', '2025-01-19 13:43:09'),
(144, 76, 'hhd', '<p>kdkjn</p>', 2, '2025-01-20 03:19:52', '2025-01-20 03:19:52'),
(145, 81, 'ab', '<p>ab</p>', 7, '2025-01-24 06:58:20', '2025-01-24 06:58:20'),
(159, 111, 'kk', '<p>kk</p>', 13, '2025-02-01 15:34:15', '2025-02-01 15:34:15'),
(160, 124, 'gfgf', '<p>fgfg</p>', 13, '2025-02-02 16:32:07', '2025-02-02 16:32:07'),
(162, 135, 'halo kang', '<p>bvbv</p>', 14, '2025-02-04 02:10:59', '2025-02-05 06:49:14'),
(165, 133, 'b', '<p>b</p>', 2, '2025-02-04 03:34:47', '2025-02-04 03:34:47');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `nip` int NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `role_id` int NOT NULL,
  `instance_id` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `nip`, `email`, `password`, `role_id`, `instance_id`, `deleted_at`) VALUES
(2, 'Ahmad Prasetyo', 12345678, 'ahmad.prasetyo@jogjaprov.go.id', 'password12345', 1, 1, NULL),
(3, 'Dewi Lestari k', 223344556, 'dewi.lestari@gmail.com', 'dewi12345', 3, 2, NULL),
(5, 'Rudi Setiawan', 334455667, 'rudi.setiawan@jogjaprov.go.id', 'rudisecure@2024', 1, 21, NULL),
(7, 'Doni', 123456789, 'ddo@yahoo.com', '12321', 1, 19, NULL),
(9, 'Budi Santoso', 123, 'budi.santoso@jogjaprov.go.id', '123', 3, 10, NULL),
(13, 'Superadmin', 1, 'superadmin@gmail.com', 'superadmin', 5, 3, NULL),
(14, 'Luthfi Nurafiq', 123456, 'Luthfi@gmail.com', '123', 3, 12, NULL),
(16, 'ppp balap', 1234, 'p@gmail.com', '123456', 2, 11, NULL),
(20, 'fff', 1244, 'fff@gmail.com', '1234', 2, 15, NULL),
(22, 'Aku', 12233, 'k@gmail.com', '123456', 3, 14, NULL),
(23, 'aku', 1234, 'aku@gmail.com', '123', 2, 15, NULL),
(24, 'aku ganteng', 1234, 'aku@gmail.com', '123', 3, 17, NULL),
(25, 'kamu', 1234, 'kamu@gmail.com', '12', 2, 15, NULL),
(26, 'kamu', 1234, 'kamu@gmail.com', '123', 2, 12, '2025-01-29 15:46:23'),
(27, 'new', 122, 'n@gmail.com', '123', 3, 13, '2025-01-29 15:36:38'),
(28, 'hallllfdfqe2334', 313, 'uu@gmail.com', '123', 3, 16, '2025-01-29 15:43:57'),
(29, 'barufewe', 123, 'b@gmail.com', '123', 3, 12, '2025-01-29 15:54:40'),
(30, 'fakhri taj', 123123, 'f@gmail.com', '123', 2, 13, '2025-01-29 16:02:37'),
(31, 'kkk', 123, 'k@gmail.com', '123', 2, 18, '2025-02-04 10:25:25'),
(32, 'garangan', 1234, 'g@gmail.com', '123', 2, 15, '2025-02-04 10:56:35'),
(33, 'agus', 134, 'agus@gmail.com', 'superadmin', 2, 16, '2025-02-05 22:48:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`author_id`),
  ADD KEY `fk_instance_id` (`instance_id`);

--
-- Indexes for table `content_edit_history`
--
ALTER TABLE `content_edit_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `content_id` (`content_id`),
  ADD KEY `editor_id` (`editor_id`);

--
-- Indexes for table `instance`
--
ALTER TABLE `instance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `subheadings`
--
ALTER TABLE `subheadings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `content` (`content_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_ibfk_1` (`role_id`),
  ADD KEY `instance_id` (`instance_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `content`
--
ALTER TABLE `content`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `content_edit_history`
--
ALTER TABLE `content_edit_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=244;

--
-- AUTO_INCREMENT for table `instance`
--
ALTER TABLE `instance`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `subheadings`
--
ALTER TABLE `subheadings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `content`
--
ALTER TABLE `content`
  ADD CONSTRAINT `fk_instance_id` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `user` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `content_edit_history`
--
ALTER TABLE `content_edit_history`
  ADD CONSTRAINT `content_edit_history_ibfk_1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `content_edit_history_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`);

--
-- Constraints for table `subheadings`
--
ALTER TABLE `subheadings`
  ADD CONSTRAINT `subheadings_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
