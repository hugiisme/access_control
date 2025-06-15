-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2025 at 12:19 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `access_control`
--

-- --------------------------------------------------------

--
-- Table structure for table `actions`
--

CREATE TABLE `actions` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT 'Tên hành động',
  `description` varchar(255) DEFAULT NULL COMMENT 'Mô tả hành động'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng hành động';

--
-- Dumping data for table `actions`
--

INSERT INTO `actions` (`id`, `name`, `description`) VALUES
(1, 'Create', NULL),
(2, 'Read', NULL),
(3, 'Update', NULL),
(4, 'Delete', NULL),
(5, 'Assign', NULL),
(6, 'Verify', NULL),
(7, 'Submit', NULL),
(8, 'Upload', NULL),
(9, 'Download', NULL),
(10, 'Import', NULL),
(11, 'Export', NULL),
(12, 'Request', NULL),
(13, 'Foward', NULL),
(14, 'Configure', NULL),
(15, 'Execute', NULL),
(16, 'Authorize', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT 'Tên tổ chức',
  `parent_org_id` int(11) DEFAULT NULL COMMENT 'ID tổ chức cha (nếu có)',
  `organization_level` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng tổ chức, tập thể';

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`id`, `name`, `parent_org_id`, `organization_level`) VALUES
(1, 'Đoàn trường', NULL, 1),
(2, 'Ban chấp hành Đoàn trường', 1, 1),
(3, 'Ban thường vụ Đoàn trường', 2, 1),
(4, 'Ban thường trực Đoàn trường', 3, 1),
(5, 'Chi đoàn trực thuộc Đoàn trường', 1, 2),
(6, 'Ban chấp hành chi đoàn trực thuộc Đoàn trường', 5, 2),
(7, 'Đoàn trường THPT', 1, 2),
(8, 'Ban chấp hành đoàn trường Phổ thông', 7, 2),
(9, 'Đội trực thuộc trường', 1, 2),
(10, 'Ban lãnh đội trực thuộc trường', 9, 2),
(11, 'Liên chi đoàn', 1, 2),
(12, 'Ban chấp hành liên chi đoàn', 11, 2),
(13, 'Ban thường vụ liên chi đoàn', 12, 2),
(14, 'Ban thường trực liên chi đoàn', 13, 2),
(15, 'Chi đoàn khoa CNTT', 11, 3),
(16, 'Ban chấp hành Chi đoàn khoa CNTT', 15, 3),
(17, 'Đội khoa CNTT', 15, 3),
(18, 'Ban lãnh đội khoa CNTT', 17, 3);

-- --------------------------------------------------------

--
-- Table structure for table `organization_permissions`
--

CREATE TABLE `organization_permissions` (
  `id` int(11) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `permission_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Các quyền có sẵn trong một tổ chức';

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `action_id` int(11) DEFAULT NULL COMMENT 'ID hành động',
  `resource_type_id` int(11) DEFAULT NULL COMMENT 'ID loại tài nguyên'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng quyền (kết hợp hành động và loại tài nguyên)';

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `action_id`, `resource_type_id`) VALUES
(1, 5, 1),
(2, 16, 1),
(3, 14, 1),
(4, 1, 1),
(5, 4, 1),
(6, 9, 1),
(7, 15, 1),
(8, 11, 1),
(9, 13, 1),
(10, 10, 1),
(11, 2, 1),
(12, 12, 1),
(13, 7, 1),
(14, 3, 1),
(15, 8, 1),
(16, 6, 1),
(17, 5, 2),
(18, 16, 2),
(19, 14, 2),
(20, 1, 2),
(21, 4, 2),
(22, 9, 2),
(23, 15, 2),
(24, 11, 2),
(25, 13, 2),
(26, 10, 2),
(27, 2, 2),
(28, 12, 2),
(29, 7, 2),
(30, 3, 2),
(31, 8, 2),
(32, 6, 2),
(33, 5, 3),
(34, 16, 3),
(35, 14, 3),
(36, 1, 3),
(37, 4, 3),
(38, 9, 3),
(39, 15, 3),
(40, 11, 3),
(41, 13, 3),
(42, 10, 3),
(43, 2, 3),
(44, 12, 3),
(45, 7, 3),
(46, 3, 3),
(47, 8, 3),
(48, 6, 3),
(49, 5, 4),
(50, 16, 4),
(51, 14, 4),
(52, 1, 4),
(53, 4, 4),
(54, 9, 4),
(55, 15, 4),
(56, 11, 4),
(57, 13, 4),
(58, 10, 4),
(59, 2, 4),
(60, 12, 4),
(61, 7, 4),
(62, 3, 4),
(63, 8, 4),
(64, 6, 4),
(65, 5, 5),
(66, 16, 5),
(67, 14, 5),
(68, 1, 5),
(69, 4, 5),
(70, 9, 5),
(71, 15, 5),
(72, 11, 5),
(73, 13, 5),
(74, 10, 5),
(75, 2, 5),
(76, 12, 5),
(77, 7, 5),
(78, 3, 5),
(79, 8, 5),
(80, 6, 5),
(81, 5, 6),
(82, 16, 6),
(83, 14, 6),
(84, 1, 6),
(85, 4, 6),
(86, 9, 6),
(87, 15, 6),
(88, 11, 6),
(89, 13, 6),
(90, 10, 6),
(91, 2, 6),
(92, 12, 6),
(93, 7, 6),
(94, 3, 6),
(95, 8, 6),
(96, 6, 6),
(97, 5, 7),
(98, 16, 7),
(99, 14, 7),
(100, 1, 7),
(101, 4, 7),
(102, 9, 7),
(103, 15, 7),
(104, 11, 7),
(105, 13, 7),
(106, 10, 7),
(107, 2, 7),
(108, 12, 7),
(109, 7, 7),
(110, 3, 7),
(111, 8, 7),
(112, 6, 7),
(113, 5, 8),
(114, 16, 8),
(115, 14, 8),
(116, 1, 8),
(117, 4, 8),
(118, 9, 8),
(119, 15, 8),
(120, 11, 8),
(121, 13, 8),
(122, 10, 8),
(123, 2, 8),
(124, 12, 8),
(125, 7, 8),
(126, 3, 8),
(127, 8, 8),
(128, 6, 8),
(129, 5, 9),
(130, 16, 9),
(131, 14, 9),
(132, 1, 9),
(133, 4, 9),
(134, 9, 9),
(135, 15, 9),
(136, 11, 9),
(137, 13, 9),
(138, 10, 9),
(139, 2, 9),
(140, 12, 9),
(141, 7, 9),
(142, 3, 9),
(143, 8, 9),
(144, 6, 9),
(145, 5, 10),
(146, 16, 10),
(147, 14, 10),
(148, 1, 10),
(149, 4, 10),
(150, 9, 10),
(151, 15, 10),
(152, 11, 10),
(153, 13, 10),
(154, 10, 10),
(155, 2, 10),
(156, 12, 10),
(157, 7, 10),
(158, 3, 10),
(159, 8, 10),
(160, 6, 10),
(161, 5, 11),
(162, 16, 11),
(163, 14, 11),
(164, 1, 11),
(165, 4, 11),
(166, 9, 11),
(167, 15, 11),
(168, 11, 11),
(169, 13, 11),
(170, 10, 11),
(171, 2, 11),
(172, 12, 11),
(173, 7, 11),
(174, 3, 11),
(175, 8, 11),
(176, 6, 11),
(177, 5, 12),
(178, 16, 12),
(179, 14, 12),
(180, 1, 12),
(181, 4, 12),
(182, 9, 12),
(183, 15, 12),
(184, 11, 12),
(185, 13, 12),
(186, 10, 12),
(187, 2, 12),
(188, 12, 12),
(189, 7, 12),
(190, 3, 12),
(191, 8, 12),
(192, 6, 12),
(193, 5, 13),
(194, 16, 13),
(195, 14, 13),
(196, 1, 13),
(197, 4, 13),
(198, 9, 13),
(199, 15, 13),
(200, 11, 13),
(201, 13, 13),
(202, 10, 13),
(203, 2, 13),
(204, 12, 13),
(205, 7, 13),
(206, 3, 13),
(207, 8, 13),
(208, 6, 13),
(209, 5, 14),
(210, 16, 14),
(211, 14, 14),
(212, 1, 14),
(213, 4, 14),
(214, 9, 14),
(215, 15, 14),
(216, 11, 14),
(217, 13, 14),
(218, 10, 14),
(219, 2, 14),
(220, 12, 14),
(221, 7, 14),
(222, 3, 14),
(223, 8, 14),
(224, 6, 14),
(225, 5, 15),
(226, 16, 15),
(227, 14, 15),
(228, 1, 15),
(229, 4, 15),
(230, 9, 15),
(231, 15, 15),
(232, 11, 15),
(233, 13, 15),
(234, 10, 15),
(235, 2, 15),
(236, 12, 15),
(237, 7, 15),
(238, 3, 15),
(239, 8, 15),
(240, 6, 15),
(241, 5, 16),
(242, 16, 16),
(243, 14, 16),
(244, 1, 16),
(245, 4, 16),
(246, 9, 16),
(247, 15, 16),
(248, 11, 16),
(249, 13, 16),
(250, 10, 16),
(251, 2, 16),
(252, 12, 16),
(253, 7, 16),
(254, 3, 16),
(255, 8, 16),
(256, 6, 16),
(257, 5, 17),
(258, 16, 17),
(259, 14, 17),
(260, 1, 17),
(261, 4, 17),
(262, 9, 17),
(263, 15, 17),
(264, 11, 17),
(265, 13, 17),
(266, 10, 17),
(267, 2, 17),
(268, 12, 17),
(269, 7, 17),
(270, 3, 17),
(271, 8, 17),
(272, 6, 17),
(273, 5, 18),
(274, 16, 18),
(275, 14, 18),
(276, 1, 18),
(277, 4, 18),
(278, 9, 18),
(279, 15, 18),
(280, 11, 18),
(281, 13, 18),
(282, 10, 18),
(283, 2, 18),
(284, 12, 18),
(285, 7, 18),
(286, 3, 18),
(287, 8, 18),
(288, 6, 18),
(289, 5, 19),
(290, 16, 19),
(291, 14, 19),
(292, 1, 19),
(293, 4, 19),
(294, 9, 19),
(295, 15, 19),
(296, 11, 19),
(297, 13, 19),
(298, 10, 19),
(299, 2, 19),
(300, 12, 19),
(301, 7, 19),
(302, 3, 19),
(303, 8, 19),
(304, 6, 19),
(305, 5, 20),
(306, 16, 20),
(307, 14, 20),
(308, 1, 20),
(309, 4, 20),
(310, 9, 20),
(311, 15, 20),
(312, 11, 20),
(313, 13, 20),
(314, 10, 20),
(315, 2, 20),
(316, 12, 20),
(317, 7, 20),
(318, 3, 20),
(319, 8, 20),
(320, 6, 20),
(321, 5, 21),
(322, 16, 21),
(323, 14, 21),
(324, 1, 21),
(325, 4, 21),
(326, 9, 21),
(327, 15, 21),
(328, 11, 21),
(329, 13, 21),
(330, 10, 21),
(331, 2, 21),
(332, 12, 21),
(333, 7, 21),
(334, 3, 21),
(335, 8, 21),
(336, 6, 21),
(337, 5, 22),
(338, 16, 22),
(339, 14, 22),
(340, 1, 22),
(341, 4, 22),
(342, 9, 22),
(343, 15, 22),
(344, 11, 22),
(345, 13, 22),
(346, 10, 22),
(347, 2, 22),
(348, 12, 22),
(349, 7, 22),
(350, 3, 22),
(351, 8, 22),
(352, 6, 22),
(353, 5, 23),
(354, 16, 23),
(355, 14, 23),
(356, 1, 23),
(357, 4, 23),
(358, 9, 23),
(359, 15, 23),
(360, 11, 23),
(361, 13, 23),
(362, 10, 23),
(363, 2, 23),
(364, 12, 23),
(365, 7, 23),
(366, 3, 23),
(367, 8, 23),
(368, 6, 23),
(369, 5, 24),
(370, 16, 24),
(371, 14, 24),
(372, 1, 24),
(373, 4, 24),
(374, 9, 24),
(375, 15, 24),
(376, 11, 24),
(377, 13, 24),
(378, 10, 24),
(379, 2, 24),
(380, 12, 24),
(381, 7, 24),
(382, 3, 24),
(383, 8, 24),
(384, 6, 24),
(385, 5, 25),
(386, 16, 25),
(387, 14, 25),
(388, 1, 25),
(389, 4, 25),
(390, 9, 25),
(391, 15, 25),
(392, 11, 25),
(393, 13, 25),
(394, 10, 25),
(395, 2, 25),
(396, 12, 25),
(397, 7, 25),
(398, 3, 25),
(399, 8, 25),
(400, 6, 25),
(401, 5, 26),
(402, 16, 26),
(403, 14, 26),
(404, 1, 26),
(405, 4, 26),
(406, 9, 26),
(407, 15, 26),
(408, 11, 26),
(409, 13, 26),
(410, 10, 26),
(411, 2, 26),
(412, 12, 26),
(413, 7, 26),
(414, 3, 26),
(415, 8, 26),
(416, 6, 26),
(417, 5, 27),
(418, 16, 27),
(419, 14, 27),
(420, 1, 27),
(421, 4, 27),
(422, 9, 27),
(423, 15, 27),
(424, 11, 27),
(425, 13, 27),
(426, 10, 27),
(427, 2, 27),
(428, 12, 27),
(429, 7, 27),
(430, 3, 27),
(431, 8, 27),
(432, 6, 27),
(433, 5, 28),
(434, 16, 28),
(435, 14, 28),
(436, 1, 28),
(437, 4, 28),
(438, 9, 28),
(439, 15, 28),
(440, 11, 28),
(441, 13, 28),
(442, 10, 28),
(443, 2, 28),
(444, 12, 28),
(445, 7, 28),
(446, 3, 28),
(447, 8, 28),
(448, 6, 28),
(449, 5, 29),
(450, 16, 29),
(451, 14, 29),
(452, 1, 29),
(453, 4, 29),
(454, 9, 29),
(455, 15, 29),
(456, 11, 29),
(457, 13, 29),
(458, 10, 29),
(459, 2, 29),
(460, 12, 29),
(461, 7, 29),
(462, 3, 29),
(463, 8, 29),
(464, 6, 29),
(465, 5, 30),
(466, 16, 30),
(467, 14, 30),
(468, 1, 30),
(469, 4, 30),
(470, 9, 30),
(471, 15, 30),
(472, 11, 30),
(473, 13, 30),
(474, 10, 30),
(475, 2, 30),
(476, 12, 30),
(477, 7, 30),
(478, 3, 30),
(479, 8, 30),
(480, 6, 30),
(481, 5, 31),
(482, 16, 31),
(483, 14, 31),
(484, 1, 31),
(485, 4, 31),
(486, 9, 31),
(487, 15, 31),
(488, 11, 31),
(489, 13, 31),
(490, 10, 31),
(491, 2, 31),
(492, 12, 31),
(493, 7, 31),
(494, 3, 31),
(495, 8, 31),
(496, 6, 31),
(497, 5, 32),
(498, 16, 32),
(499, 14, 32),
(500, 1, 32),
(501, 4, 32),
(502, 9, 32),
(503, 15, 32),
(504, 11, 32),
(505, 13, 32),
(506, 10, 32),
(507, 2, 32),
(508, 12, 32),
(509, 7, 32),
(510, 3, 32),
(511, 8, 32),
(512, 6, 32),
(513, 5, 33),
(514, 16, 33),
(515, 14, 33),
(516, 1, 33),
(517, 4, 33),
(518, 9, 33),
(519, 15, 33),
(520, 11, 33),
(521, 13, 33),
(522, 10, 33),
(523, 2, 33),
(524, 12, 33),
(525, 7, 33),
(526, 3, 33),
(527, 8, 33),
(528, 6, 33),
(529, 5, 34),
(530, 16, 34),
(531, 14, 34),
(532, 1, 34),
(533, 4, 34),
(534, 9, 34),
(535, 15, 34),
(536, 11, 34),
(537, 13, 34),
(538, 10, 34),
(539, 2, 34),
(540, 12, 34),
(541, 7, 34),
(542, 3, 34),
(543, 8, 34),
(544, 6, 34),
(545, 5, 35),
(546, 16, 35),
(547, 14, 35),
(548, 1, 35),
(549, 4, 35),
(550, 9, 35),
(551, 15, 35),
(552, 11, 35),
(553, 13, 35),
(554, 10, 35),
(555, 2, 35),
(556, 12, 35),
(557, 7, 35),
(558, 3, 35),
(559, 8, 35),
(560, 6, 35),
(561, 5, 36),
(562, 16, 36),
(563, 14, 36),
(564, 1, 36),
(565, 4, 36),
(566, 9, 36),
(567, 15, 36),
(568, 11, 36),
(569, 13, 36),
(570, 10, 36),
(571, 2, 36),
(572, 12, 36),
(573, 7, 36),
(574, 3, 36),
(575, 8, 36),
(576, 6, 36),
(577, 5, 37),
(578, 16, 37),
(579, 14, 37),
(580, 1, 37),
(581, 4, 37),
(582, 9, 37),
(583, 15, 37),
(584, 11, 37),
(585, 13, 37),
(586, 10, 37),
(587, 2, 37),
(588, 12, 37),
(589, 7, 37),
(590, 3, 37),
(591, 8, 37),
(592, 6, 37),
(593, 5, 38),
(594, 16, 38),
(595, 14, 38),
(596, 1, 38),
(597, 4, 38),
(598, 9, 38),
(599, 15, 38),
(600, 11, 38),
(601, 13, 38),
(602, 10, 38),
(603, 2, 38),
(604, 12, 38),
(605, 7, 38),
(606, 3, 38),
(607, 8, 38),
(608, 6, 38);

-- --------------------------------------------------------

--
-- Table structure for table `policies`
--

CREATE TABLE `policies` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Tên chính sách',
  `description` varchar(255) DEFAULT NULL COMMENT 'Mô tả chính sách',
  `organization_id` int(11) DEFAULT NULL COMMENT 'ID tổ chức áp dụng chính sách',
  `action_id` int(11) DEFAULT NULL COMMENT 'ID hành động được phép',
  `resource_id` int(11) NOT NULL,
  `condition_group_id` int(11) DEFAULT NULL COMMENT 'ID nhóm điều kiện, null nếu không có'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng chính sách (Policy)';

-- --------------------------------------------------------

--
-- Table structure for table `policy_conditions`
--

CREATE TABLE `policy_conditions` (
  `id` int(11) NOT NULL COMMENT 'ID điều kiện',
  `condition_group_id` int(11) DEFAULT NULL,
  `attribute_name` varchar(50) DEFAULT NULL COMMENT 'Tên thuộc tính (ví dụ: user_role, organization_id)',
  `operator` varchar(10) DEFAULT NULL COMMENT 'Toán tử so sánh (ví dụ: =, !=, in, like)',
  `value` varchar(100) DEFAULT NULL COMMENT 'Giá trị so sánh'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng điều kiện chi tiết của chính sách';

-- --------------------------------------------------------

--
-- Table structure for table `policy_conditions_groups`
--

CREATE TABLE `policy_conditions_groups` (
  `id` int(11) NOT NULL COMMENT 'ID nhóm điều kiện',
  `name` varchar(50) DEFAULT NULL COMMENT 'Tên nhóm điều kiện',
  `parent_condition_group_id` int(11) DEFAULT NULL COMMENT 'ID nhóm điều kiện cha (nếu có)',
  `operator` varchar(10) DEFAULT NULL COMMENT 'Toán tử kết hợp các điều kiện trong nhóm (AND, OR)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng nhóm điều kiện chính sách';

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE `resources` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Tên tài nguyên',
  `description` varchar(255) DEFAULT NULL COMMENT 'Mô tả tài nguyên',
  `resource_type_id` int(11) DEFAULT NULL COMMENT 'ID loại tài nguyên',
  `entity_id` int(11) DEFAULT NULL COMMENT 'Id dẫn đến bảng thực thể thực tế (ví dụ: document_id)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng tài nguyên';

-- --------------------------------------------------------

--
-- Table structure for table `resource_relations`
--

CREATE TABLE `resource_relations` (
  `id` int(11) NOT NULL,
  `first_resource_id` int(11) DEFAULT NULL,
  `second_resource_id` int(11) DEFAULT NULL,
  `relation_type_id` int(11) DEFAULT NULL COMMENT 'Loại quan hệ (contains, related_to,...)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Quan hệ giữa các tài nguyên với nhau';

-- --------------------------------------------------------

--
-- Table structure for table `resource_relation_types`
--

CREATE TABLE `resource_relation_types` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT 'Tên loại quan hệ (ví dụ: contains, related_to)',
  `description` varchar(255) DEFAULT NULL COMMENT 'Mô tả loại quan hệ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng loại quan hệ giữa các tài nguyên';

-- --------------------------------------------------------

--
-- Table structure for table `resource_roles`
--

CREATE TABLE `resource_roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT 'Tên vai trò',
  `description` varchar(255) DEFAULT NULL COMMENT 'Mô tả vai trò'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng vai trò đối với tài nguyên';

--
-- Dumping data for table `resource_roles`
--

INSERT INTO `resource_roles` (`id`, `name`, `description`) VALUES
(1, 'Owner', NULL),
(2, 'Viewer', NULL),
(3, 'Editor', NULL),
(4, 'Deleter', NULL),
(5, 'Collaborator', NULL),
(6, 'Sharer', NULL),
(7, 'Verifier', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `resource_role_actions`
--

CREATE TABLE `resource_role_actions` (
  `id` int(11) NOT NULL,
  `action_id` int(11) NOT NULL,
  `resource_role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource_role_relations`
--

CREATE TABLE `resource_role_relations` (
  `id` int(11) NOT NULL,
  `resource_role_1_id` int(11) DEFAULT NULL,
  `relation_type` enum('contains') DEFAULT NULL,
  `resource_role_2_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Quan hệ giữa vai trò và loại quan hệ tài nguyên';

-- --------------------------------------------------------

--
-- Table structure for table `resource_types`
--

CREATE TABLE `resource_types` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT 'Tên loại tài nguyên'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng loại tài nguyên';

--
-- Dumping data for table `resource_types`
--

INSERT INTO `resource_types` (`id`, `name`) VALUES
(2, 'Cấp độ giải thưởng'),
(1, 'Cấp tổ chức'),
(3, 'Chính sách'),
(4, 'Cuộc bình chọn'),
(5, 'Cuộc họp'),
(6, 'Danh mục hoạt động'),
(34, 'Điều kiện (của chính sách)'),
(35, 'Điều kiện (của tiêu chí khen thưởng)'),
(36, 'Điều kiện đrl'),
(37, 'Đợt khen thưởng'),
(38, 'Đợt xét điểm rèn luyện'),
(7, 'Giải thưởng của hoạt động (tên của giải theo định '),
(8, 'Hồ sơ khen thưởng (Lưu vết)'),
(9, 'Hoạt động'),
(10, 'Hoạt động năm học'),
(11, 'Học kỳ'),
(12, 'Kế hoạch năm học'),
(13, 'Khen thưởng'),
(14, 'Loại hành động'),
(15, 'Loại hoạt động (Phản hồi/Ko phản hồi)'),
(16, 'Loại minh chứng'),
(17, 'Loại tài nguyên'),
(18, 'Mẫu báo cáo'),
(19, 'Minh chứng'),
(20, 'Năm học'),
(21, 'Người dùng'),
(25, 'Nhóm điều kiện (của chính sách)'),
(22, 'Nhóm người dùng (trong hoạt đông)'),
(24, 'Nhóm tiêu chí điểm rèn luyện'),
(23, 'Nhóm tiêu chí khen thưởng'),
(26, 'Phương thức tính điểm'),
(27, 'Quyền'),
(28, 'Tài nguyên'),
(30, 'Tiêu chí điểm rèn luyện'),
(29, 'Tiêu chí khen thưởng'),
(31, 'Tổ chức'),
(33, 'Vai trò đối với tài nguyên'),
(32, 'Vai trò hệ thống');

-- --------------------------------------------------------

--
-- Table structure for table `system_roles`
--

CREATE TABLE `system_roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `system_role_type` enum('Trưởng','Phó','Thành viên') DEFAULT NULL COMMENT 'Loại vai trò hệ thống',
  `max_users` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng vai trò hệ thống';

--
-- Dumping data for table `system_roles`
--

INSERT INTO `system_roles` (`id`, `name`, `description`, `organization_id`, `system_role_type`, `max_users`) VALUES
(31, 'Bí thư đoàn trường', NULL, 4, 'Trưởng', 0),
(32, 'Phó bí thư đoàn trường', NULL, 4, 'Phó', 0),
(33, 'Uỷ viên BTV đoàn trường', NULL, 3, 'Thành viên', 0),
(34, 'Ủy viên ban chấp hành', NULL, 2, 'Thành viên', 0),
(35, 'Chuyên viên đoàn trường', NULL, 1, 'Thành viên', 0),
(36, 'Ủy viên ban kiểm tra', NULL, 1, 'Thành viên', 0),
(37, 'Bí thư', NULL, 6, 'Trưởng', 0),
(38, 'Phó bí thư', NULL, 6, 'Phó', 0),
(39, 'UV BCH', NULL, 6, 'Thành viên', 0),
(40, 'Đoàn viên', NULL, 5, 'Thành viên', 0),
(41, 'Bí thư', NULL, 8, 'Trưởng', 0),
(42, 'Phó bí thư', NULL, 8, 'Phó', 0),
(43, 'Uỷ viên BTV', NULL, 8, 'Thành viên', 0),
(44, 'UV BCH', NULL, 8, 'Thành viên', 0),
(45, 'Bí thư liên chi đoàn', NULL, 14, 'Trưởng', 0),
(46, 'Phó bí thư liên chi đoàn', NULL, 14, 'Phó', 0),
(47, 'Uỷ viên BTV', NULL, 13, 'Thành viên', 0),
(48, 'Ủy viên ban chấp hành', NULL, 12, 'Thành viên', 0),
(49, 'Đội trưởng', NULL, 10, 'Trưởng', 0),
(50, 'Đội phó', NULL, 10, 'Phó', 0),
(51, 'Trưởng ban', NULL, 10, 'Trưởng', 0),
(52, 'Thành viên', NULL, 9, 'Thành viên', 0),
(53, 'Bí thư', NULL, 16, 'Trưởng', 0),
(54, 'Phó bí thư', NULL, 16, 'Phó', 0),
(55, 'Ban chấp hành', NULL, 16, 'Thành viên', 0),
(56, 'Đoàn viên', NULL, 15, 'Thành viên', 0),
(57, 'Đội trưởng', NULL, 18, 'Trưởng', 0),
(58, 'Đội phó', NULL, 18, 'Phó', 0),
(59, 'Trưởng ban', NULL, 18, 'Trưởng', 0),
(60, 'Thành viên', NULL, 17, 'Thành viên', 0);

-- --------------------------------------------------------

--
-- Table structure for table `system_role_permissions`
--

CREATE TABLE `system_role_permissions` (
  `id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL COMMENT 'ID từ bảng resource_roles',
  `permission_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Quan hệ vai trò tài nguyên - quyền';

--
-- Dumping data for table `system_role_permissions`
--

INSERT INTO `system_role_permissions` (`id`, `role_id`, `permission_id`) VALUES
(4, 31, 1),
(5, 31, 2),
(6, 31, 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng người dùng';

-- --------------------------------------------------------

--
-- Table structure for table `user_organizations`
--

CREATE TABLE `user_organizations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Quan hệ người dùng - tổ chức';

-- --------------------------------------------------------

--
-- Table structure for table `user_resources`
--

CREATE TABLE `user_resources` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `resource_role_id` int(11) DEFAULT NULL COMMENT 'ID vai trò tài nguyên (owner, editor,...)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Vai trò của người dùng trên một tài nguyên cụ thể';

-- --------------------------------------------------------

--
-- Table structure for table `user_system_roles`
--

CREATE TABLE `user_system_roles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `system_role_id` int(11) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Quan hệ người dùng - vai trò hệ thống';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actions`
--
ALTER TABLE `actions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `parent_org_id` (`parent_org_id`);

--
-- Indexes for table `organization_permissions`
--
ALTER TABLE `organization_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_org_permission` (`organization_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `action_id` (`action_id`),
  ADD KEY `resource_type_id` (`resource_type_id`);

--
-- Indexes for table `policies`
--
ALTER TABLE `policies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `organization_id` (`organization_id`),
  ADD KEY `action_id` (`action_id`),
  ADD KEY `condition_group_id` (`condition_group_id`),
  ADD KEY `resource_id` (`resource_id`);

--
-- Indexes for table `policy_conditions`
--
ALTER TABLE `policy_conditions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `condition_group_id` (`condition_group_id`);

--
-- Indexes for table `policy_conditions_groups`
--
ALTER TABLE `policy_conditions_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_condition_group_id` (`parent_condition_group_id`);

--
-- Indexes for table `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`),
  ADD KEY `resource_type_id` (`resource_type_id`);

--
-- Indexes for table `resource_relations`
--
ALTER TABLE `resource_relations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_resource_relation` (`first_resource_id`,`second_resource_id`),
  ADD KEY `second_resource_id` (`second_resource_id`),
  ADD KEY `relation_type_id` (`relation_type_id`);

--
-- Indexes for table `resource_relation_types`
--
ALTER TABLE `resource_relation_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `resource_roles`
--
ALTER TABLE `resource_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `resource_role_actions`
--
ALTER TABLE `resource_role_actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `action_id` (`action_id`),
  ADD KEY `resource_role_id` (`resource_role_id`);

--
-- Indexes for table `resource_role_relations`
--
ALTER TABLE `resource_role_relations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_resource_role_relation` (`resource_role_1_id`,`relation_type`),
  ADD KEY `relation_type_id` (`relation_type`),
  ADD KEY `resource_role_2_id` (`resource_role_2_id`);

--
-- Indexes for table `resource_types`
--
ALTER TABLE `resource_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `system_roles`
--
ALTER TABLE `system_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `system_role_permissions`
--
ALTER TABLE `system_role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_role_permission` (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `user_organizations`
--
ALTER TABLE `user_organizations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_organization` (`user_id`,`organization_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `user_resources`
--
ALTER TABLE `user_resources`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_resource_role` (`user_id`,`resource_id`,`resource_role_id`),
  ADD KEY `resource_id` (`resource_id`),
  ADD KEY `resource_role_id` (`resource_role_id`);

--
-- Indexes for table `user_system_roles`
--
ALTER TABLE `user_system_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_system_role_org` (`user_id`,`system_role_id`,`organization_id`),
  ADD KEY `system_role_id` (`system_role_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actions`
--
ALTER TABLE `actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `organization_permissions`
--
ALTER TABLE `organization_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=609;

--
-- AUTO_INCREMENT for table `policies`
--
ALTER TABLE `policies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `policy_conditions`
--
ALTER TABLE `policy_conditions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID điều kiện';

--
-- AUTO_INCREMENT for table `policy_conditions_groups`
--
ALTER TABLE `policy_conditions_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID nhóm điều kiện';

--
-- AUTO_INCREMENT for table `resources`
--
ALTER TABLE `resources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource_relations`
--
ALTER TABLE `resource_relations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource_relation_types`
--
ALTER TABLE `resource_relation_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource_roles`
--
ALTER TABLE `resource_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `resource_role_actions`
--
ALTER TABLE `resource_role_actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource_role_relations`
--
ALTER TABLE `resource_role_relations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource_types`
--
ALTER TABLE `resource_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `system_roles`
--
ALTER TABLE `system_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `system_role_permissions`
--
ALTER TABLE `system_role_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_organizations`
--
ALTER TABLE `user_organizations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_resources`
--
ALTER TABLE `user_resources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_system_roles`
--
ALTER TABLE `user_system_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `organizations`
--
ALTER TABLE `organizations`
  ADD CONSTRAINT `organizations_ibfk_1` FOREIGN KEY (`parent_org_id`) REFERENCES `organizations` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `organization_permissions`
--
ALTER TABLE `organization_permissions`
  ADD CONSTRAINT `organization_permissions_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `organization_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permissions_ibfk_2` FOREIGN KEY (`resource_type_id`) REFERENCES `resource_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `policies`
--
ALTER TABLE `policies`
  ADD CONSTRAINT `policies_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `policies_ibfk_2` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `policies_ibfk_4` FOREIGN KEY (`condition_group_id`) REFERENCES `policy_conditions_groups` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `policies_ibfk_5` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`);

--
-- Constraints for table `policy_conditions`
--
ALTER TABLE `policy_conditions`
  ADD CONSTRAINT `policy_conditions_ibfk_1` FOREIGN KEY (`condition_group_id`) REFERENCES `policy_conditions_groups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `policy_conditions_groups`
--
ALTER TABLE `policy_conditions_groups`
  ADD CONSTRAINT `policy_conditions_groups_ibfk_1` FOREIGN KEY (`parent_condition_group_id`) REFERENCES `policy_conditions_groups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `resources`
--
ALTER TABLE `resources`
  ADD CONSTRAINT `resources_ibfk_1` FOREIGN KEY (`resource_type_id`) REFERENCES `resource_types` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `resource_relations`
--
ALTER TABLE `resource_relations`
  ADD CONSTRAINT `resource_relations_ibfk_1` FOREIGN KEY (`first_resource_id`) REFERENCES `resources` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `resource_relations_ibfk_2` FOREIGN KEY (`second_resource_id`) REFERENCES `resources` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `resource_relations_ibfk_3` FOREIGN KEY (`relation_type_id`) REFERENCES `resource_relation_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `resource_role_actions`
--
ALTER TABLE `resource_role_actions`
  ADD CONSTRAINT `resource_role_actions_ibfk_1` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`),
  ADD CONSTRAINT `resource_role_actions_ibfk_2` FOREIGN KEY (`resource_role_id`) REFERENCES `resource_roles` (`id`);

--
-- Constraints for table `resource_role_relations`
--
ALTER TABLE `resource_role_relations`
  ADD CONSTRAINT `resource_role_relations_ibfk_1` FOREIGN KEY (`resource_role_1_id`) REFERENCES `resource_roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `resource_role_relations_ibfk_3` FOREIGN KEY (`resource_role_2_id`) REFERENCES `resource_roles` (`id`);

--
-- Constraints for table `system_roles`
--
ALTER TABLE `system_roles`
  ADD CONSTRAINT `system_roles_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `system_role_permissions`
--
ALTER TABLE `system_role_permissions`
  ADD CONSTRAINT `system_role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `system_roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `system_role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_organizations`
--
ALTER TABLE `user_organizations`
  ADD CONSTRAINT `user_organizations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_organizations_ibfk_2` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_resources`
--
ALTER TABLE `user_resources`
  ADD CONSTRAINT `user_resources_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_resources_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_resources_ibfk_3` FOREIGN KEY (`resource_role_id`) REFERENCES `resource_roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_system_roles`
--
ALTER TABLE `user_system_roles`
  ADD CONSTRAINT `user_system_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_system_roles_ibfk_2` FOREIGN KEY (`system_role_id`) REFERENCES `system_roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_system_roles_ibfk_3` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
