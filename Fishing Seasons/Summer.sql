CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event` IN(60,61);
INSERT INTO `active_event_id` (`active_event`, `name`) VALUES (61,"Fishing Summer.");

DELETE FROM `loot_fishing` WHERE `itemid` IN (13756,13755);
INSERT INTO `loot_fishing` (`entryid`, `itemid`, `normal10percentchance`, `normal25percentchance`, `heroic10percentchance`, `heroic25percentchance`, `mincount`, `maxcount`) VALUES
	(297,13756,'3.54','0','0','0',1,1),
	(307,13756,'5.23','0','0','0',1,1),
	(308,13756,'0.42','0','0','0',1,1),
	(977,13756,'3.62','0','0','0',1,1),
	(983,13756,'5.89','0','0','0',1,1),
	(986,13756,'3.13','0','0','0',1,1),
	(987,13756,'0.76','0','0','0',1,1),
	(988,13756,'2.14','0','0','0',1,1),
	(1108,13756,'1.64','0','0','0',1,1),
	(1116,13756,'4.15','0','0','0',1,1),
	(1117,13756,'6.19','0','0','0',1,1),
	(1120,13756,'6.26','0','0','0',1,1),
	(1121,13756,'6.82','0','0','0',1,1),
	(1222,13756,'9.66','0','0','0',1,1),
	(1226,13756,'8','0','0','0',1,1),
	(1227,13756,'8.55','0','0','0',1,1),
	(1228,13756,'4.03','0','0','0',1,1),
	(1229,13756,'3.52','0','0','0',1,1),
	(1230,13756,'4.2','0','0','0',1,1),
	(1231,13756,'4.27','0','0','0',1,1),
	(1256,13756,'3.23','0','0','0',1,1),
	(1336,13756,'1.11','0','0','0',1,1),
	(1940,13756,'2.46','0','0','0',1,1),
	(3140,13756,'7.16','0','0','0',1,1),
	(3317,13756,'4.39','0','0','0',1,1);
