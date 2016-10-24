local mod	= DBM:NewMod(1837, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114312)
mod:SetEncounterID(1961)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227672 227578 227545",
	"SPELL_CAST_SUCCESS 227872 227737",
	"SPELL_AURA_APPLIED 227832 227616",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
)

--TODO, build more upon CC list and make sure it actually works
--Moroes
local warnVanish					= mod:NewSpellAnnounce(227737, 2)
local warnGhastlyPurge				= mod:NewSpellAnnounce(227872, 4)
--Baroness Dorothea Millstipe
local warnManaDrain					= mod:NewCastAnnounce(227545, 3)
--Lady Lady Catriona Von'Indi
local warnHealingStream				= mod:NewCastAnnounce(227578, 4)
--Lady Keira Berrybuck
local warnEmpoweredArms				= mod:NewTargetAnnounce(227616, 3)

--Moroes
local specWarnCoatCheck				= mod:NewSpecialWarningDefensive(227832, nil, nil, nil, 1, 2)
local specWarnCoatCheckHealer		= mod:NewSpecialWarningDispel(227832, "Healer", nil, nil, 1, 2)
--Lord Crispin Ference
local specWarnWillBreaker			= mod:NewSpecialWarningSpell(227832, "Tank", nil, nil, 1, 2)

--Moroes
local timerCoatCheckCD				= mod:NewAITimer(40, 227832, nil, "Tank|Healer", nil, 5)
--Lady Lady Catriona Von'Indi
local timerHealingStreamCD			= mod:NewAITimer(40, 227578, nil, nil, nil, 0)--Interruptable via stun?
--Lord Crispin Ference
local timerWillBreakerCD			= mod:NewAITimer(40, 227832, nil, "Tank", nil, 5)

--local berserkTimer					= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

--Moroes
local voiceCoatCheck				= mod:NewVoice(227832)--defensive/dispelnow
--Lord Crispin Ference
local voiceWillBreaker				= mod:NewVoice(227832, "Tank")--shockwave

--mod:AddSetIconOption("SetIconOnCharge", 198006, true)
mod:AddInfoFrameOption(227909, true)

local updateInfoFrame, sortInfoFrame
do
	local ccList = {
		[1] = GetSpellInfo(227909),--Trap included with fight
		[2] = GetSpellInfo(6770),--Rogue Sap
		[3] = GetSpellInfo(9484),--Priest Shackle
		[4] = GetSpellInfo(20066),--Paladin Repentance
		[5] = GetSpellInfo(118),--Mage Polymorph
		[6] = GetSpellInfo(51514),--Shaman Hex
		[7] = GetSpellInfo(3355),--Hunter Freezing Trap
	}
	local lines = {}
	local UnitDebuff, floor = UnitDebuff, math.floor
	sortInfoFrame = function(a, b)
		local a = lines[a]
		local b = lines[b]
		if not tonumber(a) then a = -1 end
		if not tonumber(b) then b = -1 end
		if a < b then return true else return false end
	end
	updateInfoFrame = function()
		table.wipe(lines)
		for i = 1, 5 do
			local uId = "boss"..i
			if UnitExists(uId) then
				for s = 1, 7 do
					local spellName = ccList[s]
					local _, _, _, _, _, _, expires = UnitDebuff(uId, spellName)
					if expires then
						local debuffTime = expires - GetTime()
						lines[UnitName(uId)] = floor(debuffTime)
						break
					end
				end
			end
		end
		return lines
	end
end

function mod:OnCombatStart(delay)
	timerCoatCheckCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(GetSpellInfo(227909))
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, sortInfoFrame, true)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227672 then
		specWarnWillBreaker:Show()
		voiceWillBreaker:Play("shockwave")
		timerWillBreakerCD:Start()
	elseif spellId == 227578 then
		warnHealingStream:Show()
		timerHealingStreamCD:Start()
	elseif spellId == 227545 then
		warnManaDrain:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227872 then
		warnGhastlyPurge:Show()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 227737 then
		warnVanish:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227832 then
		timerCoatCheckCD:Start()
		if args:IsPlayer() then
			specWarnCoatCheck:Show()
			voiceCoatCheck:Play("defensive")
		else
			specWarnCoatCheckHealer:Show(args.destName)
			if self.Options.SpecWarn227832dispel then
				voiceCoatCheck:Play("dispelnow")
			end
		end
	elseif spellId == 227616 then
		warnEmpoweredArms:Show(args.destName)
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 198006 then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 115440 then--baroness-dorothea-millstipe

	elseif cid == 114317 then--lady-catriona-vonindi
		timerHealingStreamCD:Stop()
	elseif cid == 115439 then--baron-rafe-dreuger
	
	elseif cid == 114319 then--lady-keira-berrybuck
		
	elseif cid == 114320 then--lord-robin-daris
			
	elseif cid == 115441 then--lord-crispin-ference
		timerWillBreakerCD:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 206341 then
	
	end
end
--]]
