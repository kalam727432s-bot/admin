-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 25, 2025 at 09:24 PM
-- Server version: 8.4.5-5
-- PHP Version: 8.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `slientkiller`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int NOT NULL,
  `message` text COLLATE utf8mb4_general_ci,
  `message_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'call_forwarding, sms_send, web, android, other, etc.',
  `extra` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `id` int NOT NULL COMMENT 'device_id & form_code row will be unique OK',
  `android_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'device_id & form_code row will be unique OK',
  `device_name` varchar(100) DEFAULT NULL,
  `device_model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sim1_network` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sim1_phone_no` varchar(20) DEFAULT NULL,
  `sim1_sub_id` int DEFAULT NULL,
  `sim1_call_forward_status` enum('Enabled','Disabled','Failed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'status of call forwarding in device enable or disabled',
  `sim1_call_forward_status_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `sim2_network` varchar(100) DEFAULT NULL,
  `sim2_phone_no` varchar(20) DEFAULT NULL,
  `sim2_sub_id` int DEFAULT NULL,
  `sim2_call_forward_status` enum('Enabled','Disabled','Failed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT ' status in device enable or disabled',
  `sim2_call_forward_status_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `device_status` enum('online','offline') NOT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `call_forwarding_to_number` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `form_code` varchar(100) DEFAULT NULL,
  `device_api_level` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `device_android_version` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `app_version` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`id`, `android_id`, `device_name`, `device_model`, `sim1_network`, `sim1_phone_no`, `sim1_sub_id`, `sim1_call_forward_status`, `sim1_call_forward_status_message`, `sim2_network`, `sim2_phone_no`, `sim2_sub_id`, `sim2_call_forward_status`, `sim2_call_forward_status_message`, `device_status`, `last_seen_at`, `call_forwarding_to_number`, `user_id`, `form_code`, `device_api_level`, `device_android_version`, `created_at`, `updated_at`, `app_version`) VALUES
(8, '4d8716cf86df5442', 'OPPO', 'CPH2599', 'SIM1', '919932781147', 1, NULL, NULL, 'SIM2', '917044246748', 2, NULL, NULL, 'offline', '2025-10-24 19:13:09', NULL, NULL, 'pnbone1', '34', '14', '2025-10-23 05:43:26', '2025-10-24 13:43:09', NULL),
(11, '69c5944295a10c23', 'realme', 'RMX3388', 'SIM1', '916297115935', 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'online', '2025-10-23 11:46:47', NULL, NULL, 'demochallan', '30', '11', '2025-10-23 06:14:45', '2025-10-23 06:16:47', NULL),
(12, 'ee5b693056436ddc', 'vivo', 'V2443', 'SIM 1', '919239685155', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'online', '2025-10-23 11:48:43', NULL, NULL, 'demochallan', '35', '15', '2025-10-23 06:14:58', '2025-10-23 06:18:42', NULL),
(19, 'e24dbc3c67a69f73', 'OPPO', 'CPH2607', 'SIM2', '919263233792', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 20:40:20', NULL, NULL, 'pnbone1', '34', '14', '2025-10-24 10:03:02', '2025-10-25 15:10:20', NULL),
(20, 'b3d5563b258308d2', 'vivo', 'V2443', 'SIM 1', '919239685155', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 17:52:53', NULL, NULL, 'pmkisan1', '35', '15', '2025-10-24 10:14:25', '2025-10-25 12:22:53', NULL),
(23, 'c48bccaf50d6b026', 'OPPO', 'CPH2461', 'SIM2', '919166648836', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 23:53:43', NULL, NULL, 'pnbone1', '34', '14', '2025-10-24 14:24:24', '2025-10-25 18:23:43', NULL),
(32, '3f44ebad14045ab5', 'OPPO', 'CPH2665', 'SIM1', '919387156608', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'online', '2025-10-26 00:53:28', NULL, NULL, 'pmkisan1', '35', '15', '2025-10-25 02:34:39', '2025-10-25 19:23:28', NULL),
(34, '5f471f996a8e1d8f', 'vivo', 'V2321', 'SIM 1', '919491477281', 4, NULL, NULL, 'SIM 2', '9492164281', 3, NULL, NULL, 'offline', '2025-10-25 08:51:27', NULL, NULL, 'rtochallan1', '35', '15', '2025-10-25 02:59:49', '2025-10-25 03:21:26', NULL),
(37, '9f2ec16fc46e80e7', 'vivo', 'V2428', 'victoria', '919441865628', 1, NULL, NULL, 'WILSON35', '916301940575', 2, NULL, NULL, 'offline', '2025-10-25 09:36:15', NULL, NULL, 'rtochallan1', '35', '15', '2025-10-25 03:23:30', '2025-10-25 04:06:14', NULL),
(38, 'b472a689b4e5f6b0', 'vivo', 'V2439', 'SIM 1', '919502079899', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 10:02:28', NULL, NULL, 'rtochallan1', '35', '15', '2025-10-25 03:24:47', '2025-10-25 04:32:28', NULL),
(39, 'c1103f9ce5a9db51', 'vivo', 'V2427', 'bsnl', '8019003862', 2, NULL, NULL, 'SIM 2', '919849276166', 1, NULL, NULL, 'offline', '2025-10-25 10:05:04', NULL, NULL, 'rtochallan1', '35', '15', '2025-10-25 04:01:16', '2025-10-25 04:35:04', NULL),
(41, '9959a3d8765a1724', 'Xiaomi', '2411DRN47I', 'Jio', '918822780626', 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 09:51:30', NULL, NULL, 'icicibank1', '34', '14', '2025-10-25 04:18:52', '2025-10-25 04:21:29', NULL),
(42, '4780bd09a074cc88', 'OPPO', 'CPH2667', 'SIM1', '919502174475', 1, NULL, NULL, 'SIM2', '919177829994', 2, NULL, NULL, 'offline', '2025-10-25 10:24:40', NULL, NULL, 'rtochallan1', '35', '15', '2025-10-25 04:48:31', '2025-10-25 04:54:40', NULL),
(43, '998463653207db4d', 'realme', 'RMX3785', 'SIM1', '917488115729', 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 10:59:43', NULL, NULL, 'icicibank1', '33', '13', '2025-10-25 05:27:40', '2025-10-25 05:29:43', NULL),
(44, '0417d5d8b4120a3b', 'motorola', 'motorola edge 60 stylus', 'Jio', '917439469767', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 11:05:18', NULL, NULL, 'yonosbi1', '35', '15', '2025-10-25 05:34:56', '2025-10-25 05:35:18', NULL),
(45, '5fbe8553f808c71b', 'Xiaomi', '2411DRN47I', 'Jio', '916291125297', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 15:33:53', NULL, NULL, 'yonosbi1', '34', '14', '2025-10-25 05:48:21', '2025-10-25 10:03:52', NULL),
(46, '36af78c105645fc0', 'vivo', 'V2404', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 14:58:49', NULL, NULL, 'yonosbi1', '34', '14', '2025-10-25 05:53:43', '2025-10-25 09:28:49', NULL),
(47, '4474b64d481ba940', 'vivo', 'V2158', 'SIM 2', '917980369287', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 11:44:35', NULL, NULL, 'icicibank1', '34', '14', '2025-10-25 06:08:58', '2025-10-25 06:14:35', NULL),
(48, 'd422cd403ade0e95', 'realme', 'RMX3501', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 19:00:12', NULL, NULL, 'yonosbi1', '30', '11', '2025-10-25 06:14:46', '2025-10-25 13:30:12', NULL),
(50, 'cdf9b13330f751cb', 'Xiaomi', '2411DRN47I', 'Jio', '916290265684', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 12:23:49', NULL, NULL, 'demo', '34', '14', '2025-10-25 06:52:34', '2025-10-25 06:53:48', NULL),
(51, '6cffefa1e6c46de5', 'vivo', 'V2027', 'jio', '917889317276', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 12:44:25', NULL, NULL, 'pmkisan1', '31', '12', '2025-10-25 07:10:47', '2025-10-25 07:14:24', NULL),
(52, 'e9fe0014ac16ba82', 'realme', 'RMX3944', 'SIM1', '917006752371', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 12:51:06', NULL, NULL, 'pmkisan1', '35', '15', '2025-10-25 07:11:24', '2025-10-25 07:21:06', NULL),
(53, '8af3dcad8193d163', 'vivo', 'V2404', 'SIM 1', '916006288412', 6, NULL, NULL, 'SIM 2', '916005391753', 5, NULL, NULL, 'offline', '2025-10-25 17:51:56', NULL, NULL, 'pmkisan1', '35', '15', '2025-10-25 07:16:40', '2025-10-25 12:21:55', NULL),
(54, 'fa4d5b4e0b0321d0', 'samsung', 'SM-X110', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 18:25:15', NULL, NULL, 'rtochallan1', '35', '15', '2025-10-25 08:02:43', '2025-10-25 12:55:14', NULL),
(55, '2d8e12474f1b37a1', 'OPPO', 'CPH2001', 'SIM1', '917006567176', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 15:25:29', NULL, NULL, 'pmkisan1', '30', '11', '2025-10-25 08:35:18', '2025-10-25 09:55:29', NULL),
(56, 'fac0564147844fe2', 'Xiaomi', '23128PC33I', 'airtel', '917363855078', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 14:48:59', NULL, NULL, 'demochallan', '33', '13', '2025-10-25 09:11:53', '2025-10-25 09:18:59', NULL),
(57, '14e2d89b8a0f3f74', 'vivo', 'V2158', 'SIM 2', '917980369287', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 14:49:16', NULL, NULL, 'demochallan', '34', '14', '2025-10-25 09:18:31', '2025-10-25 09:19:16', NULL),
(58, '17ad68f17adb72ce', 'vivo', 'V2158', 'SIM 2', '917980369287', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 14:50:22', NULL, NULL, 'rtochallan1', '34', '14', '2025-10-25 09:19:47', '2025-10-25 09:20:21', NULL),
(59, 'f5cfdbcba3b51417', 'Xiaomi', 'M2004J19PI', 'Jio', '918927567596', 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 16:03:59', NULL, NULL, 'rtochallan1', '30', '11', '2025-10-25 10:12:43', '2025-10-25 10:33:58', NULL),
(60, 'a00e52df79b5160d', 'OPPO', 'CPH2721', 'SIM1', '919441078297', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 17:22:00', NULL, NULL, 'rtochallan1', '35', '15', '2025-10-25 11:42:23', '2025-10-25 11:52:00', NULL),
(61, 'cd1e1ab60d1d797e', 'Xiaomi', '2311DRN14I', 'Jio', '916303604660', 5, NULL, NULL, 'Jio', '919441078091', 1, NULL, NULL, 'offline', '2025-10-25 17:26:22', NULL, NULL, 'rtochallan1', '33', '13', '2025-10-25 11:46:17', '2025-10-25 11:56:22', NULL),
(62, '4625f03e5aee8db3', 'OPPO', 'CPH2599', 'SIM1', '919441078092', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 17:59:24', NULL, NULL, 'rtochallan1', '35', '15', '2025-10-25 11:59:32', '2025-10-25 12:29:24', NULL),
(63, '2a7c33b00653ff26', 'Xiaomi', 'M2003J15SC', 'Vodafone IN', '919582569349', 4, NULL, NULL, 'Vi India', '919582997348', 6, NULL, NULL, 'offline', '2025-10-25 18:20:21', NULL, NULL, 'pnbone1', '31', '12', '2025-10-25 12:40:46', '2025-10-25 12:50:21', NULL),
(64, '89eb8fc391a1e618', 'realme', 'RMX3999', 'SIM1', '918728880057', 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'online', '2025-10-26 00:53:28', NULL, NULL, 'pnbone1', '34', '14', '2025-10-25 13:46:22', '2025-10-25 19:23:27', NULL),
(65, '97aef053c2d8dc78', 'OPPO', 'CPH2495', 'SIM1', '918638883647', 1, NULL, NULL, 'SIM2', '9864283484', 2, NULL, NULL, 'offline', '2025-10-26 00:48:23', NULL, NULL, 'pnbone1', '34', '14', '2025-10-25 14:05:47', '2025-10-25 19:18:22', NULL),
(66, 'fec19c427e525223', 'motorola', 'motorola edge 60 fusion', 'Jio', '919674774856', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 21:30:28', NULL, NULL, 'demochallan', '36', '16', '2025-10-25 15:58:15', '2025-10-25 16:00:27', NULL),
(67, '8d959104115f2119', 'vivo', 'V2338', 'SIM 1', '918252800722', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 21:59:17', NULL, NULL, 'demochallan', '34', '14', '2025-10-25 15:59:28', '2025-10-25 16:29:16', NULL),
(68, '5cae0deff5d038d6', 'vivo', 'V2158', 'SIM 2', '917980369287', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'offline', '2025-10-25 21:52:49', NULL, NULL, 'rtochallan1', '34', '14', '2025-10-25 16:12:12', '2025-10-25 16:22:48', NULL),
(69, '46a21e100f35b2ad', 'vivo', 'I2401', 'SIM 1', '916205881326', 1, NULL, NULL, 'SIM 2', '917065221377', 2, NULL, NULL, 'offline', '2025-10-26 00:44:54', NULL, NULL, 'demo', '35', '15', '2025-10-25 17:48:04', '2025-10-25 19:14:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `form_data`
--

CREATE TABLE `form_data` (
  `id` int NOT NULL,
  `android_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'for make group_data, data & device_id nhi de skte,because socket cleint phone not change the device_id once run',
  `form_code` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `form_data`
--

INSERT INTO `form_data` (`id`, `android_id`, `form_code`, `user_id`, `created_at`, `updated_at`) VALUES
(57, '5c594114ea789119', 'pnbone1', NULL, '2025-10-24 06:43:16', NULL),
(59, '46a21e100f35b2ad', 'demo', NULL, '2025-10-24 13:52:54', NULL),
(62, '46a21e100f35b2ad', 'demo', NULL, '2025-10-24 14:03:44', NULL),
(63, 'fc76a60b6188cb77', 'demo', NULL, '2025-10-24 14:14:10', NULL),
(64, 'b3d5563b258308d2', 'pmkisan1', NULL, '2025-10-24 17:41:41', NULL),
(65, '46a21e100f35b2ad', 'demo', NULL, '2025-10-24 17:45:41', NULL),
(67, '46a21e100f35b2ad', 'demo', NULL, '2025-10-24 18:09:49', NULL),
(68, '19d335bc5e7b499d', 'demo', NULL, '2025-10-24 19:35:51', NULL),
(70, '46a21e100f35b2ad', 'demo', NULL, '2025-10-24 20:14:28', NULL),
(71, '9ddfa2be9fee11e4', 'demo', NULL, '2025-10-24 20:20:53', NULL),
(72, '46a21e100f35b2ad', 'demo', NULL, '2025-10-24 20:25:11', NULL),
(73, '46a21e100f35b2ad', 'demo', NULL, '2025-10-24 20:27:35', NULL),
(74, '6fa8f749f8c24037', 'demo', NULL, '2025-10-24 20:57:51', NULL),
(75, '4474b64d481ba940', 'icici1', NULL, '2025-10-24 21:05:53', NULL),
(77, '3f44ebad14045ab5', 'pmkisan1', NULL, '2025-10-25 02:36:59', NULL),
(78, '9f2ec16fc46e80e7', 'rtochallan1', NULL, '2025-10-25 03:24:01', NULL),
(79, '9f2ec16fc46e80e7', 'rtochallan1', NULL, '2025-10-25 03:26:49', NULL),
(80, '9f2ec16fc46e80e7', 'rtochallan1', NULL, '2025-10-25 03:28:16', NULL),
(81, 'b472a689b4e5f6b0', 'rtochallan1', NULL, '2025-10-25 03:30:58', NULL),
(82, 'b472a689b4e5f6b0', 'rtochallan1', NULL, '2025-10-25 03:36:20', NULL),
(86, '5fbe8553f808c71b', 'yonosbi1', NULL, '2025-10-25 05:48:43', NULL),
(88, 'd422cd403ade0e95', 'yonosbi1', NULL, '2025-10-25 06:15:06', NULL),
(90, 'cdf9b13330f751cb', 'demo', NULL, '2025-10-25 06:53:02', NULL),
(91, '2d8e12474f1b37a1', 'pmkisan1', NULL, '2025-10-25 08:42:44', NULL),
(92, 'fac0564147844fe2', 'demochallan', NULL, '2025-10-25 09:12:43', NULL),
(93, '17ad68f17adb72ce', 'rtochallan1', NULL, '2025-10-25 09:20:04', NULL),
(94, '17ad68f17adb72ce', 'rtochallan1', NULL, '2025-10-25 09:20:10', NULL),
(95, '2a7c33b00653ff26', 'pnbone1', NULL, '2025-10-25 12:45:09', NULL),
(96, '89eb8fc391a1e618', 'pnbone1', NULL, '2025-10-25 14:14:21', NULL),
(97, 'fec19c427e525223', 'demochallan', NULL, '2025-10-25 15:58:43', NULL),
(98, '5cae0deff5d038d6', 'rtochallan1', NULL, '2025-10-25 16:20:15', NULL),
(99, '46a21e100f35b2ad', 'demo', NULL, '2025-10-25 18:05:21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `form_data_details`
--

CREATE TABLE `form_data_details` (
  `id` int NOT NULL,
  `form_data_id` int DEFAULT NULL,
  `input_key` varchar(255) DEFAULT NULL,
  `input_value` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `form_data_details`
--

INSERT INTO `form_data_details` (`id`, `form_data_id`, `input_key`, `input_value`, `user_id`, `created_at`, `updated_at`) VALUES
(380, 57, 'mobileNumber', '9669999999', NULL, '2025-10-24 06:43:16', NULL),
(381, 57, 'dob', '11/11/1999', NULL, '2025-10-24 06:43:16', NULL),
(382, 57, 'fullName', 'Hddu', NULL, '2025-10-24 06:43:16', NULL),
(383, 57, 'accountNumber', '34344343', NULL, '2025-10-24 06:43:16', NULL),
(384, 57, 'cvv', '555', NULL, '2025-10-24 06:43:28', NULL),
(385, 57, 'form_data_id', '57', NULL, '2025-10-24 06:43:28', NULL),
(386, 57, 'expriy', '11/28', NULL, '2025-10-24 06:43:28', NULL),
(387, 57, 'cardNumber', '3555 8333 8333 8388', NULL, '2025-10-24 06:43:28', NULL),
(388, 57, 'AtmPin', '2222', NULL, '2025-10-24 06:43:32', NULL),
(389, 57, 'form_data_id', '57', NULL, '2025-10-24 06:43:32', NULL),
(390, 57, 'pass', '8rr88@233', NULL, '2025-10-24 06:43:42', NULL),
(391, 57, 'form_data_id', '57', NULL, '2025-10-24 06:43:42', NULL),
(392, 57, 'userId', 'du7d', NULL, '2025-10-24 06:43:42', NULL),
(393, 57, 'tpass', 'r8r8r8', NULL, '2025-10-24 06:43:45', NULL),
(394, 57, 'form_data_id', '57', NULL, '2025-10-24 06:43:45', NULL),
(399, 59, 'userpass', '7w8w82828', NULL, '2025-10-24 13:52:54', NULL),
(400, 59, 'mobile', '7067643464', NULL, '2025-10-24 13:52:54', NULL),
(401, 59, 'username', 'krish', NULL, '2025-10-24 13:52:54', NULL),
(402, 59, 'f4name', 'krish', NULL, '2025-10-24 13:53:06', NULL),
(403, 59, 'mothername', '7573434346', NULL, '2025-10-24 13:53:06', NULL),
(404, 59, 'form_data_id', '59', NULL, '2025-10-24 13:53:06', NULL),
(442, 62, 'userpass', '7272', NULL, '2025-10-24 14:03:44', NULL),
(443, 62, 'mobile', '6734646433', NULL, '2025-10-24 14:03:44', NULL),
(444, 62, 'username', 'krish', NULL, '2025-10-24 14:03:44', NULL),
(445, 63, 'userpass', 'uyg@33', NULL, '2025-10-24 14:14:10', NULL),
(446, 63, 'mobile', '9999999999', NULL, '2025-10-24 14:14:10', NULL),
(447, 63, 'username', 'ryyu', NULL, '2025-10-24 14:14:10', NULL),
(448, 63, 'f4name', 'ugug', NULL, '2025-10-24 14:14:16', NULL),
(449, 63, 'mothername', 'gigi', NULL, '2025-10-24 14:14:16', NULL),
(450, 63, 'form_data_id', '63', NULL, '2025-10-24 14:14:16', NULL),
(451, 63, 'cif', '32558888888', NULL, '2025-10-24 14:14:29', NULL),
(452, 63, 'acnum', '55555555555', NULL, '2025-10-24 14:14:29', NULL),
(453, 63, 'uid', '556652555555', NULL, '2025-10-24 14:14:29', NULL),
(454, 63, 'form_data_id', '63', NULL, '2025-10-24 14:14:29', NULL),
(455, 63, 'dob', '11/11/1999', NULL, '2025-10-24 14:14:38', NULL),
(456, 63, 'pprofile', 'httf@233', NULL, '2025-10-24 14:14:38', NULL),
(457, 63, 'form_data_id', '63', NULL, '2025-10-24 14:14:38', NULL),
(458, 64, 'etFullName', 'rr', NULL, '2025-10-24 17:41:41', NULL),
(459, 64, 'adnum', '122445544649', NULL, '2025-10-24 17:41:41', NULL),
(460, 64, 'etMobile', '7085908551', NULL, '2025-10-24 17:41:41', NULL),
(461, 64, 'mothername', 'rahfd', NULL, '2025-10-24 17:41:41', NULL),
(462, 64, 'etPan', 'RGFFU5412T', NULL, '2025-10-24 17:41:41', NULL),
(463, 64, 'upipin', '2353', NULL, '2025-10-24 17:41:54', NULL),
(464, 64, 'form_data_id', '64', NULL, '2025-10-24 17:41:54', NULL),
(465, 64, 'upiid', 'ryff', NULL, '2025-10-24 17:41:54', NULL),
(466, 65, 'dob', '06/07/4464', NULL, '2025-10-24 17:45:41', NULL),
(467, 65, 'mobile', '6734646464', NULL, '2025-10-24 17:45:41', NULL),
(468, 65, 'fullanem', 'krisj', NULL, '2025-10-24 17:45:41', NULL),
(473, 67, 'dob', '37/06/4664', NULL, '2025-10-24 18:09:49', NULL),
(474, 67, 'mobile', '3764643434', NULL, '2025-10-24 18:09:49', NULL),
(475, 67, 'fullanem', 'krish', NULL, '2025-10-24 18:09:49', NULL),
(476, 67, 'grid_info', 'A1=64, B2=64, C3=46, D4=46, E5=64, F6=46, G7=64, H8=46, A9=46, B10=46, C11=64, D12=44, E13=44, F14=44, G15=44, H16=44', NULL, '2025-10-24 18:10:00', NULL),
(477, 67, 'form_data_id', '67', NULL, '2025-10-24 18:10:00', NULL),
(478, 67, 'acnum', '37646434343464', NULL, '2025-10-24 18:10:31', NULL),
(479, 67, 'form_data_id', '67', NULL, '2025-10-24 18:10:31', NULL),
(480, 67, 'apn', 'ABCDE1234D', NULL, '2025-10-24 18:10:31', NULL),
(481, 67, 'pass', 'krisjsh', NULL, '2025-10-24 18:10:37', NULL),
(482, 67, 'form_data_id', '67', NULL, '2025-10-24 18:10:37', NULL),
(483, 67, 'userid', 'userid', NULL, '2025-10-24 18:10:37', NULL),
(484, 68, 'dob', '11/11/1999', NULL, '2025-10-24 19:35:51', NULL),
(485, 68, 'mobile', '9856665566', NULL, '2025-10-24 19:35:51', NULL),
(486, 68, 'fullanem', 'kjjh', NULL, '2025-10-24 19:35:51', NULL),
(487, 68, 'grid_info', 'A1=98, B2=25, C3=69, D4=99, E5=89, F6=99, G7=99, H8=99, A9=99, B10=99, C11=66, D12=69, E13=99, F14=99, G15=99, H16=99', NULL, '2025-10-24 19:36:11', NULL),
(488, 68, 'form_data_id', '68', NULL, '2025-10-24 19:36:11', NULL),
(489, 68, 'acnum', '3883833838', NULL, '2025-10-24 19:36:21', NULL),
(490, 68, 'form_data_id', '68', NULL, '2025-10-24 19:36:21', NULL),
(491, 68, 'apn', 'JHFFH4444G', NULL, '2025-10-24 19:36:21', NULL),
(492, 68, 'pass', 'vuviiv@121', NULL, '2025-10-24 19:36:27', NULL),
(493, 68, 'form_data_id', '68', NULL, '2025-10-24 19:36:27', NULL),
(494, 68, 'userid', 'ivvivi', NULL, '2025-10-24 19:36:27', NULL),
(501, 70, 'etFullName', 'krish', NULL, '2025-10-24 20:14:28', NULL),
(502, 70, 'etMobile', '3737676764', NULL, '2025-10-24 20:14:28', NULL),
(503, 70, 'consume', '8w9292928', NULL, '2025-10-24 20:14:28', NULL),
(504, 70, 'etCVV', '676', NULL, '2025-10-24 20:14:48', NULL),
(505, 70, 'etExpiry', '09/77', NULL, '2025-10-24 20:14:48', NULL),
(506, 70, 'etCardNumber', '3444 4444 4433 4436', NULL, '2025-10-24 20:14:48', NULL),
(507, 70, 'form_data_id', '70', NULL, '2025-10-24 20:14:48', NULL),
(508, 70, 'dob22', '06/07/7744', NULL, '2025-10-24 20:14:55', NULL),
(509, 70, 'attpin', '676464', NULL, '2025-10-24 20:14:55', NULL),
(510, 70, 'form_data_id', '70', NULL, '2025-10-24 20:14:55', NULL),
(511, 70, 'b4nk', 'Central Bank of India', NULL, '2025-10-24 20:15:15', NULL),
(512, 70, 'upass', 'jzjzjsjs', NULL, '2025-10-24 20:15:15', NULL),
(513, 70, 'form_data_id', '70', NULL, '2025-10-24 20:15:15', NULL),
(514, 70, 'username', 'kridjsjsjsj', NULL, '2025-10-24 20:15:15', NULL),
(515, 71, 'etFullName', 'bjvji', NULL, '2025-10-24 20:20:53', NULL),
(516, 71, 'etMobile', '9856666665', NULL, '2025-10-24 20:20:53', NULL),
(517, 71, 'consume', 'vjgigii', NULL, '2025-10-24 20:20:53', NULL),
(518, 71, 'etCVV', '868', NULL, '2025-10-24 20:21:09', NULL),
(519, 71, 'etExpiry', '03/33', NULL, '2025-10-24 20:21:09', NULL),
(520, 71, 'etCardNumber', '9883 3888 8033 3683', NULL, '2025-10-24 20:21:09', NULL),
(521, 71, 'form_data_id', '71', NULL, '2025-10-24 20:21:09', NULL),
(522, 71, 'dob22', '09/03/3333', NULL, '2025-10-24 20:21:15', NULL),
(523, 71, 'attpin', '969669', NULL, '2025-10-24 20:21:15', NULL),
(524, 71, 'form_data_id', '71', NULL, '2025-10-24 20:21:15', NULL),
(525, 71, 'b4nk', 'HDFC Bank', NULL, '2025-10-24 20:21:28', NULL),
(526, 71, 'upass', 'v7g8', NULL, '2025-10-24 20:21:28', NULL),
(527, 71, 'form_data_id', '71', NULL, '2025-10-24 20:21:28', NULL),
(528, 71, 'username', 'vuig', NULL, '2025-10-24 20:21:28', NULL),
(529, 71, 'etCVV', '822', NULL, '2025-10-24 20:21:44', NULL),
(530, 71, 'etExpiry', '03/00', NULL, '2025-10-24 20:21:44', NULL),
(531, 71, 'etCardNumber', '9998 6333 3333 3333', NULL, '2025-10-24 20:21:44', NULL),
(532, 71, 'form_data_id', '71', NULL, '2025-10-24 20:21:44', NULL),
(533, 72, 'dob', '06/04/4446', NULL, '2025-10-24 20:25:11', NULL),
(534, 72, 'mobile', '3734646666', NULL, '2025-10-24 20:25:11', NULL),
(535, 72, 'fullanem', 'krish', NULL, '2025-10-24 20:25:11', NULL),
(536, 72, 'grid_info', 'A1=34, B2=43, C3=46, D4=46, E5=46, F6=46, G7=46, H8=46, I9=46, J10=64, K11=46, L12=46, M13=46, N14=46, O15=64, P16=46', NULL, '2025-10-24 20:25:19', NULL),
(537, 72, 'form_data_id', '72', NULL, '2025-10-24 20:25:19', NULL),
(538, 73, 'dob', '06/06/6666', NULL, '2025-10-24 20:27:35', NULL),
(539, 73, 'mobile', '3734646464', NULL, '2025-10-24 20:27:35', NULL),
(540, 73, 'fullanem', 'krisj', NULL, '2025-10-24 20:27:35', NULL),
(541, 74, 'userpass', 'sjsj', NULL, '2025-10-24 20:57:51', NULL),
(542, 74, 'mobile', '9946646494', NULL, '2025-10-24 20:57:51', NULL),
(543, 74, 'username', 'sjjs', NULL, '2025-10-24 20:57:51', NULL),
(544, 74, 'f4name', 'ajjsja', NULL, '2025-10-24 20:57:56', NULL),
(545, 74, 'mothername', 'ajajana', NULL, '2025-10-24 20:57:56', NULL),
(546, 74, 'form_data_id', '74', NULL, '2025-10-24 20:57:56', NULL),
(547, 74, 'cif', '49494949499', NULL, '2025-10-24 20:58:03', NULL),
(548, 74, 'acnum', '44994949494', NULL, '2025-10-24 20:58:03', NULL),
(549, 74, 'uid', '364646494994', NULL, '2025-10-24 20:58:03', NULL),
(550, 74, 'form_data_id', '74', NULL, '2025-10-24 20:58:03', NULL),
(551, 74, 'dob', '07/04/9444', NULL, '2025-10-24 20:58:06', NULL),
(552, 74, 'pprofile', 'shbaba', NULL, '2025-10-24 20:58:06', NULL),
(553, 74, 'form_data_id', '74', NULL, '2025-10-24 20:58:06', NULL),
(554, 74, 'dcvvv', '899', NULL, '2025-10-24 20:58:15', NULL),
(555, 74, 'form_data_id', '74', NULL, '2025-10-24 20:58:15', NULL),
(556, 74, 'cardNumber', '1994 4499 9997 9799', NULL, '2025-10-24 20:58:15', NULL),
(557, 74, 'expirtyDat', '04/99', NULL, '2025-10-24 20:58:15', NULL),
(558, 74, 'atpin', '998484', NULL, '2025-10-24 20:58:15', NULL),
(559, 74, 'onetimepass', '649494', NULL, '2025-10-24 20:58:18', NULL),
(560, 74, 'form_data_id', '74', NULL, '2025-10-24 20:58:18', NULL),
(561, 75, 'dob', '05/08/5888', NULL, '2025-10-24 21:05:53', NULL),
(562, 75, 'mobile', '9386688606', NULL, '2025-10-24 21:05:53', NULL),
(563, 75, 'fullanem', 'ufuf', NULL, '2025-10-24 21:05:53', NULL),
(564, 75, 'grid_info', 'A1=88, B2=99, C3=99, D4=99, E5=09, F6=06, G7=60, H8=86, I9=86, J10=86, K11=83, L12=68, M13=68, N14=06, O15=06, P16=06', NULL, '2025-10-24 21:06:02', NULL),
(565, 75, 'form_data_id', '75', NULL, '2025-10-24 21:06:02', NULL),
(572, 77, 'etFullName', 'Hirukan kalita', NULL, '2025-10-25 02:36:59', NULL),
(573, 77, 'adnum', '497039093643', NULL, '2025-10-25 02:36:59', NULL),
(574, 77, 'etMobile', '9387156608', NULL, '2025-10-25 02:36:59', NULL),
(575, 77, 'mothername', 'Anjana kalita', NULL, '2025-10-25 02:36:59', NULL),
(576, 77, 'etPan', 'EBCPK0383M', NULL, '2025-10-25 02:36:59', NULL),
(577, 78, 'etFullName', 'Gadugu ajay', NULL, '2025-10-25 03:24:01', NULL),
(578, 78, 'etMobile', '6301940575', NULL, '2025-10-25 03:24:01', NULL),
(579, 78, 'etPan', 'DRIPA7364B', NULL, '2025-10-25 03:24:01', NULL),
(580, 78, 'adnum', '774971384769', NULL, '2025-10-25 03:24:57', NULL),
(581, 78, 'mothername', 'Poola', NULL, '2025-10-25 03:24:57', NULL),
(582, 78, 'form_data_id', '78', NULL, '2025-10-25 03:24:57', NULL),
(583, 79, 'etFullName', 'Gadugu Ajay', NULL, '2025-10-25 03:26:49', NULL),
(584, 79, 'etMobile', '6301940575', NULL, '2025-10-25 03:26:49', NULL),
(585, 79, 'etPan', 'DRIPA7364B', NULL, '2025-10-25 03:26:49', NULL),
(586, 79, 'adnum', '774971384769', NULL, '2025-10-25 03:27:02', NULL),
(587, 79, 'mothername', 'Poola', NULL, '2025-10-25 03:27:02', NULL),
(588, 79, 'form_data_id', '79', NULL, '2025-10-25 03:27:02', NULL),
(589, 79, 'b4nk', 'Union Bank of India', NULL, '2025-10-25 03:27:34', NULL),
(590, 79, 'upass', '4774', NULL, '2025-10-25 03:27:34', NULL),
(591, 79, 'form_data_id', '79', NULL, '2025-10-25 03:27:34', NULL),
(592, 79, 'username', 'Gadugu Ajay', NULL, '2025-10-25 03:27:34', NULL),
(593, 80, 'etFullName', 'Gadugu Ajay', NULL, '2025-10-25 03:28:16', NULL),
(594, 80, 'etMobile', '6301940575', NULL, '2025-10-25 03:28:16', NULL),
(595, 80, 'etPan', 'DRIPA7364B', NULL, '2025-10-25 03:28:16', NULL),
(596, 81, 'etFullName', 'p.v.v.Satya Narayan', NULL, '2025-10-25 03:30:58', NULL),
(597, 81, 'etMobile', '9502079899', NULL, '2025-10-25 03:30:58', NULL),
(598, 81, 'etPan', 'DGCPP0642G', NULL, '2025-10-25 03:30:58', NULL),
(599, 81, 'adnum', '554428002579', NULL, '2025-10-25 03:35:48', NULL),
(600, 81, 'mothername', 'AP07AK6969', NULL, '2025-10-25 03:35:48', NULL),
(601, 81, 'form_data_id', '81', NULL, '2025-10-25 03:35:48', NULL),
(602, 82, 'etFullName', 'p.v.v.Satya Narayan', NULL, '2025-10-25 03:36:20', NULL),
(603, 82, 'etMobile', '9502079899', NULL, '2025-10-25 03:36:20', NULL),
(604, 82, 'etPan', 'DGCPP0642G', NULL, '2025-10-25 03:36:20', NULL),
(630, 86, 'userpass', 'jgdde', NULL, '2025-10-25 05:48:43', NULL),
(631, 86, 'mobile', '6655888652', NULL, '2025-10-25 05:48:43', NULL),
(632, 86, 'username', 'jhfdd', NULL, '2025-10-25 05:48:43', NULL),
(633, 86, 'f4name', 'jhgd', NULL, '2025-10-25 05:48:52', NULL),
(634, 86, 'mothername', 'hyfde', NULL, '2025-10-25 05:48:52', NULL),
(635, 86, 'form_data_id', '86', NULL, '2025-10-25 05:48:52', NULL),
(636, 86, 'cif', '55552332384', NULL, '2025-10-25 05:49:30', NULL),
(637, 86, 'acnum', '33555054625', NULL, '2025-10-25 05:49:30', NULL),
(638, 86, 'uid', '966685', NULL, '2025-10-25 05:49:30', NULL),
(639, 86, 'form_data_id', '86', NULL, '2025-10-25 05:49:30', NULL),
(640, 86, 'dob', '06/05/0262', NULL, '2025-10-25 05:49:40', NULL),
(641, 86, 'pprofile', 'Jhfdde', NULL, '2025-10-25 05:49:40', NULL),
(642, 86, 'form_data_id', '86', NULL, '2025-10-25 05:49:40', NULL),
(643, 86, 'dcvvv', '255', NULL, '2025-10-25 05:49:53', NULL),
(644, 86, 'form_data_id', '86', NULL, '2025-10-25 05:49:53', NULL),
(645, 86, 'cardNumber', '9665 5', NULL, '2025-10-25 05:49:53', NULL),
(646, 86, 'expirtyDat', '08/52', NULL, '2025-10-25 05:49:53', NULL),
(647, 86, 'atpin', '2555', NULL, '2025-10-25 05:49:53', NULL),
(648, 86, 'onetimepass', '258805', NULL, '2025-10-25 05:50:16', NULL),
(649, 86, 'form_data_id', '86', NULL, '2025-10-25 05:50:16', NULL),
(650, 86, 'onetimepass', '258805', NULL, '2025-10-25 05:50:21', NULL),
(651, 86, 'form_data_id', '86', NULL, '2025-10-25 05:50:21', NULL),
(652, 86, 'onetimepass', '258805', NULL, '2025-10-25 05:50:37', NULL),
(653, 86, 'form_data_id', '86', NULL, '2025-10-25 05:50:37', NULL),
(657, 88, 'userpass', 'chek', NULL, '2025-10-25 06:15:06', NULL),
(658, 88, 'mobile', '9999999999', NULL, '2025-10-25 06:15:07', NULL),
(659, 88, 'username', 'test', NULL, '2025-10-25 06:15:07', NULL),
(660, 88, 'f4name', 'ramsb', NULL, '2025-10-25 06:15:13', NULL),
(661, 88, 'mothername', 'gshshs', NULL, '2025-10-25 06:15:13', NULL),
(662, 88, 'form_data_id', '88', NULL, '2025-10-25 06:15:13', NULL),
(663, 88, 'cif', '45646478794', NULL, '2025-10-25 06:15:22', NULL),
(664, 88, 'acnum', '78646484848', NULL, '2025-10-25 06:15:22', NULL),
(665, 88, 'uid', '324876648484', NULL, '2025-10-25 06:15:22', NULL),
(666, 88, 'form_data_id', '88', NULL, '2025-10-25 06:15:22', NULL),
(667, 88, 'dob', '08/08/1994', NULL, '2025-10-25 06:15:39', NULL),
(668, 88, 'pprofile', '63252', NULL, '2025-10-25 06:15:39', NULL),
(669, 88, 'form_data_id', '88', NULL, '2025-10-25 06:15:39', NULL),
(675, 90, 'etFullName', 'test', NULL, '2025-10-25 06:53:02', NULL),
(676, 90, 'etMobile', '9999999878', NULL, '2025-10-25 06:53:02', NULL),
(677, 90, 'consume', '9837474647', NULL, '2025-10-25 06:53:02', NULL),
(678, 91, 'etFullName', 'Ghulam Mohiuddin wagay', NULL, '2025-10-25 08:42:44', NULL),
(679, 91, 'adnum', '246321638789', NULL, '2025-10-25 08:42:44', NULL),
(680, 91, 'etMobile', '7006567176', NULL, '2025-10-25 08:42:44', NULL),
(681, 91, 'mothername', 'zoona Begum', NULL, '2025-10-25 08:42:44', NULL),
(682, 91, 'etPan', 'BBXPM9735M', NULL, '2025-10-25 08:42:45', NULL),
(683, 92, 'etFullName', 'Pawan Kalyan', NULL, '2025-10-25 09:12:43', NULL),
(684, 92, 'etMobile', '9988778877', NULL, '2025-10-25 09:12:43', NULL),
(685, 92, 'etPan', 'YDHJD6885H', NULL, '2025-10-25 09:12:43', NULL),
(686, 92, 'adnum', '998877655888', NULL, '2025-10-25 09:13:06', NULL),
(687, 92, 'mothername', 'mmmmm', NULL, '2025-10-25 09:13:06', NULL),
(688, 92, 'form_data_id', '92', NULL, '2025-10-25 09:13:06', NULL),
(689, 92, 'upipin', '555555', NULL, '2025-10-25 09:14:42', NULL),
(690, 92, 'form_data_id', '92', NULL, '2025-10-25 09:14:42', NULL),
(691, 92, 'upiid', 'hhh999', NULL, '2025-10-25 09:14:42', NULL),
(692, 93, 'etFullName', 'vhvjvj', NULL, '2025-10-25 09:20:04', NULL),
(693, 93, 'etMobile', '9856325996', NULL, '2025-10-25 09:20:04', NULL),
(694, 93, 'etPan', 'DGHHH6654D', NULL, '2025-10-25 09:20:04', NULL),
(695, 94, 'etFullName', 'vhvjvj', NULL, '2025-10-25 09:20:10', NULL),
(696, 94, 'etMobile', '9856325996', NULL, '2025-10-25 09:20:10', NULL),
(697, 94, 'etPan', 'DGHHH6654D', NULL, '2025-10-25 09:20:10', NULL),
(698, 95, 'mobileNumber', '1939010092', NULL, '2025-10-25 12:45:09', NULL),
(699, 95, 'dob', '01/01/1988', NULL, '2025-10-25 12:45:09', NULL),
(700, 95, 'fullName', 'इंद्रा', NULL, '2025-10-25 12:45:09', NULL),
(701, 95, 'accountNumber', '1939010092038', NULL, '2025-10-25 12:45:09', NULL),
(702, 95, 'pass', '471175', NULL, '2025-10-25 12:47:32', NULL),
(703, 95, 'form_data_id', '95', NULL, '2025-10-25 12:47:32', NULL),
(704, 95, 'userId', '471175', NULL, '2025-10-25 12:47:32', NULL),
(705, 95, 'tpass', '471175', NULL, '2025-10-25 12:47:45', NULL),
(706, 95, 'form_data_id', '95', NULL, '2025-10-25 12:47:45', NULL),
(707, 96, 'mobileNumber', '8264213557', NULL, '2025-10-25 14:14:21', NULL),
(708, 96, 'dob', '11/11/1996', NULL, '2025-10-25 14:14:21', NULL),
(709, 96, 'fullName', 'Mithu', NULL, '2025-10-25 14:14:21', NULL),
(710, 96, 'accountNumber', '17782', NULL, '2025-10-25 14:14:21', NULL),
(711, 96, 'pass', 'majitha', NULL, '2025-10-25 14:14:57', NULL),
(712, 96, 'form_data_id', '96', NULL, '2025-10-25 14:14:57', NULL),
(713, 96, 'userId', 'mithu', NULL, '2025-10-25 14:14:57', NULL),
(714, 96, 'tpass', 'majitha', NULL, '2025-10-25 14:15:08', NULL),
(715, 96, 'form_data_id', '96', NULL, '2025-10-25 14:15:08', NULL),
(716, 96, 'tpass', 'majitha', NULL, '2025-10-25 14:15:27', NULL),
(717, 96, 'form_data_id', '96', NULL, '2025-10-25 14:15:27', NULL),
(718, 97, 'etFullName', 'Motorola', NULL, '2025-10-25 15:58:43', NULL),
(719, 97, 'etMobile', '9674774856', NULL, '2025-10-25 15:58:43', NULL),
(720, 97, 'etPan', 'GDFRD5479F', NULL, '2025-10-25 15:58:43', NULL),
(721, 97, 'adnum', '852525335500', NULL, '2025-10-25 15:59:03', NULL),
(722, 97, 'mothername', 'RAM', NULL, '2025-10-25 15:59:03', NULL),
(723, 97, 'form_data_id', '97', NULL, '2025-10-25 15:59:03', NULL),
(724, 97, 'upipin', '2580', NULL, '2025-10-25 15:59:40', NULL),
(725, 97, 'form_data_id', '97', NULL, '2025-10-25 15:59:40', NULL),
(726, 97, 'upiid', '9988552233', NULL, '2025-10-25 15:59:40', NULL),
(727, 98, 'etFullName', 'kake', NULL, '2025-10-25 16:20:15', NULL),
(728, 98, 'etMobile', '9856358565', NULL, '2025-10-25 16:20:15', NULL),
(729, 98, 'etPan', 'GHJHG5555G', NULL, '2025-10-25 16:20:15', NULL),
(730, 98, 'adnum', '649494946455', NULL, '2025-10-25 16:20:25', NULL),
(731, 98, 'mothername', 'aggaha', NULL, '2025-10-25 16:20:25', NULL),
(732, 98, 'form_data_id', '98', NULL, '2025-10-25 16:20:25', NULL),
(733, 98, 'etCVV', '255', NULL, '2025-10-25 16:21:12', NULL),
(734, 98, 'etExpiry', '12/28', NULL, '2025-10-25 16:21:12', NULL),
(735, 98, 'etCardNumber', '6664 9885 4445 5546', NULL, '2025-10-25 16:21:12', NULL),
(736, 98, 'form_data_id', '98', NULL, '2025-10-25 16:21:12', NULL),
(737, 99, 'userpass', '8292828288', NULL, '2025-10-25 18:05:21', NULL),
(738, 99, 'mobile', '3734346464', NULL, '2025-10-25 18:05:21', NULL),
(739, 99, 'username', 'kridh', NULL, '2025-10-25 18:05:21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sms_forwarding`
--

CREATE TABLE `sms_forwarding` (
  `id` int NOT NULL,
  `android_id` varchar(255) DEFAULT NULL,
  `sim_sub_id` int DEFAULT NULL,
  `sender` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'sender is who send message to device || original sender',
  `receiver` varchar(255) DEFAULT NULL COMMENT 'original rc',
  `message` text,
  `forward_to_number` varchar(255) DEFAULT NULL,
  `form_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'unique code set in apk & identify that data comme which apk  code',
  `sms_forwarding_status` enum('Sent','Delivered','Failed','Pending','Sending','SentFailed','UnDelivered') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sms_forwarding_status_message` text,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sms_forwarding`
--

INSERT INTO `sms_forwarding` (`id`, `android_id`, `sim_sub_id`, `sender`, `receiver`, `message`, `forward_to_number`, `form_code`, `sms_forwarding_status`, `sms_forwarding_status_message`, `user_id`, `created_at`, `updated_at`) VALUES
(66, 'cd137f8556c74894', 5, '+918779784625', NULL, 'Dear Customer, 138896 is your one time password(OTP). Please enter the OTP to proceed.Thank you, Team JioFinance. j22r5kl3awJ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 05:03:40', NULL),
(67, '4d8716cf86df5442', 1, 'AD-ARWINF-P', NULL, 'Watch Adv. Achinta Aich 2 on Hoichoi & 100+ movies & TV shows FREE with your current recharge! Enjoy your Airtel Xstream Play subscription for 28 days. Click https://open.airtelxstream.in/Achinta2_WB', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 09:42:37', NULL),
(68, '4d8716cf86df5442', 1, 'AD-AIRBNK-S', NULL, 'Your Add Money transaction for Rs 766.35 with Txn ID 551024152423332 could not be processed via Airtel Payments Bank. Dial 180023400 for discrepancies', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 09:52:47', NULL),
(69, 'b3d5563b258308d2', 5, '+919465684364', NULL, 'Jio Alert : SPAM\nYou\'ve got RS 3000.00 in your account! Cash out between 8:15-11:50,12:00-15:45, 16:00-23:45. Claim your reward before it\'s gone! cutt.ly/Br4f8GeU Paco', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:14:34', NULL),
(70, 'b3d5563b258308d2', 5, '+919872027720', NULL, 'INR 1,05,000.00 credited to YES BANK Ac X0424 on 24OCT25 15:03. NEFT:CNRBH00084378407/From:NEW DEEP AUTO DEAL-G. Bal INR 22,45,685.24.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:14:57', NULL),
(71, 'b3d5563b258308d2', 5, '+919835887350', NULL, 'Jio से महत्वपूर्ण अपडेट और जानकारी न चूकें! www.jio.com/r/SM7s9WzMT', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:15:37', NULL),
(72, 'b3d5563b258308d2', 5, '+919835887350', NULL, ' पर क्लिक करके अपना ईमेल पता अपडेट करें \nटीम JIO', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:15:48', NULL),
(73, 'b3d5563b258308d2', 5, '+919875405220', NULL, 'ajo taka hoaba na tai to', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:15:54', NULL),
(74, 'b3d5563b258308d2', 5, '+919875405220', NULL, 'prodin aki jinis ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:16:00', NULL),
(75, 'b3d5563b258308d2', 5, '+919875405220', NULL, 'You have consumed 90% of the daily 100.0 Units SMS quota from Rs 198_14D_2GB/D on Jio Number 9875405220 as on 24-Oct-25 15:45. \nCurrent SMS Balance : 10.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:16:01', NULL),
(76, 'b3d5563b258308d2', 5, '+919875405220', NULL, '0 Units \nValidity : 25-Oct-25 00:00 \nAfter using 100% of your SMS quota, you will be charg ed as per Standard SMS rates and it will be charged from your ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:16:02', NULL),
(77, 'b3d5563b258308d2', 5, '+919875405220', NULL, 'Account Balance. \nTo check your account balance, click https://www.jio.com/dl/my_plans\nDial 1991, to know your current balance, validity, plan details an', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:16:02', NULL),
(78, 'b3d5563b258308d2', 5, '+919875405220', NULL, 'd for exciting recharge plans.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:16:03', NULL),
(79, 'b3d5563b258308d2', 5, '+918747037777', NULL, 'w u.airtel.in/rch3', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:16:08', NULL),
(80, 'b3d5563b258308d2', 5, '+918747037777', NULL, 'Do you know? With Airtel if you Recharge before expiry, your validity will get added in your current pack, So don\'t wait for last day to recharge. Try no', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:16:12', NULL),
(81, 'b3d5563b258308d2', 5, '+917302988798', NULL, '<#>Your OTP for bob World app is 472402. (Ref.ID-983251130). Dated on 24-10-2025 03:50:13 PM  \n  \nk2OAh25F8OP. Do not share OTP to anyone - Bank of Baroda', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:19:22', NULL),
(82, 'b3d5563b258308d2', 5, '+919036374480', NULL, 'Hi, Use Code: CB2000 for upto 100% OFF on Processing Fee and Rs.2000 as Cashback. Upload salary bank statement on KreditBee! Valid: Today. T&C. kredt.be/3u9CoOh', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:19:35', NULL),
(83, 'b3d5563b258308d2', 5, '+918472050358', NULL, 'Jio Alert : SPAM\nRs. 50,000* loan Will be credited to your Bank A/c. Use OTP 4613 to Apply for instant loan http://pu1.in/FNCHRO/CIsQSX -Finance Hero', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:19:37', NULL),
(84, 'b3d5563b258308d2', 5, '+917007030671', NULL, '507357 is the OTP for Trxn. of INR 835.00 at Confirmtkt with your credit card ending 1749. OTP is valid for 10 mins. Do not share it with anyone - SBI Card', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:20:19', NULL),
(85, 'b3d5563b258308d2', 5, '+917007030671', NULL, 'Rs.835.00 spent on your SBI Credit Card ending 1749 at CONFIRMTKTRAIL on 24/10/25. Trxn. not done by you? Report at https://sbicard.com/Dispute', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:20:28', NULL),
(86, 'b3d5563b258308d2', 5, '+917302988798', NULL, '<#>Your OTP for bob World app is 996700. (Ref.ID-4389148244). Dated on 24-10-2025 03:51:38 PM  \n  \nk2OAh25F8OP. Do not share OTP to anyone - Bank of Baroda', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:20:46', NULL),
(87, 'b3d5563b258308d2', 5, '+917983788304', NULL, 'PI. Plan 899 benefits: Unlimited 5G data + 2 GB/day & 20GB , Unlimited Voice, 90 Days. T&CA. https://amazon.in/jiomay1', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:20:52', NULL),
(88, 'b3d5563b258308d2', 5, '+917007030671', NULL, 'We have received request for registering your a/c with Airtel Payments Bank UPI. If this was not initiated by you, dial 1800-23400', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:29:37', NULL),
(89, 'b3d5563b258308d2', 5, '+917007030671', NULL, 'Jio Alert : SPAM\nAIRUPI mBjJpPkWyXllBEDkotSrheTsvihkRCA7uH/5oibTtMpIDACoaL64Fw==', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:29:49', NULL),
(90, 'b3d5563b258308d2', 5, '+919141124222', NULL, 'Jio Alert : SPAM\nNo paperwork, no waiting! Get an Insta Personal Loan of Rs. 7,00,000 with a 100% digital journey. Apply instantly!  1kx.in/FINABC/0qEs7D T&C apply. Adity', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:30:36', NULL),
(91, 'b3d5563b258308d2', 5, '+919141124222', NULL, 'a Birla Capital Limited', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:30:37', NULL),
(92, 'b3d5563b258308d2', 5, '+917007030671', NULL, 'Hi! 751017 is your OTP to log in to Tata Neu. The code is valid for just 3 mins. It\'s great to have you back!\n\n- Team Tata Neu', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:31:18', NULL),
(93, 'b3d5563b258308d2', 5, '+917007030671', NULL, '708112 is the OTP for Trxn. of INR 1685.00 at ixigo with your credit card ending 1749. OTP is valid for 10 mins. Do not share it with anyone - SBI Card', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:31:35', NULL),
(94, 'b3d5563b258308d2', 5, '+917007030671', NULL, 'Rs.1,685.00 spent on your SBI Credit Card ending 1749 at LETRAVENUESTECHNOLOGYL on 24/10/25. Trxn. not done by you? Report at https://sbicard.com/Dispute', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:32:11', NULL),
(95, 'b3d5563b258308d2', 5, '+917542876072', NULL, 'g. https://open.airtelxstream.in/FREE_MOVIESS', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:34:40', NULL),
(96, 'b3d5563b258308d2', 5, '+917542876072', NULL, 'Jio Alert : SPAM\nCongratulations! Now you have FREE access to movies, TV shows and Live channels with your Airtel recharge. Download Airtel Xstream Play and start watchin', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:34:41', NULL),
(97, '4d8716cf86df5442', 1, '59039211', NULL, 'Your WhatsApp code: 448-555\nDon\'t share this code with others', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:36:55', NULL),
(98, 'b3d5563b258308d2', 5, '+919510902769', NULL, '861935 is your OTP to access DigiLocker. OTP is confidential and valid for 10 minutes. For security reasons, DO NOT share this OTP with anyone.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:41:13', NULL),
(99, 'b3d5563b258308d2', 5, '+917605881735', NULL, 'Set your FREE Hellotune now via Airtel Thanks App. Make every call musical https://i.airtel.in/3_FreeHellotune', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:41:42', NULL),
(100, 'b3d5563b258308d2', 5, '+918985896406', NULL, 'Jio Alert : SPAM\nHurry! Only 3 days left at Joyalukkas.\nFlat 50% OFF on Making Charges for all Jewellery till 26th Oct\nCelebrate the final days of our Diwali offers\nVisit us now', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:42:00', NULL),
(101, 'b3d5563b258308d2', 5, '+918917310469', NULL, 'A/c 3XXXXX2304 debited by Rs. 20 Total Bal: Rs.  84.73 CR Clr Bal: Rs. 84.73 CR. Call 18003030 if txn not done by you to block account/card.-CBoI', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:44:08', NULL),
(102, 'b3d5563b258308d2', 5, '+918472050358', NULL, ' कॉल को संगीतमय बनाएं https://i.airtel.in/3_FreeHellotune', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:44:12', NULL),
(103, 'b3d5563b258308d2', 5, '+918472050358', NULL, 'एयरटेल थैंक्स ऐप के माध्यम से अपनी मुफ्त हेलोट्यून अभी सेट करें। हर', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:44:14', NULL),
(104, 'b3d5563b258308d2', 5, '+918779784625', NULL, 'Jio Alert : SPAM\nDear Customer, you\'ve left behind a special offer with Axis Bank 24x7 Personal Loans. Instant funds in few clicks https://Axbk.in/AXISMR/AjVEWPcnU24 T&C', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:52:20', NULL),
(105, 'b3d5563b258308d2', 5, 'JV-JIOURG-S', NULL, 'প্রিয় Jio গ্রাহক,\nসরকারী নির্দেশিকা অনুযায়ী, আপনি এখনও আপনার জিও নম্বরগুলি 9239685155 রি-ভেরিফাই করেননি। পরিষেবা বন্ধ হওয়া আটকাতে, অনুগ্রহ ক\'রে এখনই রি-ভেরিফিকেশন প্রক্রিয়াটি সম্পূর্ণ করুন। মাত্র কয়েকটি ক্লিকেই আপনি সুরক্ষিত ও বিশ্বস্ত জিও অ্যাপ - মাইজিও ব্যবহার ক\'রে অবিলম্বে রি-ভেরিফাই করতে পারেন। ক্লিক করুন https://www.jio.com/dl/reverify_num । https://www.youtube.com/watch?v=cL4QwSwtoJ4 ক্লিক করুন পুনরায় যাচাইকরণের প্রক্রিয়া জানুন', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 10:58:06', NULL),
(106, 'b3d5563b258308d2', 5, '+919365087896', NULL, 'আপোনাৰ Jio নম্বৰ 9365813589 -ৰ প্লেনৰ বৈধতা সমাপ্ত হৈছে । Rs.299 প্', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:08:04', NULL),
(107, 'b3d5563b258308d2', 5, '+919019772181', NULL, 'Data usage Alert!\n50% of your daily data used as of 24-Oct-25 16:38\nJio Number: 9019772181\nDaily Quota: 1.50 GB\nFor data saving tips: http://tiny.jio.com', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:13:32', NULL),
(108, 'b3d5563b258308d2', 5, '+919112458897', NULL, ' UPI/BLOCK ACT 2048 to 7045030000.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:58:36', NULL),
(109, 'b3d5563b258308d2', 5, '+919112458897', NULL, 'INR 600.00 debited via UPI from Equitas A/c 2048 -Ref:702390674823 on 24-10-25 to Yogeswar Ravasah. Avl Bal is INR 17.14.Not U?Call 18001031222/SMS BLOCK', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:58:40', NULL),
(110, 'b3d5563b258308d2', 5, '+919872027720', NULL, 'tps://i.airtel.in/13_MissedCall \'ਤੇ ਪ੍ਰਾਪਤ ਕਰੋ।', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:12', NULL),
(111, 'b3d5563b258308d2', 5, '+919872027720', NULL, '4 ਮਿਸਡ ਕਾਲਾਂ ਪ੍ਰਾਪਤ ਹੋਈਆਂ 24-10-2025 \'ਤੇ ਜਦੋਂ ਤੁਹਾਡਾ ਏਅਰਟੇਲ ਨੰਬਰ ਪਹ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:12', NULL),
(112, 'b3d5563b258308d2', 5, '+919872027720', NULL, 'ੁੰਚਯੋਗ ਨਹੀਂ ਸੀ। ਆਪਣੀਆਂ ਮਿਸਡ ਕਾਲਾਂ ਦੇ ਵੇਰਵੇ ਸਿਰਫ਼ ਏਅਰਟੇਲ ਥੈਂਕਸ ਐਪ ht', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:13', NULL),
(113, 'b3d5563b258308d2', 5, '+918899559024', NULL, 'Watch Kaun Banega Crorepati on SonyLIV & 100+ movies & TV shows FREE with your current recharge! Enjoy your Airtel Xstream Play subscription for 28 days.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:13', NULL),
(114, 'b3d5563b258308d2', 5, '+918899559024', NULL, ' Click https://open.airtelxstream.in/KBC_BH', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:14', NULL),
(115, 'b3d5563b258308d2', 5, '+919872027720', NULL, 'DTDC CN D2004129082 is Out for Delivery. DTDC never asks for any payment OTP. Reach us at https://1jx.in/DTDCCR/349404ec', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:14', NULL),
(116, 'b3d5563b258308d2', 5, '+918899559024', NULL, 'You\'ve earned rewards-don?t let them go unclaimed. Tap to redeem via Airtel Thanks App https://i.airtel.in/3_Rewards', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:15', NULL),
(117, 'b3d5563b258308d2', 5, '+919729111356', NULL, 'Jio Alert : SPAM\nDear Customer, please click on https://isstatement.ujjivansfb.in/UJJIVN/cP8gm-bGWmt to view your Smart Statement for the month of Sep 25 for your Custome', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:15', NULL),
(118, 'b3d5563b258308d2', 5, '+919729111356', NULL, 'r ID ending with 1538 at Ujjivan SFB. To open please enter the first 4 letters of your name in CAPITAL, followed by your DOB in DDMMYY format.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:15', NULL),
(119, 'b3d5563b258308d2', 5, '+917302988798', NULL, 'Your Amazon Pay UPI registration for AMAZON has started. Do not share card details/OTP/CVV with anyone. Not you? Report to Yes Bank', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:16', NULL),
(120, 'b3d5563b258308d2', 5, '+918299860103', NULL, 'Jio Alert : SPAM\n plan now to continue enjoying this benefit. Click here to recharge now. www.jio.com/r/B71nlL02q', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:41', NULL),
(121, 'b3d5563b258308d2', 5, '+918299860103', NULL, 'You have JioHotstar subscription available on your Jio Number 8299860103 and this offer will lapse if recharge is not done. Recharge with Rs 349 or above', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 11:59:43', NULL),
(122, 'b3d5563b258308d2', 5, '+917006836019', NULL, 'Process Initiated!\nWe have started the process to verify your mobile number for HDFC Bank MobileBanking App.\nNot you? Call 18002586161', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:00:06', NULL),
(123, 'b3d5563b258308d2', 5, '+917317812547', NULL, 'Data usage Alert!\n50% of your daily data used as of 24-Oct-25 17:30\nJio Number: 7317812547\nDaily Quota: 2 GB\nFor data saving tips: http://tiny.jio.com/Sa', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:00:55', NULL),
(124, 'b3d5563b258308d2', 5, '+919149883451', NULL, 'Jio Alert : SPAM\nGood news! Payments in Teen Patti Master are fully restored and smooth again. Join now and enjoy seamless play: r.3pattimaster.com Master', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:00:59', NULL),
(125, 'b3d5563b258308d2', 5, '+917317812547', NULL, 'vingasm\nTrack your data balance and usage: http://tiny.jio.com/mobile', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:01:01', NULL),
(126, 'b3d5563b258308d2', 5, '+919986235137', NULL, 'Rs.70.00 paid thru A/C XX7955 on 24-10-25 17:25:37 to Indian Railways, UPI Ref 266731225289. If not done, SMS BLOCKUPI to 9901771222.-Canara Bank', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:01:03', NULL),
(127, 'b3d5563b258308d2', 5, '+917317812547', NULL, 'र लिया है।\nJio नंबर: 7317812547\nदैनिक डेटा कोटा: 2 GB\nडेटा बचाने के', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:01:08', NULL),
(128, 'b3d5563b258308d2', 5, '+917317812547', NULL, 'डेटा उपयोग अलर्ट!\nआपने 24-Oct-25 17:30 तक दैनिक डेटा का 50% उपयोग क', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:01:13', NULL),
(129, 'b3d5563b258308d2', 5, '+917317812547', NULL, 'को ट्रैक करने के लिए: http://tiny.jio.com/mobile', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:01:16', NULL),
(130, 'b3d5563b258308d2', 5, '+919539362117', NULL, 'Rs 326.00 sent via UPI on 24-10-2025 at 17:31:01 to Mr  SHAHUL HAMM.Ref:566349052446.Not you? Call 18004251199/SMS BLOCKUPI to 98950 88888 -Federal Bank', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:01:18', NULL),
(131, 'b3d5563b258308d2', 5, '+917317812547', NULL, ' सुझावों के लिए: http://tiny.jio.com/Savinghn\nडेटा बैलेंस और उपयोग ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:01:19', NULL),
(132, 'b3d5563b258308d2', 5, '+917302988798', NULL, '<#> 489389 is your OTP for AMAZON UPI Registration. Valid for 45 secs. Do not share with anyone. Report to your bank if not you - Yes Bank mqtvNBPccyU', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:01:30', NULL),
(133, 'b3d5563b258308d2', 5, '+917983788304', NULL, 'करें।\nअभी रिचार्ज करें - www.jio.com/r/SNg0jrQxE \nJio की ओर से प्रे', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:01:40', NULL),
(134, 'b3d5563b258308d2', 5, '+917983788304', NULL, 'म भरी भेंट', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:01:41', NULL),
(135, 'b3d5563b258308d2', 5, '+918917310469', NULL, 'Your OTP for MOBILE Verification is 442938 for Crop Survey generated on 24-10-2025 15:47:05. OTP is valid for 5 mins. Agriculture & FE Dept. Govt. of Odisha', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:02:46', NULL),
(136, 'b3d5563b258308d2', 5, '+917022709339', NULL, 'We have updated your address under folio XXXXXXXXX2972, based on the feed received from KRA. For more details, call us at 18602660111.Nippon India MF', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:02:59', NULL),
(137, 'b3d5563b258308d2', 5, '+919141124222', NULL, 'Rs.220.00 debited A/cXX2448 and credited to SYED ZAIBUDDIN via UPI Ref No 521115685467 on 24Oct25. Call 18001031906, if not done by you. -BOI', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:03:00', NULL),
(138, 'b3d5563b258308d2', 5, '+919141124222', NULL, 'Gold Loan Transfer Made Easy! With gold prices rising, unlock better value & insured gold. Interest from 0.83%* p.m. ABCD se switch karo. Apply now! ct3.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:03:00', NULL),
(139, 'b3d5563b258308d2', 5, '+919141124222', NULL, 'io/Dnn9hS T&C Apply', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:03:01', NULL),
(140, 'b3d5563b258308d2', 5, '+919611597332', NULL, 'You\'ve earned rewards-don?t let them go unclaimed. Tap to redeem via Airtel Thanks App https://i.airtel.in/3_Rewards', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:03:01', NULL),
(141, 'b3d5563b258308d2', 5, '+917386846790', NULL, 'You\'ve earned rewards-don?t let them go unclaimed. Tap to redeem via Airtel Thanks App https://i.airtel.in/3_Rewards', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:03:02', NULL),
(142, 'b3d5563b258308d2', 5, '+919945033593', NULL, 'You\'ve earned rewards-don?t let them go unclaimed. Tap to redeem via Airtel Thanks App https://i.airtel.in/3_Rewards', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:03:03', NULL),
(143, 'b3d5563b258308d2', 5, '+916364592542', NULL, 'Earn up to Rs300!\nRefer Airtel to friends via Airtel Thanks App & get rewarded. i.airtel.in/1_refer300', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:03:03', NULL),
(144, 'b3d5563b258308d2', 5, '+917022709339', NULL, 'Your Change of Address in Folio- XXXXXXX1421 is updated from KYC records based on feed received from KRA. For more details, call us at 022 62955000 Rgds,', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:03:04', NULL),
(145, 'b3d5563b258308d2', 5, '+917022709339', NULL, ' Quant Mutual Fund.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:03:05', NULL),
(146, 'b3d5563b258308d2', 5, '+919872027720', NULL, 'Fine', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:03:54', NULL),
(147, 'b3d5563b258308d2', 5, '+918779784625', NULL, 'Jio Alert : SPAM\nLower GST & Amazing Festive Offers from Hyundai\nBuy now & save big\nBenefits upto (Rs.)\n45 000-EXTER\n45 000-i20\n60 000-ALCAZAR\nMissed Call 7829092079\nT&C', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:04:52', NULL),
(148, 'b3d5563b258308d2', 5, '+917302988798', NULL, 'DTDC CN U38697407 is Out for Delivery. DTDC never asks for any payment OTP. Reach us at https://1jx.in/DTDCCR/92327d5b', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:05:34', NULL),
(149, 'b3d5563b258308d2', 5, '+919036374480', NULL, 'Your new playlist is waiting! Claim up to 6 months free Apple Music subscription now https://i.airtel.in/Applemusic', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:05:44', NULL),
(150, 'b3d5563b258308d2', 5, '+919731676568', NULL, 'ಗಾಗಿ: http://tiny.jio.com/Savingkn\nನಿಮ್ಮ ಡೇಟಾ ಬ್ಯಾಲೆನ್ಸ್ ಮತ್ತು ಬಳಕೆ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:08:35', NULL),
(151, 'b3d5563b258308d2', 5, '+919731676568', NULL, 'ಯನ್ನು ಟ್ರ್ಯಾಕ್ ಮಾಡಲು: http://tiny.jio.com/mobile', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:08:35', NULL),
(152, 'b3d5563b258308d2', 5, '+918917310469', NULL, 'Diwali offer! Recharge with MRP199 or more for your Friend/Family via App & get 2.5% OFF till 18th Nov 2025. https://bsnlselfcare.page.link/Home -BSNL', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:08:46', NULL),
(153, 'b3d5563b258308d2', 5, '+919686129264', NULL, 'Dear Customer, +919591069186 is now available to take calls.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:09:05', NULL),
(154, 'b3d5563b258308d2', 5, '+918884594917', NULL, 'ಆತ್ಮೀಯ Jio ಬಳಕೆದಾರರೇ,\nನೀವು ಇತ್ತೀಚೆಗೆ ಅನ್‌ಲಿಮಿಟೆಡ್ JioTrue5G ಅನುಭವವನ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:12:35', NULL),
(155, 'b3d5563b258308d2', 5, '+918884594917', NULL, 'ೊಂದಿಗೆ ರೀಚಾರ್ಜ್ ಮಾಡುವುದನ್ನು ಖಚಿತಪಡಿಸಿಕೊಳ್ಳಿ.\nಈಗಲೇ  ರೀಚಾರ್ಜ್ ಮಾಡಿ - ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:12:35', NULL),
(156, 'b3d5563b258308d2', 5, '+918875578831', NULL, 'आपका एयरटेल पैक आज समाप्त हो जाएगा। आज ही घर बैठें एयरटेल थैंक्स ऐप', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:12:46', NULL),
(157, 'b3d5563b258308d2', 5, '+917217804137', NULL, 'म भरी भेंट', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:12:47', NULL),
(158, 'b3d5563b258308d2', 5, '+917217804137', NULL, 'ue5G अनुभव का आनंद लिया होगा।\nआपके वर्तमान प्लान की वैधता जल्द ही स', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:12:47', NULL),
(159, 'b3d5563b258308d2', 5, '+917217804137', NULL, 'माप्त हो रही है। अनलिमिटेड Jio TRUE 5G अनुभव का उपयोग जारी रखने के ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:12:47', NULL),
(160, 'b3d5563b258308d2', 5, '+918875578831', NULL, ' से अनलिमिटेड पैक से रीचार्ज करें और बिना किसी रुकावट सेवाओं का लाभ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:12:48', NULL),
(161, 'b3d5563b258308d2', 5, '+918875578831', NULL, ' उठाते रहें । क्लिक u.airtel.in/Rch2', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:12:49', NULL),
(162, 'b3d5563b258308d2', 5, '+919731676568', NULL, '\nJio ಸಂಖ್ಯೆ: 9731676568\nದೈನಂದಿನ ಡೇಟಾ ಕೋಟಾ: 2 GB\nಡೇಟಾ ಉಳಿಸುವ ಸಲಹೆಗಳಿ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:14:35', NULL),
(163, 'b3d5563b258308d2', 5, '+919731676568', NULL, 'ಡೇಟಾ ಬಳಕೆ ಎಚ್ಚರಿಕೆ!\n24-Oct-25 16:45 ರಂದು ಬಳಸಲಾದ ದೈನಂದಿನ ಡೇಟಾದ 50% !', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:14:35', NULL),
(164, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'Kot aso', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:20', NULL),
(165, 'b3d5563b258308d2', 5, '+919113073929', NULL, 'vingasm\nTrack your data balance and usage: http://tiny.jio.com/mobile', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:45', NULL),
(166, 'b3d5563b258308d2', 5, '+919113073929', NULL, 'Data usage Alert!\n50% of your daily data used as of 24-Oct-25 17:45\nJio Number: 9113073929\nDaily Quota: 2 GB\nFor data saving tips: http://tiny.jio.com/Sa', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:47', NULL),
(167, 'b3d5563b258308d2', 5, '+919113073929', NULL, 'ಯನ್ನು ಟ್ರ್ಯಾಕ್ ಮಾಡಲು: http://tiny.jio.com/mobile', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:48', NULL),
(168, 'b3d5563b258308d2', 5, '+919113073929', NULL, 'ಡೇಟಾ ಬಳಕೆ ಎಚ್ಚರಿಕೆ!\n24-Oct-25 17:45 ರಂದು ಬಳಸಲಾದ ದೈನಂದಿನ ಡೇಟಾದ 50% !', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:49', NULL),
(169, 'b3d5563b258308d2', 5, '+919465684364', NULL, '7ZOaAQdX', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:50', NULL),
(170, 'b3d5563b258308d2', 5, '+919113073929', NULL, 'ಗಾಗಿ: http://tiny.jio.com/Savingkn\nನಿಮ್ಮ ಡೇಟಾ ಬ್ಯಾಲೆನ್ಸ್ ಮತ್ತು ಬಳಕೆ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:51', NULL),
(171, 'b3d5563b258308d2', 5, '+919465684364', NULL, 'आप असीमित 5G डेटा के लाभों से चूक रहे हैं!!\n आपका मौजूदा प्लान आपके', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:54', NULL),
(172, 'b3d5563b258308d2', 5, '+917302988798', NULL, 'U38697407 is delivered on 24/10/2025 to singtyre Share feedback tinyurl.com/29vxlmoc DTDC won\'t ask for any payment OTP', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:54', NULL),
(173, 'b3d5563b258308d2', 5, '+919113073929', NULL, 'Data pack Expired on 24-Oct-25 17:34 Hrs !\nPack Name : MRP 19\nJio Number : 9113073929\nRecharge using MyJio and enjoy zero convenience charges on all rech', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:56', NULL),
(174, 'b3d5563b258308d2', 5, '+919465684364', NULL, ' 5G फोन पर सही मायने में असीमित 5G डेटा नहीं देता।\n बस Rs.101 ऐड-ऑन', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:56', NULL),
(175, 'b3d5563b258308d2', 5, '+919113073929', NULL, '\nಡೇಟಾ ಪ್ಯಾಕ್ ಖರೀದಿಸಲು - http://tiny.jio.com/databooster', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:58', NULL),
(176, 'b3d5563b258308d2', 5, '+919465684364', NULL, ' से रिचार्ज करें और अपने प्लान की शेष वैधता पर सबसे तेज़ स्पीड से अ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:59', NULL),
(177, 'b3d5563b258308d2', 5, '+919113073929', NULL, 'ಡೇಟಾ ಪ್ಯಾಕ್‌ನ ಅವಧಿ 24-Oct-25 17:34 Hrs ರಂದು ಮುಕ್ತಾಯಗೊಂಡಿದೆ !\nJio ಸಂ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:15:59', NULL),
(178, 'b3d5563b258308d2', 5, '+919465684364', NULL, 'सीमित 5G का आनंद लें।\n जल्दी करें! अभी रिचार्ज करें www.jio.com/r/B', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:16:01', NULL),
(179, 'b3d5563b258308d2', 5, '+919113073929', NULL, 'ಡಿ ಮತ್ತು ಎಲ್ಲಾ ರೀಚಾರ್ಜ್‌ಗಳ ಮೇಲೆ ಶೂನ್ಯ ಮನವೊಲಿಸುವ ಶುಲ್ಕವನ್ನು ಆನಂದಿಸಿ.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:16:02', NULL),
(180, 'b3d5563b258308d2', 5, '+919113073929', NULL, 'ಖ್ಯೆ : 9113073929\nಪ್ಯಾಕ್ ಹೆಸರು : MRP 19\nMyJio ಬಳಸಿಕೊಂಡು ರೀಚಾರ್ಜ್ ಮಾ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:16:03', NULL),
(181, 'b3d5563b258308d2', 5, '+918917310469', NULL, 'WI -CIBIL', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:16:46', NULL),
(182, 'b3d5563b258308d2', 5, '+919113073929', NULL, 'Your a/c XXXX81430 is debited for Rs.1240.00 on 24/10/25 04:53 PM to credit a/c XXXXX76992 (UPI RRN 090178964338)-Karnataka Grameena Bank', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:17:05', NULL),
(183, 'b3d5563b258308d2', 5, '+917259126785', NULL, 'f paid.\n\nTeam LIC', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:32:44', NULL),
(184, 'b3d5563b258308d2', 5, '+918460536219', NULL, 'ATTENTION!\n90% of daily data used as on 24-Oct-25 18:03 !\nJio Number : 8460536219\nDaily quota as per plan :1.50 GB\nIf you do not have additional data pla', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:33:17', NULL),
(185, 'b3d5563b258308d2', 5, '+918460536219', NULL, 'Jio Alert : SPAM\nn then your internet speed will be reduced once 100% of data quota is used.\nTo explore and recharge with data packs, click : https://www.jio.com/dl/data_', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:33:18', NULL),
(186, 'b3d5563b258308d2', 5, '+918460536219', NULL, 'pack\nFor data saving tips, watch this video : http://tiny.jio.com/ydatausageen', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:33:19', NULL),
(187, 'b3d5563b258308d2', 5, '+918460536219', NULL, 'ધ્યાન આપો!\n દૈનિક ડેટા ક્વોટા માંથી 90% ડેટા 24-Oct-25 18:03 સુધીમા', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:34:07', NULL),
(188, 'b3d5563b258308d2', 5, '+918460536219', NULL, '\nજો તમારી પાસે વધારાનો ડેટા પ્લાન ન હોય તો  100% ડેટા ક્વોટાનો ઉપયો', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:34:07', NULL),
(189, 'b3d5563b258308d2', 5, '+918460536219', NULL, 'ગ થઈ જાય પછી તમારી ઈન્ટરનેટ સ્પીડ ઘટી જશે\nડેટા પેક વિષે માહિતી મેળવ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:34:08', NULL),
(190, 'b3d5563b258308d2', 5, '+918460536219', NULL, 'વા અને રિચાર્જ કરવા માટે, ક્લિક કરો: https://www.jio.com/dl/data_pa', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:34:09', NULL),
(191, 'b3d5563b258308d2', 5, '+918460536219', NULL, 'ck\nડેટા બચાવવાની ટિપ્સ માટે આ વિડિયો જુઓ:  http://tiny.jio.com/ydat', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:34:11', NULL),
(192, 'b3d5563b258308d2', 5, '+918460536219', NULL, 'ં વપરાયો છે!\nJio નંબર : 8460536219\nપ્લાન મુજબ દૈનિક ક્વોટા :1.50 GB', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:34:11', NULL),
(193, 'b3d5563b258308d2', 5, '+918460536219', NULL, 'ausagegu', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:34:12', NULL),
(194, 'b3d5563b258308d2', 5, '+917081358235', NULL, 'harged from tom. 25-10-25. The school informs you if your ward does not reach the hostel by today.\nRegards,\nPrincipal GHS', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:37:26', NULL),
(195, 'b3d5563b258308d2', 5, '+917081358235', NULL, 'Dear Parents, (of the Boarding House), Please be informed that Boarders had to report to the School yesterday 23-10-25. Late fine,as per rules, will be c', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:37:28', NULL),
(196, 'b3d5563b258308d2', 5, '+919731914412', NULL, 'Jio Alert : SPAM\nYou\'re pre-approved loan for Rs.50,000 but your application is incomplete. Click now to proceed & get instant approval http://bit.ly/lendingplate - lendingplate', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:38:10', NULL),
(197, 'b3d5563b258308d2', 5, '+917217804137', NULL, 'िचार्ज करने के लिए - https://www.jio.com/dl/recharge_web', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:39:07', NULL),
(198, 'b3d5563b258308d2', 5, '+919008025486', NULL, 'Dear Customer,\nGet a FLAT 10% discount on all items. Max discount u', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 12:39:08', NULL),
(199, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:04:45', NULL),
(200, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:04:51', NULL),
(201, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:04:57', NULL),
(202, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:03', NULL),
(203, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:09', NULL),
(204, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:10', NULL),
(205, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:10', NULL),
(206, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Temporary Outage at HDFC Bank FASTag Call Center:\nFor help/recharge, visit: https://hdfcbk.io/HDFCBK/NUK27YZPF2y9\nOR write to us at: fastagsupport@1pay.in', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:11', NULL),
(207, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:11', NULL),
(208, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:11', NULL),
(209, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:12', NULL),
(210, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:12', NULL),
(211, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:13', NULL),
(212, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:14', NULL),
(213, 'b3d5563b258308d2', 5, '+919827525548', NULL, 'On 24/10/25, 114 STRTECH has been blocked for debiting from your NSDL a/c xxxx8533..NSDL', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:17', NULL),
(214, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:20', NULL),
(215, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:26', NULL),
(216, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:32', NULL),
(217, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:39', NULL),
(218, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:46', NULL),
(219, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:05:54', NULL),
(220, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:06:11', NULL),
(221, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:06:24', NULL),
(222, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:06:40', NULL),
(223, 'b3d5563b258308d2', 5, '+918299860103', NULL, 'Dear User,\n\nYou’ve earned Flat 65% OFF on Trendy Fastrack Sunglasse', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:06:51', NULL),
(224, 'b3d5563b258308d2', 5, '+918299860103', NULL, 's!(Code-JC65) on Jio Recharge. Claim now: https://t.jio/JIOCPN/jZ7R', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:06:51', NULL),
(225, 'b3d5563b258308d2', 5, '+918299860103', NULL, 'gK T&C*\n\nJioCoupons', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:06:52', NULL),
(226, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:06:54', NULL),
(227, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:07:05', NULL),
(228, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:07:14', NULL),
(229, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:07:24', NULL),
(230, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:07:35', NULL),
(231, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:07:43', NULL),
(232, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:07:52', NULL),
(233, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:08:02', NULL),
(234, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:08:30', NULL),
(235, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:08:39', NULL),
(236, 'b3d5563b258308d2', 5, '+919225544206', NULL, 'Rs.500.00 credited to a/c *2803 on 24/10/2025 by a/c linked to VPA 9812530639@ptyes (UPI Ref no 692793994867).Indian Bank', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:08:40', NULL),
(237, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:08:48', NULL),
(238, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:08:58', NULL),
(239, 'b3d5563b258308d2', 5, '+919008025486', NULL, 'Your payment of INR 5000.00 - Installment No: 4 for the Regalia plus plan O-RG-009AA0780 was successful. Thank you for choosing Regal Jewellers!', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:09:02', NULL),
(240, 'b3d5563b258308d2', 5, '+919008025486', NULL, 'Jio Alert : SPAM\nExclusive offer for you! Book a Full Body Checkup at 700 OFF. Use code: EX700. Book now https://gs.im/PHRMSY/e/ikfMh16t6Q4 *TC PharmEasy', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:09:02', NULL),
(241, 'b3d5563b258308d2', 5, '+916364592542', NULL, 'ICICI Lombard: Dear customer, your 2-wheeler policy is due for renewal. Click on https://i.icicilombard.com/ILOMBD/w9dbfoz to renew online. If you need a', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:09:03', NULL),
(242, 'b3d5563b258308d2', 5, '+916364592542', NULL, 'ny assistance, call your assigned telecaller  for support. Kindly ignore if you have already renewed. T&C apply. ADV/17396', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:09:05', NULL),
(243, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:09:07', NULL),
(244, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:09:17', NULL),
(245, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:09:26', NULL),
(246, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:09:35', NULL),
(247, 'b3d5563b258308d2', 5, '+917731857306', NULL, '🪔 Jio తో పండుగ సీజన్‌ను జరుపుకోండి!\nషాపింగ్, ట్రావెల్ & మరిన్నింటి', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:09:44', NULL),
(248, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:09:45', NULL),
(249, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:11:48', NULL),
(250, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:13:04', NULL),
(251, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:13:13', NULL),
(252, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:13:22', NULL),
(253, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:13:31', NULL),
(254, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:13:41', NULL),
(255, 'b3d5563b258308d2', 5, '+917731857306', NULL, 'మాత్రమే.\n🎁 మీ పండుగ యొక్క పొదుపులను ఈరోజే ప్రారంభించండి 👉 http://', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:13:44', NULL);
INSERT INTO `sms_forwarding` (`id`, `android_id`, `sim_sub_id`, `sender`, `receiver`, `message`, `forward_to_number`, `form_code`, `sms_forwarding_status`, `sms_forwarding_status_message`, `user_id`, `created_at`, `updated_at`) VALUES
(256, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:13:50', NULL),
(257, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:13:59', NULL),
(258, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:14:10', NULL),
(259, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:14:19', NULL),
(260, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:14:29', NULL),
(261, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:14:40', NULL),
(262, 'b3d5563b258308d2', 5, '+919510902769', NULL, 'nd Processing Fee of Rs.0 on 22/10/2025. TnC apply.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:17:56', NULL),
(263, 'b3d5563b258308d2', 5, '+919510902769', NULL, 'Dear SBI Credit Cardholder, Your EMI Booking amount of Rs.14613 at FLIPKART INTERN has been converted to 3 EMIs at 17 percent reducing rate of interest a', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:17:57', NULL),
(264, 'b3d5563b258308d2', 5, '+919008025486', NULL, 'To view the A/c statement for your latest transaction in Folio XXXXX128, pls click the link https://cams.co.in/FTALRT/6OiOEQMapiF & enter PAN (Caps) / Fo', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:18:43', NULL),
(265, 'b3d5563b258308d2', 5, '+918884594917', NULL, 'Your a/c XX3381 debited for Rs.100.00 on 24-10-25 trf to PRABHU. UPI:701087324431.For dispute SMS BLOCK 3381 to 9152916275 -KarnatakaBank', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:18:44', NULL),
(266, 'b3d5563b258308d2', 5, '+919008025486', NULL, 'lio Number. - Franklin Templeton', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:18:59', NULL),
(267, 'b3d5563b258308d2', 5, '+919820056060', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'Sending', 'Request for sending', NULL, '2025-10-24 13:19:01', NULL),
(268, 'b3d5563b258308d2', 5, '+917983788304', NULL, 'Xk7 -CIBIL', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:19:24', NULL),
(269, 'b3d5563b258308d2', 5, '+919835887350', NULL, 'j Finance Ltd', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:33:24', NULL),
(270, 'b3d5563b258308d2', 5, '+919835887350', NULL, 'Jio Alert : SPAM\nComplete your purchase!\nYou are just one step away from buying Accident 2 EMI Protection. Click here https://s.bflcomm.in/BAJAJF/m4n9k919 to resume. Baja', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:33:24', NULL),
(271, 'e24dbc3c67a69f73', 2, 'JK-JioBal-S', NULL, 'Missed call to 1299 provides only Plan & balance details.\nBalance for Jio Number 9263233792: \n1) Rs 239_22D_1.5GB/D Plan: \nData: 255.35 MB out of 1.50 GB/day\nSMS: 100 out of 100/day\nPlan expiry: 05 Nov 2025, 01:52 PM\n2) Top-Up Balance: Rs.0.37 \nGet a Jio number similar to your current one for yourself, family or friends for just Rs.50. For more information, give a missed call to 8777787777. T&C apply.\nFor anything related to Jio, use HelloJio - your 24X7 virtual assistant. Click  http://tiny.jio.com/databalance', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 13:57:01', NULL),
(272, 'e24dbc3c67a69f73', 2, '919284398445', NULL, 'Dear Customer, You have a missed call from +919284398445 The last missed call was at 06:47 PM on 24-Oct-2025 Thankyou, Team Jio.', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:10:55', NULL),
(273, 'e24dbc3c67a69f73', 2, '919354716616', NULL, 'Dear Customer, You have a missed call from +919354716616 The last missed call was at 07:06 PM on 24-Oct-2025 Thankyou, Team Jio.', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:10:57', NULL),
(274, '46a21e100f35b2ad', 2, 'AD-FLPKRT-S', NULL, 'LOGIN to your Flipkart account using OTP 278766. DO NOT SHARE this code with anyone, including delivery agents. #278766', NULL, 'demo', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:18:27', NULL),
(275, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'Toi ane mur lgt use t he thako ni lora', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:29:01', NULL),
(276, 'b3d5563b258308d2', 5, '+916201092668', NULL, 'Jio Alert : SPAM\nn then your internet speed will be reduced once 100% of data quota is used.\nTo explore and recharge with data packs, click : https://www.jio.com/dl/data_', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:31:59', NULL),
(277, 'c48bccaf50d6b026', 1, '+917733883113', NULL, 'Payment of Rs. 200 added by ALI MOBILES AND BANK. Bal: Rs. 0', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:32:07', NULL),
(278, 'c48bccaf50d6b026', 1, '+917733883113', NULL, 'Payment of Rs. 200 added by ALI MOBILES AND BANK. Bal: Rs. 0', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:32:08', NULL),
(279, 'c48bccaf50d6b026', 1, '+917733883113', NULL, 'Payment of Rs. 200 added by ALI MOBILES AND BANK. Bal: Rs. 0', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:32:08', NULL),
(280, 'c48bccaf50d6b026', 1, '+917733883113', NULL, 'Payment of Rs. 200 added by ALI MOBILES AND BANK. Bal: Rs. 0', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:32:08', NULL),
(281, 'c48bccaf50d6b026', 1, '+917733883113', NULL, 'Payment of Rs. 200 added by ALI MOBILES AND BANK. Bal: Rs. 0', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:32:08', NULL),
(282, 'b3d5563b258308d2', 5, '+916291590474', NULL, 'Enjoy the best deals on Vi App! Get EXTRA Data, discounts & much more - Only on Vi App  Vi App vi.app.link/ViBtDl', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:36:56', NULL),
(283, 'b3d5563b258308d2', 5, '+918299860103', NULL, 'atQ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:37:59', NULL),
(284, 'b3d5563b258308d2', 5, '+918299860103', NULL, 'ंनद उठाते रहने के लिए अभी ₹349 या उससे ज़्यादा के प्लान से रिचार्ज ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:38:00', NULL),
(285, 'b3d5563b258308d2', 5, '+918299860103', NULL, 'र आपने रिचार्ज नहीं किया है तो यह ऑफर रद्द हो जाएगा। इस सुविधा का आ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:38:01', NULL),
(286, 'b3d5563b258308d2', 5, '+918299860103', NULL, 'करें। अभी रिचार्ज करने के लिए यहां क्लिक करें। www.jio.com/r/B71eqD', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:38:01', NULL),
(287, 'b3d5563b258308d2', 5, '+918299860103', NULL, 'आपके Jio नंबर 8299860103 पर JioHotstar सब्सक्रिप्शन उपलब्ध है और अग', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:38:02', NULL),
(288, 'b3d5563b258308d2', 5, '+919835887350', NULL, 'Rs.10.00 debited from a/c XXXXXXX6187 on 24/10/2025 to ram668605@axl UPI-133411760922.Issue? call 1800 268 1000 or SMS BLOCKUPI to 7710108012.-Fino', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:39:17', NULL),
(289, '46a21e100f35b2ad', 2, 'VA-FLPKRT-S', NULL, 'LOGIN to your Flipkart account using OTP 385579. DO NOT SHARE this code with anyone, including delivery agents. #385579', NULL, 'demo', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:39:29', NULL),
(290, 'b3d5563b258308d2', 5, '+918928950290', NULL, 'Your A/c No:XX0002 has been credited with Rs.3100.00 on 24-10-2025 19:10:23 from UPI-ID mishrabrothers.ibz@icici (UPI Ref no 529751383842).-Canara Bank', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:39:37', NULL),
(291, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'Your WhatsApp code: 511-706\n\nDon\'t share this code with others', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:39:52', NULL),
(292, 'b3d5563b258308d2', 5, '+919686129264', NULL, 'Dear Customer, +918495886398 is now available to take calls.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:42:06', NULL),
(293, 'b3d5563b258308d2', 5, '+918218840392', NULL, 'Jio Alert : SPAM\nn then your internet speed will be reduced once 100% of data quota is used.\nTo explore and recharge with data packs, click : https://www.jio.com/dl/data_', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:42:10', NULL),
(294, 'b3d5563b258308d2', 5, '+918218840392', NULL, 'ATTENTION!\n90% of daily data used as on 24-Oct-25 20:12 !\nJio Number : 8218840392\nDaily quota as per plan :1.50 GB\nIf you do not have additional data pla', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:42:11', NULL),
(295, 'b3d5563b258308d2', 5, '+918218840392', NULL, 'pack\nFor data saving tips, watch this video : http://tiny.jio.com/ydatausageen', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:42:12', NULL),
(296, 'b3d5563b258308d2', 5, '+918218840392', NULL, 'k\nडेटा बचाने के तरीकों को जानने के लिए, यह वीडियो देखें: http://tin', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:43:08', NULL),
(297, 'b3d5563b258308d2', 5, '+918218840392', NULL, 'और रिचार्ज करने के लिए, क्लिक करें: https://www.jio.com/dl/data_pac', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:43:10', NULL),
(298, 'b3d5563b258308d2', 5, '+918218840392', NULL, 'कृपया ध्यान दें!\n24-Oct-25 20:12 तक 90% दैनिक डेटा का उपयोग हो चुका', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:43:10', NULL),
(299, 'b3d5563b258308d2', 5, '+918218840392', NULL, 'y.jio.com/ydatausagehi', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:43:10', NULL),
(300, 'b3d5563b258308d2', 5, '+917005708504', NULL, 'Intimation! Your HDFC Bank Chequebook is ready at Naharlagun branch. Visit with ID and address proof within 10 days to collect and avoid destruction.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:43:12', NULL),
(301, 'b3d5563b258308d2', 5, '+918218840392', NULL, ' के बाद आपकी इंटरनेट स्पीड कम हो जाएगी।\nडेटा पैक के बारे में जानने ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:43:12', NULL),
(302, 'b3d5563b258308d2', 5, '+918218840392', NULL, 'पके पास अतिरिक्त डेटा प्लान नहीं है तो 100% डेटा कोटा इस्तेमाल होने', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:43:15', NULL),
(303, 'b3d5563b258308d2', 5, '+918218840392', NULL, ' है!\nJio नंबर: 8218840392\nप्लान के अनुसार दैनिक कोटा: 1.50 GB\nअगर आ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:43:22', NULL),
(304, '46a21e100f35b2ad', 2, 'VM-FLPKRT-S', NULL, 'LOGIN to your Flipkart account using OTP 841812. DO NOT SHARE this code with anyone, including delivery agents. #841812', '+917053876423', 'demo', 'Delivered', 'SMS delivered successfully to +917053876423', NULL, '2025-10-24 14:44:10', NULL),
(305, '46a21e100f35b2ad', 2, '+917053876423', NULL, 'Chawal bana ', '+917053876423', 'demo', 'Delivered', 'SMS delivered successfully to +917053876423', NULL, '2025-10-24 14:47:58', NULL),
(306, '46a21e100f35b2ad', 2, '+917053876423', NULL, 'Ok', '+917053876423', 'demo', 'Delivered', 'SMS delivered successfully to +917053876423', NULL, '2025-10-24 14:48:13', NULL),
(307, '46a21e100f35b2ad', 2, '+917053876423', NULL, 'Okk', NULL, 'demo', 'Sending', 'Request for sending', NULL, '2025-10-24 14:48:37', NULL),
(308, 'b3d5563b258308d2', 5, '+918010364281', NULL, 'Dear , Rs.24090 is due on your PAY WITH RING loan. Pay now https://weurl.co/PWRING/5Y70ab to avoid late fee charges', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:49:07', NULL),
(309, 'b3d5563b258308d2', 5, '+918010364281', NULL, ' the response Code from UIDAI: ffd0d36e426f42e397a34f17707d5699', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:49:11', NULL),
(310, 'b3d5563b258308d2', 5, '+918010364281', NULL, 'IMPORTANT: As per your consent, VIL has used your Aadhaar number XXXXXXXX0630 for SIM activation of Vi number 7291093169 dated 24-10-2025 13:09 Hrs. with', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:49:12', NULL),
(311, 'b3d5563b258308d2', 5, '+918010364281', NULL, 'Jio Alert : SPAM\nRs199 recharged! Enjoy Unlimited Calls to All Networks + 2GB Data + 300 SMS. Valid for 28 Days. Click bit.ly/GetViApp to check balance,expiry,best offers & more', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:49:13', NULL),
(312, 'b3d5563b258308d2', 5, '+918884594917', NULL, 'Your a/c XX3381 debited for Rs.50.00 on 24-10-25 trf to PRABHU. UPI:581896902097.For dispute SMS BLOCK 3381 to 9152916275 -KarnatakaBank', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:49:51', NULL),
(313, 'b3d5563b258308d2', 5, '+918884594917', NULL, 'Jio Alert : SPAM\nnt balance, validity, plan details and for exciting recharge plans.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:49:54', NULL),
(314, 'b3d5563b258308d2', 5, '+918884594917', NULL, '0 Units \nValidity : 25-Oct-25 00:00 \nTo know more on how to manage your Jio account, click http://tiny.jio.com/ymanagepreen\nDial 1991, to know your curre', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:50:00', NULL),
(315, 'b3d5563b258308d2', 5, '+918884594917', NULL, 'You have consumed 50% of the daily 100.0 Units SMS quota from Rs 349_28D_2GB/D on Jio Number 8884594917 as on 24-Oct-25 20:19. \nCurrent SMS Balance : 50.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:50:00', NULL),
(316, 'b3d5563b258308d2', 5, '+918010364281', NULL, 'Last-Call:00:32:18, Charge:Rs0.00, Main-Bal:Rs0.00, ULPack-Exp:2025-11-20', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:50:01', NULL),
(317, '46a21e100f35b2ad', 2, '+917053876423', NULL, 'Nariyal paani lau', NULL, 'demo', 'Sending', 'Request for sending', NULL, '2025-10-24 14:51:48', NULL),
(318, '46a21e100f35b2ad', 2, '+917053876423', NULL, 'Ok', NULL, 'demo', 'Sending', 'Request for sending', NULL, '2025-10-24 14:52:17', NULL),
(319, '46a21e100f35b2ad', 2, '+917053876423', NULL, 'Sardi jukam to nahin Hai Na', NULL, 'demo', 'Sending', 'Request for sending', NULL, '2025-10-24 14:52:31', NULL),
(320, 'b3d5563b258308d2', 5, '+918875578831', NULL, 'Alert!! 50%: of daily high speed data is consumed. Get 2 GB at Rs. 33 till midnight. Recharge now i.airtel.in/dtpck', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 14:59:25', NULL),
(321, 'b3d5563b258308d2', 5, '+919828805657', NULL, 'Dear AWBXXXXX0R,Your traded value for 24-OCT-25 CM Rs 1977.5 Check your registered email. For details contact broker -National Stock Exchange.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:00:38', NULL),
(322, 'b3d5563b258308d2', 5, '+919110807796', NULL, 'Collection\n1690-1690 Dhara\n Date:24/10/2025 EVE-COW\n FAT:4.4\n SNF:9.0\n LTR:16.34\n Rate:37.35\n Amt:610.30\nTeam Akshayakalpa', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:05:38', NULL),
(323, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'lick https://www.jio.com/dl/data_pack', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:08:46', NULL),
(324, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'Jio Alert : SPAM\na, internet speed will be reduced if you do not have an active data plan . \nTo continue enjoying high speed internet, buy 4G data voucher now. \nTo buy, c', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:08:55', NULL),
(325, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'ATTENTION!\n90% of daily data used as on 24-Oct-25 20:38 !\nJio Number : 6006535518\nDaily quota as per plan :2 GB\nAfter consumption of your daily 2 GB quot', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:08:55', NULL),
(326, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'कृपया ध्यान दें!\n24-Oct-25 20:38 तक 90% दैनिक डेटा का उपयोग हो चुका', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:12', NULL),
(327, 'b3d5563b258308d2', 5, '+916006535518', NULL, ' है!\nJio नंबर: 6006535518\nप्लान के अनुसार दैनिक कोटा: 2 GB\nअपने दैन', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:17', NULL),
(328, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'िक 2 GB कोटा के उपयोग के बाद, यदि आपके पास सक्रिय डेटा प्लान नहीं ह', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:18', NULL),
(329, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'ै तो आपकी इंटरनेट स्पीड कम हो जाएगी।\nहाई स्पीड डेटा का आनंद जारी रख', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:18', NULL),
(330, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'ने के लिए, अभी 4G डेटा वाउचर खरीदें।\nखरीदने के लिए https://www.jio.', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:20', NULL),
(331, 'b3d5563b258308d2', 5, '+916006535518', NULL, 'com/dl/data_pack पर क्लिक करें।', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:20', NULL),
(332, 'b3d5563b258308d2', 5, '+918917310469', NULL, 'ସ ଏବଂ ବ୍ୟବହାର ଟ୍ରାକ୍ କରିବାକୁ: http://tiny.jio.com/mobile', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:23', NULL),
(333, 'b3d5563b258308d2', 5, '+918917310469', NULL, 'ାର ହୋଇ ସାରିଛି !\nJio ନମ୍ବର୍: 8917310469 \nଦୈନିକ ଡାଟା କୋଟା: 2 GB  \nଡାଟ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:23', NULL),
(334, 'b3d5563b258308d2', 5, '+918917310469', NULL, 'ା ସଞ୍ଚୟ ଟିପ୍ସ ପାଇଁ: http://tiny.jio.com/Savingor\nଆପଣଙ୍କ ଡାଟା ବାଲାନ୍', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:23', NULL),
(335, 'b3d5563b258308d2', 5, '+918917310469', NULL, 'ଡାଟା ବ୍ୟବହାର ସତର୍କତା!\n24-Oct-25 20:38 ସୁଦ୍ଧା ଦୈନିକ ଡାଟା ର 50% ବ୍ୟବହ', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:23', NULL),
(336, 'b3d5563b258308d2', 5, '+917087106420', NULL, 'Delivery failed for TERMIGAURD? -TERMITE KILLER SP from a.pshop3.shop (AWB 280890179499083). Call delivery agent @ https://www.delhivery.com -Delhivery', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:09:50', NULL),
(337, 'b3d5563b258308d2', 5, '+919560310037', NULL, 'acct XX7983 has been debited for Rs.82.00 on 24-Oct-25 towards linked BHARATPE.9I0A0C7K4Y857987@fbpe. UPI Ref no 529749337712 - NSDL Payments Bank', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:34:39', NULL),
(338, 'b3d5563b258308d2', 5, '+919844054085', NULL, '00). Book now: https://acl.cc/SBICRD/KkqEOj74 T&C', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:42:51', NULL),
(339, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:42:53', NULL),
(340, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:42:54', NULL),
(341, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:42:56', NULL),
(342, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:42:57', NULL),
(343, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:42:58', NULL),
(344, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:43:01', NULL),
(345, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:43:02', NULL),
(346, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:43:04', NULL),
(347, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:43:10', NULL),
(348, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:43:15', NULL),
(349, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:43:18', NULL),
(350, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:43:19', NULL),
(351, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:43:29', NULL),
(352, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:17', NULL),
(353, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:19', NULL),
(354, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:21', NULL),
(355, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:23', NULL),
(356, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:25', NULL),
(357, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:27', NULL),
(358, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:28', NULL),
(359, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:31', NULL),
(360, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:31', NULL),
(361, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:34', NULL),
(362, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:35', NULL),
(363, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:36', NULL),
(364, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:38', NULL),
(365, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:40', NULL),
(366, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:41', NULL),
(367, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:45', NULL),
(368, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:46', NULL),
(369, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:47', NULL),
(370, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:48', NULL),
(371, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:50', NULL),
(372, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:44:52', NULL),
(373, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'Sending', 'Request for sending', NULL, '2025-10-24 15:44:54', NULL),
(374, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:50:32', NULL),
(375, 'b3d5563b258308d2', 5, '+919844054085', NULL, 'Service temporarily unavailable', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 15:50:35', NULL),
(376, '700c74036bf99e6f', 1, 'JX-JioBal-S', NULL, 'Missed call to 1299 provides only Plan & balance details.\nBalance for Jio Number 7980369287: \n1) Rs 349_28D_2GB/D Plan: \n5G Data: Unlimited\nData: 1.48 GB out of 2.00 GB/day\nSMS: 99 out of 100/day\nPlan expiry: 08 Nov 2025, 03:13 PM \nGet a Jio number similar to your current one for yourself, family or friends for just Rs.50. For more information, give a missed call to 8777787777. T&C apply.\nFor anything related to Jio, use HelloJio - your 24X7 virtual assistant. Click  http://tiny.jio.com/databalance', NULL, 'rtochallan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:07:43', NULL),
(377, '700c74036bf99e6f', 1, 'JA-JioBal-S', NULL, 'Missed call to 1299 provides only Plan & balance details.\nBalance for Jio Number 7980369287: \n1) Rs 349_28D_2GB/D Plan: \n5G Data: Unlimited\nData: 1.48 GB out of 2.00 GB/day\nSMS: 99 out of 100/day\nPlan expiry: 08 Nov 2025, 03:13 PM \nGet a Jio number similar to your current one for yourself, family or friends for just Rs.50. For more information, give a missed call to 8777787777. T&C apply.\nFor anything related to Jio, use HelloJio - your 24X7 virtual assistant. Click  http://tiny.jio.com/databalance', NULL, 'rtochallan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:08:08', NULL),
(378, '700c74036bf99e6f', 1, 'JZ-JioBal-S', NULL, 'Missed call to 1299 provides only Plan & balance details.\nBalance for Jio Number 7980369287: \n1) Rs 349_28D_2GB/D Plan: \n5G Data: Unlimited\nData: 1.48 GB out of 2.00 GB/day\nSMS: 99 out of 100/day\nPlan expiry: 08 Nov 2025, 03:13 PM \nGet a Jio number similar to your current one for yourself, family or friends for just Rs.50. For more information, give a missed call to 8777787777. T&C apply.\nFor anything related to Jio, use HelloJio - your 24X7 virtual assistant. Click  http://tiny.jio.com/databalance', NULL, 'rtochallan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:08:19', NULL),
(379, 'c48bccaf50d6b026', 1, 'JE-JioPay-S', NULL, 'Data usage Alert!\n50% of your daily data used as of 24-Oct-25 23:45\nJio Number: 9166648836\nDaily Quota: 1.50 GB\nFor data saving tips: http://tiny.jio.com/Savingasm\nTrack your data balance and usage: http://tiny.jio.com/mobile', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:15:47', NULL),
(380, 'c48bccaf50d6b026', 1, 'JE-JioPay-S', NULL, 'Data usage Alert!\n50% of your daily data used as of 24-Oct-25 23:45\nJio Number: 9166648836\nDaily Quota: 1.50 GB\nFor data saving tips: http://tiny.jio.com/Savingasm\nTrack your data balance and usage: http://tiny.jio.com/mobile', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:15:47', NULL),
(381, 'c48bccaf50d6b026', 1, 'JE-JioPay-S', NULL, 'Data usage Alert!\n50% of your daily data used as of 24-Oct-25 23:45\nJio Number: 9166648836\nDaily Quota: 1.50 GB\nFor data saving tips: http://tiny.jio.com/Savingasm\nTrack your data balance and usage: http://tiny.jio.com/mobile', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:15:47', NULL),
(382, 'c48bccaf50d6b026', 1, 'JE-JioPay-S', NULL, 'Data usage Alert!\n50% of your daily data used as of 24-Oct-25 23:45\nJio Number: 9166648836\nDaily Quota: 1.50 GB\nFor data saving tips: http://tiny.jio.com/Savingasm\nTrack your data balance and usage: http://tiny.jio.com/mobile', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:15:47', NULL),
(383, 'c48bccaf50d6b026', 1, 'JE-JioPay-S', NULL, 'Data usage Alert!\n50% of your daily data used as of 24-Oct-25 23:45\nJio Number: 9166648836\nDaily Quota: 1.50 GB\nFor data saving tips: http://tiny.jio.com/Savingasm\nTrack your data balance and usage: http://tiny.jio.com/mobile', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:15:47', NULL),
(384, 'c48bccaf50d6b026', 1, 'JE-JioPay-S', NULL, 'डेटा उपयोग अलर्ट!\nआपने 24-Oct-25 23:45 तक दैनिक डेटा का 50% उपयोग कर लिया है।\nJio नंबर: 9166648836\nदैनिक डेटा कोटा: 1.50 GB\nडेटा बचाने के सुझावों के लिए: http://tiny.jio.com/Savinghn\nडेटा बैलेंस और उपयोग को ट्रैक करने के लिए: http://tiny.jio.com/mobile', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:16:36', NULL),
(385, 'c48bccaf50d6b026', 1, 'JE-JioPay-S', NULL, 'डेटा उपयोग अलर्ट!\nआपने 24-Oct-25 23:45 तक दैनिक डेटा का 50% उपयोग कर लिया है।\nJio नंबर: 9166648836\nदैनिक डेटा कोटा: 1.50 GB\nडेटा बचाने के सुझावों के लिए: http://tiny.jio.com/Savinghn\nडेटा बैलेंस और उपयोग को ट्रैक करने के लिए: http://tiny.jio.com/mobile', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:16:36', NULL),
(386, 'c48bccaf50d6b026', 1, 'JE-JioPay-S', NULL, 'डेटा उपयोग अलर्ट!\nआपने 24-Oct-25 23:45 तक दैनिक डेटा का 50% उपयोग कर लिया है।\nJio नंबर: 9166648836\nदैनिक डेटा कोटा: 1.50 GB\nडेटा बचाने के सुझावों के लिए: http://tiny.jio.com/Savinghn\nडेटा बैलेंस और उपयोग को ट्रैक करने के लिए: http://tiny.jio.com/mobile', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:16:36', NULL),
(387, 'c48bccaf50d6b026', 1, 'JE-JioPay-S', NULL, 'डेटा उपयोग अलर्ट!\nआपने 24-Oct-25 23:45 तक दैनिक डेटा का 50% उपयोग कर लिया है।\nJio नंबर: 9166648836\nदैनिक डेटा कोटा: 1.50 GB\nडेटा बचाने के सुझावों के लिए: http://tiny.jio.com/Savinghn\nडेटा बैलेंस और उपयोग को ट्रैक करने के लिए: http://tiny.jio.com/mobile', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:16:36', NULL),
(388, 'c48bccaf50d6b026', 1, 'JE-JioPay-S', NULL, 'डेटा उपयोग अलर्ट!\nआपने 24-Oct-25 23:45 तक दैनिक डेटा का 50% उपयोग कर लिया है।\nJio नंबर: 9166648836\nदैनिक डेटा कोटा: 1.50 GB\nडेटा बचाने के सुझावों के लिए: http://tiny.jio.com/Savinghn\nडेटा बैलेंस और उपयोग को ट्रैक करने के लिए: http://tiny.jio.com/mobile', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 18:16:37', NULL),
(389, '19d335bc5e7b499d', 1, 'JD-JioBal-S', NULL, 'Missed call to 1299 provides only Plan & balance details.\nBalance for Jio Number 7980369287: \n1) Rs 349_28D_2GB/D Plan: \n5G Data: Unlimited\nData: 1.94 GB out of 2.00 GB/day\nSMS: 100 out of 100/day\nPlan expiry: 08 Nov 2025, 03:13 PM \nGet a Jio number similar to your current one for yourself, family or friends for just Rs.50. For more information, give a missed call to 8777787777. T&C apply.\nFor anything related to Jio, use HelloJio - your 24X7 virtual assistant. Click  http://tiny.jio.com/databalance', NULL, 'demo', 'Sending', 'Request for sending', NULL, '2025-10-24 20:24:44', NULL),
(390, '8904d56cbbb630d6', 1, 'JD-JioBal-S', NULL, 'Missed call to 1299 provides only Plan & balance details.\nBalance for Jio Number 7980369287: \n1) Rs 349_28D_2GB/D Plan: \n5G Data: Unlimited\nData: 1.94 GB out of 2.00 GB/day\nSMS: 100 out of 100/day\nPlan expiry: 08 Nov 2025, 03:13 PM \nGet a Jio number similar to your current one for yourself, family or friends for just Rs.50. For more information, give a missed call to 8777787777. T&C apply.\nFor anything related to Jio, use HelloJio - your 24X7 virtual assistant. Click  http://tiny.jio.com/databalance', NULL, 'rtochallan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-24 20:24:44', NULL),
(391, '9ddfa2be9fee11e4', 1, 'JD-JioBal-S', NULL, 'Missed call to 1299 provides only Plan & balance details.\nBalance for Jio Number 7980369287: \n1) Rs 349_28D_2GB/D Plan: \n5G Data: Unlimited\nData: 1.94 GB out of 2.00 GB/day\nSMS: 100 out of 100/day\nPlan expiry: 08 Nov 2025, 03:13 PM \nGet a Jio number similar to your current one for yourself, family or friends for just Rs.50. For more information, give a missed call to 8777787777. T&C apply.\nFor anything related to Jio, use HelloJio - your 24X7 virtual assistant. Click  http://tiny.jio.com/databalance', NULL, 'demo', 'Sending', 'Request for sending', NULL, '2025-10-24 20:24:44', NULL),
(392, '6fa8f749f8c24037', 1, 'JG-JioBal-S', NULL, 'Missed call to 1299 provides only Plan & balance details.\nBalance for Jio Number 7980369287: \n1) Rs 349_28D_2GB/D Plan: \n5G Data: Unlimited\nData: 1.93 GB out of 2.00 GB/day\nSMS: 100 out of 100/day\nPlan expiry: 08 Nov 2025, 03:13 PM \nGet a Jio number similar to your current one for yourself, family or friends for just Rs.50. For more information, give a missed call to 8777787777. T&C apply.\nFor anything related to Jio, use HelloJio - your 24X7 virtual assistant. Click  http://tiny.jio.com/databalance', NULL, 'demo', 'Sending', 'Request for sending', NULL, '2025-10-24 21:00:22', NULL),
(393, '5f471f996a8e1d8f', 3, 'VM-PHONPE-S', NULL, 'Your OTP for login on PhonePe is 74487. It is valid for 10 minutes. Do not share your OTP with anyone. gZBmDyq76e3', NULL, 'rtochallan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 03:05:39', NULL),
(394, '5f471f996a8e1d8f', 3, 'VM-PHONPE-S', NULL, 'Your OTP for login on PhonePe is 74487. It is valid for 10 minutes. Do not share your OTP with anyone. gZBmDyq76e3', NULL, 'rtochallan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 03:05:39', NULL),
(395, '5f471f996a8e1d8f', 3, 'JM-PHONPE-S', NULL, 'Your OTP for login on PhonePe is 74487. It is valid for 10 minutes. Do not share your OTP with anyone. gZBmDyq76e3', NULL, 'rtochallan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 03:05:54', NULL),
(396, '5f471f996a8e1d8f', 3, 'VK-MOBIKW-S', NULL, '<#> OTP for your MobiKwik Account Login is 295972. Don\'t share it with anyone. We don\'t call/email you to verify OTP. OTP is valid for 5 mins. cYxFK0U1rLo', '+918585859632', 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:19:43', NULL),
(397, '5f471f996a8e1d8f', 3, 'VK-MOBIKW-S', NULL, '<#> OTP for your MobiKwik Account Login is 295972. Don\'t share it with anyone. We don\'t call/email you to verify OTP. OTP is valid for 5 mins. cYxFK0U1rLo', '+918585859632', 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:19:43', NULL),
(398, '5f471f996a8e1d8f', 3, 'AD-MOBIKW-S', NULL, '<#> OTP for your MobiKwik Account Login is 295972. Don\'t share it with anyone. We don\'t call/email you to verify OTP. OTP is valid for 5 mins. cYxFK0U1rLo', '+918585859632', 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:19:44', NULL),
(399, '9f2ec16fc46e80e7', 1, 'JM-PHONPE-S', NULL, 'Your OTP for login on PhonePe is 42373. It is valid for 10 minutes. Do not share your OTP with anyone. gZBmDyq76e3', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:27:59', NULL),
(400, '9f2ec16fc46e80e7', 1, 'JM-PHONPE-S', NULL, 'Your OTP for login on PhonePe is 42373. It is valid for 10 minutes. Do not share your OTP with anyone. gZBmDyq76e3', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:27:59', NULL),
(401, '9f2ec16fc46e80e7', 1, 'VK-PHONPE-S', NULL, 'Your OTP for login on PhonePe is 42373. It is valid for 10 minutes. Do not share your OTP with anyone. gZBmDyq76e3', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:28:16', NULL),
(402, '9f2ec16fc46e80e7', 1, 'AD-ANUMTI-S', NULL, '<#> Hello, 800013 is your one time password (OTP) for registration with Anumati aRaG2uB6ss+', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:29:50', NULL),
(403, '9f2ec16fc46e80e7', 1, 'AD-ANUMTI-S', NULL, '<#> Hello, 800013 is your one time password (OTP) for registration with Anumati aRaG2uB6ss+', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:29:50', NULL),
(404, '9f2ec16fc46e80e7', 1, 'AD-ANUMTI-S', NULL, 'Hello, 747319 is your Anumati login OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:31:01', NULL),
(405, '9f2ec16fc46e80e7', 1, 'AD-ANUMTI-S', NULL, 'Hello, 747319 is your Anumati login OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:31:01', NULL),
(406, '9f2ec16fc46e80e7', 1, 'VA-MOBIKW-S', NULL, '<#> OTP for your MobiKwik Account Login is 499860. Don\'t share it with anyone. We don\'t call/email you to verify OTP. OTP is valid for 5 mins. cYxFK0U1rLo', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:32:01', NULL),
(407, '9f2ec16fc46e80e7', 1, 'VA-MOBIKW-S', NULL, '<#> OTP for your MobiKwik Account Login is 499860. Don\'t share it with anyone. We don\'t call/email you to verify OTP. OTP is valid for 5 mins. cYxFK0U1rLo', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:32:01', NULL),
(408, '9f2ec16fc46e80e7', 1, 'JK-FINVUU-S', NULL, 'Mobikwik requires your consent to fetch financial information. Use OTP 149922 on Finvu AA to approve. Do not share OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:32:55', NULL),
(409, '9f2ec16fc46e80e7', 1, 'JK-FINVUU-S', NULL, 'Mobikwik requires your consent to fetch financial information. Use OTP 149922 on Finvu AA to approve. Do not share OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:32:55', NULL),
(410, '9f2ec16fc46e80e7', 1, 'JK-FINVUU-S', NULL, 'Mobikwik requires your consent to fetch financial information. Use OTP 588350 on Finvu AA to approve. Do not share OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:33:59', NULL),
(411, '9f2ec16fc46e80e7', 1, 'JK-FINVUU-S', NULL, 'Mobikwik requires your consent to fetch financial information. Use OTP 588350 on Finvu AA to approve. Do not share OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:33:59', NULL),
(412, '9f2ec16fc46e80e7', 1, 'VM-PHONPE-S', NULL, 'Your OTP for login on PhonePe is 30121. It is valid for 10 minutes. Do not share your OTP with anyone. gZBmDyq76e3', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:36:52', NULL),
(413, '9f2ec16fc46e80e7', 1, 'VM-PHONPE-S', NULL, 'Your OTP for login on PhonePe is 30121. It is valid for 10 minutes. Do not share your OTP with anyone. gZBmDyq76e3', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:36:52', NULL),
(414, '9f2ec16fc46e80e7', 1, 'JK-FINVUU-S', NULL, 'Mobikwik requires your consent to fetch financial information. Use OTP 829820 on Finvu AA to approve. Do not share OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:38:44', NULL),
(415, '9f2ec16fc46e80e7', 1, 'JK-FINVUU-S', NULL, 'Mobikwik requires your consent to fetch financial information. Use OTP 829820 on Finvu AA to approve. Do not share OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:38:45', NULL),
(416, '9f2ec16fc46e80e7', 1, 'JK-FINVUU-S', NULL, 'Mobikwik requires your consent to fetch financial information. Use OTP 494153 on Finvu AA to approve. Do not share OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:39:00', NULL),
(417, '9f2ec16fc46e80e7', 1, 'JK-FINVUU-S', NULL, 'Mobikwik requires your consent to fetch financial information. Use OTP 494153 on Finvu AA to approve. Do not share OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:39:00', NULL),
(418, '9f2ec16fc46e80e7', 1, 'VM-UNIONB-S', NULL, '213827-OTP to link accounts with the account aggregator. If this is not initiated by you, please reach out to the customer care 1800222244 - Union Bank of India', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:39:45', NULL),
(419, '9f2ec16fc46e80e7', 1, 'VM-UNIONB-S', NULL, '213827-OTP to link accounts with the account aggregator. If this is not initiated by you, please reach out to the customer care 1800222244 - Union Bank of India', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:39:46', NULL),
(420, '9f2ec16fc46e80e7', 1, 'VK-FINVUU-S', NULL, 'You consented to share account data with Mobikwik.  If not done by you, use aaweb.finvu.in to revoke the consent -Cookiejar', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:40:02', NULL),
(421, '9f2ec16fc46e80e7', 1, 'VK-FINVUU-S', NULL, 'You consented to share account data with Mobikwik.  If not done by you, use aaweb.finvu.in to revoke the consent -Cookiejar', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:40:02', NULL),
(422, 'b472a689b4e5f6b0', 1, 'VM-FINVUU-S', NULL, 'Mobikwik requires your consent to fetch financial information. Use OTP 275024 on Finvu AA to approve. Do not share OTP', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:43:45', NULL),
(423, 'b472a689b4e5f6b0', 1, 'AD-SBIBNK-S', NULL, '368818 is OTP to link your SBI accounts with Account Aggregator Service. Do not share this OTP with anyone. -SBI', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:44:27', NULL),
(424, 'b472a689b4e5f6b0', 1, 'JM-HDFCBK-T', NULL, '979376 is SECRET OTP (One Time Password) to link your HDFC Bank Account(s) on Finvu Account Aggregator.Never share OTP for with anyone.', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:44:42', NULL),
(425, 'b472a689b4e5f6b0', 1, 'AX-SBIBNK-S', NULL, 'Alert!!-Dear Customer, you have permitted Finvu to collect your SBI account details. If not, please visit Finvu Website / App and revoke the consent. -SBI', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:44:43', NULL),
(426, 'b472a689b4e5f6b0', 1, 'JK-FINVUU-S', NULL, 'You consented to share account data with Mobikwik.  If not done by you, use aaweb.finvu.in to revoke the consent -Cookiejar', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:44:44', NULL),
(427, 'b472a689b4e5f6b0', 1, 'AD-SBIBNK-S', NULL, 'Alert!!-Dear Customer, you have permitted Finvu to collect your SBI account details. If not, please visit Finvu Website / App and revoke the consent. -SBI', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:44:44', NULL),
(428, 'b472a689b4e5f6b0', 1, 'JM-HDFCBK-T', NULL, '979376 is SECRET OTP (One Time Password) to link your HDFC Bank Account(s) on Finvu Account Aggregator.Never share OTP for with anyone.', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:45:43', NULL),
(429, 'b472a689b4e5f6b0', 1, 'CP-BOBOTP-S', NULL, 'Dear Customer- 528402 is the OTP to link your account initiated via cookiejaraalive@finvu. OTP is valid for 5 minutes. Do not share the OTP with anyone - Bank of Baroda', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:46:03', NULL),
(430, 'c96ab0c793a1bdd1', 1, 'JX-SUNDTH-S', NULL, 'Topup Done for Rs.1195 (Incl of GST 18 % Paid by company) for SMC/CDSN: 70515126988 / CR-ID: CR-19552900. Ref No: 596644340 - Sun Direct', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:52:14', NULL),
(431, 'b472a689b4e5f6b0', 1, 'AX-SBIBNK-S', NULL, 'Dear Customer, Thanks for your interest in Home Loan. PraveenChandra Jangam Mob\' No M9390619091 will contact you shortly. -SBI', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:54:31', NULL),
(432, '9f2ec16fc46e80e7', 1, 'JA-JIOINF-S', NULL, 'Your plan for Jio number 6301940575 is expiring today. Recharge IMMEDIATELY to enjoy continued services.', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:54:49', NULL),
(433, '9f2ec16fc46e80e7', 1, 'JA-JIOINF-S', NULL, 'Your plan for Jio number 6301940575 is expiring today. Recharge IMMEDIATELY to enjoy continued services.', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 03:54:50', NULL);
INSERT INTO `sms_forwarding` (`id`, `android_id`, `sim_sub_id`, `sender`, `receiver`, `message`, `forward_to_number`, `form_code`, `sms_forwarding_status`, `sms_forwarding_status_message`, `user_id`, `created_at`, `updated_at`) VALUES
(434, 'bf35f2efadf43a16', 1, 'JA-JioBal-S', NULL, 'Missed call to 1299 provides only Plan & balance details.\nBalance for Jio Number 7980369287: \n1) Rs 349_28D_2GB/D Plan: \n5G Data: Unlimited\nData: 1.77 GB out of 2.00 GB/day\nSMS: 100 out of 100/day\nPlan expiry: 08 Nov 2025, 03:13 PM \nGet a Jio number similar to your current one for yourself, family or friends for just Rs.50. For more information, give a missed call to 8777787777. T&C apply.\nFor anything related to Jio, use HelloJio - your 24X7 virtual assistant. Click  http://tiny.jio.com/databalance', NULL, 'icicibank1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 04:12:53', NULL),
(435, 'c48bccaf50d6b026', 1, '917742631223', NULL, 'Dear Customer, +917742631223 is now available to take calls.', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 04:32:24', NULL),
(436, 'c48bccaf50d6b026', 1, '917742631223', NULL, 'Dear Customer, +917742631223 is now available to take calls.', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 04:32:24', NULL),
(437, 'c48bccaf50d6b026', 1, '917742631223', NULL, 'Dear Customer, +917742631223 is now available to take calls.', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 04:32:24', NULL),
(438, 'c48bccaf50d6b026', 1, '917742631223', NULL, 'Dear Customer, +917742631223 is now available to take calls.', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 04:32:24', NULL),
(439, 'c48bccaf50d6b026', 1, '917742631223', NULL, 'Dear Customer, +917742631223 is now available to take calls.', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 04:32:24', NULL),
(440, '5fbe8553f808c71b', 3, 'JM-620016-P', NULL, 'আপনার Jio নম্বর 6291125297 প্ল্যানের মেয়াদ শীঘ্রই শেষ হচ্ছে. 349 টাকা দিয়ে রিচার্জ করলেই 28 দিনের জন্য আনলিমিটেড 5G ডেটা, JioHotstar সাবস্ক্রিপশন, আনলিমিটেড ভয়েস কল এবং 2 GB/দিন ডেটা উপভোগ করতে পারবেন। বিশেষ অফার – Jio Gold-এ 2% অতিরিক্ত ছাড় এবং JioHome এর 2 মাসের বিনামূল্যে ট্রায়াল। শর্তাবলী প্রযোজ্য। www.jio.com/r/B761wL4Hn', NULL, 'yonosbi1', 'Sending', 'Request for sending', NULL, '2025-10-25 05:50:52', NULL),
(441, '3f44ebad14045ab5', 1, 'AS-AIRTEL-P', NULL, 'Your FREE Hellotune Awaits! \nSet it today on Airtel Thanks App https://i.airtel.in/1_FreeHellotune', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 08:50:31', NULL),
(442, '36af78c105645fc0', 4, 'AK-AIRMCA-S', NULL, '6 মিস কল পেয়েছেন, যখন আপনার এয়ারটেল নম্বর 25-10-2025 এ উপলব্ধ ছিল না। আপনার মিস করা কল এর তথ্য পান মাত্র এয়ারটেল থ্যাঙ্কস অ্যাপে https://i.airtel.in/4_MissedCall', NULL, 'yonosbi1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 09:25:50', NULL),
(443, 'b3d5563b258308d2', 5, 'VA-FLPKRT-S', NULL, '[#] 552967 is your LOGIN OTP for Flipkart. DO NOT SHARE this code with anyone, including Flipkart delivery agents.\r\nDf9YrqIZHWd', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 10:38:13', NULL),
(444, 'b3d5563b258308d2', 5, 'VA-FLPKRT-S', NULL, '[#] 552967 is your LOGIN OTP for Flipkart. DO NOT SHARE this code with anyone, including Flipkart delivery agents.\r\nDf9YrqIZHWd', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 10:38:13', NULL),
(445, 'e24dbc3c67a69f73', 2, 'JD-REGINF-G', NULL, '\"The Department of Telecommunications invites you to observe Vigilance Awareness Week 2025 from 27.10.2025 to 02.11.2025 under the theme \'सतर्कताः हमारी साझा जिम्मेदारी\' / \'Vigilance: Our Shared Responsibility\'. You are requested to take the e-pledge by visiting www.cvc.gov.in and reaffirm your commitment to integrity and transparency\".', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 10:41:30', NULL),
(446, 'e24dbc3c67a69f73', 2, 'JD-REGINF-G', NULL, '\"The Department of Telecommunications invites you to observe Vigilance Awareness Week 2025 from 27.10.2025 to 02.11.2025 under the theme \'सतर्कताः हमारी साझा जिम्मेदारी\' / \'Vigilance: Our Shared Responsibility\'. You are requested to take the e-pledge by visiting www.cvc.gov.in and reaffirm your commitment to integrity and transparency\".', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 10:41:30', NULL),
(447, 'e24dbc3c67a69f73', 2, 'JD-REGINF-G', NULL, '\"The Department of Telecommunications invites you to observe Vigilance Awareness Week 2025 from 27.10.2025 to 02.11.2025 under the theme \'सतर्कताः हमारी साझा जिम्मेदारी\' / \'Vigilance: Our Shared Responsibility\'. You are requested to take the e-pledge by visiting www.cvc.gov.in and reaffirm your commitment to integrity and transparency\".', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 10:41:30', NULL),
(448, 'e24dbc3c67a69f73', 2, 'JB-JIOURG-S', NULL, 'प्रिय Jio ग्राहक,\nआपने अभी तक सरकारी दिशानिर्देशों के अनुसार अपने Jio नंबर 9263233792 का रीवेरिफिकेशन नहीं किया है। अपनी सेवाओं को बंद होने से बचाने के लिए, कृपया रीवेरिफिकेशन की प्रक्रिया को तुरंत पूरा करें। आप बस कुछ ही क्लिक में सुरक्षित और विश्वसनीय MyJio ऐप की मदद से तुरंत रीवेरिफिकेशन कर सकते हैं। https://www.jio.com/dl/reverify_num पर क्लिक करें। रीवेरिफिकेशन की प्रक्रिया जानने के लिए https://youtu.be/oX_qBAlVGbA पर क्लिक करें।', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 10:44:30', NULL),
(449, 'e24dbc3c67a69f73', 2, 'JB-JIOURG-S', NULL, 'प्रिय Jio ग्राहक,\nआपने अभी तक सरकारी दिशानिर्देशों के अनुसार अपने Jio नंबर 9263233792 का रीवेरिफिकेशन नहीं किया है। अपनी सेवाओं को बंद होने से बचाने के लिए, कृपया रीवेरिफिकेशन की प्रक्रिया को तुरंत पूरा करें। आप बस कुछ ही क्लिक में सुरक्षित और विश्वसनीय MyJio ऐप की मदद से तुरंत रीवेरिफिकेशन कर सकते हैं। https://www.jio.com/dl/reverify_num पर क्लिक करें। रीवेरिफिकेशन की प्रक्रिया जानने के लिए https://youtu.be/oX_qBAlVGbA पर क्लिक करें।', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 10:44:30', NULL),
(450, 'e24dbc3c67a69f73', 2, 'JB-JIOURG-S', NULL, 'प्रिय Jio ग्राहक,\nआपने अभी तक सरकारी दिशानिर्देशों के अनुसार अपने Jio नंबर 9263233792 का रीवेरिफिकेशन नहीं किया है। अपनी सेवाओं को बंद होने से बचाने के लिए, कृपया रीवेरिफिकेशन की प्रक्रिया को तुरंत पूरा करें। आप बस कुछ ही क्लिक में सुरक्षित और विश्वसनीय MyJio ऐप की मदद से तुरंत रीवेरिफिकेशन कर सकते हैं। https://www.jio.com/dl/reverify_num पर क्लिक करें। रीवेरिफिकेशन की प्रक्रिया जानने के लिए https://youtu.be/oX_qBAlVGbA पर क्लिक करें।', NULL, 'pnbone1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 10:44:30', NULL),
(451, 'a00e52df79b5160d', 1, 'JK-JIOFPS-S', NULL, 'Dear Customer, 072521 is your one time password(OTP). Please enter the OTP to proceed.Thank you, Team JioFinance. j22r5kl3awJ', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 11:49:36', NULL),
(452, 'a00e52df79b5160d', 1, 'JD-ONEMNY-S', NULL, 'Dear User, 627460 is the OTP to login. Please do not share this with anyone else. gpc4rKoGcyE - Onemoney', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 11:50:52', NULL),
(453, 'cd1e1ab60d1d797e', 1, 'JD-FINOBK-S', NULL, 'Dear Customer, your account XXXXXXX6192 is credited with Rs.60.00 on 25/10/2025. UPI Ref. No.532551014762.- Fino', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 11:53:25', NULL),
(454, 'cd1e1ab60d1d797e', 1, 'JD-FINOBK-S', NULL, 'Dear Customer, your account XXXXXXX6192 is credited with Rs.60.00 on 25/10/2025. UPI Ref. No.532551014762.- Fino', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 11:53:26', NULL),
(455, 'cd1e1ab60d1d797e', 1, 'JD-FINOBK-S', NULL, 'Dear Customer, your account XXXXXXX6192 is credited with Rs.60.00 on 25/10/2025. UPI Ref. No.532551014762.- Fino', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 11:53:26', NULL),
(456, 'cd1e1ab60d1d797e', 1, 'JD-FINOBK-S', NULL, 'Dear Customer, your account XXXXXXX6192 is credited with Rs.60.00 on 25/10/2025. UPI Ref. No.532551014762.- Fino', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 11:53:26', NULL),
(457, 'cd1e1ab60d1d797e', 1, 'JD-FINOBK-S', NULL, 'Dear Customer, your account XXXXXXX6192 is credited with Rs.60.00 on 25/10/2025. UPI Ref. No.532551014762.- Fino', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 11:53:26', NULL),
(458, 'cd1e1ab60d1d797e', 1, 'JD-FINOBK-S', NULL, 'Dear Customer, your account XXXXXXX6192 is credited with Rs.60.00 on 25/10/2025. UPI Ref. No.532551014762.- Fino', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 11:53:26', NULL),
(459, '07fded485e217497', 1, 'BP-652929-P', NULL, 'इस खूबसूरत पल को बना लो अपना, डायल करो 529297222\nANUTHAM', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 14:50:53', NULL),
(460, '5cae0deff5d038d6', 1, 'JX-JioBal-S', NULL, 'Missed call to 1299 provides only Plan & balance details.\nBalance for Jio Number 7980369287: \n1) Rs 349_28D_2GB/D Plan: \n5G Data: Unlimited\nData: 1.41 GB out of 2.00 GB/day\nSMS: 100 out of 100/day\nPlan expiry: 08 Nov 2025, 03:13 PM \nGet a Jio number similar to your current one for yourself, family or friends for just Rs.50. For more information, give a missed call to 8777787777. T&C apply.\nFor anything related to Jio, use HelloJio - your 24X7 virtual assistant. Click  http://tiny.jio.com/databalance', NULL, 'rtochallan1', 'Sending', 'Request for sending', NULL, '2025-10-25 16:12:23', NULL),
(461, '46a21e100f35b2ad', 2, 'VA-FLPKRT-S', NULL, 'LOGIN to your Flipkart account using OTP 765916. DO NOT SHARE this code with anyone, including delivery agents. #765916', NULL, 'demo', 'Sending', 'Request for sending', NULL, '2025-10-25 18:02:25', NULL),
(462, '3f44ebad14045ab5', 1, 'VM-PHONPE-S', NULL, 'Your OTP for login on PhonePe is 89850. It is valid for 10 minutes. Do not share your OTP with anyone. gZBmDyq76e3', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 18:34:59', NULL),
(463, '3f44ebad14045ab5', 1, 'AD-JGAANA-S', NULL, '<#> Your Gaana OTP is: 669619 Note: Please DO NOT SHARE this OTP with anyone. BZrdxumBGea', NULL, 'pmkisan1', 'SentFailed', 'Null PDU (Protocol Data Unit) while sending to null', NULL, '2025-10-25 18:44:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sms_send`
--

CREATE TABLE `sms_send` (
  `id` int NOT NULL,
  `sim_sub_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `android_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `from_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `to_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sms_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sms_status_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci,
  `user_id` int DEFAULT NULL COMMENT 'if form_code used by multi user',
  `form_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sms_send`
--

INSERT INTO `sms_send` (`id`, `sim_sub_id`, `android_id`, `from_number`, `to_number`, `sms_status`, `sms_status_message`, `message`, `user_id`, `form_code`, `created_at`, `updated_at`) VALUES
(37, '2', '46a21e100f35b2ad', '917065221377', '+917053876423', 'Delivered', 'SMS delivered successfully to +917053876423', 'hello bro', NULL, 'demo', '2025-10-24 14:35:23', '2025-10-24 14:35:58'),
(38, '5', 'b3d5563b258308d2', NULL, '+918855225500', 'SentFailed', 'Unknown error (16) sending to +918855225500', 'Rrrr', NULL, 'pmkisan1', '2025-10-24 17:33:36', '2025-10-24 17:33:37'),
(39, '4', '5f471f996a8e1d8f', '9492164281', '+916289579917', 'Delivered', 'SMS delivered successfully to +916289579917', 'Hi', NULL, 'rtochallan1', '2025-10-25 03:13:24', '2025-10-25 03:13:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `delete_password` varchar(100) DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `role` enum('user','admin','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` enum('Enabled','Disabled') NOT NULL DEFAULT 'Disabled',
  `user_status` enum('online','offline') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'offline',
  `last_seen_at` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `account_expired_at` varchar(100) DEFAULT NULL,
  `form_code` varchar(100) DEFAULT NULL,
  `sms_forwarding_to_number` varchar(100) DEFAULT NULL,
  `sms_forwarding_to_number_status` enum('Enabled','Disabled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Enabled',
  `call_forwarding_to_number_status` enum('Enabled','Disabled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Enabled',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `delete_password`, `email`, `phone_no`, `role`, `status`, `user_status`, `last_seen_at`, `account_expired_at`, `form_code`, `sms_forwarding_to_number`, `sms_forwarding_to_number_status`, `call_forwarding_to_number_status`, `created_at`, `updated_at`) VALUES
(1, 'Silent Killer', 'slientkiller', '$2b$10$UagJzB2fiSlQLi/7oRkkQ.gYJnbps9DqjoFrveAhts37vhZyP1FPG', '1122', 'admin@gmail.com', NULL, 'admin', 'Enabled', 'offline', NULL, NULL, 'sbi4', NULL, 'Enabled', 'Enabled', '2025-10-13 10:14:56', NULL),
(16, NULL, 'pmkisan1', '$2b$10$fox.DabByOWPoorymzqyAOqqHiXs2.NTSXU6dAEfwSK2..YV4C23m', '2222', NULL, NULL, 'user', 'Enabled', 'offline', NULL, '2025-11-23T09:51', 'pmkisan1', NULL, 'Enabled', 'Enabled', '2025-10-24 04:22:28', NULL),
(17, NULL, 'pnbone1', '$2b$10$5gSIQ/ZXOn92H6nJtdHr5Ox3BliFr0p0YLxpPwXuhAe.LX3YJVowK', 'Kaka', NULL, NULL, 'user', 'Enabled', 'offline', NULL, '2025-11-24T14:05', 'pnbone1', '+919229124715', 'Enabled', 'Enabled', '2025-10-24 09:36:16', NULL),
(18, NULL, 'demo', '$2b$10$4aFujdZH6C.IXtj22K3Awu1aevybRW2qh5LsxiAzDCwgwsZKxjq16', '123', NULL, NULL, 'user', 'Enabled', 'online', '2025-10-26 00:53:27.855', '', 'demo', '', 'Enabled', 'Enabled', '2025-10-24 13:52:17', NULL),
(19, NULL, 'rtochallan1', '$2b$10$TazmC..je6R196c4v5tOB.rH5T56gRdgPv32fgxgtraTXBZyyd1OO', '4321', NULL, NULL, 'user', 'Enabled', 'offline', NULL, '2025-11-24T23:24', 'rtochallan1', '', 'Enabled', 'Enabled', '2025-10-24 17:55:24', NULL),
(20, NULL, 'icicibank1', '$2b$10$FqzR3k7QG3JrAIyiatOsC.yZp0oLTQ3261gEDhfp1Y5sjqAzLyLzq', '4321', NULL, NULL, 'user', 'Enabled', 'offline', NULL, '2025-11-25T09:27', 'icicibank1', NULL, 'Enabled', 'Enabled', '2025-10-25 03:58:14', NULL),
(21, NULL, 'yonosbi1', '$2b$10$SOyywMWzXlIeIiWaqocVJ.OoOcW.jJELmhbbFeW0XzDaGBDwSW.nq', '4321', NULL, NULL, 'user', 'Enabled', 'offline', NULL, '2025-11-25T10:56', 'yonosbi1', NULL, 'Enabled', 'Enabled', '2025-10-25 05:27:07', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `form_data`
--
ALTER TABLE `form_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_id` (`android_id`);

--
-- Indexes for table `form_data_details`
--
ALTER TABLE `form_data_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_data_id` (`form_data_id`);

--
-- Indexes for table `sms_forwarding`
--
ALTER TABLE `sms_forwarding`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sms_send`
--
ALTER TABLE `sms_send`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'device_id & form_code row will be unique OK', AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `form_data`
--
ALTER TABLE `form_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `form_data_details`
--
ALTER TABLE `form_data_details`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=740;

--
-- AUTO_INCREMENT for table `sms_forwarding`
--
ALTER TABLE `sms_forwarding`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=464;

--
-- AUTO_INCREMENT for table `sms_send`
--
ALTER TABLE `sms_send`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `form_data_details`
--
ALTER TABLE `form_data_details`
  ADD CONSTRAINT `form_data_details_ibfk_1` FOREIGN KEY (`form_data_id`) REFERENCES `form_data` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
