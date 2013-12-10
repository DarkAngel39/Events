local GAMEOBJECT_BYTES_1 = 0x0006 + 0x000B
local bonfire_data = {
{187559, 1},
{187564, 0},
{187914, 0},
{187916, 0},
{187917, 0},
{187919, 0},
{187920, 0},
{187921, 0},
{187922, 0},
{187923, 0},
{187924, 0},
{187925, 0},
{187926, 0},
{187927, 0},
{187928, 0},
{187929, 0},
{187930, 0},
{187931, 0},
{187932, 0},
{187933, 0},
{187934, 0},
{187935, 0},
{187936, 0},
{187937, 0},
{187938, 0},
{187939, 0},
{187940, 0},
{187941, 0},
{187942, 0},
{187943, 0},
{187944, 0},
{187945, 0},
{187946, 0},
{187947, 1},
{187948, 1},
{187949, 1},
{187950, 1},
{187951, 1},
{187952, 1},
{187953, 1},
{187954, 1},
{187955, 1},
{187956, 1},
{187957, 1},
{187958, 1},
{187959, 1},
{187960, 1},
{187961, 1},
{187962, 1},
{187963, 1},
{187964, 1},
{187965, 1},
{187966, 1},
{187967, 1},
{187968, 1},
{187969, 1},
{187970, 1},
{187971, 1},
{187972, 1},
{187973, 1},
{187974, 1},
{187975, 1},
{194032, 0},
{194033, 1},
{194034, 1},
{194035, 0},
{194036, 0},
{194037, 1},
{194038, 0},
{194039, 1},
{194040, 0},
{194042, 1},
{194043, 1},
{194044, 0},
{194045, 0},
{194046, 1},
{194048, 1},
{194049, 0};
};

function OnLoad(pGO)
pGO:SetByte(GAMEOBJECT_BYTES_1,2,121)
end

function OnUse(pGO, event, pPlayer)
for i = 1, #bonfire_data do
	if(bonfire_data[i][1] == pGO:GetEntry())then
		if(pPlayer:GetTeam() ~= bonfire_data[i][2] and pGO:GetByte(GAMEOBJECT_BYTES_1,2) == 121)then
			pGO:SetByte(GAMEOBJECT_BYTES_1,2,122)
			pGO:RegisterAIUpdateEvent(6000)
		end
	end
end
end

function AIUpdate(pGO)
pGO:SetByte(GAMEOBJECT_BYTES_1,2,121)
pGO:RemoveAIUpdateEvent()
end

for i = 1, #bonfire_data do
RegisterGameObjectEvent(bonfire_data[i][1],2,OnLoad)
RegisterGameObjectEvent(bonfire_data[i][1],4,OnUse)
RegisterGameObjectEvent(bonfire_data[i][1],5,AIUpdate)
end
