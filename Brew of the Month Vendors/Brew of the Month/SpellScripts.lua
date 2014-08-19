local SPELL_DATA = {42256,42255,42254,43961,42263,42257,43959,42264,42259,42260,42258,42261}
local SPELL_EMPTY = 51655

function OnCast(event, pPlayer, SpellId, pSpellObject)
for i = 1, #SPELL_DATA do
	if(SPELL_DATA[i] == SpellId)then
		pPlayer:FullCastSpell(SPELL_EMPTY)
	end
end
end

RegisterServerHook(10, OnCast)
