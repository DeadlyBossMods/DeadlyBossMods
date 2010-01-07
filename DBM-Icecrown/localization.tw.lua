if GetLocale() ~= "zhTW" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name 				= "城塞大門小怪"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkReckoning		= "為$spell:69483的目標設置標記"
}

L:SetMiscLocalization{
	WarderTrap1			= "誰…在那兒…?",
	WarderTrap2			= "我…甦醒了!",
	WarderTrap3			= "主人的聖所受到了打擾!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name 				= "大寶及臭皮"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

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
	WarnImpale			= ">%s< 被刺穿了"
}

L:SetOptionLocalization{
	WarnImpale			= "提示$spell:69062的目標",
	achievementBoned		= "為去骨成就顯示計時器",
	SetIconOnImpale			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name 				= "亡語女士"
}

L:SetTimerLocalization{
	TimerAdds			= "新的小怪"
}

L:SetWarningLocalization{
	WarnReanimating			= "小怪再活化",		-- Reanimating an adherent or fanatic
	WarnTouchInsignificance		= "%s: >%s< (%s)",	-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon			= "新的小怪 即將到來"
}

L:SetOptionLocalization{
	WarnAddsSoon			= "為新的小怪出現顯示預先警告",
	WarnReanimating			= "當小怪再活化時顯示警告",
	TimerAdds			= "為新的小怪顯示計時器",
	ShieldHealthFrame		= "為$spell:70842顯示首領血量框架",
	WarnTouchInsignificance		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),	
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull			= "這騷動是怎麼回事?你竟敢擅闖聖地?這裡將是你的最終之地!",
	YellReanimatedFanatic		= "起來，在純粹的形態中感受狂喜!",
	ShieldPercent			= "法力屏障"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name 				= "砲艇戰"
}

L:SetWarningLocalization{
	WarnBattleFury			= "%s (%d)",
	WarnAddsSoon			= "新的小怪 即將到來"
}

L:SetOptionLocalization{
	WarnBattleFury			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "戰鬥烈怒"),
	TimerCombatStart		= "為戰鬥開始顯示計時器",
	WarnAddsSoon			= "為新的小怪出現顯示預先警告",
	TimerAdds			= "為新的小怪顯示計時器"
}

L:SetTimerLocalization{
	TimerCombatStart		= "戰鬥開始",
	TimerAdds			= "新的小怪"
}

L:SetMiscLocalization{
	PullAlliance			= "發動引擎!小夥子們，我們即將面對命運啦!",
	KillAlliance			= "別說我沒警告過你，無賴!兄弟姊妹們，向前衝!",
	PullHorde			= "起來吧，部落的子女!今天我們要和最可恨的敵人作戰!為了部落!",
	KillHorde			= "聯盟已經動搖了。向巫妖王前進!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name 				= "死亡使者薩魯法爾"
}

L:SetWarningLocalization{
	warnFrenzySoon			= "狂亂 即將到來",
}

L:SetTimerLocalization{
	TimerCombatStart		= "戰鬥開始"
}

L:SetOptionLocalization{
	TimerCombatStart		= "為戰鬥開始顯示計時器",
	warnFrenzySoon			= "為狂亂(大約33%)顯然預先警告",
	SetIconOnBoilingBlood		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	SetIconOnMarkCast		= "設置標記在$spell:72444施放時的目標",
	RangeFrame			= "顯示距離框 (11)",
	RunePowerFrame			= "顯示首領血量+$spell:72371條"
}

L:SetMiscLocalization{
	RunePower			= "血魄威能",
	Pull				= "每個你殺死的部落士兵 -- 每條死去的聯盟狗，都讓巫妖王的軍隊隨之增長。此時此刻華爾琪都還在把你們倒下的同伴復活成天譴軍。"
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name 				= "膿腸"
}

L:SetWarningLocalization{
	InhaledBlight			= "吸納荒疫 >%d<",
	WarnGastricBloat		= "%s: >%s< (%s)",		-- Gastric Bloat on >args.destName< (args.amount)

}

L:SetOptionLocalization{
	InhaledBlight			= "為$spell:71912顯示警告",
	WarnGastricBloat		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72551, GetSpellInfo(72551) or "unknown"),
	SetIconOnGasSpore		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279)
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name 				= "腐臉"
}

L:SetWarningLocalization{
	WarnOozeSpawn			= "小軟泥出現了",
	WarnUnstableOoze		= "%s: >%s< (%s)"			-- Unstable Ooze on >args.destName< (args.amount)
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "下一次 劇毒軟泥管"
}

L:SetOptionLocalization{
	WarnOozeSpawn			= "為小軟泥的出現顯示警告",
	NextPoisonSlimePipes		= "為下一次劇毒軟泥管顯示計時器",
	WarnUnstableOoze		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown"),
	InfectionIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	ExplosionIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69839)
}

L:SetMiscLocalization{
	YellSlimePipes1			= "大夥聽著，好消息!我修好了劇毒軟泥管!",	-- Professor Putricide
	YellSlimePipes2			= "大夥聽著，超級好消息!軟泥又開始流動了!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name 				= "普崔希德教授"
}

L:SetWarningLocalization{
	WarnPhase2Soon			= "第2階段 即將來臨",
	WarnPhase3Soon			= "第3階段 即將來臨",
	WarnMutatedPlague		= "%s: >%s< (%s)"	-- Mutated Plague on >args.destName< (args.amount)

}

L:SetOptionLocalization{
	WarnPhase2Soon			= "為第2階段 (大約83%)顯示特別警告",
	WarnPhase3Soon			= "為第3階段 (大約38%)顯示特別警告",
	WarnMutatedPlague		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672)

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

