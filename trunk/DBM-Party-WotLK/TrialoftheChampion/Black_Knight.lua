local mod = DBM:NewMod("BlackKnight", "DBM-Party-WotLK", 13)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(35451, 10000)		-- work around, DBM API failes to handle a Boss to die, rebirth, die again, rebirth again and die to loot...
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE"
)

local warnExplode				= mod:NewAnnounce("warnExplode")
local warnGhoulExplode			= mod:NewTargetAnnounce(67751)
local warnMarked				= mod:NewTargetAnnounce(67823)
local timerMarked				= mod:NewTargetTimer(10, 67823)
local specWarnDesecration		= mod:NewSpecialWarning("specWarnDesecration")

mod:AddBoolOption("SetIconOnMarkedTarget", false)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(67729, 67886) then							-- Explode (elite explodes self, not BK. Phase 2)
		warnExplode:Show()
	end
end

do 
	local lastdesecration = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(67781, 67876) and args:IsPlayer() and time() - lastdesecration > 2 then		-- Desecration, MOVE!
			specWarnDesecration:Show()
			lastdesecration = time()
		end
	end
end

do
	local lastexplode = 0
	function mod:SPELL_AURA_APPLIED(args)
		if args:IsSpellID(67823, 67882) then							-- Marked For Death
			if self.Options.SetIconOnMarkedTarget then
				self:SetIcon(args.destName, 8, 10)
			end
			warnMarked:Show(args.destName)
			timerMarked:Show(args.destName)
		elseif args:IsSpellID(67751) and time() - lastexplode > 2 then	-- Ghoul Explode (BK exlodes Army of the dead. Phase 3)
			warnGhoulExplode:Show(args.destName)
			lastexplode = time()
		end
	end
end

