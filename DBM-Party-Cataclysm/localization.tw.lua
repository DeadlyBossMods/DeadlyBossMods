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
	WarnAdd		= "當一隻小怪丟棄$spell:75608增益時警告"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L = DBM:GetModLocalization("KarshSteelbender")

L:SetGeneralLocalization({
	name = "卡爾許·控鋼者"
})

L:SetTimerLocalization({
	TimerSuperheated 	= "極灸水銀護甲 (%d)"	-- should work, no need for translation :)
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
	SetIconOnBoss	= "$spell:76200後標記首領"
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
	ValionaYell	= "龍啊，聽我命令! 抓住我!",	-- translate -- Yell when Valiona is incoming
	Valiona		= "瓦莉歐娜"	-- translate
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

------------
-- Isiset --
------------
L = DBM:GetModLocalization("Isiset")

L:SetGeneralLocalization({
	name = "伊希賽特"
})

L:SetWarningLocalization({
	WarnSplitSoon	= "分裂 即將到來"
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

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "高階預言者巴瑞姆"
})

L:SetOptionLocalization{
	BossHealthAdds	= "在首領血量框架顯示小怪血量"	-- translate
}

L:SetMiscLocalization{
	BlazeHeavens		= "天之燃炎",	-- translate
	HarbringerDarkness	= "黑暗先驅者"	-- translate
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "鎖喉"
})

L:SetOptionLocalization{
	RangeFrame	= "顯示距離框 (5碼)"		-- translate
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "奧各"		-- translate
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

-----------------
-- Lord Walden --
-----------------
L = DBM:GetModLocalization("Walden")

L:SetGeneralLocalization({
	name = "瓦爾登領主"
})

L:SetWarningLocalization{
	specWarnCoagulant	= "綠色混合 - 不斷移動!",	-- Green light
	specWarnRedMix		= "紅色混合 - 不要移動!"		-- Red light
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

L:SetWarningLocalization({
	WarnEmerge	= "鑽出地面",
	WarnSubmerge	= "鑽進地裡"
})

L:SetTimerLocalization({
	TimerEmerge	= "鑽出地面",
	TimerSubmerge	= "鑽進地裡"
})

L:SetOptionLocalization({
	WarnEmerge	= "為鑽出地面顯示警告",
	WarnSubmerge	= "為鑽進地裡顯示警告",
	TimerEmerge	= "為鑽出地面顯示計時器",
	TimerSubmerge	= "為鑽進地裡顯示計時器"
})

L:SetGeneralLocalization({
	name = "寇伯拉斯"
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
	specWarnCrystalStorm		= "水晶風暴 - 找掩護"
})

L:SetOptionLocalization({
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

--------------
-- Altairus --
-------------- 
L = DBM:GetModLocalization("Altairus")

L:SetGeneralLocalization({
	name = "艾塔伊洛斯"
})

-----------
-- Asaad --
-----------
L = DBM:GetModLocalization("Asaad")

L:SetGeneralLocalization({
	name = "亞沙德"
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