
SET @CGUID:= 400131;
SET @GGUID:= 505135;

DELETE FROM `creature_spawns` WHERE `id` BETWEEN @CGUID+1 AND @CGUID+30;
DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN @GGUID+1 AND @GGUID+136;
DELETE FROM `creature_formations` WHERE `spawn_id`=@CGUID+20;
DELETE FROM `creature_waypoints` WHERE `spawnid` IN (@CGUID+8,@CGUID+11,@CGUID+26,@CGUID+30);

CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event`=22;
