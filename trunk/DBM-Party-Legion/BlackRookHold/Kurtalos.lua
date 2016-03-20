local mod	= DBM:NewMod(1672, "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98965, 98970)
mod:SetEncounterID(1835)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 198820 199143 199193",
	"SPELL_CAST_SUCCESS 198635",
	"SPELL_AURA_REMOVED 199193",
	"UNIT_DIED"
)

local warnCloud						= mod:NewSpellAnnounce(199143, 2)

local specWarnDarkblast				= mod:NewSpecialWarningDodge(198820, nil, nil, nil, 2)
local specWarnGuile					= mod:NewSpecialWarningDodge(199193, nil, nil, nil, 2)
local specWarnGuileEnded			= mod:NewSpecialWarningEnd(199193)

local timerDarkBlastCD				= mod:NewCDTimer(19, 198820, nil, nil, nil, 3)
local timerUnerringShearCD			= mod:NewCDTimer(13, 198635, nil, "Tank", nil, 5)
local timerGuileCD					= mod:NewCDTimer(39, 199193, nil, nil, nil, 6)
local timerGuile					= mod:NewBuffFadesTimer(24, 199193, nil, nil, nil, 6)
--local timerCloudCD					= mod:NewCDTimer(32.8, 199143, nil, nil, nil, 3)

--local voiceCurtainOfFlame			= mod:NewVoice(153392)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerUnerringShearCD:Start(6-delay)
	timerDarkBlastCD:Start(10-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 198635 then
		timerUnerringShearCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 199193 then
		specWarnGuileEnded:Show()
		timerGuileCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198820 then
		if self.vb.phase == 1 then
			timerDarkBlastCD:Start()
		end
	elseif spellId == 199143 then
		warnCloud:Show()
--		timerCloudCD:Start()
	elseif spellId == 199193 then
		specWarnGuile:Show()
		timerGuile:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 98965 then--Kur'talos Ravencrest
		self.vb.phase = 2
		timerDarkBlastCD:Stop()
		timerUnerringShearCD:Stop()
--		timerCloudCD:Start(12)
		timerGuileCD:Start(24)--24-28
	end
end
