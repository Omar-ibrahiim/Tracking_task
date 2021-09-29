-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 29, 2021 at 03:55 PM
-- Server version: 8.0.18
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `track`
--

-- --------------------------------------------------------

--
-- Table structure for table `changing`
--

CREATE TABLE `changing` (
  `doc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `what_changed` text COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `circulate_emp_doc`
--

CREATE TABLE `circulate_emp_doc` (
  `doc_id` int(11) NOT NULL,
  `emp_ssn` int(11) NOT NULL,
  `circ_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `copy`
--

CREATE TABLE `copy` (
  `draft_id` int(11) NOT NULL,
  `copy_num` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE `document` (
  `doc_id` int(11) NOT NULL,
  `doc_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `draft`
--

CREATE TABLE `draft` (
  `doc_id` int(11) NOT NULL,
  `draft_num` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `ssn` int(11) NOT NULL,
  `emp_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `out_sender`
--

CREATE TABLE `out_sender` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recieve`
--

CREATE TABLE `recieve` (
  `doc_id` int(11) NOT NULL,
  `outsend_id` int(11) NOT NULL,
  `receipt_num` int(11) NOT NULL,
  `receipt_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `copy_num` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `changing`
--
ALTER TABLE `changing`
  ADD KEY `document_doc_id_cfk` (`doc_id`),
  ADD KEY `user_user_id` (`user_id`);

--
-- Indexes for table `circulate_emp_doc`
--
ALTER TABLE `circulate_emp_doc`
  ADD KEY `emp_ssn_cfk` (`emp_ssn`),
  ADD KEY `document_doc_cfk` (`doc_id`);

--
-- Indexes for table `copy`
--
ALTER TABLE `copy`
  ADD PRIMARY KEY (`copy_num`),
  ADD KEY `darft_draft_num_fk` (`draft_id`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`doc_id`);

--
-- Indexes for table `draft`
--
ALTER TABLE `draft`
  ADD PRIMARY KEY (`draft_num`),
  ADD KEY `document_doc_id_fk` (`doc_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`ssn`);

--
-- Indexes for table `out_sender`
--
ALTER TABLE `out_sender`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recieve`
--
ALTER TABLE `recieve`
  ADD KEY `document_doc_id_rfk` (`doc_id`),
  ADD KEY `outsender_id_rfk` (`outsend_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `copy_copy_num_fk` (`copy_num`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `copy`
--
ALTER TABLE `copy`
  MODIFY `copy_num` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `draft`
--
ALTER TABLE `draft`
  MODIFY `draft_num` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `ssn` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `out_sender`
--
ALTER TABLE `out_sender`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `changing`
--
ALTER TABLE `changing`
  ADD CONSTRAINT `document_doc_id_cfk` FOREIGN KEY (`doc_id`) REFERENCES `document` (`doc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `circulate_emp_doc`
--
ALTER TABLE `circulate_emp_doc`
  ADD CONSTRAINT `document_doc_cfk` FOREIGN KEY (`doc_id`) REFERENCES `document` (`doc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `emp_ssn_cfk` FOREIGN KEY (`emp_ssn`) REFERENCES `employee` (`ssn`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `copy`
--
ALTER TABLE `copy`
  ADD CONSTRAINT `darft_draft_num_fk` FOREIGN KEY (`draft_id`) REFERENCES `draft` (`draft_num`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `draft`
--
ALTER TABLE `draft`
  ADD CONSTRAINT `document_doc_id_fk` FOREIGN KEY (`doc_id`) REFERENCES `document` (`doc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `recieve`
--
ALTER TABLE `recieve`
  ADD CONSTRAINT `document_doc_id_rfk` FOREIGN KEY (`doc_id`) REFERENCES `document` (`doc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `outsender_id_rfk` FOREIGN KEY (`outsend_id`) REFERENCES `out_sender` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `copy_copy_num_fk` FOREIGN KEY (`copy_num`) REFERENCES `copy` (`copy_num`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
