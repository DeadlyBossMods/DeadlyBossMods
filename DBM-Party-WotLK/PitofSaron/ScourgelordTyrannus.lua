local mod = DBM:NewMod("ScourgelordTyrannus", "DBM-Party-WotLK", 15)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1665 $"):sub(12, -3))
mod:SetCreatureID(12800)
--mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_PERIODIC_DAMAGE"
)

local timerForcefulSmash	= mod:NewNextTimer(40, 69627) --Experimental, Timer may not be exact
local warnUnholyPower				= mod:NewAnnounce("warnUnholyPower")
local timerUnholyPower				= mod:NewBuffActiveTimer(10, 69629)
local warnOverlordsBrand			= mod:NewTargetAnnounce(69172)
local timerOverlordsBrand				= mod:NewTargetTimer(8, 69172)
local warnHoarfrost				= mod:NewAnnounce("warnHoarfrost")
local specWarnIcyBlast		= mod:NewSpecialWarning("specWarnIcyBlast")

--mod:AddBoolOption("SetIconOnHoarfrostTarget", true) --Needs chatlog data to finish implimentation

function mod:OnCombatStart(delay)
	timerForcefulSmash:Start(-delay)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69629, 69167) then							-- Unholy Power
		warnUnholyPower:Show(args.spellName)
	elseif args:IsSpellID(69246) then							-- Hoarfrost
		warnHoarfrost:Show(args.spellName)
	elseif args:IsSpellID(69155, 69627) then							-- Forceful Smash
	timerForcefulSmash:Start()
	end
end

do 
	local lasticyblast = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(69238, 69628) and args:IsPlayer() and time() - lasticyblast > 2 then		-- Icy Blast, MOVE!
			specWarnIcyBlast:Show()
			lasticyblast = time()
		end
	end
end

	function mod:SPELL_AURA_APPLIED(args)
		if args:IsSpellID(69629, 69167) then							-- Unholy Power
			timerUnholyPower:Show(args.destName)
		elseif args:IsSpellID(69172) then							-- Overlord's Brand
			warnOverlordsBrand:Show(args.destName)
			timerOverlordsBrand:Show(args.destName)
		end
	end
end

