local mod	= DBM:NewMod("Shannox", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53691)
mod:SetModelID(38448)
mod:SetZone()
mod:SetUsedIcons(6, 8) -- cross(7) is hard to see in redish environment?

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnFaceRage	= mod:NewTargetAnnounce(99945, 4)
local warnRage		= mod:NewTargetAnnounce(100415, 3)
local warnWary		= mod:NewTargetAnnounce(100167, 2, nil, false)	-- which hound has this buff?
local warnTears		= mod:NewStackAnnounce(99937, 3)
local warnSpear		= mod:NewSpellAnnounce(100002, 3)

local timerRage		= mod:NewTargetTimer(15, 100415)
local timerWary		= mod:NewTargetTimer(25, 100167, nil, false)
local timerTears	= mod:NewTargetTimer(30, 99937)

local specWarnRage	= mod:NewSpecialWarningYou(100415)
local specWarnTears	= mod:NewSpecialWarningStack(99937, 5, nil, mod:IsTank())

mod:AddBoolOption("SetIconOnFaceRage")
mod:AddBoolOption("SetIconOnRage")

local spamFaceRage = 0
function mod:OnCombatStart(delay)
	spamFaceRage = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(100415) then
		warnRage:Show(args.destName)
		timerRage:Start(args.destName)
		if args:IsPlayer() then
			specWarnRage:Show()
		end
		if self.Options.SetIconOnRage then
			self:SetIcon(args.destName, 6, 15)
		end
	elseif args:IsSpellID(100167) then
		warnWary:Show(args.destName)
		timerWary:Start(args.destName)
	elseif args:IsSpellID(99937) then
		if args.amount or 0 % 2 == 0 then	-- announce: 1 - 2 - 4 - 6 - 8 stacks
			warnTears:Show(args.destName, args.amount or 1)
		end
		if args.amount or 0 >= 5 then		-- tank switch @ 5?
			specWarnTears:Show()
		end
		timerTears:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99945) then
		if self.Options.SetIconOnFaceRage then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(100002, 100031) then
		warnSpear:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99945) and GetTime() - spamFaceRage > 3 then
		warnFaceRage:Show(args.destName)
		spamFaceRage = GetTime()
		if self.Options.SetIconOnFaceRage then
			self:SetIcon(args.destName, 8)
		end
	end
end

