local mod	= DBM:NewMod(744, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62543)
mod:SetModelID(43141)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnTempestSlash					= mod:NewSpellAnnounce(125692, 2)
local warnOverwhelmingAssault			= mod:NewStackAnnounce(123474, 3, nil, mod:IsTank() or mod:IsHealer())
local warnWindStep						= mod:NewTargetAnnounce(123175, 3)
local warnUnseenStrike					= mod:NewTargetAnnounce(123017, 4)
local warnIntensify						= mod:NewStackAnnounce(123471, 2)
local warnBladeTempest					= mod:NewCastAnnounce(125310, 4)--Phase 1 heroic
local warnStormUnleashed				= mod:NewSpellAnnounce(123815, 3)--Phase 2

local specWarnUnseenStrike				= mod:NewSpecialWarningTarget(122949)--Everyone needs to know this, and run to this person.
local yellUnseenStrike					= mod:NewYell(122949)
local specWarnOverwhelmingAssault		= mod:NewSpecialWarningStack(123474, mod:IsTank(), 2)
local specWarnOverwhelmingAssaultOther	= mod:NewSpecialWarningTarget(123474, mod:IsTank())
local specWarnBladeTempest				= mod:NewSpecialWarningRun(125310, true)
local specWarnStormUnleashed			= mod:NewSpecialWarningSpell(123814, nil, nil, nil, true)

local timerTempestSlashCD				= mod:NewNextTimer(15.5, 125692)
local timerOverwhelmingAssault			= mod:NewTargetTimer(45, 123474, nil, mod:IsTank())
local timerOverwhelmingAssaultCD		= mod:NewCDTimer(20.5, 123474, nil, mod:IsTank() or mod:IsHealer())--Only ability with a variation in 2 pulls so far. He will use every 20.5 seconds unless he's casting something else, then it can be delayed as much as an extra 15-20 seconds. TODO: See if there is a way to detect when variation is going to occur and call update timer.
local timerWindStepCD					= mod:NewCDTimer(25, 123175)
local timerUnseenStrike					= mod:NewCastTimer(5, 123017)
local timerUnseenStrikeCD				= mod:NewCDTimer(55, 123017) -- this spell seems to have 2 cooldowns. some fight 55, some  61. 
local timerIntensifyCD					= mod:NewNextTimer(60, 123471)
local timerBladeTempest					= mod:NewBuffActiveTimer(9, 125310)
local timerBladeTempestCD				= mod:NewNextTimer(60, 125310)--Always cast after immediately intensify since they essencially have same CD

local berserkTimer						= mod:NewBerserkTimer(480)

local soundBladeTempest					= mod:NewSound(125310)

mod:AddBoolOption("RangeFrame", mod:IsRanged())--For Wind Step
mod:AddBoolOption("UnseenStrikeArrow")

local emoteFired = false
local intensifyCD = 60

local function checkUnseenEmote()
	if not emoteFired then
		warnUnseenStrike = mod:NewSpellAnnounce(123017, 4)
		specWarnUnseenStrike = mod:NewSpecialWarningSpell(122949)
		warnUnseenStrike:Show()
		specWarnUnseenStrike:Show()
		timerUnseenStrike:Start(4.2)
		timerUnseenStrikeCD:Start(54.2)
		-- recover Unseen Strike Target Warning
		warnUnseenStrike = mod:NewTargetAnnounce(123017, 4)
		specWarnUnseenStrike = mod:NewSpecialWarningTarget(122949)
	end
end

function mod:OnCombatStart(delay)
	emoteFired = false
	intensifyCD = 60
	timerTempestSlashCD:Start(10-delay)
	timerOverwhelmingAssaultCD:Start(15.5-delay)--Possibly wrong, the cd was shortened since beta, need better log with engage timestamp
	timerWindStepCD:Start(20.5-delay)
	timerUnseenStrikeCD:Start(30.5-delay)
	timerIntensifyCD:Start(intensifyCD-delay)
	berserkTimer:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerBladeTempestCD:Start(-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.UnseenStrikeArrow then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123474) then
		warnOverwhelmingAssault:Show(args.destName, args.amount or 1)
		timerOverwhelmingAssault:Start(args.destName)
		if args:IsPlayer() then
			if (args.amount or 1) >= 2 then
				specWarnOverwhelmingAssault:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 1 and not UnitDebuff("player", GetSpellInfo(123474)) and not UnitIsDeadOrGhost("player") then--Other tank has at least one stack and you have none
				specWarnOverwhelmingAssaultOther:Show(args.destName)--So nudge you to taunt it off other tank already.
			end
		end
	elseif args:IsSpellID(123471) then
		warnIntensify:Show(args.destName, args.amount or 1)
		timerIntensifyCD:Start(intensifyCD)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123474) then
		timerOverwhelmingAssault:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(125310) then
		warnBladeTempest:Show()
		specWarnBladeTempest:Show()
		soundBladeTempest:Play()
		timerBladeTempest:Start()
		timerBladeTempestCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(123474) then
		timerOverwhelmingAssaultCD:Start()--Start CD here, since this might miss.
	elseif args:IsSpellID(123175) then
		warnWindStep:Show(args.destName)
		timerWindStepCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:122949") then--Does not show in combat log except for after it hits. IT does fire a UNIT_SPELLCAST event but has no target info. The only way to get target is emote.
		emoteFired = true
		warnUnseenStrike:Show(target)
		specWarnUnseenStrike:Show(target)
		timerUnseenStrike:Start()
		timerUnseenStrikeCD:Start()
		if target == UnitName("player") then
			yellUnseenStrike:Yell()
		end
		if self.Options.UnseenStrikeArrow then
			DBM.Arrow:ShowRunTo(target, 5)
		end
		self:Schedule(5, function()
			emoteFired = false
		end)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122839 and self:AntiSpam(2, 1) then--Tempest Slash. DO NOT ADD OTHER SPELLID. 122839 is primary cast, 122842 is secondary cast 3 seconds later. We only need to warn for primary and start CD off it and it alone.
		warnTempestSlash:Show()
		timerTempestSlashCD:Start()
	elseif spellId == 122949 and self:AntiSpam(2, 3) then-- sometimes Unseen Strike emote not fires. bliz bug.
		self:Schedule(0.8, checkUnseenEmote)
	elseif spellId == 123814 and self:AntiSpam(2, 2) then--Do not add other spellids here either. 123814 is only cast once, it starts the channel. everything else is cast every 1-2 seconds as periodic triggers.
		intensifyCD = 10
		timerTempestSlashCD:Cancel()
		timerOverwhelmingAssaultCD:Cancel()
		timerWindStepCD:Cancel()
		timerUnseenStrikeCD:Cancel()
		timerIntensifyCD:Cancel()
		timerBladeTempestCD:Cancel()
		warnStormUnleashed:Show()
		specWarnStormUnleashed:Show()
	end
end

--[[ Transcrpitor Log 
"<875.1 21:29:19> Tayak [boss1:Storm Unleashed::0:123814]", -- [403] -- phase 2 start
"<875.1 21:29:19> Tayak [target:Storm Unleashed::0:123814]", -- [404]
"<876.3 21:29:21> Tayak [boss1:Storm Unleashed::0:130908]", -- [405]
"<876.3 21:29:21> Tayak [target:Storm Unleashed::0:130908]", -- [406]
"<876.3 21:29:21> Tayak [boss1:Storm Unleashed::0:123805]", -- [407]
"<876.3 21:29:21> Tayak [target:Storm Unleashed::0:123805]", -- [408]
"<880.3 21:29:25> Tayak [boss1:Storm Unleashed::0:123815]", -- [409]
"<880.3 21:29:25> Tayak [target:Storm Unleashed::0:123815]", -- [410]
"<880.3 21:29:25> Tayak [boss1:Storm Unleashed::0:124785]", -- [411]
"<880.3 21:29:25> Tayak [target:Storm Unleashed::0:124785]", -- [412]
"<881.8 21:29:26> Tayak [boss1:Storm Unleashed::0:123616]", -- [415]
"<881.8 21:29:26> Tayak [target:Storm Unleashed::0:123616]", -- [416]
"<883.3 21:29:28> Tayak [boss1:Storm Unleashed::0:123616]", -- [417]
"<883.3 21:29:28> Tayak [target:Storm Unleashed::0:123616]", -- [418]
"<884.8 21:29:29> Tayak [boss1:Storm Unleashed::0:123616]", -- [419]
"<884.8 21:29:29> Tayak [target:Storm Unleashed::0:123616]", -- [420]
"<886.3 21:29:31> Tayak [boss1:Storm Unleashed::0:123616]", -- [421]
"<886.3 21:29:31> Tayak [target:Storm Unleashed::0:123616]", -- [422]
"<887.8 21:29:32> Tayak [boss1:Storm Unleashed::0:123616]", -- [423]
"<887.8 21:29:32> Tayak [target:Storm Unleashed::0:123616]", -- [424]
"<889.3 21:29:34> Tayak [boss1:Storm Unleashed::0:123616]", -- [425]
"<889.3 21:29:34> Tayak [target:Storm Unleashed::0:123616]", -- [426]
"<890.8 21:29:35> Tayak [boss1:Storm Unleashed::0:123616]", -- [427]
"<890.8 21:29:35> Tayak [target:Storm Unleashed::0:123616]", -- [428]
"<892.3 21:29:37> Tayak [boss1:Storm Unleashed::0:123616]", -- [429]
"<892.3 21:29:37> Tayak [target:Storm Unleashed::0:123616]", -- [430]
"<893.8 21:29:38> Tayak [boss1:Storm Unleashed::0:123616]", -- [431]
"<893.8 21:29:38> Tayak [target:Storm Unleashed::0:123616]", -- [432]
"<895.3 21:29:40> Tayak [boss1:Storm Unleashed::0:123616]", -- [433]
"<895.3 21:29:40> Tayak [target:Storm Unleashed::0:123616]", -- [434]
"<896.8 21:29:41> Tayak [boss1:Storm Unleashed::0:123616]", -- [435]
"<896.8 21:29:41> Tayak [target:Storm Unleashed::0:123616]", -- [436]
"<898.3 21:29:43> Tayak [boss1:Storm Unleashed::0:123616]", -- [437]
"<898.3 21:29:43> Tayak [target:Storm Unleashed::0:123616]", -- [438]
"<899.8 21:29:44> Tayak [boss1:Storm Unleashed::0:123616]", -- [439]
"<899.8 21:29:44> Tayak [target:Storm Unleashed::0:123616]", -- [440]
"<901.3 21:29:46> Tayak [boss1:Storm Unleashed::0:123616]", -- [441]
"<901.3 21:29:46> Tayak [target:Storm Unleashed::0:123616]", -- [442]
"<902.8 21:29:47> Tayak [boss1:Storm Unleashed::0:123616]", -- [443]
"<902.8 21:29:47> Tayak [target:Storm Unleashed::0:123616]", -- [444]
"<904.3 21:29:49> Tayak [boss1:Storm Unleashed::0:123616]", -- [445]
"<904.3 21:29:49> Tayak [target:Storm Unleashed::0:123616]", -- [446]
"<905.8 21:29:50> Tayak [boss1:Storm Unleashed::0:123616]", -- [447]
"<905.8 21:29:50> Tayak [target:Storm Unleashed::0:123616]", -- [448]
"<907.3 21:29:52> Tayak [boss1:Storm Unleashed::0:123616]", -- [449]
"<907.3 21:29:52> Tayak [target:Storm Unleashed::0:123616]", -- [450]
"<908.8 21:29:53> Tayak [boss1:Storm Unleashed::0:123616]", -- [451]
"<908.8 21:29:53> Tayak [target:Storm Unleashed::0:123616]", -- [452]
"<910.3 21:29:55> Tayak [boss1:Storm Unleashed::0:123616]", -- [453]
"<910.3 21:29:55> Tayak [target:Storm Unleashed::0:123616]", -- [454]
"<911.8 21:29:56> Tayak [boss1:Storm Unleashed::0:123616]", -- [455]
"<911.8 21:29:56> Tayak [target:Storm Unleashed::0:123616]", -- [456]
"<913.3 21:29:58> Tayak [boss1:Storm Unleashed::0:123616]", -- [457]
"<913.3 21:29:58> Tayak [target:Storm Unleashed::0:123616]", -- [458]
"<914.8 21:29:59> Tayak [boss1:Storm Unleashed::0:123616]", -- [459]
"<914.8 21:29:59> Tayak [target:Storm Unleashed::0:123616]", -- [460]
"<916.3 21:30:01> Tayak [boss1:Storm Unleashed::0:123616]", -- [461]
"<916.3 21:30:01> Tayak [target:Storm Unleashed::0:123616]", -- [462]
"<917.8 21:30:02> Tayak [boss1:Storm Unleashed::0:123616]", -- [463]
"<917.8 21:30:02> Tayak [target:Storm Unleashed::0:123616]", -- [464]
"<919.3 21:30:04> Tayak [boss1:Storm Unleashed::0:123616]", -- [465]
"<919.3 21:30:04> Tayak [target:Storm Unleashed::0:123616]", -- [466]
"<920.8 21:30:05> Tayak [boss1:Storm Unleashed::0:123616]", -- [467]
"<920.8 21:30:05> Tayak [target:Storm Unleashed::0:123616]", -- [468]
"<922.3 21:30:07> Tayak [boss1:Storm Unleashed::0:123616]", -- [469]
"<923.8 21:30:08> Tayak [boss1:Storm Unleashed::0:123616]", -- [470]
"<925.3 21:30:10> Tayak [boss1:Storm Unleashed::0:123616]", -- [471]
"<926.8 21:30:11> Tayak [boss1:Storm Unleashed::0:123616]", -- [472]
"<928.3 21:30:13> Tayak [boss1:Storm Unleashed::0:123616]", -- [473]
"<929.8 21:30:14> Tayak [boss1:Storm Unleashed::0:123616]", -- [474]
"<931.3 21:30:16> Tayak [boss1:Storm Unleashed::0:123616]", -- [475]
"<932.8 21:30:17> Tayak [boss1:Storm Unleashed::0:123616]", -- [476]
"<934.3 21:30:19> Tayak [boss1:Storm Unleashed::0:123616]", -- [477]
"<935.8 21:30:20> Tayak [boss1:Storm Unleashed::0:123616]", -- [478]
"<937.3 21:30:22> Tayak [boss1:Storm Unleashed::0:123616]", -- [479]
"<938.8 21:30:23> Tayak [boss1:Storm Unleashed::0:123616]", -- [480]
"<940.3 21:30:25> Tayak [boss1:Storm Unleashed::0:123616]", -- [481]
"<941.8 21:30:26> Tayak [boss1:Storm Unleashed::0:123616]", -- [482]
"<943.3 21:30:28> Tayak [boss1:Storm Unleashed::0:123616]", -- [483]
"<944.8 21:30:29> Tayak [boss1:Storm Unleashed::0:123616]", -- [484]
"<946.3 21:30:31> Tayak [boss1:Storm Unleashed::0:123616]", -- [485]
"<947.8 21:30:32> Tayak [boss1:Storm Unleashed::0:123616]", -- [486]
"<949.3 21:30:34> Tayak [boss1:Storm Unleashed::0:123616]", -- [487]
"<950.8 21:30:35> Tayak [boss1:Storm Unleashed::0:123616]", -- [488]
"<952.3 21:30:37> Tayak [boss1:Storm Unleashed::0:123616]", -- [489]
"<953.8 21:30:38> Tayak [boss1:Storm Unleashed::0:123616]", -- [490]
"<955.3 21:30:40> Tayak [boss1:Storm Unleashed::0:123616]", -- [491]
"<960.4 21:30:45> Tayak [boss1:Storm Unleashed::0:123820]", -- [492] -- only this line spellids mismatchs. i doubt it.
"<961.9 21:30:46> Tayak [boss1:Storm Unleashed::0:123616]", -- [493]
"<963.4 21:30:48> Tayak [boss1:Storm Unleashed::0:123616]", -- [494]
"<964.9 21:30:49> Tayak [boss1:Storm Unleashed::0:123616]", -- [495]
"<966.4 21:30:51> Tayak [boss1:Storm Unleashed::0:123616]", -- [496]
"<967.9 21:30:52> Tayak [boss1:Storm Unleashed::0:123616]", -- [497]
"<969.4 21:30:54> Tayak [boss1:Storm Unleashed::0:123616]", -- [498]
"<970.9 21:30:55> Tayak [boss1:Storm Unleashed::0:123616]", -- [499]
"<972.4 21:30:57> Tayak [boss1:Storm Unleashed::0:123616]", -- [500]
"<973.9 21:30:58> Tayak [boss1:Storm Unleashed::0:123616]", -- [501]
"<975.4 21:31:00> Tayak [boss1:Storm Unleashed::0:123616]", -- [502]

--]]