local mod	= DBM:NewMod("NightholdTrash", "DBM-Nighthold")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 221164 224510 224246",
	"SPELL_CAST_SUCCESS 225389",
	"SPELL_AURA_APPLIED 221344 222111 224572 225390"
)

local warnAnnihilatingOrb			= mod:NewTargetAnnounce(221344, 3)

local specWarnAnnihilatingOrb		= mod:NewSpecialWarningMoveAway(221344, nil, nil, nil, 1, 2)
local yellAnnihilatingOrb			= mod:NewYell(221344)
local specWarnFulminate				= mod:NewSpecialWarningMoveTo(221164, "Melee", nil, nil, 4, 2)
local specWarnCracklingSlice		= mod:NewSpecialWarningDodge(224510, "Tank", nil, nil, 1, 2)
local specWarnProtectiveShield		= mod:NewSpecialWarningMove(224510, "Tank", nil, nil, 1, 2)
local specWarnRoilingFlame			= mod:NewSpecialWarningMove(222111, nil, nil, nil, 1, 2)
local specWarnDisruptingEnergy		= mod:NewSpecialWarningMove(224572, nil, nil, nil, 1, 2)
local specWarnStellarDust			= mod:NewSpecialWarningMove(225390, nil, nil, nil, 1, 2)
local specWarnArcWell				= mod:NewSpecialWarningSwitch(224246, "Dps", nil, nil, 1, 6)

local voiceAnnihilatingOrb			= mod:NewVoice(221344)--runout
local voiceFulminate				= mod:NewVoice(221164)--runout
local voiceCracklingSlice			= mod:NewVoice(224510)--shockwave
local voiceProtectiveShield			= mod:NewVoice(225389)--bossout
local voiceRoilingFlame				= mod:NewVoice(222111)--runaway
local voiceDisruptingEnergy			= mod:NewVoice(224572)--runaway
local voiceStellarDust				= mod:NewVoice(225390)--runaway
local voiceArcWell					= mod:NewVoice(224246)--killtotem (NYI)

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221164 and self:AntiSpam(3, 1) then
		specWarnFulminate:Show()
		voiceFulminate:Play("runout")
	elseif spellId == 224510 and self:AntiSpam(3, 2) then
		specWarnCracklingSlice:Show()
		voiceCracklingSlice:Play("shockwave")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 225389 and self:AntiSpam(3, 3) then
		specWarnProtectiveShield:Show()
		voiceProtectiveShield:Play("runout")
	elseif spellId == 224246 then
		specWarnArcWell:Show()
		voiceArcWell:Play("killtotem")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221344 then
		if args:IsPlayer() then
			specWarnAnnihilatingOrb:Show()
			voiceAnnihilatingOrb:Play("runout")
			yellAnnihilatingOrb:Yell()
		else
			warnAnnihilatingOrb:Show(args.destName)
		end
	elseif spellId == 222111 and args:IsPlayer() then
		specWarnRoilingFlame:Show()
		voiceRoilingFlame:Play("runaway")
	elseif spellId == 224572 and args:IsPlayer() then
		specWarnDisruptingEnergy:Show()
		voiceDisruptingEnergy:Play("runaway")
	elseif spellId == 225390 and args:IsPlayer() then
		specWarnStellarDust:Show()
		voiceStellarDust:Play("runaway")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
