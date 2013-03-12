local mod	= DBM:NewMod(743, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62837)--62847 Dissonance Field, 63591 Kor'thik Reaver, 63589 Set'thik Windblade
mod:SetModelID(42730)
mod:SetZone()
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnScreech				= mod:NewSpellAnnounce(123735, 3, nil, false)--Not useful.
local warnCryOfTerror			= mod:NewTargetAnnounce(123788, 3, nil, mod:IsRanged())
local warnEyes					= mod:NewStackAnnounce(123707, 2, nil, mod:IsTank() or mod:IsHealer())
local warnDissonanceField		= mod:NewCountAnnounce(123255, 3)
local warnSonicDischarge		= mod:NewSoonAnnounce(123504, 4)--Iffy reliability but better then nothing i suppose.
local warnRetreat				= mod:NewSpellAnnounce(125098, 4)
local warnAmberTrap				= mod:NewAnnounce("warnAmberTrap", 2, 125826)
local warnTrapped				= mod:NewTargetAnnounce(125822, 1)--Trap used
local warnStickyResin			= mod:NewTargetAnnounce(124097, 3)
local warnFixate				= mod:NewTargetAnnounce(125390, 3, nil, false)--Spammy
local warnAdvance				= mod:NewSpellAnnounce(125304, 4)
local warnVisions				= mod:NewTargetAnnounce(124862, 4)--Visions of Demise
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnCalamity				= mod:NewSpellAnnounce(124845, 3, nil, mod:IsHealer())
local warnConsumingTerror		= mod:NewSpellAnnounce(124849, 4, nil, not mod:IsTank())
local warnHeartOfFear			= mod:NewTargetAnnounce(125638, 4)

local specwarnSonicDischarge	= mod:NewSpecialWarningSpell(123504, nil, nil, nil, true)
local specWarnEyes				= mod:NewSpecialWarningStack(123707, mod:IsTank(), 4)--4 is max, 2 is actually the smartest time to taunt though. i may change it to 2 at some point
local specWarnEyesOther			= mod:NewSpecialWarningTarget(123707, mod:IsTank())
local specwarnCryOfTerror		= mod:NewSpecialWarningYou(123788)
local specWarnRetreat			= mod:NewSpecialWarningSpell(125098)
local specwarnAmberTrap			= mod:NewSpecialWarningSpell(125826, false)
local specwarnStickyResin		= mod:NewSpecialWarningYou(124097)
local yellStickyResin			= mod:NewYell(124097, nil, false)
local specwarnFixate			= mod:NewSpecialWarningYou(125390)
local specWarnDispatch			= mod:NewSpecialWarningInterrupt(124077, mod:IsMelee())
local specWarnAdvance			= mod:NewSpecialWarningSpell(125304)
local specwarnVisions			= mod:NewSpecialWarningYou(124862)
local yellVisions				= mod:NewYell(124862, nil, false)
local specWarnConsumingTerror	= mod:NewSpecialWarningSpell(124849, not mod:IsTank())
local specWarnHeartOfFear		= mod:NewSpecialWarningYou(125638)
local yellHeartOfFear			= mod:NewYell(125638)

local timerScreechCD			= mod:NewNextTimer(7, 123735, nil, false)
local timerCryOfTerror			= mod:NewTargetTimer(20, 123788, nil, mod:IsHealer())
local timerCryOfTerrorCD		= mod:NewCDTimer(25, 123788, nil, mod:IsRanged())
local timerEyes					= mod:NewTargetTimer(30, 123707, nil, mod:IsTank())
local timerEyesCD				= mod:NewNextTimer(11, 123707, nil, mod:IsTank())
local timerDissonanceFieldCD	= mod:NewNextCountTimer(65, 123255)
local timerPhase1				= mod:NewNextTimer(156.4, 125304)--156.4 til ENGAGE fires and boss is out, 157.4 until "advance" fires though. But 156.4 is more accurate timer
local timerDispatchCD			= mod:NewCDTimer(12, 124077)--Every 12-15 seconds on 25 man. on 10 man i've heard it's every 20ish?
local timerPhase2				= mod:NewNextTimer(151, 125098)--152 until trigger, but probalby 150 or 151 til adds are targetable.
local timerCalamityCD			= mod:NewCDTimer(6, 124845, nil, mod:IsHealer())
local timerVisionsCD			= mod:NewCDTimer(19.5, 124862)
local timerConsumingTerrorCD	= mod:NewCDTimer(32, 124849, nil, not mod:IsTank())
local timerCorruptedDissonance	= mod:NewNextTimer(20, 126122)--10 seconds after first and 20 seconds after
local timerHeartOfFear			= mod:NewBuffFadesTimer(6, 125638)

local berserkTimer				= mod:NewBerserkTimer(900)

local soundFixate				= mod:NewSound(125390)

mod:AddBoolOption("InfoFrame")--On by default because these do more then just melee, they interrupt spellcasting (bad for healers)
mod:AddBoolOption("RangeFrame", mod:IsRanged())
mod:AddBoolOption("StickyResinIcons", true)
mod:AddBoolOption("HeartOfFearIcon", true)

local sentLowHP = {}
local warnedLowHP = {}
local visonsTargets = {}
local resinTargets = {}
local resinIcon = 2
local phase3Started = false
local fieldCount = 0

local function warnVisionsTargets()
	warnVisions:Show(table.concat(visonsTargets, "<, >"))
	timerVisionsCD:Start()
	table.wipe(visonsTargets)
end

function mod:OnCombatStart(delay)
	phase3Started = false
	resinIcon = 2
	fieldCount = 0
	timerScreechCD:Start(-delay)
	timerEyesCD:Start(-delay)
	timerDissonanceFieldCD:Start(20.5-delay, 1)
	timerPhase2:Start(-delay)
	berserkTimer:Start(-delay)
	table.wipe(sentLowHP)
	table.wipe(warnedLowHP)
	table.wipe(visonsTargets)
	table.wipe(resinTargets)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
	self:RegisterShortTermEvents(
		"UNIT_HEALTH_FREQUENT_UNFILTERED"
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123707) then
		warnEyes:Show(args.destName, args.amount or 1)
		timerEyes:Start(args.destName)
		timerEyesCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 4 then
			specWarnEyes:Show(args.amount)
		else
			if (args.amount or 1) >= 3 and not UnitDebuff("player", GetSpellInfo(123735)) and not UnitIsDeadOrGhost("player") then
				specWarnEyesOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(123788) then
		warnCryOfTerror:Show(args.destName)
		timerCryOfTerror:Start(args.destName)
		timerCryOfTerrorCD:Start()
		if args:IsPlayer() then
			specwarnCryOfTerror:Show()
		end
	elseif args:IsSpellID(124748) then
		warnAmberTrap:Show(args.amount or 1)
		table.wipe(resinTargets)
	elseif args:IsSpellID(125822) then
		warnTrapped:Show(args.destName)
	elseif args:IsSpellID(125390) then
		warnFixate:Show(args.destName)
		if args:IsPlayer() then
			specwarnFixate:Show()
			soundFixate:Play()
		end
	elseif args:IsSpellID(124862) then
		visonsTargets[#visonsTargets + 1] = args.destName
		if args:IsPlayer() then
			specwarnVisions:Show()
			if not self:IsDifficulty("lfr25") then
				yellVisions:Yell()
			end
		end
		self:Unschedule(warnVisionsTargets)
		self:Schedule(0.3, warnVisionsTargets)
	elseif args:IsSpellID(124097) then
		if args:IsPlayer() and self:AntiSpam(5, 2) then --prevent spam in heroic
			specwarnStickyResin:Show()
			yellStickyResin:Yell()
		end
		if not resinTargets[args.destName] then --prevent spam in heroic
			resinTargets[args.destName] = true
			warnStickyResin:Show(args.destName)
			if self.Options.StickyResinIcons then
				self:SetIcon(args.destName, resinIcon)
				if resinIcon == 2 then
					resinIcon = 1
				else
					resinIcon = 2
				end
			end
		end
	elseif args:IsSpellID(124077) then
		specWarnDispatch:Show(args.sourceName)
		if self:IsDifficulty("normal25", "heroic25", "lfr25") then
			timerDispatchCD:Start()--25 is about 12-15 variation
		else
			timerDispatchCD:Start(21)--Longer Cd on 10 man (21-24 variation)
		end
	elseif args:IsSpellID(123845) then
		warnHeartOfFear:Show(args.destName)
		if args:IsPlayer() then
			specWarnHeartOfFear:Show()
			yellHeartOfFear:Yell()
			timerHeartOfFear:Start()
		end
		if self.Options.HeartOfFearIcon then
			self:SetIcon(args.destName, 8)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123788) then
		timerCryOfTerror:Cancel(args.destName)
	elseif args:IsSpellID(124097) then
		if self.Options.StickyResinIcons then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(123845) then
		if self.Options.HeartOfFearIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(123735) then
		warnScreech:Show()
		timerScreechCD:Start()
	elseif args:IsSpellID(125826) then
		specwarnAmberTrap:Show()
	elseif args:IsSpellID(124845) then
		warnCalamity:Show()
		timerCalamityCD:Start()
	--"<33.5 22:57:49> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#No more excuses, Empress! Eliminate these cretins or I will kill you myself!#Sha of Fear###Grand Empress Shek'zeer
	--"<36.8 22:57:52> [CLEU] SPELL_CAST_SUCCESS#false#0xF130F9C600007497#Sha of Fear#2632#0#0x0000000000000000#nil#-2147483648#-2147483648#125451#Ultimate Corruption#1", -- [7436]
	--backup phase 3 trigger for unlocalized languages
	elseif args:IsSpellID(125451) and not phase3Started then
		phase3Started = true
		self:UnregisterShortTermEvents()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		timerPhase2:Cancel()
		timerCryOfTerrorCD:Cancel()
		timerDissonanceFieldCD:Cancel()
		timerScreechCD:Cancel()
		warnPhase2:Show()
		timerVisionsCD:Start(4)
		timerCalamityCD:Start(9)
		timerConsumingTerrorCD:Start(11)
	elseif args:IsSpellID(123255) and self:AntiSpam(2, 3) then
		fieldCount = fieldCount + 1
		warnDissonanceField:Show(fieldCount)
		if fieldCount < 2 then
			timerDissonanceFieldCD:Start(nil, fieldCount+1)
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			if fieldCount == 1 then
				timerCorruptedDissonance:Start(10)
			else
				timerCorruptedDissonance:Start()
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(124849) then
		warnConsumingTerror:Show()
		specWarnConsumingTerror:Show()
		timerConsumingTerrorCD:Start()
	end
end

--[[ Yell comes 3 seconds sooner then combat log event, so it's better phase 3 transitioner to start better timers, especially for first visions of demise
"<33.5 22:57:49> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#No more excuses, Empress! Eliminate these cretins or I will kill you myself!#Sha of Fear###Grand Empress Shek'zeer
"<36.8 22:57:52> [CLEU] SPELL_CAST_SUCCESS#false#0xF130F9C600007497#Sha of Fear#2632#0#0x0000000000000000#nil#-2147483648#-2147483648#125451#Ultimate Corruption#1", -- [7436]
--]]
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellPhase3 or msg:find(L.YellPhase3)) and not phase3Started then
		phase3Started = true
		self:UnregisterShortTermEvents()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		timerPhase2:Cancel()
		timerCryOfTerrorCD:Cancel()
		timerDissonanceFieldCD:Cancel()
		timerScreechCD:Cancel()
		warnPhase2:Show()
		timerVisionsCD:Start(7)
		timerCalamityCD:Start(12)
		timerConsumingTerrorCD:Start(14)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 125098 and self:AntiSpam(2, 1) then--Yell is about 1.5 seconds faster then this event, BUT, it also requires localizing. I don't think doing it this way hurts anything.
		self:UnregisterShortTermEvents()
		table.wipe(resinTargets)
		timerScreechCD:Cancel()
		timerCryOfTerrorCD:Cancel()
		timerDissonanceFieldCD:Cancel()
		timerEyesCD:Cancel()
		warnRetreat:Show()
		specWarnRetreat:Show()
		timerPhase1:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(L.PlayerDebuffs)
			DBM.InfoFrame:Show(10, "playerbaddebuff", 125390)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 125304 and self:AntiSpam(2, 1) then
		fieldCount = 0
		timerPhase1:Cancel()--If you kill everything it should end early.
		warnAdvance:Show()
		specWarnAdvance:Show()
		timerDissonanceFieldCD:Start(20, 1)
		timerPhase2:Start()--Assumed same as pull
		if self.Options.InfoFrame then--Will do this more accurately when i have an accurate count of mobs for all difficulties and then i can hide it when mobcount reaches 0
			DBM.InfoFrame:Hide()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
		self:RegisterShortTermEvents(
			"UNIT_HEALTH_FREQUENT_UNFILTERED"
		)
	end
end

--May not be that reliable, because they don't have a special unitID and there is little reason to target them.
--So it may miss some of them, not sure of any other way to PRE-warn though. Can warn on actual cast/damage but not too effective.
function mod:UNIT_HEALTH_FREQUENT_UNFILTERED(uId)
	local cid = self:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	if cid == 62847 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.08 and not sentLowHP[guid] then -- 0.05 seems too late.
		sentLowHP[guid] = true
		self:SendSync("lowhealth", guid)
	end
end

function mod:OnSync(msg, guid)
	if msg == "lowhealth" and guid and not warnedLowHP[guid] then
		warnedLowHP[guid] = true
		warnSonicDischarge:Show()--This only works if someone in raid is actually targeting them :(
		specwarnSonicDischarge:Show()--But is extremly useful when they are.
	end
end
