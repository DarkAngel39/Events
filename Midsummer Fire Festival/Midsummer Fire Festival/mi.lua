local NPC_TOTEM = 26534
local NPC_GUIDE = 25324

function OnLoad(pUnit)
pUnit:SpawnCreature(NPC_GUIDE, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(),35,36000,0,0,0,1,0)
end

RegisterUnitEvent(NPC_TOTEM,18,OnLoad)