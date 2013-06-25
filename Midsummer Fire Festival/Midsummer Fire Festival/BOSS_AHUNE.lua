local BOSS_AHUNE				= 25740
local NPC_AHUNE_BOTTLE_BUNNY	= 26346
local NPC_AHUNE_ICE_BUNNY		= 25985
local NPC_HAILSTONE				= 25755
local NPC_COLDWAVE				= 25756
local NPC_FROZENCORE			= 25865
local NPC_FROSTWIND				= 25757
local OBJECT_ICE_STONE			= 187882
local QUEST_SUMMON_AHUNE		= 11691
 -- Spells
 -- Ahune intro and visual
local SPELL_AHUNE_FLOOR_AMBIENT	= 46314
local SPELL_AHUNE_FLOOR			= 45945
local SPELL_AHUNE_BONFIRE		= 45930
local SPELL_AHUNE_RESURFACE		= 46402
local SPELL_AHUNE_GHOST_MODEL	= 46786
local SPELL_AHUNE_BEAM_ATT_1	= 46336
local SPELL_AHUNE_BEAM_ATT_1	= 46336
local SPELL_AHUNE_GHOST_BURST	= 46809
local SPELL_AHUNE_STAND			= 37752
local SPELL_AHUNE_SUBMERGED		= 37751
 -- Combat spells.
local SPELL_AHUNE_1_MINION		= 46103
local SPELL_AHUNE_1_MINION		= 46103
local SPELL_AHUNE_SHIELD		= 45954
local SPELL_AHUNE_COLD_SLAP		= 46145
 -- End spells
local SPELL_AHUNE_SUMM_LOOT		= 45939
local SPELL_AHUNE_SUMM_LOOT_H	= 46622
local self = getfenv(1)

function IceStone_OnUse(pGO, event, pPlayer)
	pGO:GossipCreateMenu(15864, pPlayer, 0)
	if(pPlayer:HasQuest(QUEST_SUMMON_AHUNE))then
		pGO:GossipMenuAddItem(0, "Disturb the stone and summon Lord Ahune.", 1, 0)
	end
	pGO:GossipSendMenu(pPlayer)
end

function OnSelect(pGO, event, pPlayer, id, intid, code)
if(intid == 1)then
	pGO:SpawnCreature(BOSS_AHUNE,-95.57,-240.801,-1.222,1.566,14,3600000,0,0,0,1,0)
	pGO:Despawn(1,0)
end
end

RegisterGOGossipEvent(OBJECT_ICE_STONE,2,OnSelect)
RegisterGameObjectEvent(OBJECT_ICE_STONE, 4, IceStone_OnUse)