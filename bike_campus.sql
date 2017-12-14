-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 14 Des 2017 pada 15.47
-- Versi Server: 10.1.16-MariaDB
-- PHP Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bike@campus`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `civitas`
--

CREATE TABLE `civitas` (
  `no_induk` varchar(10) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `no_telepon` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `civitas`
--

INSERT INTO `civitas` (`no_induk`, `nama`, `alamat`, `email`, `no_telepon`) VALUES
('18215037', 'Jundi amir syuhada', 'jl. tubagus ismail raya no.90', 'jundiamir45@gmail.com', '089518978053'),
('18218001', 'Yesa', 'jl. cislam 20', '18218001@std.stei.itb.ac.id', '089518978054'),
('18218002', 'Nani Kore', 'jl. Terus', '18218002@std.stei.itb.ac.id', '085225016501');

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `no_peminjaman` int(12) NOT NULL,
  `no_induk` varchar(10) NOT NULL,
  `id_sepeda` varchar(5) NOT NULL,
  `no_shelter_ambil` varchar(3) NOT NULL,
  `no_shelter_kembali` varchar(3) NOT NULL,
  `waktu_ambil` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `waktu_kembali` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`no_peminjaman`, `no_induk`, `id_sepeda`, `no_shelter_ambil`, `no_shelter_kembali`, `waktu_ambil`, `waktu_kembali`) VALUES
(1, '18215037', '1', '1', '1', '2017-12-13 13:07:22', '2017-12-14 04:00:00'),
(5, '', '', '0', '0', '2017-12-14 14:34:26', '0000-00-00 00:00:00'),
(6, '', '', '', '', '2017-12-14 14:38:30', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sepeda`
--

CREATE TABLE `sepeda` (
  `id_sepeda` varchar(5) NOT NULL,
  `kondisi` char(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `sepeda`
--

INSERT INTO `sepeda` (`id_sepeda`, `kondisi`) VALUES
('1', 'baik'),
('10', 'baik'),
('11', 'baik'),
('12', 'baik'),
('13', 'baik'),
('14', 'baik'),
('15', 'baik'),
('16', 'baik'),
('17', 'baik'),
('18', 'baik'),
('19', 'baik'),
('2', 'baik'),
('20', 'baik'),
('21', 'baik'),
('22', 'baik'),
('23', 'baik'),
('24', 'baik'),
('25', 'baik'),
('26', 'baik'),
('27', 'baik'),
('28', 'baik'),
('29', 'baik'),
('3', 'baik'),
('30', 'baik'),
('4', 'rusak'),
('5', 'baik'),
('6', 'baik'),
('7', 'rusak'),
('8', 'baik'),
('9', 'baik');

-- --------------------------------------------------------

--
-- Struktur dari tabel `shelter`
--

CREATE TABLE `shelter` (
  `no_shelter` varchar(2) NOT NULL,
  `lokasi` varchar(20) NOT NULL,
  `kapasitas` int(5) NOT NULL,
  `jumlah_sepeda` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `shelter`
--

INSERT INTO `shelter` (`no_shelter`, `lokasi`, `kapasitas`, `jumlah_sepeda`) VALUES
('1', 'Aula Barat', 20, 10),
('2', 'Perpustakaan', 20, 9),
('3', 'Seni Rupa', 20, 5),
('4', 'Gku Barat', 20, 7),
('5', 'Gku Timur', 20, 6),
('6', 'CADL', 20, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `civitas`
--
ALTER TABLE `civitas`
  ADD PRIMARY KEY (`no_induk`),
  ADD UNIQUE KEY `no_telepon` (`no_telepon`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`no_peminjaman`),
  ADD UNIQUE KEY `no_induk` (`no_induk`,`id_sepeda`,`no_shelter_ambil`,`no_shelter_kembali`),
  ADD UNIQUE KEY `no_peminjaman` (`no_peminjaman`),
  ADD UNIQUE KEY `no_peminjaman_2` (`no_peminjaman`),
  ADD KEY `no_shelter_ambil` (`no_shelter_ambil`),
  ADD KEY `no_shelter_kembali` (`no_shelter_kembali`),
  ADD KEY `id_sepeda` (`id_sepeda`);

--
-- Indexes for table `sepeda`
--
ALTER TABLE `sepeda`
  ADD PRIMARY KEY (`id_sepeda`),
  ADD UNIQUE KEY `id_sepeda` (`id_sepeda`);

--
-- Indexes for table `shelter`
--
ALTER TABLE `shelter`
  ADD PRIMARY KEY (`no_shelter`),
  ADD UNIQUE KEY `lokasi` (`lokasi`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `no_peminjaman` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
