local NPC_ENTRY = {27806,27810,27811,27812,27813,27814,27815,27816,27817,27818,27819,27820}
local DATA = {
{14,1637,775,49673,},
{1,1537,774,49672}
}

local text = "I'd like to buy this month's brew."

function OnLoad(pUnit)
pUnit:SetNPCFlags(129)
local zone = pUnit:GetZoneId()
for i = 1,#DATA do
	if(zone == DATA[i][1] or zone == DATA[i][2])then
		pUnit:SetFaction(DATA[i][3])
		pUnit:CastSpell(DATA[i][4])
	end
end
end

function OnTalk(pUnit, event, pPlayer)
pUnit:GossipCreateMenu(13155, pPlayer, 0)
if(pPlayer:HasFinishedQuest(12420) or pPlayer:HasFinishedQuest(12421))then
	pUnit:GossipMenuAddItem(1, text, 1, 0)
end
pUnit:GossipSendMenu(pPlayer)
end

function OnSelect(pUnit, event, pPlayer, id, intid, code)
if(intid == 1)then
	pPlayer:SendVendorWindow(pUnit)
end
end

for i = 1,#NPC_ENTRY do
RegisterUnitEvent(NPC_ENTRY[i],18,OnLoad)
RegisterUnitGossipEvent(NPC_ENTRY[i],1,OnTalk)
RegisterUnitGossipEvent(NPC_ENTRY[i],2,OnSelect)
end
