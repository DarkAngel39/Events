local entry = {18927,19148,19169,19171,19172,19173,19175,19176,19177,19178,20102}
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

for i = 1,#entry do
RegisterUnitEvent(entry[i],18,OnSpawn)
RegisterUnitGossipEvent(entry[i],1,OnGossip)
RegisterUnitGossipEvent(entry[i],18,2,OnGossip_Submenus)
end
