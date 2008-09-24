local Kal = DBM:NewBossMod("Kal", DBM_KAL_NAME, DBM_KAL_DESCRIPTION, DBM_SUNWELL, DBM_SW_TAB, 1)

Kal.Version		= "1.0"
Kal.Author		= "Tandanu"
Kal.MinRevision = 988

Kal:SetCreatureID(24850)
Kal:RegisterCombat("yell", DBM_KAL_YELL_PULL, 24892)

Kal:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED", -- this will fire just after SPELL_AURA_DISPELLED, so there's no need to check for SPELL_AURA_DISPELLED
	"UNIT_DIED",
	"UNIT_HEALTH"
)

Kal:AddOption("WarnBreathNew", false, DBM_KAL_OPTION_BREATH)
Kal:AddOption("PreWarnBreathNew", false, DBM_KAL_OPTION_PREBREATH)
Kal:AddOption("RangeCheck", false, DBM_KAL_OPTION_RANGE)
Kal:AddOption("SpecWarnMagic", true, DBM_KAL_OPTION_WM_WARN2)
Kal:AddOption("WhisperMagic", true, DBM_KAL_OPTION_WM_WHISPER)
Kal:AddOption("WarnCoA", true, DBM_KAL_OPTION_COA_WARN)
Kal:AddOption("CoAIcon", false, DBM_KAL_OPTION_COA_ICON)
Kal:AddOption("PreWarnPort", true, DBM_KAL_OPTION_PORT_PREWARN)
Kal:AddOption("WarnPort", true, DBM_KAL_OPTION_PORT_WARN)
Kal:AddOption("ShowFrame", true, DBM_KAL_OPTION_SHOWFRAME)
Kal:AddOption("FrameLocked", false, DBM_KAL_MENU_LOCK)
Kal:AddOption("WarnStrike", false, DBM_KAL_OPTION_STRIKE)
Kal.Options.FramePoint = "CENTER"
Kal.Options.FrameX = 150
Kal.Options.FrameY = -50


Kal:AddOption("FrameClassColor", true, DBM_KAL_FRAME_COLORS, function()
	Kal:UpdateColors() 
end)
Kal:AddOption("FrameUpwards", false, DBM_KAL_FRAME_UPWARDS, function()
	Kal:ChangeFrameOrientation()
end)

local dragonHP = 100
local demonHP = 100


Kal:AddBarOption("Arcane Buffet")
Kal:AddBarOption("Frost Breath", false)
Kal:AddBarOption("Next Portal #(.*)")
Kal:AddBarOption("Portal #(.*)")
Kal:AddBarOption("Ported")
Kal:AddBarOption("Exhausted")
Kal:AddBarOption("CoA: (.*)")


local noPortWarn = 0
local portCounter = 0


function Kal:OnCombatStart()
	noPortWarn = 0
	portCounter = 0
	dragonHP = 100
	demonHP = 100
	if self.Options.ShowFrame then
		self:CreateFrame()
	end
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Show()
	end
end

function Kal:OnCombatEnd()
	self:DestroyFrame()
	DBM_Gui_DistanceFrame_Hide()
end

function Kal:OnEvent(event, args)
	if event == "SPELL_CAST_START" then
		if args.spellId == DBM_KAL_SPELLID_BREATH then
			self:SendSync("Breath")
		end
	elseif event == "SPELL_AURA_APPLIED" then
		if args.spellId and DBM_KAL_SPELLIDS_WM[args.spellId] then
			self:SendSync("WM"..tostring(args.spellId)..tostring(args.destName))
		elseif args.spellId == DBM_KAL_SPELLID_COA1 or args.spellId == DBM_KAL_SPELLID_COA2 then
			self:SendSync("CoA"..tostring(args.destName))
		elseif args.spellId == DBM_KAL_SPELLID_PORT1 then
			self:SendSync("Port"..tostring(args.destName))
		elseif args.spellId == DBM_KAL_SPELLID_BUFFET then
			self:SendSync("Buffet")
		elseif args.spellId == 45029 then
			self:SendSync("Strike"..tostring(args.destName))
		end
	elseif event == "SPELL_AURA_APPLIED_DOSE" then
		if args.spellId == DBM_KAL_SPELLID_BUFFET then
			self:SendSync("Buffet")
		end
	elseif event == "SPELL_AURA_REMOVED" then
		if args.spellId == DBM_KAL_SPELLID_COA1 or args.spellId == DBM_KAL_SPELLID_COA2 then
			self:SendSync("ECoA"..tostring(args.destName))
		end
	elseif event == "UNIT_DIED" then
		if bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
			self:SendSync("Down"..tostring(args.destName))
		end
	elseif event == "UNIT_HEALTH" and UnitIsEnemy(arg1, "player") then
		if UnitName(arg1) == DBM_KAL_NAME then
			self:SendSync("HPDragon"..tostring(UnitHealth(arg1)))
		elseif UnitName(arg1) == DBM_KAL_KILL_NAME then
			self:SendSync("HPDemon"..tostring(UnitHealth(arg1)))
		end
	end
end

local function getUnitId(name)
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid"..i) == name then
			return "raid"..i
		end
	end	
	return "raid41" -- to avoid nil error messages
end

function Kal:OnSync(msg, sender)
	if msg == "Breath" then
		self:StartStatusBarTimer(15.5, "Frost Breath", "Interface\\Icons\\Spell_Frost_FrostBlast")
		if self.Options.WarnBreathNew then
			self:Announce(DBM_KAL_WARN_BREATH, 3)
		end		
		if self.Options.PreWarnBreathNew then
			self:ScheduleAnnounce(12.5, DBM_KAL_WARN_BREATH_SOON, 1)
		end
	elseif msg:sub(0, 2) == "WM" then
		msg = msg:sub(3)
		local _, _, spellId, name = msg:find("(%d+)(.+)")
		if spellId then
			spellId = tonumber(spellId)
			local spellType = DBM_KAL_SPELLIDS_WM[spellId]
		
			if spellType == "Cast" then 	-- Casting time increased by 100%.
				if UnitPowerType(getUnitId(name)) == 0 then
					if self.Options.SpecWarnMagic and name == UnitName("player") then
						self:AddSpecialWarning(DBM_KAL_WARN_CASTTIME)
					end
					if self.Options.WhisperMagic then
						self:SendHiddenWhisper(DBM_KAL_WHISPER_WM:format(DBM_KAL_WARN_CASTTIME), name)
					end
				end
			elseif spellType == "Hit" then	-- Chance to hit with melee and ranged attacks reduced by 50%.
				local _, class = UnitClass(getUnitId(name))
				if class == "WARRIOR"
				or class == "ROGUE"
				or class == "HUNTER"
				or (class == "DRUID" and (UnitPowerType(getUnitId(name)) == 1 or UnitPowerType(getUnitId(name)) == 3))
				or (class == "SHAMAN" and (UnitManaMax(getUnitId(name)) or 0) < 10000) then
					if self.Options.SpecWarnMagic and name == UnitName("player") then
						self:AddSpecialWarning(DBM_KAL_WARN_HIT)
					end
					if self.Options.WhisperMagic then
						self:SendHiddenWhisper(DBM_KAL_WHISPER_WM:format(DBM_KAL_WARN_HIT), name)
					end
				end
			elseif spellType == "Crit" then	-- Damage done by critical hits increased by 100%.
				local _, class = UnitClass(getUnitId(name))
				if class == "WARRIOR"
				or class == "ROGUE"
				or class == "HUNTER"
				or (class == "DRUID" and (UnitPowerType(getUnitId(name)) == 1 or UnitPowerType(getUnitId(name)) == 3))
				or (class == "SHAMAN" and (UnitManaMax(getUnitId(name)) or 0) < 10000) then
					if self.Options.SpecWarnMagic and name == UnitName("player") then
						self:AddSpecialWarning(DBM_KAL_WARN_CRIT)
					end
					if self.Options.WhisperMagic then
						self:SendHiddenWhisper(DBM_KAL_WHISPER_WM:format(DBM_KAL_WARN_CRIT), name)
					end
				end
			elseif spellType == "Aggro" then -- Increases threat generated by 100%.
				if self.Options.SpecWarnMagic and name == UnitName("player") then
					self:AddSpecialWarning(DBM_KAL_WARN_AGGRO)
				end
				if self.Options.WhisperMagic then
					self:SendHiddenWhisper(DBM_KAL_WHISPER_WM:format(DBM_KAL_WARN_AGGRO), name)
				end
			elseif spellType == "Heal" then -- Healing done by spells and effects increased by 100%.
				local _, class = UnitClass(getUnitId(name))
				if (class == "PRIEST" and not DBM.GetBuff(getUnitId(name), GetSpellInfo(15473)))
				or class == "PALADIN"
				or (class == "DRUID" and UnitPowerType(getUnitId(name)) == 0)
				or (class == "SHAMAN" and (UnitManaMax(getUnitId(name)) or 0) > 10000) then
					if self.Options.SpecWarnMagic and name == UnitName("player") then
						self:AddSpecialWarning(DBM_KAL_WARN_HEAL)
					end
					if self.Options.WhisperMagic then
						self:SendHiddenWhisper(DBM_KAL_WHISPER_WM:format(DBM_KAL_WARN_HEAL), name)
					end
				end				
			elseif spellType == "Cost" then	-- Spell and ability costs reduced by 50%.
				if self.Options.SpecWarnMagic and name == UnitName("player") then
					self:AddSpecialWarning(DBM_KAL_WARN_COST)
				end
				if self.Options.WhisperMagic then
					self:SendHiddenWhisper(DBM_KAL_WHISPER_WM:format(DBM_KAL_WARN_COST), name)
				end
			end

		end
	elseif msg:sub(0, 3) == "CoA" then
		msg = msg:sub(4)
		if self.Options.WarnCoA then
			self:Announce(DBM_KAL_WARN_COA:format(msg), 4)
		end
		if self.Options.CoAIcon then
			self:SetIcon(msg, 30)
		end
		self:StartStatusBarTimer(30, "CoA: "..msg, "Interface\\Icons\\Spell_Shadow_CurseOfSargeras")
	elseif msg:sub(0, 4) == "ECoA" then
		msg = msg:sub(5)
		if self.Options.CoAIcon then
			self:RemoveIcon(msg)
		end
		self:EndStatusBarTimer("CoA: "..msg)
	elseif msg:sub(0, 4) == "Port" then
		msg = msg:sub(5)
		local grp, class
		for i = 1, GetNumRaidMembers() do
			local name, _, subgroup, _, _, fileName = GetRaidRosterInfo(i)
			if name == msg then
				grp = subgroup
				class = fileName
				break
			end
		end
		
		if (GetTime() - noPortWarn) > 20 then
			noPortWarn = GetTime()
			portCounter = portCounter + 1
			if self.Options.WarnPort then
				self:Announce(DBM_KAL_WARN_PORT:format(portCounter, msg, (grp or 0)), 2)
			end
			if self.Options.PreWarnPort then
				self:ScheduleAnnounce(22, DBM_KAL_WARN_PORT_SOON:format(portCounter + 1), 1)
			end
			self:StartStatusBarTimer(25, "Next Portal #"..(portCounter + 1), "Interface\\Icons\\Spell_Arcane_PortalUnderCity")
			self:StartStatusBarTimer(15, "Portal #"..portCounter, "Interface\\Icons\\Spell_Arcane_PortalUnderCity")
		end
		
		if msg == UnitName("player") then
			self:StartStatusBarTimer(60, "Ported", "Interface\\Icons\\Spell_Arcane_PortalUnderCity", true)
			self:ScheduleMethod(60, "StartStatusBarTimer", 60, "Exhausted", "Interface\\Icons\\Spell_Shadow_Teleport", true)
		end		
		self:AddEntry(("%s (%d)"):format(msg, grp or 0), class)
		
	elseif msg:sub(0, 4) == "Down" then
		msg = msg:sub(5)
		self:RemoveIcon(msg)
		self:EndStatusBarTimer("CoA: "..msg)
		local grp
		for i = 1, GetNumRaidMembers() do
			local name, _, subgroup = GetRaidRosterInfo(i)
			if name == msg then
				grp = subgroup
				break
			end
		end
		self:RemoveEntry(("%s (%d)"):format(msg, grp or 0))
	elseif msg == "Buffet" then
		self:StartStatusBarTimer(8, "Arcane Buffet", DBM_KAL_SPELLID_BUFFET)
	elseif msg:sub(0, 6) == "Strike" and self.InCombat then
		msg = msg:sub(7)
		if self.Options.WarnStrike then
			self:Announce(DBM_KAL_WARN_STRIKE:format(msg), 1)
		end
	end
end

function Kal:GetBossHP()
	return DBM_KAL_STATUS_MSG:format(dragonHP, demonHP)
end
