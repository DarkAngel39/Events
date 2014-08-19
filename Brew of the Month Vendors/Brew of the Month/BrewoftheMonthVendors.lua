local NPC_ENTRY = {27806,27810,27811,27812,27813,27814,27815,27816,27817,27818,27819,27820}
local DATA = {
{1,1475.8,-4210.23,775,49673},
{0,-4843.8,-861.92,774,49672}
}
local text1 = "What do you have for me?" -- 9548
local text2 = "I''d like to buy this month''s brew." -- 9549
 -- 13155 -- 9549
 -- 12863 -- 9548

function OnLoad(pUnit)
local map = pUnit:GetMapId()
local x = pUnit:GetX()
local y = pUnit:GetY()
for i = 1,#DATA do
	if(map == DATA[i][1] and x >= DATA[i][2] + 300 and x <= DATA[i][2] - 300 and y >= DATA[i][3] + 300 and y <= DATA[i][3] - 300)then
		pUnit:SetFaction(DATA[i][4])
		pUnit:CastSpell(DATA[i][5])
	end
end
end

function OnTalk(pUnit, event, pPlayer)
if(pPlayer:HasFinishedQuest(12420) or pPlayer:HasFinishedQuest(12421))then
	pUnit:GossipCreateMenu(12863, pPlayer, 0)
	if(pPlayer:HasItem(37829))then
		pUnit:GossipMenuAddItem(1, text1, 1, 0)
	end
	pUnit:GossipSendMenu(pPlayer)
else
	pUnit:GossipCreateMenu(13155, pPlayer, 0)
	pUnit:GossipSendMenu(pPlayer)
end
end

local function OnSelect(pUnit, event, pPlayer, id, intid, code)
if(intid == 1)then
	pPlayer:SendVendorWindow(pUnit)
end
end

for i = 1,#NPC_ENTRY do
RegisterUnitEvent(NPC_ENTRY[i],18,OnLoad)
RegisterUnitGossipEvent(NPC_ENTRY[i],1,OnTalk)
RegisterUnitGossipEvent(NPC_ENTRY[i],2,OnSelect)
end
