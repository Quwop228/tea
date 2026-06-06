-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: art_of_tea
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `art_of_tea`
--

/*!40000 DROP DATABASE IF EXISTS `art_of_tea`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `art_of_tea` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `art_of_tea`;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  FULLTEXT KEY `ft_articles` (`title`,`content`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'Как заваривать габа улун','Для заваривания габа чая важно соблюдать правильную температуру и время. Рекомендуется использовать воду температурой 90–95°C. Чтобы достичь этой температуры, доведите воду до кипения, а затем дайте ей остыть 2–3 минуты. Заваривайте габа улун в течение 3–5 минут, в зависимости от ваших предпочтений. Габа улун можно заваривать несколько раз, и с каждым новым завариванием вкус будет меняться и раскрываться. Наслаждайтесь чаепитием! 🍵✨','2026-05-31 17:33:46'),(2,'Как правильно заваривать зелёный чай','Зелёный чай не любит крутого кипятка. Оптимальная температура воды — 75–85°C, иначе листья «сгорят» и появится горечь. Используйте около 3–5 граммов чая на 150 мл воды. Первый пролив делайте коротким, 20–30 секунд, и увеличивайте время с каждым следующим завариванием. Зелёный чай выдерживает 3–4 пролива. 🍃','2026-05-31 17:33:46'),(3,'Какой чай пить для бодрости и энергии по утрам','Чтобы взбодриться утром, выбирайте чай с высоким содержанием кофеина и насыщенным вкусом. Отлично подойдёт шу пуэр, красный чай Дянь Хун, японская сенча или церемониальная матча. Эти сорта мягко, но уверенно тонизируют, дарят заряд энергии и помогают проснуться без резкого эффекта, как от кофе. ⚡🌅','2026-05-31 17:33:46'),(4,'Какой чай помогает уснуть и расслабиться вечером','Перед сном лучше выбирать напитки без кофеина. Иван-чай, ройбуш и габа улун успокаивают нервную систему, снимают напряжение и помогают мягко уснуть. Заваривайте их некрепко и пейте за час до сна, чтобы расслабиться после долгого дня. 🌙😴','2026-05-31 17:33:46'),(5,'Чай для медитации и спокойствия','Для медитативных практик подходят чаи с расслабляющим, обволакивающим вкусом. Габа улун богат гамма-аминомасляной кислотой и помогает сосредоточиться и успокоить ум. Неспешная заварка и осознанное чаепитие сами по себе становятся формой медитации. 🧘🍵','2026-05-31 17:33:46'),(6,'В каких чаях нет кофеина','Полностью без кофеина только травяные напитки: иван-чай (кипрей), ройбуш, а также фруктовые и цветочные сборы. Настоящий чай (зелёный, белый, улун, красный, пуэр) делается из камелии китайской и всегда содержит кофеин, хотя его количество зависит от сорта и способа заваривания. 🌿','2026-05-31 17:33:46'),(7,'Чем полезен пуэр','Пуэр — это постферментированный чай, который улучшает пищеварение и помогает чувствовать лёгкость после плотной еды. Шу пуэр бодрит и согревает, обладает мягким землистым вкусом. Его особенность — способность выдерживать множество проливов и улучшаться со временем хранения. ☕','2026-05-31 17:33:46'),(8,'Как проходит китайская чайная церемония','Китайская чайная церемония гунфу-ча — это неспешное искусство заваривания чая в маленьком чайнике или гайвани. Используют много чайного листа, короткие проливы и горячую воду. Каждый пролив раскрывает новые грани вкуса. Церемония учит вниманию, спокойствию и наслаждению моментом. 🫖','2026-05-31 17:33:46');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `emoji` varchar(16) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` varchar(8) NOT NULL DEFAULT '₽',
  `url` varchar(512) NOT NULL DEFAULT '',
  `image` varchar(512) NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  FULLTEXT KEY `ft_products` (`name`,`description`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Тегуаньинь, высший сорт, осень 2024 г.','🍵','Знаменитый улун с юга провинции Фуцзянь, обладающий сбалансированным, мягким вкусом и сладковатым ароматом. Этот чай дарит спокойствие и расслабление, что делает его идеальным выбором для вечернего чаепития. Наслаждайтесь его сдобным ароматом и долгим сладким послевкусием. 🌙✨',450.00,'₽','https://art-of-tea.ru/oolong/teguanin-1sort','assets/img/tea-box-1.png','2026-05-31 17:33:46'),(2,'Габа улун Али Шань Классическая','🌿','Классический тайваньский Габа улун, обладающий мягким, сочным вкусом и расслабляющим эффектом. Богатый гамма-аминомасляной кислотой, он помогает снять напряжение и способствует медитации. Идеален для вечернего расслабления и умиротворения. 🌌🍃',650.00,'₽','https://art-of-tea.ru/oolong/gaba-ulun-ali-shan','assets/img/tea-box-2.png','2026-05-31 17:33:46'),(3,'Зелёный чай с жасмином Моли Хуа Люй Ча','🌸','Столовый зелёный чай с лепестками жасмина обладает тонким, сладким ароматом и мягким вкусом. Он освежает и мягко тонизирует, что делает его отличным выбором для вечернего чаепития. Долгое, сочное послевкусие. 🌙💖',330.00,'₽','https://art-of-tea.ru/greentea/jasmine-moli-hua','assets/img/tea-box-3.png','2026-05-31 17:33:46'),(4,'Шу пуэр «Мэнхай Гунтин», 2021 г.','🍂','Высокосортный шу пуэр с дворцовой типсовой нарезкой. Обладает плотным, древесным вкусом с нотами чернослива и шоколада. Бодрит и наполняет энергией — отличный выбор для утреннего чаепития. Многократно заваривается, раскрываясь с каждым проливом. ☕💪',5706.00,'₽','https://art-of-tea.ru/puer/shu-menhai-guntin','assets/img/tea-box-4.png','2026-05-31 17:33:46'),(5,'Да Хун Пао «Большой красный халат»','🔥','Легендарный сильно ферментированный утёсный улун с насыщенным, бодрящим вкусом и ароматом печёных фруктов. Прекрасно тонизирует и помогает проснуться, поэтому идеален для утра и первой половины дня. 🌅⚡',480.00,'₽','https://art-of-tea.ru/oolong/da-hun-pao','assets/img/tea-box-5.png','2026-05-31 17:33:46'),(6,'Иван-чай (кипрей) ферментированный','🌾','Традиционный русский травяной чай из кипрея. Полностью без кофеина, обладает мягким медово-травяным вкусом. Успокаивает и помогает уснуть, поэтому хорош для вечера и крепкого сна. Подходит для всей семьи. 🌙😴',380.00,'₽','https://art-of-tea.ru/herbal/ivan-chai','assets/img/tea-cup.png','2026-05-31 17:33:46'),(7,'Молочный улун «Най Сян», новый урожай','🥛','Нежный бирюзовый улун со сливочно-молочным ароматом и сладким вкусом. Свежие чайные новинки сезона: мягко тонизирует и поднимает настроение — приятен в течение всего дня. 🍮🌿',520.00,'₽','https://art-of-tea.ru/oolong/milk-oolong','assets/img/tea-box-6.png','2026-05-31 17:33:46'),(8,'Сенча Япония, зелёный чай','🍵','Классический японский зелёный чай с травянисто-свежим вкусом и приятной терпкостью. Бодрит мягче кофе и заряжает энергией и бодростью — отличный выбор для утра. Богат антиоксидантами. 🌅🍃',290.00,'₽','https://art-of-tea.ru/greentea/sencha','assets/img/tea-cup-2.jpg','2026-05-31 17:33:46'),(9,'Дянь Хун, красный чай с типсами','🌹','Юньнаньский красный чай с обилием золотых типсов. Сладкий, медовый вкус с нотами какао хорошо бодрит и согревает — приятен утром и днём. Чайные новинки этого сезона. 🍯☕',420.00,'₽','https://art-of-tea.ru/redtea/dian-hun','assets/img/tea-box-1.png','2026-05-31 17:33:46'),(10,'Матча церемониальная, премиум','🍃','Ярко-зелёный японский порошковый чай для классической чайной церемонии. Насыщенный вкус дарит бодрость и концентрацию — идеален для утра и медитации. Взбивается венчиком тясэн. 🌅🌿',890.00,'₽','https://art-of-tea.ru/greentea/matcha-ceremonial','assets/img/tea-box-2.png','2026-05-31 17:33:46'),(11,'Ройбуш африканский','🌼','Травяной напиток из южноафриканского кустарника, полностью без кофеина. Сладковатый ореховый вкус, успокаивает и помогает расслабиться вечером перед сном. Можно пить детям. 🌙🍯',350.00,'₽','https://art-of-tea.ru/herbal/rooibos','assets/img/tea-cup.png','2026-05-31 17:33:46');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggestions`
--

DROP TABLE IF EXISTS `suggestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suggestions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggestions`
--

LOCK TABLES `suggestions` WRITE;
/*!40000 ALTER TABLE `suggestions` DISABLE KEYS */;
INSERT INTO `suggestions` VALUES (1,'Чайные новинки',1,1),(2,'Чай для бодрости',2,1),(3,'Чай для сна',3,1),(4,'Как заваривать чай',4,1),(5,'Чайные церемонии',5,1),(6,'Чай для медитации',6,1),(7,'Какой чай улучшает пищеварение',7,1),(8,'В каких чаях нет кофеина',8,1);
/*!40000 ALTER TABLE `suggestions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-06 19:20:05
