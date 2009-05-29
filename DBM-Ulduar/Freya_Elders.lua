local mod = DBM:NewMod("Freya_Elders", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1114 $"):sub(12, -3))
mod:SetZone()

-- passive mod to provide information for multiple fight (trash respawn)
-- mod:SetCreatureID(32914, 32915, 32913)
-- mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"UNIT_DIED"
)

mod:AddBoolOption("PlaySoundOnFistOfStone", false)
local specWarnFistofStone	= mod:NewSpecialWarning("specWarnFistofStone", false)
local specWarnGroundTremor	= mod:NewSpecialWarning("specWarnGroundTremor", true)
local timerTrashRespawn		= mod:NewTimer(7200, "TimerTrashRespawn")

--
-- Trash: 33430 Guardian Lasher (so ne blume)
-- 33355 (nymphe)
-- 33354 (baum)
--
-- Elder Stonebark (ground tremor / fist of stone)
-- Elder Brightleaf (unstable sunbeam)
--
--Mob IDs:
-- Elder Ironbranch: 32913
-- Elder Brightleaf: 32915
-- Elder Stonebark: 32914
--

function mod:SPELL_CAST_START(args)
	if args.spellId == 62344 then 						-- Fists of Stone
		specWarnFistofStone:Show()
		if self.Options.PlaySoundOnFistOfStone then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	elseif args.spellId == 62325 or args.spellId == 62932 then		-- Ground Tremor
		specWarnGroundTremor:Show()
	end
		-- Petrified Bark (not required)

end

function mod:UNIT_DIED(args)
	if self.Options.TrashRespawnTimer and not DBM.Bars:GetBar(L.TrashRespawnTimer) then
		local guid = tonumber(args.destGUID:sub(9, 12), 16)
		if guid == 33430 or guid == 33355 or guid == 33354 then		-- guardian lasher / nymphe / tree
			timerTrashRespawn:Start()
		end
	end
end

