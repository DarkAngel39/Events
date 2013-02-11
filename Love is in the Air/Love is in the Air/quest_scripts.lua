local QUEST_PERFECT_PERFUME = 24629
local QUEST_CLASSY_COLONGE = 24635
local QUEST_BONBON_BITZ = 24636
local QUEST_HOT_ON_THE_TRIAL_A = 24849
local QUEST_HOT_ON_THE_TRIAL_H = 24851
local QUEST_A_FRIENDLY_CHAT_H = 24576
local QUEST_A_FRIENDLY_CHAT_A = 24657
local SPELL_ROMANTIC_PICNIC = 45123
local SPELL_LUCKY_CHARM_COLLECTOR = 69510
local SPELL_LUCKY_CHARM = 69511
local SPELL_PERFUME_SPRITZ_CREDIT = 71002
local SPELL_HEAVY_PERFUMED = 71520
local SPELL_CREATE_LEDGER = 70646
local GO_PICNIC_BASKET = 187267
local GO_STRANGE_VIAL = 181015
local ITEM_CHARM_COLLECTOR = 49661
local ITEM_LEDGER = 49915
local AT_S_AUCTION_HOUSE = 5711
local AT_S_BARBER_HOUSE = 5712
local AT_S_BANK = 5710
local AT_O_AUCTION_HOUSE = 5714
local AT_O_BARBER_HOUSE = 5716
local AT_O_BANK = 5715
local NPC_A_GUARD = 68
local NPC_H_GUARD = 3296
local NPC_SNIVEL = 37715

local last_spell = 0

function SpellCast(event, pPlayer, SpellId, pSpellObject)
	local SPELL_1 = 69445 -- perfume
	local SPELL_2 = 69563 -- cologne
	local SPELL_3 = 69489 -- bonbon

	if ( SpellId==SPELL_1 or SpellId==SPELL_2 or SpellId==SPELL_3 ) then
		last_spell = SpellId
	else
		if ( SpellId ~= SPELL_PERFUME_SPRITZ_CREDIT and SpellId ~= 69438) then
			last_spell = 0
		end
	end

	if (SpellId == SPELL_PERFUME_SPRITZ_CREDIT) then
		if (last_spell==SPELL_1 and pPlayer:GetQuestObjectiveCompletion(QUEST_PERFECT_PERFUME, 0) < 10) then
			pPlayer:AdvanceQuestObjective(QUEST_PERFECT_PERFUME, 0)
		end
		if (last_spell==SPELL_2 and pPlayer:GetQuestObjectiveCompletion(QUEST_CLASSY_COLONGE, 0) < 10) then
			pPlayer:AdvanceQuestObjective(QUEST_CLASSY_COLONGE, 0)
		end
		if (last_spell==SPELL_3 and pPlayer:GetQuestObjectiveCompletion(QUEST_BONBON_BITZ, 0) < 10) then
			pPlayer:AdvanceQuestObjective(QUEST_BONBON_BITZ, 0)
		end
	end
end

function OnUse(pGameObject, event, pPlayer)
pPlayer:FullCastSpell(SPELL_ROMANTIC_PICNIC)
pPlayer:Emote(13, 4000)
end

function KillCreature(event, pKiller, pDied)
if(pKiller:IsPlayer() and pDied:IsPlayer() == false)then
	if(pKiller:HasItem(ITEM_CHARM_COLLECTOR) and pDied:IsDead())then
		pKiller:CastSpell(SPELL_LUCKY_CHARM_COLLECTOR)
	end
end
end

function OnLoad(pUnit)
pUnit:RegisterAIUpdateEvent(30000)
end

function AIUpdate(pUnit)
if(pUnit == nil)then
	pUnit:RemoveAIUpdateEvent()
end
local chance = math.random(1,100)
if(chance <= 30)then
	pUnit:FullCastSpell(SPELL_HEAVY_PERFUMED)
elseif(chance == 100)then
	if(pUnit:HasAura(SPELL_HEAVY_PERFUMED))then
		pUnit:RemoveAura(SPELL_HEAVY_PERFUMED)
	end
end
end

function AreaTrigger(event, pPlayer, AreaTriggerId)
if(AreaTriggerId == AT_S_BANK)then
	if(pPlayer:GetQuestObjectiveCompletion(QUEST_HOT_ON_THE_TRIAL_A, 0) < 1)then
		pPlayer:AdvanceQuestObjective(QUEST_HOT_ON_THE_TRIAL_A, 0)
	end
elseif(AreaTriggerId == AT_S_AUCTION_HOUSE)then
	if(pPlayer:GetQuestObjectiveCompletion(QUEST_HOT_ON_THE_TRIAL_A, 1) < 1)then
		pPlayer:AdvanceQuestObjective(QUEST_HOT_ON_THE_TRIAL_A, 1)
	end
elseif(AreaTriggerId == AT_S_BARBER_HOUSE)then
	if(pPlayer:GetQuestObjectiveCompletion(QUEST_HOT_ON_THE_TRIAL_A, 2) < 1)then
		pPlayer:AdvanceQuestObjective(QUEST_HOT_ON_THE_TRIAL_A, 2)
	end
elseif(AreaTriggerId == AT_O_BANK)then
	if(pPlayer:GetQuestObjectiveCompletion(QUEST_HOT_ON_THE_TRIAL_H, 0) < 1)then
		pPlayer:AdvanceQuestObjective(QUEST_HOT_ON_THE_TRIAL_H, 0)
	end
elseif(AreaTriggerId == AT_O_AUCTION_HOUSE)then
	if(pPlayer:GetQuestObjectiveCompletion(QUEST_HOT_ON_THE_TRIAL_H, 1) < 1)then
		pPlayer:AdvanceQuestObjective(QUEST_HOT_ON_THE_TRIAL_H, 1)
	end
elseif(AreaTriggerId == AT_O_BARBER_HOUSE)then
	if(pPlayer:GetQuestObjectiveCompletion(QUEST_HOT_ON_THE_TRIAL_H, 2) < 1)then
		pPlayer:AdvanceQuestObjective(QUEST_HOT_ON_THE_TRIAL_H, 2)
	end
end
end

function OnGossip(pUnit, event, pPlayer)
pUnit:GossipCreateMenu(15188, pPlayer, 0)
if(pPlayer:HasQuest(QUEST_A_FRIENDLY_CHAT_H) or pPlayer:HasQuest(QUEST_A_FRIENDLY_CHAT_A))then
	if(pPlayer:HasItem(ITEM_LEDGER) == false)then
	pUnit:GossipMenuAddItem(0, "I have a rocket here with your mark on it, Snivel.", 1, 0)
	end
end
pUnit:GossipSendMenu(pPlayer)
end

function OnGossip_Submenus(pUnit, event, pPlayer, id, intid, code)
if(intid == 1)then
	pUnit:GossipCreateMenu(15209, pPlayer, 0)
	pUnit:GossipMenuAddItem(0, "There's a chemical inside the rocket. What is it?", 2, 0)
	pUnit:GossipSendMenu(pPlayer)
elseif(intid == 2)then
	pUnit:GossipCreateMenu(15210, pPlayer, 0)
	pUnit:GossipMenuAddItem(0, "Where were they delivered?", 3, 0)
	pUnit:GossipSendMenu(pPlayer)
elseif(intid == 3)then
	pUnit:GossipCreateMenu(15211, pPlayer, 0)
	pUnit:GossipSendMenu(pPlayer)
	pPlayer:CastSpell(SPELL_CREATE_LEDGER)
end
end

RegisterServerHook(26, "AreaTrigger")
RegisterServerHook(28, "KillCreature")
RegisterServerHook(10, "SpellCast")
RegisterGameObjectEvent(GO_PICNIC_BASKET,4,OnUse)
RegisterUnitEvent(NPC_A_GUARD,18,OnLoad)
RegisterUnitEvent(NPC_A_GUARD,21,AIUpdate)
RegisterUnitEvent(NPC_H_GUARD,18,OnLoad)
RegisterUnitEvent(NPC_H_GUARD,21,AIUpdate)
RegisterUnitGossipEvent(NPC_SNIVEL,1,OnGossip)
RegisterUnitGossipEvent(NPC_SNIVEL,2,OnGossip_Submenus)
