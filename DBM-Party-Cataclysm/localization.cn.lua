-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 12/26/2011

if GetLocale() ~= "zhCN" then return end

local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L = DBM:GetModLocalization("Romogg")

L:SetGeneralLocalization({
	name = "碎骨者罗姆欧格"
})

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L = DBM:GetModLocalization("Corla")

L:SetGeneralLocalization({
	name = "柯尔拉，暮光之兆"
})

L:SetWarningLocalization({
	WarnAdd		= "小怪出现"
})

L:SetOptionLocalization({
	WarnAdd		= "警报：当某个小怪失去$spell:75608效果"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L = DBM:GetModLocalization("KarshSteelbender")

L:SetGeneralLocalization({
	name = "卡尔什·断钢"
})

L:SetTimerLocalization({
	TimerSuperheated 	= "过热护甲（%d）"
})

L:SetOptionLocalization({
	TimerSuperheated	= "计时条：$spell:75846的持续时间"
})

------------
-- Beauty --
------------
L = DBM:GetModLocalization("Beauty")

L:SetGeneralLocalization({
	name = "如花"
})

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L = DBM:GetModLocalization("AscendantLordObsidius")

L:SetGeneralLocalization({
	name = "升腾者领主奥西迪斯"
})

L:SetOptionLocalization({
	SetIconOnBoss	= "在$spell:76200之后自动为首领添加标记"
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L = DBM:GetModLocalization("Glubtok")

L:SetGeneralLocalization({
	name = "格拉布托克"
})

-----------------------
-- Helix Gearbreaker --
-----------------------
L = DBM:GetModLocalization("Helix")

L:SetGeneralLocalization({
	name = "赫利克斯·破甲"
})

---------------------
-- Foe Reaper 5000 --
---------------------
L = DBM:GetModLocalization("FoeReaper")

L:SetGeneralLocalization({
	name = "死神5000"
})

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L = DBM:GetModLocalization("Ripsnarl")

L:SetGeneralLocalization({
	name = "撕心狼将军"
})

----------------------
-- "Captain" Cookie --
----------------------
L = DBM:GetModLocalization("Cookie")

L:SetGeneralLocalization({
	name = "“船长”曲奇"
})

----------------------
-- Vanessa VanCleef --
----------------------
L = DBM:GetModLocalization("Vanessa")

L:SetGeneralLocalization({
	name = "梵妮莎·范克里夫"
})

L:SetTimerLocalization({
	achievementGauntlet	= "限时挑战"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L = DBM:GetModLocalization("GeneralUmbriss")

L:SetGeneralLocalization({
	name 		= "乌比斯将军"
})

L:SetOptionLocalization{
	PingBlitz	= "当乌比斯将军准备对你迅猛突袭时自动点击小地图"
}

L:SetMiscLocalization{
	Blitz		= "盯住了|cFFFF0000(%S+)"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L = DBM:GetModLocalization("ForgemasterThrongus")

L:SetGeneralLocalization({
	name = "铸炉之主索乌格斯"
})

-------------------------
-- Drahga Shadowburner --
-------------------------
L = DBM:GetModLocalization("DrahgaShadowburner")

L:SetGeneralLocalization({
	name = "达加·燃影者"
})

L:SetMiscLocalization{
	ValionaYell	= "巨龙，听从我的命令！接住我！",	-- Yell when Valiona is incoming
	Add			= "%s开始施放",
	Valiona		= "瓦里昂娜"
}

------------
-- Erudax --
------------
L = DBM:GetModLocalization("Erudax")

L:SetGeneralLocalization({
	name = "埃鲁达克"
})

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L = DBM:GetModLocalization("TempleGuardianAnhuur")

L:SetGeneralLocalization({
	name = "神殿守护者安努尔"
})

---------------------
-- Earthrager Ptah --
---------------------
L = DBM:GetModLocalization("EarthragerPtah")

L:SetGeneralLocalization({
	name = "地怒者塔赫"
})

L:SetMiscLocalization{
	Kill		= "塔赫……不复存在了……"
}

--------------
-- Anraphet --
--------------
L = DBM:GetModLocalization("Anraphet")

L:SetGeneralLocalization({
	name = "安拉斐特"
})

L:SetTimerLocalization({
	achievementGauntlet	= "限时挑战"
})

L:SetMiscLocalization({
	Brann				= "好啊，我们走！只需要在门禁系统中输入最终登录序列……然后……"
})

------------
-- Isiset --
------------
L = DBM:GetModLocalization("Isiset")

L:SetGeneralLocalization({
	name = "伊希斯特"
})

L:SetWarningLocalization({
	WarnSplitSoon	= "即将分裂"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "提前警报：分裂"
})

-------------
-- Ammunae --
------------- 
L = DBM:GetModLocalization("Ammunae")

L:SetGeneralLocalization({
	name = "阿穆纳伊"
})

-------------
-- Setesh  --
------------- 
L = DBM:GetModLocalization("Setesh")

L:SetGeneralLocalization({
	name = "塞特斯"
})

----------
-- Rajh --
----------
L = DBM:GetModLocalization("Rajh")

L:SetGeneralLocalization({
	name = "拉夏"
})

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L = DBM:GetModLocalization("GeneralHusam")

L:SetGeneralLocalization({
	name = "胡辛姆将军"
})

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L = DBM:GetModLocalization("Siamat")

L:SetGeneralLocalization({
	name = "希亚玛特"		-- "Siamat, Lord of the South Wind" --> Real name is too long :((
})

L:SetWarningLocalization{
	specWarnPhase2Soon	= "5秒后进入第2阶段"
}

L:SetTimerLocalization({
	timerPhase2 		= "第2阶段开始"
})

L:SetOptionLocalization{
	specWarnPhase2Soon	= "特殊警报：第2阶段即将开始（约5秒）",
	timerPhase2 		= "计时条：第2阶段即将开始"
}

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "高阶预言者巴林姆"
})

L:SetOptionLocalization{
	BossHealthAdds	= "在首领生命框体内显示小怪血量"
}

L:SetMiscLocalization{
	BlazeHeavens		= "天堂炽焰",
	HarbringerDarkness	= "黑暗先驱"
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "锁喉"
})

L:SetOptionLocalization{
	RangeFrame	= "距离监视器（5码）"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "奥弗"		-- he is fightable after Lockmaw :o
})

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L = DBM:GetModLocalization("Ashbury")

L:SetGeneralLocalization({
	name = "灰葬男爵"
})

-----------------------
-- Baron Silverlaine --
-----------------------
L = DBM:GetModLocalization("Silverlaine")

L:SetGeneralLocalization({
	name = "席瓦莱恩男爵"
})

--------------------------
-- Commander Springvale --
--------------------------
L = DBM:GetModLocalization("Springvale")

L:SetGeneralLocalization({
	name = "指挥官斯普林瓦尔"
})

L:SetTimerLocalization({
	TimerAdds		= "下一次小怪刷新"
})

L:SetOptionLocalization{
	TimerAdds		= "计时条：下一次小怪刷新"
}

L:SetMiscLocalization{
	YellAdds		= "击退入侵者！"
}

-----------------
-- Lord Walden --
-----------------
L = DBM:GetModLocalization("Walden")

L:SetGeneralLocalization({
	name = "瓦尔登勋爵"
})

L:SetWarningLocalization{
	specWarnCoagulant	= "绿色混合剂 - 持续移动！",	-- Green light
	specWarnRedMix		= "红色混合剂 - 不要移动！"		-- Red light
}

L:SetOptionLocalization{
	RedLightGreenLight	= "特殊警报：红色/绿色混合剂的移动要求"
}

------------------
-- Lord Godfrey --
------------------
L = DBM:GetModLocalization("Godfrey")

L:SetGeneralLocalization({
	name = "高弗雷勋爵"
})

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L = DBM:GetModLocalization("Corborus")

L:SetGeneralLocalization({
	name = "克伯鲁斯"
})

L:SetWarningLocalization({
	WarnEmerge		= "出现",
	WarnSubmerge	= "钻地"
})

L:SetTimerLocalization({
	TimerEmerge		= "下一次出现",
	TimerSubmerge	= "下一次钻地"
})

L:SetOptionLocalization({
	WarnEmerge		= "警报：出现",
	WarnSubmerge	= "警报：钻地",
	TimerEmerge		= "计时条：下一次出现",
	TimerSubmerge	= "计时条：下一次钻地",
	CrystalArrow	= "DBM箭头：当$spell:81634目标距你过近时",
	RangeFrame		= "距离监视器（5码）"
})

-----------
-- Ozruk --
----------- 
L = DBM:GetModLocalization("Ozruk")

L:SetGeneralLocalization({
	name = "欧泽鲁克"
})

--------------
-- Slabhide --
-------------- 
L = DBM:GetModLocalization("Slabhide")

L:SetGeneralLocalization({
	name = "岩皮"
})

L:SetWarningLocalization({
	WarnAirphase			= "空中阶段",
	WarnGroundphase			= "地面阶段",
	specWarnCrystalStorm	= "水晶风暴 - 寻找掩护"
})

L:SetTimerLocalization({
	TimerAirphase			= "下一次空中阶段",
	TimerGroundphase		= "下一次地面阶段"
})

L:SetOptionLocalization({
	WarnAirphase			= "警报：岩皮起飞",
	WarnGroundphase			= "警报：岩皮落地",
	TimerAirphase			= "计时条：下一次空中阶段",
	TimerGroundphase		= "计时条：下一次地面阶段",
	specWarnCrystalStorm	= "特殊警报：$spell:92265"
})

-------------------------
-- High Priestess Azil --
------------------------
L = DBM:GetModLocalization("HighPriestessAzil")

L:SetGeneralLocalization({
	name = "高阶女祭司艾苏尔"
})

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L = DBM:GetModLocalization("GrandVizierErtan")

L:SetGeneralLocalization({
	name = "大宰相埃尔坦喊道"
})

L:SetMiscLocalization{
	Retract		= "%s收回了他的旋风之盾！"
}

--------------
-- Altairus --
-------------- 
L = DBM:GetModLocalization("Altairus")

L:SetGeneralLocalization({
	name = "阿尔泰鲁斯"
})

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L = DBM:GetModLocalization("Asaad")

L:SetGeneralLocalization({
	name = "阿萨德"
})

L:SetOptionLocalization({
	SpecWarnStaticCling	= "特殊警报：$spell:87618"
})

L:SetWarningLocalization({
	SpecWarnStaticCling	= "跳！"
})

---------------------------
--  The Throne of Tides  --
---------------------------
-- Lady Naz'jar --
------------------ 
L = DBM:GetModLocalization("LadyNazjar")

L:SetGeneralLocalization({
	name = "纳兹夏尔女士"
})

-----======-----------
-- Commander Ulthok --
---------------------- 
L = DBM:GetModLocalization("CommanderUlthok")

L:SetGeneralLocalization({
	name = "指挥官乌尔索克"
})

-------------------------
-- Erunak Stonespeaker --
-------------------------
L = DBM:GetModLocalization("ErunakStonespeaker")

L:SetGeneralLocalization({
	name = "石语者埃鲁纳克"
})

------------
-- Ozumat --
------------ 
L = DBM:GetModLocalization("Ozumat")

L:SetGeneralLocalization({
	name = "厄祖玛特"
})

----------------
--  Zul'Aman  --
----------------
-- Nalorakk --
--------------
L = DBM:GetModLocalization("Nalorakk5")

L:SetGeneralLocalization{
	name = "纳洛拉克（野熊）"
}

L:SetWarningLocalization{
	WarnBear		= "熊形态",
	WarnBearSoon	= "5秒后熊形态",
	WarnNormal		= "人形态",
	WarnNormalSoon	= "5秒后人形态"
}

L:SetTimerLocalization{
	TimerBear		= "熊形态",
	TimerNormal		= "人形态"
}

L:SetOptionLocalization{
	WarnBear		= "警报：变为熊形态",
	WarnBearSoon	= "提前警报：变为熊形态",
	WarnNormal		= "警报：变为人形态",
	WarnNormalSoon	= "提前警报：变为人形态",
	TimerBear		= "计时条：熊形态",
	TimerNormal		= "计时条：人形态",
	InfoFrame		= "信息框：拥有$spell:42402效果的团员的列表"
}

L:SetMiscLocalization{
	YellBear 		= "你们召唤野兽？你马上就要大大的后悔了！",
	YellNormal		= "让我带给你们痛苦！",
	PlayerDebuffs	= "澎湃效果"
}

--------------
-- Akil'zon --
--------------
L = DBM:GetModLocalization("Akilzon5")

L:SetGeneralLocalization{
	name = "埃基尔松（雄鹰）"
}

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97300),
	RangeFrame	= "距离监视器（10码）",
	StormArrow	= "DBM箭头：$spell:97300",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

--------------
-- Jan'alai --
--------------
L = DBM:GetModLocalization("Janalai5")

L:SetGeneralLocalization{
	name = "加亚莱（龙鹰）"
}

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "烧死你们！",
	YellHatchAll= "现在，让我来告诉你们什么叫……数量优势。",
	YellAdds	= "孵化者呢？快去孵蛋！"
}

-------------
-- Halazzi --
-------------
L = DBM:GetModLocalization("Halazzi5")

L:SetGeneralLocalization{
	name = "哈尔拉兹（山猫）"
}

L:SetWarningLocalization{
	WarnSpirit	= "灵魂阶段",
	WarnNormal	= "普通阶段"
}

L:SetOptionLocalization{
	WarnSpirit	= "警报：灵魂阶段",
	WarnNormal	= "警报：普通阶段"
}

L:SetMiscLocalization{
	YellSpirit	= "狂野的灵魂与我同在……",
	YellNormal	= "灵魂，到我这里来！"
}

-----------------------
-- Hexlord Malacrass --
-----------------------
L = DBM:GetModLocalization("Malacrass5")

L:SetGeneralLocalization{
	name = "妖术领主玛拉卡斯"
}

L:SetTimerLocalization{
	TimerSiphon	= "%s：%s"
}

L:SetOptionLocalization{
	TimerSiphon	= "计时条：$spell:43501"
}

L:SetMiscLocalization{
	YellPull	= "阴影将会降临在你们头上……"
}

-------------
-- Daakara --
-------------
L = DBM:GetModLocalization("Daakara")

L:SetGeneralLocalization{
	name = "达卡拉"
}

L:SetTimerLocalization{
	timerNextForm	= "下一次变形"
}

L:SetOptionLocalization{
	timerNextForm	= "计时条：变形",
	InfoFrame		= "信息框：拥有$spell:42402效果的团员的列表",
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639),
	ClawRageIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97672)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "澎湃效果"
}

-----------------
--  Zul'Gurub  --
-------------------------
-- High Priest Venoxis --
-------------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "高阶祭司温诺西斯"
}

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow			= "DBM箭头：当你受到$spell:96477影响时"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L = DBM:GetModLocalization("Mandokir")

L:SetGeneralLocalization{
	name = "血领主曼多基尔"
}

L:SetWarningLocalization{
	WarnRevive		= "剩余%d个幽灵",
	SpecWarnOhgan	= "奥根复活了！" -- check this, i'm not good at English
}

L:SetOptionLocalization{
	WarnRevive		= "警报：幽灵剩余数量",
	SpecWarnOhgan	= "警报：奥根的复活", -- check this, i'm not good at English
	SetIconOnOhgan	= "当奥根复活时自动为其添加标记" 
}

L:SetMiscLocalization{
	Ohgan		= "奥根"
}

------------
-- Zanzil --
------------
L = DBM:GetModLocalization("Zanzil")

L:SetGeneralLocalization{
	name = "赞吉尔"
}

L:SetWarningLocalization{
	SpecWarnToxic	= "Get Toxic Torment"
}

L:SetOptionLocalization{
	SpecWarnToxic	= "特殊警报：当你缺少$spell:96328效果时",
	InfoFrame		= "信息框：没有$spell:96328效果的团员的列表",
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "没有剧毒折磨效果"
}

----------------------------
-- High Priestess Kilnara --
----------------------------
L = DBM:GetModLocalization("Kilnara")

L:SetGeneralLocalization{
	name = "高阶祭司基尔娜拉"
}

----------------------------
-- Jindo --
----------------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "碎神者金度"
}

L:SetWarningLocalization{
	WarnBarrierDown	= "哈卡之链壁垒被摧毁 - %d/3剩余"
}

L:SetOptionLocalization{
	WarnBarrierDown	= "警报：哈卡之链的壁垒被摧毁",
	BodySlamIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97198)
}

L:SetMiscLocalization{
	Kill			= "You overstepped your bounds, Jin'do. You toy with powers that are beyond you. Have you forgotten who I am? Have you forgotten what I can do?!"
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
	pursuitEmote	= "%s正在"
})

---------------
-- Hazza'rah --
---------------
--L= DBM:GetModLocalization(604)

L = DBM:GetModLocalization("CoMGHazzarah")

L:SetGeneralLocalization{
	name = "哈扎拉尔"
}

--------------
-- Renataki --
--------------
--L= DBM:GetModLocalization(605)

L = DBM:GetModLocalization("CoMRenataki")

L:SetGeneralLocalization{
	name = "雷纳塔基"
}

---------------
-- Wushoolay --
---------------
--L= DBM:GetModLocalization(606)

L = DBM:GetModLocalization("CoMWushoolay")

L:SetGeneralLocalization{
	name = "乌苏雷"
}

--------------------
--  World Bosses  --
-------------------------
-- Akma'hat --
-------------------------
L = DBM:GetModLocalization("Akmahat")

L:SetGeneralLocalization{
	name = "阿卡玛哈特"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "加尔（大地的裂变）"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "厄运尤拉克"
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "魔布斯"
}

-------------
-- Xariona --
-------------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "埃克萨妮奥娜"
}

----------------
--  End Time  --
----------------------
-- Echo of Sylvanas --
----------------------
L = DBM:GetModLocalization("EchoSylvanas")

L:SetGeneralLocalization{
	name = "希尔瓦娜斯的残影"
}

---------------------
-- Echo of Tyrande --
---------------------
L = DBM:GetModLocalization("EchoTyrande")

L:SetGeneralLocalization{
	name = "泰兰德的残影"
}

-------------------
-- Echo of Jaina --
-------------------
L = DBM:GetModLocalization("EchoJaina")

L:SetGeneralLocalization{
	name = "吉安娜的残影"
}

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "炙焰之核"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "计时条：$spell:101927引爆"
}

L:SetMiscLocalization{
}

----------------------
-- Echo of Baine --
----------------------
L = DBM:GetModLocalization("EchoBaine")

L:SetGeneralLocalization{
	name = "贝恩的残影"
}

--------------
-- Murozond --
--------------
L = DBM:GetModLocalization("Murozond")

L:SetGeneralLocalization{
	name = "姆诺兹多"
}

L:SetMiscLocalization{
	Kill		= "你根本不明白你究竟干了什么。阿曼苏尔……我……看到……的……"
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L = DBM:GetModLocalization("Perotharn")

L:SetGeneralLocalization{
	name = "佩罗萨恩"
}

L:SetMiscLocalization{
	Pull		= "没有凡人能从我手中逃脱！"
}


-------------
-- Azshara --
-------------
L = DBM:GetModLocalization("Azshara")

L:SetGeneralLocalization{
	name = "艾萨拉女王"
}

L:SetWarningLocalization{
	WarnAdds	= "新的小怪即将出现"
}

L:SetTimerLocalization{
	TimerAdds	= "下一批小怪"
}

L:SetOptionLocalization{
	WarnAdds	= "警报：新的小怪出现",
	TimerAdds	= "计时条：下一批小怪"
}

L:SetMiscLocalization{
	Kill		= "够了！我虽然好客，但现在必须要去处理更重要的事情了。"
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L = DBM:GetModLocalization("Mannoroth")

L:SetGeneralLocalization{
	name = "玛诺洛斯与瓦罗森"
}

L:SetTimerLocalization{
	TimerTyrandeHelp	= "泰兰德需要帮助"
}

L:SetOptionLocalization{
	TimerTyrandeHelp	= "计时条：泰兰德需要帮助"
}

L:SetMiscLocalization{
	Kill		= "玛法里奥，他成功了！传送门崩溃了！"
}

------------------------
--  Hour of Twilight  --
------------------------
-- Arcurion --
--------------
L = DBM:GetModLocalization("Arcurion")

L:SetGeneralLocalization{
	name = "阿奎里恩"
}

L:SetTimerLocalization{
	TimerCombatStart	= "战斗即将开始"
}

L:SetOptionLocalization{
	TimerCombatStart	= "计时条：战斗即将开始"
}

L:SetMiscLocalization{
	Event		= "现身吧！",
	Pull		= "你不过是个凡人。现在，像个凡人那样卑微地死去吧。"
	--Pull		= "Twilight forces begin to appear around the canyons edges."
}

----------------------
-- Asira Dawnslayer --
----------------------
L = DBM:GetModLocalization("AsiraDawnslayer")

L:SetGeneralLocalization{
	name = "埃希拉·黎明克星"
}

L:SetMiscLocalization{
	Pull		= "该干正事了，对吧？"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L = DBM:GetModLocalization("Benedictus")

L:SetGeneralLocalization{
	name = "大主教本尼迪塔斯"
}

L:SetTimerLocalization{
	TimerCombatStart	= "战斗即将开始"
}

L:SetOptionLocalization{
	TimerCombatStart	= "计时条：战斗即将开始"
}

L:SetMiscLocalization{
	Event		= " 萨满，你会把巨龙之魂交给我。"
}