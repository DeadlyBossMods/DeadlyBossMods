local mod	= DBM:NewMod(1427, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(92330)--Verify
mod:SetEncounterID(1794)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 182635 181288 182994 180221 182992 182051 183331 183329 184239 182392",
--	"SPELL_CAST_SUCCESS,
	"SPELL_AURA_APPLIED 182038 180415 183017 184239 182769 182900",
	"SPELL_AURA_APPLIED_DOSE 182038",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"RAID_BOSS_WHISPER",
--	"CHAT_MSG_ADDON",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe add icon marking once prisons are figured out. Assuming there is any way to free them
--TODO, figure out which version of each spell is actually friendly and hostile, so i can remove the hostile checks and friendly spell ids from most spells
--KILL RAID_BOSS_WHISPER and CHAT_MSG_ADDON if possible
--Soulbound Construct
local warnReverberatingBlow			= mod:NewCountAnnounce(182635, 3)
local warnFelPrison					= mod:NewTargetAnnounce(180415, 4)
local warnShatteredDefenses			= mod:NewStackAnnounce(182038, 3, nil, "Tank")
local warnVolatileFelOrb			= mod:NewTargetAnnounce(180221, 4)
local warnGhastlyFixation			= mod:NewTargetAnnounce(182769, 4)
local warnVirulentHaunt				= mod:NewTargetAnnounce(182900, 4, nil, false)--Failed at fixate

--Soulbound Construct
local specWarnReverberatingBlow		= mod:NewSpecialWarningCount(182635, "Tank", nil, nil, 1, nil, 2)
local specWarnFelPrison				= mod:NewSpecialWarningDodge(182994, nil, nil, nil, 2)
local specWarnVolatileFelOrb		= mod:NewSpecialWarningRun(180221, nil, nil, nil, 4, nil, 2)
local yellVolatileFelOrb			= mod:NewYell(180221)
local specWarnFelCharge				= mod:NewSpecialWarningDodge(182051, nil, nil, nil, 2, nil, 2)
--Socrethar
local specWarnUnseat				= mod:NewSpecialWarningInterrupt(183331, "-Healer", nil, nil, 1, nil, 2)
local specWarnApocalypse			= mod:NewSpecialWarningSpell(183329, nil, nil, nil, 2, nil, 2)
--Adds
local specWarnShadowWordAgony		= mod:NewSpecialWarningInterrupt(184239, false, nil, nil, 1, nil, 2)
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(182392, "-Healer", nil, nil, 1, nil, 2)
local specWarnGhastlyFixation		= mod:NewSpecialWarningRun(182769, nil, nil, nil, 4, nil, 2)
local yellGhastlyFixation			= mod:NewYell(182769, nil, false)

--Soulbound Construct
local timerReverberatingBlowCD		= mod:NewAITimer(13, 182635)--Change to count timer when changed to real timer
local timerFelPrisonCD				= mod:NewAITimer(13, 182994)
local timerVolatileFelOrbCD			= mod:NewAITimer(13, 180221)
--Socrethar
local timerUnseatCD					= mod:NewAITimer(13, 183331, nil, "-Healer")
local timerApocalypseCD				= mod:NewAITimer(13, 183329)
--Adds
--Not going to use AI timers for adds, because there could be a lot of adds, and plus AI timers don't support multiple of same timer via GUID so it'll screw up

--local berserkTimer				= mod:NewBerserkTimer(360)

--local countdownReverberatingBlow	= mod:NewCountdown(12, 182635, "Tank")

local voiceReverberatingBlow		= mod:NewVoice(182635)--gathershare
local voiceVolatileFelOrb			= mod:NewVoice(182635)--runout/keepmove
local voiceFelblazeCharge			= mod:NewVoice(182051)--chargemove
local voiceUnseat					= mod:NewVoice(183331, "-Healer")--kickcast
local voiceApocalypse				= mod:NewVoice(183329)--aesoon
--Adds
local voiceShadowWordAgony			= mod:NewVoice(184239, false)--kickcast
local voiceShadowBoltVolley			= mod:NewVoice(182392, "-Healer")--kickcast
local voiceGhastlyFixation			= mod:NewVoice(182769)--runout/keepmove

--mod:AddRangeFrameOption(8, 155530)

--[[
local debuffFilter
do
	local debuffName = GetSpellInfo(155323)
	local UnitDebuff = UnitDebuff
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end--]]

mod.vb.ReverberatingBlow = 0

function mod:OnCombatStart(delay)
	DBM:AddMsg(DBM_CORE_COMBAT_STARTED_AI_TIMER)
	self.vb.ReverberatingBlow = 0
	timerReverberatingBlowCD:Start(1-delay)
	timerFelPrisonCD:Start(1-delay)
	timerVolatileFelOrbCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 182635 and args:IsSrcTypeHostile() then
		timerReverberatingBlowCD:Start()
		--countdownReverberatingBlow:Start()
		self.vb.ReverberatingBlow = self.vb.ReverberatingBlow + 1
		voiceReverberatingBlow:Play("gathershare")
		if self.Options.SpecWarn182635count then
			specWarnReverberatingBlow:Show(self.vb.ReverberatingBlow)
		else
			warnReverberatingBlow:Show(self.vb.ReverberatingBlow)
		end
	elseif (spellId == 180415 or spellId == 183017) and args:IsSrcTypeHostile() then
		specWarnFelPrison:Show()
		timerFelPrisonCD:Start()
	elseif (spellId == 180221 or spellId == 182992) and args:IsSrcTypeHostile() then
		timerVolatileFelOrbCD:Start()
	elseif spellId == 182051 and args:IsSrcTypeHostile() then
		specWarnFelCharge:Show()
		voiceFelblazeCharge:Play("chargemove")
	elseif spellId == 183331 then
		timerUnseatCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnUnseat:Show(args.sourceName)
			voiceUnseat:Play("kickcast")
		end
	elseif spellId == 183329 then
		specWarnApocalypse:Show()
		voiceApocalypse:Play("aesoon")
		timerApocalypseCD:Start()
	elseif spellId == 184239 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnShadowWordAgony:Show()
		voiceShadowWordAgony:Play("kickcast")
	elseif spellId == 182392 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnShadowBoltVolley:Show()
		voiceShadowBoltVolley:Play("kickcast")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155326 then

	end
end--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 182038 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			local amount = args.amount or 1
			warnShatteredDefenses:Show(amount)
			--if amount % 2 == 0 or amount >= 5 then

			--end
		end
	elseif (spellId == 181288 or spellId == 182994) and args:IsDestTypePlayer() then
		warnFelPrison:CombinedShow(1, args.destName)
	elseif (spellId == 181288 or spellId == 182994) and args:IsDestTypePlayer() then
		warnFelPrison:CombinedShow(1, args.destName)
	elseif spellId == 182769 then
		warnGhastlyFixation:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnGhastlyFixation:Show()
			yellGhastlyFixation:Yell()
			voiceGhastlyFixation:Play("runout")
			voiceGhastlyFixation:Schedule(2, "keepmove")
		end
	elseif spellId == 182900 then
		warnVirulentHaunt:CombinedShow(0.5, args.destName)
	elseif (spellId == 180221 or spellId == 182992) and args:IsDestTypePlayer() then
		warnVolatileFelOrb:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155323 then

	end
end--]]

--Change to combat log version if possible, but i'm not confident i can reliable drycode that to work, so coding it this way to make sure it works during test.
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:180221") or msg:find("spell:182992") then
		specWarnVolatileFelOrb:Show()
		yellVolatileFelOrb:Yell()
		voiceVolatileFelOrb:Play("runout")
		voiceVolatileFelOrb:Schedule(2, "keepmove")
	end
end

--[[
function mod:CHAT_MSG_ADDON(prefix, msg, channel, targetName)
	if prefix ~= "Transcriptor" then return end
	if msg:find("spell:180221") or msg:find("spell:182992") then--Volatile Orb
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(5, targetName) then--Set antispam if we got a sync, to block 3 second late SPELL_AURA_APPLIED if we got the early warning
			warnRapidFire:Show(self.vb.rapidfire, targetName)
		end
	end
end--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 173195 then
		
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
