local SPELL_GREEN_MALE = 26157
local SPELL_GREEN_FEMALE = 26272
local SPELL_RED_MALE = 26273
local SPELL_RED_FEMALE = 26274
local GO_TRAP = 180797
local areatrigger = {4026,4852,5310,4851,4028,4027,4032,4029}

function OnAreaTrigger_Buff(event, pPlayer, AreaTriggerId)
for i = 1, #areatrigger do
	if(AreaTriggerId == areatrigger[i])then
		local trap = pPlayer:GetGameObjectNearestCoords(pPlayer:GetX(),pPlayer:GetY(),pPlayer:GetZ(),GO_TRAP)
		if(trap and pPlayer:GetGender() == 0)then
			if(pPlayer:HasAura(SPELL_GREEN_MALE) == false and pPlayer:HasAura(SPELL_RED_MALE) == false)then
				local cast = math.random(1,2)
				if(cast == 1)then
					pPlayer:FullCastSpell(SPELL_GREEN_MALE)
				else
					pPlayer:FullCastSpell(SPELL_RED_MALE)
				end
			end
		elseif(trap and pPlayer:GetGender() == 1)then
			if(pPlayer:HasAura(SPELL_GREEN_FEMALE) == false and pPlayer:HasAura(SPELL_RED_FEMALE) == false)then
				local cast1 = math.random(1,2)
				if(cast1 == 1)then
					pPlayer:FullCastSpell(SPELL_GREEN_FEMALE)
				else
					pPlayer:FullCastSpell(SPELL_RED_FEMALE)
				end
			end
		end
	end
end
end

RegisterServerHook(26, OnAreaTrigger_Buff)
