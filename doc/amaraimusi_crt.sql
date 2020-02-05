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
-- データベース: `amaraimusi_crt`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `PhotoTbl`
--

CREATE TABLE IF NOT EXISTS `PhotoTbl` (
  `Id` int(11) NOT NULL,
  `RecId` int(11) NOT NULL,
  `SmryId` int(11) NOT NULL,
  `SmallFn` varchar(255) DEFAULT NULL,
  `MiddleFn` varchar(255) DEFAULT NULL,
  `RealFn` varchar(255) DEFAULT NULL,
  `PhotoText` text,
  PRIMARY KEY (`Id`,`RecId`,`SmryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータをダンプしています `PhotoTbl`
--


-- --------------------------------------------------------

--
-- テーブルの構造 `RecSmryTbl`
--

CREATE TABLE IF NOT EXISTS `RecSmryTbl` (
  `Id` int(11) NOT NULL,
  `RecName` varchar(255) DEFAULT NULL,
  `Category` varchar(32) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `UpdateDate` date DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータをダンプしています `RecSmryTbl`
--

INSERT INTO `RecSmryTbl` (`Id`, `RecName`, `Category`, `StartDate`, `UpdateDate`) VALUES
(1, 'トマトの観察記録【2013】', '野菜', '2013-10-30', '2013-11-07'),
(2, 'ヘテランヘラの観察記録', '水草', '2013-10-31', '2013-11-08'),
(3, 'ティモの観察記録', 'ペット', '2013-11-01', '2013-11-09'),
(4, 'ミニビオトープ', 'アクアリウム', '2013-11-02', '2013-11-10');

-- --------------------------------------------------------

--
-- テーブルの構造 `RecTbl`
--

CREATE TABLE IF NOT EXISTS `RecTbl` (
  `Id` int(11) NOT NULL,
  `SmryId` int(11) NOT NULL,
  `RecDate` date DEFAULT NULL,
  `Text` text,
  `RealPicFn` varchar(255) DEFAULT NULL,
  `MiddlePicFn` varchar(255) DEFAULT NULL,
  `SmallPicFn` varchar(255) DEFAULT NULL,
  `Lat` double DEFAULT NULL,
  `Lon` double DEFAULT NULL,
  `Temper` double DEFAULT NULL,
  PRIMARY KEY (`Id`,`SmryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータをダンプしています `RecTbl`
--


-- --------------------------------------------------------

--
-- テーブルの構造 `UserTbl`
--

CREATE TABLE IF NOT EXISTS `UserTbl` (
  `UserId` varchar(32) NOT NULL,
  `Password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- テーブルのデータをダンプしています `UserTbl`
--

