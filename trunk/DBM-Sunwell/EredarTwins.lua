local Twins = DBM:NewBossMod("Twins", DBM_TWINS_NAME, DBM_TWINS_DESCRIPTION, DBM_SUNWELL, DBM_SW_TAB, 4)

Twins.Version		= "1.0"
Twins.Author		= "Tandanu"

Twins:SetCreatureID(25166)
Twins:RegisterCombat("combat", 25165, 25166)

Twins:AddOption("WarnShadowBlades", false, DBM_TWINS_OPTION_BLADES)
Twins:AddOption("WarnBuff", true, DBM_TWINS_OPTION_BUFF)
Twins:AddOption("WarnBlow", true, DBM_TWINS_OPTION_BLOW)
Twins:AddOption("WarnBlowSoon", false, DBM_TWINS_OPTION_BLOW_SOON)
Twins:AddOption("RangeCheck", true, DBM_KAL_OPTION_RANGE)
Twins:AddOption("WarnConflagration", true, DBM_TWINS_OPTION_CONFLAG)
Twins:AddOption("WhisperConflag", true, DBM_TWINS_OPTION_CONFLAG2)
Twins:AddOption("SpecWarnConflag", true, DBM_TWINS_OPTION_CONFLAG3)
Twins:AddOption("IconConflag", true, DBM_TWINS_OPTION_CONFLAG4)
Twins:AddOption("SoundWarnConflag", true, DBM_TWINS_OPTION_CONFLAG5)
Twins:AddOption("WarnNova", true, DBM_TWINS_OPTION_NOVA)
Twins:AddOption("WhisperNova", true, DBM_TWINS_OPTION_NOVA2)
Twins:AddOption("SpecWarnNova", true, DBM_TWINS_OPTION_NOVA3)
Twins:AddOption("IconNova", false, DBM_TWINS_OPTION_NOVA4)
Twins:AddOption("DarkTouch", true, DBM_TWINS_OPTION_TOUCH1)
Twins:AddOption("FlameTouch", false, DBM_TWINS_OPTION_TOUCH2)

Twins:AddBarOption("Enrage")
Twins:AddBarOption("Shadow Blades", false)
Twins:AddBarOption("Next Shadow Blades", false)
Twins:AddBarOption("Next Shadow Nova")
Twins:AddBarOption("Shadow Nova")
Twins:AddBarOption("Confounding Blow")

Twins:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_AURA_APPLIED_DOSE"
)


function Twins:OnCombatStart(delay)
	self:StartStatusBarTimer(360 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy") 
	self:ScheduleAnnounce(180 - delay, DBM_GENERIC_ENRAGE_WARN:format(3, DBM_MIN), 1)
	self:ScheduleAnnounce(300 - delay, DBM_GENERIC_ENRAGE_WARN:format(1, DBM_MIN), 2)
	self:ScheduleAnnounce(330 - delay, DBM_GENERIC_ENRAGE_WARN:format(30, DBM_SEC), 3)
	self:ScheduleAnnounce(350 - delay, DBM_GENERIC_ENRAGE_WARN:format(10, DBM_SEC), 4)
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Show()
	end
end

function Twins:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide()
	end
end

function Twins:OnEvent(event, args)
	if event == "SPELL_CAST_START" then
		if args.spellId == 45248 then
			self:SendSync("Blades")
		end
	elseif event == "SPELL_AURA_APPLIED" then
		if args.spellId == 45230 and args.destName == DBM_TWINS_MOB_WL then
			self:SendSync("Buff")
		end
	elseif event == "SPELL_AURA_APPLIED_DOSE" then
		if self.Options.DarkTouch and args.spellId == 45347 and args.destName == UnitName("player") and args.amount >= 8 then
			self:AddSpecialWarning(DBM_TWINS_SPECWARN_SHADOW:format(args.amount))
		elseif self.Options.FlameTouch and args.spellId == 45348 and args.destName == UnitName("player") and args.amount >= 5 then
			self:AddSpecialWarning(DBM_TWINS_SPECWARN_FIRE:format(args.amount))
		end
	elseif event == "SPELL_DAMAGE" then
		if args.spellId == 45256 then
			self:SendSync("Blow")
		end
	elseif event == "CHAT_MSG_RAID_BOSS_EMOTE" then
		local _, _, target = (args or ""):find(DBM_TWINS_EMOTE_CONFLAG)
		if target then
			self:SendSync("Conflagration"..target)
		end
		target = nil
		
		local _, _, target = (args or ""):find(DBM_TWINS_EMOTE_NOVA)
		if target then
			self:SendSync("ShadowNova"..target)
		end
	end
end


function Twins:OnSync(msg)
	if msg == "Blades" then
		self:StartStatusBarTimer(11, "Next Shadow Blades", 45248)
		self:StartStatusBarTimer(1.5, "Shadow Blades", 45248)
		if self.Options.WarnShadowBlades then
			self:Announce(DBM_TWINS_WARN_BLADES, 1)
		end
	elseif msg == "Buff" then
		if self.Options.WarnBuff then
			self:Announce(DBM_TWINS_WARN_BUFF, 3)
		end
	elseif msg == "Blow" then
		self:StartStatusBarTimer(20, "Next Confounding Blow", 45256)
		if self.Options.WarnBlowSoon then
			self:ScheduleAnnounce(17.5, DBM_TWINS_WARN_BLOW_SOON, 1)
		end
		if self.Options.WarnBlow then
			self:Announce(DBM_TWINS_WARN_BLOW, 1)
		end

	elseif msg:sub(0, 13) == "Conflagration" then
		msg = msg:sub(14)
		if self.Options.WarnConflagration then
			self:Announce(DBM_TWINS_WARN_CONFLAG_ON:format(msg), 4)
		end
		if self.Options.WhisperConflag then
			self:SendHiddenWhisper(DBM_TWINS_WHISPER_CONFLAG, msg)
		end
		if msg == UnitName("player") then
			if self.Options.SoundWarnConflag then
				PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav")
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
			if self.Options.SpecWarnConflag then
				self:AddSpecialWarning(DBM_TWINS_WHISPER_CONFLAG)
			end
		end
		if self.Options.IconConflag then
			self:SetIcon(msg, 8)
		end
	elseif msg:sub(0, 10) == "ShadowNova" then
		msg = msg:sub(11)
		self:StartStatusBarTimer(31, "Next Shadow Nova", 45329)
		self:StartStatusBarTimer(3.5, "Shadow Nova", 45329)
		if self.Options.WarnNova then
			self:Announce(DBM_TWINS_WARN_NOVA_ON:format(msg), 2)
		end
		if self.Options.WhisperNova then
			self:SendHiddenWhisper(DBM_TWINS_WHISPER_NOVA, msg)
		end
		if msg == UnitName("player") and self.Options.SpecWarnNova then
			self:AddSpecialWarning(DBM_TWINS_WHISPER_NOVA)
		end
		if self.Options.IconNova then
			self:SetIcon(msg,7)
		end
	end
end


function Twins:GetBossHP()
	return ("%s: %s, %s: %s"):format(DBM_TWINS_MOB_WL, DBM.GetHPByName(DBM_TWINS_MOB_WL), DBM_TWINS_MOB_SOCR, DBM.GetHPByName(DBM_TWINS_MOB_SOCR))
end

