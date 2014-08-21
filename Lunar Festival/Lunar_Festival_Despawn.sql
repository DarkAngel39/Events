CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event`=1;

SET @CGUID := 429999;
SET @GGUID := 539999;

DELETE FROM `creature_spawns` WHERE `id` BETWEEN @CGUID+1 AND @CGUID+234;
DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN @GGUID+1 AND @GGUID+1271;
DELETE FROM `npc_gossip_textid` WHERE `creatureid` IN (19169,19171,19148,19178,19172,20102,18927,19173,19175,19176,19177);
