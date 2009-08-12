local mod = DBM:NewMod("Jaraxxus", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
mod:SetCreatureID(34780)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)

local warnPortalSoon	= mod:NewAnnounce("PortalSoonWarning", 3)
local warnVolcanoSoon	= mod:NewAnnounce("VolcanoSoonWarning", 3)
local warnFlame			= mod:NewAnnounce("WarnFlame", 3)
local warnTouch		= mod:NewAnnounce("WarnTouch", 3)

local timerFlame 		= mod:NewTargetTimer(6, 68123)
local timerFlameCD		= mod:NewCDTimer(30, 68125) 
local timerFlesh		= mod:NewTargetTimer(12, 67049)
local timerFleshCD		= mod:NewCDTimer(23, 67051) 
local timerPortalCD		= mod:NewCDTimer(120, 67900)
local timerVolcanoCD	= mod:NewCDTimer(120, 67901)
--local timerTouchCD		= mod:NewCDTimer(999, 12345)	-- No idea about the cd timer for this spell

local specWarnFlame		= mod:NewSpecialWarning("SpecWarnFlame")
local specWarnFlesh		= mod:NewSpecialWarning("SpecWarnFlesh")
local specWarnTouch		= mod:NewSpecialWarning("SpecWarnTouch")
local specWarnTouchNear		= mod:NewSpecialWarning("SpecWarnTouchNear", false)
local specWarnKiss		= mod:NewSpecialWarning("SpecWarnKiss", false)

mod:AddBoolOption("LegionFlameWhisper", false, "announce")
mod:AddBoolOption("LegionFlameIcon", true, "announce")
mod:AddBoolOption("IncinerateFleshIcon", true, "announce")
mod:AddBoolOption("TouchJaraxxusIcon", true, "announce")

function mod:OnCombatStart(delay)
	timerVolcano:Start(105-delay)
	timerPortal:Start(45-delay)
	warnVolcanoSoon:Schedule(100-delay)
	warnPortalSoon:Schedule(40-delay)
	timerFleshCD:Start(14-delay)
	timerFlameCD:Start(20-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67051 or args.spellId == 67049 then		-- Incinerate Flesh
		timerFlesh:Start(args.destName)
		timerFleshCD:Start()
		if self.Options.IncinerateFleshIcon then
			self:SetIcon(args.destName, 8, 12)
		end
		if args.destName == UnitName("player") then

			specWarnFlesh:Show()
		end
	elseif args.spellId == 68125 or args.spellId == 68123 then	-- Legion Flame
		local targetname = args.destName
		warnFlame:Show(args.destName)
		timerFlame:Start(args.destName)
		timerFlameCD:Start()
		if self.Options.LegionFlameIcon then
			self:SetIcon(args.destName, 6, 8)
		end
		if DBM:GetRaidRank() >= 1 and self.Options.LegionFlameWhisper then
			self:SendWhisper(L.WhisperFlame, targetname)
		end
		if args.destName == UnitName("player") then
			specWarnFlame:Show()
		end
	elseif args.spellId == 66209 then	-- Touch of Jaraxxus
		-- timerTouchCD:Start()
		warnTouch:Show(args.destName)
		local uId = DBM:GetRaidUnitId(args.destName)
		if args.destName == UnitName("player") then
			specWarnTouch:Show()
		end
		if self.Options.TouchJaraxxusIcon then
			self:SetIcon(args.destName, 7, 12)
		end
		if uId then 
			local inRange = CheckInteractDistance(uId, 2) 
			if inRange then 
				specWarnTouchNear:Show(args.destName) 
			end 
		end
	elseif args.spellId == 67907 then
		if args.destName == UnitName("player") then
			specWarnKiss:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 67051 or args.spellId == 67049 then		-- Incinerate Flesh
		timerFlesh:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 67901 then					-- Infernal Volcano
		timerVolcanoCD:Start()
		warnVolcanoSoon:Schedule(110)
	elseif args.spellId == 67900 or args.spellId == 67898 then	-- Nether Portal
		timerPortalCD:Start()
		warnPortalSoon:Schedule(40)
	end
end
