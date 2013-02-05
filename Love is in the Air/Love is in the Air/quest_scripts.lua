QUEST_PERFECT_PERFUME = 24629
QUEST_CLASSY_COLONGE = 24635
QUEST_BONBON_BITZ = 24636
SPELL_ROMANTIC_PICNIC = 45123
SPELL_LUCKY_CHARM_COLLECTOR = 69510
SPELL_LUCKY_CHARM = 69511
SPELL_PERFUME_SPRITZ_CREDIT = 71002
GO_PICNIC_BASKET = 187267
ITEM_CHARM_COLLECTOR = 49661

function SpellCast(event, pPlayer, SpellId, pSpellObject)
if(SpellId == SPELL_PERFUME_SPRITZ_CREDIT)then
	if(pPlayer:GetQuestObjectiveCompletion(QUEST_PERFECT_PERFUME, 0) < 10)then
		pPlayer:AdvanceQuestObjective(QUEST_PERFECT_PERFUME, 0)
	end
	if(pPlayer:GetQuestObjectiveCompletion(QUEST_CLASSY_COLONGE, 0) < 10)then
		pPlayer:AdvanceQuestObjective(QUEST_CLASSY_COLONGE, 0)
	end
	if(pPlayer:GetQuestObjectiveCompletion(QUEST_BONBON_BITZ, 0) < 10)then
		pPlayer:AdvanceQuestObjective(QUEST_BONBON_BITZ, 0)
	end
 --[[ elseif(SPELL_LUCKY_CHARM_COLLECTOR)then
	local chance = math.random(1,100)
	if(chance <= 34)then
		pPlayer:CastSpell(SPELL_LUCKY_CHARM)
	end ]]--
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

RegisterServerHook(28, "KillCreature")
RegisterServerHook(10, "SpellCast")
RegisterGameObjectEvent(GO_PICNIC_BASKET,4,OnUse)
