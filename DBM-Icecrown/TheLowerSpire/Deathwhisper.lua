local mod	= DBM:NewMod("Deathwhisper", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36855)
mod:SetUsedIcons(4, 5, 6, 7, 8)
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_TARGET"
)

local warnAddsSoon					= mod:NewAnnounce("WarnAddsSoon", 3)
local warnDominateMind				= mod:NewTargetAnnounce(71289, 3)
local warnDeathDecay				= mod:NewSpellAnnounce(72108, 2)
local warnReanimating				= mod:NewAnnounce("WarnReanimating", 3)
local warnDarkTransformation		= mod:NewSpellAnnounce(70900, 4)
local warnDarkEmpowerment			= mod:NewSpellAnnounce(70901, 4)
local warnPhase2					= mod:NewPhaseAnnounce(2, 3)	
local warnFrostbolt					= mod:NewCastAnnounce(72007, 2)
local warnTouchInsignificance		= mod:NewAnnounce("WarnTouchInsignificance", 3)


local specWarnCurseTorpor			= mod:NewSpecialWarningYou(71237)
local specWarnDeathDecay			= mod:NewSpecialWarningMove(72108)
local specWarnTouchInsignificance	= mod:NewSpecialWarningStack(71204, nil, 3)

local timerAdds						= mod:NewTimer(60, "TimerAdds")
local timerDominateMind				= mod:NewBuffActiveTimer(20, 71289)
local timerDominateMindCD			= mod:NewCDTimer(40, 71289)
local timerTouchInsignificance		= mod:NewTargetTimer(30, 71204)

local enrageTimer					= mod:NewEnrageTimer(600)

mod:AddBoolOption("SetIconOnDominateMind", true)
mod:AddBoolOption("SetIconOnDeformedFanatic", true)
mod:AddBoolOption("SetIconOnEmpoweredAdherent", true)

mod:RemoveOption("HealthFrame")
mod:AddBoolOption("ShieldHealthFrame", true, "misc")

local lastDD	= 0
local dominateMindTargets	= {}
local dominateMindIcon 	= 6
local deformedFanatic
local empoweredAdherent

function mod:OnCombatStart(delay)
	if self.Options.ShieldHealthFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(36855, L.name)
		self:ScheduleMethod(0.5, "CreateShildHPFrame")
	end		
	enrageTimer:Start(-delay)
	timerAdds:Start(7)
	warnAddsSoon:Schedule(4)			-- 3sec pre-warning on start
	self:ScheduleMethod(7, "addsTimer")
	timerDominateMindCD:Start(30)		-- Sometimes 1 fails at the start, then the next will be applied 70 secs after start ?? :S
	table.wipe(dominateMindTargets)
	dominateMindIcon = 7
	deformedFanatic = nil
	empoweredAdherent = nil
end

function mod:OnCombatEnd()
	DBM.BossHealth:Clear()
end

do	-- add the additional Shield Bar
	local last = 100
	local function getShieldPercent()
		local guid = UnitGUID("focus")
		if guid and tonumber(guid:sub(9, 12), 16) == 36855 then 
			last = math.floor(UnitMana(unitId)/UnitManaMax(unitId) * 100)
			return last
		end
		for i = 0, GetNumRaidMembers(), 1 do
			local unitId = ((i == 0) and "target") or "raid"..i.."target"
			local guid = UnitGUID(unitId)
			if guid and tonumber(guid:sub(9, 12), 16) == 36855 then
				last = math.floor(UnitMana(unitId)/UnitManaMax(unitId) * 100)
				return last
			end
		end
		return last
	end
	function mod:CreateShildHPFrame()
		DBM.BossHealth:AddBoss(getShieldPercent, L.ShieldPercent)
	end
end

function mod:addsTimer()
	timerAdds:Cancel()
	warnAddsSoon:Cancel()
	timerAdds:Start()
	warnAddsSoon:Schedule(55)	-- 5 secs prewarning
	self:ScheduleMethod(60, "addsTimer")
end

function mod:TrySetTarget()
	if DBM:GetRaidRank() >= 1 then
		for i = 1, GetNumRaidMembers() do
			if UnitGUID("raid"..i.."target") == deformedFanatic then
				deformedFanatic = nil
				SetRaidTarget("raid"..i.."target", 8)
			elseif UnitGUID("raid"..i.."target") == empoweredAdherent then
				empoweredAdherent = nil
				SetRaidTarget("raid"..i.."target", 7)
			end
			if not (deformedFanatic or empoweredAdherent) then
				break
			end
		end
	end
end

do
	local function showDominateMindWarning()
		warnDominateMind:Show(table.concat(dominateMindTargets, "<, >"))
		timerDominateMind:Start()
		timerDominateMindCD:Start()
		table.wipe(dominateMindTargets)
		dominateMindIcon = 6
	end
	
	function mod:SPELL_AURA_APPLIED(args)
		if args:IsSpellID(71289) then
			dominateMindTargets[#dominateMindTargets + 1] = args.destName
			if self.Options.SetIconOnDominateMind then
				self:SetIcon(args.destName, dominateMindIcon, 20)
				dominateMindIcon = dominateMindIcon - 1
			end
			self:Unschedule(showDominateMindWarning)
			if mod:IsDifficulty("heroic10") or mod:IsDifficulty("normal25") or (mod:IsDifficulty("heroic25") and #dominateMindTargets >= 3) then
				showDominateMindWarning()
			else
				self:Schedule(0.3, showDominateMindWarning)
			end
		elseif args:IsSpellID(72108, 71001) then
			if args:IsPlayer() then
				specWarnDeathDecay:Show()
			end
			if (GetTime() - lastDD > 5) then
				warnDeathDecay:Show()
				lastDD = GetTime()
			end
		elseif args:IsSpellID(71237) and args:IsPlayer() then
			specWarnCurseTorpor:Show()
		elseif args:IsSpellID(71204) then
			warnTouchInsignificance:Show(args.spellName, args.destName, args.amount or 1)
			if args:IsPlayer() and (args.amount or 1) >= 3 then
				specWarnTouchInsignificance:Show(args.amount)
			end
			timerTouchInsignificance:Start(args.destName)
		end
	end
	mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70842) then
		warnPhase2:Show()
		timerAdds:Cancel()
		warnAddsSoon:Cancel()
		self:UnscheduleMethod("addsTimer")
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(72007) then
		warnFrostbolt:Show()
	elseif args:IsSpellID(70900) then
		warnDarkTransformation:Show()
		if self.Options.SetIconOnDeformedFanatic then
			deformedFanatic = args.sourceGUID
			self:TrySetTarget()
		end
	elseif args:IsSpellID(70901) then
		warnDarkEmpowerment:Show()
		if self.Options.SetIconOnEmpoweredAdherent then
			empoweredAdherent = args.sourceGUID
			self:TrySetTarget()
		end
	end
end


function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellReanimatedFanatic or msg:find(L.YellReanimatedFanatic) then
		self:SendSync("ReanimatedFanatic")
	elseif msg == L.YellDeformedFanatic or msg:find(L.YellDeformedFanatic) then
		self:SendSync("DeformedFanatic")
	end
end

function mod:UNIT_TARGET()
	if empoweredAdherent or deformedFanatic then
		self:TrySetTarget()
	end
end

function mod:OnSync(msg, arg)
	if msg == "DeformedFanatic" then
		warnDeformedFanatic:Show()
	elseif msg == "ReanimatedFanatic" then
		warnReanimating:Show()
	end
end

