if GetLocale() ~= "zhTW" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "北裂境野獸"
}

L:SetMiscLocalization{
	Charge				= "%%s怒視著(%S+)，並發出震耳的咆哮!",
	CombatStart			= "來自風暴群山最深邃，最黑暗的洞穴。歡迎『穿刺者』戈莫克!戰鬥吧，英雄們!",
	Phase3				= "下一場參賽者的出場連空氣都會為之凝結:冰嚎!戰個你死我活吧，勇士們!"
}

L:SetOptionLocalization{
	WarningImpale			= "為刺穿顯示警告",
	WarningFireBomb			= "為燃燒彈顯示警告",
	WarningBreath			= "為寒地之息顯示警告",
--	WarningSpray			= "為痲痺噴霧顯示警告",
	WarningRage			= "為泡沫之怒顯示警告",
	WarningCharge			= "為撞擊的目標顯示警告",
	WarningToxin			= "為痲痺劇毒的目標顯示警告",
	WarningBile			= "為燃燒膽汁的目標顯示警告",
	SpecialWarningImpale3		= "為刺穿(大於3層)顯示特別警告",
	SpecialWarningFireBomb		= "當你中了燃燒彈時顯示特別警告",
	SpecialWarningSlimePool		= "為泥漿池顯示特別警告",
	SpecialWarningSilence		= "為法術沉默顯示特別警告",
	SpecialWarningSpray		= "當你中了痲痺噴霧時顯示特別警告",
	SpecialWarningToxin		= "當你中了痲痺劇毒時顯示特別警告",
	SpecialWarningBile		= "當你中了燃燒膽汁時顯示特別警告",
	SpecialWarningCharge		= "當冰嚎即將撞擊你時顯示特別警告",
	SpecialWarningChargeNear	= "當冰嚎的撞擊接近你時顯示特別警告",
	SetIconOnChargeTarget		= "為撞擊的目標設置標記(頭顱)",
	SetIconOnBileTarget		= "為燃燒膽汁的目標設置標記",
	ClearIconsOnIceHowl		= "撞擊前消除所有標記",
	TimerNextBoss			= "為下一隻王到來顯示計時器"
}

L:SetTimerLocalization{
	TimerNextBoss			= "下一隻王到來"
}

L:SetWarningLocalization{
	WarningImpale			= "%s: >%s<",
	WarningFireBomb			= "燃燒彈",
--	WarningSpray			= "%s: >%s<",
	WarningBreath			= "寒地之息",
	WarningRage			= "泡沫之怒",
	WarningCharge			= "撞擊: >%s<",
	WarningToxin			= "痲痺劇毒: >%s<",
	WarningBile			= "燃燒膽汁: >%s<",
	SpecialWarningImpale3		= "你中了刺穿>%d<!",
	SpecialWarningFireBomb		= "你中了燃燒彈!",
	SpecialWarningSlimePool		= "泥漿池, 跑開!",
	SpecialWarningSilence		= "~1.5秒後 法術沉默!",
	SpecialWarningSpray		= "你中了痲痺噴霧!",
	SpecialWarningToxin		= "痲痺劇毒! 跑開!",
	SpecialWarningCharge		= "你中了撞擊! 跑開!",
	SpecialWarningChargeNear	= "接近你的人中了撞擊! 跑開!",
	SpecialWarningBile		= "你中了燃燒膽汁!"
}


-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "賈拉克瑟斯領主"
}

L:SetWarningLocalization{
	WarnFlame			= "聚合烈焰: >%s<",
	WarnTouch			= "賈拉克瑟斯之觸: >%s<",
	WarnNetherPower			= "虛空威能在賈拉克瑟斯領主身上! 快驅散!",
	WarnPortalSoon			= "虛空傳送門 即將到來!",
	WarnVolcanoSoon			= "煉獄爆發 即將到來!",
	SpecWarnFlesh			= "你中了焚化血肉!",
	SpecWarnTouch			= "你中了賈拉克瑟斯之觸!",
	SpecWarnKiss			= "仕女之吻",
	SpecWarnTouchNear		= "接近你的>%s<中了賈拉克瑟斯之觸!",
	SpecWarnFlame			= "聚合烈焰! 跑開!",
	SpecWarnNetherPower		= "現在驅散!",
	SpecWarnFelInferno		= "魔化煉獄! 跑開!"
}

L:SetMiscLocalization{
	WhisperFlame			= "你中了聚合烈焰!"
}

L:SetOptionLocalization{
	WarnFlame			= "為聚合烈焰顯示警告",
	WarnTouch			= "為賈拉克瑟斯之觸顯示警告",
	WarnNetherPower			= "當賈拉克瑟斯領主擁有虛空威能時警告 (驅散/竊取用)",
	WarnPortalSoon			= "預先提示虛空傳送門的出現",
	WarnVolcanoSoon			= "預先提示煉獄爆發的出現",
	SpecWarnFlame			= "當你中了聚合烈焰時顯示特別警告",
	SpecWarnFlesh			= "當你中了焚化血肉時顯示特別警告",
	SpecWarnTouch			= "當你中了賈拉克瑟斯之觸時顯示特別警告",
	SpecWarnTouchNear		= "當你附近的人中了賈拉克瑟斯之觸時顯示特別警告",
	SpecWarnKiss			= "當你中了仕女之吻時顯示特別警告",
	SpecWarnNetherPower		= "為虛空威能顯示特別警告 (驅散賈拉克瑟斯領主用)",
	SpecWarnFelInferno		= "當你太接近魔化煉獄時顯示特別警告",
	TouchJaraxxusIcon		= "為賈拉克瑟斯之觸的目標設置標記 (十字)",
	IncinerateFleshIcon		= "為焚化血肉的目標設置標記 (頭顱)",
	LegionFlameIcon			= "為聚合烈焰的目標設置標記 (正方)",
	LegionFlameWhisper		= "密語提示中了聚合烈焰的人"
}


-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "各陣營勇士"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnHellfire			= "地獄烈焰",
	SpecWarnHellfire		= "地獄烈焰! 跑開!"
}

L:SetMiscLocalization{
	Gorgrim				= "DK - 高葛林·影斬",	-- 34458
	Birana 				= "D - 碧菈娜·風暴之蹄",-- 34451
	Erin				= "D - 艾琳·霧蹄",	-- 34459
	Rujkah				= "H - 茹卡",		-- 34448
	Ginselle			= "M - 金賽兒·凋擲",	-- 34449
	Liandra				= "P - 黎安卓·喚日",	-- 34445
	Malithas			= "P - 瑪力薩·亮刃",	-- 34456
	Caiphus				= "PR - 嚴厲的凱普司",	-- 34447
	Vivienne			= "PR - 薇薇安·黑語",	-- 34441
	Mazdinah			= "R - 馬茲迪娜",	-- 34454
	Thrakgar			= "S - 瑟瑞克加爾",	-- 34444
	Broln				= "S - 伯洛連·頑角",	-- 34455
	Harkzog				= "WL - 哈克佐格",	-- 34450
	Narrhok				= "W - 納霍克·破鋼者",		-- 34453
	YellKill			= "膚淺而悲痛的勝利。今天痛失的生命反而令我們更加的頹弱。除了巫妖王之外，誰還能從中獲利?偉大的戰士失去了寶貴生命。為了什麼?真正的威脅就在前方 - 巫妖王在死亡的領域中等著我們。"
} 

L:SetOptionLocalization{
	WarnHellfire			= "當哈克佐格施放地獄烈焰時警告",
	SpecWarnHellfire		= "當你受到地獄烈焰時顯示特別警告"

}


------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "華爾琪雙子"
}

L:SetTimerLocalization{
	TimerSpecialSpell		= "下一次 特別技能"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "特別技能 即將到來!",
	SpecWarnSpecial			= "另一顏色AE即將來臨 快變換顏色!",
	SpecWarnEmpoweredDarkness	= "強力黑暗",
	SpecWarnEmpoweredLight		= "強力光明"
}

L:SetMiscLocalization{
	YellPull 			= "以我們的黑暗君王之名。為了巫妖王。你‧得‧死。",
	Fjola 				= "菲歐拉·光寂",
	Eydis				= "艾狄絲·暗寂"
}

L:SetOptionLocalization{
	TimerSpecialSpell		= "為下一次 特別技能顯示計時器",
	WarnSpecialSpellSoon		= "為下一次 特別技能預先提示",
	SpecWarnSpecial			= "當你需要變換顏色時顯示特別警告",
	SpecWarnEmpoweredDarkness	= "為強力黑暗顯示特別警告",
	SpecWarnEmpoweredLight		= "為強力光明顯示特別警告",
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name = "阿努巴拉克"
}

L:SetTimerLocalization{
	TimerEmerge			= "鑽地維持",
	TimerSubmerge			= "下一次 鑽地"
}

L:SetWarningLocalization{
	WarnEmerge			= "阿努巴拉克從地底鑽出來了",
	WarnEmergeSoon			= "10秒後 鑽進地裡",
	WarnSubmerge			= "阿努巴拉克鑽進地裡了",
	WarnSubmergeSoon		= "10秒後 鑽出來",
	WarnPursue			= "追擊尖刺: >%s<",
	SpecWarnPursue			= "你中了追擊尖刺!"	
}

L:SetMiscLocalization{
	YellPull			= "這裡將會是你們的墳墓!",
	Swarm				= "蟲群將會淹沒你們!",
	Emerge				= "%s從地底鑽出!",
	Burrow				= "%s鑽進地裡!"
}

L:SetOptionLocalization{
	WarnEmerge			= "為鑽地顯示警告",
	WarnEmergeSoon			= "為鑽地顯示預先警告",
	WarnSubmerge			= "為下一次 鑽地顯示警告",
	WarnSubmergeSoon		= "為下一次 鑽地顯示預先警告",
	SpecWarnPursue			= "當你被追擊時顯示特別警告",
	TimerEmerge			= "顯示鑽地的計時器",
	TimerSubmerge			= "顯示下一次鑽地的計時器",
	PlaySoundOnPursue		= "當你被追擊時播放音效",
	PursueIcon			= "為被追擊的玩家設置標記",
	WarnPursue			= "提示被追擊的玩家"
}