local ACHIEVEMENT_BOOTY = 3457
local SPELL_TURN_PIRATE = 50517
local TEXT_NO_AURA = 13059
local TEXT_AURA = 13065
local GOSSIP_OPTION = "Here's to you. Dread Captain! Make me a pirate of the day."
local NPC_DREAD_CAPITAN = 28048

function OnGossip(pUnit, event, pPlayer)
if not(pPlayer:HasAura(SPELL_TURN_PIRATE))then
	pUnit:GossipCreateMenu(TEXT_NO_AURA, pPlayer, 0)
	pUnit:GossipMenuAddItem(0, GOSSIP_OPTION, 1, 0)
	pUnit:GossipSendMenu(pPlayer)
else
	pUnit:GossipCreateMenu(TEXT_AURA, pPlayer, 0)
	pUnit:GossipSendMenu(pPlayer)
end
end

function OnGossipSelect(pUnit, event, pPlayer, id, intid, code)
if(intid == 1)then
	pPlayer:FullCastSpell(SPELL_TURN_PIRATE)
	if not(pPlayer:HasAchievement(ACHIEVEMENT_BOOTY))then
		pPlayer:AddAchievement(ACHIEVEMENT_BOOTY)
	end
	pPlayer:GossipComplete()
end
end

RegisterUnitGossipEvent(NPC_DREAD_CAPITAN,1,OnGossip)
RegisterUnitGossipEvent(NPC_DREAD_CAPITAN,2,OnGossipSelect)
