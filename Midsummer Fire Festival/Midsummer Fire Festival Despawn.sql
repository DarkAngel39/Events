SET @SPID := 500000;
SET @GOID := 500001;
DELETE FROM `creature_spawns` WHERE `id` BETWEEN @SPID+1 AND @SPID+674;
DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN @GOID+1 AND @GOID+2221;
DELETE FROM `gameobject_quest_starter` WHERE `quest` IN('11580', '11581', '11732', '11734', '11735', '11736', '11737', '11738', '11739', '11740', '11741', '11742', '11743', '11744', '11745', '11746', '11747', '11748', '11749', '11750', '11751', '11752', '11753', '11754', '11755', '11756', '11757', '11758', '11759', '11760', '11761', '11762', '11763', '11764', '11765', '11799', '11800', '11801', '11802', '11803', '11766', '11767', '11768', '11769', '11770', '11771', '11772', '11773', '11774', '11775', '11776', '11777', '11778', '11779', '11780', '11781', '11782', '11783', '11784', '11785', '11786', '11787', '13440', '13441', '13450', '13442', '13443', '13451', '13444', '13453', '13445', '13454', '13455', '13446', '13447', '13457', '13458', '13449');
DELETE FROM `gameobject_quest_finisher` WHERE `quest` IN('11580', '11581', '11732', '11734', '11735', '11736', '11737', '11738', '11739', '11740', '11741', '11742', '11743', '11744', '11745', '11746', '11747', '11748', '11749', '11750', '11751', '11752', '11753', '11754', '11755', '11756', '11757', '11758', '11759', '11760', '11761', '11762', '11763', '11764', '11765', '11799', '11800', '11801', '11802', '11803', '11766', '11767', '11768', '11769', '11770', '11771', '11772', '11773', '11774', '11775', '11776', '11777', '11778', '11779', '11780', '11781', '11782', '11783', '11784', '11785', '11786', '11787', '13440', '13441', '13450', '13442', '13443', '13451', '13444', '13453', '13445', '13454', '13455', '13446', '13447', '13457', '13458', '13449');
DELETE FROM `creature_quest_starter` WHERE `quest` IN ('9365', '11964', '9339', '11966', '11970', '11971', '11891', '12012', '11691', '11696', '11805', '11841', '11804', '11806', '11807', '11808', '11809', '11810', '11811', '11812', '11813', '11814', '11815', '11816', '11817', '11818', '11819', '11820', '11821', '11822', '11823', '11824', '11825', '11826', '11827', '11583', '11828', '11829', '11830', '11831', '11832', '11833', '11834', '11835', '11836', '11837', '11838', '11839', '11840', '11842', '11843', '11844', '11845', '11846', '11847', '11848', '11849', '11850', '11851', '11853', '11852', '11854', '11855', '11584', '11856', '11857', '11858', '11859', '11860', '11861', '11862', '11863', '11657', '11731', '11921', '11924', '11922', '11923', '11925', '11926', '11886', '11917', '11947', '11948', '11952', '11953', '11954', '11955', '13485', '13486', '13487', '13488', '13489', '13490', '13491', '13492', '13493', '13494', '13495', '13496', '13497', '13498', '13499', '13500', '11976');

CREATE TABLE IF NOT EXISTS `active_event_id` (
  `active_event` int(10) unsigned NOT NULL,
  `name` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`active_event`)
);

DELETE FROM `active_event_id` WHERE `active_event`=4;
