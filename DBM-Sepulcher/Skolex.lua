local mod	= DBM:NewMod(2465, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181395)
mod:SetEncounterID(2542)
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20211203000000)
mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 359770 359829 364778 359979 359975 360451",
--	"SPELL_CAST_SUCCESS 364893",
	"SPELL_AURA_APPLIED 359778 364522 359976 359981",
	"SPELL_AURA_APPLIED_DOSE 359778 359976 359981",
	"SPELL_AURA_REMOVED 359778",
	"SPELL_AURA_REMOVED_DOSE 359778",
	"SPELL_PERIODIC_DAMAGE 366070",
	"SPELL_PERIODIC_MISSED 366070",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, probably use https://ptr.wowhead.com/spell=359777/unending-hunger to resume timers at REMOVED, if it's in combat log
--TODO, do timers estart when raid triggers a hunger, or do they pause?
--TODO, maybe go all out with some ra-den level shit and calculate who's tank
--then calculate 3 furhtest targets from tank (which assumes they're also 3 furthest from boss
--which then enables showing them on infoframe, marking them, and even auto rangecheck opening if player is one of the 3, for Dust Blast mechanic
--TODO, is tank weapon and dust blast still a combined mechanic? it no longer mentioned this way and leaves one to wonder. For now timer name was changed to be sure it's tied to tank mechanic and if sep, adding a new dust blast timer later will be trivial
--[[
(ability.id = 359770 or ability.id = 359829 or ability.id = 359979 or ability.id = 359975 or ability.id = 364778 or ability.id = 360451) and type = "begincast"
 or ability.id = 364893 and type = "cast"
--]]
local warnDustFlail								= mod:NewCountAnnounce(359829, 2)
local warnRend									= mod:NewStackAnnounce(359979, 2, nil, "Tank|Healer")
local warnRift									= mod:NewStackAnnounce(359976, 2, nil, "Tank|Healer")
local warnDestroy								= mod:NewCastAnnounce(364778, 4)

local specWarnRaveningBurrow					= mod:NewSpecialWarningCount(359770, nil, nil, nil, 2, 2)
local specWarnDustFlail							= mod:NewSpecialWarningCount(359829, "Healer", nil, nil, 2, 2)
local specWarnRetch								= mod:NewSpecialWarningDodge(360448, nil, nil, nil, 2, 2)
local specWarnDevouringBlood					= mod:NewSpecialWarningDispel(364522, false, nil, nil, 1, 2)--Opt in
local specWarnRiftmaw							= mod:NewSpecialWarningTaunt(359976, nil, nil, nil, 1, 2)
local specWarnRend								= mod:NewSpecialWarningTaunt(359979, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(366070, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerDustflailCD							= mod:NewCDTimer(17, 359829, nil, nil, nil, 2)
local timerRetchCD								= mod:NewCDTimer(24.2, 360448, nil, nil, nil, 3)
--local timerDustBlastCD						= mod:NewCDTimer(24.2, 359905, nil, nil, nil, 2)
local timerRiftmawCD							= mod:NewCDTimer(24.2, 359976, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--used for tank combo and blast, it's all together

local berserkTimer								= mod:NewBerserkTimer(360)--Final Consumption

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(359778, true)
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

mod.vb.hungerCount = 0
mod.vb.dustCount = 0
mod.vb.comboCount = 0
local EphemeraDustStacks = {}

function mod:OnCombatStart(delay)
	table.wipe(EphemeraDustStacks)
	self.vb.hungerCount = 0
	self.vb.dustCount = 0
	self.vb.comboCount = 0
	timerDustflailCD:Start(2-delay)
	timerRiftmawCD:Start(10.5-delay)
	timerRetchCD:Start(25.1-delay)
	berserkTimer:Start(360-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(359778))
		DBM.InfoFrame:Show(20, "table", EphemeraDustStacks, 1)
	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 359770 then
		self.vb.hungerCount = self.vb.hungerCount + 1
		specWarnRaveningBurrow:Show(self.vb.hungerCount)
		specWarnRaveningBurrow:Play("specialsoon")
		--Reset other spell counts
		self.vb.dustCount = 0
		--Boss energy doesn't reset, Timers continue but just get queued up and then unqueud after
		--TODO, maybe time to any timers if < 5 seconds remaining on them, but first want to see if they make changes to bosses enery, it has some bugs
	elseif spellId == 359829 then
		self.vb.dustCount = self.vb.dustCount + 1
		if self.Options.SpecWarn359829count then
			specWarnDustFlail:Show(self.vb.dustCount)
			specWarnDustFlail:Play("aesoon")
		else
			warnDustFlail:Show(self.vb.dustCount)
		end
		timerDustflailCD:Start()
	elseif args:IsSpellID(359979, 359975) then--Rend, Riftmaw
--		if self:AntiSpam(20, 1) then
--			self.vb.comboCount = 0
--			timerRiftmawCD:Start()
--		end
		self.vb.comboCount = self.vb.comboCount + 1
	elseif spellId == 364778 then
		warnDestroy:Show()
		--This really shouldn't be a thing and I hope they fix it by next test
--		timerDustflailCD:Pause()
--		timerRetchCD:Pause()
--		timerRiftmawCD:Pause()
	elseif spellId == 360451 then
		specWarnRetch:Show()
		specWarnRetch:Play("shockwave")
		timerRetchCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 364893 then
		timerDustflailCD:Resume()
		timerRetchCD:Resume()
		timerRiftmawCD:Resume()
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 359778 then
		local amount = args.amount or 1
		EphemeraDustStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(EphemeraDustStacks, 0.2)
		end
	elseif spellId == 364522 and args:IsDestTypePlayer() and self:CheckDispelFilter() then
		specWarnDevouringBlood:CombinedShow(0.5, args.destName)
		specWarnDevouringBlood:ScheduleVoice(0.5, "helpdispel")
	--Begin copy paste from Grong
	elseif spellId == 359976 then--Riftmaw
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if not args:IsPlayer() then
				--always swap after a rift if combo is only at 1 or 2, because rift CAN be 3rd cast of a combo.
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) and self.vb.comboCount < 3 then
					specWarnRiftmaw:Show(args.destName)
					specWarnRiftmaw:Play("tauntboss")
				else
					warnRift:Show(args.destName, amount)
				end
			else
				warnRift:Show(args.destName, amount)
			end
		end
	elseif spellId == 359981 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if not args:IsPlayer() then
				--Taunt at 2 stacks of rend, if combo count less than 3 (basically any combo starting with rend rend x) to make sure tank doesn't get a 3rd rend
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) and amount >= 2 then--Can't taunt less you've dropped yours off, period.
					specWarnRend:Show(args.destName)
					specWarnRend:Play("tauntboss")
				else--only 1 stack, or no risk of it being a rend rend rend combo
					warnRend:Show(args.destName, amount)
				end
			else
				warnRend:Show(args.destName, amount)
			end
		end
	--End copy paste from Grong
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 359778 then
		EphemeraDustStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(EphemeraDustStacks, 0.2)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 359778 then
		EphemeraDustStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(EphemeraDustStacks, 0.2)
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 180323 then

	end
end
-]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 366070 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 360079 then--[DNT] Tank Combo
		self.vb.comboCount = 0
		timerRiftmawCD:Start()
	end
end
