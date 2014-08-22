SET @CGUID:= 434533;
SET @GGUID:= 512657;

DELETE FROM `creature_spawns` WHERE `id` BETWEEN @CGUID+1 AND @CGUID+128;
DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN @GGUID+1 AND @GGUID+87;

CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event`=40;
