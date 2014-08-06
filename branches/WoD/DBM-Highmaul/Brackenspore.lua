local mod	= DBM:NewMod(1196, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78491)--86612 Spore Shooter, 86611 Mind Fungus, 86613 Fungal Flesh-Eater
mod:SetEncounterID(1720)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 159996 160013 159219",
	"SPELL_CAST_SUCCESS 160446",
	"SPELL_AURA_APPLIED 163241",
	"SPELL_AURA_APPLIED_DOSE 163241"
)

--TODO, find a way to detect Fungal Flesh-Eater Spawns.
--local warnCreepingMoss			= mod:NewSpellAnnounce(163590, 3)--Figure out how this works and enable.
local warnInfestingSpores			= mod:NewSpellAnnounce(159996, 3)
local warnDecay						= mod:NewSpellAnnounce(160013, 4)
local warnNecroticBreath			= mod:NewSpellAnnounce(159219, 4, nil, mod:IsHealer() or mod:IsTank())
local warnRot						= mod:NewStackAnnounce(163241, 2, nil, mod:IsTank())
local warnSporeShooter				= mod:NewSpellAnnounce(160446)

--local specWarnCreepingMoss		= mod:NewSpecialWarningSwitch(163590)--Check if flamethrower buffed?
local specWarnInfestingSpores		= mod:NewSpecialWarningSpell(159996, nil, nil, nil, 2)
local specWarnDecay					= mod:NewSpecialWarningInterrupt(160013, not mod:IsHealer())
local specWarnNecroticBreath		= mod:NewSpecialWarningSpell(159219, mod:IsTank(), nil, nil, 3)
local specWarnRot					= mod:NewSpecialWarningStack(163241, nil, 12)--stack guessed, based on low debuff damage, assumed to be a fast stacker, like malkorak
local specWarnRotOther				= mod:NewSpecialWarningTaunt(163241)

--local timerCreepingMossCD			= mod:NewNextTimer(30, 163590)
--local timerInfestingSporesCD		= mod:NewNextTimer(30, 159996)--Energy Based
--local timerNecroticBreathCD		= mod:NewNextTimer(30, 159219, nil, mod:IsTank() or mod:IsHealer())

mod:AddRangeFrameOption(8, 160254)

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)--TODO, move this to a place that detects when Spore Shooter's are active.
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 159996 then
		warnInfestingSpores:Show()
		specWarnInfestingSpores:Show()
	elseif spellId == 160013 then
		warnDecay:Show()
		specWarnDecay:Show(args.sourceName)
	elseif spellId == 159219 then
		warnNecroticBreath:Show()
		specWarnNecroticBreath:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 160446 and self:AntiSpam(5, 3) then
		warnSporeShooter:Show()--If this works move range frame stuff here.
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 163241 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRot:Show(args.destName, amount)
		end
		if amount % 3 == 0 and amount >= 12 then
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnRot:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(163241)) and not UnitIsDeadOrGhost("player") then
					specWarnRotOther:Show(args.destName)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 147068 then
	end
end

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
