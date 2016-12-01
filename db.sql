-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.9 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             8.2.0.4675
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table test.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_category_category` (`parent_id`),
  CONSTRAINT `FK_category_category` FOREIGN KEY (`parent_id`) REFERENCES `category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=334 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test.category: ~5 rows (approximately)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `parent_id`, `name`, `active`) VALUES
	(1, NULL, 'Категория', 1),
	(2, 1, 'Категория', 1),
	(3, 1, 'Категория', 1),
	(222, 3, 'Категория22', 1),
	(333, 3, 'Категория33', 0);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


-- Dumping structure for table test.news
CREATE TABLE IF NOT EXISTS `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` int(11) NOT NULL DEFAULT '1',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=445 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test.news: ~5 rows (approximately)
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` (`id`, `active`, `title`, `image`, `description`, `text`, `date`) VALUES
	(1, 1, 'Новость 1', 'http://site-with.images/images/image-1.jpg', 'Описание', 'text', '2015-05-12'),
	(2, 1, 'Новость 2', 'http://site-with.images/images/image-1.jpg', 'Описание', 'text', '2015-05-12'),
	(3, 1, 'Новость 3', 'http://site-with.images/images/image-1.jpg', 'Описание', 'text', '2015-05-12'),
	(4, 0, 'Новость 4', 'http://site-with.images/images/image-1.jpg', 'Описание', 'text', '2015-05-12'),
	(5, 1, 'Новость 555', 'http://site-with.images/images/image-1.jpg', 'Описание', 'text', '2015-05-12'),
	(333, 1, 'Новость 333', 'http://site-with.images/images/image-1.jpg', 'Описание333', 'text', '2015-05-12'),
	(444, 1, 'Новость 444', 'http://site-with.images/images/image-1.jpg', 'Описание44', 'text', '2015-05-12');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;


-- Dumping structure for table test.news_category
CREATE TABLE IF NOT EXISTS `news_category` (
  `news_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`news_id`,`category_id`),
  KEY `FK_news_category_category` (`category_id`),
  CONSTRAINT `FK_news_category_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_news_category_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test.news_category: ~0 rows (approximately)
/*!40000 ALTER TABLE `news_category` DISABLE KEYS */;
INSERT INTO `news_category` (`news_id`, `category_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 2),
	(5, 3),
	(333, 222),
	(444, 222),
	(5, 333);
/*!40000 ALTER TABLE `news_category` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
