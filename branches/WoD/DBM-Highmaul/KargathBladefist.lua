local mod	= DBM:NewMod(1128, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79459)
mod:SetEncounterID(1721)
mod:SetZone()
--mod:SetUsedIcons(7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 159113",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 159947 159250 158986 159178",
	"SPELL_AURA_APPLIED_DOSE 159178",
	"SPELL_AURA_REMOVED 159250",
	"SPELL_PERIODIC_DAMAGE 159413",
	"SPELL_PERIODIC_MISSED 159413"
)

--TODO verify target scanning when http://beta.wowhead.com/spell=159212 is used (blade rush interval spell)
--TODO, when iron bombers appear, change to range 10 for http://beta.wowhead.com/spell=160952
local warnChainHurl					= mod:NewTargetAnnounce(159947, 3)--Warn for cast too?
local warnBladeDance				= mod:NewSpellAnnounce(159250, 3)
local warnBerserkerRush				= mod:NewTargetAnnounce(158986, 4)
local warnOpenWounds				= mod:NewStackAnnounce(159178, 2, nil, mod:IsTank())
local warnImpale					= mod:NewSpellAnnounce(159113, 3)

local specWarnChainHurl				= mod:NewSpecialWarningYou(159947)
local specWarnBladeDance			= mod:NewSpecialWarningSpell(159250, nil, nil, nil, 2)
local specWarnBladeDanceEnded		= mod:NewSpecialWarningEnd(159250)
local specWarnBerserkerRushOther	= mod:NewSpecialWarningTarget(158986, nil, nil, nil, 2)
local specWarnBerserkerRush			= mod:NewSpecialWarningYou(158986, nil, nil, nil, 3)
local yellBerserkerRush				= mod:NewYell(158986)
local specWarnImpale				= mod:NewSpecialWarningSpell(159113, mod:IsTank())
--local specWarnOpenWounds			= mod:NewSpecialWarningStack(159178, nil, 1)--2 stacks? or swap every impale?
local specWarnOpenWoundsOther		= mod:NewSpecialWarningTaunt(159178)--If it is swap every impale, will move this to impale cast and remove stack stuff all together.
local specWarnMaulingBrew			= mod:NewSpecialWarningMove(159413)

--local timerChainHurlCD			= mod:NewNextTimer(30, 159947)
--local timerBerserkerRushCD		= mod:NewNextTimer(30, 158986)

mod:AddRangeFrameOption("7/4")

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(4)--For Mauling Brew splash damage.
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 159113 then
		warnImpale:Show()
		specWarnImpale:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 159947 then
		warnChainHurl:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnChainHurl:Show()
		end
	elseif spellId == 159250 then
		warnBladeDance:Show()
		specWarnBladeDance:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(7)
		end
	elseif spellId == 158986 then
		warnBerserkerRush:Show(args.destName)
		if args:IsPlayer() then
			specWarnBerserkerRush:Show()
			yellBerserkerRush:Yell()
		else
			specWarnBerserkerRushOther:Show(args.destName)
		end
	elseif spellId == 159178 then
		local amount = args.amount or 1
		warnOpenWounds:Show(args.destName, amount)
		if amount >= 1 then--Stack count unknown
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
--				specWarnOpenWounds:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(159178)) and not UnitIsDeadOrGhost("player") then
					specWarnOpenWoundsOther:Show(args.destName)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 159250 then
		specWarnBladeDanceEnded:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(4)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 159413 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnMaulingBrew:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then--Eject All Passengers:
	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("cFFFF0404") then

	elseif msg:find(L.tower) then

	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(20, 4) and self:IsInCombat() then

	end
end--]]
