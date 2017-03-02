local mod	= DBM:NewMod("NightholdTrash", "DBM-Nighthold")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 221164 224510 224246 231005 143807 231737",
	"SPELL_CAST_SUCCESS 225389",
	"SPELL_AURA_APPLIED 221344 222111 224572 225390 224632 224560 204744 224978 225856 223655 224982 225105 222079",
	"SPELL_AURA_APPLIED_DOSE 222079"
)

--TODO, add arcane blast when i remember to log/get spellID
local warnAnnihilatingOrb			= mod:NewTargetAnnounce(221344, 3)
local warnCelestialBrand			= mod:NewTargetAnnounce(224560, 2)
local warnArcaneRelease				= mod:NewTargetAnnounce(225105, 2)
local warnOozingRush				= mod:NewTargetAnnounce(223655, 2)
local warnFelGlare					= mod:NewTargetAnnounce(224982, 2)

local specWarnAnnihilatingOrb		= mod:NewSpecialWarningMoveAway(221344, nil, nil, nil, 1, 2)
local yellAnnihilatingOrb			= mod:NewYell(221344)
local specWarnFulminate				= mod:NewSpecialWarningRun(221164, "Melee", nil, nil, 4, 2)
local specWarnCracklingSlice		= mod:NewSpecialWarningDodge(224510, "Tank", nil, nil, 1, 2)
local specWarnArcaneEmanations		= mod:NewSpecialWarningDodge(231005, "Tank", nil, nil, 1, 2)
local specWarnProtectiveShield		= mod:NewSpecialWarningMove(224510, "Tank", nil, nil, 1, 2)
local specWarnRoilingFlame			= mod:NewSpecialWarningMove(222111, nil, nil, nil, 1, 2)
local specWarnDisruptingEnergy		= mod:NewSpecialWarningMove(224572, nil, nil, nil, 1, 2)
local specWarnStellarDust			= mod:NewSpecialWarningMove(225390, nil, nil, nil, 1, 2)
local specWarnToxicChit				= mod:NewSpecialWarningMove(204744, nil, nil, nil, 1, 2)
local specWarnInfiniteAbyss			= mod:NewSpecialWarningMove(224978, nil, nil, nil, 1, 2)
local specWarnPoisonBrambles		= mod:NewSpecialWarningMove(225856, nil, nil, nil, 1, 2)
local specWarnArcWell				= mod:NewSpecialWarningSwitch(224246, "Dps", nil, nil, 1, 6)
local specWarnCelestialBrand		= mod:NewSpecialWarningMoveAway(224560, nil, nil, nil, 1, 2)
local yellCelestialBrand			= mod:NewYell(224560)
local specWarnArcaneRelease			= mod:NewSpecialWarningMoveAway(225105, nil, nil, nil, 1, 2)
local specWarnArcaneBlast			= mod:NewSpecialWarningInterrupt(143807, "HasInterrupt", nil, nil, 1, 2)
local yellArcaneRelease				= mod:NewYell(225105)
local specWarnHeavenlyCrash			= mod:NewSpecialWarningMoveTo(224632, nil, nil, nil, 1, 2)
local yellHeavenlyCrash				= mod:NewFadesYell(224632)--VERIFY duration
local specWarnOozingRush			= mod:NewSpecialWarningRun(223655, nil, nil, nil, 4, 2)
local yellOozingRush				= mod:NewYell(223655)
local specWarnFelGlare				= mod:NewSpecialWarningMoveAway(224982, nil, nil, nil, 1, 2)
local yellFelGlareh					= mod:NewYell(224982)
local specWarnSearingWounds			= mod:NewSpecialWarningStack(222079, nil, 4, nil, 2, 1, 2)--Lets go with 4 for now
local specWarnSearingWoundsOther	= mod:NewSpecialWarningTaunt(222079, nil, nil, nil, 1, 2)
local specWarnNightwellDischarge	= mod:NewSpecialWarningDodge(231737, nil, nil, nil, 1, 2)

local timerSearingWounds				= mod:NewTargetTimer(20, 222079, nil, "Tank", nil, 5)

local voiceAnnihilatingOrb			= mod:NewVoice(221344)--runout
local voiceFulminate				= mod:NewVoice(221164, "Melee")--runout
local voiceCracklingSlice			= mod:NewVoice(224510, "Tank")--shockwave
local voiceArcaneEmanations			= mod:NewVoice(231005, "Tank")--shockwave
local voiceProtectiveShield			= mod:NewVoice(225389)--bossout
local voiceRoilingFlame				= mod:NewVoice(222111)--runaway
local voiceDisruptingEnergy			= mod:NewVoice(224572)--runaway
local voiceStellarDust				= mod:NewVoice(225390)--runaway
local voiceToxicChit				= mod:NewVoice(204744)--runaway
local voiceInfiniteAbyss			= mod:NewVoice(224978)--runaway
local voicePoisonBrambles			= mod:NewVoice(225856)--runaway
local voiceArcWell					= mod:NewVoice(224246)--killtotem
local voiceCelestialBrand			= mod:NewVoice(224560)--runout
local voiceArcaneRelease			= mod:NewVoice(225105)--runout
local voiceArcaneBlast				= mod:NewVoice(143807, "HasInterrupt")--kickcast
local voiceHeavenlyCrash			= mod:NewVoice(224632)--gathershare
local voiceOozingRush				= mod:NewVoice(223655)--runaway/keepmove
local voiceFelGlare					= mod:NewVoice(224982)--runout/keepmove
local voiceSearingWounds				= mod:NewVoice(222079)--changemt
local voiceNightwellDischarge		= mod:NewVoice(231737)--watchorb

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 221164 and self:AntiSpam(5, 1) then
		specWarnFulminate:Show()
		voiceFulminate:Play("runout")
	elseif spellId == 224510 and self:AntiSpam(3, 2) then
		specWarnCracklingSlice:Show()
		voiceCracklingSlice:Play("shockwave")
	elseif spellId == 231005 then
		specWarnArcaneEmanations:Show()
		voiceArcaneEmanations:Play("shockwave")
	elseif spellId == 143807 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnArcaneBlast:Show(args.sourceName)
		voiceArcaneBlast:Play("kickcast")
	elseif spellId == 231737 and self:AntiSpam(4, 4) then
		specWarnNightwellDischarge:Show()
		voiceNightwellDischarge:Play("watchorb")
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
	elseif spellId == 204744 and args:IsPlayer() then
		specWarnToxicChit:Show()
		voiceToxicChit:Play("runaway")
	elseif spellId == 224978 and args:IsPlayer() then
		specWarnInfiniteAbyss:Show()
		voiceInfiniteAbyss:Play("runaway")
	elseif spellId == 225856 and args:IsPlayer() then
		specWarnPoisonBrambles:Show()
		voicePoisonBrambles:Play("runaway")
	elseif spellId == 224632 then
		specWarnHeavenlyCrash:Show(args.destName)
		voiceHeavenlyCrash:Play("gathershare")
		if args:IsPlayer() then
			yellHeavenlyCrash:Schedule(4, 1)
			yellHeavenlyCrash:Schedule(3, 2)
			yellHeavenlyCrash:Schedule(2, 3)
		end
	elseif spellId == 224560 then
		warnCelestialBrand:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnCelestialBrand:Show()
			voiceCelestialBrand:Play("runout")
			yellCelestialBrand:Yell()
		end
	elseif spellId == 225105 then
		warnArcaneRelease:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnArcaneRelease:Show()
			voiceArcaneRelease:Play("runout")
			yellArcaneRelease:Yell()
		end
	elseif spellId == 223655 then
		if args:IsPlayer() then
			specWarnOozingRush:Show()
			voiceOozingRush:Play("runaway")
			voiceOozingRush:Schedule(1, "keepmove")
			yellOozingRush:Yell()
		else
			warnOozingRush:Show(args.destName)
		end
	elseif spellId == 224982 then
		if args:IsPlayer() then
			specWarnFelGlare:Show()
			voiceFelGlare:Play("runout")
			voiceFelGlare:Schedule(1, "keepmove")
			yellFelGlareh:Yell()
		else
			warnFelGlare:Show(args.destName)
		end
	elseif spellId == 222079 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			timerSearingWounds:Start(args.destName)
			if amount >= 2 then
				if args:IsPlayer() then
					if amount >= 4 then
						specWarnSearingWounds:Show(amount)
						voiceSearingWounds:Play("stackhigh")
					end
				else
					if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
						specWarnSearingWoundsOther:Show(args.destName)
						voiceSearingWounds:Play("changemt")
					end
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
