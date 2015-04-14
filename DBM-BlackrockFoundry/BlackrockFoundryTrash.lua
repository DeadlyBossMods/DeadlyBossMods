local mod	= DBM:NewMod("BlackrockFoundryTrash", "DBM-BlackrockFoundry")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 156446 163194 171537",
	"SPELL_AURA_APPLIED 175583 175594 175765 175993 177855 159750",
	"SPELL_AURA_APPLIED_DOSE 175594",
	"SPELL_AURA_REMOVED 159750",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnLivingBlaze				= mod:NewTargetAnnounce(175583, 3, nil, false)
local warnEmberInWind				= mod:NewTargetAnnounce(177855, 3, nil, false)
local warnBlastWaves				= mod:NewCountAnnounce(159750, 4)--On mythic the miniboss casts 3 of them in a row at different locations, 3 seconds apart. Basically sindragosa

local specWarnOverheadSmash			= mod:NewSpecialWarningTaunt(175765)
local specWarnBlastWave				= mod:NewSpecialWarningMoveTo(156446, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(156446))
local specWarnInsatiableHunger		= mod:NewSpecialWarningRun(159632, nil, nil, nil, 4)
local specWarnLumberingStrength		= mod:NewSpecialWarningRun("OptionVersion2", 175993, "Tank", nil, nil, 4)
local specWarnLivingBlaze			= mod:NewSpecialWarningMoveAway(175583)
local yellLivingBlaze				= mod:NewYell(175583)
local specWarnEmberInWind			= mod:NewSpecialWarningMoveAway(177855)
local specWarnFinalFlame			= mod:NewSpecialWarningDodge(163194, "MeleeDps")
local specWarnReapingWhirl			= mod:NewSpecialWarningDodge(171537, "MeleeDps")
local specWarnBurning				= mod:NewSpecialWarningStack(175594, nil, 8)
local specWarnBurningOther			= mod:NewSpecialWarningTaunt(175594, nil, nil, nil, nil, nil, 2)

local voiceBurning					= mod:NewVoice(155242) --changemt

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local volcanicBomb = GetSpellInfo(156413)
local blastCount = 0--Non synced variable, because mods that don't use start/endcombat don't have timer recovery

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 156446 then
		specWarnBlastWave:Show(volcanicBomb)
	elseif spellId == 163194 then
		specWarnFinalFlame:Show()
	elseif spellId == 171537 then
		specWarnReapingWhirl:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 175583 then
		warnLivingBlaze:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnLivingBlaze:Show()
			if not self:IsLFR() then
				yellLivingBlaze:Yell()
			end
		end
	elseif spellId == 177855 then
		warnEmberInWind:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnEmberInWind:Show()
		end
	elseif spellId == 175594 then
		local amount = args.amount or 1
		if (amount >= 8) and (amount % 3 == 0) then
			voiceBurning:Play("changemt")
			if args:IsPlayer() then
				specWarnBurning:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(175594)) and not UnitIsDeadOrGhost("player") then
					specWarnBurningOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 175765 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			specWarnOverheadSmash:Show(args.destName)
		end
	elseif spellId == 175993 then
		specWarnLumberingStrength:Show()
	elseif spellId == 159750 then--Mythic version (Blast Waves)
		DBM:HideBlizzardEvents(1)--Blizzards frame completely covers dbms warnings here and stays on screen forever, so disable the stupid thing.
		blastCount = 0
		specWarnBlastWave:Show(volcanicBomb)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 159750 then--Mythic version (Blast Waves)
		DBM:HideBlizzardEvents(0)
	end
end

--[[
--Boss Gains Blast Waves
"<95.97 22:11:12> [CLEU] SPELL_AURA_APPLIED#Creature-0-3137-1205-5634-77504-000014A9AF#Slag Behemoth#Creature-0-3137-1205-5634-77504-000014A9AF#Slag Behemoth#159750#Blast Waves#BUFF#nil", -- [1429]
--Boss Casts First Wave
"<99.06 22:11:15> [UNIT_SPELLCAST_SUCCEEDED] Slag Behemoth(Shiramura) target:Blast Waves::0:159751", -- [1506]
--Boss Casts Second Wave
"<102.03 22:11:18> [UNIT_SPELLCAST_SUCCEEDED] Slag Behemoth(Shiramura) target:Blast Waves::0:159751", -- [1570]
--First wave hits
"<104.05 22:11:20> [CLEU] SPELL_DAMAGE#Creature-0-3137-1205-5634-77504-000014A9AF#Slag Behemoth#Player-55-05730E16#Torima#159752#Blast Waves#227543#-1", -- [1595]
--Boss Casts 3rd and final wave
"<104.99 22:11:21> [UNIT_SPELLCAST_SUCCEEDED] Slag Behemoth(Shiramura) target:Blast Waves::0:159755", -- [1625]
--Boss Loses Blast Waves
"<104.99 22:11:21> [CLEU] SPELL_AURA_REMOVED#Creature-0-3137-1205-5634-77504-000014A9AF#Slag Behemoth#Creature-0-3137-1205-5634-77504-000014A9AF#Slag Behemoth#159750#Blast Waves#BUFF#nil", -- [1627]
--Second wave hits
"<106.99 22:11:23> [CLEU] SPELL_MISSED#Creature-0-3137-1205-5634-77504-000014A9AF#Slag Behemoth#Player-55-078511B6#Metsuki#159752#Blast Waves#IMMUNE#false", -- [1665]
--Third wave hits
"<109.00 22:11:25> [CLEU] SPELL_MISSED#Creature-0-3137-1205-5634-77504-000014A9AF#Slag Behemoth#Player-55-036B2A5B#Ikatus#159757#Blast Waves#IMMUNE#false", -- [1720]
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 159751 or spellId == 159755) and self:AntiSpam(1.5, 1) then--Sub casts don't show in combat log. Block players who do not pass latency check from sending sync since have to set threshold so low
		blastCount = blastCount + 1
		warnBlastWaves:Show(blastCount)
	end
end

function mod:RAID_BOSS_WHISPER(msg, count)
	if not self.Options.Enabled then return end
	if msg:find("spell:159632") then
		specWarnInsatiableHunger:Show()
	end
end
