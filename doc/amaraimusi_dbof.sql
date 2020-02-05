-- phpMyAdmin SQL Dump
-- version 3.3.10.5
-- http://www.phpmyadmin.net
--
-- ホスト: mysql303.db.sakura.ne.jp
-- 生成時間: 2020 年 2 月 05 日 12:53
-- サーバのバージョン: 5.5.59
-- PHP のバージョン: 5.3.28

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- データベース: `amaraimusi_dbof`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `tbl_sample`
--

CREATE TABLE IF NOT EXISTS `tbl_sample` (
  `id` int(6) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `fname` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lon` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータをダンプしています `tbl_sample`
--

INSERT INTO `tbl_sample` (`id`, `name`, `fname`, `lat`, `lon`) VALUES
(1, 'aaa', 'テスト.PDF', 35.180332817, 136.90677166);
