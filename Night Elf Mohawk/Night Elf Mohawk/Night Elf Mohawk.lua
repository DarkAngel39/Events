local TEXT1 = 15038
local TEXT2 = 15037
local GOSSIP_OPTION = "I believe in you."
local SPELL_CREATE_GRENADE = 69243
local SPELL_MOHAWKED = 58493
local NPC_MOHAWK = 31111

function OnGossip(pUnit,  event, pPlayer)
	if(pPlayer:HasAura(SPELL_MOHAWKED))then
		pUnit:GossipCreateMenu(TEXT1, pPlayer, 0)
		pUnit:GossipSendMenu(pPlayer)
	elseif(pPlayer:HasAura(SPELL_MOHAWKED) == false)then
		pUnit:GossipCreateMenu(TEXT2, pPlayer, 0)
		pUnit:GossipMenuAddItem(0, GOSSIP_OPTION, 1, 0)
		pUnit:GossipSendMenu(pPlayer)
	end
end

function OnSelect(pUnit, event, pPlayer, id, intid, code)
if(intid == 1)then
	pUnit:FullCastSpellOnTarget(SPELL_CREATE_GRENADE,pPlayer)
	pPlayer:GossipComplete()
end
end

RegisterUnitGossipEvent(NPC_MOHAWK, 1, OnGossip)
RegisterUnitGossipEvent(NPC_MOHAWK, 2, OnSelect)
