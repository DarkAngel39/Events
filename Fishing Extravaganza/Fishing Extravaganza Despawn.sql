SET @CGUID := 434400;
SET @GGUID := 512586;

DELETE FROM `creature_spawns` WHERE `id` BETWEEN @CGUID+1 AND @CGUID+3;
DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN @GGUID+1 AND @GGUID+52;
DELETE FROM `creature_quest_starter` WHERE `quest` IN (8193,8194,8221,8224,8225);
DELETE FROM `creature_quest_finisher` WHERE `quest` IN (8193,8194,8221,8224,8225);

CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event`=18;
