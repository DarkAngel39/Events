local NPC_TOTEM = 26534
local NPC_GUIDE = 25324
local SPELL_FULL_MID_SET	= 58933
local SPELL_RIBBON_DANCE	= 29175 -- XP buff
local SPELL_DANCER_AURA		= 29531
local SPELL_RIBBON_POLE		= 29708
local SPELL_RIBBON_FLAME	= 45422
local SPELL_DANCER_CHECK	= 45390
local SPELL_DANCER_VISUAL	= 45406
local SPLL_RIBBON_ROPE		= 29726
local GO_RIBBON_POLE		= 181605
local NPC_RIBBON_POLE_BUNNY	= 17066

function OnLoad(pUnit)
pUnit:SpawnCreature(NPC_GUIDE, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(),35,36000,0,0,0,1,0)
end

RegisterUnitEvent(NPC_TOTEM,18,OnLoad)

function OnLoadPoleBunny(pUnit)
local pole = pUnit:GetGameObjectNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),GO_RIBBON_POLE)
if(pole)then
	local owner = pUnit:GetPetOwner()
	if(owner and owner:IsPlayer())then
		local x,y,z,_ = pole:GetSpawnLocation()
		pUnit:Teleport(x,y,z)
		-- pUnit:RegisterAIUpdateEvent(1000)
		owner:ChannelSpell(SPLL_RIBBON_ROPE, pUnit) 
	end
end
end

function AIUpdate(pUnit)
end

RegisterUnitEvent(NPC_RIBBON_POLE_BUNNY,18,OnLoadPoleBunny)