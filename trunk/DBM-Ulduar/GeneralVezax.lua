local mod	= DBM:NewMod("GeneralVezax", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33271)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_INTERRUPT",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnShadowCrash			= mod:NewTargetAnnounce(62660, 4)
local warnLeechLife				= mod:NewTargetAnnounce(63276, 3)

local specWarnShadowCrash		= mod:NewSpecialWarning("SpecialWarningShadowCrash")
local specWarnShadowCrashNear	= mod:NewSpecialWarning("SpecialWarningShadowCrashNear")
local specWarnSurgeDarkness		= mod:NewSpecialWarningSpell(62662, mod:IsTank() or mod:IsHealer())
local specWarnLifeLeechYou		= mod:NewSpecialWarningYou(63276)
local specWarnLifeLeechNear 	= mod:NewSpecialWarning("SpecialWarningLLNear", false)

local timerEnrage				= mod:NewBerserkTimer(600)
local timerSearingFlamesCast	= mod:NewCastTimer(2, 62661)
local timerSurgeofDarkness		= mod:NewBuffActiveTimer(10, 62662)
local timerNextSurgeofDarkness	= mod:NewBuffActiveTimer(62, 62662)
local timerSaroniteVapors		= mod:NewNextTimer(30, 63322)
local timerLifeLeech			= mod:NewTargetTimer(10, 63276)
local timerHardmode				= mod:NewTimer(189, "hardmodeSpawn")

mod:AddBoolOption("YellOnLifeLeech", true, "announce")
mod:AddBoolOption("YellOnShadowCrash", true, "announce")
mod:AddBoolOption("SetIconOnShadowCrash", true)
mod:AddBoolOption("SetIconOnLifeLeach", true)
mod:AddBoolOption("CrashArrow")
mod:AddBoolOption("BypassLatencyCheck", false)--Use old scan method without syncing or latency check (less reliable but not dependant on other DBM users in raid)


function mod:OnCombatStart(delay)
	timerEnrage:Start(-delay)
	timerHardmode:Start(-delay)
	timerNextSurgeofDarkness:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62661) then	-- Searing Flames
		timerSearingFlamesCast:Start()
	elseif args:IsSpellID(62662) then 
		specWarnSurgeDarkness:Show()
		timerNextSurgeofDarkness:Start()
		if self.Options.SpecialWarningSurgeDarkness then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if args:IsSpellID(62661) then
		timerSearingFlamesCast:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62662) then	-- Surge of Darkness
		timerSurgeofDarkness:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(62662) then	
		timerSurgeofDarkness:Stop()
	end
end

function mod:ShadowCrashTarget()
	local target = self:GetBossTarget(33271)
	if not target then return end
	if mod:LatencyCheck() then--Only send sync if you have low latency.
		self:SendSync("CrashOn", target)
	end
end

function mod:OldShadowCrashTarget()
	local targetname = self:GetBossTarget()
	if not targetname then return end
	if self.Options.SetIconOnShadowCrash and mod:LatencyCheck() then
		self:SetIcon(targetname, 8, 10)
	end
	warnShadowCrash:Show(targetname)
	if targetname == UnitName("player") then
		specWarnShadowCrash:Show(targetname)
		if self.Options.YellOnShadowCrash and mod:LatencyCheck()  then
			SendChatMessage(L.YellCrash, "SAY")
		end
	elseif targetname then
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnShadowCrashNear:Show()
				if self.Options.CrashArrow then
					DBM.Arrow:ShowRunAway(x, y, 15, 5)
				end
			end
		end
	end
end


function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(62660) then		-- Shadow Crash
		if self.Options.BypassLatencyCheck then
			self:ScheduleMethod(0.1, "OldShadowCrashTarget")
		else
			self:ScheduleMethod(0.1, "ShadowCrashTarget")
		end
	elseif args:IsSpellID(63276) then	-- Mark of the Faceless
		if self.Options.SetIconOnLifeLeach then
			self:SetIcon(args.destName, 7, 10)
		end
		warnLeechLife:Show(args.destName)
		timerLifeLeech:Start(args.destName)
		if args:IsPlayer() then
			specWarnLifeLeechYou:Show()
			if self.Options.YellOnLifeLeech then
				SendChatMessage(L.YellLeech, "SAY")
			end
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnLifeLeechNear:Show(args.destName)
				end
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	if emote == L.EmoteSaroniteVapors or emote:find(L.EmoteSaroniteVapors) then
		timerSaroniteVapors:Start()
	end
end

function mod:OnSync(msg, target)
	if msg == "CrashOn" then
		if not self.Options.BypassLatencyCheck then
			warnShadowCrash:Show(target)
			if self.Options.SetIconOnShadowCrash then
				self:SetIcon(target, 8, 10)
			end
			if target == UnitName("player") then
				specWarnShadowCrash:Show()
				if self.Options.YellOnShadowCrash then
					SendChatMessage(L.YellCrash, "SAY")
				end
			elseif target then
				local uId = DBM:GetRaidUnitId(target)
				if uId then
					local inRange = CheckInteractDistance(uId, 2)
					local x, y = GetPlayerMapPosition(uId)
					if x == 0 and y == 0 then
						SetMapToCurrentZone()
						x, y = GetPlayerMapPosition(uId)
					end
					if inRange then
						specWarnShadowCrashNear:Show()
						if self.Options.CrashArrow then
							DBM.Arrow:ShowRunAway(x, y, 15, 5)
						end
					end
				end
			end
		end
	end
end