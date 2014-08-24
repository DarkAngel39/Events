SET @CGUID := 434403;
DELETE FROM `creature_spawns` WHERE `id` BETWEEN @CGUID+1 AND @CGUID+2;
DELETE FROM `creature_quest_starter` WHERE `quest` IN (8228,8229);
DELETE FROM `creature_quest_finisher` WHERE `quest` IN (8228,8229);

CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event`=19;
