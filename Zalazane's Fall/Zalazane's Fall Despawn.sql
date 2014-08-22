SET @CGUID := 409999;
SET @GGUID := 5900078;

DELETE FROM `creature_spawns` WHERE `id` BETWEEN @CGUID+1 AND @CGUID+142;
DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN @GGUID+1 AND @GGUID+78;

CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event`=9;
