-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.3.12-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for sec_officer
DROP DATABASE IF EXISTS `sec_officer`;
CREATE DATABASE IF NOT EXISTS `sec_officer` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `sec_officer`;

-- Dumping structure for table sec_officer.casbin_rule
DROP TABLE IF EXISTS `casbin_rule`;
CREATE TABLE IF NOT EXISTS `casbin_rule` (
  `p_type` varchar(100) DEFAULT NULL,
  `v0` varchar(100) DEFAULT NULL,
  `v1` varchar(100) DEFAULT NULL,
  `v2` varchar(100) DEFAULT NULL,
  `v3` varchar(100) DEFAULT NULL,
  `v4` varchar(100) DEFAULT NULL,
  `v5` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table sec_officer.casbin_rule: ~8 rows (approximately)
DELETE FROM `casbin_rule`;
/*!40000 ALTER TABLE `casbin_rule` DISABLE KEYS */;
INSERT INTO `casbin_rule` (`p_type`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES
	('p', '1', '/api/v1/me/', 'GET', NULL, NULL, NULL),
	('p', '1', '/api/v1/users/*', '	(GET)|(POST)|(PUT)|(DELETE)', NULL, NULL, NULL),
	('p', '1', '/api/v1/courts/', 'GET', NULL, NULL, NULL),
	('p', '2', '/api/v1/me/', 'GET', NULL, NULL, NULL),
	('p', '1', '/api/v1/sec_persons/*', '	(GET)|(POST)|(PUT)|(DELETE)', NULL, NULL, NULL),
	('p', '2', '/api/v1/court_reports/*', '	(GET)|(POST)|(PUT)|(DELETE)|(PATCH)', NULL, NULL, NULL),
	('p', '2', '/api/v1/sec_persons/*', '	(GET)|(POST)|(PUT)|(DELETE)', NULL, NULL, NULL),
	('p', '1', '/api/v1/admin_reports/*', 'GET', NULL, NULL, NULL);
/*!40000 ALTER TABLE `casbin_rule` ENABLE KEYS */;

-- Dumping structure for table sec_officer.courts
DROP TABLE IF EXISTS `courts`;
CREATE TABLE IF NOT EXISTS `courts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `court_code` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_uid` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `c_updated_uid` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `court_code` (`court_code`)
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8;

-- Dumping data for table sec_officer.courts: ~301 rows (approximately)
DELETE FROM `courts`;
/*!40000 ALTER TABLE `courts` DISABLE KEYS */;
INSERT INTO `courts` (`id`, `court_code`, `name`, `created_uid`, `created_at`, `c_updated_uid`, `updated_at`, `deleted_at`, `updated_uid`) VALUES
	(1, '0000001', 'สำนักคณะกรรมการบริหารศาลยุติธรรม', NULL, NULL, NULL, NULL, NULL, NULL),
	(2, '0000002', 'สำนักคณะกรรมการตุลาการศาลยุติธรรม', NULL, NULL, NULL, NULL, NULL, NULL),
	(3, '0000003', 'สำนักคณะกรรมการข้าราชการศาลยุติธรรม', NULL, NULL, NULL, NULL, NULL, NULL),
	(4, '0000004', 'สำนักบริหารกลาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(5, '0000005', 'สำนักการต่างประเทศ', NULL, NULL, NULL, NULL, NULL, NULL),
	(6, '0000006', 'ศูนย์วิทยบริการศาลยุติธรรม', NULL, NULL, NULL, NULL, NULL, NULL),
	(7, '0000007', 'กองสารนิเทศและประชาสัมพันธ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(8, '0000008', 'สำนักบริหารงานออกแบบและก่อสร้าง', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, '0000009', 'สถาบันพัฒนาข้าราชการฝ่ายตุลาการศาลยุติธรรม', NULL, NULL, NULL, NULL, NULL, NULL),
	(10, '0000010', 'สำนักการคลัง', NULL, NULL, NULL, NULL, NULL, NULL),
	(11, '0000011', 'สำนักเทคโนโลยีสารสนเทศ', NULL, NULL, NULL, NULL, NULL, NULL),
	(12, '0000012', 'สำนักแผนงานและงบประมาณ', NULL, NULL, NULL, NULL, NULL, NULL),
	(13, '0000013', 'สำนักกฎหมายและวิชาการศาลยุติธรรม', NULL, NULL, NULL, NULL, NULL, NULL),
	(14, '0000014', 'สำนักตรวจสอบภายใน', NULL, NULL, NULL, NULL, NULL, NULL),
	(15, '0000015', 'หน่วยตรวจราชการ', NULL, NULL, NULL, NULL, NULL, NULL),
	(16, '0000016', 'สถาบันวิจัยและพัฒนารพีพัฒนศักดิ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(17, '0000017', 'สำนักบริหารทรัพย์สิน', NULL, NULL, NULL, NULL, NULL, NULL),
	(18, '0000018', 'กองสวัสดิการศาลยุติธรรม', NULL, NULL, NULL, NULL, NULL, NULL),
	(19, '0000019', 'สำนักรักษาความปลอดภัยและสถานที่', NULL, NULL, NULL, NULL, NULL, NULL),
	(20, '0000020', 'สำนักการเจ้าหน้าที่', NULL, NULL, NULL, NULL, NULL, NULL),
	(21, '0000021', 'สำนักกิจการคดี', NULL, NULL, NULL, NULL, NULL, NULL),
	(22, '0000022', 'สำนักส่งเสริมงานตุลาการ', NULL, NULL, NULL, NULL, NULL, NULL),
	(23, '0000023', 'สำนักอนุญาโตตุลาการ', NULL, NULL, NULL, NULL, NULL, NULL),
	(24, '0000024', 'สำนักงานเลขานุการคณะกรรมการวินิจฉัยชี้ขาดอำนาจหน้าที่ระหว่างศาล', NULL, NULL, NULL, NULL, NULL, NULL),
	(25, '0000101', 'สำนักศาลยุติธรรมประจำภาค 1', NULL, NULL, NULL, NULL, NULL, NULL),
	(26, '0000201', 'สำนักศาลยุติธรรมประจำภาค 2', NULL, NULL, NULL, NULL, NULL, NULL),
	(27, '0000301', 'สำนักศาลยุติธรรมประจำภาค 3', NULL, NULL, NULL, NULL, NULL, NULL),
	(28, '0000401', 'สำนักศาลยุติธรรมประจำภาค 4', NULL, NULL, NULL, NULL, NULL, NULL),
	(29, '0000501', 'สำนักศาลยุติธรรมประจำภาค 5', NULL, NULL, NULL, NULL, NULL, NULL),
	(30, '0000601', 'สำนักศาลยุติธรรมประจำภาค 6', NULL, NULL, NULL, NULL, NULL, NULL),
	(31, '0000701', 'สำนักศาลยุติธรรมประจำภาค 7', NULL, NULL, NULL, NULL, NULL, NULL),
	(32, '0000801', 'สำนักศาลยุติธรรมประจำภาค 8', NULL, NULL, NULL, NULL, NULL, NULL),
	(33, '0000901', 'สำนักศาลยุติธรรมประจำภาค 9', NULL, NULL, NULL, NULL, NULL, NULL),
	(34, '2000101', 'ศาลอุทธรณ์ภาค 1', NULL, NULL, NULL, NULL, NULL, NULL),
	(35, '2000201', 'ศาลอุทธรณ์ภาค 2', NULL, NULL, NULL, NULL, NULL, NULL),
	(36, '2000301', 'ศาลอุทธรณ์ภาค 3', NULL, NULL, NULL, NULL, NULL, NULL),
	(37, '2000401', 'ศาลอุทธรณ์ภาค 4', NULL, NULL, NULL, NULL, NULL, NULL),
	(38, '2000501', 'ศาลอุทธรณ์ภาค 5', NULL, NULL, NULL, NULL, NULL, NULL),
	(39, '2000601', 'ศาลอุทธรณ์ภาค 6', NULL, NULL, NULL, NULL, NULL, NULL),
	(40, '2000701', 'ศาลอุทธรณ์ภาค 7', NULL, NULL, NULL, NULL, NULL, NULL),
	(41, '2000801', 'ศาลอุทธรณ์ภาค 8', NULL, NULL, NULL, NULL, NULL, NULL),
	(42, '2000901', 'ศาลอุทธรณ์ภาค 9', NULL, NULL, NULL, NULL, NULL, NULL),
	(43, '2000002', 'ศาลอุทธรณ์คดีชำนัญพิเศษ', NULL, NULL, NULL, NULL, NULL, NULL),
	(44, '3010001', 'ศาลแพ่ง', NULL, NULL, NULL, NULL, NULL, NULL),
	(45, '3010002', 'ศาลแพ่งกรุงเทพใต้', NULL, NULL, NULL, NULL, NULL, NULL),
	(46, '3010003', 'ศาลแพ่งธนบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(47, '3020001', 'ศาลอาญา', NULL, NULL, NULL, NULL, NULL, NULL),
	(48, '3020002', 'ศาลอาญากรุงเทพใต้', NULL, NULL, NULL, NULL, NULL, NULL),
	(49, '3020003', 'ศาลอาญาธนบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(50, '3020004', 'ศาลอาญาคดีทุจริตและประพฤติมิชอบกลาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(51, '3020101', 'ศาลอาญาคดีทุจริตและประพฤติมิชอบภาค 1', NULL, NULL, NULL, NULL, NULL, NULL),
	(52, '3020201', 'ศาลอาญาคดีทุจริตและประพฤติมิชอบภาค 2', NULL, NULL, NULL, NULL, NULL, NULL),
	(53, '3020301', 'ศาลอาญาคดีทุจริตและประพฤติมิชอบภาค 3', NULL, NULL, NULL, NULL, NULL, NULL),
	(54, '3020401', 'ศาลอาญาคดีทุจริตและประพฤติมิชอบภาค 4', NULL, NULL, NULL, NULL, NULL, NULL),
	(55, '3020501', 'ศาลอาญาคดีทุจริตและประพฤติมิชอบภาค 5', NULL, NULL, NULL, NULL, NULL, NULL),
	(56, '3020601', 'ศาลอาญาคดีทุจริตและประพฤติมิชอบภาค 6', NULL, NULL, NULL, NULL, NULL, NULL),
	(57, '3020701', 'ศาลอาญาคดีทุจริตและประพฤติมิชอบภาค 7', NULL, NULL, NULL, NULL, NULL, NULL),
	(58, '3020801', 'ศาลอาญาคดีทุจริตและประพฤติมิชอบภาค 8', NULL, NULL, NULL, NULL, NULL, NULL),
	(59, '3020901', 'ศาลอาญาคดีทุจริตและประพฤติมิชอบภาค 9', NULL, NULL, NULL, NULL, NULL, NULL),
	(60, '3030001', 'ศาลแรงงานกลาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(61, '3030101', 'ศาลแรงงานภาค 1', NULL, NULL, NULL, NULL, NULL, NULL),
	(62, '3030201', 'ศาลแรงงานภาค 2', NULL, NULL, NULL, NULL, NULL, NULL),
	(63, '3030301', 'ศาลแรงงานภาค 3', NULL, NULL, NULL, NULL, NULL, NULL),
	(64, '3030401', 'ศาลแรงงานภาค 4', NULL, NULL, NULL, NULL, NULL, NULL),
	(65, '3030501', 'ศาลแรงงานภาค 5', NULL, NULL, NULL, NULL, NULL, NULL),
	(66, '3030601', 'ศาลแรงงานภาค 6', NULL, NULL, NULL, NULL, NULL, NULL),
	(67, '3030701', 'ศาลแรงงานภาค 7', NULL, NULL, NULL, NULL, NULL, NULL),
	(68, '3030801', 'ศาลแรงงานภาค 8', NULL, NULL, NULL, NULL, NULL, NULL),
	(69, '3030901', 'ศาลแรงงานภาค 9', NULL, NULL, NULL, NULL, NULL, NULL),
	(70, '3040001', 'ศาลภาษีอากรกลาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(71, '3050001', 'ศาลทรัพย์สินทางปัญญาและการค้าระหว่างประเทศกลาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(72, '3060001', 'ศาลล้มละลายกลาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(73, '3070101', 'ศาลจังหวัดตลิ่งชัน', NULL, NULL, NULL, NULL, NULL, NULL),
	(74, '3070102', 'ศาลจังหวัดพระโขนง', NULL, NULL, NULL, NULL, NULL, NULL),
	(75, '3070103', 'ศาลจังหวัดมีนบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(76, '3070104', 'ศาลจังหวัดสมุทรปราการ', NULL, NULL, NULL, NULL, NULL, NULL),
	(77, '3070105', 'ศาลจังหวัดนนทบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(78, '3070106', 'ศาลจังหวัดปทุมธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(79, '3070107', 'ศาลจังหวัดธัญบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(80, '3070108', 'ศาลจังหวัดพระนครศรีอยุธยา', NULL, NULL, NULL, NULL, NULL, NULL),
	(81, '3070109', 'ศาลจังหวัดอ่างทอง', NULL, NULL, NULL, NULL, NULL, NULL),
	(82, '3070110', 'ศาลจังหวัดลพบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(83, '3070111', 'ศาลจังหวัดสิงห์บุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(84, '3070112', 'ศาลจังหวัดชัยนาท', NULL, NULL, NULL, NULL, NULL, NULL),
	(85, '3070113', 'ศาลจังหวัดชัยบาดาล', NULL, NULL, NULL, NULL, NULL, NULL),
	(86, '3070114', 'ศาลจังหวัดสระบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(87, '3070201', 'ศาลจังหวัดชลบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(88, '3070202', 'ศาลจังหวัดพัทยา', NULL, NULL, NULL, NULL, NULL, NULL),
	(89, '3070203', 'ศาลจังหวัดระยอง', NULL, NULL, NULL, NULL, NULL, NULL),
	(90, '3070204', 'ศาลจังหวัดจันทบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(91, '3070205', 'ศาลจังหวัดตราด', NULL, NULL, NULL, NULL, NULL, NULL),
	(92, '3070206', 'ศาลจังหวัดฉะเชิงเทรา', NULL, NULL, NULL, NULL, NULL, NULL),
	(93, '3070207', 'ศาลจังหวัดปราจีนบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(94, '3070208', 'ศาลจังหวัดกบินทร์บุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(95, '3070209', 'ศาลจังหวัดนครนายก', NULL, NULL, NULL, NULL, NULL, NULL),
	(96, '3070210', 'ศาลจังหวัดสระแก้ว', NULL, NULL, NULL, NULL, NULL, NULL),
	(97, '3070301', 'ศาลจังหวัดนครราชสีมา', NULL, NULL, NULL, NULL, NULL, NULL),
	(98, '3070302', 'ศาลจังหวัดบัวใหญ่', NULL, NULL, NULL, NULL, NULL, NULL),
	(99, '3070303', 'ศาลจังหวัดสีคิ้ว', NULL, NULL, NULL, NULL, NULL, NULL),
	(100, '3070304', 'ศาลจังหวัดสีคิ้ว (ปากช่อง)', NULL, NULL, NULL, NULL, NULL, NULL),
	(101, '3070305', 'ศาลจังหวัดบุรีรัมย์', NULL, NULL, NULL, NULL, NULL, NULL),
	(102, '3070306', 'ศาลจังหวัดนางรอง', NULL, NULL, NULL, NULL, NULL, NULL),
	(103, '3070307', 'ศาลจังหวัดสุรินทร์', NULL, NULL, NULL, NULL, NULL, NULL),
	(104, '3070308', 'ศาลจังหวัดรัตนบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(105, '3070309', 'ศาลจังหวัดศรีสะเกษ', NULL, NULL, NULL, NULL, NULL, NULL),
	(106, '3070318', 'ศาลจังหวัดกันทรลักษ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(107, '3070311', 'ศาลจังหวัดอุบลราชธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(108, '3070312', 'ศาลจังหวัดเดชอุดม', NULL, NULL, NULL, NULL, NULL, NULL),
	(109, '3070313', 'ศาลจังหวัดยโสธร', NULL, NULL, NULL, NULL, NULL, NULL),
	(110, '3070314', 'ศาลจังหวัดชัยภูมิ', NULL, NULL, NULL, NULL, NULL, NULL),
	(111, '3070315', 'ศาลจังหวัดภูเขียว', NULL, NULL, NULL, NULL, NULL, NULL),
	(112, '3070316', 'ศาลจังหวัดอำนาจเจริญ', NULL, NULL, NULL, NULL, NULL, NULL),
	(113, '3070317', 'ศาลจังหวัดพิมาย', NULL, NULL, NULL, NULL, NULL, NULL),
	(114, '3070401', 'ศาลจังหวัดบึงกาฬ', NULL, NULL, NULL, NULL, NULL, NULL),
	(115, '3070402', 'ศาลจังหวัดหนองบัวลำภู', NULL, NULL, NULL, NULL, NULL, NULL),
	(116, '3070403', 'ศาลจังหวัดขอนแก่น', NULL, NULL, NULL, NULL, NULL, NULL),
	(117, '3070404', 'ศาลจังหวัดพล', NULL, NULL, NULL, NULL, NULL, NULL),
	(118, '3070405', 'ศาลจังหวัดอุดรธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(119, '3070406', 'ศาลจังหวัดเลย', NULL, NULL, NULL, NULL, NULL, NULL),
	(120, '3070407', 'ศาลจังหวัดหนองคาย', NULL, NULL, NULL, NULL, NULL, NULL),
	(121, '3070408', 'ศาลจังหวัดมหาสารคาม', NULL, NULL, NULL, NULL, NULL, NULL),
	(122, '3070409', 'ศาลจังหวัดร้อยเอ็ด', NULL, NULL, NULL, NULL, NULL, NULL),
	(123, '3070410', 'ศาลจังหวัดกาฬสินธุ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(124, '3070411', 'ศาลจังหวัดสกลนคร', NULL, NULL, NULL, NULL, NULL, NULL),
	(125, '3070412', 'ศาลจังหวัดสว่างแดนดิน', NULL, NULL, NULL, NULL, NULL, NULL),
	(126, '3070413', 'ศาลจังหวัดนครพนม', NULL, NULL, NULL, NULL, NULL, NULL),
	(127, '3070414', 'ศาลจังหวัดมุกดาหาร', NULL, NULL, NULL, NULL, NULL, NULL),
	(128, '3070415', 'ศาลจังหวัดชุมแพ', NULL, NULL, NULL, NULL, NULL, NULL),
	(129, '3070501', 'ศาลจังหวัดเชียงใหม่', NULL, NULL, NULL, NULL, NULL, NULL),
	(130, '3070502', 'ศาลจังหวัดฝาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(131, '3070503', 'ศาลจังหวัดลำพูน', NULL, NULL, NULL, NULL, NULL, NULL),
	(132, '3070504', 'ศาลจังหวัดลำปาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(133, '3070505', 'ศาลจังหวัดแพร่', NULL, NULL, NULL, NULL, NULL, NULL),
	(134, '3070506', 'ศาลจังหวัดน่าน', NULL, NULL, NULL, NULL, NULL, NULL),
	(135, '3070508', 'ศาลจังหวัดพะเยา', NULL, NULL, NULL, NULL, NULL, NULL),
	(136, '3070509', 'ศาลจังหวัดเชียงราย', NULL, NULL, NULL, NULL, NULL, NULL),
	(137, '3070510', 'ศาลจังหวัดเทิง', NULL, NULL, NULL, NULL, NULL, NULL),
	(138, '3070511', 'ศาลจังหวัดแม่ฮ่องสอน', NULL, NULL, NULL, NULL, NULL, NULL),
	(139, '3070513', 'ศาลจังหวัดแม่สะเรียง', NULL, NULL, NULL, NULL, NULL, NULL),
	(140, '3070514', 'ศาลจังหวัดฮอด', NULL, NULL, NULL, NULL, NULL, NULL),
	(141, '3070515', 'ศาลจังหวัดเชียงคำ', NULL, NULL, NULL, NULL, NULL, NULL),
	(142, '3070601', 'ศาลจังหวัดอุตรดิตถ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(143, '3070602', 'ศาลจังหวัดนครสวรรค์', NULL, NULL, NULL, NULL, NULL, NULL),
	(144, '3070603', 'ศาลจังหวัดอุทัยธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(145, '3070604', 'ศาลจังหวัดกำแพงเพชร', NULL, NULL, NULL, NULL, NULL, NULL),
	(146, '3070605', 'ศาลจังหวัดตาก', NULL, NULL, NULL, NULL, NULL, NULL),
	(147, '3070606', 'ศาลจังหวัดแม่สอด', NULL, NULL, NULL, NULL, NULL, NULL),
	(148, '3070607', 'ศาลจังหวัดสุโขทัย', NULL, NULL, NULL, NULL, NULL, NULL),
	(149, '3070608', 'ศาลจังหวัดสวรรคโลก', NULL, NULL, NULL, NULL, NULL, NULL),
	(150, '3070609', 'ศาลจังหวัดพิษณุโลก', NULL, NULL, NULL, NULL, NULL, NULL),
	(151, '3070610', 'ศาลจังหวัดพิจิตร', NULL, NULL, NULL, NULL, NULL, NULL),
	(152, '3070611', 'ศาลจังหวัดเพชรบูรณ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(153, '3070612', 'ศาลจังหวัดหล่มสัก', NULL, NULL, NULL, NULL, NULL, NULL),
	(154, '3070613', 'ศาลจังหวัดวิเชียรบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(155, '3070701', 'ศาลจังหวัดราชบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(156, '3070702', 'ศาลจังหวัดกาญจนบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(157, '3070703', 'ศาลจังหวัดทองผาภูมิ', NULL, NULL, NULL, NULL, NULL, NULL),
	(158, '3070704', 'ศาลจังหวัดสุพรรณบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(159, '3070705', 'ศาลจังหวัดนครปฐม', NULL, NULL, NULL, NULL, NULL, NULL),
	(160, '3070706', 'ศาลจังหวัดสมุทรสาคร', NULL, NULL, NULL, NULL, NULL, NULL),
	(161, '3070707', 'ศาลจังหวัดสมุทรสงคราม', NULL, NULL, NULL, NULL, NULL, NULL),
	(162, '3070708', 'ศาลจังหวัดเพชรบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(163, '3070709', 'ศาลจังหวัดประจวบคีรีขันธ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(164, '3070710', 'ศาลจังหวัดหัวหิน', NULL, NULL, NULL, NULL, NULL, NULL),
	(165, '3070801', 'ศาลจังหวัดนครศรีธรรมราช', NULL, NULL, NULL, NULL, NULL, NULL),
	(166, '3070802', 'ศาลจังหวัดทุ่งสง', NULL, NULL, NULL, NULL, NULL, NULL),
	(167, '3070803', 'ศาลจังหวัดปากพนัง', NULL, NULL, NULL, NULL, NULL, NULL),
	(168, '3070804', 'ศาลจังหวัดกระบี่', NULL, NULL, NULL, NULL, NULL, NULL),
	(169, '3070805', 'ศาลจังหวัดพังงา', NULL, NULL, NULL, NULL, NULL, NULL),
	(170, '3070806', 'ศาลจังหวัดตะกั่วป่า', NULL, NULL, NULL, NULL, NULL, NULL),
	(171, '3070807', 'ศาลจังหวัดภูเก็ต', NULL, NULL, NULL, NULL, NULL, NULL),
	(172, '3070808', 'ศาลจังหวัดสุราษฎร์ธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(173, '3070809', 'ศาลจังหวัดเกาะสมุย', NULL, NULL, NULL, NULL, NULL, NULL),
	(174, '3070810', 'ศาลจังหวัดไชยา', NULL, NULL, NULL, NULL, NULL, NULL),
	(175, '3070811', 'ศาลจังหวัดเวียงสระ', NULL, NULL, NULL, NULL, NULL, NULL),
	(176, '3070812', 'ศาลจังหวัดระนอง', NULL, NULL, NULL, NULL, NULL, NULL),
	(177, '3070813', 'ศาลจังหวัดชุมพร', NULL, NULL, NULL, NULL, NULL, NULL),
	(178, '3070814', 'ศาลจังหวัดหลังสวน', NULL, NULL, NULL, NULL, NULL, NULL),
	(179, '3070901', 'ศาลจังหวัดสงขลา', NULL, NULL, NULL, NULL, NULL, NULL),
	(180, '3070902', 'ศาลจังหวัดนาทวี', NULL, NULL, NULL, NULL, NULL, NULL),
	(181, '3070903', 'ศาลจังหวัดสตูล', NULL, NULL, NULL, NULL, NULL, NULL),
	(182, '3070904', 'ศาลจังหวัดตรัง', NULL, NULL, NULL, NULL, NULL, NULL),
	(183, '3070905', 'ศาลจังหวัดพัทลุง', NULL, NULL, NULL, NULL, NULL, NULL),
	(184, '3070906', 'ศาลจังหวัดปัตตานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(185, '3070907', 'ศาลจังหวัดยะลา', NULL, NULL, NULL, NULL, NULL, NULL),
	(186, '3070908', 'ศาลจังหวัดเบตง', NULL, NULL, NULL, NULL, NULL, NULL),
	(187, '3070909', 'ศาลจังหวัดนราธิวาส', NULL, NULL, NULL, NULL, NULL, NULL),
	(188, '3080101', 'ศาลแขวงดุสิต', NULL, NULL, NULL, NULL, NULL, NULL),
	(189, '3080102', 'ศาลแขวงธนบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(190, '3080103', 'ศาลแขวงปทุมวัน', NULL, NULL, NULL, NULL, NULL, NULL),
	(191, '3080104', 'ศาลแขวงพระนครใต้', NULL, NULL, NULL, NULL, NULL, NULL),
	(192, '3080105', 'ศาลแขวงพระนครเหนือ', NULL, NULL, NULL, NULL, NULL, NULL),
	(193, '3080106', 'ศาลแขวงสมุทรปราการ', NULL, NULL, NULL, NULL, NULL, NULL),
	(194, '3080107', 'ศาลแขวงนนทบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(195, '3080108', 'ศาลแขวงพระนครศรีอยุธยา', NULL, NULL, NULL, NULL, NULL, NULL),
	(196, '3080109', 'ศาลแขวงลพบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(197, '3080110', 'ศาลแขวงดอนเมือง', NULL, NULL, NULL, NULL, NULL, NULL),
	(198, '3080111', 'ศาลแขวงสระบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(199, '3080201', 'ศาลแขวงชลบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(200, '3080202', 'ศาลแขวงพัทยา', NULL, NULL, NULL, NULL, NULL, NULL),
	(201, '3080301', 'ศาลแขวงนครราชสีมา', NULL, NULL, NULL, NULL, NULL, NULL),
	(202, '3080303', 'ศาลแขวงสุรินทร์', NULL, NULL, NULL, NULL, NULL, NULL),
	(203, '3080304', 'ศาลแขวงอุบลราชธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(204, '3080401', 'ศาลแขวงขอนแก่น', NULL, NULL, NULL, NULL, NULL, NULL),
	(205, '3080402', 'ศาลแขวงอุดรธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(206, '3080403', 'ศาลแขวงพยัคฆภูมิพิสัย', NULL, NULL, NULL, NULL, NULL, NULL),
	(207, '3080501', 'ศาลแขวงเชียงใหม่', NULL, NULL, NULL, NULL, NULL, NULL),
	(208, '3080502', 'ศาลแขวงลำปาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(209, '3080503', 'ศาลแขวงเวียงป่าเป้า', NULL, NULL, NULL, NULL, NULL, NULL),
	(210, '3080601', 'ศาลแขวงนครสวรรค์', NULL, NULL, NULL, NULL, NULL, NULL),
	(211, '3080602', 'ศาลแขวงพิษณุโลก', NULL, NULL, NULL, NULL, NULL, NULL),
	(212, '3080603', 'ศาลแขวงนครไทย', NULL, NULL, NULL, NULL, NULL, NULL),
	(213, '3080701', 'ศาลแขวงราชบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(214, '3080702', 'ศาลแขวงสุพรรณบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(215, '3080703', 'ศาลแขวงนครปฐม', NULL, NULL, NULL, NULL, NULL, NULL),
	(216, '3080801', 'ศาลแขวงนครศรีธรรมราช', NULL, NULL, NULL, NULL, NULL, NULL),
	(217, '3080802', 'ศาลแขวงสุราษฎร์ธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(218, '3080803', 'ศาลแขวงทุ่งสง', NULL, NULL, NULL, NULL, NULL, NULL),
	(219, '3080901', 'ศาลแขวงสงขลา', NULL, NULL, NULL, NULL, NULL, NULL),
	(220, '3090001', 'ศาลเยาวชนและครอบครัวกลาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(221, '3090002', 'ศาลเยาวชนและครอบครัวกลาง (สาขามีนบุรี)', NULL, NULL, NULL, NULL, NULL, NULL),
	(222, '3090101', 'ศาลเยาวชนและครอบครัวจังหวัดสมุทรปราการ', NULL, NULL, NULL, NULL, NULL, NULL),
	(223, '3090102', 'ศาลเยาวชนและครอบครัวจังหวัดนนทบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(224, '3090103', 'ศาลเยาวชนและครอบครัวจังหวัดปทุมธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(225, '3090104', 'ศาลเยาวชนและครอบครัวจังหวัดพระนครศรีอยุธยา', NULL, NULL, NULL, NULL, NULL, NULL),
	(226, '3090105', 'ศาลเยาวชนและครอบครัวจังหวัดอ่างทอง', NULL, NULL, NULL, NULL, NULL, NULL),
	(227, '3090106', 'ศาลเยาวชนและครอบครัวจังหวัดลพบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(228, '3090107', 'ศาลเยาวชนและครอบครัวจังหวัดสิงห์บุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(229, '3090108', 'ศาลเยาวชนและครอบครัวจังหวัดชัยนาท', NULL, NULL, NULL, NULL, NULL, NULL),
	(230, '3090109', 'ศาลเยาวชนและครอบครัวจังหวัดสระบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(231, '3090201', 'ศาลเยาวชนและครอบครัวจังหวัดชลบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(232, '3090202', 'ศาลเยาวชนและครอบครัวจังหวัดระยอง', NULL, NULL, NULL, NULL, NULL, NULL),
	(233, '3090203', 'ศาลเยาวชนและครอบครัวจังหวัดจันทบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(234, '3090204', 'ศาลเยาวชนและครอบครัวจังหวัดตราด', NULL, NULL, NULL, NULL, NULL, NULL),
	(235, '3090205', 'ศาลเยาวชนและครอบครัวจังหวัดฉะเชิงเทรา', NULL, NULL, NULL, NULL, NULL, NULL),
	(236, '3090206', 'ศาลเยาวชนและครอบครัวจังหวัดปราจีนบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(237, '3090207', 'ศาลเยาวชนและครอบครัวจังหวัดนครนายก', NULL, NULL, NULL, NULL, NULL, NULL),
	(238, '3090208', 'ศาลเยาวชนและครอบครัวจังหวัดสระแก้ว', NULL, NULL, NULL, NULL, NULL, NULL),
	(239, '3090301', 'ศาลเยาวชนและครอบครัวจังหวัดนครราชสีมา', NULL, NULL, NULL, NULL, NULL, NULL),
	(240, '3090302', 'ศาลเยาวชนและครอบครัวจังหวัดบุรีรัมย์', NULL, NULL, NULL, NULL, NULL, NULL),
	(241, '3090303', 'ศาลเยาวชนและครอบครัวจังหวัดสุรินทร์', NULL, NULL, NULL, NULL, NULL, NULL),
	(242, '3090304', 'ศาลเยาวชนและครอบครัวจังหวัดศรีสะเกษ', NULL, NULL, NULL, NULL, NULL, NULL),
	(243, '3090305', 'ศาลเยาวชนและครอบครัวจังหวัดอุบลราชธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(244, '3090306', 'ศาลเยาวชนและครอบครัวจังหวัดยโสธร', NULL, NULL, NULL, NULL, NULL, NULL),
	(245, '3090307', 'ศาลเยาวชนและครอบครัวจังหวัดชัยภูมิ', NULL, NULL, NULL, NULL, NULL, NULL),
	(246, '3090308', 'ศาลเยาวชนและครอบครัวจังหวัดอำนาจเจริญ', NULL, NULL, NULL, NULL, NULL, NULL),
	(247, '3090401', 'ศาลเยาวชนและครอบครัวจังหวัดบึงกาฬ', NULL, NULL, NULL, NULL, NULL, NULL),
	(248, '3090402', 'ศาลเยาวชนและครอบครัวจังหวัดหนองบัวลำภู', NULL, NULL, NULL, NULL, NULL, NULL),
	(249, '3090403', 'ศาลเยาวชนและครอบครัวจังหวัดขอนแก่น', NULL, NULL, NULL, NULL, NULL, NULL),
	(250, '3090404', 'ศาลเยาวชนและครอบครัวจังหวัดอุดรธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(251, '3090405', 'ศาลเยาวชนและครอบครัวจังหวัดเลย', NULL, NULL, NULL, NULL, NULL, NULL),
	(252, '3090406', 'ศาลเยาวชนและครอบครัวจังหวัดหนองคาย', NULL, NULL, NULL, NULL, NULL, NULL),
	(253, '3090407', 'ศาลเยาวชนและครอบครัวจังหวัดมหาสารคาม', NULL, NULL, NULL, NULL, NULL, NULL),
	(254, '3090408', 'ศาลเยาวชนและครอบครัวจังหวัดร้อยเอ็ด', NULL, NULL, NULL, NULL, NULL, NULL),
	(255, '3090409', 'ศาลเยาวชนและครอบครัวจังหวัดกาฬสินธุ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(256, '3090410', 'ศาลเยาวชนและครอบครัวจังหวัดสกลนคร', NULL, NULL, NULL, NULL, NULL, NULL),
	(257, '3090411', 'ศาลเยาวชนและครอบครัวจังหวัดนครพนม', NULL, NULL, NULL, NULL, NULL, NULL),
	(258, '3090412', 'ศาลเยาวชนและครอบครัวจังหวัดมุกดาหาร', NULL, NULL, NULL, NULL, NULL, NULL),
	(259, '3090501', 'ศาลเยาวชนและครอบครัวจังหวัดเชียงใหม่', NULL, NULL, NULL, NULL, NULL, NULL),
	(260, '3090502', 'ศาลเยาวชนและครอบครัวจังหวัดลำพูน', NULL, NULL, NULL, NULL, NULL, NULL),
	(261, '3090503', 'ศาลเยาวชนและครอบครัวจังหวัดลำปาง', NULL, NULL, NULL, NULL, NULL, NULL),
	(262, '3090504', 'ศาลเยาวชนและครอบครัวจังหวัดแพร่', NULL, NULL, NULL, NULL, NULL, NULL),
	(263, '3090505', 'ศาลเยาวชนและครอบครัวจังหวัดน่าน', NULL, NULL, NULL, NULL, NULL, NULL),
	(264, '3090506', 'ศาลเยาวชนและครอบครัวจังหวัดพะเยา', NULL, NULL, NULL, NULL, NULL, NULL),
	(265, '3090507', 'ศาลเยาวชนและครอบครัวจังหวัดเชียงราย', NULL, NULL, NULL, NULL, NULL, NULL),
	(266, '3090508', 'ศาลเยาวชนและครอบครัวจังหวัดแม่ฮ่องสอน', NULL, NULL, NULL, NULL, NULL, NULL),
	(267, '3090601', 'ศาลเยาวชนและครอบครัวจังหวัดอุตรดิตถ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(268, '3090602', 'ศาลเยาวชนและครอบครัวจังหวัดนครสวรรค์', NULL, NULL, NULL, NULL, NULL, NULL),
	(269, '3090603', 'ศาลเยาวชนและครอบครัวจังหวัดอุทัยธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(270, '3090604', 'ศาลเยาวชนและครอบครัวจังหวัดกำแพงเพชร', NULL, NULL, NULL, NULL, NULL, NULL),
	(271, '3090605', 'ศาลเยาวชนและครอบครัวจังหวัดตาก', NULL, NULL, NULL, NULL, NULL, NULL),
	(272, '3090606', 'ศาลเยาวชนและครอบครัวจังหวัดสุโขทัย', NULL, NULL, NULL, NULL, NULL, NULL),
	(273, '3090607', 'ศาลเยาวชนและครอบครัวจังหวัดพิษณุโลก', NULL, NULL, NULL, NULL, NULL, NULL),
	(274, '3090608', 'ศาลเยาวชนและครอบครัวจังหวัดพิจิตร', NULL, NULL, NULL, NULL, NULL, NULL),
	(275, '3090609', 'ศาลเยาวชนและครอบครัวจังหวัดเพชรบูรณ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(276, '3090701', 'ศาลเยาวชนและครอบครัวจังหวัดราชบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(277, '3090702', 'ศาลเยาวชนและครอบครัวจังหวัดกาญจนบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(278, '3090703', 'ศาลเยาวชนและครอบครัวจังหวัดสุพรรณบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(279, '3090704', 'ศาลเยาวชนและครอบครัวจังหวัดนครปฐม', NULL, NULL, NULL, NULL, NULL, NULL),
	(280, '3090705', 'ศาลเยาวชนและครอบครัวจังหวัดสมุทรสาคร', NULL, NULL, NULL, NULL, NULL, NULL),
	(281, '3090706', 'ศาลเยาวชนและครอบครัวจังหวัดสมุทรสงคราม', NULL, NULL, NULL, NULL, NULL, NULL),
	(282, '3090707', 'ศาลเยาวชนและครอบครัวจังหวัดเพชรบุรี', NULL, NULL, NULL, NULL, NULL, NULL),
	(283, '3090708', 'ศาลเยาวชนและครอบครัวจังหวัดประจวบคีรีขันธ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(284, '3090801', 'ศาลเยาวชนและครอบครัวจังหวัดนครศรีธรรมราช', NULL, NULL, NULL, NULL, NULL, NULL),
	(285, '3090802', 'ศาลเยาวชนและครอบครัวจังหวัดกระบี่', NULL, NULL, NULL, NULL, NULL, NULL),
	(286, '3090803', 'ศาลเยาวชนและครอบครัวจังหวัดพังงา', NULL, NULL, NULL, NULL, NULL, NULL),
	(287, '3090804', 'ศาลเยาวชนและครอบครัวจังหวัดภูเก็ต', NULL, NULL, NULL, NULL, NULL, NULL),
	(288, '3090805', 'ศาลเยาวชนและครอบครัวจังหวัดสุราษฎร์ธานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(289, '3090806', 'ศาลเยาวชนและครอบครัวจังหวัดระนอง', NULL, NULL, NULL, NULL, NULL, NULL),
	(290, '3090807', 'ศาลเยาวชนและครอบครัวจังหวัดชุมพร', NULL, NULL, NULL, NULL, NULL, NULL),
	(291, '3090901', 'ศาลเยาวชนและครอบครัวจังหวัดสงขลา', NULL, NULL, NULL, NULL, NULL, NULL),
	(292, '3090902', 'ศาลเยาวชนและครอบครัวจังหวัดสตูล', NULL, NULL, NULL, NULL, NULL, NULL),
	(293, '3090903', 'ศาลเยาวชนและครอบครัวจังหวัดตรัง', NULL, NULL, NULL, NULL, NULL, NULL),
	(294, '3090904', 'ศาลเยาวชนและครอบครัวจังหวัดพัทลุง', NULL, NULL, NULL, NULL, NULL, NULL),
	(295, '3090905', 'ศาลเยาวชนและครอบครัวจังหวัดปัตตานี', NULL, NULL, NULL, NULL, NULL, NULL),
	(296, '3090906', 'ศาลเยาวชนและครอบครัวจังหวัดยะลา', NULL, NULL, NULL, NULL, NULL, NULL),
	(297, '3090907', 'ศาลเยาวชนและครอบครัวจังหวัดนราธิวาส', NULL, NULL, NULL, NULL, NULL, NULL),
	(298, '1000001', 'สำนักประธานศาลฏีกา', NULL, NULL, NULL, NULL, NULL, NULL),
	(299, '2000001', 'ศาลอุทธรณ์', NULL, NULL, NULL, NULL, NULL, NULL),
	(300, '3080203', 'ศาลแขวงระยอง', NULL, NULL, NULL, NULL, NULL, NULL),
	(301, '3080804', 'ศาลแขวงภูเก็ต', NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `courts` ENABLE KEYS */;

-- Dumping structure for table sec_officer.court_reports
DROP TABLE IF EXISTS `court_reports`;
CREATE TABLE IF NOT EXISTS `court_reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `court_id` int(11) NOT NULL,
  `year` varchar(4) NOT NULL,
  `month` varchar(2) NOT NULL,
  `work7_day` int(11) DEFAULT NULL,
  `work6_day` int(11) DEFAULT NULL,
  `total_shuffle` int(11) DEFAULT NULL,
  `total_shuffle_except` int(11) DEFAULT NULL,
  `total_shuffle_absence` int(11) DEFAULT NULL,
  `reporter_name` varchar(255) DEFAULT NULL,
  `reporter_position` varchar(255) DEFAULT NULL,
  `inspector_name` varchar(255) DEFAULT NULL,
  `inspector_position` varchar(255) DEFAULT NULL,
  `status` varchar(10) DEFAULT 'W',
  `file_path` varchar(255) DEFAULT NULL,
  `doc_no` varchar(255) DEFAULT NULL,
  `created_uid` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_uid` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_1` (`court_id`,`year`,`month`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table sec_officer.court_reports: ~2 rows (approximately)
DELETE FROM `court_reports`;
/*!40000 ALTER TABLE `court_reports` DISABLE KEYS */;
INSERT INTO `court_reports` (`id`, `court_id`, `year`, `month`, `work7_day`, `work6_day`, `total_shuffle`, `total_shuffle_except`, `total_shuffle_absence`, `reporter_name`, `reporter_position`, `inspector_name`, `inspector_position`, `status`, `file_path`, `doc_no`, `created_uid`, `created_at`, `updated_uid`, `updated_at`) VALUES
	(1, 78, '2562', '07', 31, 25, 57, 1, 5, 'AAA', 'BBB', 'CCC', 'DDD', 'S', 'report_1.pdf', 'ศย.62/999', 2, '2019-08-27 23:38:00', 2, '2019-08-27 23:45:21'),
	(2, 77, '2562', '07', 31, 25, 1, 0, 0, 'A', 'B', 'C', 'D', 'S', 'report_2.pdf', 'ศย.62/888', 3, '2019-08-27 23:49:33', 3, '2019-08-27 23:49:51');
/*!40000 ALTER TABLE `court_reports` ENABLE KEYS */;

-- Dumping structure for table sec_officer.court_report_sec_people
DROP TABLE IF EXISTS `court_report_sec_people`;
CREATE TABLE IF NOT EXISTS `court_report_sec_people` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `court_report_id` int(11) NOT NULL,
  `sec_person_name` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `role` int(11) DEFAULT 2,
  `day_month` int(11) DEFAULT NULL,
  `day_month_work` int(11) DEFAULT NULL,
  `shuffle` int(11) DEFAULT NULL,
  `shuffle_except` int(11) DEFAULT NULL,
  `shuffle_date_name` varchar(500) DEFAULT NULL,
  `shuffle_absence` int(11) DEFAULT NULL,
  `shuffle_absence_date` varchar(500) DEFAULT NULL,
  `h_not12` int(11) DEFAULT NULL,
  `h_not12_date_h` varchar(500) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table sec_officer.court_report_sec_people: ~5 rows (approximately)
DELETE FROM `court_report_sec_people`;
/*!40000 ALTER TABLE `court_report_sec_people` DISABLE KEYS */;
INSERT INTO `court_report_sec_people` (`id`, `court_report_id`, `sec_person_name`, `type`, `role`, `day_month`, `day_month_work`, `shuffle`, `shuffle_except`, `shuffle_date_name`, `shuffle_absence`, `shuffle_absence_date`, `h_not12`, `h_not12_date_h`, `remark`, `created_at`, `updated_at`) VALUES
	(1, 1, 'นายเจ้าหน้าที่ รักษาความปลอดภัย', 1, 1, 31, 25, 3, 1, '', 3, '', 4, '', '', '2019-08-27 23:38:00', '2019-08-27 23:38:00'),
	(2, 1, 'นายเจ้าหน้าที่ รักษาความปลอดภัย2', 1, 2, 31, 31, 30, 0, '', 1, '', 0, '', '', '2019-08-27 23:38:00', '2019-08-27 23:38:00'),
	(3, 1, 'นายเจ้าหน้าที่ รักษาความปลอดภัย3', 2, 2, 25, 25, 24, 0, '', 1, '', 0, '', '', '2019-08-27 23:38:00', '2019-08-27 23:38:00'),
	(4, 2, 'นายรักษาความปลอดภัย 1', 1, 2, 31, 30, 1, 0, '', 0, '', 0, '', '', '2019-08-27 23:49:33', '2019-08-27 23:49:33'),
	(5, 2, 'นายรักษาความปลอดภัย 2', 2, 2, 25, 25, 0, 0, '', 0, '', 0, '', '', '2019-08-27 23:49:33', '2019-08-27 23:49:33');
/*!40000 ALTER TABLE `court_report_sec_people` ENABLE KEYS */;

-- Dumping structure for table sec_officer.posts
DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table sec_officer.posts: ~0 rows (approximately)
DELETE FROM `posts`;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;

-- Dumping structure for table sec_officer.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_uid` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `c_updated_uid` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table sec_officer.roles: ~2 rows (approximately)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `description`, `created_uid`, `created_at`, `c_updated_uid`, `updated_at`, `deleted_at`) VALUES
	(1, 'admin', 'แอดมิน', 1, '2019-07-09 10:08:04', 1, '2019-07-09 10:08:11', NULL),
	(2, 'staff', 'เจ้าหน้าที่ศาล', 1, '2019-07-09 10:08:05', 1, '2019-07-09 10:08:13', NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table sec_officer.sec_persons
DROP TABLE IF EXISTS `sec_persons`;
CREATE TABLE IF NOT EXISTS `sec_persons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(500) DEFAULT NULL,
  `court_id` int(11) DEFAULT NULL,
  `status` varchar(10) DEFAULT 'A',
  `created_uid` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_uid` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table sec_officer.sec_persons: ~5 rows (approximately)
DELETE FROM `sec_persons`;
/*!40000 ALTER TABLE `sec_persons` DISABLE KEYS */;
INSERT INTO `sec_persons` (`id`, `full_name`, `court_id`, `status`, `created_uid`, `created_at`, `updated_uid`, `updated_at`) VALUES
	(1, 'นายเจ้าหน้าที่ รักษาความปลอดภัย', 78, 'A', 2, '2019-08-27 13:05:50', 0, '2019-08-27 13:05:50'),
	(2, 'นายเจ้าหน้าที่ รักษาความปลอดภัย2', 78, 'A', 2, '2019-08-27 13:05:54', 0, '2019-08-27 13:05:54'),
	(3, 'นายเจ้าหน้าที่ รักษาความปลอดภัย3', 78, 'A', 2, '2019-08-27 13:05:58', 0, '2019-08-27 13:05:58'),
	(4, 'นายรักษาความปลอดภัย 1', 77, 'A', 3, '2019-08-27 13:13:07', 0, '2019-08-27 13:13:07'),
	(5, 'นายรักษาความปลอดภัย 2', 77, 'A', 3, '2019-08-27 13:13:12', 0, '2019-08-27 13:13:12');
/*!40000 ALTER TABLE `sec_persons` ENABLE KEYS */;

-- Dumping structure for table sec_officer.tags
DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tags_post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table sec_officer.tags: ~0 rows (approximately)
DELETE FROM `tags`;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;

-- Dumping structure for table sec_officer.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `court_id` int(11) DEFAULT NULL,
  `status` varchar(10) DEFAULT 'A',
  `created_uid` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_uid` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table sec_officer.users: ~3 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`, `first_name`, `last_name`, `role_id`, `court_id`, `status`, `created_uid`, `created_at`, `updated_uid`, `updated_at`, `deleted_at`) VALUES
	(1, 'admin', '$2a$12$2FGcjZvRdh/MHOZKl6CBq.HbFGpqm3w2qMpMlJBL1TX7m1c28GMdu', 'aaaa', 'aaaa', 1, 11, 'A', 0, '2019-07-11 11:12:25', 0, '2019-07-11 11:12:25', NULL),
	(2, 'user1', '$2a$12$7arvcf6esVSDXyVLj8lX1uDfKuYZL81YFKNo9UPM7va/2LIqJM/j2', 'user1', 'user1', 2, 78, 'A', 1, '2019-08-27 13:04:45', 0, '2019-08-27 13:04:45', NULL),
	(3, 'user2', '$2a$12$3Q/7D69npabrLf69reArNOAFaWQY0PIWy1VoYCms8cgX9aXGYfRmi', 'user2', 'user2', 2, 77, 'A', 1, '2019-08-27 13:05:30', 0, '2019-08-27 13:05:30', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
