if GetLocale() ~= "zhTW" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "阿努比瑞克漢"
})

L:SetWarningLocalization({
	SpecialLocust		= "蝗蟲風暴!",
	WarningLocustSoon	= "15秒內蝗蟲風暴",
	WarningLocustNow	= "蝗蟲風暴!",
	WarningLocustFaded	= "蝗蟲風暴消失"
})

L:SetTimerLocalization({
	TimerLocustIn	= "蝗蟲風暴", 
	TimerLocustFade = "蝗蟲風暴啟動"
})

L:SetOptionLocalization({
	SpecialLocust		= "顯示蝗蟲風暴特殊警告",
	WarningLocustSoon	= "顯示蝗蟲風暴預先警告",
	WarningLocustNow	= "顯示蝗蟲風暴警告",
	WarningLocustFaded	= "顯示蝗蟲風暴消失警告",
	TimerLocustIn		= "顯示蝗蟲風暴計時", 
	TimerLocustFade 	= "顯示蝗蟲風暴消失計時"
})


----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "大寡婦費琳娜"
})

L:SetWarningLocalization({
	WarningEmbraceActive	= "寡婦之擁啟動",
	WarningEmbraceExpire	= "寡婦之擁5秒內結束",
	WarningEmbraceExpired	= "寡婦之擁消失",
	WarningEnrageSoon		= "5秒內狂亂",
	WarningEnrageNow		= "狂亂!"
})

L:SetTimerLocalization({
	TimerEmbrace	= "寡婦之擁啟動",
	TimerEnrage		= "狂亂",
})

L:SetOptionLocalization({
	TimerEmbrace			= "顯示寡婦之擁計時",
	WarningEmbraceActive	= "顯示寡婦之擁警告",
	WarningEmbraceExpire	= "顯示警告當寡婦之擁結束",
	WarningEmbraceExpired	= "顯示警告當寡婦之擁即將結束",
	WarningEnrageSoon		= "顯示即將狂亂警告",
	WarningEnrageNow		= "顯示狂亂警告",
	TimerEnrage				= "顯示狂亂計時",
})


---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "梅克絲娜"
})

L:SetWarningLocalization({
	WarningWebWrap		= "撒網纏繞: >%s<",
	WarningWebSpraySoon	= "5秒內撒網",
	WarningWebSprayNow	= "撒網!",
	WarningSpidersSoon	= "5秒內蜘蛛",
	WarningSpidersNow	= "蜘蛛出現!"
})

L:SetTimerLocalization({
	TimerWebSpray	= "撒網",
	TimerSpider		= "蜘蛛"
})

L:SetOptionLocalization({
	WarningWebWrap		= "提示撒網目標",
	WarningWebSpraySoon	= "顯示撒網預先警告",
	WarningWebSprayNow	= "顯示撒網警告",
	WarningSpidersSoon	= "顯示蜘蛛預先警告",
	WarningSpidersNow	= "顯示蜘蛛警告",
	TimerWebSpray		= "顯示撒網計時",
	TimerSpider			= "顯示蜘蛛計時"
})

L:SetMiscLocalization({
	YellWebWrap			= "我被纏繞! 救我!"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "『瘟疫使者』諾斯"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "被傳送!",
	WarningTeleportSoon	= "20秒內傳送",
	WarningCurse		= "詛咒!"
})

L:SetTimerLocalization({
	TimerTeleport		= "傳送",
	TimerTeleportBack	= "傳送回來"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "顯示傳送警告",
	WarningTeleportSoon		= "顯示傳送預先警告",
	WarningCurse			= "顯示詛咒警告",
	TimerTeleport			= "顯示傳送計時",
	TimerTeleportBack		= "顯示傳送回來計時"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "『骯髒者』海根"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "被傳送!",
	WarningTeleportSoon	= "%d秒內傳送",
})

L:SetTimerLocalization({
	TimerTeleport		= "傳送",
})

L:SetOptionLocalization({
	WarningTeleportNow		= "顯示傳送警告",
	WarningTeleportSoon		= "顯示傳送預先警告",
	WarningCurse			= "顯示詛咒警告",
	TimerTeleport			= "顯示傳送計時",
	TimerTeleportBack		= "顯示傳送回來計時"
})


----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "憎恨者"
})

L:SetWarningLocalization({
	WarningSporeNow		= "孢子出現!",
	WarningSporeSoon	= "5秒內孢子",
	WarningDoomNow		= "無可避免的末日 #%d",
	WarningHealSoon		= "3秒內可能治療",
	WarningHealNow		= "現在治療!"
})

L:SetTimerLocalization({
	TimerDoom			= "無可避免的末日 #%d",
	TimerSpore			= "下一次孢子",
	TimerAura			= "亡域光環"
})

L:SetOptionLocalization({
	WarningSporeNow		= "顯示孢子警告",
	WarningSporeSoon	= "顯示孢子預先警告",
	WarningDoomNow		= "顯示無可避免的末日警告",
	WarningHealSoon		= "顯示\"3秒內治療\"預先警告",
	WarningHealNow		= "顯示\"現在治療\" 警告",
	TimerDoom			= "顯示無可避免的末日計時",
	TimerSpore			= "顯示孢子計時",
	TimerAura			= "顯示亡域光環計時"
})



-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "縫補者"
})

L:SetOptionLocalization({
	WarningHateful = "提示團隊憎恨打擊\n(你須要是隊長或有權限才能使用)"
})

L:SetMiscLocalization({
	yell1 = "縫補者要跟你玩！",
	yell2 = "縫補者是科爾蘇加德的戰神！",
	HatefulStrike = "憎恨打擊 --> %s [%s]"
})


-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name = "葛羅巴斯"
})

L:SetOptionLocalization({
	WarningInjection		= "顯示突變注射警告",
	SpecialWarningInjection	= "顯示特殊警告當你被突變注射折磨"
})

L:SetWarningLocalization({
	WarningInjection		= "突變注射: >%s<",
	SpecialWarningInjection	= "你被突變注射!"
})

L:SetTimerLocalization({
})


-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "古魯斯"
})

L:SetOptionLocalization({
	WarningDecimateNow	= "顯示屠殺警告",
	WarningDecimateSoon	= "顯示屠殺預先警告",
	TimerDecimate		= "顯示屠殺計時"
})

L:SetWarningLocalization({
	WarningDecimateNow	= "屠殺!",
	WarningDecimateSoon	= "10秒內屠殺"
})

L:SetTimerLocalization({
	TimerDecimate		= "屠殺"
})


----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "泰迪斯"
})

L:SetMiscLocalization({
	Yell	= "斯塔拉格要碾碎你！",
	Emote	= "%s 超負荷！", -- ?
	Emote2	= "泰斯拉·寇歐", -- ?
})

L:SetOptionLocalization({
	WarningShiftCasting		= "顯示兩極移形警告",
	WarningChargeChanged	= "顯示特殊警告當你極性轉變",
	WarningChargeNotChanged	= "顯示特殊警告當你極性沒轉變",
	TimerShiftCast			= "顯示兩極移形施法計時",
	TimerNextShift			= "顯示兩極移形冷卻計時",
	ArrowsEnabled			= "顯示箭頭 (正常 \"2 營地\" 戰略)",
	ArrowsRightLeft			= "顯示右/左箭頭代表\"4 營地\" 戰略 (如果極性轉變顯示左箭頭, 否則右)",
	ArrowsInverse			= "倒轉\"4 營地\" 戰略 (顯示右箭頭當極性轉變, 沒有就左)",
	WarningThrow			= "顯示坦克投擲警告",
	WarningThrowSoon		= "顯示坦克投擲預先警告",
	TimerThrow				= "顯示坦克投擲計時"
})

L:SetWarningLocalization({
	WarningShiftCasting		= "5秒內兩極移形!",
	WarningChargeChanged	= "極性轉變為 %s",
	WarningChargeNotChanged	= "極性沒轉變",
	WarningThrow			= "坦克投擲!",
	WarningThrowSoon		= "3秒內坦克投擲"
})

L:SetTimerLocalization({
	TimerShiftCast			= "兩極移形施法",
	TimerNextShift			= "下次兩極移形",
	TimerThrow				= "坦克投擲"
})

L:SetOptionCatLocalization({
	Arrows	= "箭頭",
})


-----------------
--  Razuvious  --
-----------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "講師拉祖維斯"
})

L:SetMiscLocalization({
	Yell1 = "仁慈無用！",
	Yell2 = "練習時間到此為止！都拿出真本事來！",
	Yell3 = "照我教你的做！",
	Yell4 = "絆腿……有什麼問題嗎？"
})

L:SetOptionLocalization({
	WarningShoutNow		= "顯示混亂怒吼警告",
	WarningShoutSoon	= "顯示混亂怒吼預先警告",
	TimerShout			= "顯示混亂怒吼計時"
})

L:SetWarningLocalization({
	WarningShoutNow		= "混亂怒吼!",
	WarningShoutSoon	= "3秒內混亂怒吼"
})

L:SetTimerLocalization({
	TimerShout			= "混亂怒吼"
})

--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "『收割者』高希"
})

L:SetOptionLocalization({
	TimerWave			= "顯示波計時",
	TimerPhase2			= "顯示第二階計時",
	WarningWaveSoon		= "顯示下一波預先警告",
	WarningWaveSpawned	= "顯示下一波警告",
	WarningRiderDown	= "顯示警告當騎兵死亡",
	WarningKnightDown	= "顯示警告當死騎死亡",
	WarningPhase2		= "顯示第二階警告"
})

L:SetTimerLocalization({
	TimerWave	= "第#%d波",
	TimerPhase2	= "第二階"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "第%d波: %s 3秒內",
	WarningWaveSpawned	= "第%d波: %s 出現",
	WarningRiderDown	= "騎兵死亡",
	WarningKnightDown	= "死騎死亡",
	WarningPhase2		= "第二階"
})

L:SetMiscLocalization({
	yell			= "你們這些蠢貨已經主動步入了陷阱。",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s 和 %d %s",
	WarningWave3	= "%d %s, %d %s 和 %d %s",
	Trainee			= "|4無情的訓練師:訓練師;",
	Knight			= "|4無情的死騎:死騎;",
	Rider			= "|4無情的騎兵:騎兵;",
})


----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "四騎士"
})

L:SetOptionLocalization({
	TimerMark					= "顯示印記計時",
	WarningMarkSoon				= "顯示印記預先警告",
	WarningMarkNow				= "顯示印記警告",
	SpecialWarningMarkOnPlayer	= "顯示特殊警告當你有或多於4個印記"
})

L:SetTimerLocalization({
	TimerMark = "Mark %d"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "3秒內印記 %d ",
	WarningMarkNow				= "印記 %d!",
	SpecialWarningMarkOnPlayer	= "%s: %s",
})

L:SetMiscLocalization({
	Korthazz	= "寇斯艾茲族長",
	Rivendare	= "瑞文戴爾男爵",
	Blaumeux	= "布洛莫斯女士",
	Zeliek		= "札里克爵士",
})


-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "薩菲隆"
})

L:SetOptionLocalization({
	WarningIceblock			= "顯示寒冰屏障警告",
	WarningDrainLifeNow		= "顯示吸取生命警告",
	WarningDrainLifeSoon	= "顯示吸取生命預先警告",
	WarningAirPhaseSoon		= "顯示空中階段預先警告",
	WarningAirPhaseNow		= "顯示空中階段警告",
	WarningLanded			= "顯示地上階段警告",
	TimerDrainLifeCD		= "顯示吸取生命計時",
	TimerAir				= "顯示空中階段計時",
	TimerLanding			= "顯示著陸計時",
	TimerIceBlast			= "顯示深呼吸計時",
	WarningDeepBreath		= "顯示深呼吸特殊警告"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s深深地吸了一口氣...",
	WarningYellIceblock	= "我變成寒冰屏障了, 站到我後面去!"
})

L:SetWarningLocalization({
	WarningDrainLifeNow		= "吸取生命!",
	WarningDrainLifeSoon	= "即將吸取生命",
	WarningAirPhaseSoon		= "10秒內空中階段",
	WarningAirPhaseNow		= "空中階段",
	WarningLanded			= "薩菲隆著陸",
	WarningDeepBreath		= "深地吸!",
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "吸取生命冷卻",
	TimerAir				= "空中階段",
	TimerLanding			= "著陸",
	TimerIceBlast			= "深地吸"	
})

------------------
--  Kel'thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "科爾蘇加德"
})

L:SetOptionLocalization({
	TimerPhase2			= "顯示第二階計時",
	WarningBlastTargets	= "顯示冰霜衝擊警告",
	WarningPhase2		= "顯示第二階警告",
	WarningFissure		= "顯示暗影裂縫警告",
	WarningMana			= "顯示爆裂法力警告"
})

L:SetMiscLocalization({
	Yell = "僕從們，侍衛們，隸屬於黑暗與寒冷的戰士！聽從科爾蘇加德的召換！"
})

L:SetWarningLocalization({
	WarningBlastTargets	= "冰霜衝擊: >%s<",
	WarningPhase2		= "第二階",
	WarningFissure		= "暗影裂縫出現",
	WarningMana			= "爆裂法力: >%s<"
})

L:SetTimerLocalization({
	TimerPhase2			= "第二階"
})



