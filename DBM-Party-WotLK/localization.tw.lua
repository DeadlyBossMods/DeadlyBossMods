if GetLocale() ~= "zhTW" then return end

local L

local spell		= "%s"				
local debuff		= "%s: >%s<"			
local spellCD		= "%s 冷卻"
local spellSoon		= "%s 即將到來"
local optionWarning	= "為\"%s\"顯示警告"
local optionPreWarning	= "為\"%s\"顯示預先警告"
local optionSpecWarning	= "為\"%s\"顯示特別警告"
local optionTimerCD	= "為\"%s\"顯示冷卻計時器"
local optionTimerDur	= "為\"%s\"顯示持續時間計時器"
local optionTimerCast	= "為\"%s\"顯示施法計時器"


--------------------------------
-- AhnKahet: The Old Kingdom --
--------------------------------
-- Prince Taldaram --
---------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "泰爾達朗王子"
})

L:SetWarningLocalization({
	WarningFlame		= spell,
	WarningEmbrace		= debuff
})

L:SetTimerLocalization({
	TimerEmbrace		= debuff,
	TimerFlameCD		= spellCD
})

L:SetOptionLocalization({
	WarningFlame		= optionWarning:format(GetSpellInfo(55931)),
	WarningEmbrace		= optionWarning:format(GetSpellInfo(55959)),
	TimerEmbrace		= optionTimerDur:format(GetSpellInfo(55959)),
	TimerFlameCD		= optionTimerCD:format(GetSpellInfo(55931))
})


-----------------
-- Elder Nadox --
-----------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "老那杜斯"
})

L:SetWarningLocalization({
	WarningPlague	= debuff
})

L:SetTimerLocalization({
	TimerPlague	= debuff
})

L:SetOptionLocalization({
	WarningPlague	= optionWarning:format(GetSpellInfo(56130)),
	TimerPlague	= optionTimerDur:format(GetSpellInfo(56130))
})


-------------------------
-- Jedoga Shadowseeker --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "潔杜佳·尋影者"
})

L:SetWarningLocalization({
	WarningThundershock	= spell,
	WarningCycloneStrike	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningThundershock	= optionWarning:format(GetSpellInfo(56926)),
	WarningCycloneStrike	= optionWarning:format(GetSpellInfo(60030))
})


-------------------
-- Herald Volazj --
-------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "信使沃菈齊"
})

L:SetWarningLocalization({
	WarningInsanity	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningInsanity	= optionWarning:format(GetSpellInfo(57496))
})


--------------
-- Amanitar --
--------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "毒蕈魔"
})

L:SetWarningLocalization({
	WarningMini	= spell
})

L:SetTimerLocalization({
	TimerMiniCD	= spellCD
})

L:SetOptionLocalization({
	WarningMini	= optionWarning:format(GetSpellInfo(57055)),
	TimerMiniCD	= optionTimerCD:format(GetSpellInfo(57055))
})


-----------------
-- Azjol-Nerub --
-------------------------------
-- Krik'thir the Gatewatcher --
-------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "『守門者』齊力克西爾"
})

L:SetWarningLocalization({
	WarningCurse	= spell
})

L:SetTimerLocalization({
	TimerCurseCD	= spellCD
})

L:SetOptionLocalization({
	WarningCurse 	= optionWarning:format(GetSpellInfo(52592)),
	TimerCurseCD	= optionTimerCD:format(GetSpellInfo(52592))
})


--------------
-- Hadronox --
--------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "哈卓諾克斯"
})

L:SetWarningLocalization({
	WarningLeech	= spell,
	WarningCloud	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningLeech	= optionWarning:format(GetSpellInfo(53030)),
	WarningCloud	= optionWarning:format(GetSpellInfo(53400))
})


---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "阿努 巴拉克" --change for aviod bug
})

L:SetWarningLocalization({
	WarningPound	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPound	= optionWarning:format(GetSpellInfo(53472)),
})


--------------------------------------
-- Caverns of Time - Old Stratholme --
--------------------------------------
-- Meathook --
--------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "肉鉤"
})

L:SetWarningLocalization({
	WarningChains	= debuff
})

L:SetTimerLocalization({
	TimerChains	= debuff,
	TimerChainsCD	= spellCD
})

L:SetOptionLocalization({
	WarningChains	= optionWarning:format(GetSpellInfo(52696)),
	TimerChains	= optionTimerDur:format(GetSpellInfo(52696)),
	TimerChainsCD	= optionTimerCD:format(GetSpellInfo(52696))
})


------------------------------
-- Salramm the Fleshcrafter --
------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "『血肉工匠』塞歐朗姆"
})

L:SetWarningLocalization({
	WarningCurse	= debuff,
	WarningSteal	= debuff,
	WarningGhoul	= spell
})

L:SetTimerLocalization({
	TimerGhoulCD	= spellCD,
	TimerCurse	= debuff
})

L:SetOptionLocalization({
	WarningCurse	= optionWarning:format(GetSpellInfo(58845)),
	WarningSteal	= optionWarning:format(GetSpellInfo(52709)),
	WarningGhoul	= optionWarning:format(GetSpellInfo(52451)),
	TimerGhoulCD	= optionTimerCD:format(GetSpellInfo(52451)),
	TimerCurse	= optionTimerDur:format(GetSpellInfo(58845))
})


-----------------------
-- Chrono-Lord Epoch --
-----------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "紀元時間領主"
})

L:SetWarningLocalization({
	WarningTime	= spell,
	WarningCurse	= debuff
})

L:SetTimerLocalization({
	TimerTimeCD	= spellCD,
	TimerCurse	= debuff
})

L:SetOptionLocalization({
	WarningTime	= optionWarning:format("時間停止/扭曲"),
	WarningCurse	= optionWarning:format(GetSpellInfo(52772)),
	TimerTimeCD	= optionTimerCD:format("時間停止/扭曲"),
	TimerCurse	= optionTimerDur:format(GetSpellInfo(52772))
})


---------------
-- Mal'Ganis --
---------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "瑪爾加尼斯"
})

L:SetWarningLocalization({
	WarningSleep	= debuff
})

L:SetTimerLocalization({
	TimerSleep	= debuff,
	TimerSleepCD	= spellCD
})

L:SetOptionLocalization({
	WarningSleep	= optionWarning:format(GetSpellInfo(52721)),
	TimerSleep	= optionTimerDur:format(GetSpellInfo(52721)),
	TimerSleepCD	= optionTimerCD:format(GetSpellInfo(52721))
})

-----------------
-- Wave Timers --
-----------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "斯坦波數"
})

L:SetWarningLocalization({
	WarningWaveNow		= "第%d波: %s 出現了",
})

L:SetTimerLocalization({
	TimerWaveIn	= 	"下一波(6)", 
})

L:SetOptionLocalization({
	WarningWaveNow		= optionWarning:format("新一波"),
	TimerWaveIn		= "為\"下一波\"顯示計時器 (只有第6波)",
})


L:SetMiscLocalization({
	Meathook	= "Meathook",
	Salramm		= "Salramm the Fleshcrafter",
	Devouring	= "Devouring Ghoul",
	Enraged		= "Enraged Ghoul",
	Necro		= "Necromancer",
	Friend		= "Crypt Friend",
	Tomb		= "Tomb Stalker",
	Abom		= "Patchwork Construct",
	Acolyte		= "Acolyte",
	Wave1		= "%d %s",
	Wave2		= "%d %s and %d %s",
	Wave3		= "%d %s, %d %s and %d %s",
	Wave4		= "%d %s, %d %s, %d %s and %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Scourge Wave = %d/10"
})


----------------------
-- Drak'Tharon Keep --
----------------------
-- Trollgore --
---------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "血角食人妖"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


------------------------
-- Novos the Summoner --
------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "『召喚者』諾沃司"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
-- King Dred --
---------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "崔德王"
})

L:SetWarningLocalization({
	WarningFear	= spell,
	WarningBite	= debuff,
	WarningSlash	= spell
})

L:SetTimerLocalization({
	TimerFearCD	= spellCD,
	TimerSlash	= debuff,
	TimerSlashCD	= spellCD
})

L:SetOptionLocalization({
	WarningSlash	= optionWarning:format("碎裂斬/穿甲斬"),
	WarningFear	= optionWarning:format(GetSpellInfo(22686)),
	WarningBite	= optionWarning:format(GetSpellInfo(48920)),
	TimerFearCD	= optionTimerCD:format(GetSpellInfo(22686)),
	TimerSlash	= optionTimerDur:format("碎裂斬/穿甲斬"),
	TimerSlashCD	= optionTimerCD:format("碎裂斬/穿甲斬")
})


---------------------------
-- The Prophet Tharon'ja --
---------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "預言者薩隆杰"
})

L:SetWarningLocalization({
	WarningCloud	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningCloud	= optionWarning:format(GetSpellInfo(49548))
})


--------------
-- Gun'Drak --
--------------
-- Slad'ran --
--------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "史拉德銳"
})

L:SetWarningLocalization({
	WarningNova	= spell
})

L:SetTimerLocalization({
	TimerNovaCD	= spellCD
})

L:SetOptionLocalization({
	WarningNova	= optionWarning:format(GetSpellInfo(55081)),
	TimerNovaCD	= optionTimerCD:format(GetSpellInfo(55081))
})


-------------
-- Moorabi --
-------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "慕拉比"
})

L:SetWarningLocalization({
	WarningTransform	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningTransform	= optionWarning:format(GetSpellInfo(55098))
})


-----------------------
-- Drakkari Colossus --
-----------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "德拉克瑞巨像"
})

L:SetWarningLocalization({
	WarningElemental	= "元素階段",
	WarningStone		= "巨像階段"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "為元素階段顯示警告",
	WarningStone		= "為巨像階段顯示警告"
})


---------------
-- Gal'darah --
---------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "蓋爾達拉"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
-- Eck the Ferocious --
-----------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "『兇猛』埃克"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


------------------------
-- Halls of Lightning --
------------------------
-- General Bjarngrim --
-----------------------
L = DBM:GetModLocalization("Gjarngrin")

L:SetGeneralLocalization({
	name = "畢亞格林將軍"
})

L:SetWarningLocalization({
	WarningWhirlwind	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(52027))
})


-----------
-- Ionar --
-----------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "埃歐納"
})

L:SetWarningLocalization({
	WarningOverload	= debuff,
	WarningSplit	= spell
})

L:SetTimerLocalization({
	TimerOverload	= debuff
})

L:SetOptionLocalization({
	WarningOverload = optionWarning:format(GetSpellInfo(52658)),
	WarningSplit	= optionWarning:format(GetSpellInfo(52770)),
	TimerOverload	= optionTimerDur:format(GetSpellInfo(52658))
})


-------------
-- Volkhan --
-------------
L = DBM:GetModLocalization("Volkhan")


L:SetGeneralLocalization({
	name = "渥克瀚"
})

L:SetWarningLocalization({
	WarningStomp 	= spell
})

L:SetTimerLocalization({
	TimerStompCD	= spellCD
})

L:SetOptionLocalization({
	WarningStomp 	= optionWarning:format(GetSpellInfo(52237)),
	TimerStompCD 	= optionTimerCD:format(GetSpellInfo(52237))
})


------------
-- Kronus --
------------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "洛肯"
})

L:SetWarningLocalization({
	WarningNova	= spell
})

L:SetTimerLocalization({
	TimerNovaCD	= spellCD
})

L:SetOptionLocalization({
	WarningNova	= optionWarning:format(GetSpellInfo(52960)),
	TimerNovaCD	= optionTimerCD:format(GetSpellInfo(52960))
})


--------------------
-- Halls of Stone --
---------------------
-- Maiden of Grief --
---------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "悲嘆少女"
})

L:SetWarningLocalization({
	WarningWoe	= debuff,
	WarningSorrow	= spell,
	WarningStorm	= spell
})

L:SetTimerLocalization({
	TimerWoe	= debuff,
	TimerSorrow	= spell,
	TimerSorrowCD	= spellCD,
	TimerStormCD	= spellCD
})

L:SetOptionLocalization({
	WarningWoe	= optionWarning:format(GetSpellInfo(50761)),
	WarningSorrow	= optionWarning:format(GetSpellInfo(50760)),
	WarningStorm	= optionWarning:format(GetSpellInfo(50752)),
	TimerWoe	= optionTimerDur:format(GetSpellInfo(50761)),
	TimerSorrow	= optionTimerDur:format(GetSpellInfo(50760)),
	TimerSorrowCD	= optionTimerCD:format(GetSpellInfo(50760)),
	TimerStormCD	= optionTimerCD:format(GetSpellInfo(50752)),
})


----------------
-- Krystallus --
----------------
L = DBM:GetModLocalization("Krystallus")
L:SetGeneralLocalization({
	name = "克利斯托魯斯"
})

L:SetWarningLocalization({
	WarningShatter	= spell
})

L:SetTimerLocalization({
	TimerShatterCD	= spellCD
})

L:SetOptionLocalization({
	WarningShatter	= optionWarning:format(GetSpellInfo(50810)),
	TimerShatterCD	= optionTimerCD:format(GetSpellInfo(50810))
})


----------------------------
-- Sjonnir the Ironshaper --
----------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "『塑鐵者』斯雍尼爾"
})

L:SetWarningLocalization({
	WarningCharge	= debuff,
	WarningRing	= spell
})

L:SetTimerLocalization({
	TimerCharge	= debuff,
	TimerChargeCD	= spellCD,
	TimerRingCD	= spellCD
})

L:SetOptionLocalization({
	WarningCharge	= optionWarning:format(GetSpellInfo(50834)),
	WarningRing	= optionWarning:format(GetSpellInfo(50840)),
	TimerCharge	= optionTimerDur:format(GetSpellInfo(50834)),
	TimerChargeCD	= optionTimerCD:format(GetSpellInfo(50834)),
	TimerRingCD	= optionTimerCD:format(GetSpellInfo(50840))
})


------------------------------------
-- Brann Bronzebeard Escort Event --
------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "護衛事件"
})

L:SetWarningLocalization({
	WarningPhase	= "階段 %d"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("階段 #")
})

L:SetMiscLocalization({
	Pull		= "幫我看著外頭!我只要三兩下就可以搞定這玩意--",
	Phase1	= "xxx anti error xxx",
	Phase2	= "xxx anti error xxx",
	Phase3	= "xxx anti error xxx"
})


---------------
-- The Nexus --
---------------
-- Anomalus --
--------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "艾諾瑪路斯"
})

L:SetWarningLocalization({
	WarningRiftSoon		= spellSoon,
	WarningRiftNow		= spell,
})

L:SetOptionLocalization({
	WarningRiftSoon		= optionPreWarning:format(GetSpellInfo(47743)),
	WarningRiftNow		= optionWarning:format(GetSpellInfo(47743))
})


-----------------------------
-- Ormorok the Tree-Shaper --
-----------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "『樹木造形者』歐爾莫洛克"
})

L:SetWarningLocalization({
	WarningSpikes		= spell,
	WarningReflection	= spell,
	WarningFrenzy		= spell,
	WarningAdd		= spell
})

L:SetTimerLocalization({
	TimerReflection		= spell,
	TimerReflectionCD	= spellCD
})

L:SetOptionLocalization({
	WarningSpikes		= optionWarning:format(GetSpellInfo(47958)),
	WarningReflection	= optionWarning:format(GetSpellInfo(47981)),
	WarningFrenzy		= optionWarning:format(GetSpellInfo(48017)),
	WarningAdd		= optionWarning:format(GetSpellInfo(61564)),
	TimerReflection		= optionTimerDur:format(GetSpellInfo(47981)),
	TimerReflectionCD	= optionTimerCD:format(GetSpellInfo(47981))
})


--------------------------
-- Grand Magus Telestra --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "大魔導師特雷斯翠"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "即將分裂",
	WarningSplitNow		= "分裂",
	WarningMerge		= "融合"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= optionPreWarning:format("分裂"),
	WarningSplitNow		= optionWarning:format("分裂"),
	WarningMerge		= optionWarning:format("融合"),
})

L:SetMiscLocalization({
	SplitTrigger1 = "這裡有我千萬個分身。",
	SplitTrigger2 = "我要讓你們嚐嚐無所適從的滋味!",
	MergeTrigger = "現在，最後一步!"
})


-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "凱瑞史卓莎"
})

L:SetWarningLocalization({
	WarningChains 	= debuff,
	WarningEnrage	= spell,
	WarningNova	= spell
})

L:SetTimerLocalization({
	TimerChains	= debuff,
	TimerNova	= spell,
	TimerChainsCD	= spellCD,
	TimerNovaCD	= spellCD
})

L:SetOptionLocalization({
	WarningChains	= optionWarning:format(GetSpellInfo(50997)),
	WarningNova	= optionWarning:format(GetSpellInfo(48179)),
	WarningEnrage	= optionWarning:format(GetSpellInfo(8599)),
	TimerChains	= optionTimerDur:format(GetSpellInfo(50997)),
	TimerChainsCD	= optionTimerCD:format(GetSpellInfo(50997)),
	TimerNova	= optionTimerDur:format(GetSpellInfo(48179)),
	TimerNovaCD	= optionTimerCD:format(GetSpellInfo(48179))
})


---------------------------------
-- Commander Kolurg/Stoutbeard --
---------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "未知"
if UnitFactionGroup("player") == "Alliance" then
	commander = "指揮官寇勒格"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "指揮官厚鬚"
end

L:SetGeneralLocalization({
	name = commander
})

L:SetWarningLocalization({
	WarningFear 		= spell,
	WarningWhirlwind	= spell
})

L:SetTimerLocalization({
	TimerFearCD		= spellCD,
	TimerWhirlwindCD	= spellCD
})

L:SetOptionLocalization({
	WarningFear		= optionWarning:format(GetSpellInfo(19134)),
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(38619)),
	TimerFearCD		= optionTimerCD:format(GetSpellInfo(19134)),
	TimerWhirlwindCD	= optionTimerCD:format(GetSpellInfo(38619))
})


----------------
-- The Oculus --
-----------------------------
-- Drakos the Interrogator --
-----------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "『審問者』德拉高斯"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------
-- Mage-Lord Urom --
--------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "法師領主厄隆"
})

L:SetWarningLocalization({
	WarningTimeBomb = debuff,
	WarningExplosion = spell
})

L:SetTimerLocalization({
	TimerTimeBomb = debuff,
	TimerExplosion = spell
})

L:SetOptionLocalization({
	WarningTimeBomb 	= optionWarning:format(GetSpellInfo(51121)),
	WarningExplosion 	= optionWarning:format(GetSpellInfo(51110)),
	TimerTimeBomb 		= optionTimerDur:format(GetSpellInfo(51121)),
	TimerExplosion 		= optionTimerDur:format(GetSpellInfo(51110)),
	SpecWarnBombYou 	= optionSpecWarning:format(GetSpellInfo(51121))
})


------------------------
-- Varos Cloudstrider --
------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "瓦羅斯·雲行者"
})

L:SetWarningLocalization({
	WarningAmplify	= debuff
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningAmplify	= optionWarning:format(GetSpellInfo(51054))
})


-------------------------
-- Ley-Guardian Eregos --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "地脈守護者伊瑞茍斯"
})

L:SetWarningLocalization({
	WarningShift	= spell,
	WarningEnraged	= spell,
	WarningShiftEnd	= "界域轉換結束"
})

L:SetTimerLocalization({
	TimerShift	= spell,
	TimerEnrage	= spell
})

L:SetOptionLocalization({
	WarningShift	= optionWarning:format(GetSpellInfo(51162)),
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).."結束"),
	WarningEnraged	= optionWarning:format(GetSpellInfo(51170)),
	TimerShift	= optionTimerDur:format(GetSpellInfo(51162)),
	TimerEnrage	= optionTimerDur:format(GetSpellInfo(51170))
})


------------------
-- Utgarde Keep --
---------------------
-- Prince Keleseth --
---------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "凱雷希斯王子"
})

L:SetWarningLocalization({
	WarningTomb	= debuff
})

L:SetTimerLocalization({
	TimerTomb	= debuff
})

L:SetOptionLocalization({
	WarningTomb	= optionWarning:format(GetSpellInfo(48400)),
	TimerTomb	= optionTimerDur:format(GetSpellInfo(48400))
})


------------------------------
-- Skarvald the Constructor --
-- & Dalronn the Controller --
------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "『控制者』達隆恩"
})

L:SetWarningLocalization({
	WarningEnfeeble		= debuff,
	WarningSummon		= spell
})

L:SetTimerLocalization({
	TimerEnfeeble		= debuff
})

L:SetOptionLocalization({
	WarningEnfeeble		= optionWarning:format(GetSpellInfo(43650)),
	WarningSummon		= optionWarning:format(GetSpellInfo(52611)),
	TimerEnfeeble		= optionTimerDur:format(GetSpellInfo(43650))
})


--------------------------
-- Ingvar the Plunderer --
--------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "『盜掠者』因格瓦"
})

L:SetWarningLocalization({
	WarningSmash			= spell,
	WarningGrowl			= spell,
	WarningWoeStrike		= debuff,
	SpecialWarningSpelllock 	= "法術封鎖 - 停止施法!"
})

L:SetTimerLocalization({
	TimerSmash	= spell,
	TimerWoeStrike	= debuff
})

L:SetOptionLocalization({
	WarningSmash		= optionWarning:format(GetSpellInfo(42723)),
	WarningGrowl		= optionWarning:format(GetSpellInfo(42708)),
	WarningWoeStrike	= optionWarning:format(GetSpellInfo(42730)),
	SpecialWarningSpelllock 	= optionSpecWarning:format(GetSpellInfo(42729)),
	TimerSmash		= optionTimerCast:format(GetSpellInfo(42723)),
	TimerWoeStrike		= optionTimerDur:format(GetSpellInfo(42730))
})


----------------------
-- Utgarde Pinnacle --
------------------------
-- Skadi the Ruthless --
------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "無情的斯卡迪"
})

L:SetWarningLocalization({
	WarningWhirlwind	= spell,
	WarningPoison		= debuff
})

L:SetTimerLocalization({
	TimerPoison		= debuff,
	TimerWhirlwindCD	= spellCD
})

L:SetOptionLocalization({
	WarningWhirlwind	= optionWarning:format(GetSpellInfo(59332)),
	WarningPoison		= optionWarning:format(GetSpellInfo(59331)),
	TimerPoison		= optionTimerDur:format(GetSpellInfo(59331)),
	TimerWhirlwindCD	= optionTimerCD:format(GetSpellInfo(59332))
})

------------
-- Ymiron --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "依米倫國王"
})

L:SetWarningLocalization({
	WarningBane	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningBane	= optionWarning:format(GetSpellInfo(48294))
})


-----------------------
-- Svala Sorrowgrave --
-----------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "絲瓦拉·悲傷亡墓"
})

L:SetWarningLocalization({
	WarningSword	= debuff
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSword	= optionWarning:format(GetSpellInfo(48276))
})


---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "戈托克·白蹄"
})

L:SetWarningLocalization({
	WarningImpale	= debuff
})

L:SetTimerLocalization({
	TimerImpale	= debuff
})

L:SetOptionLocalization({
	WarningImpale	= optionWarning:format(GetSpellInfo(48261)),
	TimerImpale	= optionTimerDur:format(GetSpellInfo(48261))
})


---------------------
-- The Violet Hold --
---------------------
-- Cyanigosa --
---------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "霞妮苟莎"
})

L:SetWarningLocalization({
	WarningVacuum	= spell,
	WarningBlizzard	= spell,
	WarningMana	= debuff
})

L:SetTimerLocalization({
	TimerVacuumCD	= spellCD,
	TimerMana	= debuff
})

L:SetOptionLocalization({
	WarningVacuum	= optionWarning:format(GetSpellInfo(58694)),
	WarningBlizzard	= optionWarning:format(GetSpellInfo(58693)),
	WarningMana	= optionWarning:format(GetSpellInfo(59374)),
	TimerMana	= optionTimerDur:format(GetSpellInfo(59374)),
	TimerVacuumCD	= optionTimerCD:format(GetSpellInfo(58694))
})


------------
-- Erekem --
------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "伊銳坎"
})

L:SetWarningLocalization({
	WarningES	= spell
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningES	= optionWarning:format(GetSpellInfo(54479))
})


-------------
-- Ichoron --
-------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "伊仇隆"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
-- Lavanthor --
---------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "拉方索"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


------------
-- Moragg --
------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "摩拉革"
})

L:SetWarningLocalization({
	WarningLink	= debuff
})

L:SetTimerLocalization({
	TimerLink	= debuff,
	TimerLinkCD	= spellCD
})

L:SetOptionLocalization({
	WarningLink	= optionWarning:format(GetSpellInfo(54396)),
	TimerLink	= optionTimerDur:format(GetSpellInfo(54396)),
	TimerLinkCD	= optionTimerCD:format(GetSpellInfo(54396))
})


------------
-- Xevoss --
------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "基沃滋"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


-----------------------------
-- Zuramat the Obliterator --
-----------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "『消滅者』舒拉邁特"
})

L:SetWarningLocalization({
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningVoidShifted	= optionSpecWarning:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness		= optionSpecWarning:format(GetSpellInfo(59745))
})


-------------------
-- Portal Timers --
-------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "傳送門計時"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "新傳送門即將開啟",
	WarningPortalNow	= "傳送門 #%d",
	WarningBossNow		= "首領即將到來",
})

L:SetTimerLocalization({
	TimerPortalIn	= "傳送門 #%d",
})

L:SetOptionLocalization({
	WarningPortalNow		= "為新傳送門顯示警告",
	WarningPortalSoon		= "為新傳送門顯示預先警告",
	WarningBossNow			= "為首領顯示警告",
	TimerPortalIn			= "為 \"傳送門: #\" 顯示計時器",
	ShowAllPortalWarnings		= "為所有傳送門顯示警告"
})


L:SetMiscLocalization({
	yell1 = "監獄守衛，我們要離開了!這些冒險者會接手!動作快!",
	WavePortal		= "傳送門開啟:(%d+)/18"
})


---------------------
-- Trial of the Champion --
---------------------
-------------------
-- The Black Knight --
-------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "黑騎士"
})

L:SetWarningLocalization({
	specWarnDesecration		= "褻瀆 - 快跑開",
	warnExplode		= "食屍鬼爪牙即將爆炸 - 快跑開"
})

L:SetOptionLocalization({
	specWarnDesecration		= "當你受到褻瀆的傷害時顯示特別警告",
	warnExplode		= "當食屍鬼爪牙即將自我爆炸時警告",
	SetIconOnMarkedTarget	= "設置標記在死亡標記的目標"
})

L:SetMiscLocalization({
	YellCombatEnd			= "My congratulations, champions. Through trials both planned and unexpected, you have triumphed."	-- can also be "No! I must not fail... again ..."
})


-------------------
-- Grand Champions --
-------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "大勇士們"
})

L:SetWarningLocalization({
	specWarnHaste		= "加速: >%s< - 快驅散",
	specWarnPoison		= "毒藥瓶 - 快跑開",
})

L:SetOptionLocalization({
	specWarnHaste		= "當法師獲得加速時特別警告 (驅散/竊取用)",
	specWarnPoison		= "當你受到毒藥瓶的傷害時顯示特別警告"
})

L:SetMiscLocalization({
	YellCombatEnd			= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})


-------------------
-- Argent Confessor Paletress --
-------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "銀白告解者帕爾璀絲"
})

L:SetWarningLocalization({
	specwarnRenew		= "帕爾璀絲施放恢復於 >%s< - 快驅散"
})

L:SetOptionLocalization({
	specwarnRenew		= "為恢復的目標顯示特別警告 (驅散/竊取用)"
})

L:SetMiscLocalization({
--	YellCombatEnd				= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})


-------------------
-- Eadric the Pure --
-------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "『純淨者』埃卓克"
})

L:SetWarningLocalization({
	specwarnHammerofJustice		= "制裁之錘: >%s< - 快驅散",
	specwarnRadiance		= "烈光 - 背對王"
})

L:SetOptionLocalization({
	specwarnHammerofJustice		= "為制裁之錘顯示特別警告 (驅散用)",
	specwarnRadiance		= "為烈光顯示特別警告",
	SetIconOnHammerTarget		= "設置標記在制裁之錘的目標"
})

L:SetMiscLocalization({
--	YellCombatEnd				= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})

---------------------
-- World Events --
---------------------
-------------------
-- Coren Direbrew --
-------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "寇仁·恐酒"
})

L:SetWarningLocalization({
	warnBarrel		= "空桶(暈): >%s<", 
--	specwarnDaughters		= "女兒出現了!",
	specwarnDisarm		= "繳械 - 快跑開",
	specWarnBrew		= "在他再丟你一個前喝掉酒!",
	specWarnBrewStun		= "提示:你瘋狂了,記得下一次喝啤酒!"
})

L:SetOptionLocalization({
	warnBarrel		= "提示空桶(暈)的目標",
--	specwarnDaughters		= "提示厄蘇拉/伊爾莎的出現",
	DisarmWarning		= "為繳械顯示特別警告",
	specWarnBrew		= "為黑鐵啤酒辣妹的啤酒顯示特別警告",
	specWarnBrewStun		= "為黑鐵啤酒辣妹昏迷顯示特別警告",
	PlaySoundOnDisarm	= "當繳械時播放音效",
	YellOnBarrel		= "當你中了空桶(暈)時大喊"
})

L:SetMiscLocalization({
	YellBarrel		= "我中了空桶(暈)"
})

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "無頭騎士"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers			= "跳動的南瓜出現了!",
	specWarnHorsemanHead			= "頭顱出現了! 轉換目標!"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers			= "為跳動的南瓜出現顯示警告",
	specWarnHorsemanHead			= "為無頭騎士之頭出現顯示警告"

})

L:SetMiscLocalization({
	HorsemanHead				= "過來這裡，你這白痴!",
	HorsemanSoldiers			= "士兵們起立，挺身奮戰!讓這個位死去的騎士得到最後的勝利!",
	SayCombatEnd				= "我也曾面對過這樣的末路。還有什麼新的冒險在等著呢?"
})

---------------------
-- Pit of Saron --
---------------------
-------------------
-- Ick --
-------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "艾克"
})

L:SetWarningLocalization({
	warnPursuit			= "5 秒後 獵殺",
	specWarnToxic		= "Toxic Waste - 快跑開",
	specWarnPursuit		= "你中了獵殺 - 快跑"
})

L:SetOptionLocalization({
	warnPursuit			= "當獵殺即將到來時顯示警告",
	specWarnToxic		= "當你受到Toxic Waste的傷害時顯示特別警告",
	specWarnPursuit		= "當你中了獵殺時顯示特別警告",
--	SetIconOnPursuitTarget	= "設置標記在獵殺的目標"
})

L:SetMiscLocalization({
	IckPursuit			= "%s正在追擊著你!"
})
-------------------
-- Forgemaster Garfrost --
-------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "『鍛造大師』加弗羅斯"
})

L:SetWarningLocalization({
	warnSaroniteRock				= "Saronite Rock! Line of Sight now",
	specWarnSaroniteRock		= "你中了Saronite Throw - 快跑開",
	specWarnPermafrost		= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock				= "為Saronite Rock顯示警告 (清除極寒冰霜用)",
	specWarnSaroniteRock		= "當你中了Saronite Throw顯示特別警告",
	specWarnPermafrost		= "當極寒冰霜堆疊太高時顯示特別警告 (數值並非一成不變)",
--	SetIconOnSaroniteRockTarget	= "設置標記在Saronite Rock的目標"
})

L:SetMiscLocalization({
	SaroniteRockThrow			= "%s hurls a massive saronite boulder at you!"
})

-------------------
-- Scourgelord Tyrannus --
-------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "『天譴領主』提朗紐斯"
})

L:SetWarningLocalization({
	specTyrannusEngaged			= "『天譴領主』提朗紐斯正在下來 - 做好準備",
	specWarnIcyBlast			= "冰結衝擊 - 快跑開",
	specWarnHoarfrost			= "你中了Hoarfrost - 快跑開",
	specWarnHoarfrostNear		= "你附近有人被Hoarfrost - 快跑開"
})

L:SetOptionLocalization({
	specWarnIcyBlast			= "當你受到冰結衝擊的傷害時顯示特別警告",
	specWarnHoarfrost			= "當你中了Hoarfrost時顯示特別警告",
	specWarnHoarfrostNear		= "當你附近有人被Hoarfrost時顯示特別警告",
	SetIconOnHoarfrostTarget	= "設置標記在Hoarfrost的目標"
})

L:SetMiscLocalization({
	TyrannusYell		= "Alas, brave, brave adventurers, your meddling has reached its end. Do you hear the clatter of bone and steel coming up the tunnel behind you? That is the sound of your impending demise.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget			= "^%%s gazes at (%S+) and readies an icy attack!"
})
---------------------
-- Forge of Souls --
---------------------
-------------------
-- Bronjahm --
-------------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "『眾魂教父』布朗吉姆"
})

L:SetWarningLocalization({
	specwarnSoulstorm		= "Soulstorm - 快跑進去"
})

L:SetOptionLocalization({
	specwarnSoulstorm		= "當Soulstorm施放時顯示特別警告 (進駐用)"
})

-------------------
-- Devourer of Souls --
-------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "眾魂監督者"
})

L:SetWarningLocalization({
	specwarnMirroredSoul		= "停止攻擊"
})

L:SetOptionLocalization({
	specwarnMirroredSoul		= "為Mirrored Soul需要停止攻擊時顯示特別警告"
})
