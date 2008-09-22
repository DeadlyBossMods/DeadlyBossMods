local Souls = DBM:NewBossMod("Souls", DBM_SOULS_NAME, DBM_SOULS_DESCRIPTION, DBM_BLACK_TEMPLE, DBM_BT_TAB, 6)

Souls.Version	= "1.0"
Souls.Author	= "Tandanu"
Souls.MinVersionToSync = 3.00

Souls:RegisterCombat("YELL", DBM_SOULS_YELL_PULL, nil, nil, DBM_SOULS_BOSS_KILL_NAME, 20)

Souls:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE"
)

local drainTargets = {}
local spiteTargets = {}
local lastFixate
local lastSpite = 0
local phase = 1

Souls:AddOption("WarnDrain", true, DBM_SOULS_OPTION_DRAIN)
Souls:AddOption("WarnDrainCast", false, DBM_SOULS_OPTION_DRAIN_CAST)
Souls:AddOption("WarnFixate", false, DBM_SOULS_OPTION_FIXATE)
Souls:AddOption("WarnScream", false, DBM_SOULS_OPTION_SCREAM)
Souls:AddOption("WarnSpite", true, DBM_SOULS_OPTION_SPITE)
Souls:AddOption("SpecWarnSpite", true, DBM_SOULS_OPTION_SPECWARN_SPITE)
Souls:AddOption("SpiteWhisper", true, DBM_SOULS_OPTION_WHISPER_SPITE)

Souls:AddBarOption("Enrage")
Souls:AddBarOption("Next Enrage")
Souls:AddBarOption("Fixate: (.*)")
Souls:AddBarOption("Mana Drain")
Souls:AddBarOption("Rune Shield")
Souls:AddBarOption("Deaden")
Souls:AddBarOption("Soul Scream")

function Souls:OnCombatStart(delay)
	drainTargets = {}
	spiteTargets = {}
	lastFixate = nil
	self:StartStatusBarTimer(47 - delay, "Next Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy")
	self:ScheduleSelf(42 - delay, "EnrageWarn")
	phase = 1
end


function Souls:OnEvent(event, arg1)
	if event == "CHAT_MSG_RAID_BOSS_EMOTE" then
		if arg1 == DBM_SOULS_EMOTE_ENRAGE and self.InCombat then
			self:Announce(DBM_SOULS_WARN_ENRAGE, 3)
			self:StartStatusBarTimer(15, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy")
			self:ScheduleSelf(15, "NextEnrage")
		end
	elseif event == "NextEnrage" then
		self:Announce(DBM_SOULS_WARN_ENRAGE_OVER, 2)
		self:StartStatusBarTimer(32, "Next Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy")
		self:ScheduleSelf(27, "EnrageWarn")
	elseif event == "EnrageWarn" then
		self:Announce(DBM_SOULS_WARN_ENRAGE_SOON, 2)
	
	elseif event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 41431 and bit.band(arg1.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) == 0 then
			self:SendSync("Runeshield")
		elseif arg1.spellId == 41376 then
			self:SendSync("Spite"..tostring(arg1.destName))
		elseif arg1.spellId == 41303 then
			self:SendSync("SoulDrain"..tostring(arg1.destName))
		elseif arg1.spellId == 41294 then
			self:SendSync("Fixate"..tostring(arg1.destName))
		end
	elseif event == "RuneShieldWarn" then
		self:Announce(DBM_SOULS_WARN_RUNESHIELD_SOON, 2)

	elseif event == "SPELL_CAST_START" then
		if arg1.spellId == 41410 then
			self:SendSync("Deaden")
		elseif arg1.spellId == 41303 then
			self:SendSync("DrainCast")
		end
	
	elseif event == "SPELL_DAMAGE" then
		if arg1.spellId == 41545 then
			self:SendSync("SoulScream")
		end
	
	elseif event == "DeadenWarn" then
		self:Announce(DBM_SOULS_WARN_DEADEN_SOON, 1)
	
	elseif event == "CHAT_MSG_MONSTER_YELL" and arg1 then
		if arg1 == DBM_SOULS_YELL_DESIRE or arg1:find(DBM_SOULS_YELL_DESIRE_DEMONIC) then
			phase = 2
			self:Announce(DBM_SOULS_WARN_DESIRE_INC, 1)
			self:StartStatusBarTimer(160, "Mana Drain", "Interface\\Icons\\Spell_Shadow_SiphonMana")
			self:ScheduleSelf(140, "ManaDrainWarn")
			
			self:StartStatusBarTimer(13.5, "Rune Shield", "Interface\\Icons\\Spell_Arcane_Blast")
			self:ScheduleSelf(10.5, "RuneShieldWarn")
			self:StartStatusBarTimer(28, "Deaden", "Interface\\Icons\\Spell_Shadow_SoulLeech_1")
			self:ScheduleSelf(23, "DeadenWarn")
		elseif arg1 == DBM_SOULS_YELL_ANGER_INC then
			phase = 3
			self:Announce(DBM_SOULS_WARN_ANGER_INC, 1)
		end
	elseif event == "ManaDrainWarn" then
		self:Announce(DBM_SOULS_WARN_MANADRAIN, 1)

	elseif event == "WarnDrain" then
		local msg = ""
		for i, v in ipairs(drainTargets) do
			msg = msg..">"..v.."<"..", "
		end
		msg = msg:sub(0, -3)
		drainTargets = {}
		self:Announce(DBM_SOULS_WARN_SOULDRAIN:format(msg), 1)
	elseif event == "WarnSpite" then
		if (GetTime() - lastSpite) > 12 then
			lastSpite = GetTime()
			local msg = ""
			for i, v in ipairs(spiteTargets) do
				msg = msg..">"..v.."<"..", "
				if v == UnitName("player") then
					if self.Options.SpecWarnSpite then
						self:AddSpecialWarning(DBM_SOULS_SPECWARN_SPITE)
					end
				end
				if self.Options.SpiteWhisper and self.Options.Announce and DBM.Rank >= 1 then
					self:SendHiddenWhisper(DBM_SOULS_WHISPER_SPITE, v)
				end
			end
			msg = msg:sub(0, -3)
			spiteTargets = {}
			self:Announce(DBM_SOULS_WARN_SPITE:format(msg), 2)
		else
			spiteTargets = {}
		end
	end
end

function Souls:GetBossHP()
	if phase == 1 then
		return DBM_SOULS_BOSS_SUFFERING..": "..DBM.GetHPByName(DBM_SOULS_BOSS_SUFFERING)
	elseif phase == 2 then
		return DBM_SOULS_BOSS_DESIRE..": "..DBM.GetHPByName(DBM_SOULS_BOSS_DESIRE)
	elseif phase == 3 then
		return DBM_SOULS_BOSS_KILL_NAME..": "..DBM.GetHPByName(DBM_SOULS_BOSS_KILL_NAME)
	end
end

function Souls:OnSync(msg)
	if msg == "Runeshield" then
		self:Announce(DBM_SOULS_WARN_RUNESHIELD, 3)
		self:StartStatusBarTimer(15.4, "Rune Shield", "Interface\\Icons\\Spell_Arcane_Blast") -- the timer between 2 runeshields is always about 15.5 seconds in my combatlog...this could be due to delay/lag/whatever, but this timer seems to be quite accurate
		self:ScheduleSelf(12.4, "RuneShieldWarn")
	elseif msg == "Deaden" then
		self:Announce(DBM_SOULS_WARN_DEADEN, 2)
		self:StartStatusBarTimer(31.5, "Deaden", "Interface\\Icons\\Spell_Shadow_SoulLeech_1")
		self:ScheduleSelf(26.5, "DeadenWarn")
	elseif msg:sub(0, 5) == "Spite" and self.Options.WarnSpite then
		msg = msg:sub(6)
		table.insert(spiteTargets, msg)
		self:UnScheduleSelf("WarnSpite")
		if #spiteTargets == 3 then
			self:OnEvent("WarnSpite")
		else
			self:ScheduleSelf(1.3, "WarnSpite")
		end
	elseif msg:sub(0, 9) == "SoulDrain" and self.Options.WarnDrain then
		msg = msg:sub(10)
		table.insert(drainTargets, msg)
		self:UnScheduleSelf("WarnDrain")
		if #drainTargets == 5 then
			self:OnEvent("WarnDrain")
		else
			self:ScheduleSelf(1.5, "WarnDrain")
		end
	elseif msg == "DrainCast" then
		if self.Options.WarnDrainCast then
			self:Announce(DBM_SOULS_WARN_SOULDRAIN_CAST, 1)
		end
	elseif msg:sub(0, 6) == "Fixate" and self.InCombat then
		msg = msg:sub(7)
		if lastFixate then
			self:EndStatusBarTimer(lastFixate)
		end
		self:StartStatusBarTimer(5.5, "Fixate: "..msg, "Interface\\Icons\\Spell_Shadow_SpectralSight")
		lastFixate = "Fixate: "..msg
		if msg == UnitName("player") then
			self:AddSpecialWarning(DBM_SOULS_SPECWARN_FIXATE)
		end
		if self.Options.WarnFixate then
			self:Announce(DBM_SOULS_WARN_FIXATE:format(msg), 2)
		end
	elseif msg == "SoulScream" then
		self:StartStatusBarTimer(10, "Soul Scream", "Interface\\Icons\\Spell_Shadow_SoulLeech")
		if self.Options.WarnScream then
			self:Announce(DBM_SOULS_WARN_SCREAM, 1)
		end
	end
end