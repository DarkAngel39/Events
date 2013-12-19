local ACHIEVEMENT_FROSTY = 1690
local SPELL_SNOWMAN = 21848
local ZONE_DALARAN = 4395

local SPELL_SNOWBALL = 21343
local NPC_BRONZE = 2784
local NPC_BLOODHOOF = 3057
local ACHIEVEMENT_SCROOGE_A = 1255
local ACHIEVEMENT_SCROOGE_H = 259

local SPELL_CAKE = 25990
local SPELL_WINTER_SET = 55000
local ACHIEVEMENT_SEASON = 277

function OnEmote(event, pPlayer, pUnit, EmoteId)
if(EmoteId == 10)then
	local plr = pPlayer:GetSelection()
	if(plr ~= nil and plr:IsPlayer())then
		if(plr:HasAura(SPELL_SNOWMAN) and pPlayer:HasAura(SPELL_SNOWMAN) and plr:GetZoneId() == ZONE_DALARAN and pPlayer:GetZoneId() == ZONE_DALARAN)then
			if(pPlayer:HasAchievement(ACHIEVEMENT_FROSTY) == false)then
				pPlayer:AddAchievement(ACHIEVEMENT_FROSTY)
			end
		end
	end
end
end

function HandleSnowball(spellIndex, pSpell)
local caster = pSpell:GetCaster()
local target = pSpell:GetTarget()
if(caster:IsPlayer() and target:IsCreature())then
	if(caster:GetTeam() == 0 and target:GetEntry() == NPC_BRONZE)then
		if(caster:HasAchievement(ACHIEVEMENT_SCROOGE_A) == false)then
			caster:AddAchievement(ACHIEVEMENT_SCROOGE_A)
		end
	elseif(caster:GetTeam() == 1 and target:GetEntry() == NPC_BLOODHOOF)then
		if(caster:HasAchievement(ACHIEVEMENT_SCROOGE_H) == false)then
			caster:AddAchievement(ACHIEVEMENT_SCROOGE_H)
		end
	end
end

end

function HandleCake(event, pPlayer, SpellId, pSpellObject)
if(SpellId == SPELL_CAKE and pPlayer:HasAura(SPELL_WINTER_SET) and pPlayer:HasAchievement(ACHIEVEMENT_SEASON) == false)then
	pPlayer:AddAchievement(ACHIEVEMENT_SEASON)
end
end

RegisterServerHook(8, OnEmote)
RegisterDummySpell(SPELL_SNOWBALL, HandleSnowball)
RegisterServerHook(10, HandleCake)
