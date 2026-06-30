-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 30, 2026 at 05:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `api_demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `id` int(11) NOT NULL,
  `device_name` varchar(50) DEFAULT NULL,
  `device_type` enum('LED','SENSOR') DEFAULT NULL,
  `pin` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`id`, `device_name`, `device_type`, `pin`, `status`, `created_at`) VALUES
(1, 'LED1', 'LED', 13, 'OFF', '2026-06-30 03:42:31'),
(2, 'LED2', 'LED', 12, 'OFF', '2026-06-30 03:42:31'),
(3, 'Temperature', 'SENSOR', 34, 'ACTIVE', '2026-06-30 03:42:31'),
(4, 'Humidity', 'SENSOR', 35, 'ACTIVE', '2026-06-30 03:42:31'),
(5, 'Soil Moisture', 'SENSOR', 36, 'ACTIVE', '2026-06-30 03:42:31');

-- --------------------------------------------------------

--
-- Table structure for table `led_status`
--

CREATE TABLE `led_status` (
  `id` int(11) NOT NULL,
  `led_name` varchar(30) DEFAULT NULL,
  `status` enum('ON','OFF') DEFAULT NULL,
  `datetime` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `led_status`
--

INSERT INTO `led_status` (`id`, `led_name`, `status`, `datetime`) VALUES
(1, 'LED1', 'ON', '2026-06-30 10:44:21'),
(2, 'LED2', 'OFF', '2026-06-30 10:44:21');

-- --------------------------------------------------------

--
-- Table structure for table `sensor_data`
--

CREATE TABLE `sensor_data` (
  `id` int(11) NOT NULL,
  `sensor_name` varchar(50) DEFAULT NULL,
  `sensor_value` float DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `datetime` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sensor_data`
--

INSERT INTO `sensor_data` (`id`, `sensor_name`, `sensor_value`, `unit`, `datetime`) VALUES
(1, 'Temperature', 31.5, '°C', '2026-06-30 10:44:04'),
(2, 'Humidity', 68, '%', '2026-06-30 10:44:04'),
(3, 'Soil Moisture', 55, '%', '2026-06-30 10:44:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `led_status`
--
ALTER TABLE `led_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sensor_data`
--
ALTER TABLE `sensor_data`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `led_status`
--
ALTER TABLE `led_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sensor_data`
--
ALTER TABLE `sensor_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
