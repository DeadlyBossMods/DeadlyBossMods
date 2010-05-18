local mod	= DBM:NewMod("Baltharus", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39751)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH"
)

local warningSplitSoon		= mod:NewAnnounce("WarningSplitSoon", 2)
local warningSplitNow		= mod:NewAnnounce("WarningSplitNow", 3)
local warningWarnBrand		= mod:NewTargetAnnounce(74505)

local specWarnWhirlwind		= mod:NewSpecialWarningRun(75127, mod:IsMelee())
local specWarnBrand			= mod:NewSpecialWarningYou(74505)

local timerWhirlwindCD		= mod:NewCDTimer(22, 75127)
local timerWhirlwind		= mod:NewBuffActiveTimer(4, 75127)
local timerBrand			= mod:NewTargetTimer(10, 74505)

local soundWhirlwind 		= mod:NewSound(75127, nil, mod:IsMelee())
mod:AddBoolOption("SetIconOnBrand", true)

local warnedSplit		= false
local brandTargets = {}
local brandIcon	= 8

local function showBrandWarning()
	warningWarnBrand:Show(table.concat(brandTargets, "<, >"))
	table.wipe(brandTargets)
end

function mod:OnCombatStart(delay)
	timerWhirlwindCD:Start(15.5-delay)
	warnedSplit = false
	table.wipe(brandTargets)
	brandIcon = 8
end

--[[function mod:SPELL_CAST_SUCCESS(args)--Use spell cast success if aura apply is bad from hoping.
	if args:IsSpellID(74505) then
		brandTargets[#brandTargets + 1] = args.destName
		timerBrand:Show(args.destName)
		if args:IsPlayer() then
			specWarnBrand:Show()
		end
		if self.Options.SetIconOnBrand then
			self:SetIcon(args.destName, brandIcon, 10)
			brandIcon = brandIcon - 1
		end
		self:Unschedule(showBrandWarning)
		self:Schedule(0.3, showBrandWarning)
	end
end--]]

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(75127, 75125) and args:GetSrcCreatureID() == 39751 then --(Ignore bladestorm from the clone. Only show from original since clone will SHOULD be pulled out.)
		specWarnWhirlwind:Show()
		timerWhirlwindCD:Start()
		timerWhirlwind:Show()
		soundWhirlwind:Play()
	elseif args:IsSpellID(74505) then
		brandTargets[#brandTargets + 1] = args.destName
		timerBrand:Show(args.destName)
		if args:IsPlayer() then
			specWarnBrand:Show()
		end
		if self.Options.SetIconOnBrand then
			if 	brandIcon < 1 then	--Icons are gonna be crazy on this fight if people don't control jumps, we will use ALL of them and only reset icons if we run out of them
				brandIcon = 8
			end
			self:SetIcon(args.destName, brandIcon, 10)
			brandIcon = brandIcon - 1
		end
		self:Unschedule(showBrandWarning)
		self:Schedule(0.3, showBrandWarning)
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedSplit and self:GetUnitCreatureId(uId) == 39751 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		warnedSplit = true
		warningSplitSoon:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SplitTrigger then
		self:SendSync("Split")
	end
end

function mod:OnSync(msg, arg)
	if msg == "Split" then
		warningSplitNow:Show()
	end
end