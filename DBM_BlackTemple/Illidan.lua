local Illidan = DBM:NewBossMod("Illidan", DBM_ILLIDAN_NAME, DBM_ILLIDAN_DESCRIPTION, DBM_BLACK_TEMPLE, DBM_BT_TAB, 9)

Illidan.Version		= "1.1"
Illidan.Author		= "Tandanu"
Illidan.MinRevision = 764

Illidan:RegisterCombat("YELL", DBM_ILLIDAN_YELL_PULL)

local flameTargets = {}
local flamesDown = 0
local flameBursts = 0
local demonTargets = {}
local phase2
local warnedDemons
local phase4

Illidan:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"SPELL_DAMAGE",
	"UNIT_SPELLCAST_START"
)

Illidan:AddOption("RangeCheck", true, DBM_ILLIDAN_OPTION_RANGECHECK)
Illidan:AddOption("WarnPhases", true, DBM_ILLIDAN_OPTION_PHASES)
Illidan:AddOption("WarnShearCast", false, DBM_ILLIDAN_OPTION_SHEARCAST)
Illidan:AddOption("WarnShear", true, DBM_ILLIDAN_OPTION_SHEAR)
Illidan:AddOption("WarnShadowfiend", true, DBM_ILLIDAN_OPTION_SHADOWFIEND)
Illidan:AddOption("IconShadowfiend", true, DBM_ILLIDAN_OPTION_ICONFIEND)
Illidan:AddOption("WarnBarrage", true, DBM_ILLIDAN_OPTION_BARRAGE)
Illidan:AddOption("WarnBarrageSoon", true, DBM_ILLIDAN_OPTION_BARRAGE_SOON)
Illidan:AddOption("WarnEyeBeam", true, DBM_ILLIDAN_OPTION_EYEBEAM)
--Illidan:AddOption("WarnEyeBeamSoon", false, DBM_ILLIDAN_OPTION_EYEBEAMSOON) -- inaccurate!
Illidan:AddOption("WarnFlames", true, DBM_ILLIDAN_OPTION_FLAMES)
Illidan:AddOption("WarnDemonForm", true, DBM_ILLIDAN_OPTION_DEMONFORM)
Illidan:AddOption("WarnFlameBursts", true, DBM_ILLIDAN_OPTION_FLAMEBURST)
Illidan:AddOption("WarnShadowDemons", true, DBM_ILLIDAN_OPTION_SHADOWDEMONS)

Illidan:AddBarOption("Enrage")
Illidan:AddBarOption("Illidan Stormrage")
Illidan:AddBarOption("Shear: (.*)")
Illidan:AddBarOption("Shadowfiend: (.*)")
Illidan:AddBarOption("Next Dark Barrage")
Illidan:AddBarOption("Dark Barrage: (.*)")
Illidan:AddBarOption("Flames: (.*)", false)
Illidan:AddBarOption("Demon Phase")
Illidan:AddBarOption("Normal Phase")
Illidan:AddBarOption("Shadow Demons")
Illidan:AddBarOption("Next Flame Burst")

function Illidan:OnCombatStart(delay)
	flameTargets = {}
	demonTargets = {}
	flamesDown = 0
	flameBursts = 0
	phase2 = nil
	phase4 = nil
	delay = delay - 7 - 33 -- 7 = time until combat starts and 33 because the timer will stop while illidan is switching from phase 1->2, 2->3 and 3->4; according to my combatlogs this should be quite accurate
	self:StartStatusBarTimer(1500 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy");	
	self:ScheduleAnnounce(900 - delay, DBM_GENERIC_ENRAGE_WARN:format(10, DBM_MIN), 1)
	self:ScheduleAnnounce(1200 - delay, DBM_GENERIC_ENRAGE_WARN:format(5, DBM_MIN), 1)
	self:ScheduleAnnounce(1320 - delay, DBM_GENERIC_ENRAGE_WARN:format(3, DBM_MIN), 1)
	self:ScheduleAnnounce(1440 - delay, DBM_GENERIC_ENRAGE_WARN:format(1, DBM_MIN), 2)
	self:ScheduleAnnounce(1470 - delay, DBM_GENERIC_ENRAGE_WARN:format(30, DBM_SEC), 3)
	self:ScheduleAnnounce(1490 - delay, DBM_GENERIC_ENRAGE_WARN:format(10, DBM_SEC), 4)
end

function Illidan:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide()
	end
	phase2 = nil
	phase4 = nil
end

function Illidan:OnEvent(event, args)
	if event == "CHAT_MSG_MONSTER_YELL" then
		if args == DBM_ILLIDAN_YELL_EYEBEAM then
			self:SendSync("EyeBeam")
		elseif args == DBM_ILLIDAN_YELL_DEMONFORM then
			self:SendSync("DemonForm")
		elseif args == DBM_ILLIDAN_YELL_PHASE4 then
			self:SendSync("Phase4")
		elseif args == DBM_ILLIDAN_YELL_START then
			self:StartStatusBarTimer(36.6, "Illidan Stormrage", "Interface\\Icons\\INV_Weapon_ShortBlade_07")
		end
	elseif event == "SPELL_AURA_APPLIED" then
		if args.spellId == 40647 then
			self:SendSync("Prison")
		elseif args.spellId == 41032 then
			self:SendSync("Shear"..tostring(args.destName))
		elseif args.spellId == 41917 or args.spellId == 41914 then
			self:SendSync("Shadowfiend"..tostring(args.destName))
		elseif args.spellId == 40585 then
			self:SendSync("DarkBarrage"..tostring(args.destName))
		elseif args.spellId == 40932 then
			self:SendSync("Flames"..tostring(args.destName))
		elseif args.spellId == 41083 then
			self:SendSync("ShadowDems"..tostring(args.destName))
		elseif args.spellId == 40683 then -- ??
			self:SendSync("P4Enrage")
		elseif args.spellId == 40695 then
			self:SendSync("Caged")
		end
	elseif event == "SPELL_CAST_SUCCESS" then
		if args.spellId == 39855 then
			self:SendSync("Phase2")
		end
	elseif event == "WarnAF" then
		local msg = ""
		for i, v in ipairs(flameTargets) do
			msg = msg..">"..v.."<, "
		end
		msg = msg:sub(0, -3)
		flameTargets = {}
		if self.Options.WarnFlames then
			self:Announce(DBM_ILLIDAN_WARN_FLAMES:format(msg), 3)
		end
	elseif event == "WarnSD" and not warnedDemons then
		local msg = ""
		for i, v in ipairs(demonTargets) do
			msg = msg..">"..v.."<, "
		end
		msg = msg:sub(0, -3)
		demonTargets = {}
		if self.Options.WarnShadowDemons then
			self:Announce(DBM_ILLIDAN_WARN_SHADOWDEMSON:format(msg), 4)
		end
		warnedDemons = true
	elseif event == "UNIT_DIED" then
		if args.destName == DBM_ILLIDAN_MOB_FLAME then
			self:SendSync("FlameDown")
		end
	elseif event == "SPELL_DAMAGE" then
		if args.spellId == 41131 then
			self:SendSync("Flameburst")
		end
	elseif event == "SPELL_CAST_START" then
		if args.spellId == 41032 then
			self:SendSync("CastShear")
		end
	end
end

function Illidan:GetBossHP()
	if phase2 then
		return DBM_ILLIDAN_STATUSMSG_PHASE2
	end
end

function Illidan:OnSync(msg)
	if msg:sub(0, 5) == "Shear" then
		msg = msg:sub(6)
		if self.Options.WarnShear then
			self:Announce(DBM_ILLIDAN_WARN_SHEAR:format(msg), 1)
		end
		self:StartStatusBarTimer(7, "Shear: "..msg, "Interface\\Icons\\Spell_Shadow_FocusedPower")
	elseif msg == "CastShear" then
		if self.Options.WarnShearCast then
			self:Announce(DBM_ILLIDAN_WARN_CASTSHEAR, 1)
		end
	elseif msg:sub(0, 11) == "Shadowfiend" then
		msg = msg:sub(12)
		if msg == UnitName("player") then
			self:AddSpecialWarning(DBM_ILLIDAN_SELFWARN_SHADOWFIEND)
		end
		if self.Options.WarnShadowfiend then
			self:Announce(DBM_ILLIDAN_WARN_SHADOWFIEND:format(msg), 2)
		end
		if self.Options.IconShadowfiend then
			self:SetIcon(msg, 10)
		end
		self:StartStatusBarTimer(10, "Shadowfiend: "..msg, "Interface\\Icons\\Spell_Shadow_Shadowfiend")
	elseif msg:sub(0, 11) == "DarkBarrage" then
		msg = msg:sub(12)
		if self.Options.WarnBarrage then
			self:Announce(DBM_ILLIDAN_WARN_BARRAGE:format(msg), 2)
		end
		if self.Options.WarnBarrageSoon then
			self:ScheduleAnnounce(42, DBM_ILLIDAN_WARN_BARRAGE_SOON, 1)
		end
		self:EndStatusBarTimer("Next Dark Barrage") -- synced timers may only overwrite timers that are about to expire - the barrage timer seems to be quite inaccurate...so send a end timer command before.
		self:StartStatusBarTimer(44, "Next Dark Barrage", "Interface\\Icons\\Spell_Shadow_PainSpike")
		self:StartStatusBarTimer(10, "Dark Barrage: "..msg, "Interface\\Icons\\Spell_Shadow_PainSpike")
	elseif msg == "EyeBeam" then
		if self.Options.WarnEyeBeam then
			self:Announce(DBM_ILLIDAN_WARN_EYEBEAM, 3)
		end
--		if self.Options.WarnEyeBeamSoon then -- inaccurate!
--			self:ScheduleAnnounce(32, DBM_ILLIDAN_WARN_EYEBEAM_SOON, 2)
--		end
--		self:StartStatusBarTimer(35, "Next Eye Blast", "Interface\\Icons\\Spell_Shadow_SiphonMana")
	elseif msg:sub(0, 6) == "Flames" then
		msg = msg:sub(7)
		self:StartStatusBarTimer(60, "Flames: "..msg, "Interface\\Icons\\Spell_Fire_BlueImmolation")
		if msg == UnitName("player") then
			self:AddSpecialWarning(DBM_ILLIDAN_SELFWARN_SHADOW)
		end
		table.insert(flameTargets, msg)
		self:UnScheduleEvent("WarnAF")
		self:ScheduleEvent(1, "WarnAF")
	elseif msg == "Phase2" then
		if self.Options.WarnPhases then
			self:Announce(DBM_ILLIDAN_WARN_PHASE2, 4)
		end
		if self.Options.WarnBarrageSoon then
			self:ScheduleAnnounce(76, DBM_ILLIDAN_WARN_BARRAGE_SOON, 1)
		end
		self:StartStatusBarTimer(81, "Next Dark Barrage", "Interface\\Icons\\Spell_Shadow_PainSpike")
		phase2 = true
		flamesDown = 0
	elseif msg == "Phase3" then
		if self.Options.WarnPhases then
			self:Announce(DBM_ILLIDAN_WARN_PHASE3, 4)
		end
		if self.Options.RangeCheck then
			DBM_Gui_DistanceFrame_Show()
		end
		phase2 = nil
		self:StartStatusBarTimer(76, "Demon Phase", "Interface\\Icons\\Spell_Shadow_Metamorphosis")
		if self.Options.WarnDemonForm then
			self:ScheduleAnnounce(66, DBM_ILLIDAN_WARN_DEMONPHASE_SOON, 3)
		end
		self:EndStatusBarTimer("Next Dark Barrage")
		self:UnScheduleAnnounce(DBM_ILLIDAN_WARN_BARRAGE_SOON, 1)
	elseif msg == "Phase4" then
		if self.Options.WarnPhases then
			self:Announce(DBM_ILLIDAN_WARN_PHASE4, 4)
		end
		self:EndStatusBarTimer("Demon Phase")
		self:EndStatusBarTimer("Normal Phase")
		self:UnScheduleAnnounce(DBM_ILLIDAN_WARN_DEMONPHASE_SOON)
		self:UnScheduleAnnounce(DBM_ILLIDAN_WARN_NORMALPHASE_SOON)
		self:StartStatusBarTimer(92, "Demon Phase", "Interface\\Icons\\Spell_Shadow_Metamorphosis")
		if self.Options.WarnDemonForm then
			self:ScheduleAnnounce(82, DBM_ILLIDAN_WARN_DEMONPHASE_SOON, 3)
		end
		
		self:StartStatusBarTimer(71.5, "Enrage2", "Interface\\Icons\\Ability_Warrior_EndlessRage")
		self:ScheduleAnnounce(66.5, DBM_ILLIDAN_WARN_P4ENRAGE_SOON, 3)
		
		phase4 = true
	elseif msg == "DemonForm" then
		flameBursts = 0
		if self.Options.WarnDemonForm then
			self:Announce(DBM_ILLIDAN_WARN_PHASE_DEMON, 4)
		end
		self:StartStatusBarTimer(74, "Normal Phase", "Interface\\Icons\\INV_Weapon_ShortBlade_07")
		self:StartStatusBarTimer(34, "Shadow Demons", "Interface\\Icons\\Spell_Shadow_SoulLeech_3")
		self:StartStatusBarTimer(20, "Next Flame Burst", "Interface\\Icons\\Spell_Fire_BlueRainOfFire")
		if self.Options.WarnDemonForm then
			self:ScheduleAnnounce(64, DBM_ILLIDAN_WARN_NORMALPHASE_SOON, 2)
		end
		if self.Options.WarnShadowDemons then
			self:ScheduleAnnounce(29, DBM_ILLIDAN_WARN_SHADOWDEMSSOON, 2)
		end
		if self.Options.WarnFlameBursts then
			self:ScheduleAnnounce(15, DBM_ILLIDAN_WARN_FLAMEBURST_SOON, 1)
		end
		self:ScheduleMethod(74, "SendSync", "NormalForm")
		warnedDemons = nil
	elseif msg == "NormalForm" then
		if self.Options.WarnDemonForm then
			self:Announce(DBM_ILLIDAN_WARN_PHASE_NORMAL, 4)
		end
		self:StartStatusBarTimer(60, "Demon Phase", "Interface\\Icons\\Spell_Shadow_Metamorphosis")
		if self.Options.WarnDemonForm then
			self:ScheduleAnnounce(50, DBM_ILLIDAN_WARN_DEMONPHASE_SOON, 3)
		end
		if phase4 then
			self:StartStatusBarTimer(40, "Enrage2", "Interface\\Icons\\Ability_Warrior_EndlessRage")
			self:ScheduleAnnounce(35, DBM_ILLIDAN_WARN_P4ENRAGE_SOON, 3)
		end
	elseif msg == "FlameDown" then
		flamesDown = flamesDown + 1
		if flamesDown >= 2 then
			self:SendSync("Phase3")
		end
	elseif msg == "Flameburst" then
		flameBursts = flameBursts + 1
		if flameBursts < 3 then
			self:StartStatusBarTimer(19.5, "Next Flame Burst", "Interface\\Icons\\Spell_Fire_BlueRainOfFire")
			if self.Options.WarnFlameBursts then
				self:ScheduleAnnounce(14.5, DBM_ILLIDAN_WARN_FLAMEBURST_SOON, 1)
			end
		end
		if self.Options.WarnFlameBursts then
			self:Announce(DBM_ILLIDAN_WARN_FLAMEBURST:format(flameBursts), 3)
		end
	elseif msg:sub(0, 10) == "ShadowDems" then
		msg = msg:sub(11)
		if msg == UnitName("player") then
			self:AddSpecialWarning(DBM_ILLIDAN_SELFWARN_DEMONS)
		end
		table.insert(demonTargets, msg)
		self:UnScheduleEvent("WarnSD")
		if #demonTargets == 4 then
			self:OnEvent("WarnSD")
		else
			self:ScheduleEvent(1, "WarnSD")
		end
	elseif msg == "Prison" then
		self:Announce(DBM_ILLIDAN_WARN_PRISON)
		self:StartStatusBarTimer(30, "Shadow Prison", "Interface\\Icons\\Spell_Shadow_SealOfKings")
	elseif msg == "P4Enrage" then
		self:Announce(DBM_ILLIDAN_WARN_P4ENRAGE_NOW, 4)
	elseif msg == "Caged" then
		self:Announce(DBM_ILLIDAN_WARN_CAGED, 1)
		self:StartStatusBarTimer(15, "Caged", 40695)
	end
end
