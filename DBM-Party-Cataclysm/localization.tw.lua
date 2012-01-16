if GetLocale() ~= "zhTW" then return end
local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L = DBM:GetModLocalization("Romogg")

L:SetGeneralLocalization({
	name = "羅姆歐格·裂骨者"
})

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L = DBM:GetModLocalization("Corla")

L:SetGeneralLocalization({
	name = "柯爾菈，暮光信使"
})

L:SetWarningLocalization({
	WarnAdd		= "小怪被釋放了"
})

L:SetOptionLocalization({
	WarnAdd		= "當一隻小怪的$spell:75608消散時警告"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L = DBM:GetModLocalization("KarshSteelbender")

L:SetGeneralLocalization({
	name = "卡爾許·控鋼者"
})

L:SetTimerLocalization({
	TimerSuperheated 	= "極灸水銀護甲(%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "為$spell:75846顯示持續時間計時器"
})

------------
-- Beauty --
------------
L = DBM:GetModLocalization("Beauty")

L:SetGeneralLocalization({
	name = "美麗"
})

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L = DBM:GetModLocalization("AscendantLordObsidius")

L:SetGeneralLocalization({
	name = "卓越者領主奧希迪厄斯"
})

L:SetOptionLocalization({
	SetIconOnBoss	= "首領施放$spell:76200後標記首領"
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L = DBM:GetModLocalization("Glubtok")

L:SetGeneralLocalization({
	name = "格魯巴托克"
})

-----------------------
-- Helix Gearbreaker --
-----------------------
L = DBM:GetModLocalization("Helix")

L:SetGeneralLocalization({
	name = "赫利克斯•碎輪者"
})

---------------------
-- Foe Reaper 5000 --
---------------------
L = DBM:GetModLocalization("FoeReaper")

L:SetGeneralLocalization({
	name = "敵人收割者5000"
})

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L = DBM:GetModLocalization("Ripsnarl")

L:SetGeneralLocalization({
	name = "利普斯納爾上將"
})

----------------------
-- "Captain" Cookie --
----------------------
L = DBM:GetModLocalization("Cookie")

L:SetGeneralLocalization({
	name = "『隊長』餅乾"
})

----------------------
-- Vanessa VanCleef --
----------------------
L = DBM:GetModLocalization("Vanessa")

L:SetGeneralLocalization({
	name = "凡妮莎·范克里夫"
})

L:SetTimerLocalization({
	achievementGauntlet	= "充滿活力"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L = DBM:GetModLocalization("GeneralUmbriss")

L:SetGeneralLocalization({
	name = "昂布里斯將軍"
})

L:SetOptionLocalization{
	PingBlitz	= "當昂布里斯將軍即將閃擊你時點擊小地圖"
}

L:SetMiscLocalization{
	Blitz		= "將目光注射|cFFFF0000(%S+)"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L = DBM:GetModLocalization("ForgemasterThrongus")

L:SetGeneralLocalization({
	name = "鍛造大師瑟隆葛斯"
})

-------------------------
-- Drahga Shadowburner --
-------------------------
L = DBM:GetModLocalization("DrahgaShadowburner")

L:SetGeneralLocalization({
	name = "德拉卡·燃影者"
})

L:SetMiscLocalization{
	ValionaYell	= "龍啊，聽我命令! 抓住我!",
	Add		= "%s進行",
	Valiona		= "瓦莉歐娜"
}

------------
-- Erudax --
------------
L = DBM:GetModLocalization("Erudax")

L:SetGeneralLocalization({
	name = "伊魯達克斯"
})

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L = DBM:GetModLocalization("TempleGuardianAnhuur")

L:SetGeneralLocalization({
	name = "神殿守護者安胡爾"
})

---------------------
-- Earthrager Ptah --
---------------------
L = DBM:GetModLocalization("EarthragerPtah")

L:SetGeneralLocalization({
	name = "地怒者普塔"
})

L:SetMiscLocalization{
	Kill		= "普塔...不再...存在..."
}

--------------
-- Anraphet --
--------------
L = DBM:GetModLocalization("Anraphet")

L:SetGeneralLocalization({
	name = "安拉斐特"
})

L:SetTimerLocalization({
	achievementGauntlet	= "成就挑戰"
})

L:SetMiscLocalization({
	Brann				= "好了，快走吧!只需要把最後的登錄程序輸入到門的機關中....然後..."
})

------------
-- Isiset --
------------
L = DBM:GetModLocalization("Isiset")

L:SetGeneralLocalization({
	name = "伊希賽特"
})

L:SetWarningLocalization({
	WarnSplitSoon	= "即將分裂"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "為分裂顯示預先警告"
})

-------------
-- Ammunae --
------------- 
L = DBM:GetModLocalization("Ammunae")

L:SetGeneralLocalization({
	name = "安姆內"
})

-------------
-- Setesh  --
------------- 
L = DBM:GetModLocalization("Setesh")

L:SetGeneralLocalization({
	name = "賽特胥"
})

----------
-- Rajh --
----------
L = DBM:GetModLocalization("Rajh")

L:SetGeneralLocalization({
	name = "拉頡"
})

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L = DBM:GetModLocalization("GeneralHusam")

L:SetGeneralLocalization({
	name = "胡薩姆將軍"
})

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L = DBM:GetModLocalization("Siamat")

L:SetGeneralLocalization({
	name = "希亞梅特"		-- "Siamat, Lord of the South Wind" --> Real name is too long :((
})

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

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "高階預言者巴瑞姆"
})

L:SetOptionLocalization{
	BossHealthAdds	= "在首領血量框架顯示小怪血量"
}

L:SetMiscLocalization{
	BlazeHeavens		= "天之燃炎",
	HarbringerDarkness	= "黑暗先驅者"
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "鎖喉"
})

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

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L = DBM:GetModLocalization("Ashbury")

L:SetGeneralLocalization({
	name = "艾胥柏利男爵"
})

-----------------------
-- Baron Silverlaine --
-----------------------
L = DBM:GetModLocalization("Silverlaine")

L:SetGeneralLocalization({
	name = "席瓦萊恩男爵"
})

--------------------------
-- Commander Springvale --
--------------------------
L = DBM:GetModLocalization("Springvale")

L:SetGeneralLocalization({
	name = "指揮官斯普林瓦爾"
})

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
L = DBM:GetModLocalization("Walden")

L:SetGeneralLocalization({
	name = "瓦爾登領主"
})

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
L = DBM:GetModLocalization("Godfrey")

L:SetGeneralLocalization({
	name = "高佛雷領主"
})

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L = DBM:GetModLocalization("Corborus")

L:SetGeneralLocalization({
	name = "寇伯拉斯"
})

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

-----------
-- Ozruk --
----------- 
L = DBM:GetModLocalization("Ozruk")

L:SetGeneralLocalization({
	name = "歐茲魯克"
})

--------------
-- Slabhide --
-------------- 
L = DBM:GetModLocalization("Slabhide")

L:SetGeneralLocalization({
	name = "岩革"
})

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

-------------------------
-- High Priestess Azil --
------------------------
L = DBM:GetModLocalization("HighPriestessAzil")

L:SetGeneralLocalization({
	name = "高階祭司艾吉兒"
})

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L = DBM:GetModLocalization("GrandVizierErtan")

L:SetGeneralLocalization({
	name = "首相伊爾丹"
})

L:SetMiscLocalization{
	Retract		= "%s收起了他的颶風之盾!"
}

--------------
-- Altairus --
-------------- 
L = DBM:GetModLocalization("Altairus")

L:SetGeneralLocalization({
	name = "艾塔伊洛斯"
})

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L = DBM:GetModLocalization("Asaad")

L:SetGeneralLocalization({
	name = "亞沙德"
})

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
L = DBM:GetModLocalization("LadyNazjar")

L:SetGeneralLocalization({
	name = "納茲賈爾女士"
})

-----======-----------
-- Commander Ulthok --
---------------------- 
L = DBM:GetModLocalization("CommanderUlthok")

L:SetGeneralLocalization({
	name = "指揮官烏索克"
})

-------------------------
-- Erunak Stonespeaker --
-------------------------
L = DBM:GetModLocalization("ErunakStonespeaker")

L:SetGeneralLocalization({
	name = "伊魯納克·石語者"
})

------------
-- Ozumat --
------------ 
L = DBM:GetModLocalization("Ozumat")

L:SetGeneralLocalization({
	name = "歐蘇瑪特"
})

----------------
--  Zul'Aman  --
---------------
-- Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk5")

L:SetGeneralLocalization{
	name = "納羅拉克"
}

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
-- Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon5")

L:SetGeneralLocalization{
	name = "阿奇爾森"
}

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97300),
	RangeFrame	= "顯示距離框",
	StormArrow	= "為$spell:97300顯示BDM箭頭",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

---------------
-- Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai5")

L:SetGeneralLocalization{
	name = "賈納雷"
}

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "燒死你們!",
	YellHatchAll	= "現在，讓我來告訴你們什麼叫數量優勢...",
	YellAdds	= "雌鷹哪裡去啦?快去孵蛋!"
}

--------------
-- Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi5")

L:SetGeneralLocalization{
	name = "哈拉齊"
}

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

--------------------------
-- Hexlord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass5")

L:SetGeneralLocalization{
	name = "妖術領主瑪拉克雷斯"
}

L:SetTimerLocalization{
	TimerSiphon	= "%s:%s"
}

L:SetOptionLocalization{
	TimerSiphon	= "顯示$spell:43501的計時器"
}

L:SetMiscLocalization{
	YellPull	= "陰影將會降臨在你們頭上..."
}

--------------
-- Daakara --
--------------
L = DBM:GetModLocalization("Daakara")

L:SetGeneralLocalization{
	name = "達卡拉"
}

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
-------------------------
-- High Priest Venoxis --
-------------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "高階祭司溫諾希斯"
}

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow		= "當你中了$spell:96477顯顯示DBM箭頭"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L = DBM:GetModLocalization("Mandokir")

L:SetGeneralLocalization{
	name = "血領主曼多基爾"
}

L:SetWarningLocalization{
	WarnRevive		= "剩餘%d鬼魂",
	SpecWarnOhgan		= "奧根蘇醒了!攻擊!"
}

L:SetOptionLocalization{
	WarnRevive		= "提示剩餘多少鬼魂",
	SpecWarnOhgan	= "當奧根蘇醒時顯示警告",
	SetIconOnOhgan	= "當奧根蘇醒時標記它"
}

L:SetMiscLocalization{
	Ohgan		= "奧根"
}

------------
-- Zanzil --
------------
L = DBM:GetModLocalization("Zanzil")

L:SetGeneralLocalization{
	name = "贊吉爾"
}

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
-- High Priestess Kilnara --
----------------------------
L = DBM:GetModLocalization("Kilnara")

L:SetGeneralLocalization{
	name = "高階祭司基爾娜拉"
}

----------------------------
-- Jindo --
----------------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "破神者金度"
}

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

----------------------
-- Cache of Madness --
----------------------
-------------
-- Gri'lek --
-------------
--L= DBM:GetModLocalization(603)

L = DBM:GetModLocalization("CoMGrilek")

L:SetGeneralLocalization{
	name = "格里雷克"
}

L:SetMiscLocalization({
	pursuitEmote	= "在追著%s"
})

---------------
-- Hazza'rah --
---------------
--L= DBM:GetModLocalization(604)

L = DBM:GetModLocalization("CoMGHazzarah")

L:SetGeneralLocalization{
	name = "哈札拉爾"
}

--------------
-- Renataki --
--------------
--L= DBM:GetModLocalization(605)

L = DBM:GetModLocalization("CoMRenataki")

L:SetGeneralLocalization{
	name = "雷納塔基"
}

---------------
-- Wushoolay --
---------------
--L= DBM:GetModLocalization(606)

L = DBM:GetModLocalization("CoMWushoolay")

L:SetGeneralLocalization{
	name = "烏蘇雷"
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

----------------
--  End Time  --
----------------------
-- Echo of Sylvanas --
----------------------
L = DBM:GetModLocalization("EchoSylvanas")

L:SetGeneralLocalization{
	name = "希瓦娜斯的回音"
}

---------------------
-- Echo of Tyrande --
---------------------
L = DBM:GetModLocalization("EchoTyrande")

L:SetGeneralLocalization{
	name = "泰蘭妲的回音"
}

-------------------
-- Echo of Jaina --
-------------------
L = DBM:GetModLocalization("EchoJaina")

L:SetGeneralLocalization{
	name = "珍娜的回音"
}

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "光核爆炸"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "為$spell:101927顯示計時器"
}

----------------------
-- Echo of Baine --
----------------------
L = DBM:GetModLocalization("EchoBaine")

L:SetGeneralLocalization{
	name = "貝恩的回音"
}

--------------
-- Murozond --
--------------
L = DBM:GetModLocalization("Murozond")

L:SetGeneralLocalization{
	name = "姆多茲諾"
}

L:SetMiscLocalization{
	Kill		= "你們不知道自己做了什麼。阿曼蘇爾...我所...見到的..."
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L = DBM:GetModLocalization("Perotharn")

L:SetGeneralLocalization{
	name = "佩洛薩恩"

}

L:SetMiscLocalization{
	Pull		= "沒有凡人能在我眼前活下來!"
}


-------------
-- Azshara --
-------------
L = DBM:GetModLocalization("Azshara")

L:SetGeneralLocalization{
	name = "艾薩拉女王"
}

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
L = DBM:GetModLocalization("Mannoroth")

L:SetGeneralLocalization{
	name = "瑪諾洛斯 & 瓦羅森隊長"
}

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
L = DBM:GetModLocalization("Arcurion")

L:SetGeneralLocalization{
	name = "阿奇里森"
}

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
L = DBM:GetModLocalization("AsiraDawnslayer")

L:SetGeneralLocalization{
	name = "阿希拉黎明殺戮者"
}

L:SetMiscLocalization{
	Pull		= "...搞定了那傢伙，現在輪到你和你這群笨拙的朋友了。嗯，我還以為你們到不了這裡呢!"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L = DBM:GetModLocalization("Benedictus")

L:SetGeneralLocalization{
	name = "大主教本尼迪塔斯"
}

L:SetTimerLocalization{
	TimerCombatStart	= "戰鬥開始"
}

L:SetOptionLocalization{
	TimerCombatStart	= "為戰鬥開始顯示計時器"
}

L:SetMiscLocalization{
	Event		= "現在呢，薩滿，把巨龍之魂交給我吧。"
}
