local Bloodboil = DBM:NewBossMod("Bloodboil", DBM_BLOODBOIL_NAME, DBM_BLOODBOIL_DESCRIPTION, DBM_BLACK_TEMPLE, DBM_BT_TAB, 5)

Bloodboil.Version	= "1.0"
Bloodboil.Author	= "Tandanu"

local boilCounter = 0

Bloodboil:SetCreatureID(22948)
Bloodboil:RegisterCombat("yell", DBM_BLOODBOIL_YELL_PULL)

Bloodboil:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

Bloodboil:AddOption("WarnSmash", false, DBM_BLOODBOIL_OPTION_SMASH)

Bloodboil:AddBarOption("Enrage")
Bloodboil:AddBarOption("Bloodboil")
Bloodboil:AddBarOption("Fel Rage")
Bloodboil:AddBarOption("Normal Phase")
Bloodboil:AddBarOption("Arcing Smash")


function Bloodboil:OnCombatStart(delay)
	boilCounter = 0
	
	self:StartStatusBarTimer(600 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy")
	self:ScheduleSelf(300 - delay, "EnrageWarn", 300)
	self:ScheduleSelf(480 - delay, "EnrageWarn", 120)
	self:ScheduleSelf(540 - delay, "EnrageWarn", 60)
	self:ScheduleSelf(570 - delay, "EnrageWarn", 30)
	self:ScheduleSelf(590 - delay, "EnrageWarn", 10)
	
	self:StartStatusBarTimer(57.5, "Fel Rage", "Interface\\Icons\\Spell_Fire_ElementalDevastation")
	self:ScheduleSelf(52.5, "FelRageWarn")
	self:StartStatusBarTimer(11.5, "Bloodboil", "Interface\\Icons\\Spell_Shadow_BloodBoil")
end


function Bloodboil:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 42005 then
			self:SendSync("Bloodboil")
		elseif arg1.spellId == 40604 then
			self:SendSync("FelRage"..tostring(arg1.destName))
		elseif arg1.spellId == 40599 then
			self:SendSync("ArcingSmash"..tostring(arg1.destName))
		end
	elseif event == "SPELL_AURA_REMOVED" then
		if arg1.spellId == 40594 then
			boilCounter = 0
			self:Announce(DBM_BLOODBOIL_WARN_NORMALPHASE, 3)
			self:ScheduleSelf(52, "FelRageWarn")
			self:StartStatusBarTimer(57, "Fel Rage", "Interface\\Icons\\Spell_Fire_ElementalDevastation")
			self:StartStatusBarTimer(10, "Bloodboil", "Interface\\Icons\\Spell_Shadow_BloodBoil")
		end
	elseif event == "FelRageWarn" then
		self:Announce(DBM_BLOODBOIL_WARN_FELRAGE_SOON, 2)
	elseif event == "NormalWarn" then
		self:Announce(DBM_BLOODBOIL_WARN_NORMAL_SOON, 2)
	elseif event == "SmashWarn" then
		self:Announce(DBM_BLOODBOIL_WARN_SMASH_SOON, 2)
	elseif event == "EnrageWarn" and type(arg1) == "number" then
		if arg1 >= 60 then
			self:Announce(string.format(DBM_BLOODBOIL_WARN_ENRAGE, (arg1/60), DBM_MIN), 1)
		else
			self:Announce(string.format(DBM_BLOODBOIL_WARN_ENRAGE, arg1, DBM_SEC), 3)
		end
	end
end

function Bloodboil:OnSync(msg)
	if msg == "Bloodboil" then
		boilCounter = boilCounter + 1
		self:Announce(DBM_BLOODBOIL_WARN_BLOODBOIL:format(boilCounter), 1)
		self:StartStatusBarTimer(10, "Bloodboil", "Interface\\Icons\\Spell_Shadow_BloodBoil")
	elseif msg:sub(0, 7) == "FelRage" then
		msg = msg:sub(8)
		self:EndStatusBarTimer("Bloodboil")
		self:StartStatusBarTimer(28, "Normal Phase", "Interface\\Icons\\Spell_Nature_WispSplode")
		self:ScheduleSelf(23, "NormalWarn")
		self:Announce(DBM_BLOODBOIL_WARN_FELRAGE:format(msg), 4)
		boilCounter = 0
	elseif msg:sub(0, 11) == "ArcingSmash" then
		msg = msg:sub(12)
		self:StartStatusBarTimer(4, "Arcing Smash", "Interface\\Icons\\Ability_Warrior_Cleave")
		if self.Options.WarnSmash then
			self:ScheduleSelf(3, "SmashWarn")		
			self:Announce(DBM_BLOODBOIL_WARN_SMASH, 4)
		end
	end
end