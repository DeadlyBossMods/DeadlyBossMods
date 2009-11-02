if GetLocale() ~= "zhTW" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "北裂境巨獸"
}

L:SetMiscLocalization{
	Charge				= "%%s怒視著(%S+)，並發出震耳的咆哮!",
	CombatStart			= "來自風暴群山最深邃，最黑暗的洞穴。歡迎『穿刺者』戈莫克!戰鬥吧，英雄們!",
	Phase3				= "下一場參賽者的出場連空氣都會為之凝結:冰嚎!戰個你死我活吧，勇士們!",
	Gormok				= "『穿刺者』戈莫克",
	Acidmaw				= "酸喉",
	Dreadscale			= "懼鱗",
	Icehowl				= "冰嚎"
}

L:SetOptionLocalization{
	SpecialWarningImpale3		= "為刺穿(大於3層)顯示特別警告",
	SpecialWarningFireBomb		= "當你中了燃燒彈時顯示特別警告",
	SpecialWarningSlimePool		= "當你受到泥漿池的傷害時顯示特別警告",
	SpecialWarningSilence		= "為驚恐踐踏顯示特別警告",
	SpecialWarningToxin		= "當你中了痲痺劇毒時顯示特別警告",
	SpecialWarningBile		= "當你中了燃燒膽汁時顯示特別警告",
	SpecialWarningCharge		= "當冰嚎即將衝鋒你時顯示特別警告",
	PingCharge			= "當冰嚎即將衝鋒你時自動點擊小地圖",
	SpecialWarningChargeNear	= "當冰嚎的衝鋒在你附近時顯示特別警告",
	SetIconOnChargeTarget		= "設置標記在衝鋒的目標(頭顱)",
	SetIconOnBileTarget		= "設置標記在燃燒膽汁的目標",
	ClearIconsOnIceHowl		= "衝鋒前消除所有標記",
	TimerNextBoss			= "為下一隻王到來顯示計時器",
	TimerCombatStart		= "為戰鬥開始顯示計時器"
}

L:SetTimerLocalization{
	TimerNextBoss			= "下一隻王到來",
	TimerCombatStart		= "戰鬥開始"
}

L:SetWarningLocalization{
	SpecialWarningImpale3		= "你中了刺穿>%d<",
	SpecialWarningFireBomb		= "你中了燃燒彈",
	SpecialWarningSlimePool		= "泥漿池 - 快跑開",
	SpecialWarningSilence		= "1.5秒後 驚恐踐踏",
	SpecialWarningToxin		= "痲痺劇毒 - 快跑開",
	SpecialWarningCharge		= "你被衝鋒了 - 快跑開",
	SpecialWarningChargeNear	= "你附近有人被衝鋒 - 快跑開",
	SpecialWarningBile		= "你中了燃燒膽汁"
}



---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "賈拉克瑟斯領主"
}

L:SetWarningLocalization{
	WarnNetherPower			= "賈拉克瑟斯領主擁有虛空威能 - 快驅散",
	SpecWarnFlesh			= "你中了焚化血肉",
	SpecWarnTouch			= "你中了賈拉克瑟斯之觸",
	SpecWarnKiss			= "你中了仕女之吻",
	SpecWarnTouchNear		= "你附近的>%s<中了賈拉克瑟斯之觸",
	SpecWarnFlame			= "軍團烈焰 - 快跑開",
	SpecWarnNetherPower		= "現在驅散",
	SpecWarnFelInferno		= "魔化煉獄 - 快跑開",
	SpecWarnFelFireball		= "魔化火球 - 現在斷法",
	SpecWarnFelFireballDispel	= "魔化火球: %s - 快驅散"
}

L:SetMiscLocalization{
	WhisperFlame			= "你中了軍團烈焰 - 快跑開",
	IncinerateTarget		= "焚化血肉: %s"
}

L:SetOptionLocalization{
	WarnNetherPower			= "當賈拉克瑟斯領主擁有虛空威能時警告 (驅散/竊取用)",
	SpecWarnFlame			= "當你中了軍團烈焰時顯示特別警告",
	SpecWarnFlesh			= "當你中了焚化血肉時顯示特別警告",
	SpecWarnTouch			= "當你中了賈拉克瑟斯之觸時顯示特別警告",
	SpecWarnTouchNear		= "當你附近的人中了賈拉克瑟斯之觸時顯示特別警告",
	SpecWarnKiss			= "當你中了仕女之吻時顯示特別警告",
	SpecWarnNetherPower		= "為虛空威能顯示特別警告 (驅散/竊取用)",
	SpecWarnFelFireball		= "為魔化火球顯示特別警告 (斷法用)",
	SpecWarnFelFireballDispel	= "為魔化火球顯示特別警告 (驅散用)",
	SpecWarnFelInferno		= "當你在魔化煉獄附近時顯示特別警告",
	TouchJaraxxusIcon		= "設置標記在賈拉克瑟斯之觸的目標 (十字)",
	IncinerateFleshIcon		= "設置標記在焚化血肉的目標 (頭顱)",
	LegionFlameIcon			= "設置標記在軍團烈焰的目標 (正方)",
	LegionFlameWhisper		= "密語提示中了軍團烈焰的目標",
	IncinerateShieldFrame		= "在首領血量裡顯示焚化血肉的血量"
}


-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "各陣營勇士"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecWarnHellfire		= "地獄烈焰 - 快跑開",
	SpecWarnHandofProt		= "保護聖禦: %s - 快驅散",
	SpecWarnDivineShield		= "聖盾術: %s - 快驅散"
}

L:SetMiscLocalization{
	Gorgrim				= "死騎 - 高葛林·影斬",		-- 34458, Horde
	Birana 				= "小德 - 碧菈娜·風暴之蹄",	-- 34451, Horde
	Erin				= "小德 - 艾琳·霧蹄",		-- 34459, Horde
	Rujkah				= "獵人 - 茹卡",		-- 34448, Horde
	Ginselle			= "法師 - 金賽兒·凋擲",		-- 34449, Horde
	Liandra				= "聖騎 - 黎安卓·喚日",		-- 34445, Horde
	Malithas			= "聖騎 - 瑪力薩·亮刃",		-- 34456, Horde
	Caiphus				= "牧師 - 嚴厲的凱普司",	-- 34447, Horde
	Vivienne			= "牧師 - 薇薇安·黑語",		-- 34441, Horde
	Mazdinah			= "盜賊 - 馬茲迪娜",		-- 34454, Horde
	Thrakgar			= "薩滿 - 瑟瑞克加爾",		-- 34444, Horde
	Broln				= "薩滿 - 伯洛連·頑角",		-- 34455, Horde
	Harkzog				= "術士 - 哈克佐格",		-- 34450, Horde
	Narrhok				= "戰士 - 納霍克·破鋼者",	-- 34453, Horde
	Tyrius				= "死騎 - 提瑞斯·暮刃",		-- 34461, Allience
 	Kavina				= "小德 - 卡薇娜·林地之歌",	-- 34460, Allience
 	Melador				= "小德 - 梅拉朵·谷行者",	-- 34469, Allience
 	Alyssia 			= "獵人 - 愛莉希雅·月巡者",	-- 34467, Allience
 	Noozle				= "法師 - 諾佐·嘯棍",		-- 34468, Allience
 	Baelnor 			= "聖騎 - 貝爾諾·攜光者",	-- 34471, Allience
 	Velanaa				= "聖騎 - 維蘭娜", 		-- 34465, Allience
 	Anthar				= "牧師 - 安薩·修爐匠",		-- 34466, Allience
 	Brienna				= "牧師 - 布芮娜·夜墜",		-- 34473, Allience
 	Irieth				= "盜賊 - 艾芮絲·影步",		-- 34472, Allience
 	Saamul				= "薩滿 - 薩繆爾", 		-- 34470, Allience
 	Shaabad				= "薩滿 - 夏巴德", 		-- 34463, Allience
 	Serissa				= "術士 - 瑟芮莎·厲濺",		-- 34474, Allience
 	Shocuul				= "戰士 - 修庫爾",		-- 34475, Allience
	YellKill			= "膚淺而悲痛的勝利。今天痛失的生命反而令我們更加的頹弱。除了巫妖王之外，誰還能從中獲利?偉大的戰士失去了寶貴生命。為了什麼?真正的威脅就在前方 - 巫妖王在死亡的領域中等著我們。"
} 

L:SetOptionLocalization{
	SpecWarnHellfire		= "當你受到地獄烈焰的傷害時顯示特別警告",
	SpecWarnHandofProt		= "當聖騎士施放保護聖禦時顯示特別警告",
	SpecWarnDivineShield		= "當聖騎士施放聖盾術時顯示特別警告"

}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "華爾琪雙子"
}

L:SetTimerLocalization{
	TimerSpecialSpell		= "下一次 特別技能"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "特別技能 即將到來",
	SpecWarnSpecial			= "快變換顏色",
	SpecWarnEmpoweredDarkness	= "強力黑暗 - 傷害加倍",
	SpecWarnEmpoweredLight		= "強力光明 - 傷害加倍",
	SpecWarnSwitchTarget		= "快換目標打雙子契印",
	SpecWarnKickNow			= "現在斷法",
	WarningTouchDebuff		= "光明或黑暗之觸: >%s<",
	WarningPoweroftheTwins		= "雙子威能 - 加大治療於 >%s<",
	SpecWarnPoweroftheTwins		= "雙子威能"
}

L:SetMiscLocalization{
	YellPull 			= "以我們的黑暗君王之名。為了巫妖王。你‧得‧死。",
	Fjola 				= "菲歐拉·光寂",
	Eydis				= "艾狄絲·暗寂"
}

L:SetOptionLocalization{
	TimerSpecialSpell		= "為下一次 特別技能顯示計時器",
	WarnSpecialSpellSoon		= "為下一次 特別技能顯示預先警告",
	SpecWarnSpecial			= "當你需要變換顏色時顯示特別警告",
	SpecWarnEmpoweredDarkness	= "當你中了強力黑暗時顯示特別警告",
	SpecWarnEmpoweredLight		= "當你中了強力光明時顯示特別警告",
	SpecWarnSwitchTarget		= "當另一個首領施放雙子契印時顯示特別警告",
	SpecWarnKickNow			= "當你可以斷法時顯示特別警告",
	SpecialWarnOnDebuff		= "當你中了光明或黑暗之觸時顯示特別警告 (需切換顏色)",
	SetIconOnDebuffTarget		= "設置標記在光明或黑暗之觸的目標 (英雄模式)",
	WarningTouchDebuff		= "提示中了光明或黑暗之觸的目標",
	WarningPoweroftheTwins		= "提示雙子威能的目標",
	SpecWarnPoweroftheTwins		= "當你坦住的首領擁有雙子威能時顯示特別警告"
}


-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 				= "阿努巴拉克"
}

L:SetTimerLocalization{
	TimerEmerge			= "持續鑽地",
	TimerSubmerge			= "下一次 鑽地",
	timerAdds			= "下一次 中蟲出現"
}

L:SetWarningLocalization{
	WarnEmerge			= "阿努巴拉克鑽出地面了",
	WarnEmergeSoon			= "10秒後 鑽出地面",
	WarnSubmerge			= "阿努巴拉克鑽進地裡了",
	WarnSubmergeSoon		= "10秒後 鑽進地裡",
	SpecWarnPursue			= "你被追擊了 - 快跑去撞冰塊",
	warnAdds			= "奈幽掘洞者 出現了",
	SpecWarnShadowStrike		= "暗影打擊 - 快斷法",
	SpecWarnPCold			= "你中了透骨之寒"
}

L:SetMiscLocalization{
	YellPull			= "這裡將會是你們的墳墓!",
	Emerge				= "從地底鑽出!",
	Burrow				= "鑽進地裡!"
}

L:SetOptionLocalization{
	WarnEmerge			= "為鑽出地面顯示警告",
	WarnEmergeSoon			= "為鑽出地面顯示預先警告",
	WarnSubmerge			= "為鑽進地裡顯示警告",
	WarnSubmergeSoon		= "為鑽進地裡顯示預先警告",
	SpecWarnPursue			= "當你被追擊時顯示特別警告",
	warnAdds			= "提示奈幽掘洞者出現",
	timerAdds			= "為下一次 奈幽掘洞者出現顯示計時器",
	TimerEmerge			= "為持續鑽地顯示計時器",
	TimerSubmerge			= "為下一次 鑽地顯示計時器",
	PlaySoundOnPursue		= "當你開始被追擊時播放音效",
	PursueIcon			= "設置標記在被追擊的目標 (頭顱)",
	SpecWarnShadowStrike		= "為暗影打擊顯示特別警告 (斷法用)",
	SpecWarnPCold			= "當你中了透骨之寒時顯示特別警告",
	RemoveHealthBuffsInP3		= "當進入第3階段時移除耐力的增益",
	SetIconsOnPCold			= "設置標記在透骨之寒的目標"
}