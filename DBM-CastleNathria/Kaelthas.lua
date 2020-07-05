local mod	= DBM:NewMod(2422, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(157602)--Who dies for this fight to win?
--mod:SetMainBossID(131545)--Maybe used, with highest health seen reported for kael at time of wipe?
mod:SetEncounterID(2402)
mod:SetZone()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 325877 329509 329518 328885 325440 325506 333002",
	"SPELL_CAST_SUCCESS 326583 326586",
	"SPELL_AURA_APPLIED 326456 328659 328731 325442 333145 326078",
	"SPELL_AURA_APPLIED_DOSE 326456 325442 326078",
	"SPELL_AURA_REMOVED 328731 326078",
	"SPELL_PERIODIC_DAMAGE 328579",
	"SPELL_PERIODIC_MISSED 328579",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, adjust tank stacks for two swap mechanics
--TODO, Switch Ember Blast to UnitTargetScanner for max scan speed/efficiency, if shade has boss unit ID and isn't already targetting victim when cast starts
--TODO, adjust ember blast warning to reduce number told to soak it if it's not conventional to just tell everyone but the tanks to do it
--TODO, figure out which spellId is the tank only one for Blazing Surge and just use primary target instead of target scanning
--TODO, improve bird spawn handling?
--TODO, is High Torturor Darithos always active? Improve Greater Castigation handling when known
--TODO, detect soul infuser spawns and warn like hell to slow/kill them
--TODO, rapid strikes target scanning or is it like the adds on vexiona where they charge then cast something on arrival and we can't get that target
--TODO, essence tracking of energy for Cultists?
--TODO, dispel warnings for Vulgar brand based on difficulty (magic non mythic, curse mythic)?
--Shade of Kael'thas
local warnBurningRemnants						= mod:NewStackAnnounce(326456, 2, nil, "Tank")
local warnEmberBlast							= mod:NewTargetNoFilterAnnounce(325877, 4)
local warnBlazingSurge							= mod:NewTargetAnnounce(329509, 3)
local warnRebornPhoenix							= mod:NewSpellAnnounce("ej22090", 2, 328659)
--Adds
----Rockbound Vanquisher
local warnVanquished							= mod:NewStackAnnounce(325442, 2, nil, "Tank")
local warnConcussiveSmash						= mod:NewCountAnnounce(325506, 3)
----Assassin
local warnCrimsonTorment						= mod:NewSpellAnnounce(326586, 4)--Fall back warning that'll only fire if special warning is disabled
local warnReturnToStone							= mod:NewTargetNoFilterAnnounce(333145, 4)

--Shade of Kael'thas
local specWarnBurningRemnants					= mod:NewSpecialWarningStack(326456, nil, 18, nil, nil, 1, 6)
local specWarnBurningRemnantsTaunt				= mod:NewSpecialWarningTaunt(326456, nil, nil, nil, 1, 2)
local specWarnEmberBlast						= mod:NewSpecialWarningMoveTo(325877, nil, nil, nil, 1, 2)
local yellEmberBlast							= mod:NewYell(325877, nil, nil, nil, "YELL")
local yellEmberBlastFades						= mod:NewFadesYell(325877, nil, nil, nil, "YELL")
local specWarnBlazingSurge						= mod:NewSpecialWarningMoveAway(329509, nil, nil, nil, 1, 2)
local yellBlazingSurge							= mod:NewYell(329509)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(328579, nil, nil, nil, 1, 8)
--High Torturor Darithos
local specWarnGreaterCastigation				= mod:NewSpecialWarningMoveAway(328885, nil, nil, nil, 2, 2)
--Adds
----Rockbound Vanquisher
local specWarnVanquished						= mod:NewSpecialWarningStack(325442, nil, 18, nil, nil, 1, 6)
local specWarnVanquishedTaunt					= mod:NewSpecialWarningTaunt(325442, nil, nil, nil, 1, 2)
--Assassin
local specWarnCrimsonTorment					= mod:NewSpecialWarningDodge(326586, false, nil, nil, 2, 2)
--Vile Occultist
local specWarnVulgarBrand						= mod:NewSpecialWarningInterrupt(333002, "HasInterrupt", nil, nil, 1, 2)

--Shade of Kael'thas
--mod:AddTimerLine(BOSS)
local timerEmberBlastCD							= mod:NewAITimer(44.3, 325877, nil, nil, nil, 3)
local timerBlazingSurgeCD						= mod:NewAITimer(44.3, 329509, nil, nil, nil, 3)
local timerRebornPhoenixCD						= mod:NewAITimer(44.3, "ej22090", nil, nil, nil, 1, 328659, DBM_CORE_L.DAMAGE_ICON)
--High Torturor Darithos
local timerGreaterCastigationCD					= mod:NewAITimer(44.3, 328885, nil, nil, nil, 2)
--Adds
----Rockbound Vanquisher
local timerVanquishingStrikeCD					= mod:NewAITimer(16.6, 325440, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 2, 3)
--local timerConcussiveSmashCD					= mod:NewNextCountTimer(12.1, 325506, nil, nil, nil, 5)
----Assasssin
local timerRapidStrikesCD						= mod:NewAITimer(44.3, 326583, nil, nil, nil, 3)
----occultist
local timerVulgarBrandCD						= mod:NewAITimer(44.3, 333002, nil, nil, nil, 3)--TODO, give it a relative icon based on difficulty (Magic/Curse)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 328885)
mod:AddInfoFrameOption(326078, true)
mod:AddSetIconOption("SetIconOnEmberBlast", 325877, true, false, {1})
mod:AddNamePlateOption("NPAuraOnPhoenixEmbers", 328731)

local seenAdds = {}
local castsPerGUID = {}
local infuserTargets = {}

function mod:EmberBlastTarget(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnEmberBlast:Show(DBM_CORE_L.ALLIES)
		specWarnEmberBlast:Play("gathershare")
		yellEmberBlast:Yell()
		yellEmberBlastFades:Countdown(5-scanningTime)
	elseif not self:IsTank() then
		specWarnEmberBlast:Show(targetname)
		specWarnEmberBlast:Play("gathershare")
	else
		warnEmberBlast:Show(targetname)
	end
	if self.Options.SetIconOnEmberBlast then
		self:SetIcon(targetname, 1, 6-scanningTime)--So icon clears 1 second after blast
	end
end

function mod:BlazingSurgeTarget(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnBlazingSurge:Show()
		specWarnBlazingSurge:Play("runout")
		yellBlazingSurge:Yell()
	else
		warnBlazingSurge:Show(targetname)
	end
end

local updateInfoFrame
do
	local infusersBoon = DBM:GetSpellInfo(326078)
	local floor = math.floor
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Infuser's Boon targets
		if #infuserTargets > 0 then
			addLine("---"..infusersBoon.."---")
			for i=1, #infuserTargets do
				local name = infuserTargets[i]
				local uId = DBM:GetRaidUnitId(name)
				if uId then
					local _, _, infuserCount, _, _, infuserExpireTime = DBM:UnitDebuff(uId, 326078)
					if infuserCount and infuserExpireTime then--Has count, show count and infuser remaining
						local infuserRemaining = infuserExpireTime-GetTime()
						addLine(i.."*"..name, infuserCount.."-"..floor(infuserRemaining))
					end
				end
			end
		else--Nothing left to track, auto hide
			DBM.InfoFrame:Hide()
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(seenAdds)
	table.wipe(castsPerGUID)
	table.wipe(infuserTargets)
	timerGreaterCastigationCD:Start(1)--Only valid if Darithos is active on pull
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
	if self.Options.NPAuraOnPhoenixEmbers then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(seenAdds)
	table.wipe(castsPerGUID)
	table.wipe(infuserTargets)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnPhoenixEmbers then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 325877 then
		timerEmberBlastCD:Start(18.3, args.sourceGUID)
		self:BossTargetScanner(args.sourceGUID, "EmberBlastTarget", 0.2, 13)--Scans for 2.6 of 5.0 second cast, will adjust later
	elseif spellId == 329509 or spellId == 329518 then
		timerBlazingSurgeCD:Start(18.3, args.sourceGUID)
		self:BossTargetScanner(args.sourceGUID, "BlazingSurgeTarget", 0.1, 12)
	elseif spellId == 328885 then
		specWarnGreaterCastigation:Show()
		specWarnGreaterCastigation:Play("scatter")
		timerGreaterCastigationCD:Start()
	elseif spellId == 325440 then
		--Announce the cast? seems only stacks worth announcing
		timerVanquishingStrikeCD:Start(15, args.sourceGUID)
	elseif spellId == 325506 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local addnumber, count = #castsPerGUID, castsPerGUID[args.sourceGUID]
		warnConcussiveSmash:Show(addnumber.."-"..count)
--		timerConcussiveSmashCD:Start(12.1, count+1, args.sourceGUID)
	elseif spellId == 333002 then
		timerVulgarBrandCD:Start(15, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnVulgarBrand:Show(args.sourceName)
			specWarnVulgarBrand:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 326583 then
		timerRapidStrikesCD:Start(15, args.sourceGUID)
	elseif spellId == 326586 then
		if self:AntiSpam(3, 4) then
			if self.Options.SpecWarn326586dodge then
				specWarnCrimsonTorment:Show()
				specWarnCrimsonTorment:Play("watchstep")
			else
				warnCrimsonTorment:Show()
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 326456 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			if amount >= 18 then--FIXME
				if args:IsPlayer() then
					specWarnBurningRemnants:Show(amount)
					specWarnBurningRemnants:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
						specWarnBurningRemnantsTaunt:Show(args.destName)
						specWarnBurningRemnantsTaunt:Play("tauntboss")
					else
						warnBurningRemnants:Show(args.destName, amount)
					end
				end
			else
				warnBurningRemnants:Show(args.destName, amount)
			end
		end
	elseif spellId == 325442 then
		local amount = args.amount or 1
		if amount >= 18 then--FIXME
			if args:IsPlayer() then
				specWarnVanquished:Show(amount)
				specWarnVanquished:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
					specWarnVanquishedTaunt:Show(args.destName)
					specWarnVanquishedTaunt:Play("tauntboss")
				else
					warnVanquished:Show(args.destName, amount)
				end
			end
		else
			warnVanquished:Show(args.destName, amount)
		end
	elseif spellId == 328659 and not seenAdds[args.destGUID] then--Smoldering Plumage
		seenAdds[args.destGUID] = true
		if self:AntiSpam(5, 1) then--In case more than one spawn at once
			warnRebornPhoenix:Show()
			timerRebornPhoenixCD:Start()
		end
	elseif spellId == 328731 then
		if self.Options.NPAuraOnPhoenixEmbers then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 20)
		end
	elseif spellId == 333145 then
		warnReturnToStone:Show(args.destName)
	elseif spellId == 326078 then
		if not tContains(infuserTargets, args.destName) then
			table.insert(infuserTargets, args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(OVERVIEW)
			DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 328731 then
		if self.Options.NPAuraOnPhoenixEmbers then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 326078 then
		infuserTargets[args.destName] = nil
	end
end

--https://shadowlands.wowhead.com/npc=165762/soul-infuser
--https://shadowlands.wowhead.com/npc=168700/pestering-fiend
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165805 then--Shade of Kael'thas
		--Timers are started and canceled by GUID in case more than one Shade can be out at a time
		--While this is entirely unlikely in current content, it might happen when content becomes trivial
		timerEmberBlastCD:Stop(args.destGUID)
		timerBlazingSurgeCD:Stop(args.destGUID)
		timerRebornPhoenixCD:Stop()--Hard to GUID owner with current implimentation, will change if possible
--	elseif cid == 168962 then--Reborn Phoenix

	elseif cid == 168973 then--High Torturer Darithos
		timerGreaterCastigationCD:Stop()
	elseif cid == 165764 then--Rockbound Vanquisher
		timerVanquishingStrikeCD:Stop(args.destGUID)
		--timerConcussiveSmashCD:Stop(castsPerGUID[args.destGUID]+1, args.destGUID)
	elseif cid == 167566 then--bleakwing-assassin
		timerRapidStrikesCD:Stop(args.destGUID)
	elseif cid == 165763 then--vile-occultist
		timerVulgarBrandCD:Stop(args.destGUID)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 328579 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
--https://shadowlands.wowhead.com/spell=336658/reborn-phoenix-exit
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 336658 then

	end
end
--]]
