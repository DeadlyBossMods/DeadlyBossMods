local Kil = DBM:NewBossMod("Kil", DBM_KIL_NAME, DBM_KIL_DESCRIPTION, DBM_SUNWELL, DBM_SW_TAB, 6)

Kil.Version	= "0.92"
Kil.Author	= "Tandanu"
Kil.MinRevision = 1043

Kil:SetCreatureID(25315)
Kil:RegisterCombat("yell", DBM_KIL_YELL_PULL)

Kil:AddOption("RangeCheck", true, DBM_KIL_OPTION_RANGE)
Kil:AddOption("WarnShield", true, DBM_KIL_OPTION_SHIELD)
Kil:AddOption("WarnOrb", true, DBM_KIL_OPTION_ORB)
Kil:AddOption("FireTargetWarn", true, DBM_KIL_OPTION_FIRETARGET)
Kil:AddOption("FireSay", true, DBM_KIL_OPTION_FIRESAY)
Kil:AddOption("FireWhisper", true, DBM_KIL_OPTION_FIREWHISP)
Kil:AddOption("FireIcon", true, DBM_KIL_OPTION_FIREICON)
Kil:AddOption("WarnReflections", false, DBM_KIL_OPTION_WARNREFL)
Kil:AddOption("WarnDarts", true, DBM_KIL_OPTION_DARTS)
Kil:AddOption("WarnDragonOrb", true, DBM_KIL_OPTION_DRAGONORB)

Kil:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_AURA_APPLIED"
)

local orbGUIDs = {}
local lastOrb = 0
local fire = {}
local phase = 2

function Kil:OnCombatStart()
	orbGUIDs = {}
	lastOrb = 0
	fire = {}
	phase = 2
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Show()
	end
	self:Announce(DBM_KIL_WARN_PHASE1, 3)
end

function Kil:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide()
	end
end

function Kil:OnEvent(event, args)
	if event == "CHAT_MSG_MONSTER_YELL" then
		if args == DBM_KIL_YELL_PHASE2_1 or args == DBM_KIL_YELL_PHASE2_2 then
			self:SendSync("Phase")
		end
	elseif event == "SPELL_DAMAGE" or event == "SPELL_MISSED" then
		if args.spellId == 45680 then
			if not orbGUIDs[args.sourceGUID] then
				orbGUIDs[args.sourceGUID] = true
				self:SendSync("Orb")
			end
		end
	elseif event == "SPELL_CAST_SUCCESS" then
		if args.spellId == 45848 then
			self:SendSync("StartShield")
		elseif args.spellId == 45892 then
			self:SendSync("Reflections")
		end
	elseif event == "SPELL_AURA_APPLIED" then
--		if args.spellId == 45848 and bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 and shieldCasted then
--			self:SendSync("Shield"..tostring(args.destName))
		if args.spellId == 45641 then
			self:SendSync("Fire"..tostring(args.destName))
		end
	elseif event == "SPELL_CAST_START" then
		if args.spellId == 46605 then
			self:SendSync("Darkness")
--		elseif args.spellId == 45641 then
--			self:SendSync("BloomInc")
		elseif args.spellId == 45737 then
			self:SendSync("Darts")
		end
	end
end

local function announceFire(self)
	if self.Options.FireIcon then
		local icon = 8
		for i, v in ipairs(fire) do
			self:SetIcon(v, 20, icon)
			icon = icon - 1
		end
	end
	if self.Options.FireTargetWarn then
		self:Announce(DBM_KIL_WARN_FIRE_ON:format(table.concat(fire, "<, >"), 2))
		fire = {}
	end
	self:StartStatusBarTimer(20, "Fire Bloom CD", 45641)
end

function Kil:OnSync(msg)
	if msg == "StartShield" then
		if self.Options.WarnShield then
			self:Announce(DBM_KIL_WARN_SHIELD, 1)
		end
--		shieldCasted = true
--	elseif msg:sub(0, 6) == "Shield" then
--		msg = msg:sub(7)
--		shieldCasted = false
--		if self.Options.WarnShield then
--			self:Announce(DBM_KIL_WARN_SHIELD:format(msg), 2)
--		end
	elseif msg == "Phase" then
		phase = phase + 1
		if phase == 3 then
			self:Announce(DBM_KIL_WARN_PHASE2, 3)
			self:StartStatusBarTimer(77, "Next Darkness", 46605)
			self:ScheduleAnnounce(72, DBM_KIL_WARN_DARKNESS_SOON, 3)
			self:StartStatusBarTimer(59, "Flame Darts", 45740)
			if self.Options.WarnDarts then
				self:ScheduleAnnounce(54, DBM_KIL_WARN_DARTS_SOON, 1)
			end
			self:StartStatusBarTimer(37, "Dragon Orb", 45109)
			if self.Options.WarnDragonOrb then
				self:ScheduleAnnounce(32, DBM_KIL_WARN_DRAGORB_SOON, 2)
				self:ScheduleAnnounce(37, DBM_KIL_WARN_DRAGORB_NOW, 3)
			end
		elseif phase == 4 then
			self:Announce(DBM_KIL_WARN_PHASE3, 3)
			self:EndStatusBarTimer("Next Darkness")
			self:UnScheduleAnnounce(DBM_KIL_WARN_DARKNESS_SOON, 3)
			self:StartStatusBarTimer(77, "Next Darkness", 46605)
			self:ScheduleAnnounce(72, DBM_KIL_WARN_DARKNESS_SOON, 3)
			self:StartStatusBarTimer(37, "Dragon Orb", 45109)
			if self.Options.WarnDragonOrb then
				self:ScheduleAnnounce(32, DBM_KIL_WARN_DRAGORB_SOON, 2)
				self:ScheduleAnnounce(37, DBM_KIL_WARN_DRAGORB_NOW, 3)
			end
		elseif phase == 5 then
			self:Announce(DBM_KIL_WARN_PHASE4, 3)
			self:EndStatusBarTimer("Next Darkness")
			self:UnScheduleAnnounce(DBM_KIL_WARN_DARKNESS_SOON, 3)
			self:StartStatusBarTimer(58, "Next Darkness", 46605)
			self:ScheduleAnnounce(53, DBM_KIL_WARN_DARKNESS_SOON, 3)
		end
	elseif msg == "Darkness" then
		self:Announce(DBM_KIL_WARN_DARKNESS, 4)
		if phase == 5 then
			self:StartStatusBarTimer(25, "Next Darkness", 46605)
			self:ScheduleAnnounce(20, DBM_KIL_WARN_DARKNESS_SOON, 3)
		else
			self:StartStatusBarTimer(45, "Next Darkness", 46605)
			self:ScheduleAnnounce(40, DBM_KIL_WARN_DARKNESS_SOON, 3)
		end
		self:StartStatusBarTimer(8.5, "Darkness", 46605)
		self:ScheduleAnnounce(8.5, DBM_KIL_WARN_DARKNESS_NOW, 4)
	elseif msg == "Orb" then
		if (GetTime() - lastOrb) > 10 then
			lastOrb = GetTime()
			if self.Options.WarnOrb then
				if phase >= 3 then
					self:Announce(DBM_KIL_WARN_ORBS, 1)
				else
					self:Announce(DBM_KIL_WARN_ORB, 1)
				end
			end
		end
--	elseif msg == "BloomInc" then
--		if self.Options.FireWarn then
--			self:Announce(DBM_KIL_WARN_FIRE, 1)
--		end
	elseif msg:sub(0, 4) == "Fire" then
--		self:AddMsg(msg)
		msg = msg:sub(5)
		table.insert(fire, msg)
		local class
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i) == msg then
				class = select(2, UnitClass("raid"..i))
				break
			end
		end
		if #fire == 5 then
			announceFire(self)
			DBM.UnSchedule(announceFire, self)
		else
			DBM.UnSchedule(announceFire, self)
			DBM.Schedule(1, announceFire, self)
		end
		if UnitName("player") == msg then
			if self.Options.FireSay then
				SendChatMessage(DBM_KIL_WARN_FIRE_SAY, "SAY")
			end
		end
		if self.Options.FireWhisper then
			self:SendHiddenWhisper(DBM_KIL_WARN_FIRE_WHISPER, msg)
		end
	elseif msg == "Reflections" then
		if self.Options.WarnReflections then
			self:Announce(DBM_KIL_WARN_REFLECTIONS, 3)
		end
		
	elseif msg == "Darts" then
		self:StartStatusBarTimer(20, "Flame Darts", 45740)
		if self.Options.WarnDarts then
			self:Announce(DBM_KIL_WARN_DARTS, 3)			
			self:ScheduleAnnounce(15, DBM_KIL_WARN_DARTS_SOON, 1)
		end			
	end
end
