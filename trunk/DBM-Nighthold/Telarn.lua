local mod	= DBM:NewMod(1761, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104528)--109042
mod:SetEncounterID(1886)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 218438 218463 218466 218470 218148 218806 218774 219049 218927",
	"SPELL_CAST_SUCCESS 218424",
	"SPELL_AURA_APPLIED 218809 218503 218304 219009",
	"SPELL_AURA_APPLIED_DOSE 218503",
	"SPELL_AURA_REMOVED 218809 218304",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_HEALTH target focus mouseover"
)

--TODO. see how many CoN go out and auto assign soakers for it. I bet it's 2 melee 2 ranged and 1 healer. Redo icons accordingly
--TODO, verify target scanning.
--TODO, flare? wtf? tooltip is either wrong or boss has one useless insigificant spell
--TODO, adjust 15% on stars if it's too low/high. 25% was used on algalon for reference
--TODO, see if images can be tanked really far apart from one another to split the mechanics (dark shaman strat. Not that it's even remotely practical here, merely for science)
--Stage 1: The High Botanist
local warnRecursiveStrikes			= mod:NewStackAnnounce(218809, 2, nil, "Tank")
local warnControlledChaos			= mod:NewCountAnnounce(218438, 3)
local warnParasiticFetter			= mod:NewTargetAnnounce(218304, 3)
local warnSolarCollapse				= mod:NewTargetAnnounce(218148, 3)--target scanning assumed
--Stage 2: Nightosis
local warnFlare						= mod:NewSpellAnnounce(218806, 2, nil, "Tank")
local warnPlasmaSpheres				= mod:NewSpellAnnounce(218774, 2)
--Stage 3: Pure Forms
local warnToxicSpores				= mod:NewSpellAnnounce(219049, 3)
local warnCoN						= mod:NewTargetAnnounce(218809, 4)
local warnGraceofNature				= mod:NewTargetAnnounce(218927, 4, nil, "Tank")

--Stage 1: The High Botanist
local specWarnRecursiveStrikes		= mod:NewSpecialWarningTaunt(218809, nil, nil, nil, 1, 2)
local specWarnControlledChaos		= mod:NewSpecialWarningDodge(218438, nil, nil, nil, 2, 2)
local specWarnLasher				= mod:NewSpecialWarningSwitch("ej13699", "RangedDps", nil, nil, 1, 2)
local yellParasiticFetter			= mod:NewYell(218304)
local specWarnParasiticFetter		= mod:NewSpecialWarningClose(218304, nil, nil, nil, 1, 2)
local specWarnSolarCollapse			= mod:NewSpecialWarningYou(218148, nil, nil, nil, 1, 2)
local yellSolarCollapse				= mod:NewYell(218148)
local specWarnSolarCollapseNear		= mod:NewSpecialWarningClose(218148, nil, nil, nil, 1, 2)
--Stage 2: Nightosis
local specwarnStarLow				= mod:NewSpecialWarning("warnStarLow", "Tank|Healer", nil, nil, 2)--aesoon?
--Stage 3: Pure Forms
local specWarnGraceOfNature			= mod:NewSpecialWarningTarget(218927, "Tank", nil, nil, 3, 2)
local specWarnCoN					= mod:NewSpecialWarningYouPos(218809, nil, nil, nil, 1, 5)
local yellCoN						= mod:NewPosYell(218809)

--Stage 1: The High Botanist
local timerControlledChaosCD		= mod:NewAITimer(16, 218438, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerParasiticFetterCD		= mod:NewAITimer(16, 218304, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)--Technically can also be made add timer instead of targetted
local timerSolarCollapseCD			= mod:NewAITimer(16, 218148, nil, nil, nil, 3)
--Stage 2: Nightosis
local timerPlasmaSpheresCD			= mod:NewAITimer(16, 218774, nil, nil, nil, 1)

--Stage 3: Pure Forms
local timerToxicSporesCD			= mod:NewAITimer(16, 219049, nil, nil, nil, 3)
local timerGraceOfNatureCD			= mod:NewAITimer(16, 218927, nil, "Tank", nil, 5)
--local timerCoNCD					= mod:NewCDTimer(16, 218809, nil, nil, nil, 3)--Probably only cast once after phase change so no AI timer

--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)

--Stage 1: The High Botanist
local voiceRecursiveStrikes			= mod:NewVoice(218809)--tauntboss
local voiceControlledChaos			= mod:NewVoice(218438)--watchstep
local voiceLasher					= mod:NewVoice("ej13699", "RangedDps")--killmob
local voiceParasiticFetter			= mod:NewVoice(218304)--runaway
local voiceSolarCollapseNear		= mod:NewVoice(218148)--runaway
--Stage 2: Nightosis

--Stage 3: Pure Forms
local voiceGraceOfNature			= mod:NewVoice(218927, "Tank")--bossout
local voiceCoN						= mod:NewVoice(218809)--mmX

mod:AddRangeFrameOption(8, 218807)
mod:AddSetIconOption("SetIconOnCoN", 218807, true)
mod:AddHudMapOption("HudMapOnCoN", 218807)

mod.vb.CoNIcon = 1

local sentLowHP = {}
local warnedLowHP = {}
local UnitDebuff = UnitDebuff
local callOfNightName = GetSpellInfo(218809)
local hasCoN, noCoN
do
	--hasCoN not used
	hasCoN = function(uId)
		if UnitDebuff(uId, callOfNightName) then
			return true
		end
	end
	noCoN = function(uId)
		if not UnitDebuff(uId, callOfNightName) then
			return true
		end
	end
end

function mod:SolarCollapseTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSolarCollapse:Show()
		yellSolarCollapse:Yell()
	elseif self:CheckNearby(8, targetname) then
		specWarnSolarCollapseNear:Show(targetname)
		voiceSolarCollapseNear:Play("runaway")
	else
		warnSolarCollapse:Show(targetname)
	end
end

function mod:GraceofNatureTarget(targetname)
	if not targetname then return end
	warnGraceofNature:Show(targetname)
end

function mod:OnCombatStart(delay)
	table.wipe(sentLowHP)
	table.wipe(warnedLowHP)
	self.vb.CoNIcon = 1
	timerControlledChaosCD:Start(1-delay)
	timerParasiticFetterCD:Start(1-delay)
	timerSolarCollapseCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnCoN then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 218438 then--Primary cast?
		specWarnControlledChaos:Show()
		voiceControlledChaos:Play("watchstep")
		timerControlledChaosCD:Start()
	elseif spellId == 218463 then--(10)
		warnControlledChaos:Show(10)
	elseif spellId == 218466 then--(20)
		warnControlledChaos:Show(20)
	elseif spellId == 218470 then--(30)
		warnControlledChaos:Show(30)
	elseif spellId == 218148 then
		self:BossTargetScanner(args.sourceGUID, "SolarCollapseTarget", 0.1, 16, true)
		timerSolarCollapseCD:Start()
	elseif spellId == 218806 then
		warnFlare:Show()
	elseif spellId == 218774 then
		warnPlasmaSpheres:Show()
		timerPlasmaSpheresCD:Start()
	elseif spellId == 219049 then
		warnToxicSpores:Show()
		timerToxicSporesCD:Start()
	elseif spellId == 218927 then
		self:BossTargetScanner(args.sourceGUID, "GraceofNatureTarget", 0.1, 16, true, true)
		timerGraceOfNatureCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 218424 then
		timerParasiticFetterCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 218809 then
		warnCoN:CombinedShow(0.5, args.destName)
		self.vb.CoNIcon = self.vb.CoNIcon + 1
		local number = self.vb.CoNIcon
		if self.Options.HudMapOnCoN then
			if args:IsPlayer() then
				DBMHudMap:RegisterRangeMarkerOnPartyMember(2188092, "party", UnitName("player"), 0.9, 1200, nil, nil, nil, 1, nil, false):Appear()
			else
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 8, 1200, nil, nil, nil, 0.5):Appear():RegisterForAlerts(nil, args.destName)
			end
		end
		if args:IsPlayer() then
			specWarnCoN:Show(self:IconNumToString(number))
			yellCoN:Yell(self:IconNumToString(number), number, number)
			voiceCoN:Play("mm"..number)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8, noCoN, nil, true)
				DBM:AddMsg(L.RadarMessage)
			end
		end
		if self.Options.SetIconOnCoN and number < 9 then--Set icons on first 8, after that less clear
			self:SetIcon(args.destName, number)
		end
	elseif spellId == 218503 then
		local amount = args.amount or 1
		if amount % 2 == 0 or amount > 5 then
			warnRecursiveStrikes:Show(args.destName, amount)
			if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") and self:AntiSpam(3, 6) then
				specWarnRecursiveStrikes:Show(args.destName)
				voiceRecursiveStrikes:Play("tauntboss")
			end
		end
	elseif spellId == 218304 then
		if args:IsPlayer() then
			yellParasiticFetter:Yell()
		end
		if self:CheckNearby(20, args.destName) then
			specWarnParasiticFetter:Show(args.destName)
			voiceParasiticFetter:Play("runaway")
		else
			warnParasiticFetter:Show(args.destName)
		end
	elseif spellId == 219009 then
		local targetName = args.destName
		if targetName == UnitName("target") or targetName == UnitName("focus") then
			specWarnGraceOfNature:Show(targetName)
			voiceGraceOfNature:Play("bossout")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 218809 then
		if self.Options.HudMapOnCoN then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
			if self.Options.HudMapOnCoN then
				DBMHudMap:FreeEncounterMarkerByTarget(2188092, args.destName)
			end
		end
		if self.Options.SetIconOnCoN then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 218304 then
		specWarnLasher:Show()
		voiceLasher:Play("killmob")
	end
end

function mod:UNIT_HEALTH(uId)
	local cid = self:GetUnitCreatureId(uId)
	if cid == 109804 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.15 then
		local guid = UnitGUID(uId)
		if not sentLowHP[guid] then
			sentLowHP[guid] = true
			self:SendSync("lowhealth", guid)
		end
	end
end

function mod:OnSync(msg, guid)
	if msg == "lowhealth" and guid and not warnedLowHP[guid] then
		warnedLowHP[guid] = true
		specwarnStarLow:Show()
	end
end

--[[
--If needed
function mod:SPELL_DISPEL(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 218304 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
