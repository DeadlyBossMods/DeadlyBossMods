if GetLocale() ~= "zhTW" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "瑪洛嘉領主"
}

L:SetTimerLocalization{
	achievementBoned		= "自由時間"
}

L:SetWarningLocalization{
	WarnImpale				= ">%s< 被刺穿了",
	SpecWarnWhirlwind		= "旋風斬 - 快跑開",
	SpecWarnColdflame		= "冷焰 - 快跑開"
}

L:SetOptionLocalization{
	WarnImpale				= "提示刺穿的目標",
	SpecWarnWhirlwind		= "為旋風斬顯示特別警告",
	SpecWarnColdflame		= "當你受到冷焰的傷害時顯示特別警告",
	PlaySoundOnWhirlwind	= "為旋風斬播放音效",
	achievementBoned		= "為Boned成就顯示計時器"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "緋紅亡語者"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnReanimating			= "小怪復元中",	-- Reanimating an adherent or fanatic
	WarnTouchInsignificance		= "%s: >%s< (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	SpecWarnDeathDecay		= "死亡凋零 - 快跑開",
	SpecWarnCurseTorpor		= "你中了Curse of Torpor",
	SpecWarnTouchInsignificance	= "Touch of Insignificance (3)",
	WarnAddsSoon			= "新的小怪即將出現"
}

L:SetOptionLocalization{
	WarnAddsSoon			= "為新的小怪出現顯示預先警告",
	WarnTouchInsignificance		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204)),		-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	WarnReanimating			= "當小怪正在復元中時顯示警告",	-- Reanimated Adherent/Fanatic spawning
	SpecWarnTouchInsignificance	= "當你中了3層Touch of Insignificance時顯示特別警告",
	SpecWarnDeathDecay		= "當你中了死亡凋零時顯示特別警告",
	SpecWarnCurseTorpor		= "當你中了Curse of Torpor時顯示特別警告",
}

L:SetMiscLocalization{
	YellPull				= "What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!",
	YellReanimatedFanatic		= "Arise, and exult in your pure form!",
}

------------------------
--  The Deathbringer  --
------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "薩魯法爾·死亡召喚者"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "砲艇突擊戰"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "膿腸"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "腐臉"
}

L:SetWarningLocalization{
	SpecWarnStickyOoze			= "Sticky Ooze - 快跑開",
	SpecWarnRadiatingOoze		= "Radiating Ooze",
	SpecWarnMutatedInfection 	= "你中了Mutated Infection"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "下一次 Poison Slime Pipes"
}

L:SetOptionLocalization{
	SpecWarnStickyOoze			= "為Sticky Ooze顯示特別警告",
	SpecWarnRadiatingOoze		= "為Radiating Ooze顯示特別警告",
	NextPoisonSlimePipes		= "為下一次 Poison Slime Pipes顯示計時器",
	SpecWarnMutatedInfection 	= "為Mutated Infection顯示特別警告",
	InfectionIcon				= "為Mutated Infection的目標設置標記",
	WarnOozeSpawn				= "為小軟泥怪出現顯示警告"
}

L:SetMiscLocalization{
	YellSlimePipes				= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "普崔希德教授"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	YellPull	= "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "血王子議會"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "轉換目標到: %s",		-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon	= "即將轉換目標",			-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnResonance		= "Shadow Resonance - 跑開"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "可能的轉換目標"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "為轉換目標顯示警告",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "為轉換目標顯示預先警告",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "為目標轉換冷卻顯示計時器",
	SpecWarnResonance		= "當Dark Nucleus跟隨你時顯示特別警告"	-- If it follows you, you have to move to the tank
}

L:SetMiscLocalization{
	Keleseth				= "Prince Keleseth",
	Taldaram				= "Prince Taldaram",
	Valanar					= "Prince Valanar"
}

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "菈娜薩爾女王"
}

L:SetWarningLocalization{
	SpecWarnPactDarkfallen	= "你中了Pact of the Darkfallen"
}

L:SetOptionLocalization{
	SpecWarnPactDarkfallen	= "當你中了Pact of the Darkfallen時顯示特別警告"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "瓦莉絲瑞雅．夢行者"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "辛德拉苟莎"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "下一次 空中階段",
	TimerNextGroundphase	= "下一次 地上階段"
}

L:SetWarningLocalization{
	WarnAirphase			= "空中階段",
	SpecWarnBlisteringCold	= "Blistering Cold - 快跑開",
	SpecWarnFrostBeacon		= "你中了Frost beacon",
	WarnGroundphaseSoon		= "辛德拉苟莎 即將著陸",
	SpecWarnUnchainedMagic	= "你中了Unchained Magic"
}

L:SetOptionLocalization{
	WarnAirphase			= "提示空中階段",
	SpecWarnBlisteringCold	= "為Blistering Cold顯示特別警告",
	SpecWarnFrostBeacon		= "為Frost Beacon顯示特別警告",
	WarnGroundphaseSoon		= "為地上階段顯示預先警告",
	TimerNextAirphase		= "為下一次 空中階段顯示計時器",
	TimerNextGroundphase	= "為下一次 地上階段顯示計時器",
	SpecWarnUnchainedMagic	= "為Unchained Magic顯示特別警告"
}

L:SetMiscLocalization{
	YellAirphase			= "Your incursion ends here! None shall survive!",
	YellPull				= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "巫妖王"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

