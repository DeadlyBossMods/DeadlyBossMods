local mod	= DBM:NewMod("Valithria", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36789)
mod:SetUsedIcons(8)
mod:RegisterCombat("yell", L.YellPull)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_TARGET"
)

local warnCorrosion		= mod:NewAnnounce("warnCorrosion", 2, nil, false)
local warnGutSpray		= mod:NewTargetAnnounce(71283)
local warnManaVoid		= mod:NewSpellAnnounce(71741)
local warnSupression	= mod:NewSpellAnnounce(70588)
local warnPortalSoon	= mod:NewSoonAnnounce(71987)
local warnPortal		= mod:NewSpellAnnounce(71987)

local specWarnLayWaste	= mod:NewSpecialWarningSpell(71730)

local timerLayWaste		= mod:NewBuffActiveTimer(12, 69325)
local timerNextPortal	= mod:NewCDTimer(46, 71987)
local timerGutSpray		= mod:NewTargetTimer(12, 71283)
local timerCorrosion	= mod:NewTargetTimer(6, 70751)

local berserkTimer	= mod:NewBerserkTimer(420)--Seems to exist just kinda funny, the adds just blow you up, not her

mod:AddBoolOption("SetIconOnBlazingSkeleton", true)

local GutSprayTargets = {}
local spamSupression = 0
local BlazingSkeleton

local function warnGutSprayTargets()
	warnGutSpray:Show(table.concat(GutSprayTargets, "<, >"))
	table.wipe(GutSprayTargets)
end

function mod:OnCombatStart(delay)
	warnPortalSoon:Schedule(41-delay)
	timerNextPortal:Start(-delay)
	berserkTimer:Start(-delay)
	BlazingSkeleton = nil
end

function mod:TrySetTarget()
	if DBM:GetRaidRank() >= 1 then
		for i = 1, GetNumRaidMembers() do
			if UnitGUID("raid"..i.."target") == BlazingSkeleton then
				BlazingSkeleton = nil
				SetRaidTarget("raid"..i.."target", 8)
			end
			if not BlazingSkeleton then
				break
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(70754, 71748) then--Fireball (its the first spell Blazing SKeleton's usually cast upon spawning)
		if self.Options.SetIconOnBlazingSkeleton then
			BlazingSkeleton = args.sourceGUID
			self:TrySetTarget()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(71741) then--Mana Void (spellids drycoded, will confirm later)
		warnManaVoid:Show()
	elseif args:IsSpellID(70588) and GetTime() - spamSupression > 5 then--Supression
		warnSupression:Show(args.destName)
		spamSupression = GetTime()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) then--Gut Spray (spellids drycoded, will confirm later)
		GutSprayTargets[#GutSprayTargets + 1] = args.destName
		timerGutSpray:Start(args.destName)
		self:Unschedule(warnGutSprayTargets)
		self:Schedule(0.3, warnGutSprayTargets)
	elseif args:IsSpellID(70751) then--Corrosion (spellids drycoded, will confirm later)
		warnCorrosion:Show(args.spellName, args.destName, args.amount or 1)
		timerCorrosion:Start(args.destName)
	elseif args:IsSpellID(69325, 71730) then--Lay Waste (spellids drycoded, will confirm later)
		specWarnLayWaste:Show()
		timerLayWaste:Start()
		if self.Options.SetIconOnBlazingSkeleton then
			BlazingSkeleton = args.sourceGUID
			self:TrySetTarget()
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) then--Gut Spray (spellids drycoded, will confirm later)
		timerGutSpray:Cancel(args.destName)
	elseif args:IsSpellID(69325, 71730) then--Lay Waste (spellids drycoded, will confirm later)
		timerLayWaste:Cancel()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPortals or msg:find(L.YellPortals) then
		self:SendSync("NightmarePortal")
	end
end

function mod:OnSync(msg, arg)
	if msg == "NightmarePortal" then
		warnPortal:Show()
		warnPortalSoon:Schedule(41)
		timerNextPortal:Start()
	end
end

function mod:UNIT_TARGET()
	if BlazingSkeleton then
		self:TrySetTarget()
	end
end