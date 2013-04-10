DELETE FROM `gameobject_spawns` WHERE `id` BETWEEN '505136' AND '505271';
DELETE FROM `creature_spawns` WHERE `id` BETWEEN '400132' AND '400161';
DELETE FROM `creature_formations` WHERE `spawn_id`=400151;
DELETE FROM `creature_waypoints` WHERE `spawnid` IN (400157,400139,400142,400161);
