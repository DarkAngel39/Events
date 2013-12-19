DELETE FROM `creature_quest_starter` WHERE `id` IN (18927,19148,19171,19172,19173,20102,19169,19175,19176,19177,19178,32798,32799);
DELETE FROM `creature_quest_starter` WHERE `quest` IN (8746,8799,8762,8763,7063);
SET @GOID := 109999;
SET @SPID := 709999;
DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN @GOID AND @GOID+1781;
DELETE FROM `creature_spawns` WHERE `id` BETWEEN @SPID AND @SPID+131;
DELETE FROM `npc_gossip_textid` WHERE `creatureid` IN (18927,19148,19169,19171,19172,19173,19175,19176,19177,19178,20102);
UPDATE `creature_proto` SET `auras`=' ' WHERE `entry` IN (18927,19148,19169,19171,19172,19173,19175,19176,19177,19178,20102);
DELETE FROM `loot_creatures` WHERE `itemid` IN (21524,21525);

CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event`=7;
