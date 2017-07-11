local mod	= DBM:NewMod(1983, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(125075)
mod:SetEncounterID(2069)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 243999",
	"SPELL_CAST_SUCCESS 243960 244093",
	"SPELL_AURA_APPLIED 243961 244042 244094 248732",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 244042 244094",
	"SPELL_PERIODIC_DAMAGE 244005 248740",--243968 243977 243980 243973
	"SPELL_PERIODIC_MISSED 244005 248740",--243968 243977 243980 243973
--	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Enable GTFO for all the flames if its something you can avoid
--TODO, icons on necrotic embrace?
--TODO, dark fissure targets?
--Torments of the Shivarra
--local warnTormentofFlames				= mod:NewSpellAnnounce(243967, 2)
--local warnTormentofFrost				= mod:NewSpellAnnounce(243976, 2)
--local warnTormentofFel					= mod:NewSpellAnnounce(243979, 2)
--local warnTormentofShadows				= mod:NewSpellAnnounce(243974, 2)
--The Fallen Nathrezim
local warnShadowStrike					= mod:NewSpellAnnounce(243960, 2)--Doesn't need special warning because misery should trigger special warning at same time
local warnMarkedPrey					= mod:NewTargetAnnounce(243974, 3)
local warnNecroticEmbrace				= mod:NewTargetAnnounce(244094, 4)
local warnEchoesofDoom					= mod:NewTargetAnnounce(248732, 3)

--Torments of the Shivarra
local specWarnGTFO						= mod:NewSpecialWarningGTFO(243968, nil, nil, nil, 1, 2)
--The Fallen Nathrezim
local specWarnMisery					= mod:NewSpecialWarningYou(243961, nil, nil, nil, 1, 2)
local specWarnMiseryTaunt				= mod:NewSpecialWarningTaunt(243961, nil, nil, nil, 1, 2)
local specWarnDarkFissure				= mod:NewSpecialWarningDodge(243999, nil, nil, nil, 2, 2)
local specWarnMarkedPrey				= mod:NewSpecialWarningYou(243974, nil, nil, nil, 1, 2)
local yellMarkedPrey					= mod:NewFadesYell(243974)
local specWarnNecroticEmbrace			= mod:NewSpecialWarningMoveAway(244094)
local yellNecroticEmbrace				= mod:NewFadesYell(244094)
local specWarnEchoesOfDoom				= mod:NewSpecialWarningMoveAway(248732)
local yellEchoesOfDoom					= mod:NewYell(248732)

--Torments of the Shivarra
--local timerTormentofFlamesCD			= mod:NewAITimer(61, 243967, nil, nil, nil, 3)
--local timerTormentofFrostCD			= mod:NewAITimer(61, 243976, nil, nil, nil, 3)
--local timerTormentofFelCD				= mod:NewAITimer(61, 243979, nil, nil, nil, 3)
--local timerTormentofShadowsCD			= mod:NewAITimer(61, 243974, nil, nil, nil, 3)
--The Fallen Nathrezim
local timerShadowStrikeCD				= mod:NewAITimer(25, 243960, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDarkFissureCD				= mod:NewAITimer(61, 243999, nil, nil, nil, 3)
local timerNecroticEmbraceCD			= mod:NewAITimer(61, 244093, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--The Fallen Nathrezim
--local countdownSingularity			= mod:NewCountdown(50, 235059)

--Torments of the Shivarra
local voiceGTFO							= mod:NewVoice(243968, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
--The Fallen Nathrezim
local voiceMisery						= mod:NewVoice(243961)--defensive/tauntboss
local voiceDarkFissure					= mod:NewVoice(243999)--watchstep
local voiceMarkedPrey					= mod:NewVoice(243974)--targetyou?
local voiceNecroticEmbrace				= mod:NewVoice(244094)--scatter
local voiceEchoesOfDoom					= mod:NewVoice(248732)--runout

mod:AddSetIconOption("SetIconOnMarkedPrey", 244042, true)
--mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("8/10")

function mod:OnCombatStart(delay)
	timerShadowStrikeCD:Start(1-delay)
	timerDarkFissureCD:Start(1-delay)
	if self:IsHard() then
		timerNecroticEmbraceCD:Start(1-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 243999 then
		specWarnDarkFissure:Show()
		voiceDarkFissure:Play("watchstep")
		timerDarkFissureCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 243960 then
		warnShadowStrike:Show()
		timerShadowStrikeCD:Show()
	elseif spellId == 244093 then--Necrotic Embrace Cast
		timerNecroticEmbraceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 243961 then
		if args:IsPlayer() then
			specWarnMisery:Show()
			voiceMisery:Play("defensive")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			--Applied to a tank that's not you and you don't have it, taunt
			if uId and self:IsTanking(uId) and not UnitDebuff("player", args.spellName) then
				specWarnMiseryTaunt:Show(args.destName)
				voiceMisery:Play("tauntboss")
			end
		end
	elseif spellId == 244042 then
		if args:IsPlayer() then
			specWarnMarkedPrey:Show()
			voiceMarkedPrey:Play("targetyou")
			yellMarkedPrey:Yell(5)
			yellMarkedPrey:Countdown(5)
		else
			warnMarkedPrey:Show(args.destName)
		end
	elseif spellId == 244094 then
		if args:IsPlayer() then
			specWarnNecroticEmbrace:Show()
			voiceNecroticEmbrace:Play("scatter")
			yellNecroticEmbrace:Countdown(4, 4)
		else
			warnNecroticEmbrace:CombinedShow(0.3, args.destName)--Combined message because even if it starts on 1, people are gonna fuck it up
		end
	elseif spellId == 248732 then
		warnEchoesofDoom:CombinedShow(0.5, args.destName)--In case multiple shadows up
		if args:IsPlayer() then
			specWarnEchoesOfDoom:Show()
			voiceEchoesOfDoom:Play("runout")
			yellEchoesOfDoom:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244042 then
		if args:IsPlayer() then
			yellMarkedPrey:Cancel()
		end
	elseif spellId == 244094 then
		if args:IsPlayer() then
			yellNecroticEmbrace:Cancel()
		end
	end
end

--Dark Fissure and all the torments
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 243968 or spellId == 243977 or spellId == 243980 or spellId == 243973 or spellId == 244005 or spellId == 248740) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 243967 then--Torment of Flames
		--warnTormentofFlames:Show()
	elseif spellId == 243976 then--Torment of Frost
		--warnTormentofFrost:Show()
	elseif spellId == 243979 then--Torment of Fel
		--warnTormentofFel:Show()
	elseif spellId == 243974 then--Torment of Shadows
		--warnTormentofShadows:Show()
	end
end
