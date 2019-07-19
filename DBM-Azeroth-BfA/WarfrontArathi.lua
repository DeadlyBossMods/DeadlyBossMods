local mod	= DBM:NewMod("WarfrontArathi", "DBM-Azeroth-BfA", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 303803 302809 299697 273110 272853",
	"SPELL_CAST_SUCCESS 272988 273118",
	"SPELL_AURA_APPLIED 303808 272853",
	"SPELL_AURA_REMOVED 272853"
--	"CHAT_MSG_RAID_BOSS_EMOTE",
--	"UNIT_SPELLCAST_SUCCEEDED"
)


local warnFlamePlague				= mod:NewTargetNoFilterAnnounce(303808, 3, nil, false)
local warnHexBomb					= mod:NewTargetNoFilterAnnounce(272853, 3)
local warnGreaterSerpentTotem		= mod:NewSpellAnnounce(272853, 3)
local warnSinkholeTotem				= mod:NewSpellAnnounce(273118, 3)

local specWarnChainedLightning		= mod:NewSpecialWarningInterrupt(273110, "HasInterrupt", nil, nil, 1, 2)
local specWarnFlamePlague			= mod:NewSpecialWarningMoveAway(303808, nil, nil, nil, 1, 2)
local yellFlamePlague				= mod:NewYell(303808)
local specWarnHexBomb				= mod:NewSpecialWarningMoveAway(272853, nil, nil, nil, 1, 2)
local yellHexBomb					= mod:NewYell(272853)
local yellHexBombFadesFades			= mod:NewShortFadesYell(272853)

local timerFlamePlagueCD			= mod:NewCDTimer(35.1, 303808, nil, nil, nil, 3, nil, nil, nil, 1, 3)
local timerHexBombCD				= mod:NewCDTimer(17, 272853, nil, nil, nil, 3, nil, nil, nil, 2, 3)
local timerGreaterSerpentTotemCD	= mod:NewCDTimer(20.6, 272853, nil, nil, nil, 1)
local timerSinkholeTotemCD			= mod:NewCDTimer(20, 273118, nil, nil, nil, 2)

--[[
function mod:BarrageTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") and self:AntiSpam(4, 8) then
		specWarnPoisonBarrage:Show()
		specWarnPoisonBarrage:Play("runout")
		yellPoisonBarrage:Yell()
		yellPoisonBarrageFades:Countdown(4)
	else
		warnPoisonBarrage:Show(targetname)
	end
end
--]]

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 303803 then--Flame Plague
		timerFlamePlagueCD:Start()
	elseif spellId == 272853 then
		timerHexBombCD:Start()
	elseif spellId == 302809 or spellId == 299697 then--Scroll of Town Portal (horde, alliance)
		timerFlamePlagueCD:Stop()
		timerHexBombCD:Stop()
		timerGreaterSerpentTotemCD:Stop()
		timerSinkholeTotemCD:Stop()
	elseif spellId == 273110 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnChainedLightning:Show(args.sourceName)
		specWarnChainedLightning:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 272853 then
		warnGreaterSerpentTotem:Show()
		timerGreaterSerpentTotemCD:Start()
	elseif spellId == 273118 then
		warnSinkholeTotem:Show()
		timerSinkholeTotemCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 303808 then
		warnFlamePlague:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFlamePlague:Show()
			specWarnFlamePlague:Play("runout")
			yellFlamePlague:Yell()
		end
	elseif spellId == 272853 then
		warnHexBomb:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnHexBomb:Show()
			specWarnHexBomb:Play("runout")
			yellHexBomb:Yell()
			yellHexBombFadesFades:Countdown(spellId)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 272853 and args:IsPlayer() then
		yellHexBombFadesFades:Cancel()
	end
end

--[[
--"<274.38 20:07:06> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\INV_HordeWarEffort.blp:20|tThe Horde Commander has begun to lead the assault on Stromgarde!#Rokhan
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("spell:267702") then
		if targetname and self:AntiSpam(5, targetname) then
			if targetname == UnitName("player") then
				specWarnEntomb:Show()
				specWarnEntomb:Play("targetyou")
				yellEntomb:Yell()
			else
				warnEntomb:Show(targetname)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 272014 then
		self:SendSync("Pool")
	end
end

function mod:OnSync(msg)
	if msg == "Pool" and self:AntiSpam(4, 5) then
		warnPoolofDarkness:Show()
	end
end
--]]
