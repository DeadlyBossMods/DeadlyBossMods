local mod	= DBM:NewMod(682, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60143)
mod:SetModelID(41256)
mod:SetZone()
mod:SetUsedIcons(5, 6, 7, 8)
mod:SetMinSyncRevision(7751)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)
--NOTES
--Syncing is used for all warnings because the realms don't share combat events. You won't get warnings for other realm any other way.
--Voodoo dolls do not have a CD, they are linked to banishment (or player deaths), when he banishes current tank, he reapplies voodoo dolls to new tank and new players. If tank dies, he just recasts voodoo on a new current threat target.
--Latency checks are used for good reason (to prevent lagging users from sending late events and making our warnings go off again incorrectly). if you play with high latency and want to bypass latency check, do so with in game GUI option.
local warnTotem						= mod:NewCountAnnounce(116174, 2)
local warnVoodooDolls				= mod:NewTargetAnnounce(122151, 3)
local warnCrossedOver				= mod:NewTargetAnnounce(116161, 3)
local warnBanishment				= mod:NewTargetAnnounce(116272, 3)
local warnSuicide					= mod:NewPreWarnAnnounce(116325, 5, 4)--Pre warn 5 seconds before you die so you take whatever action you need to, to prevent. (this is effect that happens after 30 seconds of Soul Sever
local warnFrenzy					= mod:NewSpellAnnounce(117752, 4)

local specWarnTotem					= mod:NewSpecialWarningSpell(116174, false)
local specWarnBanishment			= mod:NewSpecialWarningYou(116272)
local specWarnBanishmentOther		= mod:NewSpecialWarningTarget(116272, mod:IsTank())
local specWarnVoodooDolls			= mod:NewSpecialWarningSpell(122151, false)
local specWarnVoodooDollsYou		= mod:NewSpecialWarningYou(122151, false)

local timerTotemCD					= mod:NewNextCountTimer(20, 116174)
local timerBanishmentCD				= mod:NewCDTimer(65, 116272)
local timerSoulSever				= mod:NewBuffFadesTimer(30, 116278)--Tank version of spirit realm
local timerCrossedOver				= mod:NewBuffFadesTimer(30, 116161)--Dps version of spirit realm
local timerSpiritualInnervation		= mod:NewBuffFadesTimer(30, 117549)
local timerShadowyAttackCD			= mod:NewCDTimer(8, "ej6698", nil, nil, nil, 117222)
local timerFrailSoul				= mod:NewBuffFadesTimer(30, 117723)

local berserkTimer					= mod:NewBerserkTimer(360)

local countdownCrossedOver			= mod:NewCountdown(29, 116161)

mod:AddBoolOption("SetIconOnVoodoo", true)

local totemCount = 0
local voodooDollTargets = {}
local crossedOverTargets = {}
local voodooDollTargetIcons = {}
local guids = {}
local guidTableBuilt = false--Entirely for DCs, so we don't need to reset between pulls cause it doesn't effect building table on combat start and after a DC then it will be reset to false always
local function buildGuidTable()
	table.wipe(guids)
	for uId, i in DBM:GetGroupMembers() do
		guids[UnitGUID(uId) or "none"] = GetRaidRosterInfo(i)
	end
end

local function warnVoodooDollTargets()
	warnVoodooDolls:Show(table.concat(voodooDollTargets, "<, >"))
	specWarnVoodooDolls:Show()
	table.wipe(voodooDollTargets)
end

local function warnCrossedOverTargets()
	warnCrossedOver:Show(table.concat(crossedOverTargets, "<, >"))
	table.wipe(crossedOverTargets)
end

local function removeIcon(target)
	for i,j in ipairs(voodooDollTargetIcons) do
		if j == target then
			table.remove(voodooDollTargetIcons, i)
			mod:SetIcon(target, 0)
			break
		end
	end
end

--[[
local function ClearVoodooTargets()
	table.wipe(voodooDollTargetIcons)
end--]]

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetVoodooIcons()
		table.sort(voodooDollTargetIcons, sort_by_group)
		local voodooIcon = 8
		for i, v in ipairs(voodooDollTargetIcons) do
			-- DBM:SetIcon() is used because of follow reasons
			--1. It checks to make sure you're on latest dbm version, if you are not, it disables icon setting so you don't screw up icons (ie example, a newer version of mod does icons differently)
			--2. It checks global dbm option "DontSetIcons"
			self:SetIcon(v, voodooIcon)
			voodooIcon = voodooIcon - 1
		end
--		self:Schedule(1.5, ClearVoodooTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:OnCombatStart(delay)
	totemCount = 0
	buildGuidTable()
	guidTableBuilt = true
	table.wipe(voodooDollTargets)
	table.wipe(crossedOverTargets)
	table.wipe(voodooDollTargetIcons)
	timerShadowyAttackCD:Start(7-delay)
	if self:IsDifficulty("normal25", "heroic25") then
		timerTotemCD:Start(20-delay, totemCount+1)
	elseif self:IsDifficulty("lfr25") then
		timerTotemCD:Start(30-delay, totemCount+1)
	else
		timerTotemCD:Start(36-delay, totemCount+1)
	end
	timerBanishmentCD:Start(-delay)
	if not self:IsDifficulty("lfr25") then -- lfr seems not berserks.
		berserkTimer:Start(-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)--We don't use spell cast success for actual debuff on >player< warnings since it has a chance to be resisted.
	if args:IsSpellID(122151) then
		if args:IsPlayer() then
			specWarnVoodooDollsYou:Show()
		end
		if self:LatencyCheck() then
			self:SendSync("VoodooTargets", args.destGUID)
		end
	elseif args:IsSpellID(116161, 116260) then -- 116161 is normal and heroic, 116260 is lfr.
		if args:IsPlayer() and self:AntiSpam(2, 3) then
			if not self:IsDifficulty("lfr25") then -- lfr do not suicide even you not press the extra button.
				warnSuicide:Schedule(25)
			end
			countdownCrossedOver:Start(29)
			timerCrossedOver:Start(29)
		end
		if not self:IsDifficulty("lfr25") then -- lfr totems not breakable, instead totems can click. so lfr warns can be spam, not needed to warn. also CLEU fires all players, no need to use sync.
			crossedOverTargets[#crossedOverTargets + 1] = args.destName
			self:Unschedule(warnCrossedOverTargets)
			self:Schedule(0.3, warnCrossedOverTargets)		
		end
	elseif args:IsSpellID(116278) then--this is tank spell, no delays?
		if args:IsPlayer() then--no latency check for personal notice you aren't syncing.
			timerSoulSever:Start()
			countdownCrossedOver:Start(29)
			warnSuicide:Schedule(25)
		end
	elseif args:IsSpellID(117543) and args:IsPlayer() then -- 117543 is healer spell, 117549 is dps spell
		timerSpiritualInnervation:Start()
	elseif args:IsSpellID(117549) and args:IsPlayer() then -- 117543 is healer spell, 117549 is dps spell
		if self:IsDifficulty("lfr25") then
			timerSpiritualInnervation:Start(40)
		else
			timerSpiritualInnervation:Start()
		end
	elseif args:IsSpellID(117723) and args:IsPlayer() then
		timerFrailSoul:Start()
	elseif args:IsSpellID(117752) then
		warnFrenzy:Show()
		if not self:IsDifficulty("lfr25") then--lfr continuing summon totem below 20%
			timerTotemCD:Cancel()
		end
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)--We don't use spell cast success for actual debuff on >player< warnings since it has a chance to be resisted.
	if args:IsSpellID(116161, 116260) and args:IsPlayer() then
		if not self:IsDifficulty("lfr25") then
			warnSuicide:Cancel()
		end
		timerCrossedOver:Cancel()
		countdownCrossedOver:Cancel()
	elseif args:IsSpellID(116278) and args:IsPlayer() then
		warnSuicide:Cancel()
		timerSoulSever:Cancel()
		countdownCrossedOver:Cancel()
	elseif args:IsSpellID(122151) then
		self:SendSync("VoodooGoneTargets", args.destGUID)
	elseif args:IsSpellID(117543, 117549) and args:IsPlayer() then
		timerSpiritualInnervation:Cancel()
	elseif args:IsSpellID(117723) and args:IsPlayer() then
		timerFrailSoul:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(116174) and self:LatencyCheck() then
		self:SendSync("SummonTotem")
	elseif args:IsSpellID(116272) then
		if args:IsPlayer() then--no latency check for personal notice you aren't syncing.
			specWarnBanishment:Show()
		end
		if self:LatencyCheck() then
			self:SendSync("BanishmentTarget", args.destGUID)
		end
	end
end

function mod:OnSync(msg, guid)
	--Make sure we build a table if we DCed mid fight, before we try comparing any syncs to that table.
	if not guidTableBuilt then
		buildGuidTable()
		guidTableBuilt = true
	end
	if msg == "SummonTotem" then
		totemCount = totemCount + 1
		warnTotem:Show(totemCount)
		specWarnTotem:Show()
		if self:IsDifficulty("normal25", "heroic25") then
			timerTotemCD:Start(20, totemCount+1)
		elseif self:IsDifficulty("lfr25") then
			timerTotemCD:Start(30, totemCount+1)
		else
			timerTotemCD:Start(36, totemCount+1)
		end
	elseif msg == "VoodooTargets" and guids[guid] then
		voodooDollTargets[#voodooDollTargets + 1] = guids[guid]
		self:Unschedule(warnVoodooDollTargets)
		self:Schedule(0.3, warnVoodooDollTargets)
		if self.Options.SetIconOnVoodoo then
			table.insert(voodooDollTargetIcons, DBM:GetRaidUnitId(guids[guid]))
			self:UnscheduleMethod("SetVoodooIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				self:ScheduleMethod(1, "SetVoodooIcons")
			end
		end
	elseif msg == "VoodooGoneTargets" and guids[guid] and self.Options.SetIconOnVoodoo then
		removeIcon(DBM:GetRaidUnitId(guids[guid]))
	elseif msg == "BanishmentTarget" and guids[guid] then
		warnBanishment:Show(guids[guid])
		timerBanishmentCD:Start()
		if guid ~= UnitGUID("player") then--make sure YOU aren't target before warning "other"
			specWarnBanishmentOther:Show(guids[guid])
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 117215 or spellId == 117218 or spellId == 117219 or spellId == 117222) and self:AntiSpam(2, 1) then--Shadowy Attacks
		timerShadowyAttackCD:Start()
	elseif spellId == 116964 and self:AntiSpam(2, 2) then--Summon Totem
		if self:LatencyCheck() then
			self:SendSync("SummonTotem")
		end
	end
end

--Secondary pull trigger. (leave it for lfr combat detection bug)
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.Pull or msg:find(L.Pull)) and not self:IsInCombat() then
		DBM:StartCombat(self, 0)
	end
end
