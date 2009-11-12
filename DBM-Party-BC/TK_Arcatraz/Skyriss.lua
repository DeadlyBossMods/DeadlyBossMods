local mod = DBM:NewMod("Skyriss", "DBM-Party-BC", 15)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(20912)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED",
	"UNIT_HEALTH"
)

--local warnSplitSoon     = mod:NewAnnounce("warnSplitSoon") Doesn't work, just errors. Someone else can fix it I spent enough hours on this.
local warnSplit         = mod:NewAnnounce("warnSplit")
local warnMindControl   = mod:NewTargetAnnounce(39019)
local timerMindControl  = mod:NewTargetTimer(6, 39019)
local warnMindRend      = mod:NewTargetAnnounce(39017)
local timerMindRend     = mod:NewTargetTimer(6, 39017)

local warnedSplit1		= false
local warnedSplit2		= false

function mod:OnCombatStart()
	warnedSplit1 = false
	warnedSplit2 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39019, 37162) then
		warnMindControl:Show(args.destName)
		timerMindControl:Start(args.destName)
	elseif args:IsSpellID(39017) then
		warnMindRend:Show(args.destName)
		timerMindRend:Start(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Split then
        warnSplit:Show()
	end
end

--[[function mod:UNIT_HEALTH(uId)
    if self:GetUnitCreatureID(uId) == 20912 then
        local h = UnitHealth(uId) / UnitHealthMax(uId)
        if h > 0.66 and h < 0.70 and not warnedSplit1 then
           warnSplitSoon:Show()
           warnedSplit1 = true
        elseif h > 0.33 and h < 0.37 and not warnedSplit2 then
           warnSplitSoon:Show()
           warnedSplit2 = true
        end
    end
end--]]