if GetLocale() ~= "zhTW" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name 				= "瑪洛嘉領主"
}

L:SetTimerLocalization{
	achievementBoned		= "自由時間"
}

L:SetWarningLocalization{
	WarnImpale			= ">%s< 被刺穿了",
	SpecWarnWhirlwind		= "旋風斬 - 快跑開",
	SpecWarnColdflame		= "冷焰 - 快跑開"
}

L:SetOptionLocalization{
	WarnImpale			= "提示刺穿的目標",
	SpecWarnWhirlwind		= "為旋風斬顯示特別警告",
	SpecWarnColdflame		= "當你受到冷焰的傷害時顯示特別警告",
	PlaySoundOnWhirlwind		= "為旋風斬播放音效",
	achievementBoned		= "為Boned成就顯示計時器"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name 				= "亡語女士"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnReanimating			= "小怪再活化",		-- Reanimating an adherent or fanatic
	WarnTouchInsignificance		= "%s: >%s< (%s)",	-- Touch of Insignificance on >args.destName< (args.amount)
	SpecWarnDeathDecay		= "死亡凋零 - 快跑開",
	SpecWarnCurseTorpor		= "你中了魯鈍詛咒",
	SpecWarnTouchInsignificance	= "無足輕重之觸 (3)",
	WarnAddsSoon			= "新的小怪即將出現"
}

L:SetOptionLocalization{
	WarnAddsSoon			= "為新的小怪出現顯示預先警告",
	WarnTouchInsignificance		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),		-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	WarnReanimating			= "當小怪再活化時顯示警告",	-- Reanimated Adherent/Fanatic spawning
	SpecWarnTouchInsignificance	= "當你中了3層無足輕重之觸時顯示特別警告",
	SpecWarnDeathDecay		= "當你中了死亡凋零時顯示特別警告",
	SpecWarnCurseTorpor		= "當你中了魯鈍詛咒時顯示特別警告",
}

L:SetMiscLocalization{
	YellPull			= "這騷動是怎麼回事?你竟敢擅闖聖地?這裡將是你的最終之地!",
	YellReanimatedFanatic		= "起來，在純粹的形態中感受狂喜!",
}

------------------------
--  The Deathbringer  --
------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name 				= "死亡使者薩魯法爾"
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
	name 				= "砲艇戰"
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
	name 				= "膿腸"
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
	name 				= "腐臉"
}

L:SetWarningLocalization{
	SpecWarnStickyOoze		= "粘稠軟泥 - 快跑開",
	SpecWarnRadiatingOoze		= "輻射軟泥",
	SpecWarnMutatedInfection 	= "你中了突變感染"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "下一次 泥漿噴霧"
}

L:SetOptionLocalization{
	SpecWarnStickyOoze		= "為粘稠軟泥顯示特別警告",
	SpecWarnRadiatingOoze		= "為輻射軟泥顯示特別警告",
	NextPoisonSlimePipes		= "為下一次泥漿噴霧顯示計時器",
	SpecWarnMutatedInfection 	= "為突變感染顯示特別警告",
	InfectionIcon			= "為突變感染的目標設置標記",
	WarnOozeSpawn			= "為小軟泥怪出現顯示警告"
}

L:SetMiscLocalization{
	YellSlimePipes			= "大夥聽著，好消息!我修好了劇毒軟泥管!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name 				= "普崔希德教授"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	YellPull			= "大夥聽著，好消息!我想我研發出一種瘟疫足以毀滅艾澤拉斯上所有的生命!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name 				= "血親王議會"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "轉換目標到: %s",		-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon		= "即將轉換目標",			-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnResonance		= "暗影共鳴 - 跑開"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "可能的轉換目標"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "為轉換目標顯示警告",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon		= "為轉換目標顯示預先警告",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "為目標轉換冷卻顯示計時器",
	SpecWarnResonance		= "當黑暗晶核跟隨你時顯示特別警告"	-- If it follows you, you have to move to the tank
}

L:SetMiscLocalization{
	Keleseth			= "凱雷希斯親王",
	Taldaram			= "泰爾達朗親王",
	Valanar				= "瓦拉納爾親王"
}

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name 				= "血腥女王菈娜薩爾"
}

L:SetWarningLocalization{
	SpecWarnPactDarkfallen		= "你中了暗殞契印"
}

L:SetOptionLocalization{
	SpecWarnPactDarkfallen		= "當你中了暗殞契印時顯示特別警告"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name 				= "瓦莉絲瑞雅·夢行者"
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
	name 				= "辛德拉苟莎"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "下一次 空中階段",
	TimerNextGroundphase		= "下一次 地上階段"
}

L:SetWarningLocalization{
	WarnAirphase			= "空中階段",
	SpecWarnBlisteringCold		= "極凍之寒 - 快跑開",
	SpecWarnFrostBeacon		= "你中了冰霜信標",
	WarnGroundphaseSoon		= "辛德拉苟莎 即將著陸",
	SpecWarnUnchainedMagic		= "你中了無束魔法"
}

L:SetOptionLocalization{
	WarnAirphase			= "提示空中階段",
	SpecWarnBlisteringCold		= "為極凍之寒顯示特別警告",
	SpecWarnFrostBeacon		= "為冰霜信標顯示特別警告",
	WarnGroundphaseSoon		= "為地上階段顯示預先警告",
	TimerNextAirphase		= "為下一次 空中階段顯示計時器",
	TimerNextGroundphase		= "為下一次 地上階段顯示計時器",
	SpecWarnUnchainedMagic		= "為無束魔法顯示特別警告"
}

L:SetMiscLocalization{
	YellAirphase			= "你們的入侵將在此終止!誰也別想存活!",
	YellPull			= "你們真是夠蠢了才會來到此地。北裂境的冰冷寒風將吞噬你們的靈魂!"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name 				= "巫妖王"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

