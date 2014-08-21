local option_data = {
{12083,"Do I get a free mount?",1,12084},
{12083,"How do I make my ram go faster?",2,12085},
{12083,"What's with the different speeds?",3,12086},
{12083,"Can I tire my ram out?",4,12087},
{12083,"That all sounds very complicated...",5,12088},
{12083,"Say, you wouldn't happen to have an extra set of reins...",6,-1},
{12084,"I have another question.",7,12083},
{12084,"Say, you wouldn't happen to have an extra set of reins...",8,-1},
{12085,"I have another question.",9,12083},
{12086,"I have another question.",10,12083},
{12087,"I have another question.",11,12083},
{12088,"I have another question.",12,12083}
}

local SPELL_RAM_CREATE = 44262

function OnGossip(pUnit, event, pPlayer)
pUnit:GossipCreateMenu(12083, pPlayer, 0)
for i = 1,#option_data do
	if(option_data[i][1] == 12083)then
		pUnit:GossipMenuAddItem(0, option_data[i][2], option_data[i][3], 0)
	end
end
pUnit:GossipAddQuests(pPlayer)
pUnit:GossipSendMenu(pPlayer)
end

function OnSelect(pUnit, event, pPlayer, id, intid, code)
for i = 1,#option_data do
	if(intid == option_data[i][3] and option_data[i][4] > 0)then
		pUnit:GossipCreateMenu(option_data[i][4], pPlayer, 0)
		for k = 1,#option_data do
			if(option_data[k][1] == option_data[i][4])then
				pUnit:GossipMenuAddItem(0, option_data[k][2], option_data[k][3], 0)
			end
		end
		pUnit:GossipSendMenu(pPlayer)
	elseif(intid == option_data[i][3] and option_data[i][4] == -1)then
		pPlayer:CastSpell(SPELL_RAM_CREATE)
		pPlayer:GossipComplete()
	end
end
end

RegisterUnitGossipEvent(24510,1,OnGossip)
RegisterUnitGossipEvent(24510,2,OnSelect)
RegisterUnitGossipEvent(24468,1,OnGossip)
RegisterUnitGossipEvent(24468,2,OnSelect)
