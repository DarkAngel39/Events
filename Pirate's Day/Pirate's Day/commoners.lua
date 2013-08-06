local SPELL_GOSSIP_PIRATES_DAY = 50531
local GOSSIP_TEXT_COMMONER = 13044
local GOSSIP_OPTON_COMMONER = "I'd like to dress as a prate."

function OnSpawn(pUnit, event)
pUnit:FullCastSpell(SPELL_GOSSIP_PIRATES_DAY)
end

function OnGossip(pUnit, event, pPlayer)
pUnit:GossipCreateMenu(GOSSIP_TEXT_COMMONER, pPlayer, 0)
pUnit:GossipMenuAddItem(0, GOSSIP_OPTON_COMMONER, 1, 0)
end

function OnGossip_Submenus(pUnit, event, pPlayer, id, intid, code)
if(intid == 1)then
	pPlayer:FullCastSpell(50517) -- TODO: find the correct spell.
	pPlayer:GossipComplete()
end
end

RegisterUnitEvent(18927,18,OnSpawn)
RegisterUnitEvent(19148,18,OnSpawn)
RegisterUnitEvent(19169,18,OnSpawn)
RegisterUnitEvent(19171,18,OnSpawn)
RegisterUnitEvent(19172,18,OnSpawn)
RegisterUnitEvent(19173,18,OnSpawn)
RegisterUnitEvent(19175,18,OnSpawn)
RegisterUnitEvent(19176,18,OnSpawn)
RegisterUnitEvent(19177,18,OnSpawn)
RegisterUnitEvent(19178,18,OnSpawn)
RegisterUnitEvent(20102,18,OnSpawn)
RegisterUnitGossipEvent(18927,1,OnGossip)
RegisterUnitGossipEvent(19148,1,OnGossip)
RegisterUnitGossipEvent(19169,1,OnGossip)
RegisterUnitGossipEvent(19171,1,OnGossip)
RegisterUnitGossipEvent(19172,1,OnGossip)
RegisterUnitGossipEvent(19173,1,OnGossip)
RegisterUnitGossipEvent(19175,1,OnGossip)
RegisterUnitGossipEvent(19176,1,OnGossip)
RegisterUnitGossipEvent(19177,1,OnGossip)
RegisterUnitGossipEvent(19178,1,OnGossip)
RegisterUnitGossipEvent(20102,1,OnGossip)
RegisterUnitGossipEvent(18927,18,2,OnGossip_Submenus)
RegisterUnitGossipEvent(19148,18,2,OnGossip_Submenus)
RegisterUnitGossipEvent(19169,18,2,OnGossip_Submenus)
RegisterUnitGossipEvent(19171,18,2,OnGossip_Submenus)
RegisterUnitGossipEvent(19172,18,2,OnGossip_Submenus)
RegisterUnitGossipEvent(19173,18,2,OnGossip_Submenus)
RegisterUnitGossipEvent(19175,18,2,OnGossip_Submenus)
RegisterUnitGossipEvent(19176,18,2,OnGossip_Submenus)
RegisterUnitGossipEvent(19177,18,2,OnGossip_Submenus)
RegisterUnitGossipEvent(19178,18,2,OnGossip_Submenus)
RegisterUnitGossipEvent(20102,18,2,OnGossip_Submenus)

