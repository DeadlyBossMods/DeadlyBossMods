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
	specWarnTrap			= "陷阱激活! - 亡縛守衛釋放了"
}

L:SetOptionLocalization{
	specWarnTrap			= "為陷阱激活顯示預先警告",
	SetIconOnDarkReckoning		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
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
	warnMortalWound			= "%s: >%s< (%s)",
	specWarnTrap			= "陷阱激活! - 復仇的血肉收割者即將到來"
}

L:SetOptionLocalization{
	specWarnTrap			= "為陷阱激活顯示預先警告",
	warnMortalWound			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "快，我們要從後面奇襲他們!",
	FleshreaperTrap2		= "你無法逃避我們!",
	FleshreaperTrap3		= "The living? Here?!"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name 				= "赤紅大廳小怪"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name 				= "瑪洛嘉領主"
}

L:SetTimerLocalization{
	achievementBoned		= "去骨計時"
}

L:SetWarningLocalization{
	WarnImpale			= ">%s< 被刺穿了"
}

L:SetOptionLocalization{
	WarnImpale			= "提示$spell:69062的目標",
	achievementBoned		= "為成就:去骨顯示計時器",
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
	WarnReanimating			= "小怪再活化",
	WarnTouchInsignificance		= "%s: >%s< (%s)",
	WarnAddsSoon			= "新的小怪 即將到來",
	specWarnVengefulShade		= "你被復仇的暗影盯上了 - 快跑開"
}

L:SetOptionLocalization{
	WarnAddsSoon			= "為新的小怪出現顯示預先警告",
	WarnReanimating			= "當小怪再活化時顯示警告",
	TimerAdds			= "為新的小怪顯示計時器",
	specWarnVengefulShade		= "當你被復仇的暗影盯上時顯示特別警告",
	ShieldHealthFrame		= "為$spell:70842顯示首領血量框架",
	WarnTouchInsignificance		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),	
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull			= "這騷動是怎麼回事?你竟敢擅闖聖地?這裡將是你的最終之地!",
	YellReanimatedFanatic		= "起來，在純粹的形態中感受狂喜!",
	ShieldPercent			= "法力屏障",
	Fanatic1			= "神教狂熱者",
	Fanatic2			= "畸形的狂熱者",
	Fanatic3			= "再活化的狂熱者"
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
	warnFrenzySoon			= "為狂亂顯然預先警告 (大約33%)",
	SetIconOnBoilingBlood		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	SetIconOnMarkCast		= "為施放$spell:72444時的目標設置標記\n(試驗中，可能會錯誤地標記坦克)",
	RangeFrame			= "顯示距離框 (12碼)",
	RunePowerFrame			= "顯示首領血量及$spell:72371條"
}

L:SetMiscLocalization{
	RunePower			= "血魄威能",
	PullAlliance			= "每個你殺死的部落士兵 -- 每條死去的聯盟狗，都讓巫妖王的軍隊隨之增長。此時此刻華爾琪都還在把你們倒下的同伴復活成天譴軍。",
	PullHorde			= "柯爾克隆，前進!勇士們，要當心，天譴軍團已經……"
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name 				= "膿腸"
}

L:SetWarningLocalization{
	InhaledBlight			= "吸納荒疫: >%d<",
	WarnGastricBloat		= "%s: >%s< (%s)"

}

L:SetOptionLocalization{
	InhaledBlight			= "為$spell:71912顯示警告",
	RangeFrame			= "顯示距離框 (8碼)",
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
	WarnOozeSpawn			= "小軟泥怪 出現了",
	WarnUnstableOoze		= "%s: >%s< (%s)",
	specWarnLittleOoze		= "你被小軟泥怪盯上了 - 快跑開"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "下一次 劇毒軟泥管"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "為下一次劇毒軟泥管顯示計時器",
	WarnOozeSpawn			= "為小軟泥的出現顯示警告",
	specWarnLittleOoze		= "當你被小軟泥怪盯上時顯示特別警告",
	WarnUnstableOoze		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown"),
	InfectionIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	ExplosionIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69839)
}

L:SetMiscLocalization{
	YellSlimePipes1			= "大夥聽著，好消息!我修好了劇毒軟泥管!",
	YellSlimePipes2			= "大夥聽著，超級好消息!軟泥又開始流動了!"
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name 				= "普崔希德教授"
}

L:SetWarningLocalization{
	WarnPhase2Soon			= "第2階段 即將到來",
	WarnPhase3Soon			= "第3階段 即將到來",
	WarnMutatedPlague		= "%s: >%s< (%s)",
	specWarnMalleableGoo		= "你中了延展黏液 - 快離開",
	specWarnMalleableGooNear	= "你附近有人中了延展黏液 - 小心"
}

L:SetOptionLocalization{
	WarnPhase2Soon			= "為第2階段顯示預先警告 (大約83%)",
	WarnPhase3Soon			= "為第3階段顯示預先警告 (大約38%)",
	specWarnMalleableGoo		= "當你中了延展黏液時顯示特別警告\n(只在你是第一個目標時有用)",
	specWarnMalleableGooNear	= "當你附近有人中了延展黏液時顯示特別警告\n(只在你附近的人是第一個目標時有用)",
	WarnMutatedPlague		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	MalleableGooIcon		= "為第一個中$spell:72295的目標設置標記"

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
	WarnTargetSwitch		= "轉換目標到: %s",
	WarnTargetSwitchSoon		= "轉換目標 即將到來"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "轉換目標"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "為轉換目標顯示警告",
	WarnTargetSwitchSoon		= "為轉換目標顯示預先警告",
	TimerTargetSwitch		= "為轉換目標顯示冷卻計時器",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "設置標記在強力的親王身上 (頭顱)"
}

L:SetMiscLocalization{
	Keleseth			= "凱雷希斯親王",
	Taldaram			= "泰爾達朗親王",
	Valanar				= "瓦拉納爾親王",
	EmpoweredFlames			= "煉獄烈焰加速靠近(%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name 				= "血腥女王菈娜薩爾"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkFallen		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838)
}

L:SetMiscLocalization{
	SwarmingShadows			= "暗影聚集並旋繞在(%S+)四周!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name 				= "瓦莉絲瑞雅·夢行者"
}

L:SetWarningLocalization{
	warnCorrosion			= "%s: >%s< (%s)"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "設置標記在熾熱骷髏身上 (頭顱)",
	warnCorrosion			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "unknown")
}

L:SetMiscLocalization{
	YellPull			= "入侵者已經突破了內部聖所。加快摧毀綠龍的速度!只要留下骨頭和肌腱來復活!",
	YellKill			= "我重生了!伊瑟拉賦予我讓那些邪惡生物安眠的力量!",
	YellPortals			= "我打開了一道傳送門通往夢境。你們的救贖就在其中，英雄們……",
	YellPhase2			= "我的力量正在恢復。加把勁，英雄們!"
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
	warnPhase2soon			= "第2階段 即將到來",
	WarnAirphase			= "空中階段",
	WarnGroundphaseSoon		= "辛德拉苟莎 即將著陸",
	warnInstability			= "不穩定: >%d<",
	warnChilledtotheBone		= "徹骨之寒: >%d<",
	warnMysticBuffet		= "秘能連擊: >%d<"
}

L:SetOptionLocalization{
	WarnAirphase			= "提示空中階段",
	WarnGroundphaseSoon		= "為地上階段顯示預先警告",
	warnPhase2soon			= "為第2階段顯示預先警告 (大約38%)",
	TimerNextAirphase		= "為下一次 空中階段顯示計時器",
	TimerNextGroundphase		= "為下一次 地上階段顯示計時器",
	warnInstability			= "為你的$spell:69766堆疊顯示警告",
	warnChilledtotheBone		= "為你的$spell:70106堆疊顯示警告",
	warnMysticBuffet		= "為你的$spell:70128堆疊顯示警告",
	SetIconOnFrostBeacon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126)
}

L:SetMiscLocalization{
	YellAirphase			= "你們的入侵將在此終止!誰也別想存活!",
	YellPhase2			= "現在，絕望地感受我主無限的力量吧!",
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
	WarnPhase2Soon			= "第2階段轉換 即將到來",
	WarnPhase3Soon			= "第3階段轉換 即將到來",
	specWarnDefileCast		= "你中了汙染 - 快跑開",
	specWarnDefileCastNear		= "你附近的人中了汙染 - 小心"
}

L:SetTimerLocalization{
	TimerCombatStart		= "戰鬥開始",
	PhaseTransition			= "階段轉換"
}

L:SetOptionLocalization{
	TimerCombatStart		= "為戰鬥開始顯示計時器",
	PhaseTransition			= "為階段轉換顯示計時器",
	WarnPhase2Soon			= "為第2階段轉換顯示預先警告 (大約73%)",
	WarnPhase3Soon			= "為第3階段轉換顯示預先警告 (大約43%)",
	specWarnDefileCast		= "當你中了$spell:72762時顯示特別警告",
	specWarnDefileCastNear		= "當你附近的人中了$spell:72762時顯示特別警告",
	DefileIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73779),
	NecroticPlagueIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912)
}

L:SetMiscLocalization{
	YellPull			= "聖光所謂的正義終於來了嗎?我是否該把雙之哀傷放下,祈求你的寬恕呢,弗丁?"
}