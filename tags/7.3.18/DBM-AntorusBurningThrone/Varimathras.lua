local mod	= DBM:NewMod(1983, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122366)
mod:SetEncounterID(2069)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 3, 4)
mod:SetHotfixNoticeRev(16945)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 243960 244093 243999 257644",
	"SPELL_AURA_APPLIED 243961 244042 244094 248732 243968 243977 243980 243973",
	"SPELL_AURA_REMOVED 244042 244094",
	"SPELL_PERIODIC_DAMAGE 244005 248740",
	"SPELL_PERIODIC_MISSED 244005 248740",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, on phase changes most ability CDs extended by 2+ seconds, but NOT ALWAYS so difficult to hard code a rule for it right now
--[[
(ability.id = 243960 or ability.id = 244093 or ability.id = 243999 or ability.id = 244042 or ability.id = 257644) and type = "cast"
 or (ability.id = 243968 or ability.id = 243977 or ability.id = 243980 or ability.id = 243973) and type = "applydebuff" and target.name = "Omegal"
 or ability.id = 26662
--]]
--Torments of the Shivarra
local warnTormentofFlames				= mod:NewSpellAnnounce(243967, 2, nil, nil, nil, nil, nil, 2)
local warnTormentofFrost				= mod:NewSpellAnnounce(243976, 2, nil, nil, nil, nil, nil, 2)
local warnTormentofFel					= mod:NewSpellAnnounce(243979, 2, nil, nil, nil, nil, nil, 2)
local warnTormentofShadows				= mod:NewSpellAnnounce(243974, 2, nil, nil, nil, nil, nil, 2)
--The Fallen Nathrezim
local warnShadowStrike					= mod:NewSpellAnnounce(243960, 2, nil, "Tank", 2)--Doesn't need special warning because misery should trigger special warning at same time
local warnMarkedPrey					= mod:NewTargetAnnounce(244042, 3)
local warnNecroticEmbrace				= mod:NewTargetAnnounce(244094, 4)
local warnEchoesofDoom					= mod:NewTargetAnnounce(248732, 3)

--Torments of the Shivarra
local specWarnGTFO						= mod:NewSpecialWarningGTFO(243968, nil, nil, nil, 1, 2)
--The Fallen Nathrezim
local specWarnMisery					= mod:NewSpecialWarningYou(243961, nil, nil, nil, 1, 2)
local specWarnMiseryTaunt				= mod:NewSpecialWarningTaunt(243961, nil, nil, nil, 1, 2)
local specWarnDarkFissure				= mod:NewSpecialWarningDodge(243999, nil, nil, nil, 2, 2)
local specWarnMarkedPrey				= mod:NewSpecialWarningYou(244042, nil, nil, 2, 1, 2)
local yellMarkedPrey					= mod:NewYell(244042)
local yellMarkedPreyFades				= mod:NewShortFadesYell(244042)
local specWarnNecroticEmbrace			= mod:NewSpecialWarningMoveAway(244094, nil, nil, 2, 1, 2)
local yellNecroticEmbrace				= mod:NewPosYell(244094)
local yellNecroticEmbraceFades			= mod:NewIconFadesYell(244094)
local specWarnEchoesOfDoom				= mod:NewSpecialWarningYou(248732, nil, nil, nil, 1, 2)
local yellEchoesOfDoom					= mod:NewYell(248732)

--Torments of the Shivarra
mod:AddTimerLine(GENERAL)
local timerTormentofFlamesCD			= mod:NewNextTimer(5, 243967, nil, nil, nil, 6)
local timerTormentofFrostCD				= mod:NewNextTimer(61, 243976, nil, nil, nil, 6)
local timerTormentofFelCD				= mod:NewNextTimer(61, 243979, nil, nil, nil, 6)
local timerTormentofShadowsCD			= mod:NewNextTimer(61, 243974, nil, nil, nil, 6)
--The Fallen Nathrezim
mod:AddTimerLine(BOSS)
local timerShadowStrikeCD				= mod:NewCDTimer(8.5, 243960, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--8.5-14 (most of time it's 9.7 or more, But lowest has to be used
local timerDarkFissureCD				= mod:NewCDTimer(32, 243999, nil, nil, nil, 3)--32-33
local timerMarkedPreyCD					= mod:NewNextTimer(30.3, 244042, nil, nil, nil, 3)
local timerNecroticEmbraceCD			= mod:NewNextTimer(30.3, 244093, nil, nil, nil, 3)

local berserkTimer						= mod:NewBerserkTimer(390)

--The Fallen Nathrezim
local countdownShadowStrike				= mod:NewCountdown("Alt9", 243960, "Tank", nil, 3)
local countdownMarkedPrey				= mod:NewCountdown(30, 244042)
local countdownNecroticEmbrace			= mod:NewCountdown("AltTwo30", 244093)

mod:AddSetIconOption("SetIconOnMarkedPrey", 244042, true)
mod:AddSetIconOption("SetIconEmbrace", 244094, true)
--mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("8/10")

mod.vb.currentTorment = 0--Can't antispam, cause it'll just break if someone dies and gets brezzed
mod.vb.totalEmbrace = 0

function mod:OnCombatStart(delay)
	self.vb.currentTorment = 0
	self.vb.totalEmbrace = 0
	timerTormentofFlamesCD:Start(5-delay)
	timerShadowStrikeCD:Start(9.3-delay)
	countdownShadowStrike:Start(9.3-delay)
	timerDarkFissureCD:Start(17.4-delay)--success
	timerMarkedPreyCD:Start(25.2-delay)
	countdownMarkedPrey:Start(25.2-delay)
	if not self:IsEasy() then
		timerNecroticEmbraceCD:Start(35-delay)
		countdownNecroticEmbrace:Start(35-delay)
	end
	berserkTimer:Start(310-delay)--Confirmed normal/heroic/mythic
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 243960 or spellId == 257644 then--257644 LFR shadow strike
		warnShadowStrike:Show()
		timerShadowStrikeCD:Show()
		countdownShadowStrike:Start(9)
	elseif spellId == 244093 then--Necrotic Embrace Cast
		timerNecroticEmbraceCD:Start()
		countdownNecroticEmbrace:Start(30.3)
	elseif spellId == 243999 then
		specWarnDarkFissure:Show()
		specWarnDarkFissure:Play("watchstep")
		timerDarkFissureCD:Start()
	elseif spellId == 122366 then
		timerMarkedPreyCD:Start()
		countdownMarkedPrey:Start(30.3)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 243961 and self.vb.currentTorment ~= 4 then--If current torment is shadow, disable these warnings, Because entire raid now has misery rest of fight
		if args:IsPlayer() then
			if self:AntiSpam(4, 2) then
				specWarnMisery:Show()
				specWarnMisery:Play("defensive")
			end
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			--Applied to a tank that's not you and you don't have it, taunt
			if uId and self:IsTanking(uId) and self:CheckNearby(8, args.destName) and not UnitDebuff("player", args.spellName) then
				specWarnMiseryTaunt:Show(args.destName)
				specWarnMiseryTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 244042 then
		if args:IsPlayer() then
			specWarnMarkedPrey:Show()
			specWarnMarkedPrey:Play("targetyou")
			yellMarkedPrey:Yell()
			yellMarkedPreyFades:Countdown(5)
		else
			warnMarkedPrey:Show(args.destName)
		end
	elseif spellId == 244094 then
		self.vb.totalEmbrace = self.vb.totalEmbrace + 1
		if self.vb.totalEmbrace >= 3 then return end--Once it's beyond 2 players, consider it a wipe and throttle messages
		if args:IsPlayer() then
			specWarnNecroticEmbrace:Show()
			specWarnNecroticEmbrace:Play("scatter")
			local icon = self.vb.totalEmbrace+2
			yellNecroticEmbrace:Yell(self.vb.totalEmbrace, icon, icon)
			yellNecroticEmbraceFades:Countdown(6, 3, icon)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warnNecroticEmbrace:CombinedShow(0.5, args.destName)--Combined message because even if it starts on 1, people are gonna fuck it up
		end
		if self.Options.SetIconEmbrace then
			self:SetIcon(args.destName, self.vb.totalEmbrace+2)--Should be BW compatible, for most part.
		end
	elseif spellId == 248732 then
		warnEchoesofDoom:CombinedShow(0.5, args.destName)--In case multiple shadows up
		if args:IsPlayer() and self:AntiSpam(3, 1) then
			specWarnEchoesOfDoom:Show()
			specWarnEchoesOfDoom:Play("targetyou")
			yellEchoesOfDoom:Yell()
		end
	elseif spellId == 243968 and self.vb.currentTorment ~= 1 then--Flame
		self.vb.currentTorment = 1
		warnTormentofFlames:Show()
		warnTormentofFlames:Play("phasechange")
		if not self:IsEasy() then
			timerTormentofFrostCD:Start(100)
		else--No frost or fel in normal, LFR assumed
			timerTormentofShadowsCD:Start(290)
		end
	elseif spellId == 243977 and self.vb.currentTorment ~= 2 then--Frost
		self.vb.currentTorment = 2
		warnTormentofFrost:Show()
		warnTormentofFrost:Play("phasechange")
		timerTormentofFelCD:Start(99)
	elseif spellId == 243980 and self.vb.currentTorment ~= 3 then--Fel
		self.vb.currentTorment = 3
		warnTormentofFel:Show()
		warnTormentofFel:Play("phasechange")
		timerTormentofShadowsCD:Start(90)
	elseif spellId == 243973 and self.vb.currentTorment ~= 4 then--Shadow
		self.vb.currentTorment = 4
		warnTormentofShadows:Show()
		warnTormentofShadows:Play("phasechange")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244042 then
		if args:IsPlayer() then
			yellMarkedPrey:Cancel()
		end
	elseif spellId == 244094 then
		self.vb.totalEmbrace = self.vb.totalEmbrace - 1
		if args:IsPlayer() then
			yellNecroticEmbraceFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if self.Options.SetIconEmbrace then
			self:SetIcon(args.destName, 0)
		end
	end
end

--Dark Fissure & Echoes of Doom
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 244005 or spellId == 248740) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
