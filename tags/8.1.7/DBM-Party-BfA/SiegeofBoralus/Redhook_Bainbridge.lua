local dungeonID, creatureID, encounterID
if UnitFactionGroup("player") == "Alliance" then
	dungeonID, creatureID, encounterID = 2132, 128650, 2098--Redhook
else
	dungeonID, creatureID, encounterID = 2133, 130834, 2097--Bainbridge
end
local mod	= DBM:NewMod(dungeonID, "DBM-Party-BfA", 5, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(creatureID)
mod:SetEncounterID(encounterID)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 257459 260954 261428 256709",
	"SPELL_CAST_START 257459 275107 257326 261428 260924",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, cannon barrage detection
--TODO, verify some other spellIds
--Chopper Redhook
local warnOntheHook					= mod:NewTargetNoFilterAnnounce(257459, 2)
local warnMeatHook					= mod:NewCastAnnounce(275107, 2)
--Sergeant Bainbridge
local warnIronGaze					= mod:NewTargetNoFilterAnnounce(260954, 2)

--Chopper Redhook
local specWarnOntheHook				= mod:NewSpecialWarningRun(257459, nil, nil, nil, 4, 2)
local yellOntheHook					= mod:NewYell(257459)
local specWarnGoreCrash				= mod:NewSpecialWarningDodge(257326, nil, nil, nil, 2, 2)
local specWarnHeavySlash			= mod:NewSpecialWarningDodge(279761, "Tank", nil, nil, 1, 2)
--Sergeant Bainbridge
local specWarnIronGaze				= mod:NewSpecialWarningRun(260954, nil, nil, nil, 4, 2)
local yellIronGaze					= mod:NewYell(260954)
local specWarnHangmansNoose			= mod:NewSpecialWarningRun(261428, nil, nil, nil, 4, 2)
local specWarnSteelTempest			= mod:NewSpecialWarningDodge(260924, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)
--BOTH
local specWarnCannonBarrage			= mod:NewSpecialWarningDodge(257540, nil, nil, nil, 2, 2)
--local specWarnAdds					= mod:NewSpecialWarningAdds(257649, "-Healer", nil, nil, 1, 2)

--Chopper Redhook
--local timerOntheHookCD				= mod:NewAITimer(13, 257459, nil, nil, nil, 3)
--local timerGoreCrashCD				= mod:NewAITimer(13, 257326, nil, nil, nil, 3)--24.9, 43.3
--local timerHeavySlashCD				= mod:NewAITimer(13, 279761, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--Shared
--Sergeant Bainbridge
--local timerIronGazeCD				= mod:NewAITimer(13, 260954, nil, nil, nil, 3)
--local timerSteelTempestCD			= mod:NewAITimer(13, 260924, nil, nil, nil, 3)
--local timerHangmansNooseCD			= mod:NewAITimer(13, 261428, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	if dungeonID == 2132 then--Redhook
		--timerOntheHookCD:Start(1-delay)
		--timerGoreCrashCD:Start(1-delay)
	else--Bainbridge
		--timerIronGazeCD:Start(1-delay)
		--timerSteelTempestCD:Start(1-delay)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 260954 then
		if args:IsPlayer() then
			specWarnIronGaze:Show()
			specWarnIronGaze:Play("justrun")
			specWarnIronGaze:ScheduleVoice(1.5, "keepmove")
			yellIronGaze:Yell()
		else
			warnIronGaze:Show(args.destName)
		end
	elseif spellId == 257459 then
		if args:IsPlayer() then
			specWarnOntheHook:Show()
			specWarnOntheHook:Play("justrun")
			specWarnOntheHook:ScheduleVoice(1.5, "keepmove")
			yellOntheHook:Yell()
		else
			warnOntheHook:Show(args.destName)
		end
	elseif spellId == 261428 then
		if args:IsPlayer() then
			specWarnHangmansNoose:Show()
			specWarnHangmansNoose:Play("justrun")
			specWarnHangmansNoose:ScheduleVoice(1.5, "keepmove")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 257459 then
		--timerOntheHookCD:Start()
	elseif spellId == 275107 then
		warnMeatHook:Show()
	elseif spellId == 257326 then
		specWarnGoreCrash:Show()
		specWarnGoreCrash:Play("watchstep")
		--timerGoreCrashCD:Start()
	elseif spellId == 260924 then
		specWarnSteelTempest:Show()
		specWarnSteelTempest:Play("watchstep")
		--timerSteelTempestCD:Start()
	elseif spellId == 261428 then
		--timerHangmansNooseCD:Start()
	elseif spellId == 260954 then
		--timerIronGazeCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 129996 or cid == 138019 or cid == 129879 then--Irontide Cleaver/Kul Tiran Vanguard
		--timerHeavySlashCD:Stop(args.destGUID)
	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257540 then--Cannon Barrage
		specWarnCannonBarrage:Show()
		specWarnCannonBarrage:Play("watchstep")
	--19.7, 18.2, 14.6
	elseif spellId == 274002 then--Call Adds (works fine alliance side, horde side it spams non stop)
		--specWarnAdds:Show()
		--specWarnAdds:Play("mobsoon")
	elseif spellId == 257287 then
		--local guid = UnitGUID(uId)
		if self:AntiSpam(3, 1) then
			specWarnHeavySlash:Show()
			specWarnHeavySlash:Play("shockwave")
		end
		--timerHeavySlashCD:Start(nil, guid)
	end
end
