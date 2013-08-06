CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event`=52;

SET @SPID := 400900;
SET @GOID := 400900;
DELETE FROM `creature_spawns` WHERE `id` BETWEEN @SPID+1 AND @SPID+63;
DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN @GOID+1 AND @GOID+11;

DELETE FROM `npc_gossip_textid` WHERE `creatureid`=2496;
INSERT INTO `npc_gossip_textid` (`creatureid`,`textid`) VALUES 
	(2496,7965);
