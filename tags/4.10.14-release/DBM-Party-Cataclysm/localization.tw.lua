if GetLocale() ~= "zhTW" then return end
local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L= DBM:GetModLocalization(105)

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L= DBM:GetModLocalization(106)

L:SetWarningLocalization({
	WarnAdd		= "小怪被釋放了"
})

L:SetOptionLocalization({
	WarnAdd		= "當一隻小怪的$spell:75608消散時警告"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L= DBM:GetModLocalization(107)

L:SetTimerLocalization({
	TimerSuperheated 	= "極灸水銀護甲(%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "為$spell:75846顯示持續時間計時器"
})

------------
-- Beauty --
------------
L= DBM:GetModLocalization(108)

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L= DBM:GetModLocalization(109)

L:SetOptionLocalization({
	SetIconOnBoss	= "首領施放$spell:76200後標記首領"
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L= DBM:GetModLocalization(89)

-----------------------
-- Helix Gearbreaker --
-----------------------
L= DBM:GetModLocalization(90)

---------------------
-- Foe Reaper 5000 --
---------------------
L= DBM:GetModLocalization(91)

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L= DBM:GetModLocalization(92)

----------------------
-- "Captain" Cookie --
----------------------
L= DBM:GetModLocalization(93)

----------------------
-- Vanessa VanCleef --
----------------------
L= DBM:GetModLocalization(95)

L:SetTimerLocalization({
	achievementGauntlet	= "充滿活力"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

L:SetOptionLocalization{
	PingBlitz	= "當昂布里斯將軍即將閃擊你時點擊小地圖"
}

L:SetMiscLocalization{
	Blitz		= "將目光注射|cFFFF0000(%S+)"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L= DBM:GetModLocalization(132)

-------------------------
-- Drahga Shadowburner --
-------------------------
L= DBM:GetModLocalization(133)

L:SetMiscLocalization{
	ValionaYell	= "龍啊，聽我命令! 抓住我!",
	Add		= "%s進行"
}

------------
-- Erudax --
------------
L= DBM:GetModLocalization(134)

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L= DBM:GetModLocalization(124)

---------------------
-- Earthrager Ptah --
---------------------
L= DBM:GetModLocalization(125)

L:SetMiscLocalization{
	Kill		= "普塔...不再...存在..."
}

--------------
-- Anraphet --
--------------
L= DBM:GetModLocalization(126)

L:SetTimerLocalization({
	achievementGauntlet	= "成就挑戰"
})

L:SetMiscLocalization({
	Brann				= "好了，快走吧!只需要把最後的登錄程序輸入到門的機關中....然後..."
})

------------
-- Isiset --
------------
L= DBM:GetModLocalization(127)

L:SetWarningLocalization({
	WarnSplitSoon	= "即將分裂"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "為分裂顯示預先警告"
})

-------------
-- Ammunae --
------------- 
L= DBM:GetModLocalization(128)

-------------
-- Setesh  --
------------- 
L= DBM:GetModLocalization(129)

----------
-- Rajh --
----------
L= DBM:GetModLocalization(130)

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L= DBM:GetModLocalization(117)

--------------
-- Lockmaw --
--------------
L= DBM:GetModLocalization(118)

L:SetOptionLocalization{
	RangeFrame	= "顯示距離框(5碼)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "奧各"
})

------------------------
-- High Prophet Barim --
------------------------
L= DBM:GetModLocalization(119)

L:SetOptionLocalization{
	BossHealthAdds	= "在首領血量框架顯示小怪血量"
}

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

L:SetWarningLocalization{
	specWarnPhase2Soon	= "5秒後進入第2階段"
}

L:SetTimerLocalization({
	timerPhase2 	= "第2階段開始"
})

L:SetOptionLocalization{
	specWarnPhase2Soon	= "當第2階段即將到來(5秒)時顯示特別警告",
	timerPhase2 	= "為第2階段開始顯示計時器"
}

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L= DBM:GetModLocalization(96)

-----------------------
-- Baron Silverlaine --
-----------------------
L= DBM:GetModLocalization(97)

--------------------------
-- Commander Springvale --
--------------------------
L= DBM:GetModLocalization(98)

L:SetTimerLocalization({
	TimerAdds		= "下一次小怪"
})

L:SetOptionLocalization{
	TimerAdds		= "顯示下一次小怪的計時器"
}

L:SetMiscLocalization{
	YellAdds		= "趕走入侵者!"
}

-----------------
-- Lord Walden --
-----------------
L= DBM:GetModLocalization(99)

L:SetWarningLocalization{
	specWarnCoagulant	= "綠色混合 - 不斷移動!",
	specWarnRedMix		= "紅色混合 - 不要移動!"
}

L:SetOptionLocalization{
	RedLightGreenLight	= "為紅/綠色移動方式顯示特別警告"
}

------------------
-- Lord Godfrey --
------------------
L= DBM:GetModLocalization(100)

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L= DBM:GetModLocalization(110)

L:SetWarningLocalization({
	WarnEmerge	= "鑽出地面",
	WarnSubmerge	= "鑽進地裡"
})

L:SetTimerLocalization({
	TimerEmerge	= "下一次 鑽出地面",
	TimerSubmerge	= "下一次 鑽進地裡"
})

L:SetOptionLocalization({
	WarnEmerge	= "為鑽出地面顯示警告",
	WarnSubmerge	= "為鑽進地裡顯示警告",
	TimerEmerge	= "為鑽出地面顯示計時器",
	TimerSubmerge	= "為鑽進地裡顯示計時器",
	CrystalArrow	= "當你附近的人中了$spell:81634時顯示DBM箭頭",
	RangeFrame	= "顯示距離框 (5碼)"
})

--------------
-- Slabhide --
-------------- 
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	WarnAirphase			= "空中階段",
	WarnGroundphase			= "地上階段",
	specWarnCrystalStorm		= "水晶風暴 - 找掩護"
})

L:SetTimerLocalization({
	TimerAirphase			= "下一次空中階段",
	TimerGroundphase		= "下一次地上階段"
})

L:SetOptionLocalization({
	WarnAirphase			= "當岩革升空時顯示警告",
	WarnGroundphase			= "當岩革降落時顯示警告",
	TimerAirphase			= "為下一次空中階段顯示計時器",
	TimerGroundphase		= "為下一次地上階段顯示計時器",
	specWarnCrystalStorm		= "為$spell:92265顯示特別警告"
})

-----------
-- Ozruk --
----------- 
L= DBM:GetModLocalization(112)

-------------------------
-- High Priestess Azil --
------------------------
L= DBM:GetModLocalization(113)

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L= DBM:GetModLocalization(114)

L:SetMiscLocalization{
	Retract		= "%s收起了他的颶風之盾!"
}

--------------
-- Altairus --
-------------- 
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L= DBM:GetModLocalization(116)

L:SetOptionLocalization({
	SpecWarnStaticCling	= "顯示$spell:87618的特別警告"
})

L:SetWarningLocalization({
	SpecWarnStaticCling	= "跳!"
})

---------------------------
--  The Throne of Tides  --
---------------------------
-- Lady Naz'jar --
------------------ 
L= DBM:GetModLocalization(101)

-----======-----------
-- Commander Ulthok --
---------------------- 
L= DBM:GetModLocalization(102)

-------------------------
-- Erunak Stonespeaker --
-------------------------
L= DBM:GetModLocalization(103)

------------
-- Ozumat --
------------ 
L= DBM:GetModLocalization(104)

----------------
--  Zul'Aman  --
----------------
--  Akil'zon --
---------------
L= DBM:GetModLocalization(186)

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97300),
	RangeFrame	= "顯示距離框",
	StormArrow	= "為$spell:97300顯示BDM箭頭",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

---------------
--  Nalorakk --
---------------
L= DBM:GetModLocalization(187)

L:SetWarningLocalization{
	WarnBear		= "熊階段",
	WarnBearSoon		= "5秒後 熊階段",
	WarnNormal		= "普通階段",
	WarnNormalSoon		= "5秒後 普通階段"
}

L:SetTimerLocalization{
	TimerBear		= "熊階段",
	TimerNormal		= "普通階段"
}

L:SetOptionLocalization{
	WarnBear		= "為熊階段顯示警告",
	WarnBearSoon		= "為熊階段顯示預先警告",
	WarnNormal		= "為普通階段顯示警告",
	WarnNormalSoon		= "為熊階段顯示預先警告",
	TimerBear		= "為熊階段顯示計時器",
	TimerNormal		= "為普通階段顯示計時器",
	InfoFrame		= "顯示中了$spell:42402的玩家的訊息框"
}

L:SetMiscLocalization{
	YellBear 		= "你們既然將野獸召喚出來，就將付出更多的代價!",
	YellNormal		= "沒有人可以擋在納羅拉克的面前!",
	PlayerDebuffs	= "猛衝減益"
}

---------------
--  Jan'alai --
---------------
L= DBM:GetModLocalization(188)

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "燒死你們!",
	YellHatchAll	= "現在，讓我來告訴你們什麼叫數量優勢...",
	YellAdds	= "雌鷹哪裡去啦?快去孵蛋!"
}

--------------
--  Halazzi --
--------------
L= DBM:GetModLocalization(189)

L:SetWarningLocalization{
	WarnSpirit	= "靈魂階段",
	WarnNormal	= "普通階段"
}

L:SetOptionLocalization{
	WarnSpirit	= "為靈魂階段顯示警告",
	WarnNormal	= "為普通階段顯示警告"
}

L:SetMiscLocalization{
	YellSpirit	= "狂野的靈魂與我同在......",
	YellNormal	= "靈魂，回到我這裡來!"
}

-----------------------
-- Hexlord Malacrass --
-----------------------
L= DBM:GetModLocalization(190)

L:SetTimerLocalization{
	TimerSiphon	= "%s:%s"
}

L:SetOptionLocalization{
	TimerSiphon	= "顯示$spell:43501的計時器"
}

L:SetMiscLocalization{
	YellPull	= "陰影將會降臨在你們頭上..."
}

-------------
-- Daakara --
-------------
L= DBM:GetModLocalization(191)

L:SetTimerLocalization{
	timerNextForm	= "下一次型態變化"
}

L:SetOptionLocalization{
	timerNextForm	= "顯示型態變化的計時器",
	InfoFrame		= "顯示中了$spell:42402的玩家的訊息框",
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639),
	ClawRageIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97672)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "猛衝減益"
}

-----------------
--  Zul'Gurub  --
-----------------
-- High Priest Venoxis --
-------------------------
L= DBM:GetModLocalization(175)

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow		= "當你中了$spell:96477顯顯示DBM箭頭"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L= DBM:GetModLocalization(176)

L:SetWarningLocalization{
	WarnRevive		= "剩餘%d鬼魂",
	SpecWarnOhgan		= "奧根蘇醒了!攻擊!"
}

L:SetOptionLocalization{
	WarnRevive		= "提示剩餘多少鬼魂",
	SpecWarnOhgan	= "當奧根蘇醒時顯示警告",
	SetIconOnOhgan	= "當奧根蘇醒時標記它"
}

----------------------
-- Cache of Madness --
----------------------
-------------
-- Gri'lek --
-------------
L= DBM:GetModLocalization(177)

---------------
-- Hazza'rah --
---------------
L= DBM:GetModLocalization(178)

--------------
-- Renataki --
--------------
L= DBM:GetModLocalization(179)

---------------
-- Wushoolay --
---------------
L= DBM:GetModLocalization(180)

----------------------------
-- High Priestess Kilnara --
----------------------------
L= DBM:GetModLocalization(181)

------------
-- Zanzil --
------------
L= DBM:GetModLocalization(184)

L:SetWarningLocalization{
	SpecWarnToxic	= "喝下毒物折磨大鍋!!"
}

L:SetOptionLocalization{
	SpecWarnToxic	= "為當你沒有$spell:96328顯示特別警告",
	InfoFrame		= "為沒有$spell:96328的玩家顯示訊息框",
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "無毒物折磨"
}

----------------------------
-- Jindo --
----------------------------
L= DBM:GetModLocalization(185)

L:SetWarningLocalization{
	WarnBarrierDown	= "哈卡之鏈的薄霧障壁破壞 - 剩餘%d/3"
}

L:SetOptionLocalization{
	WarnBarrierDown	= "提示當哈卡之鏈的薄霧障壁被破壞",
	BodySlamIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97198)
}

L:SetMiscLocalization{
	Kill			= "你跨越了你的分際，金度。你觸碰了遠超越你的力量。你忘了我是誰嗎?你忘了我的能耐了嗎?"
}

----------------
--  End Time  --
-------------------
-- Echo of Baine --
-------------------
L= DBM:GetModLocalization(340)

-------------------
-- Echo of Jaina --
-------------------
L= DBM:GetModLocalization(285)

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "光核爆炸"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "為$spell:101927顯示計時器"
}

----------------------
-- Echo of Sylvanas --
----------------------
L= DBM:GetModLocalization(323)

---------------------
-- Echo of Tyrande --
---------------------
L= DBM:GetModLocalization(283)

--------------
-- Murozond --
--------------
L= DBM:GetModLocalization(289)

L:SetMiscLocalization{
	Kill		= "你們不知道自己做了什麼。阿曼蘇爾...我所...見到的..."
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L= DBM:GetModLocalization(290)

L:SetMiscLocalization{
	Pull		= "沒有凡人能在我眼前活下來!"
}

-------------
-- Azshara --
-------------
L= DBM:GetModLocalization(291)

L:SetWarningLocalization{
	WarnAdds	= "新的魔導師!"
}

L:SetTimerLocalization{
	TimerAdds	= "下一次魔導師"
}

L:SetOptionLocalization{
	WarnAdds	= "為下一次魔導師發佈警告",
	TimerAdds	= "為下一次魔導師顯示計時器"
}

L:SetMiscLocalization{
	Kill		= "夠了。我雖然想當稱職的女主人，但是我還有其他事情要忙。"
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L= DBM:GetModLocalization(292)

L:SetTimerLocalization{
	TimerTyrandeHelp	= "泰蘭妲需要幫助"
}

L:SetOptionLocalization{
	TimerTyrandeHelp	= "為泰蘭妲需要幫助之前顯示計時器"
}

L:SetMiscLocalization{
	Kill		= "瑪法里恩，他做到了!傳送門在崩塌了!"
}

------------------------
--  Hour of Twilight  --
------------------------
-- Arcurion --
--------------
L= DBM:GetModLocalization(322)

L:SetTimerLocalization{
	TimerCombatStart	= "戰鬥開始"
}

L:SetOptionLocalization{
	TimerCombatStart	= "為戰鬥開始顯示計時器"
}

L:SetMiscLocalization{
	Event		= "現身吧!",
	Pull		= "暮光的軍隊開始出現在峽谷邊緣。"
}

----------------------
-- Asira Dawnslayer --
----------------------
L= DBM:GetModLocalization(342)

L:SetMiscLocalization{
	Pull		= "...搞定了那傢伙，現在輪到你和你這群笨拙的朋友了。嗯，我還以為你們到不了這裡呢!"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L= DBM:GetModLocalization(341)

L:SetTimerLocalization{
	TimerCombatStart	= "戰鬥開始"
}

L:SetOptionLocalization{
	TimerCombatStart	= "為戰鬥開始顯示計時器"
}

L:SetMiscLocalization{
	Event		= "現在呢，薩滿，把巨龍之魂交給我吧。"
}

--------------------
--  World Bosses  --
-------------------------
-- Akma'hat --
-------------------------
L = DBM:GetModLocalization("Akmahat")

L:SetGeneralLocalization{
	name = "阿克瑪哈特"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "加爾(浩劫與重生)"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "毀滅祖拉克"
}

L:SetOptionLocalization{
	SetIconOnMC	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(93621)
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "莫比斯"
}

-----------
-- Xariona --
-----------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "克薩瑞歐納"
}
