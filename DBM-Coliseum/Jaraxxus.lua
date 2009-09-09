local mod = DBM:NewMod("Jaraxxus", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(34780)
mod:SetMinCombatTime(30)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)


local isDispeller = select(2, UnitClass("player")) == "MAGE"
	    		 or select(2, UnitClass("player")) == "PRIEST"
	    		 or select(2, UnitClass("player")) == "SHAMAN"


local warnPortalSoon		= mod:NewAnnounce("WarnPortalSoon", 3)
local warnVolcanoSoon		= mod:NewAnnounce("WarnVolcanoSoon", 3)
local warnFlame				= mod:NewAnnounce("WarnFlame", 3)
local warnTouch				= mod:NewAnnounce("WarnTouch", 3)
local warnNetherPower		= mod:NewAnnounce("WarnNetherPower", 4)

local timerFlame 			= mod:NewTargetTimer(6, 68123)
local timerFlameCD			= mod:NewCDTimer(30, 68125) 
local timerFlesh			= mod:NewTargetTimer(12, 67049)
local timerFleshCD			= mod:NewCDTimer(23, 67051) 
local timerPortalCD			= mod:NewCDTimer(120, 67900)
local timerVolcanoCD		= mod:NewCDTimer(120, 67901)
--local timerTouchCD		= mod:NewCDTimer(999, 12345)	-- No idea about the cd timer for this spell

local specWarnFlame			= mod:NewSpecialWarning("SpecWarnFlame")
local specWarnFlesh			= mod:NewSpecialWarning("SpecWarnFlesh")
local specWarnTouch			= mod:NewSpecialWarning("SpecWarnTouch")
local specWarnTouchNear		= mod:NewSpecialWarning("SpecWarnTouchNear", false)
local specWarnKiss			= mod:NewSpecialWarning("SpecWarnKiss", false)
local spelWarnNetherPower	= mod:NewSpecialWarning("SpecWarnNetherPower", isDispeller)
local specWarnFelInferno	= mod:NewSpecialWarning("SpecWarnFelInferno")

local enrageTimer			= mod:NewEnrageTimer(600)

mod:AddBoolOption("LegionFlameWhisper", false, "announce")
mod:AddBoolOption("LegionFlameIcon", true, "announce")
mod:AddBoolOption("IncinerateFleshIcon", true, "announce")
mod:AddBoolOption("TouchJaraxxusIcon", true, "announce")

function mod:OnCombatStart(delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerPortalCD:Start(20-delay)
		warnPortalSoon:Schedule(15-delay)
		timerVolcanoCD:Start(60-delay)
		warnVolcanoSoon:Schedule(55-delay)
	else
		timerPortalCD:Start(45-delay)
		warnPortalSoon:Schedule(40-delay)
		timerVolcanoCD:Start(105-delay)
		warnVolcanoSoon:Schedule(100-delay)
	end
	timerFleshCD:Start(14-delay)
	timerFlameCD:Start(20-delay)
	enrageTimer:Start(-delay)
end

do
	local lastflame = 0
	local lastinferno = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(66877, 67070, 67071, 67072) and args:IsPlayer() then		-- Legion Flame
			if GetTime() - 3 > lastflame then
				specWarnFlame:Show()
				lastflame = GetTime()
			end
		elseif args:IsSpellID(66496, 68716, 68717, 68718) and args:IsPlayer() then	-- Fel Inferno
			if GetTime() - 3 > lastinferno then
				specWarnFelInferno:Show()
				lastinferno = GetTime()
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67051, 67050, 67049, 66237) then			-- Incinerate Flesh
		timerFlesh:Start(args.destName)
		timerFleshCD:Start()
		if self.Options.IncinerateFleshIcon then
			self:SetIcon(args.destName, 8, 15)
		end
		if args:IsPlayer() then
			specWarnFlesh:Show()
		end

	elseif args:IsSpellID(66197, 68123, 68124, 68125) then		-- Legion Flame
		local targetname = args.destName
		timerFlame:Start(args.destName)
		timerFlameCD:Start()
		if self.Options.LegionFlameIcon then
			self:SetIcon(args.destName, 6, 8)
		end
		if DBM:GetRaidRank() >= 1 and self.Options.LegionFlameWhisper then
			self:SendWhisper(L.WhisperFlame, targetname)
		end

	elseif args:IsSpellID(66209) then					-- Touch of Jaraxxus		causes Curse of the Nether ID:66210
		-- timerTouchCD:Start()
		warnTouch:Show(args.destName)
		local uId = DBM:GetRaidUnitId(args.destName)
		if args:IsPlayer() then
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

	elseif args:IsSpellID(67907) and args:IsPlayer() then
			specWarnKiss:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(67051, 67050, 67049, 66237) then			-- Incinerate Flesh
		timerFlesh:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(67009) then								-- Nether Power
		warnNetherPower:Show()
		spelWarnNetherPower:Show()

	elseif args:IsSpellID(67901, 67902, 67903, 66258) then		-- Infernal Volcano
		timerVolcanoCD:Start()
		warnVolcanoSoon:Schedule(110)

	elseif args:IsSpellID(67900, 67899, 67898, 66269) then		-- Nether Portal
			timerPortalCD:Start()
			warnPortalSoon:Schedule(40)
	
	elseif args:IsSpellID(66197, 68123, 68124, 68125) then		-- Legion Flame
		warnFlame:Show(args.destName)
	end
end


