local mod	= DBM:NewMod("DemonInvasions", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 1705)--Azsuna ID so far

mod:RegisterEvents(
	"SPELL_CAST_START 238005",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"RAID_BOSS_WHISPER"
)
mod.onlyNormal = true

--local warnRumblingSlam			= mod:NewSpellAnnounce(223420, 2)

local specWarnBombardment			= mod:NewSpecialWarningDodge(235085, nil, nil, nil, 3, 2)
local specWarnCataclysmicForceNova	= mod:NewSpecialWarningDodge(238005, nil, nil, nil, 4, 2)

local timerBombardmentCD			= mod:NewCDTimer(70, 235085, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--70-90
--local timerCataclysmicForceNovaCD	= mod:NewCDTimer(70, 238005, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

--local countdownCharredFlesh			= mod:NewCountdownFades(17, 218657)

local voiceBombardment				= mod:NewVoice(235085)--watchstep
local voiceCataclysmicForceNova		= mod:NewVoice(238005)--runout

mod:RemoveOption("HealthFrame")
--mod:AddRangeFrameOption(6, 224044)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 238005 then
		specWarnCataclysmicForceNova:Show()
		voiceCataclysmicForceNova:Play("runout")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 118975 then--Xeritas
		--timerCataclysmicForceNovaCD:Stop()
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:235085") then
		specWarnBombardment:Show()
		voiceBombardment:Play("watchstep")
		--timerBombardmentCD:Start()
	end
end
