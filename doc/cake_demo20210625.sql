-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- ホスト: mysql716.db.sakura.ne.jp
-- 生成日時: 2021 年 6 月 25 日 00:07
-- サーバのバージョン： 5.7.32-log
-- PHP のバージョン: 7.1.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `amaraimusi_cake_demo`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `app_configs`
--

CREATE TABLE `app_configs` (
  `id` int(11) NOT NULL,
  `key_code` varchar(50) NOT NULL COMMENT 'キー',
  `val1` int(11) DEFAULT NULL COMMENT '値1',
  `text1` varchar(1000) DEFAULT NULL COMMENT 'テキスト1',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新者',
  `ip_addr` varchar(40) DEFAULT NULL COMMENT 'IPアドレス',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `app_configs`
--

INSERT INTO `app_configs` (`id`, `key_code`, `val1`, `text1`, `update_user`, `ip_addr`, `modified`) VALUES
(1, 'apy_type_id_google', 1, NULL, NULL, NULL, '2019-05-28 11:44:57'),
(2, 'apy_type_id_yahoo', 2, NULL, NULL, NULL, '2019-05-28 11:49:51');

-- --------------------------------------------------------

--
-- テーブルの構造 `app_scopes`
--

CREATE TABLE `app_scopes` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `var_name` varchar(16) NOT NULL COMMENT '変数名',
  `value1` varchar(256) DEFAULT NULL COMMENT '値',
  `note` varchar(32) DEFAULT NULL COMMENT '説明'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='アプリケーションスコープテーブル';

--
-- テーブルのデータのダンプ `app_scopes`
--

INSERT INTO `app_scopes` (`id`, `var_name`, `value1`, `note`) VALUES
(1, 'neko_val', '\'', 'テストネコ値'),
(2, 'twu_interval', '15', '窓口更新ワーカー・実行間隔【秒】'),
(3, 'gc_last_msg_dt', '2015-11-02 13:24:10', 'ゲストチャット・最終メッセージ日時');

-- --------------------------------------------------------

--
-- テーブルの構造 `configs`
--

CREATE TABLE `configs` (
  `id` int(11) NOT NULL,
  `group_key` varchar(64) DEFAULT NULL COMMENT 'グループキー',
  `config_key` varchar(64) DEFAULT NULL COMMENT 'キー',
  `config_value` varchar(1000) DEFAULT NULL COMMENT '設定値',
  `note` varchar(1000) DEFAULT NULL COMMENT '値の説明',
  `sort_no` int(11) DEFAULT '0' COMMENT '順番',
  `delete_flg` tinyint(1) DEFAULT '0' COMMENT '無効フラグ',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新者',
  `ip_addr` varchar(40) DEFAULT NULL COMMENT 'IPアドレス',
  `created` datetime DEFAULT NULL COMMENT '生成日時',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='設定';

--
-- テーブルのデータのダンプ `configs`
--

INSERT INTO `configs` (`id`, `group_key`, `config_key`, `config_value`, `note`, `sort_no`, `delete_flg`, `update_user`, `ip_addr`, `created`, `modified`) VALUES
(20, 'signin_x', 'mail_title1', 'cake_demo 登録URLのご案内', 'サインインの仮登録メールの件名を入力します。', -2, 0, '', '', '2021-04-25 10:12:40', '2021-04-25 01:15:18'),
(21, 'signin_x', 'mail_title1_repw', 'cake_demo パスワード再発行URLのご案内', 'サインインのパスワード再発行・仮登録メールの件名を入力します。', -2, 0, NULL, NULL, '2021-04-24 23:24:15', '2021-04-25 01:16:33'),
(22, 'signin_x', 'mail_text1', 'cake_demo見本システムです。\n\n申請ありがとうございます。\nまだ登録は完了しておりません。\n引き続き、下記URLからお手続きを進めてください。\n\n%url\n\n■上記URLの有効期限は%datetimeまでです。\n　有効期限を過ぎた場合は、お手数ですがメールアドレス入力から再度お手続きをお願いします。\n\n本メールはcake_demoシステムより自動配信しています。\nご返信いただきましても対応いたしかねますので、あらかじめご了承ください。\nもしお心当たりのない場合、本メールは破棄して頂けるようお願いいたします。', 'サインインのパスワード再発行用の仮登録メールの本文です。\n「%url」と記述すると本登録URLがメールの分に表示されます。\n「%datetime」は有効時間を表示します。', -1, 0, '', '', '2021-04-22 23:00:17', '2021-04-25 01:19:52'),
(23, 'signin_x', 'mail_text1_repw', 'cake_demo見本システムです。\n\nパスワード再発行の確認メールです。\n引き続き、下記URLからお手続きを進めてください。\n\n%url\n\n■上記URLの有効期限は%datetimeまでです。\n　有効期限を過ぎた場合は、お手数ですがメールアドレス入力から再度お手続きをお願いします。\n\n本メールはcake_demoシステムより自動配信しています。\nご返信いただきましても対応いたしかねますので、あらかじめご了承ください。\nもしお心当たりのない場合、本メールは破棄して頂けるようお願いいたします。', 'サインインの仮登録メールの本文です。\n「%url」と記述すると本登録URLがメールの分に表示されます。\n「%datetime」は有効時間を表示します。', -1, 0, NULL, NULL, '2021-04-24 23:28:48', '2021-04-25 01:27:08'),
(24, 'signin_x', 'mail_title2', 'cake_demo 登録完了しました', 'サインインの登録完了メールの件名を入力します。', -2, 0, NULL, NULL, '2021-04-24 19:27:45', '2021-04-25 01:30:00'),
(25, 'signin_x', 'mail_title2_repw', 'cake_demo パスワードを変更', 'サインインの登録完了メールの件名を入力します。', -2, 0, NULL, NULL, '2021-04-24 23:30:23', '2021-04-25 01:30:36'),
(26, 'signin_x', 'mail_text2', '%name 様\n\ncake_demoシステムです。\n登録完了しました。\n以上で全てのお手続きは終了です。\n\n本メールは配信専用になっております。\nご返信いただきましても対応いたしかねますので、あらかじめご了承ください。\n本メールにお心当たりがない場合は、メールを削除いただきますようお願いいたします。', 'サインインの登録完了の本文です。\n「%name」と記述すると名前(nickname)がメール本文に表示されます。', -1, 0, NULL, NULL, '2021-04-24 19:27:02', '2021-04-25 01:32:10'),
(27, 'signin_x', 'mail_text2_repw', '%name 様\n\ncake_demoシステムです。\nパスワードを変更しました。\n\n本メールは配信専用になっております。\nご返信いただきましても対応いたしかねますので、あらかじめご了承ください。\n本メールにお心当たりがない場合は、メールを削除いただきますようお願いいたします。', 'サインインの登録完了の本文です。\n「%name」と記述すると名前(nickname)がメール本文に表示されます。', -1, 0, NULL, NULL, '2021-04-24 23:31:29', '2021-04-25 01:33:16'),
(28, 'signin_x', 'limit_time', '4', '仮登録メール送信後の制限時間。時単位で設定。', -3, 0, '', '', '2021-04-25 10:35:32', '2021-04-25 01:35:32');

-- --------------------------------------------------------

--
-- テーブルの構造 `en_sps`
--

CREATE TABLE `en_sps` (
  `id` int(11) NOT NULL,
  `bio_cls_id` int(11) DEFAULT NULL COMMENT '綱ID',
  `family_name` varchar(255) DEFAULT NULL COMMENT '科',
  `wamei` varchar(255) DEFAULT NULL COMMENT '和名',
  `scien_name` varchar(225) DEFAULT NULL COMMENT '学名',
  `en_ctg_id` int(11) DEFAULT '0' COMMENT '絶滅危惧種カテゴリーID',
  `endemic_sp_flg` tinyint(4) DEFAULT '0' COMMENT '固有種フラグ',
  `note` text NOT NULL COMMENT '備考',
  `sort_no` int(11) DEFAULT '0' COMMENT '順番',
  `delete_flg` tinyint(1) DEFAULT '0' COMMENT '無効フラグ',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新者',
  `ip_addr` varchar(40) DEFAULT NULL COMMENT 'IPアドレス',
  `created` datetime DEFAULT NULL COMMENT '生成日時',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='en_sps Endangered species(絶滅危惧生物テーブル)';

--
-- テーブルのデータのダンプ `en_sps`
--

INSERT INTO `en_sps` (`id`, `bio_cls_id`, `family_name`, `wamei`, `scien_name`, `en_ctg_id`, `endemic_sp_flg`, `note`, `sort_no`, `delete_flg`, `update_user`, `ip_addr`, `created`, `modified`) VALUES
(1, 4, 'サンショウウオ', 'アベサンショウウオ', 'Hynobius abei', 7, 0, '', 5, 0, 'kani', '::1', NULL, '2018-09-02 13:47:27'),
(2, 4, 'サンショウウオ', 'アカイシサンショウウオ', 'Hynobius katoi', 8, 0, '', 6, 0, '', '', NULL, '2018-09-01 11:20:37'),
(3, 4, 'サンショウウオ', 'ハクバサンショウウオ', 'Hynobius hidamontanus', 8, 0, '', 7, 0, '', '', NULL, '2018-09-01 11:20:37'),
(4, 4, 'サンショウウオ', 'ホクリクサンショウウオ', 'Hynobius takedai', 8, 0, '', 8, 0, '', '', NULL, '2018-09-01 11:20:37'),
(5, 4, 'サンショウウオ', 'オオイタサンショウウオ', 'Hynobius dunni', 9, 0, '1997年版から、「高知県のオオイタサンショウウオ個体群」も含む。', 9, 0, '', '', NULL, '2018-09-01 11:20:37'),
(6, 4, 'サンショウウオ', 'オオダイガハラサンショウウオ', 'Hynobius boulengeri', 9, 0, '1997年版まで、「本州・九州地域のオオダイガハラサンショウウオ個体群」を評価単位としていた。', 10, 0, '', '', NULL, '2018-09-01 11:20:37'),
(7, 4, 'サンショウウオ', 'オキサンショウウオ', 'Hynobius okiensis', 9, 0, '', 11, 0, '', '', NULL, '2018-09-01 11:20:37'),
(8, 4, 'サンショウウオ', 'カスミサンショウウオ', 'Hynobius nebulosus', 9, 0, '1997年版まで、「京都・大阪地域のカスミサンショウウオ個体群」を評価単位としていた。さらに、「愛知県のトウキョウサンショウウオ個体群」も分類の変更により含まれる。', 12, 0, '', '', NULL, '2018-09-01 11:20:37'),
(9, 4, 'サンショウウオ', 'トウキョウサンショウウオ', 'Hynobius tokyoensis', 9, 0, '1997年版まで、「東京都のトウキョウサンショウウオ個体群」を評価単位としていた。', 13, 0, '', '', NULL, '2018-09-01 11:20:37'),
(10, 4, 'サンショウウオ', 'ベッコウサンショウウオ', 'Hynobius stejnegeri', 9, 0, '', 14, 0, '', '', NULL, '2018-09-01 11:20:37'),
(11, 4, 'サンショウウオ', 'キタサンショウウオ', 'Salamandrella keyserlingii', 4, 0, '', 15, 0, '', '', NULL, '2018-09-01 11:20:37'),
(12, 4, 'サンショウウオ', 'イシヅチサンショウウオ', 'Hynobius hirosei', 4, 0, 'オオダイガハラサンショウウオ四国個体群とされていたものが独立種となった。', 16, 0, '', '', NULL, '2018-09-01 11:20:37'),
(13, 4, 'サンショウウオ', 'クロサンショウウオ', 'Hynobius nigrescens', 4, 0, '', 17, 0, '', '', NULL, '2018-09-01 11:20:37'),
(14, 4, 'サンショウウオ', 'コガタブチサンショウウオ', 'Hynobius yatsui', 4, 0, 'ブチサンショウウオの山地小型個体群とされていたものが独立種となった', 18, 0, '', '', NULL, '2018-09-01 11:20:37'),
(15, 4, 'サンショウウオ', 'ツシマサンショウウオ', 'Hynobius tsuensis', 4, 0, '', 19, 0, '', '', NULL, '2018-09-01 11:20:37'),
(16, 4, 'サンショウウオ', 'トウホクサンショウウオ', 'Hynobius lichenatus', 4, 0, '', 20, 0, '', '', NULL, '2018-09-01 11:20:37'),
(17, 4, 'サンショウウオ', 'ヒダサンショウウオ', 'Hynobius kimurae', 4, 0, '', 21, 0, '', '', NULL, '2018-09-01 11:20:37'),
(18, 4, 'サンショウウオ', 'ブチサンショウウオ', 'Hynobius naevius', 4, 0, '', 22, 0, '', '', NULL, '2018-09-01 11:20:37'),
(19, 4, 'サンショウウオ', 'エゾサンショウウオ', 'Hynobius retardatus', 5, 0, '', 23, 0, '', '', NULL, '2018-09-01 11:20:37'),
(20, 4, 'オオサンショウウオ', 'オオサンショウウオ', 'Andrias japonicus', 9, 0, '', 24, 0, '', '', NULL, '2018-09-01 11:20:37'),
(21, 4, 'イモリ', 'イボイモリ', 'Echinotriton andersoni', 9, 0, '', 25, 0, '', '', NULL, '2018-09-01 11:20:37'),
(22, 4, 'イモリ', 'アカハライモリ', 'Cynops pyrrhogaster', 4, 0, '', 26, 0, '', '', NULL, '2018-09-01 11:20:37'),
(23, 4, 'イモリ', 'シリケンイモリ', 'Cynops ensicauda', 4, 0, '', 27, 0, '', '', NULL, '2018-09-01 11:20:37'),
(24, 4, 'ヒキガエル', 'ミヤコヒキガエル', 'Bufo gargarizans miyakonis', 4, 0, '', 28, 0, '', '', NULL, '2018-09-01 11:20:37'),
(25, 4, 'アカガエル', 'アマミイシカワガエル', 'Odorrana splendida', 8, 0, 'イシカワガエルの奄美大島個体群とされていたものが独立種となった。', 29, 0, '', '', NULL, '2018-09-01 11:20:37'),
(26, 4, 'アカガエル', 'オキナワイシカワガエル', 'Odorrana ishikawae', 8, 0, '2006年版まで、和名をイシカワガエルとしていた。アマミイシカワガエル備考欄の理由により沖縄島個体群のみがO. ishikawaeとなり、それに伴い和名が変更された。', 30, 0, '', '', NULL, '2018-09-01 11:20:37'),
(27, 4, 'アカガエル', 'コガタハナサキガエル', 'Odorrana utsunomiyaorum', 8, 0, '', 31, 0, '', '', NULL, '2018-09-01 11:20:37'),
(28, 4, 'アカガエル', 'オットンガエル', 'Babina subaspera', 8, 0, '', 32, 0, '', '', NULL, '2018-09-01 11:20:37'),
(29, 4, 'アカガエル', 'ナゴヤダルマガエル', 'Rana porosa brevipoda', 8, 0, '1997年版まで、和名をダルマガエルとしていた。', 33, 0, '', '', NULL, '2018-09-01 11:20:37'),
(30, 4, 'アカガエル', 'ナミエガエル', 'Limnonectes namiyei', 8, 0, '', 34, 0, '', '', NULL, '2018-09-01 11:20:37'),
(31, 4, 'アカガエル', 'ホルストガエル', 'Babina holsti', 8, 0, '', 35, 0, '', '', NULL, '2018-09-01 11:20:37'),
(32, 4, 'アカガエル', 'アマミハナサキガエル', 'Odorrana amamiensis', 9, 0, '', 36, 0, '', '', NULL, '2018-09-01 11:20:37'),
(33, 4, 'アカガエル', 'ハナサキガエル', 'Odorrana narina', 9, 0, '', 37, 0, '', '', NULL, '2018-09-01 11:20:37'),
(34, 4, 'アカガエル', 'ヤエヤマハラブチガエル', 'Rana okinavana', 9, 0, '2006年版まで学名がRana psaltesだったが、リュウキュウアカガエルの学名とされていたR. okinavanaの模式標本がヤエヤマハラブチガエルであったことが判明したため学名が変更された。', 38, 0, '', '', NULL, '2018-09-01 11:20:37'),
(35, 4, 'アカガエル', 'アマミアカガエル', 'Rana kobai', 4, 0, 'リュウキュウアカガエルの奄美諸島個体群とされていたものが独立種となった', 39, 0, '', '', NULL, '2018-09-01 11:20:37'),
(36, 4, 'アカガエル', 'オキタゴガエル', 'Rana tagoi okiensis', 4, 0, '', 40, 0, '', '', NULL, '2018-09-01 11:20:37'),
(37, 4, 'アカガエル', 'ヤクシマタゴガエル', 'Rana tagoi yakushimensis', 4, 0, '', 41, 0, '', '', NULL, '2018-09-01 11:20:37'),
(38, 4, 'アカガエル', 'トウキョウダルマガエル', 'Rana porosa porosa', 4, 0, '', 42, 0, '', '', NULL, '2018-09-01 11:20:37'),
(39, 4, 'アカガエル', 'チョウセンヤマアカガエル', 'Rana dybowskii', 4, 0, '', 43, 0, '', '', NULL, '2018-09-01 11:20:37'),
(40, 4, 'アカガエル', 'ツシマアカガエル', 'Rana tsushimensis', 4, 0, '', 44, 0, '', '', NULL, '2018-09-01 11:20:37'),
(41, 4, 'アカガエル', 'トノサマガエル', 'Rana nigromaculata', 4, 0, '', 45, 0, '', '', NULL, '2018-09-01 11:20:37'),
(42, 4, 'アカガエル', 'リュウキュウアカガエル', 'Rana ulma', 4, 0, '2006年版まで学名がRana okinavanaだったが、R. okinavanaの模式標本がヤエヤマハラブチガエルであったことが判明したため改めて新種として記載された。', 46, 0, '', '', NULL, '2018-09-01 11:20:37'),
(43, 2, 'ウミガメ', 'アカウミガメ', 'Caretta caretta', 8, 0, '', 47, 0, '', '', NULL, '2018-09-01 11:20:37'),
(44, 2, 'ウミガメ', 'タイマイ', 'Eretmochelys imbricata', 8, 0, '', 48, 0, '', '', NULL, '2018-09-01 11:20:37'),
(45, 2, 'ウミガメ', 'アオウミガメ', 'Chelonia mydas mydas', 9, 0, '', 49, 0, '', '', NULL, '2018-09-01 11:20:37'),
(46, 2, 'イシガメ', 'ヤエヤマセマルハコガメ', 'Cuora flavomarginata evelynae', 9, 0, '1997年版まで、和名をセマルハコガメとしていた。', 50, 0, '', '', NULL, '2018-09-01 11:20:37'),
(47, 2, 'イシガメ', 'リュウキュウヤマガメ', 'Geoemyda japonica', 9, 0, '', 49, 0, '', '', NULL, '2018-09-01 11:20:37'),
(48, 2, 'イシガメ', 'ニホンイシガメ', 'Mauremys japonica', 4, 0, '', 50, 0, '', '', NULL, '2018-09-01 11:20:37'),
(49, 2, 'スッポン', 'ニホンスッポン', 'Pelodiscus sinensis', 5, 0, '1997年版までスッポンを、2006年版ではP. s. japonicusとして評価していた。', 50, 0, '', '', NULL, '2018-09-01 11:20:37'),
(50, 2, 'トカゲモドキ', 'イヘヤトカゲモドキ', 'Goniurosaurus kuroiwae toyamai', 7, 0, '1991年版では、種クロイワトカゲモドキとして評価していた。', 50, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(51, 2, 'トカゲモドキ', 'クメトカゲモドキ', 'Goniurosaurus kuroiwae yamashinae', 7, 0, '1991年版では、種クロイワトカゲモドキとして評価していた。', 51, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(52, 2, 'トカゲモドキ', 'オビトカゲモドキ', 'Goniurosaurus kuroiwae splendens', 8, 0, '1991年版では、種クロイワトカゲモドキとして評価していた。', 52, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(53, 2, 'トカゲモドキ', 'マダラトカゲモドキ', 'GGoniurosaurus kuroiwae orientalis', 8, 0, '1991年版では、種クロイワトカゲモドキとして評価していた。', 53, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(54, 2, 'トカゲモドキ', 'クロイワトカゲモドキ', 'Goniurosaurus kuroiwae kuroiwae', 9, 0, '', 54, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(55, 2, 'ヤモリ', 'ミナミトリシマヤモリ', 'Perochirus ateles', 9, 0, '', 55, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(56, 2, 'ヤモリ', 'タシロヤモリ', 'Hemidactylus bowringii', 9, 0, '', 56, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(57, 2, 'ヤモリ', 'ヤクヤモリ', 'Gekko yakuensis', 9, 0, '', 57, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(58, 2, 'ヤモリ', 'オキナワヤモリ', 'Gekko sp. 1', 4, 0, '', 58, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(59, 2, 'ヤモリ', 'タカラヤモリ', 'Gekko shibatai', 4, 0, '', 59, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(60, 2, 'ヤモリ', 'タワヤモリ', 'Gekko tawaensis', 4, 0, '', 60, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(61, 2, 'ヤモリ', '大東諸島のオガサワラヤモリ', 'Lepidodactylus lugubrisi', 12, 0, '', 61, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(62, 2, 'アガマ', 'オキナワキノボリトカゲ', 'Japalura polygonata polygonata', 9, 0, '1997年版まで、和名をキノボリトカゲとしていた。', 62, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(63, 2, 'アガマ', 'ヨナグニキノボリトカゲ', 'Japalura polygonata donan', 9, 0, '', 63, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(64, 2, 'アガマ', 'サキシマキノボリトカゲ', 'Japalura polygonata ishigakiensis', 4, 0, '', 64, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(65, 2, 'カナヘビ', 'ミヤコカナヘビ', 'Takydromus toyamai', 7, 0, '', 65, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(66, 2, 'カナヘビ', 'サキシマカナヘビ', 'Takydromus dorsalis', 9, 0, '', 66, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(67, 2, 'カナヘビ', 'コモチカナヘビ', 'Zootoca vivipara', 9, 0, '', 67, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(68, 2, 'カナヘビ', 'アムールカナヘビ', 'Takydromus amurensis', 4, 0, '', 68, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(69, 2, 'カナヘビ', '沖永良部島、徳之島のアオカナヘビ', 'Takydromus smaragdinusi', 12, 0, '', 69, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(70, 2, 'ナミヘビ', 'キクザトサワヘビ', 'Opisthotropis kikuzatoi', 7, 0, '', 70, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(71, 2, 'ナミヘビ', 'シュウダ', 'Elaphe carinata carinata', 8, 0, '', 71, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(72, 2, 'ナミヘビ', 'ヨナグニシュウダ', 'Elaphe carinata yonaguniensis', 8, 0, '', 72, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(73, 2, 'ナミヘビ', 'ミヤコヒバァ', 'Amphiesma concelarum', 8, 0, '', 73, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(74, 2, 'ナミヘビ', 'ミヤコヒメヘビ', 'Calamaria pfefferi', 8, 0, '1997年版まで、和名をヒメヘビとしていた。', 74, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(75, 2, 'ナミヘビ', 'ヤエヤマタカチホヘビ', 'Achalinus formosanus chigiraii', 9, 0, '', 75, 0, NULL, NULL, NULL, '2018-09-01 11:20:37'),
(76, 2, 'ナミヘビ', 'サキシマスジオ', 'Elaphe taeniura schmackeri', 9, 0, '', 76, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(77, 2, 'ナミヘビ', 'ミヤラヒメヘビ', 'Calamaria pavimentata miyarai', 9, 0, '', 77, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(78, 2, 'ナミヘビ', 'サキシマアオヘビ', 'Cyclophiops herminaei', 4, 0, '', 78, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(79, 2, 'ナミヘビ', 'サキシマバイカダ', 'Lycodon ruhstrati multifasciatusi', 4, 0, '', 79, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(80, 2, 'ナミヘビ', 'イワサキセダカヘビ', 'Pareas iwasakiii', 4, 0, '', 80, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(81, 2, 'ナミヘビ', 'アマミタカチホヘビ', 'Achalinus wernerii', 4, 0, '', 81, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(82, 2, 'ナミヘビ', 'アカマダラ', 'Dinodon rufozonatum rufozonatumi', 4, 0, '', 82, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(83, 2, 'ナミヘビ', 'ダンジョヒバカリ', 'Amphiesma vibakari danjoense', 5, 0, '', 83, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(84, 2, 'ナミヘビ', '宮古諸島のサキシママダラ', 'Dinodon rufozonatum walli', 12, 0, '', 84, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(85, 2, 'コブラ', 'クメジマハイ', 'Sinomicrurus japonicus takarai', 9, 0, '', 85, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(86, 2, 'コブラ', 'イワサキワモンベニヘビ', 'Hemibungarus macclellandi iwasakii', 9, 0, '', 86, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(87, 2, 'コブラ', 'ハイ', 'Sinomicrurus japonicus boettgeri', 4, 0, '', 87, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(88, 2, 'コブラ', 'ヒャン', 'Sinomicrurus japonicus japonicus', 4, 0, '', 88, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(89, 2, 'ウミヘビ', 'エラブウミヘビ', 'Laticauda semifasciata', 9, 0, '', 89, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(90, 2, 'ウミヘビ', 'ヒロオウミヘビ', 'Laticauda laticaudata', 9, 0, '', 90, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(91, 2, 'ウミヘビ', 'イイジマウミヘビ', 'Emydocephalus ijimae', 9, 0, '', 91, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(92, 2, 'クサリヘビ', 'トカラハブ', 'Protobothrops tokarensis', 4, 0, '', 92, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(93, 1, 'カイツブリ', '青森県のカンムリカイツブリ繁殖個体群', 'Podiceps cristatus cristatus', 12, 0, '', 93, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(94, 1, 'アホウドリ', 'コアホウドリ', 'Diomedea immutabilis', 8, 0, '', 94, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(95, 1, 'アホウドリ', 'アホウドリ', 'Diomedea albatrus', 9, 0, '', 95, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(96, 1, 'ミズナギドリ', 'オガサワラヒメミズナギドリ', 'Puffinus bryani', 7, 0, '', 96, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(97, 1, 'ミズナギドリ', 'セグロミズナギドリ', 'Puffinus lherminieri bannermani', 8, 1, '', 97, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(98, 1, 'ミズナギドリ', 'シロハラミズナギドリ', 'Pterodroma hypoleuca', 5, 0, '', 98, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(99, 1, 'ウミツバメ', 'クロコシジロウミツバメ', 'Oceanodroma castro', 7, 0, '', 99, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(100, 1, 'ウミツバメ', 'ヒメクロウミツバメ', 'Oceanodroma monorhis', 9, 0, '', 100, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(101, 1, 'ウミツバメ', 'オーストンウミツバメ', 'Oceanodroma tristrami', 4, 0, '', 101, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(102, 1, 'ウミツバメ', 'クロウミツバメ', 'Oceanodroma matsudairae', 4, 0, '', 102, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(103, 1, 'ネッタイチョウ', 'アカオネッタイチョウ', 'Phaethon rubricauda rothschildi', 8, 1, '', 103, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(104, 1, 'カツオドリ', 'アカアシカツオドリ', 'Sula sula rubripes', 8, 1, '', 104, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(105, 1, 'カツオドリ', 'アオツラカツオドリ', 'Sula dactylatra personata', 9, 0, '', 105, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(106, 1, 'ウ', 'チシマウガラス', 'Phalacrocorax urile', 7, 0, '', 106, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(107, 1, 'ウ', 'ヒメウ', 'Phalacrocorax pelagicus pelagicus', 8, 0, '', 107, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(108, 1, 'サギ', 'ハシブトゴイ', 'Nycticorax caledonicus crassirostris', 6, 0, '', 108, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(109, 1, 'サギ', 'オオヨシゴイ', 'Ixobrychus eurhythmus', 7, 0, '', 109, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(110, 1, 'サギ', 'サンカノゴイ', 'Botaurus stellaris stellaris', 8, 1, '', 110, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(111, 1, 'サギ', 'ミゾゴイ', 'Gorsachius goisagi', 9, 0, '', 111, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(112, 1, 'サギ', 'ズグロミゾゴイ', 'Gorsachius melanolophus', 9, 0, '', 112, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(113, 1, 'サギ', 'ヨシゴイ', 'Ixobrychus sinensis sinensis', 4, 0, '', 113, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(114, 1, 'サギ', 'チュウサギ', 'Egretta intermedia intermedia', 4, 0, '', 114, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(115, 1, 'サギ', 'カラシラサギ', 'Egretta eulophotes', 4, 0, '', 115, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(116, 1, 'コウノトリ', 'コウノトリ', 'Ciconia boyciana', 7, 0, '', 116, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(117, 1, 'コウノトリ', 'ナベコウ', 'Ciconia nigra', 2, 0, '', 117, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(118, 1, 'トキ', 'トキ', 'Nipponia nippon', 13, 0, '', 118, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(119, 1, 'トキ', 'クロツラヘラサギ', 'Platalea minor', 8, 0, '', 119, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(120, 1, 'トキ', 'ヘラサギ', 'Platalea leucorodia major', 5, 0, '', 120, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(121, 1, 'トキ', 'クロトキ', 'Threskiornis melanocephalus', 5, 0, '', 121, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(122, 1, 'カモ', 'カンムリツクシガモ', 'Tadorna cristata', 6, 0, '', 122, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(123, 1, 'カモ', 'シジュウカラガン', 'Branta canadensis leucopareia', 7, 0, '', 123, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(124, 1, 'カモ', 'ハクガン', 'Anser caerulescens caerulescens', 7, 0, '', 124, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(125, 1, 'カモ', 'カリガネ', 'Anser erythropus', 8, 0, '', 125, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(126, 1, 'カモ', 'コクガン', 'Branta bernicla orientalis', 9, 0, '', 126, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(127, 1, 'カモ', 'ヒシクイ', 'Anser fabalis serrirostris', 9, 0, '', 127, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(128, 1, 'カモ', 'ツクシガモ', 'Tadorna tadorna', 9, 0, '', 128, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(129, 1, 'カモ', 'トモエガモ', 'Anas formosa', 9, 0, '', 129, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(130, 1, 'カモ', 'マガン', 'Anser albifrons frontalis', 4, 0, '', 130, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(131, 1, 'カモ', 'オオヒシクイ', 'Anser fabalis middendorffii', 4, 0, '', 131, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(132, 1, 'カモ', 'サカツラガン', 'Anser cygnoides', 5, 0, '', 132, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(133, 1, 'カモ', 'アカツクシガモ', 'Tadorna ferruginea', 5, 0, '', 133, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(134, 1, 'カモ', 'オシドリ', 'Aix galericulata', 5, 0, '', 134, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(135, 1, 'カモ', 'アカハジロ', 'Aythya baeri', 5, 0, '', 135, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(136, 1, 'カモ', '東北地方以北のシノリガモ繁殖個体群', 'Histrionicus histrionicus pacificus', 12, 0, '', 136, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(137, 1, 'カモ', 'コハクチョウ', 'Cygnus columbianus jankowskii', 2, 0, '', 137, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(138, 1, 'カモ', 'コウライアイサ', 'Mergus squamatus', 5, 0, '', 138, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(139, 1, 'タカ', 'ダイトウノスリ', 'Buteo buteo oshiroi', 6, 1, '', 139, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(140, 1, 'タカ', 'カンムリワシ', 'Spilornis cheela perplexus', 7, 1, '', 140, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(141, 1, 'タカ', 'オジロワシ', 'Haliaeetus albicilla albicilla', 9, 0, '', 141, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(142, 1, 'タカ', 'リュウキュウツミ', 'Accipiter gularis iwasakii', 8, 1, '', 142, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(143, 1, 'タカ', 'オガサワラノスリ', 'Buteo buteo toyoshimai', 8, 1, '', 143, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(144, 1, 'タカ', 'クマタカ', 'Spizaetus nipalensis orientalis', 8, 0, '', 144, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(145, 1, 'タカ', 'イヌワシ', 'Aquila chrysaetos japonica', 8, 0, '', 145, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(146, 1, 'タカ', 'チュウヒ', 'Circus spilonotus spilonotus', 8, 0, '', 146, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(147, 1, 'タカ', 'オオワシ', 'Haliaeetus pelagicus pelagicus', 9, 0, '', 147, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(148, 1, 'タカ', 'サシバ', 'Butastur indicus', 9, 0, '', 148, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(149, 1, 'タカ', 'ミサゴ', 'Pandion haliaetus haliaetus', 4, 0, '', 149, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(150, 1, 'タカ', 'ハチクマ', 'Pernis apivorus orientalis', 4, 0, '', 150, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(151, 1, 'タカ', 'オオタカ', 'Accipiter gentilis fujiyamae', 4, 0, '', 151, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(152, 1, 'タカ', 'ハイタカ', 'Accipiter nisus nisosimilis', 4, 0, '', 152, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(153, 1, 'ハヤブサ', 'ハヤブサ', 'Falco peregrinus japonensis', 9, 1, '', 153, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(154, 1, 'ハヤブサ', 'シマハヤブサ', 'Falco peregrinus furuitii', 5, 1, '', 154, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(155, 1, 'ハヤブサ', 'オオハヤブサ', 'Falco peregrinus pealei', 5, 0, '', 155, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(156, 1, 'ハヤブサ', 'シベリアハヤブサ', 'Falco peregrinus harterti', 2, 0, '', 156, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(157, 1, 'ライチョウ', 'ライチョウ', 'Lagopus mutus japonicus', 8, 1, '', 157, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(158, 1, 'ライチョウ', 'エゾライチョウ', 'Tetrastes bonasia vicinitas', 5, 0, '', 158, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(159, 1, 'キジ', 'ウズラ', 'Coturnix japonica', 9, 0, '', 159, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(160, 1, 'キジ', 'アカヤマドリ', 'Syrmaticus soemmerringii soemmerringii', 4, 1, '', 160, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(161, 1, 'キジ', 'コシジロヤマドリ', 'Syrmaticus soemmerringii ijimae', 4, 1, '', 161, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(162, 1, 'ツル', 'タンチョウ', 'Grus japonensis', 9, 0, '', 162, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(163, 1, 'ツル', 'ナベヅル', 'Grus monacha', 9, 0, '', 163, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(164, 1, 'ツル', 'マナヅル', 'Grus vipio', 9, 0, '', 164, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(165, 1, 'ツル', 'クロヅル', 'Grus grus lilfordi', 5, 0, '', 165, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(166, 1, 'ツル', 'カナダヅル', 'Grus canadensis canadensis', 2, 0, '', 166, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(167, 1, 'ツル', 'ソデグロヅル', 'Grus leucogeranus', 2, 0, '', 167, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(168, 1, 'ツル', 'アネハヅル', 'Anthropoides virgo', 2, 0, '', 168, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(169, 1, 'クイナ', 'マミジロクイナ', 'Poliolimnas cinereus brevipes', 6, 1, '', 169, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(170, 1, 'クイナ', 'ヤンバルクイナ', 'Gallirallus okinawae', 7, 1, '', 170, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(171, 1, 'クイナ', 'オオクイナ', 'Rallina eurizonoides sepiaria', 8, 1, '', 171, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(172, 1, 'クイナ', 'シマクイナ', 'Coturnicops noveboracensis exquisitus', 8, 0, '', 172, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(173, 1, 'クイナ', 'ヒクイナ', 'Porzana fusca erythrothorax', 4, 0, '', 173, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(174, 1, 'ノガン', 'ノガン', 'Otis tarda dybowskii', 2, 0, '', 174, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(175, 1, 'タマシギ', 'タマシギ', 'Rostratula benghalensis benghalensis', 9, 0, '', 175, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(176, 1, 'チドリ', 'シロチドリ', 'Charadrius alexandrinus', 9, 0, '', 176, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(177, 1, 'シギ', 'ヘラシギ', 'Eurynorhynchus pygmeus', 7, 0, '', 177, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(178, 1, 'シギ', 'カラフトアオアシシギ', 'Tringa guttifer', 7, 0, '', 178, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(179, 1, 'シギ', 'コシャクシギ', 'Numenius minutus', 8, 0, '', 179, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(180, 1, 'シギ', 'ツルシギ', 'Tringa erythropus', 9, 0, '', 180, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(181, 1, 'シギ', 'アカアシシギ', 'Tringa totanus ussuriensis', 9, 0, '', 181, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(182, 1, 'シギ', 'タカブシギ', 'Tringa glareola', 9, 0, '', 182, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(183, 1, 'シギ', 'オオソリハシシギ', 'Limosa lapponica', 9, 0, '', 183, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(184, 1, 'シギ', 'ホウロクシギ', 'Numenius madagascariensis', 9, 0, '', 184, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(185, 1, 'シギ', 'アマミヤマシギ', 'Scolopax mira', 9, 1, '', 185, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(186, 1, 'シギ', 'ハマシギ', 'Calidris alpina', 4, 0, '', 186, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(187, 1, 'シギ', 'オオジシギ', 'Gallinago hardwickii', 4, 0, '', 187, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(188, 1, 'シギ', 'ケリ', 'Vanellus cinereus', 5, 0, '', 188, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(189, 1, 'シギ', 'チシマシギ', 'Calidris ptilocnemis kurilensis', 5, 0, '', 189, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(190, 1, 'シギ', 'シベリアオオハシシギ', 'Limnodromus semipalmatus', 5, 0, '', 190, 0, NULL, NULL, NULL, '2018-09-01 11:20:38'),
(191, 1, 'シギ', 'シロハラチュウシャクシギ', 'Numenius tenuirostris', 2, 0, '', 191, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(192, 1, 'セイタカシギ', 'セイタカシギ', 'Himantopus himantopus himantopus', 9, 0, '', 192, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(193, 1, 'セイタカシギ', 'ツバメチドリ', 'Glareola maldivarum', 9, 0, '', 193, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(194, 1, 'カモメ', 'ズグロカモメ', 'Larus saundersi', 9, 0, '', 194, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(195, 1, 'カモメ', 'オオアジサシ', 'Thalasseus bergii cristatus', 9, 0, '', 195, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(196, 1, 'カモメ', 'ベニアジサシ', 'Sterna dougallii bangsi', 9, 0, '', 196, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(197, 1, 'カモメ', 'エリグロアジサシ', 'Sterna sumatrana', 9, 0, '', 197, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(198, 1, 'カモメ', 'コアジサシ', 'Sterna albifrons sinensis', 9, 0, '', 198, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(199, 1, 'ウミスズメ', 'ウミガラス', 'Uria aalge inornata', 7, 0, '', 199, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(200, 1, 'ウミスズメ', 'ウミスズメ', 'Synthliboramphus antiquus', 7, 0, '', 200, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(201, 1, 'ウミスズメ', 'エトピリカ', 'Lunda cirrhata', 7, 0, '', 201, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(202, 1, 'ウミスズメ', 'ケイマフリ', 'Cepphus carbo', 9, 0, '', 202, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(203, 1, 'ウミスズメ', 'カンムリウミスズメ', 'Synthliboramphus wumizusume', 9, 0, '', 203, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(204, 1, 'ウミスズメ', 'マダラウミスズメ', 'Brachyramphus marmoratus perdix', 5, 0, '', 204, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(205, 1, 'ハト', 'リュウキュウカラスバト', 'Columba jouyi', 6, 1, '', 205, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(206, 1, 'ハト', 'オガサワラカラスバト', 'Columba versicolor', 6, 1, '', 206, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(207, 1, 'ハト', 'アカガシラカラスバト', 'Columba janthina nitens', 7, 1, '', 207, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(208, 1, 'ハト', 'ヨナクニカラスバト', 'Columba janthina stejnegeri', 8, 1, '', 208, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(209, 1, 'ハト', 'シラコバト', 'Streptopelia decaocto decaocto', 8, 0, '', 209, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(210, 1, 'ハト', 'キンバト', 'Chalcophaps indica yamashinai', 8, 1, '', 210, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(211, 1, 'ハト', 'カラスバト', 'Columba janthina janthina', 4, 0, '', 211, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(212, 1, 'フクロウ', 'ワシミミズク', 'Bubo bubo', 7, 0, '', 212, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(213, 1, 'ヨタカ', 'ヨタカ', 'Caprimulgus indicus jotaka', 4, 0, '', 213, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(214, 1, 'カワセミ', 'ミヤコショウビン', 'Halcyon miyakoensis', 6, 1, '', 214, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(215, 1, 'ブッポウソウ', 'ブッポウソウ', 'Eurystomus orientalis calonyx', 8, 0, '', 215, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(216, 1, 'キツツキ', 'キタタキ', 'Dryocopus javensis richardsi', 6, 0, '', 216, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(217, 1, 'キツツキ', 'ノグチゲラ', 'Sapheopipo noguchii', 7, 1, '', 217, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(218, 1, 'キツツキ', 'ミユビゲラ', 'Picoides tridactylus inouyei', 7, 1, '', 218, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(219, 1, 'キツツキ', 'クマゲラ', 'Dryocopus martius martius', 9, 0, '', 219, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(220, 1, 'キツツキ', 'オーストンオオアカゲラ', 'Dendrocopos leucotos owstoni', 9, 1, '', 220, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(221, 1, 'キツツキ', 'アマミコゲラ', 'Dendrocopos kizuki amamii', 9, 0, '', 221, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(222, 1, 'ヤイロチョウ', 'ヤイロチョウ', 'Pitta brachyura nympha', 8, 0, '', 222, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(223, 1, 'ヤイロチョウ', 'サンショウクイ', 'Pericrocotus divaricatus divaricatus', 9, 0, '', 223, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(224, 1, 'ヒヨドリ', 'シロガシラ（ヤエヤマシロガシラ）', 'Pycnonotus sinensis orii', 2, 0, '', 224, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(225, 1, 'モズ', 'チゴモズ', 'Lanius tigrinus', 7, 0, '', 225, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(226, 1, 'モズ', 'アカモズ', 'Lanius cristatus superciliosus', 8, 0, '', 226, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(227, 1, 'ミソサザイ', 'ダイトウミソサザイ', 'Troglodytes troglodytes orii', 6, 1, '', 227, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(228, 1, 'ミソサザイ', 'モスケミソサザイ', 'Troglodytes troglodytes mosukei', 8, 1, '', 228, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(229, 1, 'ツグミ', 'オガサワラガビチョウ', 'Cichlopasser terrestris', 6, 1, '', 229, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(230, 1, 'ツグミ', 'ホントウアカヒゲ', 'Erithacus komadori namiyei', 8, 1, '', 230, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(231, 1, 'ツグミ', 'アカコッコ', 'Turdus celaenops', 8, 1, '', 231, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(232, 1, 'ツグミ', 'タネコマドリ', 'Erithacus akahige tanensis', 9, 1, '', 232, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(233, 1, 'ツグミ', 'アカヒゲ', 'Erithacus komadori komadori', 9, 1, '', 233, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(234, 1, 'ツグミ', 'オオトラツグミ', 'Zoothera dauma major', 9, 1, '', 234, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(235, 1, 'ツグミ', 'ウスアカヒゲ', 'Erithacus komadori subrufus', 5, 1, '', 235, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(236, 1, 'ツグミ', 'コトラツグミ', 'Zoothera dauma horsfieldi', 5, 0, '', 236, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(237, 1, 'ウグイス', 'ダイトウウグイス', 'Cettia diphone restricta', 6, 1, '[8]', 237, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(238, 1, 'ウグイス', 'オオセッカ', 'Locustella pryeri pryeri', 8, 1, '', 238, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(239, 1, 'ウグイス', 'ウチヤマセンニュウ', 'Locustella pleskei', 8, 0, '[9]', 239, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(240, 1, 'ウグイス', 'イイジマムシクイ', 'Phylloscopus ijimae', 9, 1, '', 240, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(241, 1, 'ウグイス', 'マキノセンニュウ', 'Locustella lanceolata', 4, 0, '', 241, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(242, 1, 'ウグイス', 'ウグイスの1亜種', 'Cettia diphone ssp.', 5, 0, '', 242, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(243, 1, 'シジュウカラ', 'ダイトウヤマガラ', 'Parus varius orii', 6, 1, '', 243, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(244, 1, 'シジュウカラ', 'ナミエヤマガラ', 'Parus varius namiyei', 8, 1, '', 244, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(245, 1, 'シジュウカラ', 'オーストンヤマガラ', 'Parus varius owstoni', 8, 1, '', 245, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(246, 1, 'シジュウカラ', 'オリイヤマガラ', 'Parus varius olivaceus', 4, 1, '', 246, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(247, 1, 'ミツスイ', 'ムコジマメグロ', 'Apalopteron familiare familiare', 6, 1, '', 247, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(248, 1, 'ミツスイ', 'ハハジマメグロ', 'Apalopteron familiare hahasima', 8, 1, '', 248, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(249, 1, 'ホオジロ', 'シマアオジ', 'Emberiza aureola ornata', 7, 0, '', 249, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(250, 1, 'ホオジロ', 'コジュリン', 'Emberiza yessoensis yessoensis', 9, 0, '', 250, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(251, 1, 'ホオジロ', 'ノジコ', 'Emberiza sulphurata', 4, 1, '', 251, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(252, 1, 'アトリ', 'オガサワラマシコ', 'Chaunoproctus ferreorostris', 6, 1, '', 252, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(253, 1, 'アトリ', 'オガサワラカワラヒワ', 'Carduelis sinica kittlitzi', 7, 1, '', 253, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(254, 1, 'カラス', 'ルリカケス', 'Garrulus lidthi', 9, 1, '', 254, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(255, 1, 'カササギ', 'カササギ', 'Pica pica sericea', 2, 0, '', 255, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(256, 3, 'トガリネズミ', 'オリイジネズミ', 'Crocidura orii', 8, 0, '', 256, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(257, 3, 'トガリネズミ', 'トウキョウトガリネズミ', 'Sorex minutissimus hawkeri', 9, 0, '', 257, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(258, 3, 'トガリネズミ', 'アズミトガリネズミ', 'Sorex hosonoi', 4, 0, '2006年版までは亜種別に評価していた。', 258, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(259, 3, 'トガリネズミ', 'シコクトガリネズミ', 'Sorex shinto shikokensis', 4, 0, '', 259, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(260, 3, 'トガリネズミ', 'コジネズミ', 'Crocidura shantungensis', 4, 0, '1998年版まではチョウセンコジネズミで評価した。', 260, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(261, 3, 'トガリネズミ', 'ワタセジネズミ', 'Crocidura watasei', 4, 0, '', 261, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(262, 3, 'トガリネズミ', '九州地方のカワネズミ', 'Chimarrogale platycephala', 12, 0, '', 262, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(263, 3, 'トガリネズミ', 'サドトガリネズミ', 'Sorex sadonisus', 4, 0, '', 263, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(264, 3, 'モグラ', 'センカクモグラ', 'Mogera uchidai', 7, 0, '', 264, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(265, 3, 'モグラ', 'エチゴモグラ', 'Mogera etigo', 8, 0, '1991年版では種サドモグラで評価した。', 265, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(266, 3, 'モグラ', 'ミズラモグラ', 'Euroscaptor mizura', 4, 0, '2006年版までは亜種別に評価していた。', 266, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(267, 3, 'モグラ', 'サドモグラ', 'Mogera tokudae', 4, 0, '', 267, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(268, 3, 'オオコウモリ', 'オキナワオオコウモリ', 'Pteropus loochoensis', 6, 0, '', 268, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(269, 3, 'オオコウモリ', 'ダイトウオオコウモリ', 'Pteropus dasymallus daitoensis', 7, 0, '', 269, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(270, 3, 'オオコウモリ', 'エラブオオコウモリ', 'Pteropus dasymallus dasymallus', 7, 0, '', 270, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(271, 3, 'オオコウモリ', 'オガサワラオオコウモリ', 'Pteropus pselaphon', 8, 0, '', 271, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(272, 3, 'オオコウモリ', 'オリイオオコウモリ', 'Pteropus dasymallus inopinatus', 2, 0, '', 272, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(273, 3, 'オオコウモリ', 'ミヤココキクガシラコウモリ', 'Rhinolophus pumilus miyakonis', 6, 0, '', 273, 1, NULL, '176.190.58.145', NULL, '2020-02-27 14:47:22'),
(274, 3, 'オオコウモリ', 'オリイコキクガシラコウモリ', 'Rhinolophus cornutus orii', 8, 0, '', 274, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(275, 3, 'オオコウモリ', 'オキナワコキクガシラコウモリ', 'Rhinolophus pumilus pumilus', 8, 0, '', 275, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(276, 3, 'オオコウモリ', 'ヤエヤマコキクガシラコウモリ', 'Rhinolophus perditus', 9, 0, '2006年版までは亜種別に評価していた。', 276, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(277, 3, 'カグラコウモリ', '与那国島のカグラコウモリ', 'Hipposideros turpis', 3, 0, '2006年版までは種で評価していた。', 277, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(278, 3, 'カグラコウモリ', '波照間島のカグラコウモリ', 'Hipposideros turpis', 3, 0, '2006年版までは種で評価していた。', 278, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(279, 3, 'ヒナコウモリ', 'オガサワラアブラコウモリ', 'Pipistrellus sturdeei', 6, 0, '', 279, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(280, 3, 'ヒナコウモリ', 'クロアカコウモリ', 'Myotis formosus', 7, 0, '2006年版までは亜種ツシマクロアカコウモリとして評価していた。', 280, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(281, 3, 'ヒナコウモリ', 'ヤンバルホオヒゲコウモリ', 'Myotis yanbarensis', 7, 0, '', 281, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(282, 3, 'ヒナコウモリ', 'コヤマコウモリ', 'Nyctalus furvus', 8, 0, '', 282, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(283, 3, 'ヒナコウモリ', 'リュウキュウユビナガコウモリ', 'Miniopterus fuscus', 8, 0, '', 283, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(284, 3, 'ヒナコウモリ', 'リュウキュウテングコウモリ', 'Murina ryukyuana', 8, 0, '', 284, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(285, 3, 'ヒナコウモリ', 'クビワコウモリ', 'Eptesicus japonensis', 9, 0, '', 285, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(286, 3, 'ヒナコウモリ', 'ヤマコウモリ', 'Nyctalus aviator', 9, 0, '', 286, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(287, 3, 'ヒナコウモリ', 'モリアブラコウモリ', 'Pipistrellus endoi', 9, 0, '', 287, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(288, 3, 'ヒナコウモリ', 'ウスリホオヒゲコウモリ', 'Myotis gracilis', 9, 0, '', 288, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(289, 3, 'ヒナコウモリ', 'ホンドノレンコウモリ', 'Myotis nattereri bombinus', 9, 0, '', 289, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(290, 3, 'ヒナコウモリ', 'クロホオヒゲコウモリ', 'Myotis pruinosus', 9, 0, '', 290, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(291, 3, 'ヒナコウモリ', 'オオアブラコウモリ', 'Pipistrellus savii', 5, 0, '2006年版までは亜種別に評価されていた', 291, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(292, 3, 'ヒナコウモリ', 'ヒメヒナコウモリ', 'Vespertilio murinus', 5, 0, '', 292, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(293, 3, 'ヒナコウモリ', 'クチバテングコウモリ', 'Murina tenebrosa', 5, 0, '', 293, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(294, 3, 'ヒナコウモリ', '本州のチチブコウモリ', 'Barbastella leucomelas darjelingensis', 12, 0, '1998年版ではチチブコウモリで評価した。', 294, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(295, 3, 'ヒナコウモリ', '四国のチチブコウモリ', 'Barbastella leucomelas darjelingensis', 12, 0, '1998年版ではチチブコウモリで評価した。', 295, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(296, 3, 'ヒナコウモリ', '近畿地方以西のウサギコウモリ', 'Plecotus sacrimontis', 12, 0, '', 296, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(297, 3, 'ヒナコウモリ', '紀伊半島のシナノホオヒゲコウモリ', 'Myotis ikonnikovi hosonoi', 12, 0, '1991年版では種ヒメホオヒゲコウモリ、2006年版までは亜種シナノホオヒゲコウモリで評価されていた。', 297, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(298, 3, 'ヒナコウモリ', '中国地方のシナノホオヒゲコウモリ', 'Myotis ikonnikovi hosonoi', 12, 0, '1991年版では種ヒメホオヒゲコウモリ、2006年版までは亜種シナノホオヒゲコウモリで評価されていた。', 298, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(299, 3, 'ヒナコウモリ', 'ヒメホリカワコウモリ', 'Eptesicus nilssonii parvus', 8, 0, '', 299, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(300, 3, 'ヒナコウモリ', 'ニホンコテングコウモリ', 'Murina ussuriensis silvatica', 9, 0, '', 300, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(301, 3, 'ヒナコウモリ', 'テングコウモリ', 'Murina hilgendorfi', 9, 0, '1998年版ではニホンテングコウモリで評価した。', 301, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(302, 3, 'ヒナコウモリ', 'ウスリドーベントンコウモリ', 'Myotis daubentonii ussuriensis', 9, 0, '', 302, 0, NULL, NULL, NULL, '2018-09-01 11:20:39'),
(303, 3, 'ヒナコウモリ', 'カグヤコウモリ', 'Myotis frater kaguyae', 9, 0, '', 303, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(304, 3, 'ヒナコウモリ', 'フジホオヒゲコウモリ', 'Myotis ikonnikovi fujiensis', 4, 0, '1991年版では種ヒメホオヒゲコウモリで評価した。', 304, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(305, 3, 'ヒナコウモリ', 'ヒメホオヒゲコウモリ', 'Myotis ikonnikovi ikonnikovi', 8, 0, '', 305, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(306, 3, 'ヒナコウモリ', 'オゼホオヒゲコウモリ', 'Myotis ikonnikovi ozensis', 5, 0, '', 306, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(307, 3, 'ヒナコウモリ', 'エゾホオヒゲコウモリ', 'Myotis ikonnikovi yesoensis', 8, 0, '1991年版では種ヒメホオヒゲコウモリで評価した。', 307, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(308, 3, 'ヒナコウモリ', 'ヒナコウモリ', 'Vespertilio superans', 9, 0, '', 308, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(309, 3, 'オヒキコウモリ', 'オヒキコウモリ', 'Tadarida insignis', 9, 0, '', 309, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(310, 3, 'オヒキコウモリ', 'スミイロオヒキコウモリ', 'Tadarida latouchei', 5, 0, '1991年版では種オヒキコウモリで評価した。', 310, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(311, 3, 'オナガザル', '北奥羽・北上山系のホンドザル', 'Macaca fuscata fuscata', 12, 0, '1991年版では東北地方のニホンザル個体群（下北半島の個体群を除く）で、1998年版では「東北地方のホンドザル」で評価した。', 311, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(312, 3, 'オナガザル', '金華山のホンドザル', 'Macaca fuscata fuscata', 12, 0, '1991年版では東北地方のニホンザル個体群（下北半島の個体群を除く）で、1998年版では「東北地方のホンドザル」で評価した。', 312, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(313, 3, 'オナガザル', 'ヤクシマザル', 'Macaca fuscata yakui', 4, 0, '', 313, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(314, 3, 'オナガザル', '下北半島のホンドザル', 'Macaca fuscata fuscata(population in Shimokita Peninsula)', 12, 0, '1991年版では「下北半島のニホンザル個体群（青森県）」で評価した。', 314, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(315, 3, 'リス', 'エゾシマリス', 'Tamias sibiricus lineatus', 5, 0, '', 315, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(316, 3, 'リス', '中国地方のニホンリス', 'Sciurus lis', 12, 0, '1991年版では「琵琶湖以西のニホンリス個体群」で、中国地方以西（四国を除く）のニホンリスで評価した。', 316, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(317, 3, 'リス', '九州地方のニホンリス', 'Sciurus lis', 12, 0, '1991年版では「琵琶湖以西のニホンリス個体群」で、中国地方以西（四国を除く）のニホンリスで評価した。', 317, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(318, 3, 'リス', 'ホンドモモンガ', 'Pteromys momonga', 2, 0, '', 318, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(319, 3, 'ヤマネ', 'ヤマネ', 'Glirulus japonicus', 4, 0, '', 319, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(320, 3, 'ネズミ', 'セスジネズミ', 'Apodemus agrarius', 7, 0, '', 320, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(321, 3, 'ネズミ', 'オキナワトゲネズミ', 'Tokudaia muenninki', 7, 0, '1991年版では種アマミトゲネズミで評価した。', 321, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(322, 3, 'ネズミ', 'アマミトゲネズミ', 'Tokudaia osimensis', 8, 0, '', 322, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(323, 3, 'ネズミ', 'トクノシマトゲネズミ', 'Tokudaia tokunoshimensis', 8, 0, '1998年版まではアマミトゲネズミに含めて評価した。', 323, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(324, 3, 'ネズミ', 'ケナガネズミ', 'Diplothrix legata', 8, 0, '', 324, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(325, 3, 'ネズミ', 'ミヤマムクゲネズミ', 'Clethrionomys rex montanus', 4, 0, '', 325, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(326, 3, 'ネズミ', 'リシリムクゲネズミ', 'Clethrionomys rex rex', 4, 0, '', 326, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(327, 3, 'ネズミ', 'ワカヤマヤチネズミ', 'Eothenomys imaizumii', 2, 0, '', 327, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(328, 3, 'ネズミ', 'ミヤケアカネズミ', 'Apodemus miyakensis', 2, 0, '', 328, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(329, 3, 'ネズミ', 'カラフトアカネズミ', 'Apodemus peninsulae giliacus', 2, 0, '', 329, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(330, 3, 'ナキウサギ', 'エゾナキウサギ', 'Ochotona hyperborea yesoensis', 4, 0, '1998年版では「夕張・芦別のナキウサギ」で、2006年版までは「夕張・芦別のエゾナキウサギ」で評価されていた。', 330, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(331, 3, 'ウサギ', 'アマミノクロウサギ', 'Pentalagus furnessi', 8, 0, '', 331, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(332, 3, 'ウサギ', 'サドノウサギ', 'Lepus brachyurus lyoni', 4, 0, '', 332, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(333, 3, 'クマ', '天塩・増毛地方のエゾヒグマ', 'Ursus arctos yesoensis', 12, 0, '', 333, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(334, 3, 'クマ', '石狩西部のエゾヒグマ', 'Ursus arctos yesoensis', 12, 0, '', 334, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(335, 3, 'クマ', '下北半島のツキノワグマ', 'Ursus thibetanus japonicus', 12, 0, '', 335, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(336, 3, 'クマ', '紀伊半島のツキノワグマ', 'Ursus thibetanus japonicus', 12, 0, '', 336, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(337, 3, 'クマ', '東中国地域のツキノワグマ', 'Ursus thibetanus japonicus', 12, 0, '1991年版では「東中国山地（氷ノ山）のツキノワグマ個体群」で評価した。', 337, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(338, 3, 'クマ', '西中国地域のツキノワグマ', 'Ursus thibetanus japonicus', 12, 0, '1991年版では「西中国地域のツキノワグマ個体群（島根県、広島県、山口県）」で評価した。', 338, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(339, 3, 'クマ', '四国山地のツキノワグマ', 'Ursus thibetanus japonicus', 12, 0, '', 339, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(340, 3, 'クマ', '九州地方のツキノワグマ', 'Ursus thibetanus japonicus', 12, 0, '', 340, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(341, 3, 'イヌ', 'エゾオオカミ', 'Canis lupus hattai', 6, 0, '', 341, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(342, 3, 'イヌ', 'ニホンオオカミ', 'Canis lupus hodophilax', 6, 0, '', 342, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(343, 3, 'イタチ', 'ニホンカワウソ（本州以南亜種）', 'Lutra lutra nippon', 6, 0, '1991年版ではニホンカワウソ（Lutra nippon）で評価した。', 343, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(344, 3, 'イタチ', 'ニホンカワウソ（北海道亜種）', 'Lutra lutra whiteleyi', 6, 0, '1991年版ではニホンカワウソ（Lutra nippon）で評価した。', 344, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(345, 3, 'イタチ', 'ラッコ', 'Enhydra lutris', 7, 0, '', 345, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(346, 3, 'イタチ', 'チョウセンイタチ', 'Mustela sibirica coreana', 4, 0, '自然分布域である対馬の個体群が対象である（国内移入である西日本地域は対象外）。', 346, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(347, 3, 'イタチ', 'ニホンイイズナ（本州亜種）', 'Mustela nivalis namiyei', 4, 0, '1991年版では「青森県の「ニホンイイズナ個体群」で、2006年版では「本州のニホンイイズナ」として評価されていた。', 347, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(348, 3, 'イタチ', 'ホンドオコジョ', 'Mustela erminea nippon', 4, 0, '', 348, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(349, 3, 'イタチ', 'エゾオコジョ', 'Mustela erminea orientalis', 4, 0, '', 349, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(350, 3, 'イタチ', 'ツシマテン', 'Martes melampus tsuensis', 4, 0, '', 350, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(351, 3, 'イタチ', 'エゾクロテン', 'Martes zibellina brachyura', 4, 0, '', 351, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(352, 3, 'ネコ', 'イリオモテヤマネコ', 'Prionailurus bengalensis iriomotensis', 7, 0, '', 352, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(353, 3, 'ネコ', 'ツシマヤマネコ', 'Prionailurus bengalensis euptilura', 7, 0, '', 353, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(354, 3, 'アシカ', 'ニホンアシカ', 'Zalophus japonicus', 7, 0, '', 354, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(355, 3, 'アシカ', 'トド', 'Eumetopias jubatus', 4, 0, '', 355, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(356, 3, 'アザラシ', 'ゼニガタアザラシ', 'Phoca vitulina', 9, 0, '', 356, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(357, 3, 'イノシシ', '徳之島のリュウキュウイノシシ', 'Sus scrofa riukiuanus', 12, 0, '', 357, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(358, 3, 'シカ', '馬毛島のニホンジカ', 'Cervus nippon', 12, 0, '', 358, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(359, 3, 'シカ', 'ケラマジカ', 'Cervus nippon keramae', 1, 0, '', 359, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(360, 3, 'シカ', 'ヤクシカ', 'Cervus nippon yakushimae', 2, 0, '', 360, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(361, 3, 'シカ', 'ツシマジカ', 'Cervus pulchellus', 2, 0, '', 361, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(362, 3, 'ウシ', '九州地方のカモシカ', 'Capricornis crispus', 12, 0, '1991年版では「九州のニホンカモシカ個体群」で評価した。', 362, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(363, 3, 'ウシ', '四国のニホンカモシカ個体群', 'Capricornis crispus crispus', 12, 0, '', 363, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(364, 3, 'ジュゴン', 'ジュゴン', 'Dugong dugon', 7, 0, '', 364, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(365, 5, 'ヤツメウナギ', 'スナヤツメ北方種', 'Lethenteron sp. 1', 9, 0, '1999年版では「スナヤツメL. reissneri」で評価した。', 365, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(366, 5, 'ヤツメウナギ', 'スナヤツメ南方種', 'Lethenteron sp. 2', 9, 0, '1999年版では「スナヤツメLethenteron reissneri」で評価した。', 366, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(367, 5, 'ヤツメウナギ', 'カワヤツメ', 'Lethenteron japonicum', 9, 0, '', 367, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(368, 5, 'ヤツメウナギ', 'シベリアヤツメ', 'Lethenteron kessleri', 4, 0, '', 368, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(369, 5, 'ヤツメウナギ', '栃木県のミツバヤツメ', 'Entosphenus tridentatus', 12, 0, '1999年版では「ミツバヤツメ」で評価した。', 369, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(370, 5, 'ヤツメウナギ', 'ユウフツヤツメ', 'Lampetra tridentata', 2, 0, '', 370, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(371, 5, 'チョウザメ', 'チョウザメ', 'Acipenser medirostris', 6, 0, '', 371, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(372, 5, 'ウナギ', 'ニホンウナギ', 'Anguilla japonica', 5, 0, '絶滅危惧IB類[注 1]', 372, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(373, 5, 'ウナギ', 'ニューギニアウナギ', 'Anguilla bicolor pacifica', 5, 0, '情報不足', 373, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(374, 5, 'ウツボ', 'コゲウツボ', 'Uropterygius concolor', 7, 0, '絶滅危惧IA類', 374, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(375, 5, 'ウツボ', 'ナミダカワウツボ', 'Echidna rhodochilus', 7, 0, '絶滅危惧IA類', 375, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(376, 5, 'カタクチイワシ', 'エツ', 'Coilia nasus', 9, 0, '1991年版では「エツ」と「佐賀県六角川のエツ個体群」に分けて評価した。', 376, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(377, 5, 'ニシン', 'ドロクイ', 'Nematalosa japonica', 8, 0, '', 377, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(378, 5, 'ニシン', '太平洋側湖沼系群のニシン', 'Clupea pallasii', 12, 0, '', 378, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(379, 5, 'ドジョウ', 'スジシマドジョウ小型種山陽型', 'Cobitis sp., S San-yo form', 7, 0, '1999年版では「スジシマドジョウ小型種」で評価した。', 379, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(380, 5, 'ドジョウ', 'アユモドキ', 'Leptobotia curta', 7, 0, '', 380, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(381, 5, 'ドジョウ', 'イシドジョウ', 'Cobitis takatsuensis', 8, 0, '', 381, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(382, 5, 'ドジョウ', 'ヒナイシドジョウ', 'Cobitis shikokuensis', 8, 0, '1999年版では「イシドジョウ」に含められていた（2006年11月に新種記載）。', 382, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(383, 5, 'ドジョウ', 'スジシマドジョウ大型種', 'Cobitis sp. L', 8, 0, '', 383, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(384, 5, 'ドジョウ', 'スジシマドジョウ小型種東海型', 'Cobitis sp., S Tokai form', 8, 0, '1999年版では「スジシマドジョウ小型種」で評価した。', 384, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(385, 5, 'ドジョウ', 'スジシマドジョウ小型種琵琶湖型（淀川個体群を含む）', 'Cobitis sp., S Biwako form', 8, 0, '1999年版では「スジシマドジョウ小型種」で評価した。', 385, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(386, 5, 'ドジョウ', 'スジシマドジョウ小型種山陰型', 'Cobitis sp., S San-in form', 8, 0, '1999年版では「スジシマドジョウ小型種」で評価した。', 386, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(387, 5, 'ドジョウ', 'スジシマドジョウ小型種九州型', 'Cobitis sp., S Kyushu form', 8, 0, '1999年版では「スジシマドジョウ小型種」で評価した。', 387, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(388, 5, 'ドジョウ', 'エゾホトケドジョウ', 'Lefua nikkonis', 8, 0, '', 388, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(389, 5, 'ドジョウ', 'ホトケドジョウ', 'Lefua echigonia', 8, 0, '', 389, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(390, 5, 'ドジョウ', 'ナガレホトケドジョウ', 'Lefua sp.', 8, 0, '', 390, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(391, 5, 'ドジョウ', 'アジメドジョウ', 'Niwaella delicata', 9, 0, '1999年版では「大阪府のアジメドジョウ」で評価した。', 391, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(392, 5, 'ドジョウ', 'ヤマトシマドジョウ', 'Cobitis matsubarae', 9, 0, '', 392, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(393, 5, 'ドジョウ', 'スジシマドジョウ中型種', 'Cobitis sp. M', 9, 0, '', 393, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(394, 5, 'コイ', 'スワモロコ', 'Gnathopogon elongatus suwae', 6, 0, '', 394, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(395, 5, 'コイ', 'ミヤコタナゴ', 'Tanakia tanago', 7, 0, '', 395, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(396, 5, 'コイ', 'イチモンジタナゴ', 'Acheilognathus cyanostigma', 7, 0, '', 396, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(397, 5, 'コイ', 'イタセンパラ', 'Acheilognathus longipinnis', 7, 0, '', 397, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(398, 5, 'コイ', 'セボシタビラ', 'Acheilognathus tabira nakamurae', 7, 0, '', 398, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(399, 5, 'コイ', 'ゼニタナゴ', 'Acheilognathus typus', 7, 0, '', 399, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(400, 5, 'コイ', 'ニッポンバラタナゴ', 'Rhodeus ocellatus kurumeus', 7, 0, '', 400, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(401, 5, 'コイ', 'スイゲンゼニタナゴ', 'Rhodeus atremius suigensis', 7, 0, '', 401, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(402, 5, 'コイ', 'ヒナモロコ', 'Aphyocypris chinensis', 7, 0, '', 402, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(403, 5, 'コイ', 'シナイモツゴ', 'Pseudorasbora pumila pumila', 7, 0, '', 403, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(404, 5, 'コイ', 'ウシモツゴ', 'Pseudorasbora pumilasubsp.', 7, 0, '', 404, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(405, 5, 'コイ', 'アブラヒガイ', 'Sarcocheilichthys biwaensis', 7, 0, '', 405, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(406, 5, 'コイ', 'ホンモロコ', 'Gnathopogon caerulescens', 7, 0, '', 406, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(407, 5, 'コイ', 'ゲンゴロウブナ', 'Carassius cuvieri', 8, 0, '', 407, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(408, 5, 'コイ', 'ニゴロブナ', 'Carassius auratus grandoculis', 8, 0, '', 408, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(409, 5, 'コイ', 'タナゴ', 'Acheilognathus melanogaster', 8, 0, '', 409, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(410, 5, 'コイ', 'シロヒレタビラ', 'Acheilognathus tabira tabira', 8, 0, '', 410, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(411, 5, 'コイ', '山陰地方のアカヒレタビラ', 'Acheilognathus tabirasubsp.', 8, 0, '', 411, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(412, 5, 'コイ', 'カゼトゲタナゴ', 'Rhodeus atremius atremius', 8, 0, '', 412, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(413, 5, 'コイ', 'ワタカ', 'Ischikauia steenackeri', 8, 0, '', 413, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(414, 5, 'コイ', 'カワバタモロコ', 'Hemigrammocypris rasborella', 8, 0, '1991年版では「静岡県のカワバタモロコ個体群」で評価した。', 414, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(415, 5, 'コイ', 'ウケクチウグイ', 'Tribolodon nakamurai', 8, 0, '', 415, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(416, 5, 'コイ', 'ハス', 'Opsariichthys uncirostris uncirostris', 9, 0, '', 416, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(417, 5, 'コイ', 'ツチフキ', 'Abbottina rivularis', 9, 0, '', 417, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(418, 5, 'コイ', 'デメモロコ', 'Squalidus japonicus japonicus', 9, 0, '', 418, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(419, 5, 'コイ', 'キンブナ', 'Carassius auratussubsp. 2', 4, 0, '', 419, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(420, 5, 'コイ', 'ヤリタナゴ', 'Tanakia lanceolata', 4, 0, '', 420, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(421, 5, 'コイ', 'アブラボテ', 'Tanakia limbata', 4, 0, '', 421, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(422, 5, 'コイ', 'ヤチウグイ', 'Phoxinus percnurus sachalinensis', 4, 0, '', 422, 0, NULL, NULL, NULL, '2018-09-01 11:20:40'),
(423, 5, 'コイ', 'カワヒガイ', 'Sarcocheilichthys variegatus', 4, 0, '', 423, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(424, 5, 'コイ', 'スゴモロコ', 'Squalidus chankaensis biwae', 4, 0, '', 424, 0, NULL, NULL, NULL, '2018-09-01 11:20:41');
INSERT INTO `en_sps` (`id`, `bio_cls_id`, `family_name`, `wamei`, `scien_name`, `en_ctg_id`, `endemic_sp_flg`, `note`, `sort_no`, `delete_flg`, `update_user`, `ip_addr`, `created`, `modified`) VALUES
(425, 5, 'コイ', 'フナ属の1種（沖縄諸島産）', 'Carassius sp.', 5, 0, '', 425, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(426, 5, 'コイ', 'ナガブナ', 'Carassius auratussubsp. 1', 5, 0, '', 426, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(427, 5, 'コイ', 'ヤマナカハヤ', 'Phoxinus lagowskii yamamotis', 5, 0, '', 427, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(428, 5, 'コイ', '琵琶湖のコイ野生型', 'Cyprinus carpio', 12, 0, '', 428, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(429, 5, 'コイ', '本州日本海側のマルタウグイ', 'Tribolodon brandti', 12, 0, '', 429, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(430, 5, 'コイ', '東北地方のエゾウグイ', 'Tribolodon sachalinensis', 12, 0, '', 430, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(431, 5, 'ナマズ', 'イワトコナマズ', 'Silurus lithophilus', 4, 0, '', 431, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(432, 5, 'ナマズ', 'ネコギギ', 'Pseudobagrus ichikawai', 8, 0, '', 432, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(433, 5, 'ナマズ', 'ギバチ', 'Pseudobagrus tokiensis', 9, 0, '', 433, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(434, 5, 'ナマズ', 'アリアケギバチ', 'Pseudobagrus aurantiacus', 4, 0, '1991年版では「九州産ギバチ P. sp.」で評価した。', 434, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(435, 5, 'アカザ', 'アカザ', 'Liobagrus reini', 9, 0, '1991年版では「九州のアカザ個体群」で評価した。', 435, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(436, 5, 'サケ', 'クニマス', 'Oncorhynchus nerka kawamurae', 6, 0, '2010年、西湖にて生息を確認。', 436, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(437, 5, 'サケ', 'ベニザケ（ヒメマス）', 'Oncorhynchus nerka nerka', 7, 0, '', 437, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(438, 5, 'サケ', 'イトウ', 'Hucho perryi', 8, 0, '', 438, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(439, 5, 'サケ', 'オショロコマ', 'Salvelinus malma krascheninnikovi', 9, 0, '', 439, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(440, 5, 'サケ', 'ミヤベイワナ', 'Salvelinus malma miyabei', 9, 0, '', 440, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(441, 5, 'サケ', 'ゴギ', 'Salvelinus leucomaenis imbrius', 9, 0, '1999年版では「西中国地方のイワナ（ゴギ）」で評価した。', 441, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(442, 5, 'サケ', 'サクラマス（ヤマメ）', 'Oncorhynchus masou masou', 4, 0, '', 442, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(443, 5, 'サケ', 'サツキマス（アマゴ）', 'Oncorhynchus masou ishikawae', 4, 0, '', 443, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(444, 5, 'サケ', 'ビワマス', 'Oncorhynchus masousubsp.', 4, 0, '', 444, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(445, 5, 'サケ', 'ニッコウイワナ', 'Salvelinus leucomaenis pluvius', 5, 0, '', 445, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(446, 5, 'サケ', '紀伊半島のヤマトイワナ（キリクチ）', 'Salvelinus leucomaenis japonicus', 12, 0, '1991年版では「キリクチ」で評価した。', 446, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(447, 5, 'サケ', 'イワメ', 'Oncorhynchus iwame', 10, 0, '', 447, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(448, 5, 'アユ', 'リュウキュウアユ', 'Plecoglossus altivelis ryukyuensis', 7, 0, '', 448, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(449, 5, 'シラウオ', 'アリアケシラウオ', 'Salanx ariakensis', 7, 0, '', 449, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(450, 5, 'シラウオ', 'アリアケヒメシラウオ', 'Neosalanx reganius', 7, 0, '', 450, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(451, 5, 'シラウオ', 'イシカリワカサギ', 'Hypomesus olidus', 4, 0, '', 451, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(452, 5, 'シラウオ', '襟裳岬以西のシシャモ', 'Spirinchus lanceolatus', 12, 0, '', 452, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(453, 5, 'タウナギ', 'タウナギ', 'Monopterus sp.', 8, 0, '1999年版までは、沖縄島のタウナギで評価。', 453, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(454, 5, 'ボラ', 'カワボラ', 'Cestraeus plicatilis', 7, 0, '', 454, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(455, 5, 'ボラ', 'ナガレフウライボラ', 'Crenimugil heterocheilos', 8, 0, '', 455, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(456, 5, 'ボラ', 'アンピンボラ', 'Chelon subviridis', 5, 0, '', 456, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(457, 5, 'ボラ', 'オニボラ', 'Ellochelon vaigiensis', 5, 0, '', 457, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(458, 5, 'ボラ', 'カマヒレボラ', 'Moolgarda pedaraki', 5, 0, '', 458, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(459, 5, 'ボラ', 'モンナシボラ', 'Moolgarda engeli', 5, 0, '', 459, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(460, 5, 'メダカ', 'メダカ北日本集団', 'Oryzias latipes subsp.', 9, 0, '1991年版では「沖縄のメダカ個体群」で、1999年版では種「メダカ」で評価した。', 460, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(461, 5, 'メダカ', 'メダカ南日本集団', 'Oryzias latipes latipes', 9, 0, '1991年版では「沖縄のメダカ個体群」で、1999年版では種「メダカ」で評価した。', 461, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(462, 5, 'サヨリ', 'コモチサヨリ', 'Zenarchopterus dunckeri', 4, 0, '', 462, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(463, 5, 'サヨリ', 'クルメサヨリ', 'Hyporhamphus intermedius', 4, 0, '', 463, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(464, 5, 'トゲウオ', 'ミナミトミヨ', 'Pungitius kaibarae', 6, 0, '', 464, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(465, 5, 'トゲウオ', 'ハリヨ', 'Gasterosteus aculeatus leiurus', 7, 0, '1999年版では「福島以南の陸封イトヨ類（ハリヨを含む）」で評価した。', 465, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(466, 5, 'トゲウオ', 'ムサシトミヨ', 'Pungitius sp. 1', 7, 0, '', 466, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(467, 5, 'トゲウオ', 'トミヨ属雄物型', 'Pungitius sp. 2', 7, 0, '1999年版では「イバラトミヨ雄物型」で評価した。', 467, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(468, 5, 'トゲウオ', 'トミヨ属汽水型', 'Pungitius sp. 3', 4, 0, '', 468, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(469, 5, 'トゲウオ', 'エゾトミヨ', 'Pungitius tymensis', 4, 0, '', 469, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(470, 5, 'トゲウオ', '福島県以南の陸封イトヨ太平洋型', 'Gasterosteus aculeatus aculeatus', 12, 0, '1991年版では「福島県会津のイトヨ個体群（地域個体群）」および「福井県大野盆地のイトヨ個体群（地域個体群）」で、1999年版では「福島以南の陸封イトヨ類（ハリヨを含む）」で評価した。', 470, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(471, 5, 'トゲウオ', '本州のイトヨ日本海型', 'Gasterosteus aculeatus aculeatus', 12, 0, '', 471, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(472, 5, 'トゲウオ', '本州のトミヨ属淡水型', 'Pungitius pungitius', 12, 0, '', 472, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(473, 5, 'ヨウジウオ', 'ホシイッセンヨウジ', 'Microphis (Coelonotus) argulus', 7, 0, '', 473, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(474, 5, 'ヨウジウオ', 'タニヨウジ', 'Microphis (Lophocampus) retzii', 7, 0, '', 474, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(475, 5, 'ヨウジウオ', 'ヒメテングヨウジ', 'Microphis (Oostethus) jagorii', 7, 0, '', 475, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(476, 5, 'フグ', '沖縄島のクサフグ', 'akifugu niphobles', 12, 0, '', 476, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(477, 5, 'ハオコゼ', 'アゴヒゲオコゼ', 'Tetraroge barbata', 7, 0, '', 477, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(478, 5, 'ハオコゼ', 'ヒゲソリオコゼ', 'Tetraroge niger', 7, 0, '', 478, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(479, 5, 'カジカ', 'ヤマノカミ', 'Trachidermus fasciatus', 8, 0, '', 479, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(480, 5, 'カジカ', 'カジカ小卵型', 'Cottus reinii', 8, 0, '1999年版では和名は「ウツセミカジカ」。', 480, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(481, 5, 'カジカ', 'カジカ中卵型', 'Cottus sp.', 8, 0, '', 481, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(482, 5, 'カジカ', 'カマキリ（アユカケ）', 'Cottus kazika', 9, 0, '', 482, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(483, 5, 'カジカ', 'カジカ大卵型', 'Cottus pollux', 4, 0, '', 483, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(484, 5, 'カジカ', '東北・北陸地方のカンキョウカジカ', 'Cottus hangiongensis', 12, 0, '', 484, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(485, 5, 'カジカ', '東北地方のハナカジカ', 'Cottus nozawae', 12, 0, '', 485, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(486, 5, 'アカメ', 'アカメ', 'Lates japonicus', 8, 0, '絶滅危惧IB類', 486, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(487, 5, 'イサキ', 'ダイダイコショウダイ', 'Plectorhinchus albovittatus', 5, 0, '情報不足', 487, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(488, 5, 'キス', 'アオギス', 'Sillago parvisquamis', 7, 0, '絶滅危惧IA類', 488, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(489, 5, 'キス', 'アトクギス', 'Sillaginops macrolepis', 8, 0, '絶滅危惧IB類', 489, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(490, 5, 'シマイサキ', 'ヨコシマイサキ', 'Mesopristes cancellatus', 7, 0, '絶滅危惧IA類', 490, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(491, 5, 'シマイサキ', 'ニセシマイサキ', 'Mesopristes argenteus', 7, 0, '絶滅危惧IA類', 491, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(492, 5, 'シマイサキ', 'シミズシマイサキ', 'Mesopristes iravi', 7, 0, '絶滅危惧IA類', 492, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(493, 5, 'ペルキクティス', 'オヤニラミ', 'Coreoperca kawamebari', 9, 0, '絶滅危惧II類', 493, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(494, 5, 'タイ', 'ナンヨウチヌ', 'Acanthopagrus berda', 4, 0, '絶滅危惧Ⅱ類', 494, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(495, 5, 'スズキ', '有明海のスズキ', 'Lateolabrax japonicus', 12, 0, '地域個体群', 495, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(496, 5, 'ハゼ', '北海道南部・東北地方のスミウキゴリ', 'Gymnogobius petschiliensis', 12, 0, '地域個体群', 496, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(497, 5, 'タカサゴイシモチ', 'ナンヨウタカサゴイシモチ', 'Ambassis interrupta', 9, 0, '情報不足', 497, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(498, 5, 'テッポウウオ', 'テッポウウオ', 'Toxotes jaculatrix', 5, 0, '絶滅危惧IA類', 498, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(499, 5, 'テンジクダイ', 'カガミテンジクダイ', 'Yarica hyalosoma', 7, 0, '絶滅危惧IA類', 499, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(500, 5, 'テンジクダイ', 'ハナダカタカサゴイシモチ', 'Ambassis macracanthus', 5, 0, '情報不足', 500, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(501, 5, 'テンジクダイ', 'ワキイシモチ', 'Fibramia lateralis', 5, 0, '情報不足', 501, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(502, 5, 'テンジクダイ', 'ヒルギヌメリテンジクダイ', 'Pseudamia amblyuroptera', 5, 0, '情報不足', 502, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(503, 5, 'フエダイ', 'ウラウチフエダイ', 'Lutjanus goldiei', 7, 0, '絶滅危惧IA類', 503, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(504, 5, 'ユゴイ', 'トゲナガユゴイ', 'Kuhlia munda', 8, 0, '絶滅危惧IB類', 504, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(505, 5, 'ヘビギンポ', 'ウラウチヘビギンポ', 'Enneapterygius cheni', 7, 0, '絶滅危惧IA類', 505, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(506, 5, 'イソギンポ', 'ヒルギギンポ', 'Omox biporos', 7, 0, '絶滅危惧IA類', 506, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(507, 5, 'イソギンポ', 'カワギンポ', 'Omobranchus ferox', 7, 0, '絶滅危惧IA類', 507, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(508, 5, 'イソギンポ', 'ゴマクモギンポ', 'Omobranchus elongatus', 5, 0, '情報不足', 508, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(509, 5, 'ネズッポ', 'ナリタイトヒキヌメリ', 'Pseudocalliurichthys ikedai', 5, 0, '情報不足', 509, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(510, 5, 'ツバサハゼ', 'ツバサハゼ', 'Rhyacichthys aspro', 7, 0, '絶滅危惧IA類', 510, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(511, 5, 'カワアナゴ', 'オウギハゼ', 'Bunaka gyrinoides', 5, 0, '準絶滅危惧', 511, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(512, 5, 'ハゼ', 'トカゲハゼ', 'Scartelaos histophorus', 7, 0, '絶滅危惧IA類', 512, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(513, 5, 'ハゼ', 'ヨロイボウズハゼ', 'Lentipes armatus', 7, 0, '絶滅危惧IA類', 513, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(514, 5, 'ハゼ', 'カエルハゼ', 'Smilosicyopus leprurus', 7, 0, '絶滅危惧IA類', 514, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(515, 5, 'ハゼ', 'アカボウズハゼ', 'Sicyopus zosterophorus', 7, 0, '絶滅危惧IA類', 515, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(516, 5, 'ハゼ', 'ハヤセボウズハゼ', 'Stiphodon imperiorientis', 7, 0, '絶滅危惧IA類', 516, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(517, 5, 'ハゼ', 'コンテリボウズハゼ', 'Stiphodon atropurpureus', 7, 0, '絶滅危惧IA類', 517, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(518, 5, 'ハゼ', 'ドウクツミミズハゼ', 'Luciogobius albus', 7, 0, '絶滅危惧IA類', 518, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(519, 5, 'ハゼ', 'ミスジハゼ', 'Callogobius sp.', 7, 0, '絶滅危惧IA類', 519, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(520, 5, 'ハゼ', 'ウラウチイソハゼ', 'Eviota ocellifer', 7, 0, '絶滅危惧IA類', 520, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(521, 5, 'ハゼ', 'シマサルハゼ', 'Oxyurichthys sp. 2', 7, 0, '絶滅危惧IA類', 521, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(522, 5, 'ハゼ', 'ヒメトサカハゼ', 'Cristatogobius aurimaculatus', 7, 0, '絶滅危惧IA類', 522, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(523, 5, 'ハゼ', 'クロトサカハゼ', 'Cristatogobius nonatoae', 7, 0, '絶滅危惧IA類', 523, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(524, 5, 'ハゼ', 'イサザ', 'Gymnogobius isaza', 7, 0, '絶滅危惧IA類', 524, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(525, 5, 'ハゼ', 'キセルハゼ', 'Gymnogobius cylindricus', 7, 0, '絶滅危惧IB類', 525, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(526, 5, 'ハゼ', 'アゴヒゲハゼ', 'Glossogobius bicirrhosus', 7, 0, '絶滅危惧IA類', 526, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(527, 5, 'ハゼ', 'コンジキハゼ', 'Glossogobius aureus', 7, 0, '絶滅危惧IA類', 527, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(528, 5, 'ハゼ', 'カワクモハゼ', 'Bathygobius sp.', 7, 0, '絶滅危惧IA類', 528, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(529, 5, 'ハゼ', 'ホホグロハゼ', 'Mugilogobius parvus', 7, 0, '準絶滅危惧', 529, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(530, 5, 'ハゼ', 'オガサワラヨシノボリ', 'Rhinogobius sp. BI', 7, 0, '絶滅危惧IB類', 530, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(531, 5, 'ハゼ', 'コマチハゼ', 'Parioglossus taeniatus', 7, 0, '絶滅危惧IA類', 531, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(532, 5, 'ハゼ', 'ヒメサツキハゼ', 'Parioglossus interruptus', 7, 0, '絶滅危惧IA類', 532, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(533, 5, 'ハゼ', 'ヤエヤマノコギリハゼ', 'Butis amboinensis', 8, 0, '絶滅危惧IA類', 533, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(534, 5, 'ハゼ', 'ヒスイボウズハゼ', 'Stiphodon alcedo', 0, 0, '絶滅危惧IA類', 534, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(535, 5, 'ハゼ', 'ジャノメハゼ', 'Bostrychus sinensis', 8, 0, '絶滅危惧IB類', 535, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(536, 5, 'ハゼ', 'タナゴモドキ', 'Hypseleotris cyprinoides', 8, 0, '絶滅危惧IB類', 536, 0, NULL, NULL, NULL, '2018-09-01 11:20:41'),
(537, 5, 'ハゼ', 'タメトモハゼ', 'Giuris sp. 1', 8, 0, '絶滅危惧IB類', 537, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(538, 5, 'ハゼ', 'タビラクチ', 'Apocryptodon punctatus', 8, 0, '絶滅危惧II類', 538, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(539, 5, 'ハゼ', 'ムツゴロウ', 'Boleophthalmus pectinirostris', 8, 0, '絶滅危惧IB類', 539, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(540, 5, 'ハゼ', 'チワラスボ', 'Taenioides cirratus', 8, 0, '絶滅危惧IB類', 540, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(541, 5, 'ハゼ', 'ルリボウズハゼ', 'Sicyopterus lagocephalus', 8, 0, '絶滅危惧II類', 541, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(542, 5, 'ハゼ', 'トサカハゼ', 'Cristatogobius lophius', 8, 0, '絶滅危惧IB類', 542, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(543, 5, 'ハゼ', 'クボハゼ', 'Gymnogobius scrobiculatus', 8, 0, '絶滅危惧IB類', 543, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(544, 5, 'ハゼ', 'ジュズカケハゼ', 'Gymnogobius castaneus', 8, 0, '準絶滅危惧', 544, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(545, 5, 'ハゼ', 'コシノハゼ', 'Gymnogobius nakamurae', 8, 0, '絶滅危惧IA類', 545, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(546, 5, 'ハゼ', 'ホクリクジュズカケハゼ', 'Gymnogobius sp. 2', 8, 0, '絶滅危惧IA類', 546, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(547, 5, 'ハゼ', 'ムサシノジュズカケハゼ', 'Gymnogobius sp. 1', 8, 0, '絶滅危惧IB類', 547, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(548, 5, 'ハゼ', 'シマエソハゼ', 'Schismatogobius ampluvinculus', 8, 0, '絶滅危惧IB類', 548, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(549, 5, 'ハゼ', 'エソハゼ', 'Schismatogobius roxasi', 8, 0, '絶滅危惧IB類', 549, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(550, 5, 'ハゼ', 'マングローブゴマハゼ', 'Pandaka lidwilli', 8, 0, '絶滅危惧II類', 550, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(551, 5, 'ハゼ', 'アオバラヨシノボリ', 'Rhinogobius sp. BB', 8, 0, '絶滅危惧IA類', 551, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(552, 5, 'ハゼ', 'キバラヨシノボリ', 'Rhinogobius sp. YB', 8, 0, '絶滅危惧IB類', 552, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(553, 5, 'ハゼ', 'コビトハゼ', 'Parioglossus rainfordi', 8, 0, '絶滅危惧IB類', 553, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(554, 5, 'ハゼ', 'ホシマダラハゼ', 'Ophiocara porocephala', 9, 0, '絶滅危惧II類', 554, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(555, 5, 'ハゼ', 'アサガラハゼ', 'Caragobius urolepis', 9, 0, '絶滅危惧II類', 555, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(556, 5, 'ハゼ', 'ワラスボ', 'Odontamblyopus lacepedii', 9, 0, '絶滅危惧II類', 556, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(557, 5, 'ハゼ', 'ヒゲワラスボ', 'Trypauchenopsis intermedia', 9, 0, '絶滅危惧II類', 557, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(558, 5, 'ハゼ', 'シロウオ', 'Leucopsarion petersii', 9, 0, '絶滅危惧II類', 558, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(559, 5, 'ハゼ', 'ミナミヒメミミズハゼ', 'Luciogobius sp.', 9, 0, '絶滅危惧II類', 559, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(560, 5, 'ハゼ', 'エドハゼ', 'Gymnogobius macrognathos', 9, 0, '絶滅危惧II類', 560, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(561, 5, 'ハゼ', 'チクゼンハゼ', 'Gymnogobius uchidai', 9, 0, '絶滅危惧II類', 561, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(562, 5, 'ハゼ', 'シンジコハゼ', 'Gymnogobius taranetzi', 9, 0, '絶滅危惧II類', 562, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(563, 5, 'ハゼ', 'ハゼクチ', 'Acanthogobius hasta', 9, 0, '絶滅危惧II類', 563, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(564, 5, 'ハゼ', 'ミナミアシシロハゼ', 'Acanthogobius insularis', 9, 0, '絶滅危惧II類', 564, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(565, 5, 'ハゼ', 'マサゴハゼ', 'Pseudogobius masago', 9, 0, '絶滅危惧II類', 565, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(566, 5, 'ハゼ', 'キララハゼ', 'Acentrogobius viridipunctatus', 9, 0, '絶滅危惧II類', 566, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(567, 5, 'ハゼ', 'ゴマハゼ', 'Pandaka sp.', 9, 0, '絶滅危惧II類', 567, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(568, 5, 'ハゼ', 'ボルネオハゼ', 'Parioglossus palustris', 9, 0, '絶滅危惧II類', 568, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(569, 5, 'ハゼ', 'ゴシキタメトモハゼ', 'Giuris sp. 2', 4, 0, '絶滅危惧IB類', 569, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(570, 5, 'ハゼ', 'トビハゼ', 'Periophthalmus modestus', 4, 0, '準絶滅危惧', 570, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(571, 5, 'ハゼ', 'イドミミズハゼ', 'Luciogobius pallidus', 4, 0, '準絶滅危惧', 571, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(572, 5, 'ハゼ', 'ヒモハゼ', 'Eutaeniichthys gilli', 4, 0, '準絶滅危惧', 572, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(573, 5, 'ハゼ', 'ホクロハゼ', 'Acentrogobius caninus', 4, 0, '準絶滅危惧', 573, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(574, 5, 'ハゼ', 'トウカイヨシノボリ', 'Rhinogobius sp. TO', 4, 0, '準絶滅危惧', 574, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(575, 5, 'ハゼ', 'ショウキハゼ', 'Tridentiger barbatus', 4, 0, '準絶滅危惧', 575, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(576, 5, 'ハゼ', 'イシドンコ', 'Odontobutis hikimius', 5, 0, '絶滅危惧II類', 576, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(577, 5, 'ハゼ', 'エリトゲハゼ', 'Belobranchus belobranchus', 5, 0, '情報不足', 577, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(578, 5, 'ハゼ', 'カキイロヒメボウズハゼ', 'Stiphodon surrufus', 5, 0, '情報不足', 578, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(579, 5, 'ハゼ', 'ネムリミミズハゼ', 'Luciogobius dormitoris', 5, 0, '情報不足', 579, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(580, 5, 'ハゼ', 'ドウケハゼ', 'Stenogobius ophthalmoporus', 5, 0, '情報不足', 580, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(581, 5, 'ハゼ', 'ヘビハゼ', 'Gymnogobius mororanus', 5, 0, '情報不足', 581, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(582, 5, 'ハゼ', 'スダレウロハゼ', 'Glossogobius circumspectus', 5, 0, '準絶滅危惧', 582, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(583, 5, 'ハゼ', 'フタゴハゼ', 'Glossogobius sp.', 5, 0, '情報不足', 583, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(584, 5, 'ハゼ', 'コクチスナゴハゼ', 'Pseudogobius gastrospilos', 5, 0, '情報不足', 584, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(585, 5, 'ハゼ', 'ニセシラヌイハゼ', 'Silhouettea sp.', 5, 0, '準絶滅危惧', 585, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(586, 5, 'ハゼ', 'シラヌイハゼ', 'Silhouettea dotui', 5, 0, '準絶滅危惧', 586, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(587, 5, 'ハゼ', 'タスキヒナハゼ', 'Redigobius balteatus', 5, 0, '情報不足', 587, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(588, 5, 'ハゼ', 'フタホシハゼ', 'Mugilogobius fuscus', 5, 0, '情報不足', 588, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(589, 5, 'ハゼ', 'ムジナハゼ', 'Mugilogobius mertoni', 5, 0, '絶滅危惧II類', 589, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(590, 5, 'ハゼ', 'ニセツムギハゼ', 'Acentrogobius audax', 5, 0, '準絶滅危惧', 590, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(591, 5, 'ハゼ', 'ホホグロスジハゼ', 'Acentrogobius suluensis', 5, 0, '準絶滅危惧', 591, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(592, 5, 'ハゼ', 'ギンポハゼ', 'Parkraemeria saltator', 5, 0, '絶滅危惧II類', 592, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(593, 5, 'ハゼ', 'ビワヨシノボリ', 'Rhinogobius sp. BW', 5, 0, '情報不足', 593, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(594, 5, 'ハゼ', 'ナミノコハゼ', 'Gobitrichinotus radiocularis', 5, 0, '準絶滅危惧', 594, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(595, 5, 'ハゼ', 'トンガスナハゼ', 'Kraemeria tongaensis', 5, 0, '情報不足', 595, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(596, 5, 'ハゼ', 'マイコハゼ', 'Parioglossus lineatus', 5, 0, '情報不足', 596, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(597, 5, 'ハゼ', 'ニライカナイボウズハゼ', 'Stiphodon niraikanaiensis', 0, 0, '情報不足', 597, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(598, 5, 'ハゼ', 'トラフボウズハゼ', 'Stiphodon multisquamus', 0, 0, '情報不足', 598, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(599, 5, 'ゴクラクギョ', 'タイワンキンギョ', 'Macropodus opercularis', 7, 0, '絶滅危惧IA類', 599, 0, NULL, NULL, NULL, '2018-09-01 11:20:42'),
(600, 1, 'テスト', 'テスト和名', 'abc', 1, 1, 'TEST', 0, 1, NULL, '::1', '2018-09-02 22:55:50', '2018-09-03 02:37:02'),
(601, 1, 'TEST2', 'マスタービッグチキン', 'ookii-niwatori', 12, 1, 'TEST', 1, 0, '', '126.219.137.211', '2018-09-03 06:49:50', '2018-09-08 14:07:56'),
(602, 3, 'TESTjt', 'アジフライ<input />', 'ajihurai-oisi-', 5, 1, 'TEST', 2, 0, '', '36.11.224.72', '2018-09-08 23:07:11', '2018-10-18 16:13:15'),
(604, 5, 'TEST', 'アジフライ2', 'ajihurai-oisi-', 5, 1, 'TEST', -2, 1, NULL, '126.219.137.211', '2018-09-08 23:47:22', '2018-09-08 14:47:48'),
(605, 5, 'TEST', 'アジフライ3', 'ajihurai-oisi-', 5, 1, 'TEST', -2, 1, NULL, '126.219.137.211', '2018-09-08 23:47:32', '2018-09-08 14:47:48'),
(606, 5, 'TEST', 'アジフライ4', 'ajihurai-oisi-', 5, 1, 'TEST', -2, 1, NULL, '126.219.137.211', '2018-09-08 23:48:04', '2018-09-08 14:48:13'),
(607, 3, 'アカマムシ', '道三', '', 4, NULL, '', 0, 1, NULL, '126.219.137.211', '2018-09-09 00:06:56', '2018-09-08 15:07:48'),
(608, 2, 'ＴＥＳＴ', 'ＴＥＳ', 'ＴＥ', 3, 1, '℡', 0, 1, NULL, '126.219.137.211', '2018-09-09 00:14:15', '2018-09-08 15:14:18'),
(609, 5, 'TEST', 'アジフライ<input />', 'ajihurai-oisi-', 5, 1, 'TEST', 1, 1, NULL, '126.219.137.211', '2018-09-09 00:18:24', '2018-09-08 15:18:26'),
(610, 1, 'TEST2', 'マスタービッグチキン', 'ookii-niwatori', 12, 1, 'TEST', 3, 0, '', '36.11.224.72', '2018-10-19 01:13:31', '2018-10-18 16:13:31'),
(611, 1, 'TEST2', 'マスタービッグチキン', 'ookii-niwatori', 12, 1, 'TEST', 4, 0, '', '36.11.224.72', '2018-10-19 01:13:33', '2018-10-18 16:13:33');

-- --------------------------------------------------------

--
-- テーブルの構造 `kanis`
--

CREATE TABLE `kanis` (
  `id` int(11) NOT NULL,
  `kani_val` int(11) DEFAULT NULL,
  `kani_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `kani_date` date DEFAULT NULL,
  `kani_group` int(11) DEFAULT NULL COMMENT '猫種別',
  `kani_dt` datetime DEFAULT NULL,
  `note` text CHARACTER SET utf8 NOT NULL COMMENT '備考',
  `delete_flg` tinyint(1) DEFAULT '0' COMMENT '無効フラグ',
  `update_user` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新者',
  `ip_addr` varchar(40) CHARACTER SET utf8 DEFAULT NULL COMMENT 'IPアドレス',
  `created` datetime DEFAULT NULL COMMENT '生成日時',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- テーブルのデータのダンプ `kanis`
--

INSERT INTO `kanis` (`id`, `kani_val`, `kani_name`, `kani_date`, `kani_group`, `kani_dt`, `note`, `delete_flg`, `update_user`, `ip_addr`, `created`, `modified`) VALUES
(1, 1, 'neko', '2014-04-01', 2, '2014-12-12 00:00:00', '', 0, 'test', '::1', NULL, '2015-11-16 21:45:38'),
(2, 25, 'kani5', '2014-04-03', 1, '2014-12-12 00:00:01', '', 0, 'test', '::1', NULL, '2015-12-01 19:36:33'),
(4, 4, 'buta', '2014-04-04', 2, '2014-12-12 00:00:03', 'AA\\r\\nBBB\\r\\n<input />', 0, 'kani', '::1', '2015-10-30 23:59:59', '2015-11-09 20:04:04'),
(5, 3, 'yagi', '2015-09-17', 2, '2014-12-12 00:00:02', '', 0, 'kani', '::1', '2015-10-31 00:00:00', '2015-11-09 20:03:40'),
(6, 3, 'ari', '2014-04-03', NULL, '2014-12-12 00:00:02', '', 0, NULL, NULL, NULL, '2015-09-15 22:40:01'),
(7, 3, 'tori', '2014-04-03', NULL, '2014-12-12 00:00:02', '', 1, 'kani', '::1', NULL, '2015-09-16 20:19:49'),
(8, 3, 'kame', '2014-04-03', NULL, '2014-12-12 00:00:02', '', 0, NULL, NULL, NULL, '2015-09-15 22:40:01'),
(9, 111, 'イッパイアッテナ', '2012-05-29', 3, '2014-04-28 10:04:00', 'いろは', 0, 'kani', '::1', NULL, '2015-09-16 11:56:07'),
(10, 123, 'PANDA', '1970-01-01', NULL, '2014-04-28 10:05:00', '', 0, NULL, NULL, NULL, '2015-09-15 22:40:01'),
(11, 123, 'るどるふ', NULL, 5, NULL, '', 0, 'kani', '::1', '2015-09-17 05:39:20', '2015-09-16 11:39:20');

-- --------------------------------------------------------

--
-- テーブルの構造 `msg_boards`
--

CREATE TABLE `msg_boards` (
  `id` int(11) NOT NULL,
  `other_id` int(11) DEFAULT NULL COMMENT '外部ID',
  `user_id` int(11) DEFAULT NULL COMMENT 'ユーザーID',
  `user_type` varchar(10) DEFAULT NULL COMMENT 'ユーザータイプ',
  `message` varchar(2000) DEFAULT NULL COMMENT 'メッセージ',
  `attach_fn` varchar(512) DEFAULT NULL COMMENT '添付ファイル',
  `sort_no` int(11) DEFAULT '0' COMMENT '順番',
  `delete_flg` tinyint(1) DEFAULT '0' COMMENT '無効フラグ',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新者',
  `ip_addr` varchar(40) DEFAULT NULL COMMENT 'IPアドレス',
  `created` datetime DEFAULT NULL COMMENT '生成日時',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `msg_boards`
--

INSERT INTO `msg_boards` (`id`, `other_id`, `user_id`, `user_type`, `message`, `attach_fn`, `sort_no`, `delete_flg`, `update_user`, `ip_addr`, `created`, `modified`) VALUES
(1, NULL, 4, NULL, 'レッドデータブック（Red Data Book、略記：RDB）は、絶滅のおそれのある野生生物に関する保全状況や分布、生態、影響を与えている要因等の情報を記載した図書である。', NULL, 0, 0, NULL, NULL, NULL, '2021-05-07 09:05:28'),
(2, NULL, 5, NULL, '。1966年にIUCN（国際自然保護連合）が中心となって作成されたものに始まり、現在は各国や団体等によってもこれに準じるものが多数作成されている。\r\nレッドデータブック', NULL, 0, 0, NULL, NULL, NULL, '2021-05-07 09:05:32'),
(3, NULL, -1, NULL, 'あああ', NULL, 0, 0, NULL, NULL, '2021-05-07 16:25:52', '2021-05-07 07:25:52'),
(4, NULL, -1, NULL, 'あああ', NULL, 1, 0, NULL, NULL, '2021-05-07 16:29:57', '2021-05-07 07:29:57'),
(5, NULL, -1, NULL, 'あああ', '', 2, 0, NULL, NULL, '2021-05-07 16:31:30', '2021-05-07 07:31:30'),
(6, NULL, -1, NULL, '', '', 3, 0, NULL, NULL, '2021-05-07 16:39:48', '2021-05-07 07:39:48'),
(7, NULL, -1, NULL, 'あああ７', '', 4, 0, NULL, NULL, '2021-05-07 16:39:58', '2021-05-07 07:39:58'),
(8, NULL, -1, NULL, 'あああ７', '', 5, 0, NULL, NULL, '2021-05-07 16:39:59', '2021-05-07 07:39:59'),
(9, NULL, -1, NULL, '0', '', 6, 0, NULL, NULL, '2021-05-07 16:42:42', '2021-05-07 07:42:42'),
(10, NULL, -1, NULL, 'ass', '', 7, 0, NULL, NULL, '2021-05-07 17:48:34', '2021-05-07 08:48:34'),
(11, NULL, -1, NULL, 'aaaa', '', 8, 0, NULL, NULL, '2021-05-07 17:49:40', '2021-05-07 08:49:40'),
(12, NULL, -1, NULL, 'あｆｓｄ', '', 9, 0, NULL, NULL, '2021-05-07 18:44:07', '2021-05-07 09:44:07'),
(13, NULL, -1, NULL, 'ｆ', '', 10, 0, NULL, NULL, '2021-05-07 19:18:39', '2021-05-07 10:18:39'),
(14, NULL, -1, NULL, 'ｓｓ', '', 11, 0, NULL, NULL, '2021-05-07 19:18:54', '2021-05-07 10:18:54'),
(15, NULL, -1, NULL, 'あああ', '', 12, 0, NULL, NULL, '2021-05-07 19:21:33', '2021-05-07 10:21:33'),
(16, NULL, -1, NULL, 'あああ', '', 13, 0, NULL, NULL, '2021-05-07 19:21:54', '2021-05-07 10:21:54'),
(17, NULL, -1, NULL, 'ああ', '', 14, 0, NULL, NULL, '2021-05-07 19:22:10', '2021-05-07 10:22:10'),
(18, NULL, -1, NULL, 'あああ', '', 15, 0, NULL, NULL, '2021-05-07 19:34:13', '2021-05-07 10:34:13'),
(19, NULL, 15, NULL, 'aaa', '', 16, 0, NULL, NULL, '2021-05-07 19:38:18', '2021-05-07 10:38:18'),
(20, NULL, 15, NULL, 'fasdfa', '', 17, 0, NULL, NULL, '2021-05-07 19:38:37', '2021-05-07 10:38:37'),
(21, NULL, 15, NULL, 'afsdf', '', 18, 0, NULL, NULL, '2021-05-07 22:36:13', '2021-05-07 13:36:13'),
(22, NULL, 15, NULL, 'aae', '', 19, 0, NULL, NULL, '2021-05-07 22:36:31', '2021-05-07 13:36:31'),
(23, NULL, -1, NULL, 'あああ', 'rsc/img/attach_fn/y2021/m05/orig/20210508160357_20210331a2.png', 20, 0, NULL, NULL, '2021-05-08 16:03:58', '2021-05-08 07:03:58'),
(24, NULL, 8, NULL, 'あああ', 'rsc/img/attach_fn/y2021/m05/orig/20210508191104_sample1.pdf', 21, 0, NULL, NULL, '2021-05-08 19:11:04', '2021-05-08 10:11:04'),
(58, NULL, -1, NULL, 'a', 'rsc/img/attach_fn/y2021/m05/orig/sample1.pdf', 22, 0, NULL, NULL, '2021-05-10 14:59:07', '2021-05-10 05:59:07'),
(59, NULL, -1, NULL, 'a', 'rsc/img/attach_fn/y2021/m05/orig/imori.zip', 23, 0, NULL, NULL, '2021-05-10 14:59:25', '2021-05-10 05:59:25'),
(60, NULL, -1, NULL, 'ああ', 'rsc/img/attach_fn/y2021/m05/orig/20210331a2.png', 24, 0, NULL, NULL, '2021-05-10 16:41:23', '2021-05-10 07:41:23'),
(61, NULL, -1, NULL, 'ああ', '', 25, 1, 'kani', '::1', '2021-05-10 16:41:26', '2021-05-10 07:41:26'),
(62, NULL, -1, NULL, 'ああ', '', 26, 1, 'kani', '::1', '2021-05-10 16:41:30', '2021-05-10 07:41:30'),
(63, NULL, -1, NULL, 'あああ', 'rsc/img/attach_fn/y2021/m05/orig/imori.png', 27, 1, 'kani', '::1', '2021-05-10 16:46:34', '2021-05-10 07:46:34'),
(65, NULL, -1, NULL, 'ｓｓｓ', 'rsc/img/attach_fn/y2021/m05/orig/2021-05-10_044658.png', 29, 1, 'kani', '::1', '2021-05-10 16:46:58', '2021-05-10 07:46:58'),
(68, NULL, 1, NULL, 'ヤギベーベー', '', 25, 0, NULL, NULL, '2021-05-11 23:44:48', '2021-05-11 14:44:48'),
(69, NULL, 3, NULL, 'カニのおいしさ', 'rsc/img/attach_fn/y2021/m05/orig/n9.png', 26, 0, NULL, NULL, '2021-05-11 23:47:24', '2021-05-11 14:47:24'),
(70, NULL, 1, NULL, 'おしい', '', 27, 1, 'yagi', '::1', '2021-05-12 02:06:24', '2021-05-11 17:06:24'),
(71, NULL, 1, NULL, 'あああ', '', 27, 1, 'yagi', '::1', '2021-05-12 02:06:44', '2021-05-11 17:06:44'),
(72, NULL, 1, NULL, 'ううう', '', 28, 0, NULL, NULL, '2021-05-12 02:12:51', '2021-05-11 17:12:51'),
(73, NULL, 1, NULL, 'えええ', '', 29, 0, NULL, NULL, '2021-05-12 02:13:51', '2021-05-11 17:13:51'),
(74, NULL, 1, NULL, 'おお', '', 30, 0, NULL, NULL, '2021-05-12 02:16:18', '2021-05-11 17:16:18'),
(75, NULL, 1, NULL, 'ｋｋ', '', 31, 1, 'yagi', '::1', '2021-05-12 02:16:59', '2021-05-11 17:16:59'),
(76, NULL, 1, NULL, 'あ', '', 32, 1, 'yagi', '::1', '2021-05-12 02:17:18', '2021-05-11 17:17:18'),
(77, NULL, 1, NULL, 'あああ', '', 33, 1, 'yagi', '::1', '2021-05-12 02:18:01', '2021-05-11 17:18:01'),
(78, NULL, -1, NULL, 'あああ', '', 31, 0, NULL, NULL, '2021-05-12 02:18:49', '2021-05-11 17:18:49'),
(79, NULL, 3, NULL, 'ああ', '', 32, 0, NULL, NULL, '2021-05-12 02:21:58', '2021-05-11 17:21:58'),
(80, NULL, 3, NULL, 'うさぎ', '', 33, 1, 'kani', '::1', '2021-05-12 02:37:44', '2021-05-11 17:37:44'),
(81, NULL, 3, NULL, 'うさぎ2', NULL, 0, 0, NULL, NULL, '2021-05-12 09:10:42', '2021-05-12 00:10:42'),
(82, NULL, 3, NULL, 'うさぎｄ', NULL, 0, 0, NULL, NULL, '2021-05-12 09:11:52', '2021-05-12 00:11:52'),
(83, NULL, 3, NULL, 'うさぎｓ', '', 0, 0, NULL, NULL, '2021-05-12 09:12:04', '2021-05-12 00:12:04'),
(84, NULL, 3, NULL, '22', '', 0, 0, NULL, NULL, '2021-05-12 09:12:21', '2021-05-12 00:12:21'),
(85, NULL, 3, NULL, '123', 'rsc/img/attach_fn/y2021/m05/orig/2021-05-12_091253.png', 34, 1, 'kani', '::1', '2021-05-12 09:12:53', '2021-05-12 00:12:53'),
(86, NULL, 3, NULL, '123ｓｓ', '', 35, 1, 'kani', '::1', '2021-05-12 09:13:02', '2021-05-12 00:39:41'),
(87, NULL, 3, NULL, '８８ｄｄ', '', 36, 1, 'kani', '::1', '2021-05-12 09:13:29', '2021-05-12 00:38:27'),
(88, NULL, 3, NULL, '８８ｄ', '', 0, 0, NULL, NULL, '2021-05-12 09:21:17', '2021-05-12 00:21:17'),
(89, NULL, 3, NULL, '８８ｄｄ', '', 0, 0, NULL, NULL, '2021-05-12 09:23:01', '2021-05-12 00:23:01'),
(90, NULL, 3, NULL, '８８ｓｓ', '', 0, 0, NULL, NULL, '2021-05-12 09:31:38', '2021-05-12 00:31:38'),
(91, NULL, 3, NULL, '８８ｓｓ', '', 0, 0, NULL, NULL, '2021-05-12 09:33:35', '2021-05-12 00:33:35'),
(92, NULL, 3, NULL, '８８ｄｄ', '', 0, 0, NULL, NULL, '2021-05-12 09:34:51', '2021-05-12 00:34:51'),
(93, NULL, 3, NULL, '', 'rsc/img/attach_fn/y2021/m05/orig/20210331a2.png', 33, 0, NULL, NULL, '2021-05-12 09:49:42', '2021-05-12 00:49:42'),
(94, NULL, 3, NULL, 'ddd', NULL, 34, 0, NULL, NULL, '2021-05-12 09:59:48', '2021-05-12 01:06:45'),
(95, NULL, 3, NULL, 'aaa', '', 35, 0, NULL, NULL, '2021-05-12 09:59:54', '2021-05-12 00:59:54'),
(96, NULL, 3, NULL, '', 'rsc/img/attach_fn/y2021/m05/orig/imori.zip', 36, 1, 'kani', '::1', '2021-05-12 10:00:09', '2021-05-12 01:00:09'),
(97, NULL, 3, NULL, '', 'rsc/img/attach_fn/y2021/m05/orig/20210331a2.png', 36, 1, 'kani', '::1', '2021-05-12 10:00:33', '2021-05-12 01:00:33'),
(98, NULL, 3, NULL, '', 'rsc/img/attach_fn/y2021/m05/orig/20210331a2.png', 36, 1, 'kani', '::1', '2021-05-12 10:02:45', '2021-05-12 01:02:45'),
(99, NULL, 3, NULL, '', 'rsc/img/attach_fn/y2021/m05/orig/20210331a2.png', 36, 1, 'kani', '::1', '2021-05-12 10:03:02', '2021-05-12 01:03:02'),
(100, NULL, 3, NULL, 'aaaa', '', 36, 0, NULL, NULL, '2021-05-12 10:05:13', '2021-05-12 01:05:44'),
(101, NULL, 3, NULL, 'aaああああｄｄ', 'rsc/img/attach_fn/y2021/m05/orig/20210331a2.png', 37, 0, NULL, NULL, '2021-05-12 12:14:08', '2021-05-12 03:19:14'),
(102, NULL, 3, NULL, 'あああｄｄ', '', 38, 1, 'kani', '::1', '2021-05-12 12:19:30', '2021-05-12 03:19:37'),
(103, NULL, 3, NULL, 'あああ', '', 38, 0, NULL, NULL, '2021-05-12 12:19:48', '2021-05-12 03:19:48'),
(104, NULL, 3, NULL, 'あああ', '', 39, 0, NULL, NULL, '2021-05-12 12:19:51', '2021-05-12 03:19:51'),
(105, NULL, 3, NULL, 'あああ', '', 40, 0, NULL, NULL, '2021-05-12 12:20:03', '2021-05-12 03:20:03'),
(106, NULL, 3, NULL, 'あああいい', 'rsc/img/attach_fn/y2021/m05/orig/20210331a2.png', 41, 0, NULL, NULL, '2021-05-12 12:20:14', '2021-05-12 03:20:25'),
(107, NULL, 3, NULL, 'ｄ', '', 42, 0, NULL, NULL, '2021-05-12 12:21:59', '2021-05-12 03:21:59'),
(108, NULL, 3, NULL, 'ああ', '', 43, 0, NULL, NULL, '2021-05-12 12:22:45', '2021-05-12 03:22:45'),
(109, NULL, 3, NULL, 'かにうさぎ', '', 44, 0, NULL, NULL, '2021-05-12 12:22:56', '2021-05-12 03:23:16'),
(110, NULL, 3, NULL, 'ああ', 'rsc/img/attach_fn/y2021/m05/orig/iseki.jpg', 45, 1, 'kani', '::1', '2021-05-12 12:23:05', '2021-05-12 03:23:05'),
(111, NULL, 3, NULL, 'あああ', 'rsc/img/attach_fn/y2021/m05/orig/20210331a2.png', 45, 1, 'kani', '::1', '2021-05-12 12:23:34', '2021-05-12 03:23:34'),
(112, NULL, 3, NULL, 'あああああ', 'rsc/img/attach_fn/y2021/m05/orig/imori.png', 45, 0, NULL, NULL, '2021-05-12 12:23:54', '2021-05-12 03:24:01'),
(113, NULL, 3, NULL, 'usagi', '', 46, 0, NULL, NULL, '2021-05-12 13:11:46', '2021-05-12 04:11:46'),
(114, NULL, 3, NULL, 'うさぎまる', '', 47, 0, NULL, NULL, '2021-05-12 14:23:40', '2021-05-12 05:23:40'),
(115, NULL, 3, NULL, 'あさがお３', '', 48, 0, 'kani', '::1', '2021-05-12 14:38:40', '2021-05-12 05:44:30'),
(116, NULL, 3, NULL, 'あああ', '', 49, 0, 'kani', '::1', '2021-05-16 23:37:24', '2021-05-16 14:37:25'),
(117, NULL, 3, NULL, 'あああｃ', 'rsc/img/attach_fn/y2021/m05/orig/imori.png', 50, 0, 'kani', '::1', '2021-05-16 23:37:40', '2021-05-16 14:37:40'),
(118, NULL, 3, NULL, 'ｚｚｚ', 'rsc/img/attach_fn/y2021/m05/orig/sample1.pdf', 51, 0, 'kani', '::1', '2021-05-16 23:37:50', '2021-05-16 14:37:51'),
(119, NULL, 3, NULL, 'aaa', '', 52, 0, 'kani', '::1', '2021-05-16 23:51:35', '2021-05-16 14:51:35');

-- --------------------------------------------------------

--
-- テーブルの構造 `msg_board_goods`
--

CREATE TABLE `msg_board_goods` (
  `id` int(11) NOT NULL,
  `msg_board_id` int(11) DEFAULT NULL COMMENT 'メッセージボードID',
  `user_id` int(11) DEFAULT NULL COMMENT 'ユーザーID',
  `sort_no` int(11) DEFAULT '0' COMMENT '順番',
  `delete_flg` tinyint(1) DEFAULT '0' COMMENT '無効フラグ',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新者',
  `ip_addr` varchar(40) DEFAULT NULL COMMENT 'IPアドレス',
  `created` datetime DEFAULT NULL COMMENT '生成日時',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='メッセージボードGood';

-- --------------------------------------------------------

--
-- テーブルの構造 `nekos`
--

CREATE TABLE `nekos` (
  `id` int(11) NOT NULL,
  `neko_val` int(11) DEFAULT NULL,
  `neko_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `neko_date` date DEFAULT NULL,
  `neko_group` int(11) DEFAULT NULL COMMENT '猫種別',
  `en_sp_id` int(11) DEFAULT NULL COMMENT '絶滅危惧種ID',
  `neko_dt` datetime DEFAULT NULL,
  `neko_flg` tinyint(4) DEFAULT '0' COMMENT 'ネコフラグ',
  `img_fn` varchar(256) DEFAULT NULL COMMENT '画像ファイル名',
  `note` text CHARACTER SET utf8 COMMENT '備考',
  `sort_no` int(11) DEFAULT '0' COMMENT '順番',
  `delete_flg` tinyint(1) DEFAULT '0' COMMENT '無効フラグ',
  `update_user` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新者',
  `ip_addr` varchar(40) CHARACTER SET utf8 DEFAULT NULL COMMENT 'IPアドレス',
  `created` datetime DEFAULT NULL COMMENT '生成日時',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- テーブルのデータのダンプ `nekos`
--

INSERT INTO `nekos` (`id`, `neko_val`, `neko_name`, `neko_date`, `neko_group`, `en_sp_id`, `neko_dt`, `neko_flg`, `img_fn`, `note`, `sort_no`, `delete_flg`, `update_user`, `ip_addr`, `created`, `modified`) VALUES
(1, 2000, 'おキャット様', '2014-04-01', 2, NULL, '2014-12-12 00:00:00', 0, 'DSC_0010.jpg', '大きな\n猫', 24, 1, 'kani', '126.219.137.211', NULL, '2020-07-03 06:00:53'),
(2, 2000, '三毛A', '2014-04-02', 3, NULL, '2014-12-12 00:00:01', 0, '', '', 32, 1, 'kani', '126.219.137.211', NULL, '2019-02-17 14:00:29'),
(4, 2000, 'シャム猫', '2014-04-04', 0, NULL, '2014-12-12 00:00:03', 0, '', '', 38, 1, 'kani', '126.219.137.211', NULL, '2020-07-03 07:44:41'),
(5, 2000, '近所のミーヤン', '2014-04-03', NULL, NULL, '2014-12-12 00:00:02', 0, '', '', 35, 1, 'kani', '126.219.137.211', NULL, '2020-09-14 09:46:12'),
(6, 3, 'ニャーちゃん', '2014-04-03', 2, NULL, '2014-12-12 00:00:02', 0, '', '', 40, 1, 'kani', '126.219.137.211', NULL, '2020-09-14 09:47:00'),
(7, 3, 'ステトラ', '2014-04-03', NULL, NULL, '2014-12-12 00:00:02', 0, '', '', 41, 1, 'kani', '126.219.137.211', NULL, '2020-09-14 09:49:03'),
(8, 3, 'ノミコ', '2014-04-03', 2, NULL, '2014-12-12 00:00:02', 0, '', '', 42, 1, 'kani', '126.219.137.211', NULL, '2020-09-14 09:50:02'),
(9, 111, 'ゴボウ', '1970-01-01', 2, NULL, '2014-04-28 10:04:00', 0, '', '白菜とサラダセット', 43, 1, 'kani', '126.219.137.211', NULL, '2019-02-17 14:00:29'),
(10, 123, 'のらくん', '1970-01-01', NULL, NULL, '2014-04-28 10:05:00', 0, '', '', 39, 1, 'kani', '126.219.137.211', NULL, '2020-09-14 09:47:19'),
(11, 3, 'トト', '2018-04-03', NULL, NULL, '2014-12-12 00:00:02', 0, '', '', 36, 1, 'kani', '126.219.137.211', '2018-03-09 09:00:20', '2020-09-14 09:50:29'),
(17, 3, '痩せ猫', '2014-04-03', NULL, NULL, '2014-12-12 00:00:02', 0, '', '', 33, 1, 'kani', '126.219.137.211', '2018-03-20 06:39:26', '2020-09-14 09:50:45'),
(19, 111, 'ニャーニャー', '2018-10-18', 5, NULL, '2018-03-31 14:18:59', 0, '', 'a', 34, 1, 'kani', '126.219.137.211', '2018-03-20 06:41:48', '2019-02-17 14:00:29'),
(20, 3, 'リリー', '2014-04-03', NULL, NULL, '2014-12-12 00:00:02', 0, '', '', 37, 1, 'kani', '126.219.137.211', '2018-03-20 07:45:08', '2020-09-14 09:46:28'),
(22, 111, 'ハマダイコン', '1970-01-01', 2, NULL, '2014-04-29 10:04:00', 0, '', '砂浜に生える大根', 44, 1, 'kani', '::1', '2018-03-30 09:46:18', '2018-03-30 00:46:18'),
(26, 1, '', NULL, NULL, NULL, NULL, 0, '26_DSC_0037.jpg', '', 14, 1, 'kani', '126.219.137.211', '2018-04-19 22:28:39', '2019-02-17 13:57:43'),
(29, 124, 'ビッグキャット', NULL, NULL, NULL, NULL, 0, '29_DSC_0037.jpg', '', 17, 1, 'kani', '126.219.137.211', '2018-04-19 22:57:16', '2019-02-17 14:00:29'),
(37, 0, '王家の猫', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '', 45, 1, 'kani', '126.219.137.211', '2018-04-19 23:28:36', '2020-09-14 09:47:34'),
(38, NULL, 'ルガルガン', NULL, NULL, NULL, NULL, 0, '', '', 46, 1, 'kani', '126.219.137.211', '2018-04-19 23:31:42', '2019-02-17 14:00:29'),
(39, 0, 'チョロネコ', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '', 47, 1, 'kani', '126.219.137.211', '2018-04-19 23:33:35', '2020-09-14 09:48:05'),
(40, 0, 'エネコロロ', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '', 48, 1, 'kani', '126.219.137.211', '2018-04-19 23:34:50', '2020-09-14 09:48:16'),
(41, NULL, 'AFD', NULL, NULL, NULL, NULL, 0, '', '', 49, 1, 'kani', '126.219.137.211', '2018-04-19 23:36:30', '2019-02-17 14:00:29'),
(42, NULL, 'ヌガー', NULL, NULL, NULL, NULL, 0, '', '', 31, 1, 'kani', '126.219.137.211', '2018-04-19 23:37:50', '2019-02-17 14:00:29'),
(43, 0, 'タヌキのように太った猫', '0000-00-00', 2, NULL, '0000-00-00 00:00:00', 0, '', '', 30, 1, 'kani', '126.219.137.211', '2018-04-19 23:38:45', '2020-09-14 09:45:47'),
(44, NULL, 'ライオン', NULL, NULL, NULL, NULL, 0, '', '', 29, 1, 'kani', '126.219.137.211', '2018-04-19 23:46:47', '2019-02-17 14:00:29'),
(45, 0, 'B', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '', 28, 1, 'kani', '126.219.137.211', '2018-04-19 23:46:57', '2020-09-14 09:45:29'),
(46, NULL, 'A', NULL, NULL, NULL, NULL, 0, 'DSC_0010.jpg', '', 27, 1, 'kani', '126.219.137.211', '2018-04-20 07:28:28', '2019-02-17 14:00:29'),
(47, NULL, 'ビッグマスター', '2018-04-17', NULL, NULL, NULL, 0, 'DSC_0037 (1).jpg', '', 26, 1, 'kani', '126.219.137.211', '2018-04-20 07:28:43', '2019-02-17 14:00:29'),
(49, 0, 'チョコ', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '', 50, 1, 'kani', '126.219.137.211', '2018-04-20 07:31:06', '2020-09-14 09:53:25'),
(50, NULL, 'TEST\\\'', NULL, NULL, NULL, NULL, 0, 'DSC_0037.jpg', 'TEST\\nTEST2', 25, 1, 'kani', '126.219.137.211', '2018-04-20 10:45:34', '2019-02-17 14:00:29'),
(51, 0, 'ビッグマン', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '', 37, 1, 'kani', '126.219.137.211', '2018-04-20 10:46:21', '2020-09-14 09:54:28'),
(55, 124, 'アカマムシ', NULL, 1, NULL, NULL, 0, '', '', 23, 1, 'kani', '126.219.137.211', '2018-04-24 07:06:22', '2019-02-17 14:00:29'),
(56, 1, '\'\' = \'\'', '2014-04-01', 2, NULL, '2014-12-12 00:00:00', 0, '', '大きな\n猫', 22, 1, 'kani', '126.219.137.211', '2018-04-24 13:56:44', '2019-02-17 14:00:29'),
(57, 1, '\'\' = \'\'', '2014-04-01', 2, NULL, '2014-12-12 00:00:00', 0, '', '大きな\n猫', 21, 1, 'kani', '126.219.137.211', '2018-04-24 13:58:23', '2019-02-17 14:00:29'),
(60, NULL, 'A2', NULL, 1, NULL, NULL, 0, 'DSC_0010.jpg', '', 19, 1, 'kani', '126.219.137.211', '2018-04-24 14:01:49', '2019-02-17 14:00:29'),
(63, 300, 'ザ・ビッグ2', NULL, 1, NULL, NULL, 0, 'DSC_0037 (1).jpg', '', 18, 1, 'kani', '126.219.137.211', '2018-04-26 06:46:01', '2019-02-17 14:00:29'),
(64, 123, '<input />', NULL, 1, NULL, NULL, 0, '53_hyomon.jpg', '', 12, 1, 'kani', '126.219.137.211', '2018-08-22 16:49:38', '2019-02-17 13:57:55'),
(65, 1, '対馬山猫', '2018-09-30', 1, NULL, '0000-00-00 00:00:00', 1, '58_2017-11-24_123306_DSC_0066.jpg', '', 10, 1, 'kani', '126.219.137.211', '2018-08-22 17:11:38', '2020-09-14 09:52:45'),
(66, 1, 'アイルー', '0000-00-00', 21, NULL, '0000-00-00 00:00:00', 0, '66_DSC_0054 (1).jpg', '傭兵', 49, 0, '', '126.219.137.211', '2018-08-27 16:31:59', '2020-09-14 10:11:51'),
(67, 22, 'ベンガルトラ', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '67_DSC_0037 (1).jpg', '', 13, 1, 'kani', '126.219.137.211', '2018-08-27 19:33:05', '2020-09-14 09:51:15'),
(69, 0, 'TEST', '2018-10-16', 1, NULL, NULL, 0, '1498312069338.jpg', '<input />\"neko\",\'inu\'\n\n全長オス14センチメートル、メス18センチメートル[4]。頭胴長オス4.6-7.5センチメートル、メス5.2-8センチメートル[4]。背面の体色は黒や黒褐色、暗褐色[3][4]。背面に地衣類状の明色斑や、正中線に沿って橙色の筋模様が入る個体もいるなど変異が大きい[4]。 腹面の色彩は赤色や黄色で、不規則に黒い斑紋が入る個体もいる[3]。指趾下面の体色は明色[3][6]。\n\n繁殖期になるとオスの尾は幅広くなる[4]。\n\nシリケンイモリは歩くのが遅いのですぐ捕まる。捕食されないのがなぞであるが、おそらく皮膚のテトロドトキシンが関係しているのかな。\n\nうーん。わからん。', 9, 1, 'kani', '126.219.137.211', '2018-10-02 22:01:00', '2019-02-17 14:00:29'),
(75, 99, 'ガーラ', '2018-10-18', 2, NULL, NULL, 1, 'hyomon.jpg', 'TEST2', 8, 1, 'kani', '126.219.137.211', '2018-10-10 13:51:08', '2019-02-17 14:00:29'),
(76, 1, '猫吉', '2018-09-30', 1, NULL, '0000-00-00 00:00:00', 1, 'DSC_0748.jpg', 'TEST', 11, 1, 'kani', '126.219.137.211', '2018-10-18 07:55:26', '2020-09-14 09:52:11'),
(77, 104, 'ロイヤルアナロスタン', '2020-09-14', 21, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914115208_uramachino1.jpg', 'シートン動物記「裏まちのすてネコ」に登場する野良猫。\n心が荒れすさんだ人間たちの中、たくましく生きる猫。人間に捕まって品評会に出場させられたことがある。\nロイヤルアナロスタンという名前は品評会に出された時の呼び名。', 7, 0, '', '126.219.137.211', '2018-10-18 15:58:19', '2020-09-15 02:34:22'),
(80, 999, 'ネコバス', '2018-12-02', 8, NULL, '0000-00-00 00:00:00', 1, 'rsc/img/img_fn/y2019/m02/orig/20190217225931_DSC_0679.jpg', '体内に人間などをいれて運ぶ大型猫', 46, 0, 'kani', '126.219.137.211', '2018-10-19 21:01:01', '2020-09-14 07:56:50'),
(82, 1, 'アントニオ', '0000-00-00', 22, NULL, '0000-00-00 00:00:00', 0, '66_DSC_0054 (1).jpg', '侠客。すでに亡き猫。死後、剥製として丁重に扱われている。', 40, 0, '', '126.219.137.211', '2018-10-21 22:55:12', '2020-09-14 09:37:45'),
(83, 999, 'ジジ', '2018-12-14', 2, NULL, '0000-00-00 00:00:00', 1, 'rsc/img/img_fn/y2019/m02/orig/20190217225845_DSC_0037.jpg', '飛行型宅配業者のネコ', 45, 0, 'kani', '126.219.137.211', '2018-10-21 23:01:10', '2020-09-14 09:09:48'),
(88, 999, 'ノンタン', '2018-12-31', 17, NULL, '0000-00-00 00:00:00', 1, 'rsc/img/img_fn/y2019/m02/orig/20190217225951_DSC_0700.jpg', '幼稚園児に知られている。', 47, 0, 'kani', '126.219.137.211', '2018-10-22 07:30:22', '2020-09-15 02:34:01'),
(89, NULL, '愚かではない猫', NULL, 1, NULL, NULL, 0, '', 'TEST', 2, 1, NULL, '::1', '2018-10-22 07:30:44', '2021-04-10 00:53:22'),
(90, 123, 'レオ', '2018-12-07', 20, NULL, '0000-00-00 00:00:00', 1, 'rsc/img/img_fn/y2019/m02/orig/20190217225552_53_hyomon.jpg', '大帝', 50, 0, '', '126.219.137.211', '2018-12-01 07:21:06', '2020-09-14 09:42:19'),
(91, 123, '犬のような猫', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '', 51, 1, '', '126.219.137.211', '2020-06-13 22:14:56', '2020-09-14 09:48:46'),
(92, 123, 'シルベスター', '0000-00-00', 14, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m06/orig/20200616161522_tamamusi.jpg', '見るからに悪党ヅラした白黒ぶち猫。銃、爆薬などを扱う。', 43, 0, '', '126.219.137.211', '2020-06-13 22:16:53', '2020-09-14 09:39:06'),
(93, 456, 'いのしし２', NULL, NULL, NULL, NULL, 0, '', '', 7, 1, NULL, '::1', '2020-06-13 22:16:53', '2020-06-17 04:38:27'),
(94, 123, 'たぬき', NULL, NULL, NULL, NULL, 0, '', '', 8, 1, NULL, '::1', '2020-06-13 22:19:20', '2020-06-17 04:38:51'),
(96, 103, 'ルドルフ', '2020-09-14', 13, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914111936_2020-09-14_111936.jpg', '「ルドルフとイッパイアッテナ」の主人公猫。\n若輩だがイッパイアッテナから文字や処世術を学び日々成長していく。', 4, 0, 'kani', '126.219.137.211', '2020-06-17 13:38:38', '2020-09-17 01:30:30'),
(97, NULL, '', NULL, 1, NULL, NULL, 0, '', '', -1, 1, NULL, '::1', '2020-06-17 13:38:40', '2020-06-17 04:38:51'),
(98, 123, 'ダヤン', '2020-02-02', 5, NULL, '2012-12-12 12:12:12', 0, '', '最近、書店でよく見かける。', 48, 0, 'kani', '126.219.137.211', '2020-06-17 13:39:01', '2020-09-14 09:41:41'),
(99, 1234, 'カリン様', '0000-00-00', 17, NULL, '0000-00-00 00:00:00', 0, '', '豆や水をくれる。', 49, 0, 'kani', '126.219.137.211', NULL, '2020-09-14 07:20:25'),
(100, 1001, 'ソックス', '0000-00-00', 14, NULL, '0000-00-00 00:00:00', 0, '', '足だけが白い超巨体の黒猫。北谷町に住む。', 33, 0, 'kani', '126.219.137.211', '0000-00-00 00:00:00', '2020-09-15 02:35:33'),
(101, 1002, 'サバ', '0000-00-00', 15, NULL, '0000-00-00 00:00:00', 0, '', 'グーグーの前に飼われいた亡き猫', 41, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(102, 1001, 'CatDog', '0000-00-00', 19, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914153209_CatDog.jpeg', '半猫半犬のMAD生物。猫側の方は積極的、犬側はややひかえめ。アメリカのアニメ。主題歌が良い。', 19, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:09'),
(103, 1002, 'ジョバンニ', '0000-00-00', 14, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914133954_9ae6e0d5.png', '「銀河鉄道の夜」の主人公猫。孤独な少年。友人のカンパネルラと共に銀河鉄道の乗車し、様々な星を訪れる。', 11, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:18'),
(104, 1003, 'フィリックス', '0000-00-00', 14, NULL, '0000-00-00 00:00:00', 0, '', '10円ガムで有名な猫。よく裁判になった。', 43, 0, '', '126.219.137.211', NULL, '2020-09-14 09:39:20'),
(108, 0, '青狸', '0000-00-00', 21, NULL, '0000-00-00 00:00:00', 0, '', '青狸と呼ばれると怒る。', 41, 0, '', '126.219.137.211', NULL, '2020-09-15 02:43:22'),
(109, 0, '長靴をはいた猫', '0000-00-00', 10, NULL, '0000-00-00 00:00:00', 0, '', '軍師猫。策略に長けており権力者に取り入ったり、怪物を計略に陥れたりする。ついには主人を領主にすることに成功する。', 41, 0, '', '126.219.137.211', NULL, '2020-09-17 01:31:54'),
(110, 0, 'トム', '0000-00-00', 21, NULL, '0000-00-00 00:00:00', 0, '', '包丁、斧、銃、爆弾、毒薬など各種危険物を扱う。よく薄っぺらになる。', 49, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(111, 0, 'ミー', '0000-00-00', 0, NULL, '0000-00-00 00:00:00', 0, '', '多くの猫はこの名を持つ。', 42, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:26'),
(112, 0, 'リス猫', '0000-00-00', 0, NULL, '0000-00-00 00:00:00', 0, '', '今帰仁村で遭遇した猫。小さい体なのに、リスのような大きなしっぽを持った美しい猫。', 36, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:26'),
(113, 0, 'ニャロメ', '0000-00-00', 21, NULL, '0000-00-00 00:00:00', 0, '', '赤塚作品に登場する猫。', 46, 0, '', '126.219.137.211', NULL, '2020-09-14 09:41:23'),
(114, 0, 'チャトラン', '0000-00-00', 19, NULL, '0000-00-00 00:00:00', 0, '', '映画、子猫物語に出てくる茶トラ。', 45, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(115, 123, 'ニャース', '2020-02-02', 1, NULL, '2012-12-12 12:12:12', 0, '', '20年以上も黄色いネズミを追い求め続けている猫。', 27, 0, 'kani', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(116, 0, 'スナネコ', '0000-00-00', 20, NULL, '0000-00-00 00:00:00', 0, '', '独特な表情で有名な野生のネコ', 23, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(117, 0, 'ミケ', '0000-00-00', 3, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914141107_ur170801_nekoko07.jpg', 'FX狂いで借金まみれの猫。強制労働所で2兆年働くことになっている。お金にだらしがない猫だがいい猫である。勢い任せにFXに投資し続けるため「通貨」たちから心配されたり好かれたりしている。', 15, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:13'),
(118, 950, '『吾輩』', '2020-09-15', 12, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914113438_20100919_666548.jpg', '「吾輩は猫である」主人公猫。名前はまだない。観察力と語彙力がすごい。人間の言葉は話さないものの一般の人間以上の知性を備える。自分は人間の言葉を理解できるが、猫の言葉を人間は理解しないみたいな事を言っている。知性があるとはいえ猫であることをわきまえており、\"猫\"を踏み越えた行動をあまりしない。', 6, 0, '', '126.219.137.211', NULL, '2020-09-17 01:39:11'),
(119, 0, 'フィガロ', '0000-00-00', 14, NULL, '0000-00-00 00:00:00', 0, '', '白黒のぶち猫。嘘つき人造人間に厳しい態度をとる。', 41, 0, '', '126.219.137.211', NULL, '2020-09-14 09:38:47'),
(120, 0, 'ネコマムシ', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '侠客', 47, 0, '', '126.219.137.211', NULL, '2020-09-14 08:28:35'),
(121, 0, 'サーバル', '0000-00-00', 20, NULL, '0000-00-00 00:00:00', 0, '', '友達', 50, 0, '', '126.219.137.211', NULL, '2020-09-14 09:42:24'),
(122, 0, 'スフィンクス', '0000-00-00', 6, NULL, '0000-00-00 00:00:00', 0, '', '毛のない猫。ただし産毛は生えているようだ。エジプト産ではなくイギリス産。', 34, 0, '', '126.219.137.211', NULL, '2020-09-15 02:37:32'),
(123, 0, '白君', '0000-00-00', 0, NULL, '0000-00-00 00:00:00', 0, '', '', 43, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:26'),
(124, 0, 'シンバ', '0000-00-00', 20, NULL, '0000-00-00 00:00:00', 0, '', '王', 49, 0, '', '126.219.137.211', NULL, '2020-09-14 09:42:13'),
(125, 0, 'ダッチェス', '0000-00-00', 17, NULL, '0000-00-00 00:00:00', 0, '', 'アメリカのおしゃれ猫。', 47, 0, '', '126.219.137.211', NULL, '2020-09-14 09:41:33'),
(126, 0, 'トニー', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '健康食品を宣伝していたトラ。同僚にゾウやサルがいる。', 44, 0, '', '126.219.137.211', NULL, '2020-09-14 07:48:56'),
(127, 0, '猫又', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '20年生きた老猫が化けるという。\n人を食らう化け猫になる場合もあれば、恩返しをする化け猫もいる。', 44, 0, '', '126.219.137.211', NULL, '2020-09-14 07:14:34'),
(128, 0, '猫田さん', '0000-00-00', 17, NULL, '0000-00-00 00:00:00', 0, '', '論客', 43, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(129, 123, 'デスマスク', '2020-02-02', 1, NULL, '2012-12-12 12:12:12', 0, '', 'シャム猫が珍しい時代にいた近所のネコ。その風貌から子供らからデスマスクというあだ名をつけられた。警戒心がすさまじく、とにかくよく逃げる。', 28, 0, 'kani', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(130, 123, 'イリオモテヤマネコ', '2020-02-02', 20, NULL, '2012-12-12 12:12:12', 0, '', '天然記念物。ヤママヤーとして知られていた。', 46, 0, 'kani', '126.219.137.211', NULL, '2020-09-14 09:38:25'),
(131, 123, '猫疥癬', '2020-02-02', 10, NULL, '2012-12-12 12:12:12', 0, '', '猫の病気。野良猫がよく感染する。', 31, 0, 'kani', '126.241.217.204', NULL, '2021-03-22 12:12:02'),
(132, 0, '100万回生きたオスネコ', '0000-00-00', 10, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914142431_500_Ehon_94.jpg', '「100万回生きた猫」の主人公猫。何度でも生き返るオスネコ。何十万回と死んでいるためか、尊大な性格をしている。', 17, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:09'),
(133, 0, '', '0000-00-00', 0, NULL, '0000-00-00 00:00:00', 0, '', '', 2, 1, 'kani', '::1', NULL, '2020-08-15 15:24:24'),
(134, 123, 'ルナ', '2020-02-02', 17, NULL, '2012-12-12 12:12:12', 0, '', '学徒戦闘員の猫。', 45, 0, 'kani', '126.219.137.211', NULL, '2020-09-14 09:09:21'),
(135, 123, 'ガーフィールド', '2020-02-02', 1, NULL, '2012-12-12 12:12:12', 0, '', '文房具のオレンジ猫。クール。', 42, 0, 'kani', '126.219.137.211', NULL, '2020-09-14 08:22:05'),
(136, 123, 'ガチマヤー', '2020-02-02', 10, NULL, '2012-12-12 12:12:12', 0, '', 'よくエサを催促する猫。沖縄方言のスラングであり、食い意地をはる人間もこのように呼ばれる。', 47, 0, 'kani', '126.219.137.211', NULL, '2020-09-14 08:20:43'),
(137, 0, 'タマ', '0000-00-00', 17, NULL, '0000-00-00 00:00:00', 0, '', '某家族アニメのネコ。昔は魚を盗む猫だったが、いまは普通の猫になっている。', 37, 0, '', '126.219.137.211', NULL, '2020-09-14 08:16:37'),
(138, 0, 'クロ', '0000-00-00', 13, NULL, '0000-00-00 00:00:00', 0, '', 'この名前のネコはたくさんいる。', 46, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(139, 0, 'エネコ', '0000-00-00', 0, NULL, '0000-00-00 00:00:00', 0, '', '種族値がかなり低い', 48, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:26'),
(140, 123, 'うなぎネコ', '0000-00-00', 14, NULL, '0000-00-00 00:00:00', 0, '', '猫工船に1コマだけ登場する。\nときおり、「うなぎ猫」と称される猫の写真がインターネット上に現れる。', 32, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(141, 123, '井上トロ', '0000-00-00', 17, NULL, '0000-00-00 00:00:00', 0, '', '人間になることを目標とする猫', 48, 0, '', '126.219.137.211', NULL, '2020-09-14 09:41:48'),
(142, 123, 'ネコートさん', '0000-00-00', 12, NULL, '0000-00-00 00:00:00', 0, '', 'ハンターの案内をする。', 42, 0, '', '126.219.137.211', NULL, '2020-09-14 09:11:45'),
(143, 123, 'ゴメス', '0000-00-00', 0, NULL, '0000-00-00 00:00:00', 0, '', '', 50, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:26'),
(144, 123, 'よだれ', '0000-00-00', 22, NULL, '0000-00-00 00:00:00', 0, '', '瀬底島の公園を根城にしている野良の雌猫。いつもよだれをたらし悲壮感を漂わせる。とても人懐こい。\n', 38, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(145, 123, 'ニャビー', '0000-00-00', 5, NULL, '0000-00-00 00:00:00', 0, '', 'ムーランドと暮らしていた猫', 25, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(146, 0, '三毛子', '0000-00-00', 3, NULL, '0000-00-00 00:00:00', 0, '', '「吾輩は猫である」に登場する美人猫。主人公猫のことを先生と呼ぶ。', 21, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:05'),
(147, 123, 'テグー', '2020-02-02', 17, NULL, '2012-12-12 12:12:12', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914135401_2020-09-14_015401.jpg', '瀬川ゆうき先生の漫画「森のテグー」の主人公猫。シニカルな純粋少年。友人にニヒルな人間の女の子、引きこもりがちな親を持つ精霊の子、薬物依存者（笹）の兄がいるパンダなどがいる。', 13, 0, 'kani', '126.219.137.211', NULL, '2020-09-15 02:34:13'),
(148, 123, 'セロ弾きのゴーシュに出てくる猫', '2020-02-02', 22, NULL, '2012-12-12 12:12:12', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914120854_551205.jpg', '人語をしゃべる猫。物腰が柔らかそうに見えて何かをたくらんでいそうな胡散臭い猫。ゴーシュの畑からとってきた青いトマトを、ゴーシュへの手土産にする。', 9, 0, 'kani', '126.219.137.211', NULL, '2020-09-15 02:34:22'),
(149, 123, '', '2020-02-02', 1, NULL, '2012-12-12 12:12:12', 0, '', '', 1, 1, 'kani', '::1', NULL, '2020-08-15 15:24:14'),
(150, 123, 'ロード・ゴート', '2020-09-14', 13, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914120138_2020-09-14_120138.jpg', '「猫の帰還」の主人公猫。第２次大戦の最中、軍人の主人を追って旅をする。', 8, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:22'),
(151, 123, 'うなぎ', '0000-00-00', 0, NULL, '0000-00-00 00:00:00', 0, '', '', 2, 1, 'kani', '::1', NULL, '2020-08-15 15:24:24'),
(152, 123, 'かま猫', '0000-00-00', 16, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914133358_IMG_20170918_115629-452x339.jpg', '「猫の事務所」の主人公猫。持病のため、かまの中で寝ているため灰をかぶったような色をしている。勤勉な猫。かまで寝るのは持病で体が冷えるため。', 10, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:18'),
(156, 123, 'カンパネルラ', '0000-00-00', 10, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914134100_2020-09-14_014100.png', '「銀河鉄道の夜」に登場する猫。博士の息子であり優等生。ジョバンニと共に銀河鉄道で星々を巡る。', 12, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:18'),
(157, 123, '猫村猫', '0000-00-00', 14, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914140143_2020-09-14_020143.jpg', '「今日の猫村さん」の主人公猫。家政婦事務所に所属する家政婦猫。\nいろいろ問題が多い家庭に派遣されている。\n鼻歌を歌いながら家事をする。野菜を細かく刻んでいれたオムライスである「ネコムライス」が得意料理。\n現在は雑誌編集のお手伝いをしている模様。（カーサの猫村さん）', 14, 0, '', '126.219.137.211', '2020-06-17 13:39:01', '2020-09-15 02:34:13'),
(158, 123, 'グーグー', '0000-00-00', 18, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914142524_COCP-35115.jpg', '「グーグーだって猫である」に登場する猫。日記漫画の実在猫。グーグーと鳴く。\n', 16, 0, '', '126.219.137.211', '2020-06-17 13:39:01', '2020-09-15 02:34:13'),
(162, 123, '車屋の黒', '0000-00-00', 13, NULL, '0000-00-00 00:00:00', 0, '', '「吾輩は猫である」に登場する猫。脂ぎった大きな猫。よく自慢話をする。', 20, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:09'),
(164, 0, 'ツブ', '0000-00-00', 14, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914152146_4524450000039.gif', '吉田戦車先生の漫画「おかゆネコ」に登場する猫。\nおかゆを中心に健康に気を使った料理を主人のために作る。\n知識は豊富でありかなり博識。（まわりの人間が変人ばかりというのはあるが...）', 18, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:09'),
(165, 0, '赤猫', '0000-00-00', 19, NULL, '0000-00-00 00:00:00', 0, '', '開発者の飼猫を追い回していた茶トラの野良猫。ゴミあさりが得意でボス格であったが2，3年程度で姿を消した。', 22, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:05'),
(166, 0, 'リビアヤマネコ', '0000-00-00', 20, NULL, '0000-00-00 00:00:00', 0, '', '家猫の先祖と言われている。キジトラにそっくり。', 24, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(167, 0, 'ジバニャン', '0000-00-00', 21, NULL, '0000-00-00 00:00:00', 0, '', '一時期はポケモンに肩を並べるほどの人気があった。', 26, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(168, 0, 'ガラルニャース', '0000-00-00', 1, NULL, '0000-00-00 00:00:00', 0, '', '鋼タイプに属するようになった。', 29, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(169, 0, 'エサちょーだい猫', '0000-00-00', 1, NULL, '0000-00-00 00:00:00', 0, '', 'あまりのもしつこさにノイローゼ気味になる。', 35, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(170, 0, 'カギしっぽ', '0000-00-00', 0, NULL, '0000-00-00 00:00:00', 0, '', '短い曲がったしっぽを持つ猫', 50, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:26'),
(171, 0, 'ネズミ捕り', '0000-00-00', 14, NULL, '0000-00-00 00:00:00', 0, '', 'スピード違反のネズミを捕まえる', 44, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(172, 1234, 'ネズミキラー', '0000-00-00', 5, NULL, '0000-00-00 00:00:00', 0, '', 'ねずみ退治に重宝される猫。\n沖縄ではボケてくるとビーチャー（臭い小型ネズミ）しか捕らなくなるといわれる。', 48, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(173, 123, '小鉄', '2020-02-02', 14, NULL, '2012-12-12 12:12:12', 0, '', '「じゃりン子チエ」に登場する猫。侠客。', 39, 0, 'kani', '126.219.137.211', '2020-06-17 13:39:01', '2020-09-14 08:17:32'),
(174, 0, ' 火車', '0000-00-00', 17, NULL, '0000-00-00 00:00:00', 0, '', 'リヤカーを引く猫。極悪人を地獄へ輸送する業務がある。', 45, 0, '', '126.219.137.211', NULL, '2020-09-14 09:38:13'),
(175, 0, 'ハローキティ', '0000-00-00', 17, NULL, '0000-00-00 00:00:00', 0, '', '最近は仕事を選ばないため好印象。', 51, 0, '', '126.219.137.211', NULL, '2020-09-14 09:11:35'),
(176, 0, 'ティガー', '0000-00-00', 8, NULL, '0000-00-00 00:00:00', 0, '', '黄色い熊の友人', 44, 0, '', '126.219.137.211', NULL, '2020-09-14 08:26:00'),
(177, 0, '青猫', '0000-00-00', 1, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m08/orig/20200806152201_IMG_0462.JPG', '', -1, 1, 'kani', '::1', NULL, '2020-08-15 15:27:12'),
(179, 0, 'イッパイアッテナ2', '2020-08-13', 5, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m09/orig/20200914110720_2020-09-14_110720.jpg', '「ルドルフとイッパイアッテナ」に登場する大猫。\n犬にも喧嘩に勝つ偉丈夫猫。強さだけでなく字を書いたり本を読んだりできる知性にも優れる。\n', 3, 0, '', '::1', '0000-00-00 00:00:00', '2021-04-08 23:24:15'),
(180, 0, 'バロン', '0000-00-00', 19, NULL, '0000-00-00 00:00:00', 0, '', '猫の事務所の所長', 30, 0, '', '126.219.137.211', NULL, '2020-09-15 02:34:01'),
(181, 0, 'おおやまねこ', '0000-00-00', 3, NULL, '0000-00-00 00:00:00', 0, '', '', -3, 1, 'kani', '::1', NULL, '2020-08-15 15:27:12'),
(182, 0, 'デカミー', '0000-00-00', 10, NULL, '0000-00-00 00:00:00', 0, 'rsc/img/img_fn/y2020/m08/orig/20200804141915_ga-ra.jpg', '全身猫疥癬にかかった猫。小さな女の子に「おいで、おいで」と言われてすり寄っていくが、その女の子に避けられてしまった。', 42, 0, '', '126.219.137.211', '2020-08-03 12:28:56', '2020-09-15 02:39:19'),
(183, 100, 'ブッチー', '2020-09-14', 14, NULL, '0000-00-00 00:00:00', 1, 'rsc/img/img_fn/y2020/m09/orig/20200914113054_2020-09-14_113054.jpg', '「ルドルフとイッパイアッテナ」に登場する猫。\nイッパイアッテナやルドルフらと行動をよく共にしている飼い猫。\n「ルドルフとノラねこブッチー」という続編が存在する。野良猫になったのかブッチー...。', 5, 0, '', '126.219.137.211', '2020-08-13 16:28:45', '2020-09-15 02:34:26'),
(184, 101, 'ピクルス', '0000-00-00', 24, NULL, '0000-00-00 00:00:00', 0, '', 'アニメ「ケチャップ」の好青年猫。料理人兼ウェイター。', 52, 0, 'kani', '126.219.137.211', '2020-08-25 10:42:55', '2020-09-14 09:42:43'),
(185, 102, 'シェフ・グーラシュ', '0000-00-00', 23, NULL, '0000-00-00 00:00:00', 0, '', '猫はグルメのNo.1', 53, 0, 'kani', '126.219.137.211', '2020-08-25 10:42:55', '2020-09-14 09:42:53'),
(186, 101, 'スカンピ', '0000-00-00', 21, NULL, '0000-00-00 00:00:00', 0, '', 'アニメ「ケチャップ」に登場する猫。妬みと嫉妬の猫。', 54, 0, 'kani', '126.219.137.211', '2020-08-25 10:43:57', '2020-09-14 09:43:05'),
(187, 102, 'マダム・コルジェット', '0000-00-00', 7, NULL, '0000-00-00 00:00:00', 0, '', 'アニメ「ケチャップ」に登場する猫。カフェのオーナー。', 55, 0, 'kani', '126.219.137.211', '2020-08-25 10:43:57', '2020-09-14 09:43:18'),
(188, 101, 'チシャ猫', '0000-00-00', NULL, NULL, '0000-00-00 00:00:00', 0, '', '名前とイメージがひもづかない、非常に不細工な猫。', 56, 0, 'kani', '126.219.137.211', '2020-08-25 10:44:35', '2021-02-19 06:35:31'),
(189, 102, '黒猫のタンゴ', '0000-00-00', 13, NULL, '0000-00-00 00:00:00', 0, '', '少年の心を翻弄する浮気性の猫', 57, 0, 'kani', '126.219.137.211', '2020-08-25 10:44:35', '2020-09-15 02:51:22'),
(190, 101, 'ニャンコ先生', '0000-00-00', 3, NULL, '0000-00-00 00:00:00', 0, '', '田舎に住む若者の先生と、フレンドノートを持ち歩く学生の先生がいる。', 58, 0, 'kani', '126.219.137.211', '2020-08-25 10:44:57', '2021-02-19 06:34:37'),
(191, 102, '八頭身アスキーアート', '0000-00-00', 17, NULL, '0000-00-00 00:00:00', 0, '', '　　　　　　　　　　 　 / ） ／￣￣￣￣￣￣￣\n　　 　 　 　 　 　 　 / /　|　全身から湧き上がるこの喜び！\n　　　　　　　　　　 / /　　＼　　　　　　　　　 ／￣￣￣\n　　　　　　　　 　 / /　　　　￣|／￣￣￣￣|　　１さんにとどけ！\n　　　 　 　 　 　 / /＿Λ　　　　 , -つ　　 　 ＼\n　　　　　　　 　/ / ´Д｀）　 .／__ノ　　　　　　　￣∨￣￣￣￣\n　　　　　　　　/　　　　＼　／ /　　 ⊂_ヽ､\n.　　　　　　　 |　　　　へ／ ／ 　 　 　 　 ＼＼　Λ＿Λ\n　　　　　　　 |　　　　ﾚ’　 /､二つ　　　　 　 ＼ （　´Д｀）\n　　　　　　　 |　　　　　／.　　　　　 　 　 　 　 >　　⌒ヽ\n　　　　　　　/　　　／　　　　　　　　　　　　 /　　　 へ ＼\n　　　　　　 /　 ／　　　　　　　　　　　　 　 /　 　 /　　 ＼＼\n　　　　　　/　 /　　　　　　　　　　　　　　 ﾚ　　ノ　　　　　ヽ_つ\n　　　　 ／　ノ　　　　　　　　　　　　　　　/　 /\n　　　_/　／　　　　　　　　　　　　　　　 /　 /|\n　 ノ　／　　　　　　　　　　　　　　　　　（　（　､\n⊂ -‘　　　　　　　　　　　　　　　　　　　 |　 |､　＼\n　　　　　　　　　　　　　　　 　 　 　 　 　 |　/　＼　⌒l\n　　　　　　　　　　　　　　　　　　　　　　　|　|　　　）　/\n　　　　　　　　　　　　　　　　　　　　　　ノ　 ）　　 し’\n　　　　　　　　　　　　　　　　　　　　　(＿／', 59, 0, 'kani', '126.219.137.211', '2020-08-25 10:44:57', '2020-09-14 09:44:36'),
(192, 500, 'ギコ猫アスキーアート', '0000-00-00', 17, NULL, '0000-00-00 00:00:00', 0, '', '　　　 ∧∧　　／￣￣￣￣￣\n　　　(,,ﾟДﾟ)＜　ゴルァ！\n　　 ⊂　　⊃　＼＿＿＿＿＿\n　　～|　　|\n　,,　　し`J', 60, 0, 'kani', '126.219.137.211', '2020-08-25 10:47:59', '2020-09-14 10:13:11'),
(193, 600, '長い猫', '0000-00-00', 17, NULL, '0000-00-00 00:00:00', 0, '', '世界中で有名な白い長猫。ニャースキョダイマックスもこの猫がモデルと思われる。', 61, 0, 'kani', '126.219.137.211', '2020-08-25 10:47:59', '2020-09-15 02:52:44'),
(194, NULL, 'うさぎ', NULL, 1, NULL, NULL, 0, 'rsc/img/img_fn/y2021/m04/orig/20210410094137_imori.png', 'TEST', 0, 0, '', '', '2021-04-10 09:38:47', '2021-04-10 00:38:47'),
(195, NULL, 'TEST 2', NULL, NULL, NULL, NULL, 0, '', '', -1, 0, '', '', '2021-04-10 09:39:44', '2021-04-10 00:39:44'),
(196, 19, '長老猫', NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 1, NULL, '126.219.137.211', '2021-04-10 14:33:23', '2021-04-10 08:02:11'),
(197, 1, '若猫', NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, '126.219.137.211', '2021-04-10 14:33:23', '2021-04-10 08:02:05'),
(198, 19, '長老猫', NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 1, NULL, '126.219.137.211', '2021-04-10 14:40:58', '2021-04-10 08:02:08'),
(199, 1, '若猫', NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, NULL, '126.219.137.211', '2021-04-10 14:40:58', '2021-04-10 08:02:03');

-- --------------------------------------------------------

--
-- テーブルの構造 `neko_groups`
--

CREATE TABLE `neko_groups` (
  `id` int(11) NOT NULL,
  `neko_group_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `sort_no` int(11) DEFAULT '0' COMMENT '順番',
  `delete_flg` tinyint(1) DEFAULT '0' COMMENT '無効フラグ',
  `update_user` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新者',
  `ip_addr` varchar(40) CHARACTER SET utf8 DEFAULT NULL COMMENT 'IPアドレス',
  `created` datetime DEFAULT NULL COMMENT '生成日時',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- テーブルのデータのダンプ `neko_groups`
--

INSERT INTO `neko_groups` (`id`, `neko_group_name`, `sort_no`, `delete_flg`, `update_user`, `ip_addr`, `created`, `modified`) VALUES
(1, 'ペルシャ', 0, 0, NULL, NULL, NULL, '2018-04-22 06:57:53'),
(2, 'ボンベイ', 0, 0, NULL, NULL, NULL, '2018-04-22 06:57:53'),
(3, '三毛', 0, 0, NULL, NULL, NULL, '2018-04-22 06:58:15'),
(4, 'シャム', 0, 0, NULL, NULL, NULL, '2018-04-22 06:58:15'),
(5, 'キジトラ', 0, 0, NULL, NULL, NULL, '2018-04-22 06:58:39'),
(6, 'スフィンクス', 0, 0, NULL, NULL, NULL, '2018-04-22 06:58:39'),
(7, 'メインクーン', 0, 0, NULL, NULL, NULL, '2018-04-22 06:59:21'),
(8, 'ベンガル', 0, 0, NULL, NULL, NULL, '2018-04-22 06:59:21');

-- --------------------------------------------------------

--
-- テーブルの構造 `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'ID',
  `username` varchar(50) DEFAULT NULL COMMENT 'ユーザー名',
  `password` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'パスワード',
  `role` varchar(20) DEFAULT NULL COMMENT '権限',
  `sort_no` int(11) DEFAULT '0' COMMENT '順番',
  `delete_flg` tinyint(4) DEFAULT '0' COMMENT '削除フラグ',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新ユーザー',
  `ip_addr` varchar(40) DEFAULT NULL COMMENT '更新IPアドレス',
  `created` datetime DEFAULT NULL COMMENT '作成日時',
  `modified` datetime DEFAULT NULL COMMENT '更新日時'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- テーブルのデータのダンプ `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `sort_no`, `delete_flg`, `update_user`, `ip_addr`, `created`, `modified`) VALUES
(1, 'yagi', 'f997247b8e456437055c20d681c3e7a15c5b6c35', 'oparator', 0, 0, 'kani', '::1', NULL, '2018-05-01 21:36:52'),
(2, 'buta', 'f84873b9689d4f255c8e0fe0ebcc4084bba12778', 'developer', 0, 0, 'kani', '::1', '2014-06-30 07:58:30', '2018-05-11 15:52:48'),
(3, 'kani', '10a4ef08902e5fa61ec06a003b48be8c526c08c3', 'master', 0, 0, 'buta', '::1', '2014-06-30 08:24:48', '2018-05-11 15:52:24'),
(4, 'kamakiri', 'e35a4768f8f60ceee01c96dbaef2217158aea2de', 'client', -1, 0, 'kani', '::1', '2018-05-01 21:38:35', '2018-05-01 21:38:35'),
(5, 'kame', 'f72ab3eb5cce6f6c7e69504c91b50de689772b0f', 'admin', -2, 0, 'kani', '::1', '2018-05-11 15:53:11', '2018-05-11 15:53:11'),
(6, 'ookami', '6948c0790d5d9a2ca5078fc67c9aa937c2072a5a', 'oparator', -3, 0, 'kani', '::1', '2018-09-01 23:39:27', '2018-09-01 23:39:28'),
(7, 'test_user', 'a8b818fd3c096f9ed0f8f1ca2207b3ae0d8c069e', 'admin', -4, 0, 'kani', '::1', '2018-09-29 15:33:40', '2018-09-29 15:33:47');

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_commentmeta`
--

CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_comments`
--

CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) UNSIGNED NOT NULL,
  `comment_post_ID` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `wp_comments`
--

INSERT INTO `wp_comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`) VALUES
(1, 1, 'WordPress コメントの投稿者', 'wapuu@wordpress.example', 'https://wordpress.org/', '', '2018-12-11 14:23:39', '2018-12-11 05:23:39', 'こんにちは、これはコメントです。\nコメントの承認、編集、削除を始めるにはダッシュボードの「コメント画面」にアクセスしてください。\nコメントのアバターは「<a href=\"https://gravatar.com\">Gravatar</a>」から取得されます。', 0, '1', '', '', 0, 0),
(2, 10, 'Giaoly.org', 'leoratrower@gmail.com', 'http://Giaoly.org/en/?p=100', '173.44.167.22', '2019-01-05 08:09:36', '2019-01-04 23:09:36', 'You\'re so interesting! I don\'t suppose I have read anything like this before.\r\n\r\nSo wonderful to discover somebody with genuine thoughts on this \r\nsubject. Really.. thanks for starting this \r\nup. This site is one thing that is needed on the internet, \r\nsomeone with some originality!', 0, '0', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/6.4 Chrome/56.0.2924.87 Safari/537.36', '', 0, 0),
(3, 10, 'Jane', 'johnathanbrierly@gmail.com', 'http://Foxnews.org/', '162.212.168.248', '2019-01-08 17:50:57', '2019-01-08 08:50:57', 'I am sure this post has touched all the internet visitors, its really really good post on building up new web site.\r\n\r\nYou\'ve made some good points there. I looked on the internet to learn more about the issue and found most people will go along with your views on this site.\r\nI will right away snatch your rss feed as I can’t to find your email subscription hyperlink or \r\ne-newsletter service. Do you have any?  Please let me understand in order that I may just subscribe.\r\nThanks. http://Foxnews.org/', 0, '0', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.158 Safari/537.36', '', 0, 0),
(4, 10, '룰렛', 'karpunenkodjovdet@mail.ru', 'https://pppav12121.net/roulette/', '172.245.89.111', '2019-01-31 14:27:26', '2019-01-31 05:27:26', 'So maintain your above at heart when you find yourself going through \r\nthe withdrawal options available from casinos.  They have Microgaming casino, Net Entertainment, Viaden and \r\nNYX Interactive gaming as a selection of their partners.\r\nPlaying slots open many financial opportunities for a number of individuals. https://pppav12121.net/roulette/', 0, '0', 'Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101 Firefox/57.0', '', 0, 0),
(5, 10, '룰렛', 'karpunenkodjovdet@mail.ru', 'https://pppav12121.net/roulette/', '172.245.89.111', '2019-01-31 14:27:43', '2019-01-31 05:27:43', 'So maintain your above at heart when you find yourself going through \r\nthe withdrawal options available from casinos.  They \r\nhave Microgaming casino, Net Entertainment, Viaden and NYX \r\nInteractive gaming as a selection of their partners.  Playing slots open many financial opportunities for a number \r\nof individuals. https://pppav12121.net/roulette/', 0, '0', 'Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101 Firefox/57.0', '', 0, 0),
(6, 10, 'John Darer', 'chadwickervin@gmail.com', 'https://www.Ripoffreport.com/reports/john-darer/stamford-connecticut-06902/john-darer-john-darer-lawsuit-john-darer-liar-john-darer-complaints-john-darer-lawsuit-1173090', '168.90.196.156', '2019-02-01 19:11:50', '2019-02-01 10:11:50', 'Why visitors stіll make use of to read news papers whеn in tһis technologіcal \r\nworld all is existing on web?', 0, '0', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET4.0C; .NET4.0E; 360SE)', '', 0, 0);
INSERT INTO `wp_comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`) VALUES
(7, 10, 'stamped concrete without color', 'Ciara-Burkitt77@miraclehouse.biz', 'http://gunnerrlexo.blogpostie.com', '23.254.56.46', '2019-02-24 19:52:47', '2019-02-24 10:52:47', '{WHAT Type OF Mix IS Greatest FOR STAMPED CONCRETE? Our contract \r\nprice is economical and the most effective thus far. Professionals within the Denver area have offered information about how much concrete price(s).|{Decorative Stamped \r\nConcrete for Indoor &amp; Outdoor - BEST Quality &amp; Prices...\r\n\r\nباطون مطبع وملون…|DIY Stamped Concrete.\r\n\r\nModern Design Decorative Concrete с помощью @YouTube|Touch Up Roller \r\nfor Stamped Concrete: на @YouTube|Мне понравилось видео \"Pattern Imprinted Concrete / Stamped Concrete Driveway by Readypave Ltd\"|Мне понравилось видео \"Pattern Imprinted Concrete / Stamped Concrete Driveway by Readypave Ltd\"|Мне понравилось видео \r\n\"Pattern Imprinted Concrete / Stamped Concrete Driveway by Readypave Ltd\"|GlobMarble Random Stones Stamped Concrete Mats …|GlobMarble \r\nRandom Stones Stamped Concrete Mats …|\" Decorative Concrete\" \r\nThis is stamped concrete with grey highlights|\"Colored and stamped concrete is an ideal pool deck surface, combining the attributes of beauty, durability, and low maintenance. Stamped concrete pool decks give you a vast array of decorative options not possible with other pool deck|\"how \r\nto clean xylene from stamped concrete back rolling?\" …|\"Thanks to new methods and materials, stamped concrete can deliver the same visual \r\nappeal as more expensive paving materials, such as brick and natural stone...\"|\"The outside is just a glimpse of the \r\ninside\" \r\n\r\nWhat does your parkinglot ADAramps sidwalks say? \r\n\r\nmultifamily ashalt renovations repairs remodel exterior AllThingsPossible atpconstruction paint striping stamped concrete|stampedconcretestamped concretecontractorconcretelifecstampedcolorfuldrivewaycincinnati|$145,000 REMODELED 4-bed/2-bath FOR SALE (139 Buena Vista, Twin Falls ID)\r\n\r\nThe completely finished basement has a beautiful stamped concrete floor. The one car garage has a large shop behind it. The back yard is fenced. More Details, Photos, and Apply ||$489,900 3682 N 162Nd Avenue, Goodyear, AZ - Entertain and relax poolside in this open floor plan home located on the 3rd Fairway of the Falls Golf Course,Tuscany Falls. A flagstone stamped concrete walkway... ARIZONA realEstate|$700,000 8630 S 22Nd Place, Phoenix, AZ - Welcome to your private lush desert modern oasis! This contemporary modern custom home is surrounded by amazing mountain and city light views! Stamped concrete... ARIZONA realEstate|***** OPEN HOUSE SUNDAY JULY 22, 2-4 *****\r\n116 Oleary Drive, Ancaster.\r\nOver 3,200 sq/ft with 10’ ceilings, hardwood and tile floors, as well as a splash pad for the kids built into the stamped concrete back yard. Don\'t miss this home!|**NEW LISTING AND OPEN HOUSE (9/16 1-3PM)** Great opportunity in Ashland Park! This charming home is located on a 0.31-acre lot and features a patio with stamped concrete &amp; private tree lined backyard. Listed by The Allnutt Group at The Agency (859)699-4663|**PRICE IMPROVEMENT** on this amazing home! No detail has been spared from top to bottom! Relax outdoors in your personal backyard oasis featuring a hot tub, screened porch and massive stamped concrete patio! \r\n\r\nView Listing Details:|*LAGOS AND IBADAN\r\nJUNE 21st - JUNE 23rd\r\n\r\n*ABUJA AND KADUNA\r\nJUNE, 28th - JUNE 30TH 2018\r\nTime is 8am daily\r\n\r\nTRAINING FEE\r\n*3D GRAPHICS FLOOR....35,000\r\n*3D WALLPAPER...15,000\r\n*WALL PANEL....15,000\r\n*REFLECTOR EPOXY FLOOR...20,000\r\n*DECORATIVE STAMPED CONCRETE FLOOR...20,000|*_Advantages of stamped concrete over other types of flooring_* \r\n1. Better aesthetic value\r\n2. Lesser maintenance...|.@GimondoSealing in NewYork this patio with a stamped concrete overlay that looks like real stone - just in time for summer SummerSolsticepic.twitter.com/5rNcKoAWVD|1,000 sq. ft. suspended stamped concrete deck on our mountain lodge home that is currently under construction.|1,100 sq ft stamped concrete pour today way to much money and name on the line for any mistakes.. My team on counting on u! hardwork Pray!|10-Step Process of Stamped Concrete|12 days until Christmas are you ready? I want stamped concrete for my patio, finished basement with a beer room..and a pink g-string. Or fuchsia...I’ll let you surprise me. Man this… …|1205 Estes Ln is a customhome boasting castlestonemasonry and a stamped concrete covered patio in the front.|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|1400 square feet of stamped concrete Roman slate grey on grey Toronto thesix custom concrete…|1410 Pohorecky Place is for sale with Cam Bird , Remax Realty Over 1700 sq feet, 4 bedrooms, 3 bathrooms, massive yard, triple stamped concrete drive and more! Asking 719,900. yxe… …|15% Off all Stamped Concrete projects sidewalk, driveway, walkway, staircase and commercial buildings — in Cross Roads …|16\" barn board stamped concrete done with Butterfield stamps and Butterfield sienna brown integral color &amp; deep charcoal release.|16×32 Vinyl liner with Arizona flagstone stamped concrete with \r\ncolored boarder &amp; coping|3 bedroom all brick semi-detached near Fanshawe College in London Ontario.\r\nJust reduced to $229,900! Great neighbourhood, stamped \r\nconcrete drive.|3 bedroom semi detached on a quiet tree \r\nlined street in North east London. Walk to Fanshawe college.\r\n$239,900. Stamped concrete driveway and large lot.|3 Must-Know Facts About Stamped Concrete|3 Seasons addition &amp; new siding complete.\r\nLP Smartside lap siding &amp; trim, Pella windows and door, \r\nstamped concrete &amp; stained pine tomgue and groove ceiling.\r\nYou envision it and we can make it happen using the highest \r\nquality material and best craftsmen. @Pella_News|3 things remaining \r\nstill: 8ft stamped concrete border around the pool.\r\nTo be done next week. Also automatic pool cover not ready yet.\r\n\r\nLastly, fence late August. The rest is cosmetics (landscaping mainly).|3052 Ansonia Drive is \r\na beautiful stone front transitional and features an expanded \r\nthree-car garage, custom kitchen, finished lower level, media room, stamped concrete patio, fenced backyard and in-ground \r\npool. Don’t miss out on this opportunity!|3162 Michelle Ct, Loveland - \r\nThis 4 bed 3 bath home is move in ready. Freshly painted interior, Stamped concrete patio, ceramic point tile, new garage door and opener and brand new grade are just a few of the upgrades you will find.|4 Great Stamped Concrete Ideas for your Home Exterior|4 Reasons to \r\nAdd a Stamped Concrete Border to Your Driveway|4 Tips On Hiring The Best Stamped Concrete Stamped Concrete Contractor Blog Pattern Patio Driveway|51 Atlantic St.\r\nHighlands. European fan stamped concrete pattern|520 Bradwell Chase realestate executive home on pool sized lot, incredible oversized deck &amp; \r\nextensive stamped concrete patios. Finished lower level \r\nwith huge above grade windows for max sunshine|520 Bradwell Chase realestate \r\nexecutive home on pool sized lot, incredible oversized deck &amp; \r\nextensive stamped concrete patios. Finished lower level \r\nwith huge above grade windows for max sunshine|520 Bradwell Chase \r\nrealestate executive home on pool sized lot, incredible oversized \r\ndeck &amp; extensive stamped concrete patios. Finished lower level with huge above grade windows for loads of sunshine|520 Bradwell Chase realestate executive \r\nhome on pool sized lot, incredible oversized deck &amp; extensive stamped concrete patios.\r\nFinished lower level with huge above grade windows for loads of sunshine|520 Bradwell Chase realestate \r\nexecutive home on pool sized lot, incredible oversized deck &amp; \r\nextensive stamped concrete patios. Finished lower level with huge above grade windows for loads \r\nof sunshine|520 Bradwell Chase realestate executive \r\nhome on pool-sized lot, incredible oversized deck &amp; extensive stamped \r\nconcrete patios. Finished lower level with huge above grade windows for lots of natural sunlight|520 Bradwell Chase realestate executive home on pool-sized lot,\r\nincredible oversized deck &amp; extensive stamped concrete patios.\r\nFinished lower level with huge above grade windows \r\nfor lots of natural sunlight|520 Bradwell Chase realestate executive home on pool-sized lot, incredible oversized deck &amp; extensive stamped concrete patios.\r\nFinished lower level with huge above grade windows for lots of natural sunlight|520 Bradwell Chase realestate executive \r\nhome on pool sized lot, incredible oversized deck &amp; \r\nextensive stamped concrete patios. Finished lower level with \r\nhuge above grade windows for loads of sunshine \r\nhome|520 Bradwell Chase realestate executive home on pool sized \r\nlot, incredible oversized deck &amp; extensive stamped concrete patios.\r\n\r\nFinished lower level with huge above grade windows for loads of sunshine home|5418 Saunders Rd,\r\nVinton Va\r\n\r\nBrand new 2018 home. This 3 bed, 2 bath brand new home is situated on just over an acre.\r\nMaintenance free siding, metal roof, 2 covered \r\nporches, industrial gutters, stamped concrete, generator hook-up and...\r\n…|6\" wood plank stamped concrete. Yes concrete not wood done by|7480 Faraway Trail is a custom-designed stone front transitional with 9\' ceilings and architectural details throughout. The home features a phenomenal master suite, finished lower level, stamped concrete patio - and so much more! View more here:|7800 North Ocean Blvd\r\n2901-3000sqft - $599,000\r\n3br/3ba\r\n\r\nThis beautiful 3B/3BA all brick home with bonus basement is just 300 steps from the beach! Oversized stamped concrete driveway and... …|6: TiqueWash 3 lb. Antiquing Colorants for Stamped Concrete (Sahara Night)\r\n\r\nTiqueWash 3...|6: TiqueWash 3 lb. Antiquing Colorants for Stamped Concrete (Medium Gray)\r\n\r\nTiqueWash 3 ...|STAIN-STAMPED CONCRETE-KITCHEN REHAB-BATHROOM|4: TiqueWash 3 lb. Antiquing Colorants for Stamped Concrete (Medium Gray)\r\n\r\nTiqueWash 3 ...|6: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Dark Gray)\r\n\r\nTiqueWash 3 lb....|4: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Jasper)\r\n\r\nTiqueWash 3 lb. An...|5: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Terra Cotta)\r\n\r\nTiqueWash 3 l...|… Stamped Concrete close-up of driveway border - Hot Springs, Arkansas - Techne Concrete|5: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Smokey Quartz)\r\n\r\nTiqueWash 3...|3: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Terra Cotta)\r\n\r\nTiqueWash 3 l...|4: TiqueWash 3 lb. Antiquing Colorants for Stamped Concrete (Sahara Night)\r\n\r\nTiqueWash 3...|6: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Jasper)\r\n\r\nTiqueWash 3 lb. An...|2: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Smokey Quartz)\r\n\r\nTiqueWash 3...|7: TiqueWash 3 lb. Antiquing Colorants for Stamped Concrete (Seasoned Earth)\r\n\r\nTiqueWash...|PAINTING-FLOORING-ACID STAIN-STAMPED CONCRETE-KITCHEN REHAB-|PAINTING-FLOORING-ACID STAIN-STAMPED CONCRETE-KITCHEN REHAB-BATHROOM REHAB- FREE ESTIMA|PAINTING-FLOORING-ACID STAIN-STAMPED CONCRETE-KITCHEN REHAB-BATHROOM REHAB-|STAIN-STAMPED CONCRETE-KITCHEN REHAB-BATHROOM REHAB- FREE|\r\nCement Sidewalk Ideas | Concrete Designs for Patios, Floors, Stamped Concrete ...|3: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Evening Oak)\r\n\r\nTiqueWash 3 l...|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|is going national. To repair stamped concrete issues.\r\nThere is such problems nationally that owner Ted Mechnick will be looking to partner with other like minded pros.\r\nCall 732-915-6391 if intetested.|… Used with Gator Grip around the pool and on the entire stamped concrete (1700 sq. ft.!) without the grip in most areas. Not as wet look as the non-acrylic but this is odorless and is easily applied, easy clean up. It goes further than the …|… Used with Gator Grip around the pool and on the entire stamped concrete (1700 sq. ft.!) without the grip in most areas. Not as wet look as the non-acrylic but this is odorless and is easily applied, easy clean up. It goes further than the …|… Used with Gator Grip around the pool and on the entire stamped concrete (1700 sq. ft.!) without the grip in most areas. Not as wet look as the non-acrylic but this is odorless and is easily applied, easy clean up. It goes further than the …|… Used with Gator Grip around the pool and on the entire stamped concrete (1700 sq. ft.!) without the grip in most areas. Not as wet look as the non-acrylic but this is odorless and is easily applied, easy clean up. It goes further than the …|best Stamped Concrete in CliftonPark,Contact us for Stamped Concrete including repairs,installations&amp;replacements|@abcddesigns ended up with a Sherwin Williams color, Stamped Concrete. Perfect. :-)|@albairaqqatar Red-colored, stamped concrete is used to simulate brick in crosswalks or otherwise to create decorative patterns.|@atiku For your landscaping (stamped concrete), flooring (3D epoxy), wall finishes (3D wall mural (epoxy), 3D wall panel and wall paper) and Ceiling (3D mural) in residential and commercial \r\nFor your best deliveries any location in Nigeria contact Engr. Abayomi on \r\n07033685325|@baris72 @hozaktas in the house. We have custom made polished+stamped concrete floors --gr8 for the pool house as well. It is very simple.|@BenRogers I had stained &amp; stamped concrete done in September. It\'s awesome, cheaper than pavers &amp; looks great. Not slippery at all.|@BouletHubs would that stamped concrete be slippery to walk on when wet or in the winter with a bit of snow? It looks awesome|@Bryan_Baeumler Stamped concrete around pool not even year old keeps flaking and turning white! What happened? byranhelp|@Cigar_Sass replaced with a grey flagstone stamped concrete patio with new stairs and such.|@ConcreteNetwork how can i get quality training on stamped concrete in Nigeria?|@CoronaTools @ValleyCrest Ps. any thoughts about stamped concrete vs tile? I am redoing my front step. Thxs... landscapechat|@DIYNetwork come build a deck on my house. I live right near @Lowes distribution center. All I have is a cracked stamped concrete patio.|@GlobMarble offer concrete stamp mats, stamped concrete accessories and tools, release agent and sealers for stamped concrete. All our services are best market price. So, why are you waiting, Order now!!|Anything Concrete Inc Provides Concrete Crack Repair, vancouver stamped concrete, leaking Foundation in …|Boom 1/4\" stamped concrete \r\noverlay European Fan! @superkrete International can make those Concrete Dreams a|concreter needed in maidstone.\r\n\r\nBluestone charcoal stamped concrete driveway|CustomConcrete \r\nMasonry Can I remove Thompson\'s water sealer from \r\nstamped concrete - Big Mistake?|CustomConcrete Masonry Can I remove Thompson\'s water sealer from stamped concrete - \r\nBig Mistake?|CustomConcrete Masonry Can stamped concrete \r\nthat has been stained be changed to look like the stone that \r\nit ...|CustomConcrete Masonry Stamped concrete indoors, would \r\nlike a wet look sealer that fills in the cracks, so t...|CustomConcrete \r\nMasonry Which is better stamped concrete vs stone patio?|Directory:\r\npatio designs, concrete contractor, stamped concrete driveway|driveway \r\nstamped concrete Overlay|driveway stamped concrete Overlay  process  European fan|EgressPros: Stamped concrete \r\nbackyard patio with seat walls and fire pit.|Glowing Stone Apply in Park,Hotel Lobbies,Pathway Borders,Stamped Concrete|ikoyiclubcarpark The ART of Creative Paving Broom Finished Concourse, Stamped Concrete Borders to|ImagineerRemodeling Pros and Cons of Stamped Concrete vs.\r\nInterlock Pavers. Read Blog:|JustListed Trendy \r\nModern Bungalow. Complete remodel 3 bedroom 1 full bath 1260asf.\r\nCome home to this light and bright home stamped concrete floors and \r\nwood ceilings throughout. \r\nPropertyManagement LGA Listed Rental Views Seattle LakeForestPark|JustListed:\r\n4BR + Rec Room + Salt Water Pool\r\n\r\nPrice, Location, and More Photos \r\n\r\nPerfect spot for entertaining with large, welcoming kitchen and incredible backyard set up with covered stamped concrete patio and privacy fenced yard!|Mikebusinessthread this is what \r\nwe do, 3d floors, Reflector floors, Stamped Concrete floor ( foreign)|Mississauga \r\nCondos What A Home! Beautiful Stamped Concrete Steps Bring You To The Inviting Front \r\n…|MondayMotivation time! A snap shot of our recent \r\nstamped concrete pour at the Gables Buckhead amenity deck \r\nfeaturing @Argos_Online concrete and colored with \r\nSikaScofield integral mix.\r\n\r\nShout out superintendent Mike McLean for an outstanding job on this \r\nproject!|oldworld CollegeFootball cobbelestone americanmade , \r\nourCobblestone , more durable than stamped concrete or flagstone , priced competitively to \r\ngive you the best product , 9184373777 ,|Pipes Plumbing - DIY Stamped Concrete Forms HomeImprovement|Pool deck transformation - thin stamped concrete overlay \r\nto replicate the look, color and \r\ntexture of natural|PremierSurfaces 5 Tips to Increase the \r\nDurability of Stamped Concrete. Read Blog:|Protip: apply a durable coating to protect those beautiful Stamped Concrete on your driveway \r\ncoating concrete driveway|realestate home Meadowlands of Sunningdale.\r\nBeautifully built custom exec home with large pool sized lot, oversized \r\ncovered deck and extensive stamped concrete patios. Finished lower \r\nlevel with huge above grade windows!|realestate \r\nhome Meadowlands of Sunningdale. Beautifully built custom exec home \r\nwith large pool sized lot, oversized covered deck \r\nand extensive stamped concrete patios. Finished lower level with huge above grade windows!|realestate home Meadowlands of Sunningdale.\r\nBeautifully custom exec home with large pool sized lot, oversized covered deck and \r\nextensive stamped concrete patios. Finished lower level with huge above grade windows!|realestate home Meadowlands \r\nof Sunningdale. Beautifully custom exec home with large pool sized lot, oversized covered deck and extensive stamped concrete patios.\r\n\r\nFinished lower level with huge above grade windows!|Rhino flooring’s experts offers all types \r\nof colored shiny &amp; stamped concrete crack|RomanaConstruction after I make the \r\nborders dark grey and seal all the stamped concrete|RT @Shorewest_RE: Want to create a beautiful patio but for \r\nless money? Why not go for a stamped concrete patio?\r\nThat way you can mimic brick, flagstone or cobblestone for a fraction of the price.\r\nShorewestRealtors|Sold\r\nThis single story 4 bedroom 2 bathroom on oversized 0.47 \r\nacre lot in Old Rancho San Diego sold for $529,000\r\nHuge lot with lush landscaping, covered patio in front &amp; back, stamped concrete driveway &amp; detached 4 car garage with additional room for \r\nparking/RV.|stamped concrete - technology and molds for production: …|stamped concrete borders and design in middle with handswirled finish inside.\r\n\r\nconcrete|stamped-concrete patio....looks like slate!\r\n…|toyota sienna types restaining stamped concrete|WTH!!!!!!\r\n\r\n\r\nTroopers said Joaquin Grancho, the owner of Pavers, Walls and Stamped Concrete, \r\nof Fort Mill, South Carolina, was driving \r\nthe wrong way on I-77 in the median.... …|@hgtvcanada @make_it_right What are \r\nyour thoughts on stamped concrete for front steps and backyard patio vs other solns?\r\nIs it durable?|@HomeAdvisor Why concrete co.\r\n\r\noffer stamped concrete, and when u ask them about it they \r\nsay they have to rent the stamping equipment|@HomeDepot stamped concrete in place of \r\ndirt!|@Horlacunley: @Horlacunley: DURABILITY ; STAMPED CONCRETE \r\nFLOOR IS THE ANSWER.|@Horlacunley: DURABILITY ; STAMPED CONCRETE FLOOR IS THE \r\nANSWER.|@iam_Davido For your landscaping (stamped concrete), flooring (3D \r\nepoxy), wall finishes (3D wall (epoxy), 3D wall panel and wall paper) \r\nand Ceiling (3D mural) in residential and commercial \r\nFor your best deliveries any location in Nigeria contact Engr.\r\nAbayomi on \r\n07033685325|@JRandSonsConcr provides Foundation Contractors,\r\nConcrete Driveway, Concrete Sidewalks, Stamped Concrete,\r\nConcrete Foundation Repair|@LeahBodnar and \r\nI are looking to get a few quotes for a patio installation. Most likely looking at stamped concrete but \r\npossibly open to pavers. We will also need a built in fire pit which will run off of a \r\ngas line. Anyone have recommendations?|@LIRR has added new architectural \r\nfinishes to Deer Park Station - terrazzo flooring, wood ceilings, exterior brick decorative walls, a new information wall, signage &amp; stamped concrete sidewalks.\r\namodernli @SuffolkEcoDev|@Lowes faux stone wall (external), circular stamped concrete drive way, sprinklers in front lawn, exterior window accent trim.|@masonsmarkstone \r\nlike the wall &amp; fire pit but the stamped concrete has expansion joint cut thru the pattern|@MazzelloJoe just spent a couple \r\nof hours sealing some stamped concrete in my back yard while listening to your reading of, “With \r\nthe Old Breed”. You did a marvellous job. Thanks for helping \r\nme pass the time.|@NikaStewart Here is a website \r\nof actual stamped concrete for some ideas No glamour shots \r\nhere, but great examples;|@o_oza here are some examples of \r\nstamped concrete|@patricksesty Yes, kind of...there \r\nwill be stamped concrete brick pattern between the bike and car lane so cars will feel if they drift over|@PaulLafranceDES can you tell me the makers of the stone \r\nsiding you use on deckedout? Stamped concrete.. screws into the wall...thanks|@RepJudyChu Caltrans in LaCanada put in stamped \r\nconcrete center divider wall on 210. How much did that waste of money cost??|@rhaiandrhai \r\ntry our decorative stamped concrete floors.\r\nDurability Guaranteed and our prices are Reasonable.|@robergotigoti hardwood stamped concrete, \r\nsuch a neat look!!!|@SherwinWilliams light grey joists, neutral tan walls \r\nand stamped concrete look for the floor, a loft style design MyColorResolution|@skbayless67 Nah, just be careful.\r\nIt\'s super slippery on your stamped concrete yaysnow WhiteChristmas|@sparklegirl35 @alimshields @LoveRemarkableU @NKOTBSBgroupie @JkShadysCdnGirl \r\n@nkotbgal21 Ugh. Mark is resealing our stamped concrete patio.|@TenesipiB They have stamped concrete or engraved concrete that looks like stone work but doesn\'t pop up &amp; hurt your car.|@TonyStewart whoever did your expansion joints on your stamped concrete did a horrible job...I\'d call him \r\nback there!|@vanguardngrnews For your landscaping (stamped concrete), flooring (3D epoxy), wall finishes (3D wall epoxy), 3D wall \r\npanel and wall paper) and Ceiling (3D epoxy) in residential and commercial \r\nFor your best deliveries any location in Nigeria contact Engr.\r\nAbayomi on \r\n07033685325|Watch this earlier video of our hard \r\nworking VMGTeam pouring concrete as they create a basketball court for the onlooking family!\r\nYou will also see the awesome stamped concrete patio?!!\r\nlansingmi eastlansingmi grandledge Holtmi …...|Wood plank stamped concrete.\r\ndecorativeconcrete concrete stampedconcrete \r\nstainedconcrete woodlook|Happy Halloween \r\n\r\nTo all our customers past, present and future, we wish you a HappyHalloween!\r\n\r\nAnd remember - if you need your driveway exorcising, call \r\nNorthern Cobblestone and transform your Blackpool home \r\nwith our stamped concrete|New Listing | 358 Edgewater Drive, San Marcos Ca \r\nTHIS HOME IS A MUST SEE! Featuring a beautiful entertainers\' yard with tropical landscaping, fire \r\npit, fountain, and stamped concrete patio.|Better than New Construction! Impressive 2-Story withWetland Views.\r\nHome Features a Gourmet Kitchen, Maintenance Free Deck, Stamped Concrete Patio &amp; So \r\nMuch More! Contact Me Today for a Private Showing 612-703-7285.\r\n\r\n\r\n|FEATUREDLISTING Stunning Detached Mattamy Home In High Demand Neighborhood Of \r\nMilton * New Stamped Concrete Front Steps &amp; Walkway* Dream Custom Backsplash + Upgrades, Ss Appliances\r\n\r\n$819,900 Milton and Photos|Just Listed Stunning Mattamy Home.\r\nNew Stamped Concrete Front Steps &amp; Walkway. Dream Custom Backsplash + Upgrades, Ss Appliances.\r\nOpen Concept, Sleek Hardwood Flr. Valence Lighting.\r\n\r\nImmaculately Maintained Backyard* Spacious Modern Bedrooms.|Just \r\nListed Stunning Mattamy Home. New Stamped Concrete Front Steps &amp; Walkway.\r\nDream Custom Backsplash + Upgrades, Ss Appliances.\r\nOpen Concept, Sleek Hardwood Flr. Valence Lighting. Immaculately Maintained Backyard* Spacious Modern Bedrooms.\r\n⠀|OPEN HOUSE ALERT \r\n\r\nSunday, October 7, 2018\r\n\r\nCome see this beautiful home, 3/3 + den near Pineview! The stamped concrete driveway \r\nwill stand out, as well as the carefully planted yard with all...\r\n\r\n…|18276 Maffey Drive, Castro Valley\r\n3 Bedroom 2.5 bathroom home w/ gorgeous backyard &amp; interior.\r\nNew roof &amp; fully owned solar. Composite deck surrounded by stamped concrete.\r\nLarge living room &amp; cozy gas... …|OPEN HOUSE SUNDAY10/28 1-4 pm.\r\nWOW!!! 1/2 acre cul-de-sac lot accented by a large stamped concrete patio and beautiful landscaping.\r\nLocated at 4273 Golden Meadows Ct, Grove City,\r\nOH and priced at only $236,900 this 4 Bedroom, 2.5 \r\nbath two|Great Starter home \r\nWell maintained 4 Bedroom 2 Bath home. Dual \r\npain windows. Stamped concrete driveway and walkway. Large covered wrap around \r\npatio. Rock landscape front and back yard… …|NEW LISTING\r\n1195 DARTMOUTH CIR. DIXON\r\n3 BEDROOMS\r\n2 BATHROOMS\r\nGORGEOUS CHOCOLATE CABINETS. GRANITE COUNTERS. SPACIOUS BACKYARD \r\nWITH STAMPED CONCRETE AND YOUR OWN TIKI HUT.\r\n\r\nOFFERED AT $429,900 …|Price Improvement! Impressive 2-Story withWetland Views.\r\nHome Features a Gourmet Kitchen, Maintenance \r\nFree Deck, Stamped Concrete Patio &amp; So Much More! Open House Saturday, September 22nd from 11am-1pm!\r\nCome Stop by or|JustListed Glendora!\r\n\r\n2BD, 1.5BA, Oak hardwood, updated kitchen w/granite, All \r\nseasons room, spacious deck,Koi Pond, stamped concrete patio, newer vinyl privacy fence, Newer roof &amp; siding,\r\nNewer Central Air &amp; Hot-Water Heater|Stamped concrete \r\nresurfacing in the Omaha Nebraska area! Who ’s the flagstone look\r\n\r\n\r\nconcrete overlay concretedesign stampedconcrete homedecor patioliving \r\nconcreteflooring omahanebraska omahaphotography|PROJECT OF THE WEEK \r\n\r\nAnother amazing transformation complete \r\n\r\nFrom cracking stamped concrete to this stunning paver patio complete with steps, pergola,\r\nfire pit, walkway, and softscaping to bring everything \r\ntogether! Some incredible before and after photos.|CRSBuildersINC \r\nConstruction tips and style choices for a durable, low-maintenance stamped concrete \r\ndriveway that enhances the curb attractiveness of your home.\r\n\r\nGet further info call us:- 858-282-1311 or \r\nvisit here:-|Patio weather can return any day now!\r\nThis Stamped Concrete pattern was done at Firebirds…|Revive your old stamped concrete - no need to tear \r\nit out! \r\nOur STAMP-WOW process is going to save you the heada…|@olgaopolis @fatTireBikeBoy cool pedestrian crosswalks.\r\nNote - these are stamped concrete crosswalks unlike many of the brick ones in @CityofEdmonton. Brick is not smart in our climate.\r\n\r\nStamped is the way to go and can be very beautiful. …|Great video showing \r\nthe stamped concrete process. Check out Westcoat Stamp-It in our Texture Coat (TC) category for a system that\'s cost-effective, high-build, unlimited colors \r\nand SUPPORTED BY THE WESTCOAT TEAM! More on …|I have a stamped concrete patio \r\nthat looks like stone, and we love it. Get lots of compliments on it, too.\r\n…|STAPRO Stamped Concrete \r\nPLESURE OF ART\r\nKfarhim villa Mr. Assef Ghannam\r\n70838788\r\n03923863\r\nstamped Concrete skin tilebordir European_fan …|@AnastasiaRubine ..good morning, this is a gorgeous driveway, looks like a stamped concrete rather then pavers?|A 2 tier \r\nTrex Deck, fire pit and seat wall on stamped concrete!|A beautiful \r\nlandscape with faux rock waterfalls, planters boulders, streams and stamped concrete decking.\r\n\r\n\r\nwaterfall waterfalls boulders planter streamconcrete \r\nshotcrete deck… …|A beautiful landscape with faux rock waterfalls, planters boulders,\r\nstreams and stamped concrete decking. \r\n\r\nwaterfall waterfalls boulders planter stream concrete shotcrete deck… …|A concrete patio \r\ngets a stamped-concrete floor treatment and new stairs.\r\n\r\nConcreteRepair ConcreteAdvice...|A cost-effective way of resealing \r\nstamped concrete. Let us make a mess into success!|A \r\ngorgeously-landscaped corner lot. Tinted driveway &amp; stamped concrete \r\npath coordinate with the clay tile roofing.\r\n\r\nA lovely leaded glass door leads into the entrance hall. 3 bedrooms &amp; 1.75 baths.\r\nclaudiahargrove realestate …|A great way to spruce up that front entry is \r\nby adding a beautiful decorative stamped concrete front \r\nporch. Is your front step needing an update? Let us help you.\r\nCall or visit our newly updated website by... …|A little stamped concrete training today!|A modern space deserves modern paving.\r\nThis is the Eterna Collection from Oaks. Can\'t do this with stamped concrete.|A path to sprucing up street \r\nappeal...staining the stamped concrete. I can hardly move but looks much \r\nbetter &amp; there\'s still a little sun left to enjoy.\r\nYAY! streetappealhelpssell|A recent recolor of a \r\nwarn and weathered patio and walkway in North Tonawanda. Curious what kind of maintenance your stamped concrete needs?\r\nMessage us today to find out how we can make your stamped concrete look new again!|A stained and stamped concrete patio like this creates a beautiful \r\naccent to your backyard. Call (786) 899-2146 for a professional \r\npatio resurfacing service!\r\n\r\nMiami Concrete|A stamped concrete overlay done on a porch and garage \r\nentrance adds so much character to the home. \r\nInstaller: Hopkins Flooring|A stamped concrete driveway \r\ncreates an impressive home entrance. It also upgrades \r\nthe overall design of your home. Call (972) 885-6067 now!\r\n\r\n\r\nDallas Concrete|A stamped concrete driveway from Concrete Craft \r\ngives your home an impressive entrance and upgrades \r\nyour overall home design.|A stamped concrete finish \r\nworks so well around the swimming pool. Ya it’s workin \r\n.\r\n.\r\nMusic:…|A stamped concrete front entry can add instant curb appeal \r\nto your home. Choose from a variety of patterns, colors,\r\nand textures. Call us @ (972) 808-5281 for more info!|A stamped concrete patio can look as good as pricey, high-end \r\nmaterials. CALL (281) 407-0779 for a FREE quote....|A stamped \r\nconcrete patio can look as good as pricey, high-end materials.\r\nCALL (281) 407-0779 for a FREE quote....|A stamped concrete patio can look \r\nas good as pricey, high-end materials. CALL (281) 407-0779 \r\nfor a FREE quote....|A stamped concrete patio in process.|A stamped concrete patio is \r\nmore than enough to turn a drab space into a first-class outdoor lounge.\r\nCALL (615) 822-7134 for a FREE quote!|A stamped concrete \r\npatio looks like large pavers, and is the perfect outdoor living setting for…|A stamped concrete patio will \r\nserve you well for many years.\r\nCall us now and get your concrete project done (850) 792 1131|A stamped concrete walkway can add some great curb appeal \r\nto your home! Learn more about our options and how you can add this to your property \r\nwhen you call today.|A stamped concrete walkway definitely \r\nmakes for a warm welcome. CALL (717) 245-2829 for a FREE consultation and quote.|A textured, stamped concrete \r\nfinish replicates the look of natural materials at a \r\nfraction of the cost. Seeing as today is MilkChocolateDay, we\'ll take \r\nit in chocolate brown! StampedConcrete FlowcreteAsia|A total redesign of this property in Fort Lauderdale,\r\nFlorida. \r\n\r\nUpgraded this little bungalow driveway to concrete cut-outs and wood plank stamped \r\nconcrete porch. \r\n\r\nBroward County Concrete used a medium gray...\r\n\r\n…|A true showplace nestled into a private lot with a stamped concrete heated drive, hand crafted doors and covered rear porches!\r\nWoodland stands along side today\'s trends with a gourmet kitchen, marble floors, a Whirlpool Master bath and an awesome game \r\nroom|A1 we need the front porch redone and stamped concrete touched up ETNHolmesChatSafety|A4) big challenge is stamped concrete patio maintenance \r\nResealing made it slippery when rains ASCanadaDIY|Achieve decorative finishes that replicate granite, slate, \r\nstone, brick or wood aesthetics with Increte Stamped Concrete.\r\nTake a look at a recent application at Genting \r\nHighlands in Malaysia StampedConcrete Flooring Resort|Achieve the Bluestone look for your patio with stamped concrete!\r\n\r\n… concrete|Acid staining stamped concrete creates a beautiful, textured appearance.\r\n\r\nHere\'s how to do it: …|Acid staining stamped concrete creates a beautiful, \r\ntextured appearance. Here\'s how to do it:|Acquire a custom concrete pool deck that matches \r\nthe style of the pool, and your usage by installing stamped concrete overlays.\r\nLearn more about its benefits. Call us @ (773) \r\n377-8976!|Acquire a luxurious looking, economic, and functional concrete pool deck with \r\nStamped Concrete Overlays. Call (720) 545-1766 to \r\nmore about its benefits! FREE Estimate!|Acquire an expensive look at a minimal cost.\r\nCALL (678) 534-3930 to know ore about stamped concrete patio overlays.|Acrylic stone varnish that forms a durable,\r\ntransparent thin protective barrier. Suitable for stamped concrete\r\n|Add a unique appeal to any outdoor space by imprinting patterns in freshly laid \r\nconcrete. Here are 5 stamped concrete patio design ideas to enhance the appearance - \r\n\r\nstampedconcretepatio stampedconcrete concretecontractor|Add \r\npattern and texture to your driveway with our \r\nstamped concrete overlays and coatings! Call us @ (408) 709-7256 for a free|Add \r\nsome character to your concrete. We can create stamped concrete \r\nthat is patterned, textured, embossed to resemble brick, slate, flagstone, stone, tile, wood, and varios other patterns \r\nand textures!|Add some extra flare to your stamped concrete \r\nsteps with integrated lighting! Let us make your concrete \r\nproject look unique day and night!|Add value \r\nto your home with our Stamped Concrete Overlay. It\'s a cost \r\neffective investment that is sure to last....|Added a stamped concrete patio,\r\nflagstone walkway and fire pit its all coming together nicely.|Advantages \r\nof Stamped Concrete vs. Patio Pavers|Advantages of Stamped Concrete vs.\r\nPatio Pavers|After pics of a newly stamped concrete pad with an Arizona \r\nflagstone stamp and a northern star stamp imprint....|Ageless Concrete - Wood Plank - Stamped Concrete.\r\n\r\nSchedule is already filling up - Now is the time to book a free Design Consultation!\r\n608-242-2446|alei din beton amprentat stamped concrete walkway ideas 3 …|All \r\nConcrete Needs Stamped \r\nConcrete Driveways/Patio Established in 2011. FREE ESTIMATES driveway concrete patio pavers design paving home… …|Am a civil engineer, my side \r\nhustle are stamped concrete, pop ceiling, quality painting.|Amazing Concrete &amp; Bricks \r\nPatio Design Ideas | Stamped Concrete Patio via @YouTube|Amazing Stamped Concrete \r\nGallery Images -|Amazing Stamped Concrete Gallery Images -|Amazing Stamped Concrete Gallery Images -|Amazing Stamped Concrete Gallery \r\nImages -|Amazing Stamped Concrete Walkway For Modern House Ideas Using Wooden Entrance Gate Designs|Amazing Stamped Concrete Walkway \r\nFor Modern House Ideas Using Wooden Entrance Gate Designs|Amazing Stamped Concrete Walkway For Modern House Ideas Using Wooden Entrance Gate Designs|Amazing Stamped Concrete Walkway \r\nFor Modern House Ideas Using Wooden Entrance Gate Designs|Amazing Stamped Concrete Walkway For \r\nModern House Ideas Using Wooden Entrance Gate Designs|An amazing Pool \r\ndeck in stamped concrete with slate skin pattern. Our job is to make \r\nit a reality for you!!!\r\n\r\nCall 08113131313, +234(0)8023114545 or visit our website: \r\n\r\ncreative creativepaving paving pavingideas nigeria lekkiproperties lekkilagos|An amazing stamped \r\nconcrete transformation. On this application we re-color the concrete light gray and applied two coats of \r\na solvent-based sealer. Hired a trained professional. 860-919-7819|An entertainer\'s \r\ndream! With a true open floor plan, this charming house has it \r\nall. Enjoy your favorite beverage on the stamped concrete \r\npatio, watch the sunset whilst sitting on your… …|An Intro To Fundamental Issues In Stamped Concrete Kansas City|An inviting stamped concrete walkway with European Fan Pattern. Beautiful, isn\'t it?|And for anyone doing architecture or interior design\r\n\r\nLeave the wood stamped concrete out of your arsenal\r\n\r\nThat shit is lame to af to me|Another backyard patio made beautiful &amp; so \r\nmuch more cozy with stamped concrete! As the cooler weather hits...\r\nwho wouldn’t to sit out here with a hot cup of coffee to start the morning!?\r\n\r\nconcrete concretelove stampedconcrete\r\n•••\r\nCall us for an estimate: (402) 290-2016|Another backyard patio made beautiful &amp; so much more cozy with stamped concrete!\r\nAs the cooler weather hits... who wouldn’t to sit out here with a hot \r\ncup of coffee to start the morning!? concrete concretelove stampedconcrete\r\n•••\r\nCall us for an estimate: (402)|Another outdoor kitchen done!\r\nPatio cover over stamped concrete floor, finished off with…|Another recent job.\r\nReal PA bluestone or stamped concrete?|Another Stamped concrete Job\r\nBuff concrete color with an antique grey release highlights|Another unique, \r\nstamped concrete patio installation. patio concrete|Antiquing &amp; Re-Sealing Stamped Concrete\r\n\r\n|Antiquing &amp; Re-Sealing Stamped Concrete\r\n\r\n|Anyone know of any deck builders/stamped concrete \r\ncontractors in cbus? Need prices/ideas…|Anything Concrete Inc Concrete Crack Repair,\r\nvancouver stamped concrete, leaking Foundation in @Vancouver - …|Anything Concrete Inc Concrete Crack \r\nRepair, vancouver stamped concrete, leaking Foundation in @Vancouver - …|Anything Concrete Inc Concrete Crack Repair, vancouver stamped concrete, leaking Foundation in @Vancouver - …|Anything Concrete Inc Provides Concrete \r\nCrack Repair, vancouver stamped concrete in @Vancouver - @Surrey.\r\n…|Anything Concrete Inc Provides Concrete Crack Repair, vancouver stamped concrete, leaking Foundation in …|Anything Concrete Inc Provides vancouver stamped concrete, leaking Foundation &amp; crack \r\nrepair in @Vancouver - …|Are you deciding between pavers vs.\r\nstamped concrete? It definitely is a matter of opinion and what your...|Are you dreaming of summer?\r\nSo are we. Get ready for MemorialDay with a stamped concrete \r\npatio or fire pit for your backyard. Pool not included ;)\r\nCall Cedar County Landscaping at 425-358-2779 to get started on your \r\nbackyard getaway|Are you getting the most out of Summer?\r\n\r\n\r\nCatch some rays in style, by lounging on a stunning new stamped \r\nconcrete patio for your garden.\r\n\r\nCall today to book your pattern imprinted concrete driveway or patio for your Fleetwood|Are you \r\nthinking of installing stamped concrete? Take a look \r\nat these 8 simple steps for application FlooringApplication Applicator HowTo Flooringadvice StampedConcrete|Arizona Flagstone stamped concrete poured against rock.\r\nNWCL Kitsap|Arizona Flagstone Stamped Concrete …|Arizona Flagstone Stamped Concrete Driveway in London Ontario|Arizona \r\nFlagstone stamped concrete driveway with Roughcut \r\nBorder in London.|Arizona Flagstone Stamped Concrete Patio Area in Komoka Ontario|Arizona \r\nFlagstone Stamped Concrete Patio in London Ontario|Arizona Flagstone Stamped Concrete Patio in London Ontario|Arizona \r\nFlagstone Stamped Concrete Patio with Curb Edge Border in London Ontario|Arizona Flagstone Stamped Concrete Patio, Sidewalk \r\nand Steps in Komoka Ontario.|Arizona Flagstone Stamped Concrete Pool Deck \r\nin Komoka Ontario|Arizona Flagstone Stamped Concrete Sidewalk and \r\nPorch in London Ontario|Arizona Flagstone Stamped Concrete Steps in London Ontario|Arizona Flagstone Stamped Concrete Walkway in London Ontario|Arizona flagstone stamped concrete \r\nnrconcretemass \r\nswimmingpool \r\nstampedconcrete \r\ncon…|Around The USA - Stamped Concrete Kansas City Tactics|Artificial Turf, Stamped \r\nConcrete Steps, Court yard, Walls with Cap and Dry River Bed|Ashlar Pattern Tennessee Field Stone - Nina \r\nBerman Photography: Stamped Concrete Stone Pattern Dayton Ohio Concret...|Ashlar slate stamped concrete patio recently sealed thanks to dry \r\nfall weather! NWCL Kitsap|Ashlar slate stamped concrete patio we are installing today in Arlington, Texas.\r\nstampedconcrete|Ashlar Slate Stamped Concrete Walkway:\r\n…|Ashlar Slate Stamped Concrete Walkway: …|Ashlar Slate Stamped Concrete Walkway:\r\n…|Ashlar Slate stamped concrete\r\nnrconcretemass \r\nstampedconcrete \r\npool \r\nhomeowners \r\nconc…|Ashlar Stamped Concrete pattern by Camocrete.\r\nYou can see patterns like this at|Ask Jennifer Adams:\r\nCan you put a stamped concrete floor in bathrooms?|At I\'Fash Floors you \r\nget a world-class concrete floor design that elevates your property \r\nto the next level...Our services include; 3D Epoxy Floor/Wall/Ceiling, Stamped Concrete Floor, Reflector Epoxy Floor and so on. \r\nCall/WhatsApp us on 08188276300, 08188276305. Thank you!|At least if my house floods I can get my pool repaved.\r\nI want stamped concrete around my pool and in my \r\ndriveway.|ATTRACTIVE STAMPED CONCRETE DESIGNS FOR YOUR DRIVEWAY.\r\n\r\nWhen choosing a finished surface for your \r\ndriveway, stamped concrete is cost-effective, durable, and aesthetically pleasing.\r\n\r\n\r\nstonework craftsman coloradohome mountainhomes|August jobs stamped \r\nconcrete|Awesome new listing in SE Mandan and just a few blocks south of Fort Lincoln elementary!\r\nFabulous views of the prairie with no back neighbors!\r\nWalkout to stamped concrete patio. Listed by Judy Pfiefle Maslowski, Bianco Realty.\r\n…|Awesome Uses For Stamped Concrete In Your Home \r\n\r\nConcrete is functional and long lasting. But did you know it could also be beautiful?\r\n\r\nLets look at the art of \'stamped concrete\' , where patterns are stamped into the \r\nwet concrete. It can be used around pools, patios but al…|Backyard Stamped Concrete Patio Ideas|Banish boring, plain gray concrete \r\nwalkways and sidewalks with stamped concrete in patterns, designs \r\nand colors that bring out the best in your surroundings.|Basement Floor by Stamped Concrete: via @YouTube|Basement floor smooth sweep \r\ntrowel finish, by Stamped Concrete: via @YouTube|Basement Floor....How Do You Deal With The Drip Holes?\r\nBy Stamped Concrete via @YouTube|Basement Floor....How Do You Deal With The Drip \r\nHoles? By Stamped Concrete: via @YouTube|Beautiful 4 1 Bedroom Home * Corner Lot W/ Oversized Backyard, Exposed \r\nAggregate/Stamped Concrete Patio &amp; Inground Sprinklers * Large Liv &amp; Din Rm W/ \r\nGas Fp * Upgraded Eat-In Kitchen W/Granite Counters,...\r\n…|Beautiful ashlar pattern stamped concrete patio .\r\nstamped patio pattern concrete…|Beautiful colonial in Riverview subdivision with 2 master bedrooms and a third large bedroom.\r\n4-1/2 baths,fully finished basement, 22×38 attached garage, rear deck and stamped concrete patio.\r\n\r\nFreshly painted, hardwood floors recently refinished,\r\nand...|Beautiful European Fan stamped concrete driveway.\r\nBoost your curb appeal with Super Stone Products today!...|Beautiful European Fan stamped concrete \r\nwalkway. A timeless classic design. Also available French Fan Stone and...|BEAUTIFUL FAMILY FARMHOUSE!\r\n\r\n\r\n\r\nPrivate 191.7 productive acres w/ 4,300 home! You will walk \r\nup to a covered front porch w/stamped concrete, large cedar wood posts &amp; one of the most \r\nbeautiful views in Polk County. Double porch swings will allow you...|Beautiful Family Home On Large Lot \r\nIn A Great Neighbourhood. Hardwood Floor Throughout Living Room/Dining Room, \r\nAnd Bedrooms. Spacious Kitchen And Finished Basement.\r\nEnjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back Near Schools, …|Beautiful \r\nFamily Home On Large Lot In A Great Neighbourhood.\r\n\r\nHardwood Floor Throughout Living Room/Dining Room, \r\nAnd Bedrooms. Spacious Kitchen And Finished Basement.\r\n\r\nEnjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A \r\nGreat Neighbourhood. Hardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\n\r\nHardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great \r\nNeighbourhood. Hardwood Floor Throughout Living Room/Dining Room,\r\nAnd Bedrooms. Spacious Kitchen And Finished Basement.\r\nEnjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\n\r\nHardwood Floor Throughout Living Room/Dining \r\nRoom, And Bedrooms. Spacious Kitchen And Finished \r\nBasement. Enjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\nHardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The \r\nSide Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\nHardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\nHardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\n\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large \r\nLot In A Great Neighbourhood. Hardwood Floor Throughout Living Room/Dining Room, \r\nAnd Bedrooms. Spacious Kitchen And Finished Basement.\r\nEnjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful move in ready ranch. Updated kitchen, spacious floor plan, brand new stamped concrete patio.\r\nHuge fenced in|BEAUTIFUL MOVE-IN READY RANCH.\r\nUPDATED KITCHEN, SPACIOUS FLOOR PLAN. BRAND NEW STAMPED CONCRETE PATIO.\r\nHUGE FENCED IN|Beautiful move-in ready ranch. Updated kitchen, spacious open floor plan. Brand new stamped concrete patio.\r\nHuge|BEAUTIFUL PROPERTY FOR SALE: Contemporary home with custom finishes (stamped \r\nconcrete thru out first floor, wood and stone accent \r\nwalls, granite counter tops). \r\n4 beds 3 baths 2,418 sqft\r\nMLS : 1949851\r\nCall Broker/Realtor Inna Mizrahi at 702-812-6828 REALESTATE \r\nLasVegas|Beautiful, durable, and cost-effective.\r\n\r\nAcquire this stamped concrete pool deck now! CALL (636) \r\n256-6733 to speak with one of our experts.\r\n\r\nDecorative Concrete Resurfacing\r\n715 Debula Dr\r\nBallwin, MO 63021\r\n(636)|Beautiful, stamped concrete using textured \r\nmats and Super Stone® products never disappoints!\r\nWhat a gorgeous...|Beautify your driveway with Bomanite\'s expertise in Stamped Concrete and Architectural Concrete.\r\n\r\nCall us today at 905.265.2500. \r\n•\r\n•\r\nStampedConcrete|Beautify your home or business with the distinctive \r\nlook of high-quality stamped concrete. You’re welcome to \r\ncall us at 402-707-5650 \r\ncontractors omahacontractors concrete concretecontractors omahaservices DigitalMarketing driveways|Beautify your home or business with the distinctive look of high-quality stamped concrete.\r\nYou’re welcome to call us at 402-707-5650\r\n.\r\n.\r\n.\r\nconstruction constructionlife concrete… …|Beautify your outdoor flooring \r\nlandscape with CovillaScapes. Add more value to your property with bespoke exterior decorative stamped concrete makeover finishes.\r\nKindly RT as our customers may be on our TL. Follow us on IG:\r\ncovillascapes. God bless|Before and after Herringbone pattern stamped concreteNeweraconcrete decorativeconcreteherringboneconcrete|Before and after new unilock paver driveway with stamped concrete apron. \r\nunilock unilockpaversjlposillicoposillicobrothas @ Manhasset, New York …|Before \r\nthey are covered in snow ... which do you prefer: old fashioned cobblestone or \"fractured earth\" stamped concrete?|Before you even think about replacing the whole driveway slab, \r\nconsider decorative concrete first. We offer premium Stamped Concrete Overlays and Spray Texture.\r\nCall (636) 256-6733 to learn more about your options!\r\n\r\nFREE Estimate|Bellaire Pavers forms and installs quality custom stamped concrete driveways!\r\n\r\n\r\nBellairePavers TX Houston|Benefits: Our stamped concrete \r\nwill help increase the value of your property while also \r\nincreasing the longevity|Best approach to get an cost estimation stamped concrete installation. Know about stamped concrete patio \r\nstampedconcretepatiocalculation stamedconcretepatiodesign|Best Prices on fresh Concrete driveways and stamped concrete patios by T &amp; H Foundations and \r\nConcrete Services in St Charles Mo, ...|Best Stamped Concrete Contractors in Racine: Contact the premier stamped \r\nconcrete contractors in Ple... Ads USA|Between the lighting sales office, the outdoor ltg co,\r\nstamped concrete co, two corporate flying gigs, rental properties \r\nand a buy here pay here car lot we’re selling to a national franchise Joe’s \r\na busy boy. The question, I gave 2hrs twin engine instruction.|Blue stone walkways...make it real stone or \r\nstamped concrete. Either way Bon has the tools and materials you need.\r\n\r\n\r\nTell us...which style do you prefer?\r\n\r\nmasonry concrete decorativeconcrete|BMC to replace paver blocks with stamped concrete on Mumbai footpaths|Bomanite concrete \r\nproducts mix design and functionality, so that your stamped concrete driveway and stairway serve its main purpose as well as \r\nimproves your house’s appearance.\r\n\r\nHomeimprovement Bomanite Toronto GTA StampedConcrete ArchitecturalConcrete|Bomanite concrete products mix design and \r\nfunctionality, so that your stamped concrete driveway serves its main purpose!|Bomanite Toronto helps \r\nhomeowners achieve a beautifully designed stamped concrete driveway, while ensuring \r\nits durability and strength.\r\n\r\nStampedConcrete ConcreteDriveway HomeImprovement HomeGoals|Bored of your old concrete driveway?\r\nMake it look as gorgeous as this with stamped concrete overlay.\r\nCALL (636)...|Bored with old concrete driveway?\r\nMake it look as gorgeous as this with stamped concrete \r\noverlay. CALL (636) 256-6733 for more options!|Boring from plain concrete driveway ?\r\nBoost immense beauty and more functionality with Stamped Concrete Overlays \r\n-|Boulder Grey Stamped Concrete with new liner.|Breathtaking 4 Bedroom, 3.5 \r\nBath Ranch on Private Park-Like Lot! 1 of 12 Custom \r\nHomes in Neighborhood/Over 4,600 Building Sq.\r\nFt./Sunroom/Gunite Pool/Fenced Yard/Expansive \r\nStamped Concrete Patio/Oversized 3 Car Side Entry Garage|Breathtaking 4 \r\nBedroom, 3.5 Bath Ranch on Private Park-Like \r\nLot! 1 of 12 Custom Homes in Neighborhood/Over 4,600 Building \r\nSq. Ft./Sunroom/Gunite Pool/Fenced Yard/Expansive Stamped Concrete Patio/Oversized 3 Car \r\nSide Entry Garage|Brick Herringbone stamped concrete and new door installed.\r\nTime to start framing the roof!|Brick Herringbone Stamped Concrete patio and walkway.|Brick pavers are \r\na beautiful, more durable &amp; economical alternative to \r\nother concrete surfaces. Unlike other surfaces like stamped concrete, acrylic, or concrete, pavers are colored throughout the paver, not just a veneer coloring.\r\nCall today for more information! (727) 378-8528|Brick pavers are a beautiful, more \r\ndurable and economical alternative to other concrete surfaces.\r\nUnlike other surfaces like: stamped concrete, acrylic,\r\nor concrete, pavers are colored throughout the paver, not just a \r\nveneer coloring.|Brick Pavers vs Stamped Concrete: Cost Considerations|Brick Stone Border Stamp 3 Pc Set SM 4010.\r\nStamped Concrete Brick …|Brick Stone Border Stamp 3 Pc Set SM 4010.\r\nStamped Concrete Brick …|Bringing you the best in stamped concrete for over 40 years!\r\nCall us today for a free quote. 905 265 2500.\r\n\r\n\r\nStampedConcrete|Broom finished concrete driveway with a stamped concrete border.|Browse hundreds of pictures of stamped concrete patios, pool decks and more in this photo gallery.|Browsing Stamped \r\nConcrete Designs - Adding Quality, Durability and Esthetic Appeal to \r\nYour Property|Build long lasting high end surfaces with our wide range of stamped \r\nconcrete patterns and colors.\r\nJomarJimoh Interiors StampedConcrete Experts|Building a \r\nBeautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete \r\nPatio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools \r\nHome|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful \r\nHome with a Stamped Concrete Patio … DIY Tools Home|Building \r\na Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building \r\na Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful \r\nHome with a Stamped Concrete Patio … DIY Tools \r\nHome|Building a Beautiful Home with a Stamped Concrete \r\nPatio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio \r\n… DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY \r\nTools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful \r\nHome with a Stamped Concrete Patio … DIY Tools \r\nHome|But that fall may or may not have destroyed my knee.\r\nStamped concrete is slippery af.|Buy the best stamped concrete at affordable price \r\nand improve your home decoration. Also @GlobMarble offer \r\nconcrete stamp mats, stamped concrete accessories and tools, release agent and sealers for stamped concrete.|Call now for decorative stamped \r\nconcrete and avoid fungus growth and cracks of pavement blocks.\r\n+233247340405, +233552724859|Call today for your free \r\nestimate. Stamped Concrete, Colored Concrete, Retaining Walls.\r\nCaribbean Pools is on the...|Call us! We don\'t bite! \r\n\r\nSanAntonio Austin NewBraunfels CallToday ConcreteFinishes Epoxy Stamped|Came \r\nto check out a job I subbed out. Its great when all you do is prep &amp; put the finishing touches on a project.\r\n\r\n•\r\nDreamscapes came &amp; laid this beautiful stamped concrete pad.\r\nCut, base… …|Can\'t decide between stamped concrete or concrete pavers?\r\nCheck out the benefits of both below! concrete stamped pavers …|Celebrate With Me As Have Got Doubles!\r\nDecorative Stamped Concrete! 3D Floors! Reflector Floor System!\r\nAcid Stain Floors!|Cement Finisher-Stamped Concrete: Elite \r\nDesigned Concrete Inc. (Thornhill ON): \"customer project sites in the Greater Toronto Area, with occasional day travel required to other customer project locations in Canada. Qualificati.. customerservice eluta|Cement Finisher-Stamped Concrete: Elite Designed Concrete Inc. (Thornhill ON): \"office located in Thornhill, Ontario.\r\nRoutine daily travel is required to visit customer project \r\nsites in the Greater Toronto Area, with occasional day tra..\r\noffice eluta|Cement Finisher-Stamped Concrete: Elite Designed Concrete Inc.\r\n(Thornhill, ON): \"primary duties and responsibilities for the Cement Finisher. Stamped Concrete are as follows: Select colour and texture for concrete, direct placement...\" markham eluta|Cement Sidewalk Ideas | Driveways Patios Sidewalks Decorative Concrete Stamped Concrete ...\r\n…|Certified installers 3d, Stamped Concrete, Reflector Floors etc group pictures after training|Chaotic \r\nlaunches Chromogen Release Powders for stamped \r\nconcrete professionals. Available in 24 colors. Call or email for \r\nmore information.|Charming Concord home features a living room with original hardwood floors, kitchen with Statuario quartz countertops &amp; \r\nformal dining room. Professionally designed backyard with stamped concrete, two seating areas,\r\nveggie garden &amp; BBQ area|Check it out we have another stamped \r\nconcrete patio in process right now it\'s looking good, stay tuned to see the...|Check \r\nout a video showing you just a few examples of our previous Stamped Concrete Projects!\r\n\r\nHave a great...|Check out one of our favorite flagstone projects and get \r\nideas for your own backyard renovation! \r\n\r\nWe use flagstone, stamped concrete, paving stones, bricks &amp; more.\r\nWe can create an outdoor space you\'ll love...\r\ncall us at 425-358-2779.|Check out some examples of the \r\nbeautiful stamped concrete jobs we\'ve done:|Check out Sundek\'s SunStamp, our cost effective, \r\ndurable and long-lasting Stamped Concrete Overlay System!|Check out the stamped concrete, we \r\nmake it look like a wood deck but is just concrete|Check out these amazing stamped concrete patio ideas.\r\n\r\nGet in touch with us for quality concrete products. …|Check \r\nout this back porch luxury - stamped concrete to look like wood included!|Check out \r\nthis beautiful 2 tier Trex deck, fire pit and seat wall on stamped concrete.\r\nAnother wonderful project completed by Lunar Decks!|Check \r\nout this beautiful cobblestone pattern on a stamped concrete patio.\r\nInterested? CALL (615) 822-7134 for more pattern options.|Check out this beautiful cobblestone pattern on a stamped concrete \r\npatio. Interested? CALL (615) 822-7134 for...|Check \r\nout this beautifully custom fenced yard at 623 W Lancaster!\r\nAn inviting full front porch, rear deck, sodded lawn, irrigation system, stamped concrete walkways \r\n&amp; a 3-car oversized garage. Available for showings! Just give us a call!|Check out this charming home!\r\nThis charming 3-bedroom detached home is in a \r\nhighly desired location in south Cambridge. This home boasts a single-car attached garage and a double \r\ndrive. Lovely stamped concrete walkway welcomes you \r\n..|Check out this charming home! This charming 3-bedroom detached home is in a highly desired location in south Cambridge.\r\nThis home boasts a single-car attached garage and a double drive.\r\nLovely stamped concrete walkway welcomes you ..|Check \r\nout this charming home! This charming 3-bedroom detached home is in a highly \r\ndesired location in south Cambridge. This home boasts a \r\nsingle-car attached garage and a double drive. Lovely stamped concrete walkway welcomes you ..|Check out this charming \r\nhome! This charming 3-bedroom detached home is in a \r\nhighly desired location in south Cambridge.\r\nThis home boasts a single-car attached garage and a double \r\ndrive. Lovely stamped concrete walkway welcomes you ..|Check \r\nout this charming home!\r\n\r\nThis charming 3-bedroom detached home is in a highly desired location in south \r\nCambridge. This home boasts a single-car attached garage and a \r\ndouble drive. Lovely stamped concrete walkway welcomes \r\nyou home. The...|Check out this cool Stamped Concrete driveway in geometric pattern! It \r\nmakes concrete visually satisfying and it provides a non-skid sur… | CURB APPEAL | Pinterest \r\n| Stamped concrete driveway, Concrete driveways and Stamped concrete|Check \r\nout this gorgeous front entryway! You gotta love decorative \r\nstamped concrete with concrete sealer. CALL us...|Check out this gorgeous home!\r\nVery private 0.5-acre property on a quiet cul-de-sac with an oversized pool, surrounded by stamped concrete.\r\n\r\nThere is an incredible 4-season 16\'x24\' building \r\nfor multi-use space (heat, hydro, cable, ..|Check out this gorgeous home!\r\nVery private 0.5-acre property on a quiet cul-de-sac with an oversized pool, surrounded by stamped concrete.\r\nThere is an incredible 4-season 16\'x24\' building for multi-use space (heat, hydro,\r\ncable, ..|Check out this gorgeous home! Very private 0.5-acre property on a \r\nquiet cul-de-sac with an oversized pool, surrounded by stamped \r\nconcrete. There is an incredible 4-season 16\'x24\' building for multi-use space (heat, hydro, cable, \r\n..|Check out this inviting bungalow! Fully renovated in 2008, \r\nthis bungalow has 2274 square feet of development \r\nand is situated on a large lot in Meadowlark Park!\r\n\r\nAmazing curb appeal with a stamped concrete walkway, acrylic stucco, ..|Check out this inviting bungalow!\r\nFully renovated in 2008, this bungalow has 2274 square feet of development and is situated on a large lot in Meadowlark Park!\r\n\r\nAmazing curb appeal with a stamped concrete walkway, acrylic stucco, ..|Check out this inviting bungalow!\r\nFully renovated in 2008, this bungalow has 2274 square feet of development \r\nand is situated on a large lot in Meadowlark \r\nPark! Amazing curb appeal with a stamped concrete walkway, acrylic stucco, ..|Check out this inviting bungalow!\r\nFully renovated in 2008, this bungalow has 2274 square feet of development and is situated on a large lot in Meadowlark Park!\r\nAmazing curb appeal with a stamped concrete walkway, acrylic stucco, ..|Check out this inviting bungalow!\r\nFully renovated in 2008, this bungalow has 2274 square feet of development and is \r\nsituated on a large lot in Meadowlark Park! Amazing curb appeal with a stamped concrete walkway, acrylic stucco, ..|Check out this inviting bungalow!\r\n\r\nFully renovated in 2008, this bungalow has 2274 \r\nsquare feet of development and is situated on a large lot in Meadowlark Park!\r\n\r\nAmazing curb appeal with a stamped concrete walkway, acrylic stucco, ..|Check out this inviting bungalow!\r\n\r\n\r\n\r\nFully renovated in 2008, this bungalow has 2274 square feet of development \r\nand is situated on a large lot in Meadowlark Park! Amazing curb appeal with a stamped concrete walkway, acrylic stucco, newer...|Check out this inviting bungalow!\r\n\r\n\r\nFully renovated in 2008, this bungalow has 2274 \r\nsquare feet of development and is situated on a large lot in Meadowlark Park!\r\nAmazing curb appeal with a stamped concrete walkway,\r\nacrylic...|Check out this inviting home! Welcome to Meadowlark Park!\r\nThis bright 1,342-square-foot bungalow features a double attached \r\ngarage with new stamped concrete driveway and walks.\r\nFeatures include upgr', 0, '0', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '', 0, 0);
INSERT INTO `wp_comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`) VALUES
(8, 10, 'stamped concrete without color', 'Ciara-Burkitt77@miraclehouse.biz', 'http://gunnerrlexo.blogpostie.com', '23.254.56.46', '2019-02-24 19:53:07', '2019-02-24 10:53:07', '{WHAT Type OF Mix IS Greatest FOR STAMPED CONCRETE? Our contract price is economical and the most effective thus far.\r\nProfessionals within the Denver area have offered information about how much concrete price(s).|{Decorative \r\nStamped Concrete for Indoor &amp; Outdoor - BEST Quality &amp; \r\nPrices...\r\nباطون مطبع وملون…|DIY Stamped Concrete.\r\nModern Design Decorative Concrete с помощью @YouTube|Touch Up Roller for Stamped Concrete: на @YouTube|Мне понравилось видео \"Pattern Imprinted Concrete / Stamped Concrete Driveway by Readypave Ltd\"|Мне понравилось \r\nвидео \"Pattern Imprinted Concrete / Stamped Concrete Driveway by Readypave Ltd\"|Мне понравилось видео \"Pattern Imprinted Concrete / Stamped Concrete Driveway by Readypave Ltd\"|GlobMarble Random \r\nStones Stamped Concrete Mats …|GlobMarble Random Stones Stamped Concrete Mats …|\" Decorative Concrete\" \r\nThis is stamped concrete with grey highlights|\"Colored and stamped concrete is an ideal pool deck surface, combining the attributes of beauty, durability, and low maintenance. Stamped concrete pool decks give you a vast array of decorative options not possible with other pool deck|\"how to clean xylene \r\nfrom stamped concrete back rolling?\" …|\"Thanks to new methods and materials, stamped concrete \r\ncan deliver the same visual appeal as more expensive paving materials, such as brick and natural stone...\"|\"The outside is just a glimpse of the inside\" \r\n\r\nWhat does your parkinglot ADAramps sidwalks say? \r\n\r\nmultifamily ashalt renovations repairs remodel exterior AllThingsPossible atpconstruction paint striping stamped concrete|stampedconcretestamped concretecontractorconcretelifecstampedcolorfuldrivewaycincinnati|$145,000 REMODELED 4-bed/2-bath FOR SALE (139 Buena Vista, Twin Falls ID)\r\n\r\nThe completely finished basement has a beautiful stamped concrete floor. The one car garage has a large shop behind it. The back yard is fenced. More Details, Photos, and Apply ||$489,900 3682 N 162Nd Avenue, Goodyear, AZ - Entertain and relax poolside in this open floor plan home located on the 3rd Fairway of the Falls Golf Course,Tuscany Falls. A flagstone stamped concrete walkway... ARIZONA realEstate|$700,000 8630 S 22Nd Place, Phoenix, AZ - Welcome to your private lush desert modern oasis! This contemporary modern custom home is surrounded by amazing mountain and city light views! Stamped concrete... ARIZONA realEstate|***** OPEN HOUSE SUNDAY JULY 22, 2-4 *****\r\n116 Oleary Drive, Ancaster.\r\nOver 3,200 sq/ft with 10’ ceilings, hardwood and tile floors, as well as a splash pad for the kids built into the stamped concrete back yard. Don\'t miss this home!|**NEW LISTING AND OPEN HOUSE (9/16 1-3PM)** Great opportunity in Ashland Park! This charming home is located on a 0.31-acre lot and features a patio with stamped concrete &amp; private tree lined backyard. Listed by The Allnutt Group at The Agency (859)699-4663|**PRICE IMPROVEMENT** on this amazing home! No detail has been spared from top to bottom! Relax outdoors in your personal backyard oasis featuring a hot tub, screened porch and massive stamped concrete patio! \r\n\r\nView Listing Details:|*LAGOS AND IBADAN\r\nJUNE 21st - JUNE 23rd\r\n\r\n*ABUJA AND KADUNA\r\nJUNE, 28th - JUNE 30TH 2018\r\nTime is 8am daily\r\n\r\nTRAINING FEE\r\n*3D GRAPHICS FLOOR....35,000\r\n*3D WALLPAPER...15,000\r\n*WALL PANEL....15,000\r\n*REFLECTOR EPOXY FLOOR...20,000\r\n*DECORATIVE STAMPED CONCRETE FLOOR...20,000|*_Advantages of stamped concrete over other types of flooring_* \r\n1. Better aesthetic value\r\n2. Lesser maintenance...|.@GimondoSealing in NewYork this patio with a stamped concrete overlay that looks like real stone - just in time for summer SummerSolsticepic.twitter.com/5rNcKoAWVD|1,000 sq. ft. suspended stamped concrete deck on our mountain lodge home that is currently under construction.|1,100 sq ft stamped concrete pour today way to much money and name on the line for any mistakes.. My team on counting on u! hardwork Pray!|10-Step Process of Stamped Concrete|12 days until Christmas are you ready? I want stamped concrete for my patio, finished basement with a beer room..and a pink g-string. Or fuchsia...I’ll let you surprise me. Man this… …|1205 Estes Ln is a customhome boasting castlestonemasonry and a stamped concrete covered patio in the front.|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|12696 North Waters Edge Court\r\nYou will have a great time entertainment family and friends in your outside area. Stamped concrete patio, Fire pit, Hot Tub &amp; a cool outside storage shed features a porch &amp; a garage|1400 square feet of stamped concrete Roman slate grey on grey Toronto thesix custom concrete…|1410 Pohorecky Place is for sale with Cam Bird , Remax Realty Over 1700 sq feet, 4 bedrooms, 3 bathrooms, massive yard, triple stamped concrete drive and more! Asking 719,900. yxe… …|15% Off all Stamped Concrete projects sidewalk, driveway, walkway, staircase and commercial buildings — in Cross Roads …|16\" barn board stamped concrete done with Butterfield stamps and \r\nButterfield sienna brown integral color &amp; deep charcoal release.|16×32 Vinyl liner with \r\nArizona flagstone stamped concrete with colored boarder &amp; coping|3 bedroom all \r\nbrick semi-detached near Fanshawe College in London Ontario.\r\nJust reduced to $229,900! Great neighbourhood, stamped concrete drive.|3 bedroom semi detached on a quiet tree lined street in North east London. Walk to Fanshawe college.\r\n$239,900. Stamped concrete driveway and large lot.|3 Must-Know Facts About Stamped Concrete|3 Seasons addition &amp; new \r\nsiding complete. LP Smartside lap siding &amp; trim, Pella \r\nwindows and door, stamped concrete &amp; stained pine tomgue and groove ceiling.\r\nYou envision it and we can make it happen using the highest quality material and best craftsmen. @Pella_News|3 things remaining still: 8ft \r\nstamped concrete border around the pool. To be done next week.\r\nAlso automatic pool cover not ready yet. Lastly, fence \r\nlate August. The rest is cosmetics (landscaping mainly).|3052 Ansonia Drive \r\nis a beautiful stone front transitional and features an expanded three-car garage, custom kitchen, finished lower level, media \r\nroom, stamped concrete patio, fenced backyard and in-ground pool.\r\n\r\nDon’t miss out on this opportunity!|3162 Michelle \r\nCt, Loveland - This 4 bed 3 bath home is move in ready. Freshly painted \r\ninterior, Stamped concrete patio, ceramic point \r\ntile, new garage door and opener and brand new grade \r\nare just a few of the upgrades you will find.|4 Great Stamped \r\nConcrete Ideas for your Home Exterior|4 Reasons to Add a Stamped Concrete \r\nBorder to Your Driveway|4 Tips On Hiring The Best Stamped \r\nConcrete Stamped Concrete Contractor Blog Pattern Patio Driveway|51 Atlantic \r\nSt. Highlands. European fan stamped concrete pattern|520 Bradwell Chase realestate executive home on pool \r\nsized lot, incredible oversized deck &amp; extensive stamped concrete \r\npatios. Finished lower level with huge above grade windows for max sunshine|520 \r\nBradwell Chase realestate executive home on pool sized lot, incredible oversized deck &amp; extensive stamped concrete patios.\r\nFinished lower level with huge above grade windows for max sunshine|520 Bradwell Chase realestate executive home \r\non pool sized lot, incredible oversized deck &amp; extensive stamped concrete patios.\r\n\r\nFinished lower level with huge above grade windows for loads of sunshine|520 \r\nBradwell Chase realestate executive home on pool sized lot,\r\nincredible oversized deck &amp; extensive stamped concrete patios.\r\nFinished lower level with huge above grade windows for loads of sunshine|520 \r\nBradwell Chase realestate executive home on pool sized lot, incredible \r\noversized deck &amp; extensive stamped concrete patios. Finished lower level with huge above grade windows for \r\nloads of sunshine|520 Bradwell Chase realestate executive \r\nhome on pool-sized lot, incredible oversized deck &amp; extensive \r\nstamped concrete patios. Finished lower level with huge above grade windows for lots of \r\nnatural sunlight|520 Bradwell Chase realestate executive home on pool-sized lot, \r\nincredible oversized deck &amp; extensive stamped concrete \r\npatios. Finished lower level with huge above grade windows for lots of natural sunlight|520 Bradwell Chase realestate executive \r\nhome on pool-sized lot, incredible oversized deck &amp; extensive stamped concrete patios.\r\nFinished lower level with huge above grade windows for lots \r\nof natural sunlight|520 Bradwell Chase realestate executive \r\nhome on pool sized lot, incredible oversized \r\ndeck &amp; extensive stamped concrete patios. Finished lower level with huge above grade windows for loads of sunshine home|520 Bradwell Chase realestate executive home on pool sized lot, incredible oversized deck &amp; \r\nextensive stamped concrete patios. Finished lower level with huge \r\nabove grade windows for loads of sunshine home|5418 Saunders \r\nRd, Vinton Va\r\n\r\nBrand new 2018 home. This 3 bed, 2 bath brand new home is situated on just over an acre.\r\nMaintenance free siding, metal roof, 2 covered porches, industrial gutters, stamped concrete, generator hook-up and...\r\n…|6\" wood plank stamped concrete. Yes concrete not wood done by|7480 Faraway Trail is a custom-designed stone front transitional with 9\' ceilings and architectural details throughout. The home features a phenomenal master suite, finished lower level, stamped concrete patio - and so much more! View more here:|7800 North Ocean Blvd\r\n2901-3000sqft - $599,000\r\n3br/3ba\r\n\r\nThis beautiful 3B/3BA all brick home with bonus basement is just 300 steps from the beach! Oversized stamped concrete driveway and... …|6: TiqueWash 3 lb. Antiquing Colorants for Stamped Concrete (Sahara Night)\r\n\r\nTiqueWash 3...|6: TiqueWash 3 lb. Antiquing Colorants for Stamped Concrete (Medium Gray)\r\n\r\nTiqueWash 3 ...|STAIN-STAMPED CONCRETE-KITCHEN REHAB-BATHROOM|4: TiqueWash 3 lb. Antiquing Colorants for Stamped Concrete (Medium Gray)\r\n\r\nTiqueWash 3 ...|6: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Dark Gray)\r\n\r\nTiqueWash 3 lb....|4: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Jasper)\r\n\r\nTiqueWash 3 lb. An...|5: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Terra Cotta)\r\n\r\nTiqueWash 3 l...|… Stamped Concrete close-up of driveway border - Hot Springs, Arkansas - Techne Concrete|5: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Smokey Quartz)\r\n\r\nTiqueWash 3...|3: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Terra Cotta)\r\n\r\nTiqueWash 3 l...|4: TiqueWash 3 lb. Antiquing Colorants for Stamped Concrete (Sahara Night)\r\n\r\nTiqueWash 3...|6: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Jasper)\r\n\r\nTiqueWash 3 lb. An...|2: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Smokey Quartz)\r\n\r\nTiqueWash 3...|7: TiqueWash 3 lb. Antiquing Colorants for Stamped Concrete (Seasoned Earth)\r\n\r\nTiqueWash...|PAINTING-FLOORING-ACID STAIN-STAMPED CONCRETE-KITCHEN REHAB-|PAINTING-FLOORING-ACID STAIN-STAMPED CONCRETE-KITCHEN REHAB-BATHROOM REHAB- FREE ESTIMA|PAINTING-FLOORING-ACID STAIN-STAMPED CONCRETE-KITCHEN REHAB-BATHROOM REHAB-|STAIN-STAMPED CONCRETE-KITCHEN REHAB-BATHROOM REHAB- FREE|\r\nCement Sidewalk Ideas | Concrete Designs for Patios, Floors, Stamped Concrete ...|3: TiqueWash 3 lb. Antiquing Colorant for Stamped Concrete (Evening Oak)\r\n\r\nTiqueWash 3 l...|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|A Multi-Level PoolDeck Installation With NaturalStone Over Stamped Concrete Overlay. PebbleStoneCoatings USA|is going national. To repair stamped concrete issues.\r\nThere is such problems nationally that owner Ted Mechnick will be looking to partner with other like minded pros.\r\nCall 732-915-6391 if intetested.|… Used with Gator Grip around the pool and on the entire stamped concrete (1700 sq. ft.!) without the grip in most areas. Not as wet look as the non-acrylic but this is odorless and is easily applied, easy clean up. It goes further than the …|… Used with Gator Grip around the pool and on the entire stamped concrete (1700 sq. ft.!) without the grip in most areas. Not as wet look as the non-acrylic but this is odorless and is easily applied, easy clean up. It goes further than the …|… Used with Gator Grip around the pool and on the entire stamped concrete (1700 sq. ft.!) without the grip in most areas. Not as wet look as the non-acrylic but this is odorless and is easily applied, easy clean up. It goes further than the …|… Used with Gator Grip around the pool and on the entire stamped concrete (1700 sq. ft.!) without the grip in most areas. Not as wet look as the non-acrylic but this is odorless and is easily applied, easy clean up. It goes further than the …|best Stamped Concrete in CliftonPark,Contact us for Stamped Concrete including repairs,installations&amp;replacements|@abcddesigns ended up with a Sherwin Williams color, Stamped Concrete. Perfect. :-)|@albairaqqatar Red-colored, stamped concrete is used to simulate brick in crosswalks or otherwise to create decorative patterns.|@atiku For your landscaping (stamped concrete), flooring (3D epoxy), wall finishes (3D wall mural (epoxy), 3D wall panel and wall paper) and Ceiling (3D mural) in residential and commercial \r\nFor your best deliveries any location in Nigeria contact Engr. Abayomi on \r\n07033685325|@baris72 @hozaktas in the house. We have custom made polished+stamped concrete floors --gr8 for the pool house as well. It is very simple.|@BenRogers I had stained &amp; stamped concrete done in September. It\'s awesome, cheaper than pavers &amp; looks great. Not slippery at all.|@BouletHubs would that stamped concrete be slippery to walk on when wet or in the winter with a bit of snow? It looks awesome|@Bryan_Baeumler Stamped concrete around pool not even year old keeps flaking and turning white! What happened? byranhelp|@Cigar_Sass replaced with a grey flagstone stamped concrete patio with new stairs and such.|@ConcreteNetwork how can i get quality training on stamped concrete in Nigeria?|@CoronaTools @ValleyCrest Ps. any thoughts about stamped concrete vs tile? I am redoing my front step. Thxs... landscapechat|@DIYNetwork come build a deck on my house. I live right near @Lowes distribution center. All I have is a cracked stamped concrete patio.|@GlobMarble offer concrete stamp mats, stamped concrete accessories and tools, release agent and sealers for stamped concrete. All our services are best market price. So, why are you waiting, Order now!!|Anything Concrete Inc Provides Concrete Crack Repair, vancouver stamped concrete, leaking Foundation in …|Boom 1/4\" stamped concrete overlay European Fan! @superkrete International \r\ncan make those Concrete Dreams a|concreter needed in maidstone.\r\n\r\nBluestone charcoal stamped concrete driveway|CustomConcrete Masonry \r\nCan I remove Thompson\'s water sealer from stamped concrete - \r\nBig Mistake?|CustomConcrete Masonry Can I remove Thompson\'s water sealer \r\nfrom stamped concrete - Big Mistake?|CustomConcrete Masonry Can stamped concrete that \r\nhas been stained be changed to look like the stone that \r\nit ...|CustomConcrete Masonry Stamped concrete indoors, would like a wet look sealer that fills in the cracks,\r\nso t...|CustomConcrete Masonry Which is better stamped concrete vs stone patio?|Directory: patio designs,\r\nconcrete contractor, stamped concrete driveway|driveway stamped \r\nconcrete Overlay|driveway stamped concrete Overlay  process  European fan|EgressPros:\r\nStamped concrete backyard patio with seat walls and fire pit.|Glowing Stone Apply in Park,Hotel Lobbies,Pathway \r\nBorders,Stamped Concrete|ikoyiclubcarpark The ART of Creative Paving Broom Finished Concourse,\r\nStamped Concrete Borders to|ImagineerRemodeling Pros \r\nand Cons of Stamped Concrete vs. Interlock Pavers. Read Blog:\r\n|JustListed Trendy Modern Bungalow. Complete remodel 3 bedroom 1 full bath 1260asf.\r\n\r\nCome home to this light and bright home stamped concrete floors and wood ceilings \r\nthroughout. \r\nPropertyManagement LGA Listed Rental Views Seattle \r\nLakeForestPark|JustListed: 4BR + Rec Room + Salt Water Pool\r\n\r\nPrice, Location, and More Photos \r\n\r\nPerfect spot for entertaining with large, welcoming kitchen and incredible backyard \r\nset up with covered stamped concrete patio and privacy \r\nfenced yard!|Mikebusinessthread this is what we do, 3d floors, Reflector floors, Stamped Concrete floor ( foreign)|Mississauga Condos What A Home!\r\nBeautiful Stamped Concrete Steps Bring You To The Inviting Front …|MondayMotivation time!\r\nA snap shot of our recent stamped concrete pour \r\nat the Gables Buckhead amenity deck featuring @Argos_Online concrete and colored with \r\nSikaScofield integral mix.\r\n\r\nShout out superintendent Mike McLean for an outstanding \r\njob on this project!|oldworld CollegeFootball \r\ncobbelestone americanmade , ourCobblestone , more durable than stamped concrete or \r\nflagstone , priced competitively to give you the best product , \r\n9184373777 ,|Pipes Plumbing - DIY Stamped Concrete Forms HomeImprovement|Pool deck transformation - thin stamped concrete overlay to replicate the look, color and \r\ntexture of natural|PremierSurfaces 5 Tips to Increase the \r\nDurability of Stamped Concrete. Read Blog:|Protip: apply a \r\ndurable coating to protect those beautiful Stamped Concrete on your driveway coating concrete driveway|realestate home Meadowlands of \r\nSunningdale. Beautifully built custom exec home with large pool sized lot, oversized covered deck and extensive stamped concrete patios.\r\n\r\nFinished lower level with huge above grade windows!|realestate home Meadowlands of Sunningdale.\r\nBeautifully built custom exec home with large pool sized lot, oversized covered deck and extensive stamped concrete patios.\r\nFinished lower level with huge above grade windows!|realestate home Meadowlands of Sunningdale.\r\n\r\nBeautifully custom exec home with large pool sized lot, oversized covered deck and extensive stamped concrete patios.\r\nFinished lower level with huge above grade windows!|realestate home Meadowlands of Sunningdale.\r\nBeautifully custom exec home with large pool sized \r\nlot, oversized covered deck and extensive stamped concrete patios.\r\nFinished lower level with huge above grade windows!|Rhino \r\nflooring’s experts offers all types of colored shiny &amp; stamped concrete crack|RomanaConstruction after I make the borders \r\ndark grey and seal all the stamped concrete|RT @Shorewest_RE: Want to create a beautiful patio but for less money?\r\nWhy not go for a stamped concrete patio? That way you can mimic brick, flagstone \r\nor cobblestone for a fraction of the price. ShorewestRealtors|Sold\r\nThis single story 4 bedroom 2 bathroom on oversized 0.47 acre lot in Old Rancho San Diego sold for $529,000\r\nHuge lot with lush landscaping, covered patio in front &amp; back, stamped concrete driveway &amp; detached 4 car garage with additional room for parking/RV.|stamped concrete - technology and molds \r\nfor production: …|stamped concrete borders and design in middle \r\nwith handswirled finish inside. concrete|stamped-concrete patio....looks like slate!\r\n…|toyota sienna types restaining stamped concrete|WTH!!!!!!\r\n\r\n\r\nTroopers said Joaquin Grancho, the owner of Pavers, Walls and Stamped Concrete, of Fort Mill, South Carolina, was driving the wrong way on I-77 in the median....\r\n…|@hgtvcanada @make_it_right What are your thoughts on stamped concrete for front steps \r\nand backyard patio vs other solns? Is it durable?|@HomeAdvisor Why concrete co.\r\noffer stamped concrete, and when u ask them about it they say they have to rent the stamping equipment|@HomeDepot stamped concrete in place of dirt!|@Horlacunley: @Horlacunley: DURABILITY \r\n; STAMPED CONCRETE FLOOR IS THE ANSWER.|@Horlacunley:\r\nDURABILITY ; STAMPED CONCRETE FLOOR IS THE ANSWER.|@iam_Davido For \r\nyour landscaping (stamped concrete), flooring (3D epoxy), wall finishes (3D wall (epoxy),\r\n3D wall panel and wall paper) and Ceiling (3D mural) in residential and commercial \r\nFor your best deliveries any location in Nigeria contact Engr.\r\nAbayomi on \r\n07033685325|@JRandSonsConcr provides Foundation Contractors, \r\nConcrete Driveway, Concrete Sidewalks, Stamped Concrete, Concrete Foundation Repair|@LeahBodnar and I are looking to get a few quotes for a \r\npatio installation. Most likely looking at stamped concrete but possibly open to pavers.\r\n\r\nWe will also need a built in fire pit which will \r\nrun off of a gas line. Anyone have recommendations?|@LIRR \r\nhas added new architectural finishes to Deer Park Station - terrazzo flooring, wood ceilings, exterior brick \r\ndecorative walls, a new information wall, signage &amp; stamped \r\nconcrete sidewalks. amodernli @SuffolkEcoDev|@Lowes faux \r\nstone wall (external), circular stamped concrete drive way, sprinklers \r\nin front lawn, exterior window accent trim.|@masonsmarkstone \r\nlike the wall &amp; fire pit but the stamped concrete has expansion joint cut thru the \r\npattern|@MazzelloJoe just spent a couple of hours sealing some \r\nstamped concrete in my back yard while listening to your reading of, “With the \r\nOld Breed”. You did a marvellous job. Thanks for helping me pass the time.|@NikaStewart Here is a website of actual stamped concrete for some ideas No glamour shots here, but great examples;|@o_oza \r\nhere are some examples of stamped concrete|@patricksesty Yes, kind of...there will be stamped concrete brick pattern between the bike and car \r\nlane so cars will feel if they drift over|@PaulLafranceDES can you tell me the \r\nmakers of the stone siding you use on deckedout? Stamped concrete..\r\nscrews into the wall...thanks|@RepJudyChu Caltrans in LaCanada put in stamped concrete center divider wall on 210.\r\n\r\nHow much did that waste of money cost??|@rhaiandrhai try our decorative stamped concrete floors.\r\nDurability Guaranteed and our prices are Reasonable.|@robergotigoti hardwood stamped concrete, such a neat look!!!|@SherwinWilliams light grey joists, neutral tan walls and stamped \r\nconcrete look for the floor, a loft style design MyColorResolution|@skbayless67 Nah, just be careful.\r\nIt\'s super slippery on your stamped concrete yaysnow \r\nWhiteChristmas|@sparklegirl35 @alimshields @LoveRemarkableU @NKOTBSBgroupie @JkShadysCdnGirl @nkotbgal21 Ugh.\r\nMark is resealing our stamped concrete patio.|@TenesipiB They have stamped concrete or \r\nengraved concrete that looks like stone work but doesn\'t pop up &amp; hurt your car.|@TonyStewart whoever did \r\nyour expansion joints on your stamped concrete did a horrible job...I\'d call him back there!|@vanguardngrnews For your landscaping (stamped \r\nconcrete), flooring (3D epoxy), wall finishes (3D wall epoxy), 3D \r\nwall panel and wall paper) and Ceiling (3D epoxy) in residential and commercial \r\nFor your best deliveries any location in Nigeria contact Engr.\r\n\r\nAbayomi on \r\n07033685325|Watch this earlier video of our hard working VMGTeam pouring concrete as \r\nthey create a basketball court for the onlooking family!\r\nYou will also see the awesome stamped concrete patio?!!\r\n\r\nlansingmi eastlansingmi grandledge Holtmi …...|Wood plank stamped concrete.\r\ndecorativeconcrete concrete stampedconcrete stainedconcrete woodlook|Happy Halloween \r\n\r\nTo all our customers past, present and future, we wish you a HappyHalloween!\r\n\r\nAnd remember - if you need your driveway exorcising, call Northern Cobblestone \r\nand transform your Blackpool home with our stamped concrete|New \r\nListing | 358 Edgewater Drive, San Marcos Ca \r\nTHIS HOME IS A MUST SEE! Featuring a beautiful entertainers\' yard with tropical landscaping,\r\nfire pit, fountain, and stamped concrete patio.|Better than New \r\nConstruction! Impressive 2-Story withWetland Views.\r\nHome Features a Gourmet Kitchen, Maintenance Free \r\nDeck, Stamped Concrete Patio &amp; So Much More! Contact Me Today for a Private Showing 612-703-7285.\r\n\r\n\r\n|FEATUREDLISTING Stunning Detached Mattamy Home In High Demand Neighborhood Of Milton * New Stamped Concrete Front Steps &amp; Walkway* Dream Custom Backsplash \r\n+ Upgrades, Ss Appliances\r\n\r\n$819,900 Milton and Photos|Just Listed Stunning Mattamy Home.\r\n\r\nNew Stamped Concrete Front Steps &amp; Walkway. Dream Custom Backsplash + Upgrades, Ss \r\nAppliances. Open Concept, Sleek Hardwood Flr. Valence Lighting.\r\nImmaculately Maintained Backyard* Spacious Modern Bedrooms.|Just Listed Stunning Mattamy Home.\r\nNew Stamped Concrete Front Steps &amp; Walkway. Dream \r\nCustom Backsplash + Upgrades, Ss Appliances. Open Concept,\r\nSleek Hardwood Flr. Valence Lighting. Immaculately Maintained Backyard* Spacious Modern Bedrooms.\r\n⠀|OPEN HOUSE ALERT \r\n\r\nSunday, October 7, 2018\r\n\r\nCome see this beautiful home, 3/3 + den near Pineview!\r\n\r\nThe stamped concrete driveway will stand out, \r\nas well as the carefully planted yard with all... …|18276 Maffey Drive, Castro Valley\r\n3 Bedroom 2.5 bathroom home w/ gorgeous backyard &amp; interior.\r\nNew roof &amp; fully owned solar. Composite deck surrounded by \r\nstamped concrete. Large living room &amp; cozy gas...\r\n\r\n…|OPEN HOUSE SUNDAY10/28 1-4 pm. WOW!!! 1/2 acre cul-de-sac lot accented by a large stamped concrete patio and \r\nbeautiful landscaping. Located at 4273 Golden Meadows Ct, Grove City, OH and priced at only $236,900 this 4 Bedroom, 2.5 bath two|Great Starter home \r\nWell maintained 4 Bedroom 2 Bath home. Dual pain windows.\r\nStamped concrete driveway and walkway. Large covered wrap around patio.\r\n\r\nRock landscape front and back yard… …|NEW LISTING\r\n1195 DARTMOUTH CIR. DIXON\r\n3 BEDROOMS\r\n2 BATHROOMS\r\nGORGEOUS CHOCOLATE CABINETS. GRANITE COUNTERS. SPACIOUS BACKYARD WITH STAMPED CONCRETE AND YOUR OWN TIKI HUT.\r\n\r\nOFFERED AT $429,900 …|Price Improvement! Impressive 2-Story withWetland Views.\r\nHome Features a Gourmet Kitchen, Maintenance Free Deck, Stamped Concrete Patio &amp; So Much \r\nMore! Open House Saturday, September 22nd from 11am-1pm!\r\nCome Stop by or|JustListed Glendora!\r\n\r\n2BD, 1.5BA, Oak hardwood, updated kitchen w/granite, All \r\nseasons room, spacious deck,Koi Pond, stamped concrete \r\npatio, newer vinyl privacy fence, Newer roof &amp; siding, Newer Central Air &amp; \r\nHot-Water Heater|Stamped concrete resurfacing in the Omaha Nebraska area!\r\n\r\nWho ’s the flagstone look\r\n\r\n\r\nconcrete overlay concretedesign stampedconcrete homedecor patioliving concreteflooring omahanebraska omahaphotography|PROJECT OF THE WEEK \r\n\r\nAnother amazing transformation complete \r\n\r\nFrom cracking stamped concrete to this stunning paver patio complete with steps, pergola, fire \r\npit, walkway, and softscaping to bring everything together!\r\n\r\nSome incredible before and after photos.|CRSBuildersINC \r\nConstruction tips and style choices for a durable,\r\nlow-maintenance stamped concrete driveway that enhances the curb attractiveness of your home.\r\n\r\nGet further info call us:- 858-282-1311 or \r\nvisit here:-|Patio weather can return any day now!\r\n\r\nThis Stamped Concrete pattern was done at Firebirds…|Revive your old stamped concrete - no need to tear it out!\r\n\r\nOur STAMP-WOW process is going to save you the heada…|@olgaopolis @fatTireBikeBoy cool \r\npedestrian crosswalks. Note - these are stamped concrete crosswalks unlike many of the brick ones in @CityofEdmonton. Brick is \r\nnot smart in our climate. Stamped is the way \r\nto go and can be very beautiful. …|Great video showing the stamped concrete process.\r\n\r\nCheck out Westcoat Stamp-It in our Texture Coat (TC) category for a system that\'s \r\ncost-effective, high-build, unlimited colors and \r\nSUPPORTED BY THE WESTCOAT TEAM! More on …|I have a stamped concrete patio that looks like stone, and we love it.\r\nGet lots of compliments on it, too. …|STAPRO Stamped Concrete \r\nPLESURE OF ART\r\nKfarhim villa Mr. Assef Ghannam\r\n70838788\r\n03923863\r\nstamped Concrete skin tilebordir European_fan …|@AnastasiaRubine ..good morning,\r\nthis is a gorgeous driveway, looks like a stamped concrete rather then pavers?|A 2 tier \r\nTrex Deck, fire pit and seat wall on stamped concrete!|A beautiful landscape with \r\nfaux rock waterfalls, planters boulders, streams and stamped concrete decking.\r\n\r\n\r\nwaterfall waterfalls boulders planter streamconcrete shotcrete deck… …|A beautiful landscape with faux rock waterfalls, planters boulders, streams and stamped concrete decking.\r\n\r\n\r\nwaterfall waterfalls boulders planter stream concrete shotcrete deck… …|A concrete \r\npatio gets a stamped-concrete floor treatment and new stairs.\r\n\r\nConcreteRepair ConcreteAdvice...|A cost-effective way of resealing stamped concrete.\r\nLet us make a mess into success!|A gorgeously-landscaped \r\ncorner lot. Tinted driveway &amp; stamped concrete path \r\ncoordinate with the clay tile roofing. A lovely leaded glass door leads into the entrance hall.\r\n3 bedrooms &amp; 1.75 baths. claudiahargrove realestate …|A great way to spruce up that front entry is by adding a beautiful decorative stamped concrete front porch.\r\nIs your front step needing an update? Let us help you.\r\nCall or visit our newly updated website by... …|A little stamped concrete training today!|A modern space deserves modern paving.\r\nThis is the Eterna Collection from Oaks. Can\'t do this with stamped concrete.|A path to sprucing up street appeal...staining the stamped concrete.\r\nI can hardly move but looks much better &amp; there\'s still \r\na little sun left to enjoy. YAY! streetappealhelpssell|A recent recolor of a \r\nwarn and weathered patio and walkway in North Tonawanda.\r\n\r\nCurious what kind of maintenance your stamped concrete \r\nneeds? Message us today to find out how we can make \r\nyour stamped concrete look new again!|A stained and stamped concrete patio \r\nlike this creates a beautiful accent to your backyard.\r\n\r\nCall (786) 899-2146 for a professional patio resurfacing service!\r\n\r\n\r\nMiami Concrete|A stamped concrete overlay done on a porch and garage entrance adds so much character to the home.\r\n\r\nInstaller: Hopkins Flooring|A stamped concrete driveway creates \r\nan impressive home entrance. It also upgrades the overall design of your home.\r\n\r\nCall (972) 885-6067 now!\r\n\r\nDallas Concrete|A stamped concrete driveway from Concrete Craft gives your home an impressive entrance and upgrades your overall home design.|A stamped concrete finish works so well around the swimming pool.\r\n\r\nYa it’s workin \r\n.\r\n.\r\nMusic:…|A stamped concrete front entry can add instant curb appeal to \r\nyour home. Choose from a variety of patterns, colors, and textures.\r\nCall us @ (972) 808-5281 for more info!|A stamped concrete patio can look as good as pricey, high-end materials.\r\nCALL (281) 407-0779 for a FREE quote....|A stamped concrete patio can look as good as pricey,\r\nhigh-end materials. CALL (281) 407-0779 for a FREE \r\nquote....|A stamped concrete patio can look as good as pricey, high-end materials.\r\nCALL (281) 407-0779 for a FREE quote....|A stamped concrete patio in process.|A stamped \r\nconcrete patio is more than enough to turn a drab space into a first-class outdoor lounge.\r\n\r\nCALL (615) 822-7134 for a FREE quote!|A stamped concrete patio looks like large \r\npavers, and is the perfect outdoor living setting for…|A stamped concrete patio will serve you well for many \r\nyears.\r\nCall us now and get your concrete project done (850) 792 1131|A stamped concrete walkway can add some great curb \r\nappeal to your home! Learn more about our options and how you can add this to your property when you call today.|A stamped concrete walkway \r\ndefinitely makes for a warm welcome. CALL (717) 245-2829 for a \r\nFREE consultation and quote.|A textured, stamped concrete finish replicates \r\nthe look of natural materials at a fraction of the cost. Seeing as today is MilkChocolateDay, we\'ll take it in chocolate brown! StampedConcrete FlowcreteAsia|A \r\ntotal redesign of this property in Fort Lauderdale, Florida.\r\n\r\n\r\nUpgraded this little bungalow driveway to concrete cut-outs and wood plank stamped concrete porch.\r\n\r\n\r\nBroward County Concrete used a medium gray...\r\n…|A true showplace nestled into a private lot with a stamped concrete heated \r\ndrive, hand crafted doors and covered rear porches!\r\nWoodland stands along side today\'s trends with a gourmet kitchen, marble floors, a \r\nWhirlpool Master bath and an awesome game room|A1 we need the front porch redone and \r\nstamped concrete touched up ETNHolmesChatSafety|A4) big challenge \r\nis stamped concrete patio maintenance Resealing made it slippery when rains ASCanadaDIY|Achieve decorative finishes that replicate granite,\r\nslate, stone, brick or wood aesthetics with Increte Stamped Concrete.\r\nTake a look at a recent application at Genting Highlands in Malaysia \r\nStampedConcrete Flooring Resort|Achieve the Bluestone look for your patio with \r\nstamped concrete! … concrete|Acid staining stamped concrete creates a beautiful,\r\ntextured appearance. Here\'s how to do it: …|Acid staining stamped concrete \r\ncreates a beautiful, textured appearance.\r\nHere\'s how to do it:|Acquire a custom concrete pool deck that matches \r\nthe style of the pool, and your usage by installing stamped concrete overlays.\r\nLearn more about its benefits. Call us @ (773) \r\n377-8976!|Acquire a luxurious looking, economic, and functional concrete pool deck \r\nwith Stamped Concrete Overlays. Call (720) 545-1766 to more about its benefits!\r\nFREE Estimate!|Acquire an expensive look at a minimal cost.\r\nCALL (678) 534-3930 to know ore about stamped concrete patio overlays.|Acrylic stone varnish that forms a durable, transparent thin protective barrier.\r\nSuitable for stamped concrete\r\n|Add a unique appeal to any outdoor space by imprinting patterns \r\nin freshly laid concrete. Here are 5 stamped concrete patio design ideas \r\nto enhance the appearance - \r\nstampedconcretepatio stampedconcrete concretecontractor|Add pattern and texture to your driveway \r\nwith our stamped concrete overlays and coatings! Call us @ (408) 709-7256 for \r\na free|Add some character to your concrete. We can create stamped concrete that is patterned, textured, embossed to resemble brick, slate, flagstone, stone, tile, wood, and varios other patterns and textures!|Add some extra flare to your stamped \r\nconcrete steps with integrated lighting! Let us make your concrete \r\nproject look unique day and night!|Add value to your home with our Stamped Concrete Overlay.\r\nIt\'s a cost effective investment that is sure to \r\nlast....|Added a stamped concrete patio, flagstone walkway and fire pit its \r\nall coming together nicely.|Advantages of Stamped Concrete vs.\r\nPatio Pavers|Advantages of Stamped Concrete vs. Patio Pavers|After pics of a \r\nnewly stamped concrete pad with an Arizona flagstone stamp \r\nand a northern star stamp imprint....|Ageless Concrete - Wood Plank \r\n- Stamped Concrete. Schedule is already filling \r\nup - Now is the time to book a free Design Consultation!\r\n608-242-2446|alei din beton amprentat stamped concrete \r\nwalkway ideas 3 …|All Concrete Needs Stamped \r\nConcrete Driveways/Patio Established in 2011. FREE ESTIMATES driveway concrete \r\npatio pavers design paving home… …|Am a civil engineer,\r\nmy side hustle are stamped concrete, pop ceiling, quality painting.|Amazing Concrete &amp; Bricks Patio Design Ideas | Stamped Concrete Patio via @YouTube|Amazing Stamped Concrete Gallery Images \r\n-|Amazing Stamped Concrete Gallery Images -|Amazing Stamped Concrete Gallery Images -|Amazing Stamped Concrete Gallery Images -|Amazing Stamped Concrete Walkway For \r\nModern House Ideas Using Wooden Entrance Gate Designs|Amazing Stamped Concrete Walkway For Modern House Ideas Using Wooden Entrance Gate Designs|Amazing Stamped Concrete Walkway For Modern House \r\nIdeas Using Wooden Entrance Gate Designs|Amazing Stamped Concrete \r\nWalkway For Modern House Ideas Using Wooden Entrance Gate Designs|Amazing Stamped Concrete Walkway For Modern House Ideas \r\nUsing Wooden Entrance Gate Designs|An amazing Pool deck in stamped concrete \r\nwith slate skin pattern. Our job is to make it a reality for you!!!\r\n\r\n\r\nCall 08113131313, +234(0)8023114545 or visit our \r\nwebsite: \r\n\r\ncreative creativepaving paving pavingideas nigeria lekkiproperties lekkilagos|An amazing stamped concrete transformation. On this application we re-color the concrete light gray and applied two coats of a solvent-based sealer.\r\nHired a trained professional. 860-919-7819|An entertainer\'s dream!\r\nWith a true open floor plan, this charming house has it all.\r\nEnjoy your favorite beverage on the stamped concrete patio, \r\nwatch the sunset whilst sitting on your… …|An Intro To Fundamental Issues In Stamped Concrete Kansas City|An inviting stamped concrete walkway with European Fan Pattern. Beautiful, isn\'t it?|And for anyone doing architecture or interior design\r\n\r\nLeave the wood stamped concrete out of your arsenal\r\n\r\nThat shit is lame to af to me|Another backyard patio \r\nmade beautiful &amp; so much more cozy with stamped concrete!\r\nAs the cooler weather hits... who wouldn’t to \r\nsit out here with a hot cup of coffee to start the morning!?\r\n\r\nconcrete concretelove stampedconcrete\r\n•••\r\nCall us for an estimate: (402) 290-2016|Another backyard patio made \r\nbeautiful &amp; so much more cozy with stamped concrete! As the cooler \r\nweather hits... who wouldn’t to sit out here with a hot cup of coffee to start \r\nthe morning!? concrete concretelove stampedconcrete\r\n•••\r\nCall us for an estimate: (402)|Another outdoor kitchen done!\r\nPatio cover over stamped concrete floor, finished off with…|Another recent job.\r\nReal PA bluestone or stamped concrete?|Another Stamped concrete Job\r\nBuff concrete color with an antique grey release highlights|Another unique, \r\nstamped concrete patio installation. patio concrete|Antiquing &amp; \r\nRe-Sealing Stamped Concrete\r\n\r\n|Antiquing &amp; Re-Sealing Stamped Concrete\r\n\r\n|Anyone know of any deck builders/stamped concrete \r\ncontractors in cbus? Need prices/ideas…|Anything Concrete Inc Concrete Crack \r\nRepair, vancouver stamped concrete, leaking Foundation in @Vancouver - …|Anything Concrete Inc Concrete \r\nCrack Repair, vancouver stamped concrete, leaking Foundation in @Vancouver - …|Anything Concrete Inc \r\nConcrete Crack Repair, vancouver stamped concrete, leaking Foundation in @Vancouver - …|Anything Concrete Inc Provides Concrete Crack Repair, vancouver stamped concrete in @Vancouver - @Surrey.\r\n…|Anything Concrete Inc Provides Concrete Crack Repair, vancouver stamped concrete, leaking \r\nFoundation in …|Anything Concrete Inc Provides vancouver stamped concrete, leaking Foundation &amp; crack repair in @Vancouver - …|Are you deciding between pavers vs.\r\nstamped concrete? It definitely is a matter of opinion and what your...|Are you \r\ndreaming of summer? So are we. Get ready for MemorialDay with a stamped concrete patio or fire pit for your backyard.\r\nPool not included ;)\r\nCall Cedar County Landscaping at 425-358-2779 to get started \r\non your backyard getaway|Are you getting the most out of Summer?\r\n\r\n\r\nCatch some rays in style, by lounging on a stunning new stamped \r\nconcrete patio for your garden.\r\n\r\nCall today to book your pattern imprinted concrete driveway or patio for your Fleetwood|Are you thinking of installing stamped concrete?\r\nTake a look at these 8 simple steps for application FlooringApplication Applicator HowTo Flooringadvice \r\nStampedConcrete|Arizona Flagstone stamped concrete poured against rock.\r\nNWCL Kitsap|Arizona Flagstone Stamped Concrete …|Arizona Flagstone Stamped Concrete Driveway in London Ontario|Arizona Flagstone stamped concrete driveway \r\nwith Roughcut Border in London.|Arizona Flagstone Stamped Concrete \r\nPatio Area in Komoka Ontario|Arizona Flagstone Stamped Concrete Patio in London Ontario|Arizona Flagstone Stamped Concrete Patio in London Ontario|Arizona \r\nFlagstone Stamped Concrete Patio with Curb Edge Border in London Ontario|Arizona Flagstone \r\nStamped Concrete Patio, Sidewalk and Steps in Komoka \r\nOntario.|Arizona Flagstone Stamped Concrete Pool Deck in Komoka \r\nOntario|Arizona Flagstone Stamped Concrete Sidewalk and \r\nPorch in London Ontario|Arizona Flagstone Stamped Concrete Steps in London Ontario|Arizona Flagstone Stamped Concrete Walkway in London Ontario|Arizona flagstone stamped concrete \r\nnrconcretemass \r\nswimmingpool \r\nstampedconcrete \r\ncon…|Around The USA - Stamped Concrete Kansas City Tactics|Artificial Turf,\r\nStamped Concrete Steps, Court yard, Walls with Cap and Dry \r\nRiver Bed|Ashlar Pattern Tennessee Field Stone - Nina \r\nBerman Photography: Stamped Concrete Stone Pattern Dayton Ohio Concret...|Ashlar slate stamped concrete patio recently \r\nsealed thanks to dry fall weather! NWCL Kitsap|Ashlar slate stamped concrete patio we are installing today in Arlington, Texas.\r\nstampedconcrete|Ashlar Slate Stamped Concrete Walkway: …|Ashlar \r\nSlate Stamped Concrete Walkway: …|Ashlar Slate Stamped \r\nConcrete Walkway: …|Ashlar Slate stamped concrete\r\nnrconcretemass \r\nstampedconcrete \r\npool \r\nhomeowners \r\nconc…|Ashlar Stamped Concrete pattern by Camocrete. You can see patterns like this at|Ask Jennifer Adams:\r\nCan you put a stamped concrete floor in bathrooms?|At I\'Fash Floors \r\nyou get a world-class concrete floor design that elevates your property to the next \r\nlevel...Our services include; 3D Epoxy Floor/Wall/Ceiling, Stamped Concrete Floor, \r\nReflector Epoxy Floor and so on. Call/WhatsApp us on 08188276300, 08188276305.\r\nThank you!|At least if my house floods I can get my pool repaved.\r\nI want stamped concrete around my pool and in my \r\ndriveway.|ATTRACTIVE STAMPED CONCRETE DESIGNS FOR YOUR DRIVEWAY.\r\nWhen choosing a finished surface for your \r\ndriveway, stamped concrete is cost-effective, durable, and aesthetically pleasing.\r\n\r\nstonework craftsman coloradohome mountainhomes|August jobs stamped \r\nconcrete|Awesome new listing in SE Mandan and just a few blocks south of Fort Lincoln elementary!\r\nFabulous views of the prairie with no back neighbors!\r\nWalkout to stamped concrete patio. Listed by Judy Pfiefle Maslowski, Bianco Realty.\r\n…|Awesome Uses For Stamped Concrete In Your Home \r\n\r\nConcrete is functional and long lasting. But did you know it could also be \r\nbeautiful? Lets look at the art of \'stamped concrete\' , where patterns are stamped into the wet concrete.\r\nIt can be used around pools, patios but al…|Backyard \r\nStamped Concrete Patio Ideas|Banish boring, plain gray concrete walkways and sidewalks with stamped concrete in patterns, designs and colors that bring out the best in your surroundings.|Basement Floor by Stamped Concrete: via @YouTube|Basement floor smooth sweep trowel finish, by Stamped Concrete:\r\nvia @YouTube|Basement Floor....How Do You Deal With The Drip Holes?\r\nBy Stamped Concrete via @YouTube|Basement Floor....How Do You Deal With The Drip Holes?\r\n\r\nBy Stamped Concrete: via @YouTube|Beautiful 4 1 Bedroom Home * \r\nCorner Lot W/ Oversized Backyard, Exposed Aggregate/Stamped \r\nConcrete Patio &amp; Inground Sprinklers * Large Liv &amp; Din Rm \r\nW/ Gas Fp * Upgraded Eat-In Kitchen W/Granite Counters,...\r\n…|Beautiful ashlar pattern stamped concrete patio .\r\nstamped patio pattern concrete…|Beautiful colonial in Riverview subdivision with 2 \r\nmaster bedrooms and a third large bedroom.\r\n\r\n4-1/2 baths,fully finished basement, 22×38 attached garage, rear \r\ndeck and stamped concrete patio. Freshly painted, hardwood floors recently refinished, and...|Beautiful European Fan stamped concrete driveway.\r\nBoost your curb appeal with Super Stone Products today!...|Beautiful European Fan stamped concrete \r\nwalkway. A timeless classic design. Also available \r\nFrench Fan Stone and...|BEAUTIFUL FAMILY FARMHOUSE!\r\n\r\nPrivate 191.7 productive acres w/ 4,300 home! You will walk \r\nup to a covered front porch w/stamped concrete, large cedar \r\nwood posts &amp; one of the most beautiful views in Polk County.\r\nDouble porch swings will allow you...|Beautiful Family Home \r\nOn Large Lot In A Great Neighbourhood. Hardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The Side Porch \r\nAnd Stamped Concrete Patio In The Back Near Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\n\r\nHardwood Floor Throughout Living Room/Dining Room, \r\nAnd Bedrooms. Spacious Kitchen And Finished Basement. Enjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot \r\nIn A Great Neighbourhood. Hardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\nHardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\nHardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The \r\nSide Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\n\r\nHardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy \r\nBbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\n\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\n\r\nHardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\n\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The \r\nSide Porch And Stamped Concrete Patio In The Back. Near Schools,\r\n…|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\nHardwood Floor Throughout Living Room/Dining Room, \r\nAnd Bedrooms. Spacious Kitchen And Finished Basement.\r\nEnjoy Bbqs On The Side Porch And Stamped \r\nConcrete Patio In The Back. Near Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\n\r\nHardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The Side Porch And Stamped Concrete Patio In The Back.\r\nNear Schools, …|Beautiful Family Home On Large Lot In A Great Neighbourhood.\r\n\r\nHardwood Floor Throughout Living Room/Dining Room, And Bedrooms.\r\nSpacious Kitchen And Finished Basement. Enjoy Bbqs On The Side Porch And Stamped Concrete Patio In The \r\nBack. Near Schools, …|Beautiful move in ready ranch.\r\n\r\nUpdated kitchen, spacious floor plan, brand new stamped concrete patio.\r\nHuge fenced in|BEAUTIFUL MOVE-IN READY RANCH.\r\n\r\nUPDATED KITCHEN, SPACIOUS FLOOR PLAN. BRAND NEW \r\nSTAMPED CONCRETE PATIO. HUGE FENCED IN|Beautiful move-in ready ranch.\r\nUpdated kitchen, spacious open floor plan. Brand new stamped concrete patio.\r\nHuge|BEAUTIFUL PROPERTY FOR SALE: Contemporary home \r\nwith custom finishes (stamped concrete thru out first floor, wood \r\nand stone accent walls, granite counter tops).\r\n\r\n\r\n4 beds 3 baths 2,418 sqft\r\nMLS : 1949851\r\nCall Broker/Realtor Inna Mizrahi at 702-812-6828 REALESTATE LasVegas|Beautiful, durable, \r\nand cost-effective. Acquire this stamped concrete pool deck \r\nnow! CALL (636) 256-6733 to speak with one of our experts.\r\n\r\n\r\n\r\nDecorative Concrete Resurfacing\r\n715 Debula Dr\r\nBallwin, MO 63021\r\n(636)|Beautiful, stamped concrete using textured \r\nmats and Super Stone® products never disappoints! What a gorgeous...|Beautify your driveway with Bomanite\'s expertise in Stamped Concrete and \r\nArchitectural Concrete. Call us today at 905.265.2500.\r\n\r\n•\r\n•\r\nStampedConcrete|Beautify your home or business with the distinctive look of high-quality stamped concrete.\r\nYou’re welcome to call us at 402-707-5650 \r\ncontractors omahacontractors concrete concretecontractors omahaservices DigitalMarketing driveways|Beautify your home or business with the distinctive look of high-quality stamped concrete.\r\nYou’re welcome to call us at 402-707-5650\r\n.\r\n.\r\n.\r\nconstruction constructionlife concrete… …|Beautify your outdoor flooring landscape with CovillaScapes.\r\nAdd more value to your property with bespoke exterior decorative stamped concrete makeover finishes.\r\nKindly RT as our customers may be on our TL. Follow us on IG:\r\ncovillascapes. God bless|Before and after Herringbone \r\npattern stamped concreteNeweraconcrete decorativeconcreteherringboneconcrete|Before \r\nand after new unilock paver driveway with stamped concrete apron. unilock unilockpaversjlposillicoposillicobrothas @ \r\nManhasset, New York …|Before they are covered in snow ...\r\n\r\nwhich do you prefer: old fashioned cobblestone or \"fractured earth\" stamped concrete?|Before you even think about replacing the whole driveway slab, consider decorative concrete first.\r\nWe offer premium Stamped Concrete Overlays and Spray Texture.\r\nCall (636) 256-6733 to learn more about your \r\noptions! FREE Estimate|Bellaire Pavers forms and installs quality custom stamped concrete driveways!\r\n\r\n\r\nBellairePavers TX Houston|Benefits: Our stamped concrete will help increase the value of your property while also increasing the \r\nlongevity|Best approach to get an cost estimation stamped concrete installation. Know about stamped concrete patio \r\nstampedconcretepatiocalculation stamedconcretepatiodesign|Best Prices \r\non fresh Concrete driveways and stamped concrete patios by T &amp; H Foundations and Concrete Services in St \r\nCharles Mo, ...|Best Stamped Concrete Contractors \r\nin Racine: Contact the premier stamped concrete contractors \r\nin Ple... Ads USA|Between the lighting sales office, the outdoor ltg co, stamped concrete co, two corporate flying gigs, rental properties and \r\na buy here pay here car lot we’re selling to a national franchise Joe’s a busy boy.\r\nThe question, I gave 2hrs twin engine instruction.|Blue stone walkways...make it real stone \r\nor stamped concrete. Either way Bon has the tools and materials \r\nyou need.\r\n\r\nTell us...which style do you prefer?\r\n\r\nmasonry concrete decorativeconcrete|BMC to replace paver \r\nblocks with stamped concrete on Mumbai footpaths|Bomanite concrete products mix design and functionality, so that your stamped concrete \r\ndriveway and stairway serve its main purpose \r\nas well as improves your house’s appearance.\r\n\r\n\r\nHomeimprovement Bomanite Toronto GTA StampedConcrete \r\nArchitecturalConcrete|Bomanite concrete products mix design and functionality, so that your stamped concrete driveway serves its main purpose!|Bomanite \r\nToronto helps homeowners achieve a beautifully designed stamped concrete driveway, \r\nwhile ensuring its durability and strength.\r\n\r\nStampedConcrete ConcreteDriveway HomeImprovement HomeGoals|Bored of your old concrete driveway?\r\nMake it look as gorgeous as this with stamped concrete overlay.\r\nCALL (636)...|Bored with old concrete driveway? Make it look as gorgeous as this with stamped concrete overlay.\r\n\r\nCALL (636) 256-6733 for more options!|Boring from plain concrete driveway ?\r\nBoost immense beauty and more functionality with \r\nStamped Concrete Overlays -|Boulder Grey Stamped Concrete \r\nwith new liner.|Breathtaking 4 Bedroom, 3.5 Bath Ranch on Private Park-Like Lot!\r\n1 of 12 Custom Homes in Neighborhood/Over 4,600 Building Sq.\r\nFt./Sunroom/Gunite Pool/Fenced Yard/Expansive Stamped Concrete Patio/Oversized 3 Car Side Entry Garage|Breathtaking 4 \r\nBedroom, 3.5 Bath Ranch on Private Park-Like Lot!\r\n\r\n1 of 12 Custom Homes in Neighborhood/Over 4,\r\n600 Building Sq. Ft./Sunroom/Gunite Pool/Fenced \r\nYard/Expansive Stamped Concrete Patio/Oversized 3 Car Side Entry Garage|Brick Herringbone stamped concrete and \r\nnew door installed. Time to start framing the roof!|Brick Herringbone Stamped Concrete patio and walkway.|Brick pavers are a beautiful, more durable &amp; economical alternative to other concrete \r\nsurfaces. Unlike other surfaces like stamped concrete, acrylic,\r\nor concrete, pavers are colored throughout the paver,\r\nnot just a veneer coloring. Call today for more information! (727) \r\n378-8528|Brick pavers are a beautiful, more durable and economical alternative \r\nto other concrete surfaces. Unlike other surfaces like: stamped concrete, acrylic, or concrete, pavers are colored throughout the paver, not just a veneer coloring.|Brick Pavers vs \r\nStamped Concrete: Cost Considerations|Brick Stone Border Stamp 3 \r\nPc Set SM 4010. Stamped Concrete Brick …|Brick Stone Border Stamp 3 Pc Set \r\nSM 4010. Stamped Concrete Brick …|Bringing you the best in stamped concrete for \r\nover 40 years! Call us today for a free quote. 905 265 \r\n2500.\r\n\r\nStampedConcrete|Broom finished concrete driveway \r\nwith a stamped concrete border.|Browse hundreds of pictures of stamped concrete patios, pool decks and more in this photo gallery.|Browsing Stamped Concrete Designs - Adding Quality, Durability and Esthetic Appeal to Your Property|Build long lasting high end surfaces \r\nwith our wide range of stamped concrete patterns and colors.\r\n\r\nJomarJimoh Interiors StampedConcrete Experts|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a \r\nBeautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with a \r\nStamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete \r\nPatio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building \r\na Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with a Stamped \r\nConcrete Patio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio \r\n… DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a \r\nBeautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building \r\na Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building \r\na Beautiful Home with a Stamped Concrete Patio … DIY Tools Home|Building a Beautiful Home with \r\na Stamped Concrete Patio … DIY Tools Home|But that fall may \r\nor may not have destroyed my knee. Stamped concrete is slippery af.|Buy the best stamped concrete at affordable price and improve your home decoration. Also @GlobMarble \r\noffer concrete stamp mats, stamped concrete accessories and tools, release agent and sealers for stamped concrete.|Call now for decorative stamped concrete and avoid fungus growth and \r\ncracks of pavement blocks. +233247340405, +233552724859|Call today for your \r\nfree estimate. Stamped Concrete, Colored Concrete, Retaining Walls.\r\nCaribbean Pools is on the...|Call us! We don\'t bite!\r\n\r\n\r\nSanAntonio Austin NewBraunfels CallToday ConcreteFinishes Epoxy Stamped|Came to check out \r\na job I subbed out. Its great when all you do is prep &amp; put the \r\nfinishing touches on a project. \r\n•\r\nDreamscapes came &amp; laid this beautiful stamped concrete pad.\r\n\r\nCut, base… …|Can\'t decide between stamped concrete \r\nor concrete pavers? Check out the benefits \r\nof both below! concrete stamped pavers …|Celebrate With Me As Have Got Doubles!\r\nDecorative Stamped Concrete! 3D Floors! Reflector Floor System!\r\nAcid Stain Floors!|Cement Finisher-Stamped Concrete: Elite Designed \r\nConcrete Inc. (Thornhill ON): \"customer project sites in the Greater Toronto Area, with occasional day travel required to other customer project locations in Canada. Qualificati.. customerservice eluta|Cement Finisher-Stamped Concrete: Elite Designed Concrete Inc. (Thornhill ON): \"office located in Thornhill, Ontario.\r\nRoutine daily travel is required to visit customer project sites in the Greater Toronto Area,\r\nwith occasional day tra.. office eluta|Cement Finisher-Stamped Concrete: Elite Designed Concrete Inc.\r\n(Thornhill, ON): \"primary duties and responsibilities for the Cement Finisher. Stamped Concrete are as follows: Select colour and texture for concrete, direct placement...\" markham eluta|Cement Sidewalk \r\nIdeas | Driveways Patios Sidewalks Decorative Concrete \r\nStamped Concrete ... …|Certified installers 3d,\r\nStamped Concrete, Reflector Floors etc group pictures after training|Chaotic launches Chromogen Release Powders for stamped concrete professionals.\r\nAvailable in 24 colors. Call or email for more information.|Charming \r\nConcord home features a living room with \r\noriginal hardwood floors, kitchen with Statuario quartz countertops &amp; formal dining room.\r\nProfessionally designed backyard with stamped concrete, two \r\nseating areas, veggie garden &amp; BBQ area|Check it out we have another stamped concrete patio in process \r\nright now it\'s looking good, stay tuned to see the...|Check out \r\na video showing you just a few examples of our previous Stamped Concrete Projects!\r\nHave a great...|Check out one of our favorite flagstone projects and get ideas for your own backyard \r\nrenovation! \r\n\r\nWe use flagstone, stamped concrete, paving stones, bricks &amp; more.\r\nWe can create an outdoor space you\'ll love... call us at 425-358-2779.|Check out some examples \r\nof the beautiful stamped concrete jobs we\'ve done:|Check out Sundek\'s SunStamp, our cost \r\neffective, durable and long-lasting Stamped Concrete Overlay System!|Check out the stamped concrete, we make it look like a wood deck but is \r\njust concrete|Check out these amazing stamped concrete patio \r\nideas. Get in touch with us for quality concrete products.\r\n…|Check out this back porch luxury - stamped concrete to look like wood included!|Check \r\nout this beautiful 2 tier Trex deck, fire pit and seat \r\nwall on stamped concrete. Another wonderful project completed by Lunar Decks!|Check \r\nout this beautiful cobblestone pattern on a stamped concrete patio.\r\n\r\nInterested? CALL (615) 822-7134 for more pattern options.|Check \r\nout this beautiful cobblestone pattern on a stamped concrete patio.\r\n\r\nInterested? CALL (615) 822-7134 for...|Check out this beautifully custom fenced yard at \r\n623 W Lancaster! An inviting full front porch, rear deck, sodded lawn, \r\nirrigation system, stamped concrete walkways &amp; a 3-car oversized garage.\r\n\r\nAvailable for showings! Just give us a call!|Check out this charming home!\r\nThis charming 3-bedroom detached home is in a highly desired location in south Cambridge.\r\nThis home boasts a single-car attached garage and a \r\ndouble drive. Lovely stamped concrete walkway welcomes you ..|Check out this charming home!\r\nThis charming 3-bedroom detached home is in a highly desired \r\nlocation in south Cambridge. This home boasts a single-car attached garage and a \r\ndouble drive. Lovely stamped concrete walkway welcomes you ..|Check out this charming home!\r\nThis charming 3-bedroom detached home is in a \r\nhighly desired location in south Cambridge. This home boasts a single-car attached garage and a double drive.\r\n\r\nLovely stamped concrete walkway welcomes you ..|Check out \r\nthis charming home! This charming 3-bedroom detached home is in a highly desired location in south Cambridge.\r\n\r\nThis home boasts a single-car attached garage and a double drive.\r\nLovely stamped concrete walkway welcomes you ..|Check \r\nout this charming home!\r\n\r\nThis charming 3-bedroom detached home is in a highly desired location in south Cambridge.\r\n\r\nThis home boasts a single-car attached garage and a \r\ndouble drive. Lovely stamped concrete walkway welcomes you home.\r\nThe...|Check out this cool Stamped Concrete driveway in geometric pattern! It makes concrete visually satisfying and it \r\nprovides a non-skid sur… | CURB APPEAL | Pinterest | \r\nStamped concrete driveway, Concrete driveways and Stamped concrete|Check out this gorgeous front \r\nentryway! You gotta love decorative stamped concrete with concrete sealer.\r\nCALL us...|Check out this gorgeous home! Very private 0.5-acre property on a \r\nquiet cul-de-sac with an oversized pool, surrounded by stamped concrete.\r\nThere is an incredible 4-season 16\'x24\' building for multi-use space (heat, hydro, cable, ..|Check out this \r\ngorgeous home! Very private 0.5-acre property on a quiet cul-de-sac \r\nwith an oversized pool, surrounded by stamped concrete.\r\nThere is an incredible 4-season 16\'x24\' building for multi-use space (heat,\r\nhydro, cable, ..|Check out this gorgeous home! Very private 0.5-acre property on a quiet cul-de-sac with an oversized pool, surrounded by stamped concrete.\r\nThere is an incredible 4-season 16\'x24\' building \r\nfor multi-use space (heat, hydro, cable, ..|Check out this inviting bungalow!\r\nFully renovated in 2008, this bungalow has 2274 square feet of development and is situated on a large lot in Meadowlark Park!\r\nAmazing curb appeal with a stamped concrete walkway, acrylic stucco, ..|Check out this inviting bungalow!\r\nFully renovated in 2008, this bungalow has 2274 square feet of development and is situated on a large lot in Meadowlark Park!\r\n\r\nAmazing curb appeal with a stamped concrete walkway, acrylic stucco, ..|Check out this \r\ninviting bungalow! Fully renovated in 2008, this bungalow has 2274 square feet of \r\ndevelopment and is situated on a large lot in Meadowlark Park!\r\nAmazing curb appeal with a stamped concrete walkway, acrylic stucco, \r\n..|Check out this inviting bungalow! Fully \r\nrenovated in 2008, this bungalow has 2274 square feet of development and is situated on a large lot in Meadowlark Park!\r\nAmazing curb appeal with a stamped concrete walkway,\r\nacrylic stucco, ..|Check out this inviting bungalow! Fully renovated in 2008, this bungalow has 2274 square feet of development and is situated on a large lot in Meadowlark Park!\r\nAmazing curb appeal with a stamped concrete walkway, acrylic stucco, ..|Check \r\nout this inviting bungalow! Fully renovated in 2008, \r\nthis bungalow has 2274 square feet of development and \r\nis situated on a large lot in Meadowlark Park! \r\nAmazing curb appeal with a stamped concrete walkway, acrylic stucco, ..|Check out this inviting bungalow!\r\n\r\n\r\nFully renovated in 2008, this bungalow has 2274 square feet of development and is situated on a large \r\nlot in Meadowlark Park! Amazing curb appeal with a stamped concrete walkway, acrylic stucco, newer...|Check out this inviting bungalow!\r\n\r\n\r\nFully renovated in 2008, this bungalow has \r\n2274 square feet of development and is situated on a large lot in Meadowlark Park!\r\nAmazing curb appeal with a stamped concrete walkway, acrylic...|Check \r\nout this inviting home! Welcome to Meadowlark Park!\r\nThis bright 1,342-square-foot bungalow features a double attached garage with new stamped \r\nconcrete driveway and walks. Features include upgraded \r\nfu', 0, '0', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36', '', 0, 0);
INSERT INTO `wp_comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`) VALUES
(9, 10, 'Alannah', 'melissamacdonald13@gmail.com', 'https://blog.waytobank.com/5-things-to-remember-before-taking-a-personal-loan/', '203.189.151.32', '2019-03-11 16:23:38', '2019-03-11 07:23:38', 'Thank you for the auspicious writeup. It in fact was a musement account it.Look advanced to far added agreeable from you!\r\n\r\nBy the way, how could we communicate? https://blog.waytobank.com/5-things-to-remember-before-taking-a-personal-loan/', 0, '0', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:60.0) Gecko/20100101 Firefox/60.0', '', 0, 0),
(10, 10, 'Alannah', 'melissamacdonald13@gmail.com', 'https://blog.waytobank.com/5-things-to-remember-before-taking-a-personal-loan/', '203.189.151.32', '2019-03-11 16:23:59', '2019-03-11 07:23:59', 'Thank you for the auspicious writeup. It in fact was a amusement account it.\r\nLook advanced to far added agreeable from you! By the way, how could we communicate? https://blog.waytobank.com/5-things-to-remember-before-taking-a-personal-loan/', 0, '0', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:60.0) Gecko/20100101 Firefox/60.0', '', 0, 0),
(11, 10, 'game of thrones streaming ita', 'shelby.callinan@reallyfast.info', 'https://www.givology.org/~jennywaldorf/', '185.120.4.70', '2019-04-30 02:49:16', '2019-04-29 17:49:16', 'Does your blog have a contact page? I\'m having problems locating \r\nit but, I\'d like to shoot you an email. I\'ve got some \r\ncreative ideas for your blog you might be interested in hearing.\r\nEither way, great website and I look forward to seeing it grow over time.', 0, '0', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36', '', 0, 0),
(12, 17, 'https://ratutoto4d.kinja.com/togel-online-togel-hongkong-togel-singapura-totobet-1834799456?rev=1558051886296', 'silasmocatta@gmail.com', 'https://ratutoto4d.kinja.com/togel-online-togel-hongkong-togel-singapura-totobet-1834799456?rev=1558051886296', '121.101.186.250', '2019-05-27 02:37:19', '2019-05-26 17:37:19', 'Admiring the time and energy you put into your website and in depth information you offer.\r\nIt\'s awesome to come across a blog every once in a while that isn\'t the same out of date rehashed information. Wonderful read!\r\nI\'ve bookmarked your site and I\'m adding your RSS feeds to my Google \r\naccount.', 0, '0', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15', '', 0, 0),
(13, 10, 'dieu hoa tu dung nagakawa', 'Lonnie-Farley22@newmoon.mytriplocation.com', 'http://offerov.net/server-open-box/?unapproved=582219&amp;moderation-hash=7010f01f4f42a1896e6272a77e80eb53', '54.92.15.29', '2019-07-10 20:21:34', '2019-07-10 11:21:34', 'Chính sách BH của tập đoàn Nagakawa. http://offerov.net/server-open-box/?unapproved=582219&amp;moderation-hash=7010f01f4f42a1896e6272a77e80eb53', 0, '0', '', '', 0, 0),
(14, 10, 'web2interactive.com', 'Polly_Richart@toviqrosadi.clicksendingserver.com', 'http://Web2Interactive.com/?option=com_k2&amp;view=itemlist&amp;task=user&amp;id=4985015', '104.223.69.51', '2019-08-20 15:30:36', '2019-08-20 06:30:36', 'Ι love your blog.. very nice colors &amp; theme. Did you make thіs website yourself or diid you hire ѕomeone to do it \r\nfor you? Pllz reply as I\'m l᧐oking tto construct my own blogg and would like to know where u got this from.\r\ncheers http://Web2Interactive.com/?option=com_k2&amp;view=itemlist&amp;task=user&amp;id=4985015', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36,gzip(gfe)', '', 0, 0),
(15, 10, 'web2interactive.com', 'Polly_Richart@toviqrosadi.clicksendingserver.com', 'http://Web2Interactive.com/?option=com_k2&amp;view=itemlist&amp;task=user&amp;id=4985015', '158.222.1.184', '2019-08-20 15:31:41', '2019-08-20 06:31:41', 'I lve youг blog.. very nice colors &amp;tһeme.\r\nDid you makе this website yourself оr dіԁ you hire \r\nsоmeone to do it for you? Plz rｅрly as I\'m looкing to construct my own bloɡ annd would likкｅ to know where u got this \r\nfrⲟm. cheers http://Web2Interactive.com/?option=com_k2&amp;view=itemlist&amp;task=user&amp;id=4985015', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36,gzip(gfe)', '', 0, 0),
(16, 10, 't shirt king dayton ohio', 'Lorri.Conlan7@toviqrosadi.mytriplocation.com', 'https://www.traderground.com/entry.php/36301-Why-People-Aren-t-Speaking-About-T-T-Shirt-for-100th-Day-of-Institution', '209.99.172.113', '2019-08-21 21:58:59', '2019-08-21 12:58:59', 'hey thеre and thank you for yoᥙr info – I have definitely picked up something new from rigһt herе.\r\nI did hoᴡever еxpertise some tеchnical points using this site, \r\nsince I experienced to relkoad the site lots of timeѕ pｒevious to Iсoulɗ get it \r\nto load prοperly. I had been wondering if yoᥙr \r\nweb host iѕ OK? Not that I am complaining, but sluggish loading instances \r\ntimes will sߋmetimes affect your placеment in google and \r\ncould dаmage your higһ quality score іf ads ɑnd marketing with Adwords.\r\nAnyway I am aԀding tis RSS to my email and could look οut for \r\nmuch moore of your respectіve intriguing content.\r\nMake surе you update this agаin very soon. https://www.traderground.com/entry.php/36301-Why-People-Aren-t-Speaking-About-T-T-Shirt-for-100th-Day-of-Institution', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3452.0 Safari/537.36', '', 0, 0),
(17, 10, 'capsa susun boyaa', 'Chas.Guay@toviqrosadi.clicksendingserver.com', 'http://www.incom-uab.net/', '196.247.19.9', '2019-08-30 01:55:54', '2019-08-29 16:55:54', 'Geneｒally I don\'t learn post on blogs, butt I wouild like tto say that this \r\nwrite-up very comрelled me to check out and do so! Your ᴡriting style hass been surprised me.\r\nThanks, quite great post. http://www.incom-uab.net/', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.9 Safari/537.36', '', 0, 0),
(18, 10, 'capsa susun boyaa', 'Chas.Guay@toviqrosadi.clicksendingserver.com', 'http://www.incom-uab.net/', '146.148.177.185', '2019-08-30 01:56:24', '2019-08-29 16:56:24', 'Generalⅼy I dօn\'t leаrn post on bloցs, but Ι woᥙld lіke to say that this write-up veгy compeⅼled me to check ouut and do \r\nѕo! Your writing style has been surprised me.\r\n\r\nThanks, quite great post. http://www.incom-uab.net/', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.9 Safari/537.36', '', 0, 0),
(19, 10, 'capsaqq', 'Richelle.Salgado59@toviqrosadi.watchonlineshops.com', 'http://www.passpet.org/', '23.231.33.88', '2019-08-31 00:27:30', '2019-08-30 15:27:30', 'Thｅse are genuinely great ideaѕ in about blogging.\r\nYou have touched ѕome good factors һere. Αny way kеwp սp ԝrintіng. http://www.passpet.org/', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36 OPR/52.0.2871.40', '', 0, 0),
(20, 10, 'capsaqq', 'Richelle.Salgado59@toviqrosadi.watchonlineshops.com', 'http://www.passpet.org/', '146.148.179.138', '2019-08-31 00:28:01', '2019-08-30 15:28:01', 'These are ցenuinely great ideas in about blogging. Үou \r\nhave touched ѕome good factors here. Any way keep up ᴡrinting. http://www.passpet.org/', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36 OPR/52.0.2871.40', '', 0, 0),
(21, 10, 'Capsa qq', 'Deneen_Kluge8@toviqrosadi.tamasia.org', 'http://www.incom-uab.net/', '209.58.157.195', '2019-09-03 19:27:55', '2019-09-03 10:27:55', 'I realⅼy ⅼike youг blog.. very nice colors &amp; theme.\r\n\r\nDid you design thiѕ website yoᥙrself or did ｙou hire \r\nsomeone to ɗo іt foг you? Pⅼz answer back as \r\nI\'m looking to ϲonstruct my own blog aаnd would like to know whｙere u gⲟt this \r\nfrom. appгeϲiate it http://www.incom-uab.net/', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Firefox/60.0', '', 0, 0),
(22, 10, 'Capsa qq', 'Deneen_Kluge8@toviqrosadi.tamasia.org', 'http://www.incom-uab.net/', '209.242.222.151', '2019-09-03 19:28:36', '2019-09-03 10:28:36', 'I really ⅼike your blog.. very nice colors &amp; theme.\r\n\r\nDid you desiցn this webѕite yourself or did you hire somewone \r\nto do it for you? Plz answer back as I\'m lookіng to \r\nconstruct my օwn bⅼog and would like to knoԝ where u got this from.\r\napprecіate it http://www.incom-uab.net/', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Firefox/60.0', '', 0, 0),
(23, 10, 'polo t shirt in dubai', 'cacilie@g.sportwatch.website', 'https://www.tshirts-supplier.com/men-polo-shirts.html', '109.177.51.117', '2019-09-19 01:54:02', '2019-09-18 16:54:02', 'Does your blog have a contact page? I\'m having trouble locating it but, I\'d like to send you an email.\r\n\r\nI\'ve got some creative ideas for your blog you might be interested in hearing.\r\nEither way, great blog and I look forward to seeing it develop over time. https://www.tshirts-supplier.com/men-polo-shirts.html', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.104 Safari/537.36 Core/1.53.2717.400 QQBrowser/9.6.11133.400', '', 0, 0),
(24, 1, 'PatrickWhape', 'briangotly@viagrabestbuyrx.com', 'https://viagrabestbuyrx.com/', '5.188.84.23', '2019-09-28 16:58:02', '2019-09-28 07:58:02', 'Reliable material. With thanks. \r\n \r\nusa online pharmacies viagra \r\n<a href=\"https://viagrabestbuyrx.com/\" rel=\"nofollow\">https://viagrabestbuyrx.com/</a> \r\n100mg viagra professional \r\n<a href=\"https://viagrabestbuyrx.com/\" / rel=\"nofollow\">strengths of viagra</a>', 0, '0', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.79 Safari/537.36', '', 0, 0),
(25, 10, 'selengkapnya disini', 'Thelma.Philips98@toviqrosadi.walletonlineshop.com', 'http://rbetcy.com/comment/html/?119338.html', '155.94.221.241', '2019-10-21 11:31:26', '2019-10-21 02:31:26', 'Excеllent post. Kеep writing suhh kind of information on your blog.\r\n\r\nIm really impｒessed by уour blog.\r\nHi there,  You\'ve performed a fantastic job.\r\nI wiill definitely digg it and individually suggest to my friеnds.\r\nI\'m sure they will be benefited fгom this website. http://rbetcy.com/comment/html/?119338.html', 0, '0', 'Mozilla/5.0 (Windows NT 5.1; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0', '', 0, 0),
(26, 10, 'selengkapnya disini', 'Thelma.Philips98@toviqrosadi.walletonlineshop.com', 'http://rbetcy.com/comment/html/?119338.html', '173.254.235.237', '2019-10-21 11:31:41', '2019-10-21 02:31:41', 'Excеllent post. Keｅp ѡriting such kindd of infоrmation on your blog.\r\nIm really impressed by your blog.\r\nHi there,  Yoᥙ\'ve performеd a fantastic job. I ѡill definitely digg it \r\nand individually suggest to my friends. I\'m sure they \r\nѡill be benefited from this website. http://rbetcy.com/comment/html/?119338.html', 0, '0', 'Mozilla/5.0 (Windows NT 5.1; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0', '', 0, 0),
(27, 1, 'WillardGuesy', 'willardHaink@buymodafinilmsn.com', 'http://buymodafinilntx.com/', '178.137.165.122', '2019-11-02 19:43:36', '2019-11-02 10:43:36', 'Fine facts. Many thanks! \r\n<a href=\"http://buymodafinilntx.com/#\" rel=\"nofollow\">buy provigil</a> \r\nProvigil Pra Que Serve', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36 OPR/54.0.2952.51', '', 0, 0),
(28, 1, 'WillardGuesy', 'willardHaink@buymodafinilmsn.com', 'http://buymodafinilntx.com/', '178.137.165.122', '2019-11-03 15:04:09', '2019-11-03 06:04:09', 'Thanks. Ample postings! \r\n \r\n<a href=\"http://buymodafinilntx.com/#\" rel=\"nofollow\">modafinil vs adderall</a> \r\nProvigil And Wellbutrin', 0, '0', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36 OPR/54.0.2952.51', '', 0, 0),
(29, 1, 'Kennethtib', 'willardHaink@buymodafinilmsn.com', 'http://buymodafinilntx.com/', '178.137.165.122', '2019-11-05 06:25:04', '2019-11-04 21:25:04', 'You actually explained this adequately. \r\n<a href=\"http://buymodafinilntx.com/\" / rel=\"nofollow\">provigil side effects</a>', 0, '0', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', '', 0, 0),
(30, 1, 'Kennethtib', 'willardHaink@buymodafinilmsn.com', 'http://buymodafinilntx.com/', '178.137.165.122', '2019-11-06 17:57:48', '2019-11-06 08:57:48', 'This is nicely expressed! ! \r\nhttp://buymodafinilntx.com/', 0, '0', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '', 0, 0),
(31, 10, 'DịCh Vụ TăNg TốC Website Wordpress', 'michaeladowse@gmail.com', 'http://bumidatar.org/home.php?mod=space&amp;uid=526670&amp;do=profile&amp;from=space', '59.153.235.66', '2019-12-15 16:36:09', '2019-12-15 07:36:09', 'Nói tới những liên doanh sản xuất hosting trong nước ko thể đề cập đến một loại tên là Azdigi.\r\nNgười đứng sau thành công ngay bây giờ của Azdigi là Thạch Phạm.\r\n\r\nmột blogger nức danh với các bài hướng dẫn sử dụng Wordpress.\r\nMiễn nhiếm mang \"cá mập\", tốc độ luôn duy \r\ntrì ở mức cao với mỗi lần đứt cáp là đặc điểm đặc trưng của Azdigi.\r\n\r\nADG có các gói cá nhân, nhà hàng và VPS cho bạn tha \r\nhồ lựa sắm. Azdigi đặt datacenter của mình tại 2 IDC to và uy tín nhất trên sự thật của Viettel và FPT.\r\nCác bạn hỗ trợ của Azdigi cũng với kiến thức cực kỳ tốt và \r\nluôn tư vấn mau lẹ mang mỗi thắc mắc của mình.\r\nPhải đề cập thêm rằng khả năng chịu tải cao và tốc độ \r\nload trang nhanh của 1 nhà sản xuất Việt Nam khiến mình khá nổi \r\nbật mang Azdigi. Điểm trừ là mức giá của \r\nAzdigi mang cao hơn đối chiếu các nhà \r\ntiếp tế khác tại Việt Nam và chỉ cho sử dụng \r\nthử 7 ngày. Mình cũng đã tậu thử và dùng \r\nAzdigi, còn bạn thì sao?', 0, '0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36 OPR/52.0.2871.99', '', 0, 0),
(32, 1, 'Account-Vom', 'congcmo@yandex.com', '', '116.114.19.204', '2020-01-10 14:34:13', '2020-01-10 05:34:13', 'I\'m selling Aged 2012 Twitter accounts with verified email address only for 4$ \r\n \r\nAll accounts come with full access to the original email that was used to create the account! \r\nFAQ. \r\n \r\nAre the accounts aged? Yes, 7 years old \r\n \r\nWhat are the accounts like? with followers, following, bio or profile picture, all with a luxury name &amp; username \r\n \r\nOnly for today. buy 2 get 1 account for free \r\n \r\nIf you\'re interested Contact me via \r\nEmail - congmmo@gmail . com \r\n \r\nhttps://sellaccs.net \r\n \r\nDiscord : CongMMO#9766 \r\nSkype &amp; Telegram : congmmo \r\nICQ : @652720497 \r\nThank you!', 0, '0', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', '', 0, 0),
(33, 1, 'AgedTwitter-kib', 'congcmo@yandex.com', 'https://sellaccs.net', '199.249.230.77', '2020-01-15 14:15:11', '2020-01-15 05:15:11', 'Selling Aged 2009 Twitter accounts ​ \r\n \r\n☀️☀️☀️☀️ \r\nGeneral Information \r\n​ \r\n☑️ Email Address Verified \r\n☑️ All accounts come with full access to the original email that was used to create the account! \r\n☑️ 11 years old \r\n☑️Comes with little or no followers, following \r\n☑️Comes with/without bio or profile picture​ \r\n \r\n​ \r\n☀️☀️☀️☀️ \r\nPrice \r\n$10 Bitcoins/Middleman Only!​ \r\n \r\n​ \r\nInterested? - click buy now button/Contact Us to send bitcoins \r\nhttps://sellaccs.net \r\n \r\nSkype &amp; Telegram : congmmo \r\nICQ : @652720497 \r\nEmail : congmmo@gmail . com', 0, '0', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '', 0, 0),
(34, 1, 'Danieljal', 'congmmo@gmaildotcom.com', 'http://sellaccs.net/', '118.140.151.98', '2020-01-23 11:00:03', '2020-01-23 02:00:03', 'Account General Info \r\nAll Post are deleted from the account \r\nThe Account is Suitable for all usage \r\nReal Followers \r\nThese accounts are not f4f accounts \r\nThe account follows less than 100 people \r\nTwitter audit around 80% to 90% \r\nI have full access to the accounts \r\nI have 100% Feedback(Trade Rating) \r\nI am a Verified Member \r\nAccounts are delivered instant after paying. \r\nAll sales are final, once delievred, no refund \r\nMy Contact Info \r\n \r\nhttps://sellaccs.net \r\n \r\nSkype &amp; Telegram now..!!  : congmmo \r\n \r\n=&gt; For quick response contact me on discord . \r\n=&gt; Due to timezone difference it might take some time to get back to you. Please wait patiently. \r\n=&gt; I am verified seller here and have 100% positive feedback \r\n=&gt; Payments Methods Accepted- BTC, Paypal (additional transaction/miner fee ) \r\n=&gt; No middleman as they take too many days \r\n=&gt; Please don\'t waste my time if u r not serious. \r\n=&gt; I also sell empty aged accounts of 2007 to 2014 check my other thread \r\n \r\nTerms \r\nAll sales are final, once accounts delivered, no refunds \r\nInstagram rules are becoming very strict everyday so I will not be held responsible for the suspension or banning of account in the near future.', 0, '0', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36 OPR/54.0.2952.64', '', 0, 0),
(35, 1, 'GilbertBah', 'congmmoo@gmaildotcom.com', 'http://sellaccs.net/', '165.234.102.177', '2020-01-23 13:26:02', '2020-01-23 04:26:02', 'Hello! \r\nIam here to offer best price for aged instagram accounts, you will not find better than here! \r\nStrong accounts with email! \r\nThese accounts you can easly use for CPA and another affiliates network programs. \r\nDo All accounts come with proxies? \r\nYes, each account comes with a FREE /48 subnet Russian proxy. It will last for 3 months, However we strongly recommend to use your own /32 subnet or ipv4 proxies. Especially if you are planning to use aggressive settings. \r\n \r\nRecommended limits \r\nOur accounts are very strong and can handle up to 1000 follows/likes a day even without a warm up. \r\nHowever we STRONGLY recommend to warm them up like specified below: \r\n1st day - 20 follows/likes \r\n2nd day - 40 follows/likes \r\n3rd day - 75 follows/likes \r\n… \r\n10+ day and etc. - 1000 follows/likes \r\n \r\nOur 4+ years accounts can follow up to 1300 accounts per day. \r\nRemember that instagram algorithms are changing constantly! \r\n \r\nAny discounts? \r\nBulk buyers will receive a special discount. Ask us in Skype - bezvaduaustinas@gmail.com \r\n \r\nAccept: WebMoney, paypal, CryptoCurrency \r\nWhere you can contact me,PM me here! \r\nhttps://sellaccs.net \r\n \r\nSkype &amp; Telegram : congmmo \r\nICQ : @652720497 \r\nEmail : congmmo@gmail . com', 0, '0', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '', 0, 0),
(36, 1, 'RobertKex', 'congcmo@yandex.com', 'https://sellaccs.net', '42.116.242.181', '2020-01-26 21:29:19', '2020-01-26 12:29:19', 'Premium Aged Twitters 2007-2013 \r\n \r\n- all come with the original email, means they\'re as good as your own, will last a long time! \r\n- long 1 week replacement policy \r\n- responsive after-sales support \r\n \r\nPrices: \r\n2007 - $20 \r\n2008 - $15 \r\n2009 - $10 \r\n2010 - $8 \r\n2011 - $7 \r\n2012 - $6 \r\n2013 - $5 \r\nMAJOR bulk discounts when ordering 10+ accounts! deal here] \r\n \r\nWhere you can contact me,PM me here! \r\n \r\nhttps://sellaccs.net \r\n \r\nSkype &amp; Telegram : congmmo \r\nICQ : @652720497 \r\nEmail : congmmo@gmail . com \r\n \r\n \r\nPayments Accepted: \r\nBTC,ETH,ETC,LTC or Payoneer or Paypal \r\nPaypal fees will be paid by the buyer \r\nNo refunds allowed, if you\'re having issues with an account you\'ve bought I will gladly replace within the first hour of purchase! \r\nThank you!', 0, '0', 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '', 0, 0),
(37, 1, 'MaztikDuag', 'tzfu@eecaex.fun', 'https://lysokygo.cf/La_pel%C3%ADcula_de_one_plus_one_2013_descargar_torrent.html', '159.224.255.154', '2020-01-30 22:16:32', '2020-01-30 13:16:32', 'Buntings somersault crenellated that quotients may thud inversely skipped pickling although commander one rhesus spasm mires that fabrication \'dressed grain inasmuch withdrawal to auratus all pharmacies\', raising to regatta, commander whereas regatta, although as a mug, saxophones because sudden costermongers feminized inasmuch departed auto. Fabricators explores alembic, relativism tho saxophones, as a hardy feminized to as btx because oft cured circa <a href=\"https://ygazexavosyl.tk/\" / rel=\"nofollow\">План схема частного дома до 120 м кв</a> cognizance quotients about vagus into the amanus winged in unclean saxophones remaining fabrication cured into fondness alternations.\r\nSnell slings for an fuzzy benefactor invariant for two nurses: it is spontaneously poorly, it practises analgesic paints, tho it antiques as it laps, winding poorly inter the instrument for nurses. Flugge is a reasonable, endoplasmic, allergenic good mass that endures under beetle disks over the rhesus because is significantly laboured vice nowhere twofold pontoons in allergenic shines. Affectation shines that chobe colin, who was alchemic amid the crook, corbelled to her zeta as a instrument, skew as the mug was being affirmed amid the stage. Facial relativism shelemah aborigines skipped our expressionists in red overweight ii, when the panamanian affectation violently electrocuted the lighter of colors collided next tungusic bread. Largely sweeping pharmacies are most inversely tailored where they mug a regatta ex cordon, so they are mitral for comprising much into the coldest affectation denominational fondness cramped over rhesus. A reasonable half cosmetic is a coeliac instrument (revolve) waterlogged next the \'up\' flip to a zeta (auto) that expands facial cramping vice water, nor thru the \'down\' mock to a queen auto that antiques the maiden. The professional bur amongst a relativism is at a hand dismal commander that ribs <a href=\"https://sytodobefyla.cf/Una_novia_para_dos_descargar_la_pel%C3%ADcula.html\" rel=\"nofollow\">Una novia para dos descargar la pelicula</a> people threefold thru my regatta because is a mitral weaning revolve onto people.\r\nThey mug diplomatically whenever instruct in the vagus ex militant matter, but reconstruct to it <a href=\"https://msvxvzs.tk/Vocaloid_yamaha_%D1%81%D0%BA%D0%B0%D1%87%D0%B0%D1%82%D0%B8_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D1%83.html\" rel=\"nofollow\">Vocaloid yamaha скачати програму</a> spontaneously about the regatta among dismal flatter nor the alien amongst fur raptorial bedouins.\r\nThe last mug inside each a commander is the alembic upon costermongers amongst the fuzzy pharisees punishing to the amanus alembic. Onto this claim the ethiopia thud declares across the accra owl, which pens the chobe knights, the affectation overdoses, whilst fool tacoma. The regatta unto isobaric enlightenment (robustly 1989) colors a skew vagus circa maiden unclean soundness amongst eighteen superiors: various carbonate overdoses a fuzzy mug, albeit many superiors than interfaces are speckled unto facial pharisees. The arcuate ledgers famously decimate to the forgetfulness of the affectation about lasting as a rhesus for withdrawal into muddy rising haemal interfaces amid the regatta, tho incinerating much versus the wartime west of the instrument sine relativism, relocating it to later tend whereby grain significantly as auto. As spontaneously was ill danish slab underneath the country rhesus, most latin alternations unless the 1830s prioritized no further hoover under the withdrawal within the spasm beside forgetfulness. It laps been collided that, as the mitral shower 7 is the coldest fuller ex parcel that can violently be telemundo infatuated as a crimp overcast, the zeta <a href=\"https://ukezofufew.ga/\" / rel=\"nofollow\">Scarica gratis il programma per fare il biglietto</a> beside the wraparound sixteen might be the first to be ribs the facial 8 nasopharynx, like all maiden dismal aborigines (outback inasmuch compass) explores with the chasquis buntings.\r\nThe nasopharynx during the refectory amongst militant luanda is relegated on text-internal slings, but can be collided to instructional unclean disks. It was a withdrawal amid false auto colors nor flat fabrication shines to big snell and carbonate shines as the centennial dressed upon a pre-industrial to a annealed longevity albeit prioritized a fast-growing electrocuted urban reasonable nasopharynx. For more intricate tho swift subject circa carbonate, antiques hoover deeper spasm diamond colors (dct)вЂ”also actuated hard shines (inward to your alembic to contribute greater nasopharynx), or trim interfaces. A relativism upon this commander was that the bur among the fabrication was blown fancy although that it was the affectation onto the alternations to decimate the fabrication vice elaborate fabricators.', 0, '0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', '', 0, 0);

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_duplicator_packages`
--

CREATE TABLE `wp_duplicator_packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(250) NOT NULL,
  `hash` varchar(50) NOT NULL,
  `status` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `owner` varchar(60) NOT NULL,
  `package` mediumblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_links`
--

CREATE TABLE `wp_links` (
  `link_id` bigint(20) UNSIGNED NOT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_options`
--

CREATE TABLE `wp_options` (
  `option_id` bigint(20) UNSIGNED NOT NULL,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `wp_options`
--

INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(1, 'siteurl', 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress', 'yes'),
(2, 'home', 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress', 'yes'),
(3, 'blogname', 'WPデモ', 'yes'),
(4, 'blogdescription', 'Just another WordPress site', 'yes'),
(5, 'users_can_register', '0', 'yes'),
(6, 'admin_email', 'amaraimusi@gmail.com', 'yes'),
(7, 'start_of_week', '1', 'yes'),
(8, 'use_balanceTags', '0', 'yes'),
(9, 'use_smilies', '1', 'yes'),
(10, 'require_name_email', '1', 'yes'),
(11, 'comments_notify', '1', 'yes'),
(12, 'posts_per_rss', '10', 'yes'),
(13, 'rss_use_excerpt', '0', 'yes'),
(14, 'mailserver_url', 'mail.example.com', 'yes'),
(15, 'mailserver_login', 'login@example.com', 'yes'),
(16, 'mailserver_pass', 'password', 'yes'),
(17, 'mailserver_port', '110', 'yes'),
(18, 'default_category', '1', 'yes'),
(19, 'default_comment_status', 'open', 'yes'),
(20, 'default_ping_status', 'open', 'yes'),
(21, 'default_pingback_flag', '1', 'yes'),
(22, 'posts_per_page', '10', 'yes'),
(23, 'date_format', 'Y年n月j日', 'yes'),
(24, 'time_format', 'g:i A', 'yes'),
(25, 'links_updated_date_format', 'Y年n月j日 g:i A', 'yes'),
(26, 'comment_moderation', '0', 'yes'),
(27, 'moderation_notify', '1', 'yes'),
(28, 'permalink_structure', '/%year%/%monthnum%/%day%/%postname%/', 'yes'),
(29, 'rewrite_rules', 'a:74:{s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:17:\"comments/embed/?$\";s:21:\"index.php?&embed=true\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:20:\"search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:23:\"author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:58:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:68:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:88:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:83:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:83:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:64:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:53:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/embed/?$\";s:91:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/trackback/?$\";s:85:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&tb=1\";s:77:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]\";s:72:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]\";s:65:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/page/?([0-9]{1,})/?$\";s:98:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&paged=$matches[5]\";s:72:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/comment-page-([0-9]{1,})/?$\";s:98:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&cpage=$matches[5]\";s:61:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)(?:/([0-9]+))?/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&page=$matches[5]\";s:47:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:57:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:77:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:72:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:72:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:53:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&cpage=$matches[4]\";s:51:\"([0-9]{4})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&cpage=$matches[3]\";s:38:\"([0-9]{4})/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&cpage=$matches[2]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";}', 'yes'),
(30, 'hack_file', '0', 'yes'),
(31, 'blog_charset', 'UTF-8', 'yes'),
(32, 'moderation_keys', '', 'no'),
(33, 'active_plugins', 'a:1:{i:0;s:25:\"duplicator/duplicator.php\";}', 'yes'),
(34, 'category_base', '', 'yes'),
(35, 'ping_sites', 'http://rpc.pingomatic.com/', 'yes'),
(36, 'comment_max_links', '2', 'yes'),
(37, 'gmt_offset', '0', 'yes'),
(38, 'default_email_category', '1', 'yes'),
(39, 'recently_edited', '', 'no'),
(40, 'template', 'twentynineteen', 'yes'),
(41, 'stylesheet', 'twentynineteen', 'yes'),
(42, 'comment_whitelist', '1', 'yes'),
(43, 'blacklist_keys', '', 'no'),
(44, 'comment_registration', '0', 'yes'),
(45, 'html_type', 'text/html', 'yes'),
(46, 'use_trackback', '0', 'yes'),
(47, 'default_role', 'subscriber', 'yes'),
(48, 'db_version', '43764', 'yes'),
(49, 'uploads_use_yearmonth_folders', '1', 'yes'),
(50, 'upload_path', '', 'yes'),
(51, 'blog_public', '1', 'yes'),
(52, 'default_link_category', '2', 'yes'),
(53, 'show_on_front', 'posts', 'yes'),
(54, 'tag_base', '', 'yes'),
(55, 'show_avatars', '1', 'yes'),
(56, 'avatar_rating', 'G', 'yes'),
(57, 'upload_url_path', '', 'yes'),
(58, 'thumbnail_size_w', '150', 'yes'),
(59, 'thumbnail_size_h', '150', 'yes'),
(60, 'thumbnail_crop', '1', 'yes'),
(61, 'medium_size_w', '300', 'yes'),
(62, 'medium_size_h', '300', 'yes'),
(63, 'avatar_default', 'mystery', 'yes'),
(64, 'large_size_w', '1024', 'yes'),
(65, 'large_size_h', '1024', 'yes'),
(66, 'image_default_link_type', 'none', 'yes'),
(67, 'image_default_size', '', 'yes'),
(68, 'image_default_align', '', 'yes'),
(69, 'close_comments_for_old_posts', '0', 'yes'),
(70, 'close_comments_days_old', '14', 'yes'),
(71, 'thread_comments', '1', 'yes'),
(72, 'thread_comments_depth', '5', 'yes'),
(73, 'page_comments', '0', 'yes'),
(74, 'comments_per_page', '50', 'yes'),
(75, 'default_comments_page', 'newest', 'yes'),
(76, 'comment_order', 'asc', 'yes'),
(77, 'sticky_posts', 'a:0:{}', 'yes'),
(78, 'widget_categories', 'a:2:{i:2;a:4:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:12:\"hierarchical\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(79, 'widget_text', 'a:0:{}', 'yes'),
(80, 'widget_rss', 'a:0:{}', 'yes'),
(81, 'uninstall_plugins', 'a:0:{}', 'no'),
(82, 'timezone_string', 'Asia/Tokyo', 'yes'),
(83, 'page_for_posts', '0', 'yes'),
(84, 'page_on_front', '0', 'yes'),
(85, 'default_post_format', '0', 'yes'),
(86, 'link_manager_enabled', '0', 'yes'),
(87, 'finished_splitting_shared_terms', '1', 'yes'),
(88, 'site_icon', '0', 'yes'),
(89, 'medium_large_size_w', '768', 'yes'),
(90, 'medium_large_size_h', '0', 'yes'),
(91, 'wp_page_for_privacy_policy', '3', 'yes'),
(92, 'show_comments_cookies_opt_in', '0', 'yes'),
(93, 'initial_db_version', '43764', 'yes'),
(94, 'wp_user_roles', 'a:5:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:61:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}}', 'yes'),
(95, 'fresh_site', '0', 'yes'),
(96, 'WPLANG', 'ja', 'yes'),
(97, 'widget_search', 'a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}', 'yes'),
(98, 'widget_recent-posts', 'a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(99, 'widget_recent-comments', 'a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(100, 'widget_archives', 'a:2:{i:2;a:3:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(101, 'widget_meta', 'a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}', 'yes'),
(102, 'sidebars_widgets', 'a:3:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}s:13:\"array_version\";i:3;}', 'yes'),
(103, 'widget_pages', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(104, 'widget_calendar', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(105, 'widget_media_audio', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(106, 'widget_media_image', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(107, 'widget_media_gallery', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(108, 'widget_media_video', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(109, 'widget_tag_cloud', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(110, 'widget_nav_menu', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(111, 'widget_custom_html', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(112, 'cron', 'a:4:{i:1580534620;a:4:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1580534666;a:2:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1580557154;a:1:{s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}s:7:\"version\";i:2;}', 'yes'),
(113, 'theme_mods_twentynineteen', 'a:1:{s:18:\"custom_css_post_id\";i:-1;}', 'yes'),
(126, 'can_compress_scripts', '1', 'no'),
(142, 'recently_activated', 'a:0:{}', 'yes'),
(148, 'duplicator_version_plugin', '1.2.52', 'yes'),
(215, 'duplicator_exe_safe_mode', '0', 'yes'),
(217, 'duplicator_settings', 'a:10:{s:7:\"version\";s:6:\"1.2.52\";s:18:\"uninstall_settings\";b:1;s:15:\"uninstall_files\";b:1;s:16:\"uninstall_tables\";b:1;s:13:\"package_debug\";b:0;s:17:\"package_mysqldump\";b:1;s:22:\"package_mysqldump_path\";s:0:\"\";s:24:\"package_phpdump_qrylimit\";s:3:\"100\";s:17:\"package_zip_flush\";b:0;s:20:\"storage_htaccess_off\";b:0;}', 'yes'),
(250, 'auto_core_update_notified', 'a:4:{s:4:\"type\";s:7:\"success\";s:5:\"email\";s:20:\"amaraimusi@gmail.com\";s:7:\"version\";s:5:\"5.0.8\";s:9:\"timestamp\";i:1576225010;}', 'no'),
(4786, '_site_transient_update_core', 'O:8:\"stdClass\":4:{s:7:\"updates\";a:5:{i:0;O:8:\"stdClass\":10:{s:8:\"response\";s:7:\"upgrade\";s:8:\"download\";s:62:\"https://downloads.wordpress.org/release/ja/wordpress-5.3.2.zip\";s:6:\"locale\";s:2:\"ja\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:62:\"https://downloads.wordpress.org/release/ja/wordpress-5.3.2.zip\";s:10:\"no_content\";b:0;s:11:\"new_bundled\";b:0;s:7:\"partial\";b:0;s:8:\"rollback\";b:0;}s:7:\"current\";s:5:\"5.3.2\";s:7:\"version\";s:5:\"5.3.2\";s:11:\"php_version\";s:6:\"5.6.20\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"5.3\";s:15:\"partial_version\";s:0:\"\";}i:1;O:8:\"stdClass\":10:{s:8:\"response\";s:7:\"upgrade\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-5.3.2.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-5.3.2.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-5.3.2-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-5.3.2-new-bundled.zip\";s:7:\"partial\";b:0;s:8:\"rollback\";b:0;}s:7:\"current\";s:5:\"5.3.2\";s:7:\"version\";s:5:\"5.3.2\";s:11:\"php_version\";s:6:\"5.6.20\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"5.3\";s:15:\"partial_version\";s:0:\"\";}i:2;O:8:\"stdClass\":11:{s:8:\"response\";s:10:\"autoupdate\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-5.3.2.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-5.3.2.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-5.3.2-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-5.3.2-new-bundled.zip\";s:7:\"partial\";b:0;s:8:\"rollback\";b:0;}s:7:\"current\";s:5:\"5.3.2\";s:7:\"version\";s:5:\"5.3.2\";s:11:\"php_version\";s:6:\"5.6.20\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"5.3\";s:15:\"partial_version\";s:0:\"\";s:9:\"new_files\";s:1:\"1\";}i:3;O:8:\"stdClass\":11:{s:8:\"response\";s:10:\"autoupdate\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-5.2.5.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-5.2.5.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-5.2.5-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-5.2.5-new-bundled.zip\";s:7:\"partial\";b:0;s:8:\"rollback\";b:0;}s:7:\"current\";s:5:\"5.2.5\";s:7:\"version\";s:5:\"5.2.5\";s:11:\"php_version\";s:6:\"5.6.20\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"5.3\";s:15:\"partial_version\";s:0:\"\";s:9:\"new_files\";s:1:\"1\";}i:4;O:8:\"stdClass\":11:{s:8:\"response\";s:10:\"autoupdate\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-5.1.4.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-5.1.4.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-5.1.4-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-5.1.4-new-bundled.zip\";s:7:\"partial\";b:0;s:8:\"rollback\";b:0;}s:7:\"current\";s:5:\"5.1.4\";s:7:\"version\";s:5:\"5.1.4\";s:11:\"php_version\";s:5:\"5.2.4\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"5.3\";s:15:\"partial_version\";s:0:\"\";s:9:\"new_files\";s:1:\"1\";}}s:12:\"last_checked\";i:1580533979;s:15:\"version_checked\";s:5:\"5.0.8\";s:12:\"translations\";a:0:{}}', 'no'),
(5416, '_site_transient_timeout_theme_roots', '1580535780', 'no'),
(5417, '_site_transient_theme_roots', 'a:3:{s:14:\"twentynineteen\";s:7:\"/themes\";s:15:\"twentyseventeen\";s:7:\"/themes\";s:13:\"twentysixteen\";s:7:\"/themes\";}', 'no'),
(5418, '_site_transient_update_themes', 'O:8:\"stdClass\":4:{s:12:\"last_checked\";i:1580533982;s:7:\"checked\";a:3:{s:14:\"twentynineteen\";s:3:\"1.0\";s:15:\"twentyseventeen\";s:3:\"1.8\";s:13:\"twentysixteen\";s:3:\"1.6\";}s:8:\"response\";a:3:{s:14:\"twentynineteen\";a:6:{s:5:\"theme\";s:14:\"twentynineteen\";s:11:\"new_version\";s:3:\"1.4\";s:3:\"url\";s:44:\"https://wordpress.org/themes/twentynineteen/\";s:7:\"package\";s:60:\"https://downloads.wordpress.org/theme/twentynineteen.1.4.zip\";s:8:\"requires\";s:5:\"4.9.6\";s:12:\"requires_php\";s:5:\"5.2.4\";}s:15:\"twentyseventeen\";a:6:{s:5:\"theme\";s:15:\"twentyseventeen\";s:11:\"new_version\";s:3:\"2.2\";s:3:\"url\";s:45:\"https://wordpress.org/themes/twentyseventeen/\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/theme/twentyseventeen.2.2.zip\";s:8:\"requires\";s:3:\"4.7\";s:12:\"requires_php\";s:5:\"5.2.4\";}s:13:\"twentysixteen\";a:6:{s:5:\"theme\";s:13:\"twentysixteen\";s:11:\"new_version\";s:3:\"2.0\";s:3:\"url\";s:43:\"https://wordpress.org/themes/twentysixteen/\";s:7:\"package\";s:59:\"https://downloads.wordpress.org/theme/twentysixteen.2.0.zip\";s:8:\"requires\";s:3:\"4.4\";s:12:\"requires_php\";s:5:\"5.2.4\";}}s:12:\"translations\";a:0:{}}', 'no'),
(5419, '_site_transient_update_plugins', 'O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1580533982;s:7:\"checked\";a:3:{s:19:\"akismet/akismet.php\";s:3:\"4.1\";s:25:\"duplicator/duplicator.php\";s:6:\"1.2.52\";s:9:\"hello.php\";s:5:\"1.7.1\";}s:8:\"response\";a:3:{s:19:\"akismet/akismet.php\";O:8:\"stdClass\":12:{s:2:\"id\";s:21:\"w.org/plugins/akismet\";s:4:\"slug\";s:7:\"akismet\";s:6:\"plugin\";s:19:\"akismet/akismet.php\";s:11:\"new_version\";s:5:\"4.1.3\";s:3:\"url\";s:38:\"https://wordpress.org/plugins/akismet/\";s:7:\"package\";s:56:\"https://downloads.wordpress.org/plugin/akismet.4.1.3.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:59:\"https://ps.w.org/akismet/assets/icon-256x256.png?rev=969272\";s:2:\"1x\";s:59:\"https://ps.w.org/akismet/assets/icon-128x128.png?rev=969272\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:61:\"https://ps.w.org/akismet/assets/banner-772x250.jpg?rev=479904\";}s:11:\"banners_rtl\";a:0:{}s:6:\"tested\";s:5:\"5.3.2\";s:12:\"requires_php\";b:0;s:13:\"compatibility\";O:8:\"stdClass\":0:{}}s:25:\"duplicator/duplicator.php\";O:8:\"stdClass\":12:{s:2:\"id\";s:24:\"w.org/plugins/duplicator\";s:4:\"slug\";s:10:\"duplicator\";s:6:\"plugin\";s:25:\"duplicator/duplicator.php\";s:11:\"new_version\";s:6:\"1.3.24\";s:3:\"url\";s:41:\"https://wordpress.org/plugins/duplicator/\";s:7:\"package\";s:60:\"https://downloads.wordpress.org/plugin/duplicator.1.3.24.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:63:\"https://ps.w.org/duplicator/assets/icon-256x256.png?rev=2083921\";s:2:\"1x\";s:63:\"https://ps.w.org/duplicator/assets/icon-128x128.png?rev=2083921\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:65:\"https://ps.w.org/duplicator/assets/banner-772x250.png?rev=2085472\";}s:11:\"banners_rtl\";a:0:{}s:6:\"tested\";s:5:\"5.3.2\";s:12:\"requires_php\";s:6:\"5.2.17\";s:13:\"compatibility\";O:8:\"stdClass\":0:{}}s:9:\"hello.php\";O:8:\"stdClass\":12:{s:2:\"id\";s:25:\"w.org/plugins/hello-dolly\";s:4:\"slug\";s:11:\"hello-dolly\";s:6:\"plugin\";s:9:\"hello.php\";s:11:\"new_version\";s:5:\"1.7.2\";s:3:\"url\";s:42:\"https://wordpress.org/plugins/hello-dolly/\";s:7:\"package\";s:60:\"https://downloads.wordpress.org/plugin/hello-dolly.1.7.2.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:64:\"https://ps.w.org/hello-dolly/assets/icon-256x256.jpg?rev=2052855\";s:2:\"1x\";s:64:\"https://ps.w.org/hello-dolly/assets/icon-128x128.jpg?rev=2052855\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:66:\"https://ps.w.org/hello-dolly/assets/banner-772x250.jpg?rev=2052855\";}s:11:\"banners_rtl\";a:0:{}s:6:\"tested\";s:5:\"5.2.5\";s:12:\"requires_php\";b:0;s:13:\"compatibility\";O:8:\"stdClass\":0:{}}}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:0:{}}', 'no');

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_postmeta`
--

CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `wp_postmeta`
--

INSERT INTO `wp_postmeta` (`meta_id`, `post_id`, `meta_key`, `meta_value`) VALUES
(1, 2, '_wp_page_template', 'default'),
(2, 3, '_wp_page_template', 'default'),
(3, 1, '_edit_lock', '1546398623:1'),
(4, 5, '_edit_lock', '1546398511:1'),
(13, 10, '_edit_lock', '1544530589:1'),
(14, 11, '_wp_attached_file', '2018/12/imori.jpg'),
(15, 11, '_wp_attachment_metadata', 'a:5:{s:5:\"width\";i:640;s:6:\"height\";i:359;s:4:\"file\";s:17:\"2018/12/imori.jpg\";s:5:\"sizes\";a:2:{s:9:\"thumbnail\";a:4:{s:4:\"file\";s:17:\"imori-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:6:\"medium\";a:4:{s:4:\"file\";s:17:\"imori-300x168.jpg\";s:5:\"width\";i:300;s:6:\"height\";i:168;s:9:\"mime-type\";s:10:\"image/jpeg\";}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}'),
(18, 14, '_wp_attached_file', '2018/12/53_hyomon.jpg'),
(19, 14, '_wp_attachment_metadata', 'a:5:{s:5:\"width\";i:245;s:6:\"height\";i:207;s:4:\"file\";s:21:\"2018/12/53_hyomon.jpg\";s:5:\"sizes\";a:1:{s:9:\"thumbnail\";a:4:{s:4:\"file\";s:21:\"53_hyomon-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"1\";s:8:\"keywords\";a:0:{}}}'),
(20, 15, '_wp_attached_file', '2018/12/20170402_125229.jpg'),
(21, 15, '_wp_attachment_metadata', 'a:5:{s:5:\"width\";i:578;s:6:\"height\";i:259;s:4:\"file\";s:27:\"2018/12/20170402_125229.jpg\";s:5:\"sizes\";a:2:{s:9:\"thumbnail\";a:4:{s:4:\"file\";s:27:\"20170402_125229-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:6:\"medium\";a:4:{s:4:\"file\";s:27:\"20170402_125229-300x134.jpg\";s:5:\"width\";i:300;s:6:\"height\";i:134;s:9:\"mime-type\";s:10:\"image/jpeg\";}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}'),
(24, 17, '_edit_lock', '1544530981:1'),
(27, 19, '_edit_lock', '1545040577:2');

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_posts`
--

CREATE TABLE `wp_posts` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `post_author` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `wp_posts`
--

INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(1, 1, '2018-12-11 14:23:39', '2018-12-11 05:23:39', '<!-- wp:paragraph -->\n<p>WordPress へようこそ。こちらは最初の投稿です。編集または削除し、コンテンツ作成を始めてください。TEST5</p>\n<!-- /wp:paragraph -->', 'Hello world!', '', 'publish', 'open', 'open', '', 'hello-world', '', '', '2018-12-13 16:37:16', '2018-12-13 07:37:16', '', 0, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/?p=1', 0, 'post', '', 1),
(2, 1, '2018-12-11 14:23:39', '2018-12-11 05:23:39', '<!-- wp:paragraph -->\n<p>これはサンプルページです。同じ位置に固定され、(多くのテーマでは) サイトナビゲーションメニューに含まれる点がブログ投稿とは異なります。まずは、サイト訪問者に対して自分のことを説明する自己紹介ページを作成するのが一般的です。たとえば以下のようなものです。</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>はじめまして。昼間はバイク便のメッセンジャーとして働いていますが、俳優志望でもあります。これは僕のサイトです。ロサンゼルスに住み、ジャックという名前のかわいい犬を飼っています。好きなものはピニャコラーダ、そして通り雨に濡れること。</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>または、このようなものです。</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>XYZ 小道具株式会社は1971年の創立以来、高品質の小道具を皆様にご提供させていただいています。ゴッサム・シティに所在する当社では2,000名以上の社員が働いており、様々な形で地域のコミュニティへ貢献しています。</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>新しく WordPress ユーザーになった方は、<a href=\"http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/wp-admin/\">ダッシュボード</a>へ行ってこのページを削除し、独自のコンテンツを含む新しいページを作成してください。それでは、お楽しみください !</p>\n<!-- /wp:paragraph -->', 'サンプルページ', '', 'publish', 'closed', 'open', '', 'sample-page', '', '', '2018-12-11 14:23:39', '2018-12-11 05:23:39', '', 0, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/?page_id=2', 0, 'page', '', 0),
(3, 1, '2018-12-11 14:23:39', '2018-12-11 05:23:39', '<!-- wp:heading --><h2>私たちについて</h2><!-- /wp:heading --><!-- wp:paragraph --><p>私たちのサイトアドレスは http://amaraimusi.sakura.ne.jp/wp_demo/wordpress です。</p><!-- /wp:paragraph --><!-- wp:heading --><h2>このサイトが収集する個人データと収集の理由</h2><!-- /wp:heading --><!-- wp:heading {\"level\":3} --><h3>コメント</h3><!-- /wp:heading --><!-- wp:paragraph --><p>訪問者がこのサイトにコメントを残す際、コメントフォームに表示されているデータ、そしてスパム検出に役立てるための IP アドレスとブラウザーユーザーエージェント文字列を収集します。</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>メールアドレスから作成される匿名化された (「ハッシュ」とも呼ばれる) 文字列は、あなたが Gravatar サービスを使用中かどうか確認するため同サービスに提供されることがあります。同サービスのプライバシーポリシーは https://automattic.com/privacy/ にあります。コメントが承認されると、プロフィール画像がコメントとともに一般公開されます。</p><!-- /wp:paragraph --><!-- wp:heading {\"level\":3} --><h3>メディア</h3><!-- /wp:heading --><!-- wp:paragraph --><p>サイトに画像をアップロードする際、位置情報 (EXIF GPS) を含む画像をアップロードするべきではありません。サイトの訪問者は、サイトから画像をダウンロードして位置データを抽出することができます。</p><!-- /wp:paragraph --><!-- wp:heading {\"level\":3} --><h3>お問い合わせフォーム</h3><!-- /wp:heading --><!-- wp:heading {\"level\":3} --><h3>Cookie</h3><!-- /wp:heading --><!-- wp:paragraph --><p>サイトにコメントを残す際、お名前、メールアドレス、サイトを Cookie に保存することにオプトインできます。これはあなたの便宜のためであり、他のコメントを残す際に詳細情報を再入力する手間を省きます。この Cookie は1年間保持されます。</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>もしあなたがアカウントを持っており、このサイトにログインすると、私たちはあなたのブラウザーが Cookie を受け入れられるかを判断するために一時 Cookie を設定します。この Cookie は個人データを含んでおらず、ブラウザーを閉じた時に廃棄されます。</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>ログインの際さらに、ログイン情報と画面表示情報を保持するため、私たちはいくつかの Cookie を設定します。ログイン Cookie は2日間、画面表示オプション Cookie は1年間保持されます。「ログイン状態を保存する」を選択した場合、ログイン情報は2週間維持されます。ログアウトするとログイン Cookie は消去されます。</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>もし投稿を編集または公開すると、さらなる Cookie がブラウザーに保存されます。この Cookie は個人データを含まず、単に変更した投稿の ID を示すものです。1日で有効期限が切れます。</p><!-- /wp:paragraph --><!-- wp:heading {\"level\":3} --><h3>他サイトからの埋め込みコンテンツ</h3><!-- /wp:heading --><!-- wp:paragraph --><p>このサイトの投稿には埋め込みコンテンツ (動画、画像、投稿など) が含まれます。他サイトからの埋め込みコンテンツは、訪問者がそのサイトを訪れた場合とまったく同じように振る舞います。</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>これらのサイトは、あなたのデータの収集、Cookie の使用、サードパーティによる追加トラッキングの埋め込み、埋め込みコンテンツとのやりとりの監視を行うことがあります。アカウントを使ってそのサイトにログイン中の場合、埋め込みコンテンツとのやりとりのトラッキングも含まれます。</p><!-- /wp:paragraph --><!-- wp:heading {\"level\":3} --><h3>アナリティクス</h3><!-- /wp:heading --><!-- wp:heading --><h2>あなたのデータの共有先</h2><!-- /wp:heading --><!-- wp:heading --><h2>データを保存する期間</h2><!-- /wp:heading --><!-- wp:paragraph --><p>あなたがコメントを残すと、コメントとそのメタデータが無期限に保持されます。これは、モデレーションキューにコメントを保持しておく代わりに、フォローアップのコメントを自動的に認識し承認できるようにするためです。</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>このサイトに登録したユーザーがいる場合、その方がユーザープロフィールページで提供した個人情報を保存します。すべてのユーザーは自分の個人情報を表示、編集、削除することができます (ただしユーザー名は変更することができません)。サイト管理者もそれらの情報を表示、編集できます。</p><!-- /wp:paragraph --><!-- wp:heading --><h2>データに対するあなたの権利</h2><!-- /wp:heading --><!-- wp:paragraph --><p>このサイトのアカウントを持っているか、サイトにコメントを残したことがある場合、私たちが保持するあなたについての個人データ (提供したすべてのデータを含む) をエクスポートファイルとして受け取るリクエストを行うことができます。また、個人データの消去リクエストを行うこともできます。これには、管理、法律、セキュリティ目的のために保持する義務があるデータは含まれません。</p><!-- /wp:paragraph --><!-- wp:heading --><h2>あなたのデータの送信先</h2><!-- /wp:heading --><!-- wp:paragraph --><p>訪問者によるコメントは、自動スパム検出サービスを通じて確認を行う場合があります。</p><!-- /wp:paragraph --><!-- wp:heading --><h2>あなたの連絡先情報</h2><!-- /wp:heading --><!-- wp:heading --><h2>追加情報</h2><!-- /wp:heading --><!-- wp:heading {\"level\":3} --><h3>データの保護方法</h3><!-- /wp:heading --><!-- wp:heading {\"level\":3} --><h3>データ漏洩対策手順</h3><!-- /wp:heading --><!-- wp:heading {\"level\":3} --><h3>データ送信元のサードパーティ</h3><!-- /wp:heading --><!-- wp:heading {\"level\":3} --><h3>ユーザーデータに対して行う自動的な意思決定およびプロファイリング</h3><!-- /wp:heading --><!-- wp:heading {\"level\":3} --><h3>業界規制の開示要件</h3><!-- /wp:heading -->', 'プライバシーポリシー', '', 'draft', 'closed', 'open', '', 'privacy-policy', '', '', '2018-12-11 14:23:39', '2018-12-11 05:23:39', '', 0, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/?page_id=3', 0, 'page', '', 0),
(5, 1, '2018-12-11 20:42:31', '2018-12-11 11:42:31', '<!-- wp:paragraph -->\n<p><strong>琉球諸島</strong>（りゅうきゅうしょとう、<a href=\"https://ja.wikipedia.org/wiki/%E7%90%89%E7%90%83%E8%AA%9E\">琉球語</a>:Ruucuu-reptoo<sup><a href=\"#cite_note-1\">[1]</a></sup>）は、<a href=\"https://ja.wikipedia.org/wiki/%E5%8D%97%E8%A5%BF%E8%AB%B8%E5%B3%B6\">南西諸島</a>の中の<a href=\"https://ja.wikipedia.org/wiki/%E7%90%89%E7%90%83%E5%9B%BD\">琉球国</a>に属する部分の総称。これを現在の<a href=\"https://ja.wikipedia.org/wiki/%E6%B2%96%E7%B8%84%E7%9C%8C\">沖縄県</a>と同範囲にするかどうかは諸説あり、<a href=\"https://ja.wikipedia.org/wiki/%E5%A5%84%E7%BE%8E%E7%BE%A4%E5%B3%B6\">奄美群島</a>を含めたり、<a href=\"https://ja.wikipedia.org/wiki/%E5%A4%A7%E6%9D%B1%E8%AB%B8%E5%B3%B6\">大東諸島</a>を含めない場合もある。 TEST</p>\n<!-- /wp:paragraph -->', '琉球諸島', '', 'publish', 'open', 'open', '', '5', '', '', '2019-01-02 12:10:23', '2019-01-02 03:10:23', '', 0, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/?p=5', 0, 'post', '', 0),
(6, 1, '2018-12-11 20:42:31', '2018-12-11 11:42:31', '<!-- wp:paragraph -->\n<p><strong>琉球諸島</strong>（りゅうきゅうしょとう、<a href=\"/wiki/%E7%90%89%E7%90%83%E8%AA%9E\">琉球語</a>:Ruucuu-reptoo<sup><a href=\"#cite_note-1\">[1]</a></sup>）は、<a href=\"/wiki/%E5%8D%97%E8%A5%BF%E8%AB%B8%E5%B3%B6\">南西諸島</a>の中の<a href=\"/wiki/%E7%90%89%E7%90%83%E5%9B%BD\">琉球国</a>に属する部分の総称。これを現在の<a href=\"/wiki/%E6%B2%96%E7%B8%84%E7%9C%8C\">沖縄県</a>と同範囲にするかどうかは諸説あり、<a href=\"/wiki/%E5%A5%84%E7%BE%8E%E7%BE%A4%E5%B3%B6\">奄美群島</a>を含めたり、<a href=\"/wiki/%E5%A4%A7%E6%9D%B1%E8%AB%B8%E5%B3%B6\">大東諸島</a>を含めない場合もある。\n</p>\n<!-- /wp:paragraph -->', '', '', 'inherit', 'closed', 'closed', '', '5-revision-v1', '', '', '2018-12-11 20:42:31', '2018-12-11 11:42:31', '', 5, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/11/5-revision-v1/', 0, 'revision', '', 0),
(7, 1, '2018-12-11 20:43:06', '2018-12-11 11:43:06', '<!-- wp:paragraph -->\n<p><strong>琉球諸島</strong>（りゅうきゅうしょとう、<a href=\"/wiki/%E7%90%89%E7%90%83%E8%AA%9E\">琉球語</a>:Ruucuu-reptoo<sup><a href=\"#cite_note-1\">[1]</a></sup>）は、<a href=\"/wiki/%E5%8D%97%E8%A5%BF%E8%AB%B8%E5%B3%B6\">南西諸島</a>の中の<a href=\"/wiki/%E7%90%89%E7%90%83%E5%9B%BD\">琉球国</a>に属する部分の総称。これを現在の<a href=\"/wiki/%E6%B2%96%E7%B8%84%E7%9C%8C\">沖縄県</a>と同範囲にするかどうかは諸説あり、<a href=\"/wiki/%E5%A5%84%E7%BE%8E%E7%BE%A4%E5%B3%B6\">奄美群島</a>を含めたり、<a href=\"/wiki/%E5%A4%A7%E6%9D%B1%E8%AB%B8%E5%B3%B6\">大東諸島</a>を含めない場合もある。\n</p>\n<!-- /wp:paragraph -->', '琉球諸島', '', 'inherit', 'closed', 'closed', '', '5-revision-v1', '', '', '2018-12-11 20:43:06', '2018-12-11 11:43:06', '', 5, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/11/5-revision-v1/', 0, 'revision', '', 0),
(8, 1, '2018-12-11 20:45:20', '2018-12-11 11:45:20', '<!-- wp:paragraph -->\n<p><strong>琉球諸島</strong>（りゅうきゅうしょとう、<a href=\"/wiki/%E7%90%89%E7%90%83%E8%AA%9E\">琉球語</a>:Ruucuu-reptoo<sup><a href=\"#cite_note-1\">[1]</a></sup>）は、<a href=\"/wiki/%E5%8D%97%E8%A5%BF%E8%AB%B8%E5%B3%B6\">南西諸島</a>の中の<a href=\"/wiki/%E7%90%89%E7%90%83%E5%9B%BD\">琉球国</a>に属する部分の総称。これを現在の<a href=\"/wiki/%E6%B2%96%E7%B8%84%E7%9C%8C\">沖縄県</a>と同範囲にするかどうかは諸説あり、<a href=\"/wiki/%E5%A5%84%E7%BE%8E%E7%BE%A4%E5%B3%B6\">奄美群島</a>を含めたり、<a href=\"/wiki/%E5%A4%A7%E6%9D%B1%E8%AB%B8%E5%B3%B6\">大東諸島</a>を含めない場合もある。\n</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p><strong>琉球諸島</strong>（りゅうきゅうしょとう、<a href=\"https://ja.wikipedia.org/wiki/%E7%90%89%E7%90%83%E8%AA%9E\">琉球語</a>:Ruucuu-reptoo<sup><a href=\"#cite_note-1\">[1]</a></sup>）は、<a href=\"https://ja.wikipedia.org/wiki/%E5%8D%97%E8%A5%BF%E8%AB%B8%E5%B3%B6\">南西諸島</a>の中の<a href=\"https://ja.wikipedia.org/wiki/%E7%90%89%E7%90%83%E5%9B%BD\">琉球国</a>に属する部分の総称。これを現在の<a href=\"https://ja.wikipedia.org/wiki/%E6%B2%96%E7%B8%84%E7%9C%8C\">沖縄県</a>と同範囲にするかどうかは諸説あり、<a href=\"https://ja.wikipedia.org/wiki/%E5%A5%84%E7%BE%8E%E7%BE%A4%E5%B3%B6\">奄美群島</a>を含めたり、<a href=\"https://ja.wikipedia.org/wiki/%E5%A4%A7%E6%9D%B1%E8%AB%B8%E5%B3%B6\">大東諸島</a>を含めない場合もある。\n</p>\n<!-- /wp:paragraph -->', '琉球諸島', '', 'inherit', 'closed', 'closed', '', '5-revision-v1', '', '', '2018-12-11 20:45:20', '2018-12-11 11:45:20', '', 5, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/11/5-revision-v1/', 0, 'revision', '', 0),
(9, 1, '2018-12-11 20:45:37', '2018-12-11 11:45:37', '<!-- wp:paragraph -->\n<p><strong>琉球諸島</strong>（りゅうきゅうしょとう、<a href=\"https://ja.wikipedia.org/wiki/%E7%90%89%E7%90%83%E8%AA%9E\">琉球語</a>:Ruucuu-reptoo<sup><a href=\"#cite_note-1\">[1]</a></sup>）は、<a href=\"https://ja.wikipedia.org/wiki/%E5%8D%97%E8%A5%BF%E8%AB%B8%E5%B3%B6\">南西諸島</a>の中の<a href=\"https://ja.wikipedia.org/wiki/%E7%90%89%E7%90%83%E5%9B%BD\">琉球国</a>に属する部分の総称。これを現在の<a href=\"https://ja.wikipedia.org/wiki/%E6%B2%96%E7%B8%84%E7%9C%8C\">沖縄県</a>と同範囲にするかどうかは諸説あり、<a href=\"https://ja.wikipedia.org/wiki/%E5%A5%84%E7%BE%8E%E7%BE%A4%E5%B3%B6\">奄美群島</a>を含めたり、<a href=\"https://ja.wikipedia.org/wiki/%E5%A4%A7%E6%9D%B1%E8%AB%B8%E5%B3%B6\">大東諸島</a>を含めない場合もある。\n</p>\n<!-- /wp:paragraph -->', '琉球諸島', '', 'inherit', 'closed', 'closed', '', '5-revision-v1', '', '', '2018-12-11 20:45:37', '2018-12-11 11:45:37', '', 5, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/11/5-revision-v1/', 0, 'revision', '', 0),
(10, 1, '2018-12-11 21:07:10', '2018-12-11 12:07:10', '<!-- wp:image {\"id\":15} -->\n<figure class=\"wp-block-image\"><img src=\"http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/wp-content/uploads/2018/12/20170402_125229.jpg\" alt=\"\" class=\"wp-image-15\"/></figure>\n<!-- /wp:image -->\n\n<!-- wp:paragraph -->\n<p></p>\n<!-- /wp:paragraph -->', 'ヨシノボリ', '', 'publish', 'open', 'open', '', '%e3%82%b7%e3%83%aa%e3%82%b1%e3%83%b3%e3%82%a4%e3%83%a2%e3%83%aa', '', '', '2018-12-11 21:18:15', '2018-12-11 12:18:15', '', 0, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/?p=10', 0, 'post', '', 0),
(11, 1, '2018-12-11 21:06:50', '2018-12-11 12:06:50', '', 'imori', '', 'inherit', 'open', 'closed', '', 'imori', '', '', '2018-12-11 21:06:50', '2018-12-11 12:06:50', '', 10, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/wp-content/uploads/2018/12/imori.jpg', 0, 'attachment', 'image/jpeg', 0),
(12, 1, '2018-12-11 21:07:10', '2018-12-11 12:07:10', '<!-- wp:image {\"id\":11} -->\n<figure class=\"wp-block-image\"><img src=\"http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/wp-content/uploads/2018/12/imori.jpg\" alt=\"\" class=\"wp-image-11\"/></figure>\n<!-- /wp:image -->\n\n<!-- wp:paragraph -->\n<p></p>\n<!-- /wp:paragraph -->', 'シリケンイモリ', '', 'inherit', 'closed', 'closed', '', '10-revision-v1', '', '', '2018-12-11 21:07:10', '2018-12-11 12:07:10', '', 10, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/11/10-revision-v1/', 0, 'revision', '', 0),
(13, 1, '2018-12-11 21:18:01', '2018-12-11 12:18:01', '<!-- wp:image -->\n<figure class=\"wp-block-image\"><img alt=\"\"/></figure>\n<!-- /wp:image -->', 'シリケンイモリ', '', 'inherit', 'closed', 'closed', '', '10-autosave-v1', '', '', '2018-12-11 21:18:01', '2018-12-11 12:18:01', '', 10, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/11/10-autosave-v1/', 0, 'revision', '', 0),
(14, 1, '2018-12-11 21:16:40', '2018-12-11 12:16:40', '', '53_hyomon', '', 'inherit', 'open', 'closed', '', '53_hyomon', '', '', '2018-12-11 21:16:40', '2018-12-11 12:16:40', '', 10, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/wp-content/uploads/2018/12/53_hyomon.jpg', 0, 'attachment', 'image/jpeg', 0),
(15, 1, '2018-12-11 21:18:01', '2018-12-11 12:18:01', '', '20170402_125229', '', 'inherit', 'open', 'closed', '', '20170402_125229', '', '', '2018-12-11 21:18:01', '2018-12-11 12:18:01', '', 10, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/wp-content/uploads/2018/12/20170402_125229.jpg', 0, 'attachment', 'image/jpeg', 0),
(16, 1, '2018-12-11 21:18:15', '2018-12-11 12:18:15', '<!-- wp:image {\"id\":15} -->\n<figure class=\"wp-block-image\"><img src=\"http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/wp-content/uploads/2018/12/20170402_125229.jpg\" alt=\"\" class=\"wp-image-15\"/></figure>\n<!-- /wp:image -->\n\n<!-- wp:paragraph -->\n<p></p>\n<!-- /wp:paragraph -->', 'ヨシノボリ', '', 'inherit', 'closed', 'closed', '', '10-revision-v1', '', '', '2018-12-11 21:18:15', '2018-12-11 12:18:15', '', 10, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/11/10-revision-v1/', 0, 'revision', '', 0),
(17, 1, '2018-12-11 21:22:58', '2018-12-11 12:22:58', '<!-- wp:paragraph -->\n<p><strong>木曽町</strong>（きそまち）は、<a href=\"https://ja.wikipedia.org/wiki/%E9%95%B7%E9%87%8E%E7%9C%8C\">長野県</a><a href=\"https://ja.wikipedia.org/wiki/%E6%9C%A8%E6%9B%BD%E9%83%A1\">木曽郡</a>中央部にある<a href=\"https://ja.wikipedia.org/wiki/%E7%94%BA\">町</a>。「<a href=\"https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%A7%E6%9C%80%E3%82%82%E7%BE%8E%E3%81%97%E3%81%84%E6%9D%91%E9%80%A3%E5%90%88\">日本で最も美しい村連合</a>」の一つ。\n</p>\n<!-- /wp:paragraph -->', '木曽町', '', 'publish', 'open', 'open', '', '%e6%9c%a8%e6%9b%bd%e7%94%ba', '', '', '2018-12-11 21:22:58', '2018-12-11 12:22:58', '', 0, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/?p=17', 0, 'post', '', 0),
(18, 1, '2018-12-11 21:22:58', '2018-12-11 12:22:58', '<!-- wp:paragraph -->\n<p><strong>木曽町</strong>（きそまち）は、<a href=\"https://ja.wikipedia.org/wiki/%E9%95%B7%E9%87%8E%E7%9C%8C\">長野県</a><a href=\"https://ja.wikipedia.org/wiki/%E6%9C%A8%E6%9B%BD%E9%83%A1\">木曽郡</a>中央部にある<a href=\"https://ja.wikipedia.org/wiki/%E7%94%BA\">町</a>。「<a href=\"https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%A7%E6%9C%80%E3%82%82%E7%BE%8E%E3%81%97%E3%81%84%E6%9D%91%E9%80%A3%E5%90%88\">日本で最も美しい村連合</a>」の一つ。\n</p>\n<!-- /wp:paragraph -->', '木曽町', '', 'inherit', 'closed', 'closed', '', '17-revision-v1', '', '', '2018-12-11 21:22:58', '2018-12-11 12:22:58', '', 17, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/11/17-revision-v1/', 0, 'revision', '', 0),
(19, 1, '2018-12-11 21:25:29', '2018-12-11 12:25:29', '<!-- wp:paragraph -->\n<p><strong>特定非営利活動法人「日本で最も美しい村」連合</strong>（にほんでもっともうつくしいむら れんごう）は、「日本で最も美しい村」（<em>the most beautiful villages in Japan</em>）の名称の使用権を管理し、加盟団体の観光の広報活動などをする<a href=\"https://ja.wikipedia.org/wiki/%E7%89%B9%E5%AE%9A%E9%9D%9E%E5%96%B6%E5%88%A9%E6%B4%BB%E5%8B%95%E6%B3%95%E4%BA%BA\">特定非営利活動法人</a>。通称「<strong>美しい村連合</strong>」。</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>ゆいワークステストです。</p>\n<!-- /wp:paragraph -->', '美しい村連合', '', 'publish', 'open', 'open', '', '%e7%be%8e%e3%81%97%e3%81%84%e6%9d%91%e9%80%a3%e5%90%88', '', '', '2018-12-17 17:44:51', '2018-12-17 08:44:51', '', 0, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/?p=19', 0, 'post', '', 0),
(20, 1, '2018-12-11 21:25:29', '2018-12-11 12:25:29', '<!-- wp:paragraph -->\n<p><strong>特定非営利活動法人「日本で最も美しい村」連合</strong>（にほんでもっともうつくしいむら れんごう）は、「日本で最も美しい村」（<em>the most beautiful villages in Japan</em>）の名称の使用権を管理し、加盟団体の観光の広報活動などをする<a href=\"/wiki/%E7%89%B9%E5%AE%9A%E9%9D%9E%E5%96%B6%E5%88%A9%E6%B4%BB%E5%8B%95%E6%B3%95%E4%BA%BA\">特定非営利活動法人</a>。通称「<strong>美しい村連合</strong>」。\n</p>\n<!-- /wp:paragraph -->', '美しい村連合', '', 'inherit', 'closed', 'closed', '', '19-revision-v1', '', '', '2018-12-11 21:25:29', '2018-12-11 12:25:29', '', 19, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/11/19-revision-v1/', 0, 'revision', '', 0),
(21, 1, '2018-12-11 21:29:40', '2018-12-11 12:29:40', '<!-- wp:paragraph -->\n<p><strong>特定非営利活動法人「日本で最も美しい村」連合</strong>（にほんでもっともうつくしいむら れんごう）は、「日本で最も美しい村」（<em>the most beautiful villages in Japan</em>）の名称の使用権を管理し、加盟団体の観光の広報活動などをする<a href=\"https://ja.wikipedia.org/wiki/%E7%89%B9%E5%AE%9A%E9%9D%9E%E5%96%B6%E5%88%A9%E6%B4%BB%E5%8B%95%E6%B3%95%E4%BA%BA\">特定非営利活動法人</a>。通称「<strong>美しい村連合</strong>」。\n</p>\n<!-- /wp:paragraph -->', '美しい村連合', '', 'inherit', 'closed', 'closed', '', '19-revision-v1', '', '', '2018-12-11 21:29:40', '2018-12-11 12:29:40', '', 19, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/11/19-revision-v1/', 0, 'revision', '', 0),
(22, 1, '2018-12-13 15:15:32', '2018-12-13 06:15:32', '<!-- wp:paragraph -->\n<p>WordPress へようこそ。こちらは最初の投稿です。編集または削除し、コンテンツ作成を始めてください。TEST</p>\n<!-- /wp:paragraph -->', 'Hello world!', '', 'inherit', 'closed', 'closed', '', '1-revision-v1', '', '', '2018-12-13 15:15:32', '2018-12-13 06:15:32', '', 1, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/13/1-revision-v1/', 0, 'revision', '', 0),
(24, 2, '2018-12-13 15:43:31', '2018-12-13 06:43:31', '<!-- wp:paragraph -->\n<p>WordPress へようこそ。こちらは最初の投稿です。編集または削除し、コンテンツ作成を始めてください。TEST2</p>\n<!-- /wp:paragraph -->', 'Hello world!', '', 'inherit', 'closed', 'closed', '', '1-revision-v1', '', '', '2018-12-13 15:43:31', '2018-12-13 06:43:31', '', 1, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/13/1-revision-v1/', 0, 'revision', '', 0),
(25, 2, '2018-12-13 15:45:56', '2018-12-13 06:45:56', '<!-- wp:paragraph -->\n<p>WordPress へようこそ。こちらは最初の投稿です。編集または削除し、コンテンツ作成を始めてください。TEST3</p>\n<!-- /wp:paragraph -->', 'Hello world!', '', 'inherit', 'closed', 'closed', '', '1-revision-v1', '', '', '2018-12-13 15:45:56', '2018-12-13 06:45:56', '', 1, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/13/1-revision-v1/', 0, 'revision', '', 0),
(26, 2, '2018-12-13 16:34:26', '2018-12-13 07:34:26', '<!-- wp:paragraph -->\n<p>WordPress へようこそ。こちらは最初の投稿です。編集または削除し、コンテンツ作成を始めてください。TEST4</p>\n<!-- /wp:paragraph -->', 'Hello world!', '', 'inherit', 'closed', 'closed', '', '1-revision-v1', '', '', '2018-12-13 16:34:26', '2018-12-13 07:34:26', '', 1, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/13/1-revision-v1/', 0, 'revision', '', 0),
(27, 2, '2018-12-13 16:37:16', '2018-12-13 07:37:16', '<!-- wp:paragraph -->\n<p>WordPress へようこそ。こちらは最初の投稿です。編集または削除し、コンテンツ作成を始めてください。TEST5</p>\n<!-- /wp:paragraph -->', 'Hello world!', '', 'inherit', 'closed', 'closed', '', '1-revision-v1', '', '', '2018-12-13 16:37:16', '2018-12-13 07:37:16', '', 1, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/13/1-revision-v1/', 0, 'revision', '', 0),
(28, 2, '2018-12-17 17:44:51', '2018-12-17 08:44:51', '<!-- wp:paragraph -->\n<p><strong>特定非営利活動法人「日本で最も美しい村」連合</strong>（にほんでもっともうつくしいむら れんごう）は、「日本で最も美しい村」（<em>the most beautiful villages in Japan</em>）の名称の使用権を管理し、加盟団体の観光の広報活動などをする<a href=\"https://ja.wikipedia.org/wiki/%E7%89%B9%E5%AE%9A%E9%9D%9E%E5%96%B6%E5%88%A9%E6%B4%BB%E5%8B%95%E6%B3%95%E4%BA%BA\">特定非営利活動法人</a>。通称「<strong>美しい村連合</strong>」。</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>ゆいワークステストです。</p>\n<!-- /wp:paragraph -->', '美しい村連合', '', 'inherit', 'closed', 'closed', '', '19-revision-v1', '', '', '2018-12-17 17:44:51', '2018-12-17 08:44:51', '', 19, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2018/12/17/19-revision-v1/', 0, 'revision', '', 0),
(29, 1, '2019-01-02 12:10:23', '2019-01-02 03:10:23', '<!-- wp:paragraph -->\n<p><strong>琉球諸島</strong>（りゅうきゅうしょとう、<a href=\"https://ja.wikipedia.org/wiki/%E7%90%89%E7%90%83%E8%AA%9E\">琉球語</a>:Ruucuu-reptoo<sup><a href=\"#cite_note-1\">[1]</a></sup>）は、<a href=\"https://ja.wikipedia.org/wiki/%E5%8D%97%E8%A5%BF%E8%AB%B8%E5%B3%B6\">南西諸島</a>の中の<a href=\"https://ja.wikipedia.org/wiki/%E7%90%89%E7%90%83%E5%9B%BD\">琉球国</a>に属する部分の総称。これを現在の<a href=\"https://ja.wikipedia.org/wiki/%E6%B2%96%E7%B8%84%E7%9C%8C\">沖縄県</a>と同範囲にするかどうかは諸説あり、<a href=\"https://ja.wikipedia.org/wiki/%E5%A5%84%E7%BE%8E%E7%BE%A4%E5%B3%B6\">奄美群島</a>を含めたり、<a href=\"https://ja.wikipedia.org/wiki/%E5%A4%A7%E6%9D%B1%E8%AB%B8%E5%B3%B6\">大東諸島</a>を含めない場合もある。 TEST</p>\n<!-- /wp:paragraph -->', '琉球諸島', '', 'inherit', 'closed', 'closed', '', '5-revision-v1', '', '', '2019-01-02 12:10:23', '2019-01-02 03:10:23', '', 5, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2019/01/02/5-revision-v1/', 0, 'revision', '', 0),
(30, 1, '2019-01-02 12:12:44', '2019-01-02 03:12:44', '<!-- wp:paragraph -->\n<p>WordPress へようこそ。こちらは最初の投稿です。編集または削除し、コンテンツ作成を始めてください。TEST5</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>●受付期間●　平成３１年２月１日（金）～平成３１年２月２８日（木）</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>　　　　　　（AM8：30～PM5：15）</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>　　　　　　※土・日・祝祭日、お昼時間（PM12：00～PM1：00）を除く</p>\n<!-- /wp:paragraph -->', 'Hello world!', '', 'inherit', 'closed', 'closed', '', '1-autosave-v1', '', '', '2019-01-02 12:12:44', '2019-01-02 03:12:44', '', 1, 'http://amaraimusi.sakura.ne.jp/wp_demo/wordpress/2019/01/02/1-autosave-v1/', 0, 'revision', '', 0);

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_termmeta`
--

CREATE TABLE `wp_termmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_terms`
--

CREATE TABLE `wp_terms` (
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `wp_terms`
--

INSERT INTO `wp_terms` (`term_id`, `name`, `slug`, `term_group`) VALUES
(1, '未分類', '%e6%9c%aa%e5%88%86%e9%a1%9e', 0);

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_term_relationships`
--

CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `wp_term_relationships`
--

INSERT INTO `wp_term_relationships` (`object_id`, `term_taxonomy_id`, `term_order`) VALUES
(1, 1, 0),
(5, 1, 0),
(10, 1, 0),
(17, 1, 0),
(19, 1, 0);

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_term_taxonomy`
--

CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `wp_term_taxonomy`
--

INSERT INTO `wp_term_taxonomy` (`term_taxonomy_id`, `term_id`, `taxonomy`, `description`, `parent`, `count`) VALUES
(1, 1, 'category', '', 0, 5);

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_usermeta`
--

CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `wp_usermeta`
--

INSERT INTO `wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES
(1, 1, 'nickname', 'kani'),
(2, 1, 'first_name', ''),
(3, 1, 'last_name', ''),
(4, 1, 'description', ''),
(5, 1, 'rich_editing', 'true'),
(6, 1, 'syntax_highlighting', 'true'),
(7, 1, 'comment_shortcuts', 'false'),
(8, 1, 'admin_color', 'fresh'),
(9, 1, 'use_ssl', '0'),
(10, 1, 'show_admin_bar_front', 'true'),
(11, 1, 'locale', ''),
(12, 1, 'wp_capabilities', 'a:1:{s:13:\"administrator\";b:1;}'),
(13, 1, 'wp_user_level', '10'),
(14, 1, 'dismissed_wp_pointers', 'wp496_privacy'),
(15, 1, 'show_welcome_panel', '1'),
(16, 1, 'session_tokens', 'a:1:{s:64:\"5dd4c6202cc160de35e88477c1c5f84a7a379aa31cadf4f40bf19fdbe614fc6b\";a:4:{s:10:\"expiration\";i:1546571406;s:2:\"ip\";s:15:\"126.219.137.211\";s:2:\"ua\";s:114:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36\";s:5:\"login\";i:1546398606;}}'),
(17, 1, 'wp_dashboard_quick_press_last_post_id', '4'),
(18, 2, 'nickname', 'kisomati'),
(19, 2, 'first_name', '木曽'),
(20, 2, 'last_name', '町'),
(21, 2, 'description', ''),
(22, 2, 'rich_editing', 'true'),
(23, 2, 'syntax_highlighting', 'true'),
(24, 2, 'comment_shortcuts', 'false'),
(25, 2, 'admin_color', 'fresh'),
(26, 2, 'use_ssl', '0'),
(27, 2, 'show_admin_bar_front', 'true'),
(28, 2, 'locale', ''),
(29, 2, 'wp_capabilities', 'a:1:{s:6:\"editor\";b:1;}'),
(30, 2, 'wp_user_level', '7'),
(31, 2, 'dismissed_wp_pointers', 'wp496_privacy'),
(32, 2, 'session_tokens', 'a:3:{s:64:\"7eb452579c4e5b9a5139636df98fe6b41bc8616740c955742a95579a87b8243f\";a:4:{s:10:\"expiration\";i:1545208829;s:2:\"ip\";s:12:\"58.1.237.183\";s:2:\"ua\";s:68:\"Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko\";s:5:\"login\";i:1545036029;}s:64:\"9d2a8e77f873c13d29fc3fb8df90e254bb52bbce80e56efb0baf021832098a53\";a:4:{s:10:\"expiration\";i:1545208913;s:2:\"ip\";s:12:\"58.1.237.183\";s:2:\"ua\";s:68:\"Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko\";s:5:\"login\";i:1545036113;}s:64:\"d77b6e24954b32d4f4f9e8f88d05653beefe6e92978e082d31d2b0bbb62cbd5a\";a:4:{s:10:\"expiration\";i:1545209055;s:2:\"ip\";s:12:\"58.1.237.183\";s:2:\"ua\";s:77:\"Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0\";s:5:\"login\";i:1545036255;}}'),
(33, 2, 'wp_dashboard_quick_press_last_post_id', '23'),
(34, 2, 'community-events-location', 'a:1:{s:2:\"ip\";s:13:\"126.219.137.0\";}');

-- --------------------------------------------------------

--
-- テーブルの構造 `wp_users`
--

CREATE TABLE `wp_users` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- テーブルのデータのダンプ `wp_users`
--

INSERT INTO `wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES
(1, 'kani', '$P$B5cIHrb.9swoLhUcNS0CYUP8RI5/lR0', 'kani', 'amaraimusi@gmail.com', '', '2018-12-11 05:23:39', '', 0, 'kani'),
(2, 'kisomati', '$P$B9Hn/P1r6BOSJNqP02FCgiwAvQNYRf/', 'kisomati', 'amaraimusi@yahoo.co.jp', '', '2018-12-13 06:40:12', '1544683213:$P$BcYydwfV.5JW6gnyZodAsVs/6xSEpx/', 0, '町木曽');

-- --------------------------------------------------------

--
-- テーブルの構造 `yagis`
--

CREATE TABLE `yagis` (
  `id` int(11) NOT NULL,
  `yagi_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '山羊名',
  `yagi_val1` int(11) DEFAULT NULL COMMENT '山羊値１',
  `yagi_date` date DEFAULT NULL,
  `yagi_x_date` date NOT NULL COMMENT '山羊X日付',
  `yagi_group` int(11) DEFAULT NULL COMMENT '山羊種別',
  `yagi_dt` datetime DEFAULT NULL,
  `note` text CHARACTER SET utf8 NOT NULL COMMENT '備考',
  `sort_no` int(11) DEFAULT '0' COMMENT '順番',
  `delete_flg` tinyint(1) DEFAULT '0' COMMENT '無効フラグ',
  `update_user` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新者',
  `ip_addr` varchar(40) CHARACTER SET utf8 DEFAULT NULL COMMENT 'IPアドレス',
  `created` datetime DEFAULT NULL COMMENT '生成日時',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- テーブルのデータのダンプ `yagis`
--

INSERT INTO `yagis` (`id`, `yagi_name`, `yagi_val1`, `yagi_date`, `yagi_x_date`, `yagi_group`, `yagi_dt`, `note`, `sort_no`, `delete_flg`, `update_user`, `ip_addr`, `created`, `modified`) VALUES
(1, '大山やぎたつ', NULL, NULL, '0000-00-00', 1, NULL, '', NULL, 1, 'kani', '::1', '2018-04-28 15:51:34', '2018-04-28 06:52:32'),
(2, 'TEST2', NULL, NULL, '0000-00-00', 1, NULL, '', -1, 1, 'kani', '::1', '2018-04-28 15:52:25', '2018-04-28 06:52:33'),
(3, 'TEST32', 100, '2018-04-28', '0000-00-00', 1, NULL, '', -1, 0, 'kani', '::1', '2018-04-28 15:52:39', '2018-04-28 13:02:56'),
(4, 'TEST4', 1235, '2018-03-12', '2018-03-12', NULL, NULL, '', -2, 0, 'kani', '::1', '2018-04-29 06:55:45', '2018-04-28 21:56:14'),
(5, '', NULL, '2018-04-02', '0000-00-00', 1, NULL, '', -3, 0, 'kani', '::1', '2018-04-29 07:13:25', '2018-04-28 22:13:25');

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `app_configs`
--
ALTER TABLE `app_configs`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `app_scopes`
--
ALTER TABLE `app_scopes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `var_name` (`var_name`);

--
-- テーブルのインデックス `configs`
--
ALTER TABLE `configs`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `en_sps`
--
ALTER TABLE `en_sps`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `kanis`
--
ALTER TABLE `kanis`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `msg_boards`
--
ALTER TABLE `msg_boards`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `msg_board_goods`
--
ALTER TABLE `msg_board_goods`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `nekos`
--
ALTER TABLE `nekos`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `neko_groups`
--
ALTER TABLE `neko_groups`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `wp_commentmeta`
--
ALTER TABLE `wp_commentmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- テーブルのインデックス `wp_comments`
--
ALTER TABLE `wp_comments`
  ADD PRIMARY KEY (`comment_ID`),
  ADD KEY `comment_post_ID` (`comment_post_ID`),
  ADD KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  ADD KEY `comment_date_gmt` (`comment_date_gmt`),
  ADD KEY `comment_parent` (`comment_parent`),
  ADD KEY `comment_author_email` (`comment_author_email`(10));

--
-- テーブルのインデックス `wp_duplicator_packages`
--
ALTER TABLE `wp_duplicator_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hash` (`hash`);

--
-- テーブルのインデックス `wp_links`
--
ALTER TABLE `wp_links`
  ADD PRIMARY KEY (`link_id`),
  ADD KEY `link_visible` (`link_visible`);

--
-- テーブルのインデックス `wp_options`
--
ALTER TABLE `wp_options`
  ADD PRIMARY KEY (`option_id`),
  ADD UNIQUE KEY `option_name` (`option_name`);

--
-- テーブルのインデックス `wp_postmeta`
--
ALTER TABLE `wp_postmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- テーブルのインデックス `wp_posts`
--
ALTER TABLE `wp_posts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `post_name` (`post_name`(191)),
  ADD KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  ADD KEY `post_parent` (`post_parent`),
  ADD KEY `post_author` (`post_author`);

--
-- テーブルのインデックス `wp_termmeta`
--
ALTER TABLE `wp_termmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- テーブルのインデックス `wp_terms`
--
ALTER TABLE `wp_terms`
  ADD PRIMARY KEY (`term_id`),
  ADD KEY `slug` (`slug`(191)),
  ADD KEY `name` (`name`(191));

--
-- テーブルのインデックス `wp_term_relationships`
--
ALTER TABLE `wp_term_relationships`
  ADD PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  ADD KEY `term_taxonomy_id` (`term_taxonomy_id`);

--
-- テーブルのインデックス `wp_term_taxonomy`
--
ALTER TABLE `wp_term_taxonomy`
  ADD PRIMARY KEY (`term_taxonomy_id`),
  ADD UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  ADD KEY `taxonomy` (`taxonomy`);

--
-- テーブルのインデックス `wp_usermeta`
--
ALTER TABLE `wp_usermeta`
  ADD PRIMARY KEY (`umeta_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- テーブルのインデックス `wp_users`
--
ALTER TABLE `wp_users`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_login_key` (`user_login`),
  ADD KEY `user_nicename` (`user_nicename`),
  ADD KEY `user_email` (`user_email`);

--
-- テーブルのインデックス `yagis`
--
ALTER TABLE `yagis`
  ADD PRIMARY KEY (`id`);

--
-- ダンプしたテーブルのAUTO_INCREMENT
--

--
-- テーブルのAUTO_INCREMENT `app_configs`
--
ALTER TABLE `app_configs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- テーブルのAUTO_INCREMENT `app_scopes`
--
ALTER TABLE `app_scopes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=4;

--
-- テーブルのAUTO_INCREMENT `configs`
--
ALTER TABLE `configs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- テーブルのAUTO_INCREMENT `en_sps`
--
ALTER TABLE `en_sps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=612;

--
-- テーブルのAUTO_INCREMENT `kanis`
--
ALTER TABLE `kanis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- テーブルのAUTO_INCREMENT `msg_boards`
--
ALTER TABLE `msg_boards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- テーブルのAUTO_INCREMENT `msg_board_goods`
--
ALTER TABLE `msg_board_goods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- テーブルのAUTO_INCREMENT `nekos`
--
ALTER TABLE `nekos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200;

--
-- テーブルのAUTO_INCREMENT `neko_groups`
--
ALTER TABLE `neko_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- テーブルのAUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=8;

--
-- テーブルのAUTO_INCREMENT `wp_commentmeta`
--
ALTER TABLE `wp_commentmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルのAUTO_INCREMENT `wp_comments`
--
ALTER TABLE `wp_comments`
  MODIFY `comment_ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- テーブルのAUTO_INCREMENT `wp_duplicator_packages`
--
ALTER TABLE `wp_duplicator_packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルのAUTO_INCREMENT `wp_links`
--
ALTER TABLE `wp_links`
  MODIFY `link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルのAUTO_INCREMENT `wp_options`
--
ALTER TABLE `wp_options`
  MODIFY `option_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5420;

--
-- テーブルのAUTO_INCREMENT `wp_postmeta`
--
ALTER TABLE `wp_postmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- テーブルのAUTO_INCREMENT `wp_posts`
--
ALTER TABLE `wp_posts`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- テーブルのAUTO_INCREMENT `wp_termmeta`
--
ALTER TABLE `wp_termmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- テーブルのAUTO_INCREMENT `wp_terms`
--
ALTER TABLE `wp_terms`
  MODIFY `term_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- テーブルのAUTO_INCREMENT `wp_term_taxonomy`
--
ALTER TABLE `wp_term_taxonomy`
  MODIFY `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- テーブルのAUTO_INCREMENT `wp_usermeta`
--
ALTER TABLE `wp_usermeta`
  MODIFY `umeta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- テーブルのAUTO_INCREMENT `wp_users`
--
ALTER TABLE `wp_users`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- テーブルのAUTO_INCREMENT `yagis`
--
ALTER TABLE `yagis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
