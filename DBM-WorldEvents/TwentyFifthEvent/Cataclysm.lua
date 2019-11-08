local mod	= DBM:NewMod("CataEvent", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(52409)
mod:SetEncounterID(2320)
mod:SetZone()
--mod:SetModelSound("Sound\\Creature\\RAGNAROS\\VO_FL_RAGNAROS_AGGRO.ogg", "Sound\\Creature\\RAGNAROS\\VO_FL_RAGNAROS_KILL_03.ogg")
--Long: blah blah blah (didn't feel like transcribing it)
--Short: This is my realm

mod:RegisterCombat("combat")
mod:SetWipeTime(60)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 98710 98951 98952 98953 99172 99235 99236 80734 81713 81628",
	"SPELL_CAST_SUCCESS 100460 99268",
	"SPELL_AURA_APPLIED 99399 82518",
	"SPELL_AURA_APPLIED_DOSE 99399 82518",
	"UNIT_AURA player",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_DIED"
)

--Chogal
local warnFury				= mod:NewStackAnnounce(82524, 2, nil, "Tank|Healer")
--Ragnaros
local warnBurningWound		= mod:NewStackAnnounce(99399, 3, nil, "Tank|Healer")
local warnSulfurasSmash		= mod:NewSpellAnnounce(98710, 4)--Phase 1-3 ability.
local warnSonsLeft			= mod:NewAddsLeftAnnounce("ej2637", 2, 99014)
local warnBlazingHeat		= mod:NewTargetAnnounce(100460, 4)
local warnSplittingBlow		= mod:NewAnnounce("warnSplittingBlow", 3, 98951)
local warnEngulfingFlame	= mod:NewAnnounce("warnEngulfingFlame", 4, 99171)
local warnLivingMeteor		= mod:NewTargetNoFilterAnnounce(99268, 4)--Phase 3 only ability

--Chogal
local specWarnFury			= mod:NewSpecialWarningStack(82524, nil, 2, nil, nil, 1, 6)
local specWarnFuryTaunt		= mod:NewSpecialWarningTaunt(82524, nil, nil, nil, 1, 2)
local specWarnAdherent		= mod:NewSpecialWarningSwitch(81628, "-Healer", nil, nil, 1, 2)
local specWarnDepravity		= mod:NewSpecialWarningInterrupt(81713, "HasInterrupt", nil, nil, 1, 2)
local specWarnSickness		= mod:NewSpecialWarningMoveAway(82235, nil, nil, nil, 1, 2)
local yellSickness			= mod:NewYell(82235, nil, false)
--Nef
local specWarnBlastsNova	= mod:NewSpecialWarningInterrupt(80734, "HasInterrupt", nil, nil, 1, 2)
--Ragnaros
local specWarnBurningWound	= mod:NewSpecialWarningStack(99399, nil, 4, nil, nil, 1, 6)
local specWarnSplittingBlow	= mod:NewSpecialWarningSpell(98951, nil, nil, nil, 1, 2)
local specWarnBlazingHeat	= mod:NewSpecialWarningYou(100460)--Debuff on you
local yellBlazingHeat		= mod:NewYell(100460)
local specWarnMoltenSeed	= mod:NewSpecialWarningRun(98495, nil, nil, nil, 4, 2)
local specWarnEngulfing		= mod:NewSpecialWarningDodge(99171, nil, nil, nil, 2, 2)
local specWarnMeteor		= mod:NewSpecialWarningDodge(99268, nil, nil, nil, 1, 2)--Spawning on you
local specWarnMeteorNear	= mod:NewSpecialWarningClose(99268, nil, nil, nil, 1, 2)--Spawning near you
local yellMeteor			= mod:NewYell(99268)
local specWarnFixate		= mod:NewSpecialWarningRun(99849, nil, nil, nil, 4, 2)--Chasing you after it spawned
local yellFixate			= mod:NewYell(99849)

mod:AddInfoFrameOption(99849, true)

local meteorWarned = false
local meteorTarget = DBM:GetSpellInfo(99849)
mod.vb.seedsActive = false
mod.vb.meteorSpawned = 0
mod.vb.sonsLeft = 0

function mod:LivingMeteorTarget(targetname)
	if targetname == UnitName("player") then
		specWarnMeteor:Show()
		specWarnMeteor:Play("targetyou")
		yellMeteor:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = DBM.RangeCheck:GetDistance("player", uId)
			if inRange and inRange < 12 then
				specWarnMeteorNear:Show(targetname)
				specWarnMeteorNear:Play("runaway")
			else
				warnLivingMeteor:Show(targetname)
			end
		end
	end
end

local function warnSeeds()
	specWarnMoltenSeed:Show()
	specWarnMoltenSeed:Play("watchstep")
end

function mod:OnCombatStart(delay)
	self.vb.seedsActive = false
	self.vb.meteorSpawned = 0
	self.vb.sonsLeft = 0
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 98710 then
		warnSulfurasSmash:Show()
	elseif args:IsSpellID(98951, 98952, 98953) then--This has 3 spellids, 1 for each possible location for hammer.
		self.vb.sonsLeft = 8
		self:Unschedule(warnSeeds)
		specWarnSplittingBlow:Show()
		specWarnSplittingBlow:Play("phasechange")
		if spellId == 98951 then--West
			warnSplittingBlow:Show(args.spellName, L.West)
		elseif spellId == 98952 then--Middle
			warnSplittingBlow:Show(args.spellName, L.Middle)
		elseif spellId == 98953 then--East
			warnSplittingBlow:Show(args.spellName, L.East)
		end
	elseif args:IsSpellID(99172, 99235, 99236) then--Another scripted spell with a ton of spellids based on location of room.
		--North: 99172
		--Middle: 99235
		--South: 99236
		if spellId == 99172 then--North
			warnEngulfingFlame:Show(args.spellName, L.North)
			specWarnEngulfing:Show()
			specWarnEngulfing:Play("watchstep")
		elseif spellId == 99235 then--Middle
			warnEngulfingFlame:Show(args.spellName, L.Middle)
		elseif spellId == 99236 then--South
			warnEngulfingFlame:Show(args.spellName, L.South)
		end
	elseif spellId == 80734 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBlastsNova:Show(args.sourceName)
		specWarnBlastsNova:Play("kickcast")
	elseif spellId == 81713 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDepravity:Show(args.sourceName)
		specWarnDepravity:Play("kickcast")
	elseif spellId == 81628 then
		specWarnAdherent:Show()
		specWarnAdherent:Play("killmob")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 100460 then	-- Blazing heat
		if args:IsPlayer() then
			specWarnBlazingHeat:Show()
			specWarnBlazingHeat:Play("targetyou")
			yellBlazingHeat:Yell()
		else
			warnBlazingHeat:Show(args.destName)
		end
	elseif spellId == 99268 then
		self.vb.meteorSpawned = self.vb.meteorSpawned + 1
		if self.vb.meteorSpawned == 1 or self.vb.meteorSpawned % 2 == 0 then--Spam filter, announce at 1, 2, 4, 6, 8, 10 etc. The way that they spawn
			self:BossTargetScanner(args.sourceGUID, "LivingMeteorTarget", 0.025, 12)
		end
		if self.Options.InfoFrame and self.vb.meteorSpawned == 1 then--Show meteor frame and clear any health or aggro frame because nothing is more important then meteors.
			DBM.InfoFrame:SetHeader(meteorTarget)
			DBM.InfoFrame:Show(6, "playerbaddebuff", meteorTarget)--If you get more then 6 chances are you're screwed unless it's normal mode and he's at like 11%. Really anything more then 4 is chaos and wipe waiting to happen.
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 99399 then
		local amount = args.amount or 1
		if amount >= 4 and args:IsPlayer() then
			specWarnBurningWound:Show(amount)
			specWarnBurningWound:Play("stackhigh")
		else
			warnBurningWound:Show(args.destName, amount)
		end
	elseif args.spellId == 82518 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnFury:Show(amount)
					specWarnFury:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
						specWarnFuryTaunt:Show(args.destName)
						specWarnFuryTaunt:Play("tauntboss")
					else
						warnFury:Show(args.destName, amount)
					end
				end
			else
				warnFury:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:UNIT_AURA(uId)
	if DBM:UnitDebuff("player", meteorTarget) and not meteorWarned then--Warn you that you have a meteor
		specWarnFixate:Show()
		specWarnFixate:Play("justrun")
		yellFixate:Yell()
		meteorWarned = true
	elseif not DBM:UnitDebuff("player", meteorTarget) and meteorWarned then--reset warned status if you don't have debuff
		meteorWarned = false
	elseif DBM:UnitDebuff("player", 82235) and self:AntiSpam(7, 2) then
		specWarnSickness:Show()
		specWarnSickness:Play("scatter")
		yellSickness:Yell()
	end
end

local function clearSeedsActive(self)
	self.vb.seedsActive = false
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 98333 then -- The true molten seeds cast.
		self.vb.seedsActive = true
		self:Schedule(2.5, warnSeeds, self)--But use upper here
		self:Schedule(17.5, clearSeedsActive, self)--Clear active/warned seeds after they have all blown up.
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53140 then--Son of Flame
		self.vb.sonsLeft = self.vb.sonsLeft - 1
		if self.vb.sonsLeft < 3 then
			warnSonsLeft:Show(self.vb.sonsLeft)
		end
	elseif cid == 53500 then--Meteors
		self.vb.meteorSpawned = self.vb.meteorSpawned - 1
		if self.vb.meteorSpawned == 0 and self.Options.InfoFrame then--Meteors all gone, hide info frame
			DBM.InfoFrame:Hide()
		end
	end
end
