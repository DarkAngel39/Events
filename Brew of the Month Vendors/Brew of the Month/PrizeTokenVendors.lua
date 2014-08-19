local NPC_INFO = {
{27478,12864,"What do you have for me?"},
{27489,12867,"What do you have for me?"}
}

function OnTalk(pUnit, event, pPlayer)
for i = 1, #NPC_INFO do
if(pUnit:GetEntry() == NPC_INFO[i][1])then
	if(pPlayer:HasItem(37829))then
		pUnit:GossipCreateMenu(NPC_INFO[i][2], pPlayer, 0)
		pUnit:GossipMenuAddItem(0, NPC_INFO[i][4], 1, 0)
		pUnit:GossipAddQuests(pPlayer)
		pUnit:GossipSendMenu(pPlayer)
	else
		pUnit:GossipCreateMenu(12863, pPlayer, 0)
		pUnit:GossipAddQuests(pPlayer)
		pUnit:GossipSendMenu(pPlayer)
	end
end
end
end

function OnSelect(pUnit, event, pPlayer, id, intid, code)
if(intid == 1)then
	pPlayer:SendVendorWindow(pUnit)
end
end

for i = 1, #NPC_INFO do
RegisterUnitGossipEvent(NPC_INFO[i][1],1,OnTalk)
RegisterUnitGossipEvent(NPC_INFO[i][1],2,OnSelect)
end
