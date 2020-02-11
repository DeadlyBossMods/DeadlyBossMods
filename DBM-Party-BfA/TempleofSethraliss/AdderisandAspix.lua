local mod	= DBM:NewMod(2142, "DBM-Party-BfA", 6, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(133379, 133944)
mod:SetEncounterID(2124)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 263246 263371",
	"SPELL_AURA_REMOVED 263246 263371",
	"SPELL_CAST_START 263257 263318 263775 263234 263309 263365",
	"SPELL_CAST_SUCCESS 263371 263424 263425",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2",
	"UNIT_TARGET_UNFILTERED"
)

--TODO, target scan/warn Gale Force target if possible
--TODO, get a LONG pull so timer work can be actually figured out. VIDEO too
local warnLightningShield			= mod:NewTargetNoFilterAnnounce(263246, 3)
--Aspix
local warnConduction				= mod:NewTargetAnnounce(263371, 2)
--Adderis

--Aspix
----Lighting
local specWarnJolt					= mod:NewSpecialWarningInterrupt(263318, "HasInterrupt", nil, nil, 1, 2)
local specWarnConduction			= mod:NewSpecialWarningMoveAway(263371, nil, nil, nil, 3, 2)
local yellConduction				= mod:NewYell(263371)
local yellConductionFades			= mod:NewShortFadesYell(263371)
local specWarnStaticShock			= mod:NewSpecialWarningSpell(263257, nil, nil, nil, 2, 2)
----Wind
local specWarnGust					= mod:NewSpecialWarningInterrupt(263775, "HasInterrupt", nil, nil, 1, 2)
local specWarnGaleForce				= mod:NewSpecialWarningSpell(263776, nil, nil, nil, 2, 2)
--Adderis
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)
local specWarnCycloneStrike			= mod:NewSpecialWarningYou(263573, nil, nil, nil, 3, 2)
local specWarnCycloneStrikeOther	= mod:NewSpecialWarningDodge(263573, nil, nil, nil, 3, 2)
local yellCycloneStrike				= mod:NewYell(263573)
local specWarnPearlofThunder		= mod:NewSpecialWarningRun(263365, nil, nil, nil, 4, 2)

--Aspix
----Lighting
local timerConductionCD				= mod:NewCDTimer(13, 263371, nil, nil, nil, 3)--NYI
local timerStaticShockCD			= mod:NewCDTimer(13, 263257, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
----Wind
local timerGaleForceCD				= mod:NewCDTimer(16.4, 263776, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--Adderis
----Wind
local timerArcingBladeCD			= mod:NewCDTimer(13.4, 263234, nil, nil, nil, 5, nil, DBM_CORE_HEROIC_ICON)
local timerCycloneStrikeCD			= mod:NewCDTimer(14.6, 263573, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
----Lighting
local timerPearlofThunderCD			= mod:NewAITimer(13, 263365, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerArcDashCD				= mod:NewCDTimer(23, 263424, nil, nil, nil, 3)

mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(263246, true)
mod:AddSetIconOption("SetIconOnNoLit", 263246, true, true, {8})

mod.vb.noLitShield = nil

function mod:CycloneTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnCycloneStrike:Show()
		specWarnCycloneStrike:Play("targetyou")
		yellCycloneStrike:Yell()
	else
		specWarnCycloneStrikeOther:Show()
		specWarnCycloneStrikeOther:Play("shockwave")
	end
end

function mod:OnCombatStart(delay)
	self.vb.noLitShield = nil
	--Adderis should be in winds, Aspix timers started by Lightning Shield buff
	timerCycloneStrikeCD:Start(9-delay)
	if not self:IsNormal() then
		timerArcingBladeCD:Start(7.3-delay)
	end
	--Aspix
	timerArcDashCD:Start(14-delay)--Seems to be used regardless of shield
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 263246 then--Lightning Shield
		warnLightningShield:Show(args.destName)
		warnLightningShield:Play("targetchange")
		local cid = self:GetCIDFromGUID(args.destGUID)
		--Start lightning timers and stop wind
		if cid == 133379 then--Adderis
			timerArcingBladeCD:Stop()
			timerCycloneStrikeCD:Stop()
			timerPearlofThunderCD:Start(2)
			--timerArcDashCD:Start(11.2)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		elseif cid == 133944 then--Aspix
			timerConductionCD:Start(11.6)
			timerStaticShockCD:Start(20)
			if not self:IsNormal() then
				--No Doubt wrong
				timerGaleForceCD:Stop()
				timerGaleForceCD:Start(26.7)
			end
		end
	elseif spellId == 263371 then
		if args:IsPlayer() then
			specWarnConduction:Show()
			specWarnConduction:Play("runout")
			yellConduction:Yell()
			yellConductionFades:Countdown(5)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		else
			warnConduction:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 263246 then--Lightning Shield
		self.vb.noLitShield = args.destGUID
		local cid = self:GetCIDFromGUID(args.destGUID)
		--Start wind timers and stop lightning
		if cid == 133379 then--Adderis
			timerPearlofThunderCD:Stop()
			--timerArcDashCD:Stop()
			--timerCycloneStrikeCD:Start(2)
			if not self:IsNormal() then
				--timerArcingBladeCD:Start(2)
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		elseif cid == 133944 then--Aspix
			timerConductionCD:Stop()
			timerStaticShockCD:Stop()
		end
	elseif spellId == 263371 then
		if args:IsPlayer() then
			yellConductionFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 263257 then
		specWarnStaticShock:Show()
		specWarnStaticShock:Play("aesoon")
		--timerStaticShockCD:Start()
	elseif spellId == 267818 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnJolt:Show(args.sourceName)
		specWarnJolt:Play("kickcast")
	elseif spellId == 263775 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnGust:Show(args.sourceName)
		specWarnGust:Play("kickcast")
	elseif spellId == 263234 then
		timerArcingBladeCD:Start()
	elseif spellId == 263309 then
		timerCycloneStrikeCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "CycloneTarget", 0.04, 16)--give 0.2 delay before scan start.
	elseif spellId == 263365 then
		specWarnPearlofThunder:Show()
		specWarnPearlofThunder:Play("justrun")
		timerPearlofThunderCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 263371 then
		--timerConductionCD:Start()
	elseif spellId == 263425 and self:AntiSpam(3, 1) then--263424?
		timerArcDashCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 133379 then--Adderis
		timerPearlofThunderCD:Stop()
		timerArcDashCD:Stop()
		timerCycloneStrikeCD:Stop()
		timerArcingBladeCD:Stop()
	elseif cid == 133944 then--Aspix
		timerConductionCD:Stop()
		timerStaticShockCD:Stop()
		timerGaleForceCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 263776 then--Gale Force
		specWarnGaleForce:Show()
		specWarnGaleForce:Play("specialsoon")
		timerGaleForceCD:Start()
	end
end

do
	local function TrySetTarget(self)
		if DBM:GetRaidRank() >= 1 then
			for uId in DBM:GetGroupMembers() do
				if UnitGUID(uId.."target") == self.vb.noLitShield then
					self.vb.noLitShield = nil
					local icon = GetRaidTargetIndex(uId)
					if not icon then
						SetRaidTarget(uId.."target", 8)
						break
					end
				end
				if not (self.vb.noLitShield) then
					break
				end
			end
		end
	end

	function mod:UNIT_TARGET_UNFILTERED()
		if self.Options.SetIconOnNoLit and self.vb.noLitShield then
			TrySetTarget(self)
		end
	end
end
