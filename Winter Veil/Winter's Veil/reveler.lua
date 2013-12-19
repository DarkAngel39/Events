local NPC_REVELER = 15760
local SPELL_MISTLETOE = 26218
local SPELL_C_SNOWFLAKE = 45036
local SPELL_C_MISTLETOE = 26206
local SPELL_C_FRESHHOLY = 26207

function OnEmote(event, pPlayer, pUnit, EmoteId)
if(EmoteId == 17)then
	local reveler = pPlayer:GetSelection()
	if(reveler ~= nil and reveler:IsCreature())then
		if(reveler:GetEntry() == NPC_REVELER and pPlayer:HasAura(SPELL_MISTLETOE) == false)then
			reveler:FullCastSpellOnTarget(SPELL_MISTLETOE,pPlayer)
		end
	end
end
end

function HandleMistletoe(spellIndex, pSpell)
local caster = pSpell:GetTarget()
	if(caster and caster:IsPlayer())then
		local aura = caster:GetAuraObjectById(SPELL_MISTLETOE)
		if(aura)then
			local cast = math.random(1,4) -- not sure about the actual drop chance.
			if(cast == 1)then
				caster:CastSpell(SPELL_C_SNOWFLAKE)
			elseif(cast == 2)then
				caster:CastSpell(SPELL_C_MISTLETOE)
			elseif(cast == 3)then
				caster:CastSpell(SPELL_C_FRESHHOLY)
			end
			aura:SetNegative(1)
		end
	end
end

RegisterServerHook(8, OnEmote)
RegisterDummySpell(SPELL_MISTLETOE, HandleMistletoe)
