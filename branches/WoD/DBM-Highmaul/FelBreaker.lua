local mod	= DBM:NewMod(1153, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79015)
mod:SetEncounterID(1723)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 162185 162184 161411",
	"SPELL_CAST_SUCCESS 161576",
	"SPELL_AURA_APPLIED 156803 160734 162186",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 156803 162186"
)

--Maybe add add spawning warnings if I can figure out spellid effects of http://beta.wowhead.com/spell=161378 and http://beta.wowhead.com/spell=161378
--Maybe add supression field spawn warnings
--Maybe add tank warning to move to supression field when add is low
--Figure out how long barrier lasts and get a timer for it.
--Figure out how trample works. http://beta.wowhead.com/spell=163101
local warnNullBarrier				= mod:NewTargetAnnounce(156803, 3)--Warn for player and boss
local warnVulnerability				= mod:NewTargetAnnounce(160734, 1)
local warnOverflowingEnergy			= mod:NewSpellAnnounce(161576, 4)--Spammy?
local warnExpelMagicFire			= mod:NewSpellAnnounce(162185, 3, nil, mod:IsHealer())
local warnExpelMagicShadow			= mod:NewSpellAnnounce(162184, 3, nil, mod:IsHealer())
local warnExpelMagicFrost			= mod:NewSpellAnnounce(161411, 3)
local warnExpelMagicArcane			= mod:NewTargetAnnounce(162186, 4, nil, mod:IsHealer() or mod:IsTank())

local specWarnNullBarrier			= mod:NewSpecialWarningTarget(156803)--Only warn for boss
local specWarnVulnerability			= mod:NewSpecialWarningSwitch(160734, mod:IsDps())
local specWarnOverflowingEnergy		= mod:NewSpecialWarningSpell(161576)--Warn the person with Null barrier.
local specWarnExpelMagicFire		= mod:NewSpecialWarningDispel(162185, mod:IsHealer())--Maybe just change default to "class == priest or monk")?
local specWarnExpelMagicShadow		= mod:NewSpecialWarningSpell(162184, mod:IsHealer())
local specWarnExpelMagicFrost		= mod:NewSpecialWarningSpell(161411, nil, nil, nil, 2)
local specWarnExpelMagicArcane		= mod:NewSpecialWarningTarget(162186, mod:IsHealer() or mod:IsTank())
local specWarnExpelMagicArcaneYou	= mod:NewSpecialWarningMoveAway(162186)
local yellExpelMagicArcane			= mod:NewYell(162186)

local timerVulnerability			= mod:NewBuffActiveTimer(20, 160734)--FRIENDS_FRIENDS_CHOICE_EVERYONE
--local timerNullBarrierCD			= mod:NewNextTimer(20, 156803)
--local timerOverflowingEnergyCD	= mod:NewNextTimer(10, 161576)

mod:AddRangeFrameOption(5, 162186)

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 162185 then
		warnExpelMagicFire:Show()
		specWarnExpelMagicFire:Schedule(1.5, FRIENDS_FRIENDS_CHOICE_EVERYONE)--FRIENDS_FRIENDS_CHOICE_EVERYONE = "Everyone"
	elseif spellId == 162184 then
		warnExpelMagicShadow:Show()
		specWarnExpelMagicShadow:Show()
	elseif spellId == 161411 then
		warnExpelMagicFrost:Show()
		specWarnExpelMagicFrost:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 161576 then--Probably wrong spellid and probably too late, if this is damage going off it's quite useless as a warning
		warnOverflowingEnergy:Show()
		if UnitPower("player", 10) > 0 then--This is a pretty bold assumption
			specWarnOverflowingEnergy:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156803 then
		warnNullBarrier:Show(args.destName)
		if args:GetDestCreatureID() == 79015 then--On Boss
			specWarnNullBarrier:Show(args.destName)
		end
	elseif spellId == 156803 then
		warnVulnerability:Show(args.destName)
		specWarnVulnerability:Show()
		timerVulnerability:Start()
	elseif spellId == 162186 then
		warnExpelMagicArcane:Show(args.destName)
		if args:IsPlayer() then
			specWarnExpelMagicArcaneYou:Show()
			yellExpelMagicArcane:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		else
			specWarnExpelMagicArcane:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156803 and args:GetDestCreatureID() == 79015 then
		--timerNullBarrierCD:Start()
	elseif spellId == 162186 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then
	
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