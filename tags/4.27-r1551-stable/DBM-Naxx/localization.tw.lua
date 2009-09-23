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
	SpecialLocust			= "蝗蟲風暴!",
	WarningLocustSoon		= "15秒後 蝗蟲風暴",
	WarningLocustNow		= "蝗蟲風暴!",
	WarningLocustFaded		= "蝗蟲風暴消失了"
})

L:SetTimerLocalization({
	TimerLocustIn			= "蝗蟲風暴", 
	TimerLocustFade 		= "蝗蟲風暴啟動"
})

L:SetOptionLocalization({
	SpecialLocust			= "為蝗蟲風暴顯示特別警告",
	WarningLocustSoon		= "顯示蝗蟲風暴的預先警告",
	WarningLocustNow		= "顯示蝗蟲風暴警告",
	WarningLocustFaded		= "顯示蝗蟲風暴消失警告",
	TimerLocustIn			= "顯示蝗蟲風暴計時器", 
	TimerLocustFade 		= "顯示蝗蟲風暴消失計時器"
})


----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "大寡婦費琳娜"
})

L:SetWarningLocalization({
	WarningEmbraceActive		= "寡婦之擁啟動",
	WarningEmbraceExpire		= "寡婦之擁5秒後完結",
	WarningEmbraceExpired		= "寡婦之擁消失",
	WarningEnrageSoon		= "5秒後 狂怒",
	WarningEnrageNow		= "狂怒!"
})

L:SetTimerLocalization({
	TimerEmbrace			= "寡婦之擁啟動",
	TimerEnrage			= "狂怒",
})

L:SetOptionLocalization({
	TimerEmbrace			= "顯示寡婦之擁計時器",
	WarningEmbraceActive		= "顯示寡婦之擁警告",
	WarningEmbraceExpire		= "當寡婦之擁完結時顯示警告",
	WarningEmbraceExpired		= "當寡婦之擁即將完結時顯示警告",
	WarningEnrageSoon		= "顯示即將狂怒警告",
	WarningEnrageNow		= "顯示狂怒警告",
	TimerEnrage			= "顯示狂怒計時",
})


---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "梅克絲娜"
})

L:SetWarningLocalization({
	WarningWebWrap			= "撒網纏繞: >%s<",
	WarningWebSpraySoon		= "5秒後 撒網(暈)",
	WarningWebSprayNow		= "撒網!",
	WarningSpidersSoon		= "5秒後 小蜘蛛",
	WarningSpidersNow		= "小蜘蛛出現了!"
})

L:SetTimerLocalization({
	TimerWebSpray			= "撒網",
	TimerSpider			= "小蜘蛛"
})

L:SetOptionLocalization({
	WarningWebWrap			= "提示纏繞的蜘蛛網的目標",
	WarningWebSpraySoon		= "顯示撒網的預先警告",
	WarningWebSprayNow		= "顯示撒網警告",
	WarningSpidersSoon		= "顯示小蜘蛛的預先警告",
	WarningSpidersNow		= "顯示小蜘蛛警告",
	TimerWebSpray			= "顯示撒網計時器",
	TimerSpider			= "顯示小蜘蛛計時器"
})

L:SetMiscLocalization({
	YellWebWrap			= "我被纏繞住了! 救我!"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "『瘟疫使者』諾斯"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "閃現!",
	WarningTeleportSoon		= "20秒後 閃現",
	WarningCurse			= "詛咒!"
})

L:SetTimerLocalization({
	TimerTeleport			= "閃現",
	TimerTeleportBack		= "閃現回來"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "顯示閃現警告",
	WarningTeleportSoon		= "顯示閃現的預先警告",
	WarningCurse			= "顯示詛咒警告",
	TimerTeleport			= "顯示閃現計時器",
	TimerTeleportBack		= "顯示閃現回來計時器"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "『不潔者』海根"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "閃現!",
	WarningTeleportSoon		= "%d秒後 閃現",
})

L:SetTimerLocalization({
	TimerTeleport			= "閃現",
})

L:SetOptionLocalization({
	WarningTeleportNow		= "顯示閃現警告",
	WarningTeleportSoon		= "顯示閃現的預先警告",
	WarningCurse			= "顯示詛咒警告",
	TimerTeleport			= "顯示閃現計時器",
	TimerTeleportBack		= "顯示閃現回來計時器"
})


----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "憎恨者"
})

L:SetWarningLocalization({
	WarningSporeNow			= "孢子出現了!",
	WarningSporeSoon		= "5秒後 孢子",
	WarningDoomNow			= "無可避免的末日 #%d",
	WarningHealSoon			= "3秒後可以治療",
	WarningHealNow			= "現在治療!"
})

L:SetTimerLocalization({
	TimerDoom			= "無可避免的末日 #%d",
	TimerSpore			= "下一個 孢子",
	TimerAura			= "亡域光環"
})

L:SetOptionLocalization({
	WarningSporeNow			= "顯示孢子警告",
	WarningSporeSoon		= "顯示孢子的預先警告",
	WarningDoomNow			= "顯示無可避免的末日警告",
	WarningHealSoon			= "顯示\"3秒後可以治療\"的預先警告",
	WarningHealNow			= "顯示\"現在治療\"警告",
	TimerDoom			= "顯示無可避免的末日計時器",
	TimerSpore			= "顯示孢子計時器",
	TimerAura			= "顯示亡域光環計時器"
})



-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "縫補者"
})

L:SetOptionLocalization({
	WarningHateful 			= "通告憎恨打擊到團隊頻道\n(你需要團隊領袖或助理許可權)"
})

L:SetMiscLocalization({
	yell1 				= "縫補者要跟你玩!",
	yell2 				= "科爾蘇加德讓縫補者成為戰爭的化身!",
	HatefulStrike 			= "憎恨打擊 --> %s [%s]"
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
	SpecialWarningInjection		= "當你中了突變注射時顯示特別警告"
})

L:SetWarningLocalization({
	WarningInjection		= "突變注射: >%s<",
	SpecialWarningInjection		= "你中了突變注射!"
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
	WarningDecimateNow		= "顯示殘殺警告",
	WarningDecimateSoon		= "顯示殘殺的預先警告",
	TimerDecimate			= "顯示殘殺計時器"
})

L:SetWarningLocalization({
	WarningDecimateNow		= "殘殺!",
	WarningDecimateSoon		= "10秒後 殘殺"
})

L:SetTimerLocalization({
	TimerDecimate			= "殘殺冷卻"
})


----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "泰迪斯"
})

L:SetMiscLocalization({
	Yell				= "斯塔拉格要碾碎你﹗",
	Emote				= "%s超過負荷!", -- ?
	Emote2				= "泰斯拉線圈超過負荷!", -- ?
	Boss1 = "伏晨",
	Boss2 = "斯塔拉格",
	Charge1 = "負極",
	Charge2 = "正極",
})

L:SetOptionLocalization({
	WarningShiftCasting		= "顯示極性轉換警告",
	WarningChargeChanged		= "顯示特別警告當你的極性變了",
	WarningChargeNotChanged		= "顯示特別警告當你的極性沒有改變",
	TimerShiftCast			= "顯示極性轉換施放計時器",
	TimerNextShift			= "顯示極性轉換冷卻計時器",
	ArrowsEnabled			= "顯示箭頭 (正常 \"二邊\" 站位打法)",
	ArrowsRightLeft			= "顯示左/右箭頭 給 \"四角\" 站位打法 (如果極性改變顯示左箭頭, 沒變顯示左箭頭)",
	ArrowsInverse			= "倒轉的 \"四角\" 站位打法 (如果極性改變顯示左箭頭, 沒變顯示右箭頭)",
	WarningThrow			= "顯示投擲坦克警告",
	WarningThrowSoon		= "顯示投擲坦克的預先警告",
	TimerThrow			= "顯示投擲坦克計時器"
})

L:SetWarningLocalization({
	WarningShiftCasting		= "5秒後 極性轉換!",
	WarningChargeChanged		= "極性變為%s",
	WarningChargeNotChanged		= "極性沒有改變",
	WarningThrow			= "投擲坦克!",
	WarningThrowSoon		= "3秒後 投擲坦克"
})

L:SetTimerLocalization({
	TimerShiftCast			= "施放極性轉換",
	TimerNextShift			= "下一次極性轉換",
	TimerThrow			= "投擲坦克"
})

L:SetOptionCatLocalization({
	Arrows				= "箭頭",
})


-----------------
--  Razuvious  --
-----------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "講師拉祖維斯"
})

L:SetMiscLocalization({
	Yell1 				= "絕不留情!",
	Yell2 				= "練習時間到此為止!都拿出真本事來!",
	Yell3 				= "照我教你的做!",
	Yell4 				= "絆腿……有什麼問題嗎?"
})

L:SetOptionLocalization({
	WarningShoutNow			= "顯示混亂怒吼警告",
	WarningShoutSoon		= "顯示混亂怒吼的預先警告",
	TimerShout			= "顯示混亂怒吼計時器",
	WarningShieldWallSoon		= "顯示盾牆失效警告",
	TimerShieldWall			= "顯示盾牆計時器",
	TimerTaunt			= "顯示嘲諷計時器"
})

L:SetWarningLocalization({
	WarningShoutNow			= "混亂怒吼!",
	WarningShoutSoon		= "5秒後 混亂怒吼",
	WarningShieldWallSoon		= "5秒後 盾牆失效"
})

L:SetTimerLocalization({
	TimerShout			= "混亂怒吼",
	TimerTaunt			= "嘲諷",
	TimerShieldWall			= "盾牆"
})

--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "『收割者』高希"
})

L:SetOptionLocalization({
	TimerWave			= "顯示波段計時",
	TimerPhase2			= "顯示第二階段計時",
	WarningWaveSoon			= "顯示波段的預先警告",
	WarningWaveSpawned		= "顯示波段出現警告",
	WarningRiderDown		= "當騎兵死亡時顯示警告",
	WarningKnightDown		= "死亡騎士死亡時顯示警告",
	WarningPhase2			= "顯示第二階段警告"
})

L:SetTimerLocalization({
	TimerWave			= "第 #%d 波",
	TimerPhase2			= "第2階段"
})

L:SetWarningLocalization({
	WarningWaveSoon			= "3秒後第%d波: %s",
	WarningWaveSpawned		= "第%d波: %s 出現了",
	WarningRiderDown		= "騎兵已死亡﹗",
	WarningKnightDown		= "死亡騎士已死亡﹗",
	WarningPhase2			= "第二階段"
})

L:SetMiscLocalization({
	yell				= "你們這些蠢貨已經主動步入了陷阱。",
	WarningWave1			= "%d %s",
	WarningWave2			= "%d %s 和 %d %s",
	WarningWave3			= "%d %s, %d %s 和 %d %s",
	Trainee				= "受訓者",
	Knight				= "死騎",
	Rider				= "騎兵",
})


----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "四騎士"
})

L:SetOptionLocalization({
	TimerMark			= "顯示印記計時器",
	WarningMarkSoon			= "顯示印記的預先警告",
	WarningMarkNow			= "顯示印記警告",
	SpecialWarningMarkOnPlayer	= "當你印記疊加大於四時顯示特別警告"
})

L:SetTimerLocalization({
	TimerMark 			= "印記 %d"
})

L:SetWarningLocalization({
	WarningMarkSoon			= "3秒後 印記 %d",
	WarningMarkNow			= "印記 #%d",
	SpecialWarningMarkOnPlayer	= "%s: %s",
})

L:SetMiscLocalization({
	Korthazz			= "寇斯艾茲族長",
	Rivendare			= "瑞文戴爾男爵",
	Blaumeux			= "布洛莫斯女士",
	Zeliek				= "札里克爵士",
})


-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "薩菲隆"
})

L:SetOptionLocalization({
	WarningDrainLifeNow		= "顯示生命吸取警告",
	WarningDrainLifeSoon		= "顯示生命吸取的預先警告",
	WarningAirPhaseSoon		= "顯示空中階段的預先警告",
	WarningAirPhaseNow		= "顯示空中階段警告",
	WarningLanded			= "顯示地上階段警告",
	TimerDrainLifeCD		= "顯示生命吸取計時器",
	TimerAir			= "顯示空中階段計時器",
	TimerLanding			= "顯示降落計時器",
	TimerIceBlast			= "顯示深呼吸計時器",
	WarningDeepBreath		= "顯示深呼吸特別警告",
	WarningIceblock			= "當你中了冰箱大喊",
})

L:SetMiscLocalization({
	EmoteBreath			= "%s深深地吸了一口氣。",
	WarningYellIceblock		= "我在冰箱入面!"
})

L:SetWarningLocalization({
	WarningDrainLifeNow		= "生命吸取!",
	WarningDrainLifeSoon		= "生命吸取 即將發動",
	WarningAirPhaseSoon		= "10秒後 空中階段",
	WarningAirPhaseNow		= "空中階段",
	WarningLanded			= "薩菲隆降落了",
	WarningDeepBreath		= "深呼吸!",
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "生命吸取冷卻",
	TimerAir			= "空中階段",
	TimerLanding			= "降落",
	TimerIceBlast			= "深呼吸"	
})

------------------
--  Kel'thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "科爾蘇加德"
})

L:SetOptionLocalization({
	TimerPhase2			= "顯示第二階段計時器",
	WarningBlastTargets		= "顯示冰霜衝擊警告",
	WarningPhase2			= "顯示第二階段警告",
	WarningFissure			= "顯示暗影裂縫警告",
	WarningMana			= "顯示爆裂法力警告",
	WarningChainsTargets		= "顯示科爾蘇加德之鍊(心控)警告"
})

L:SetMiscLocalization({
	Yell 				= "僕從們，侍衛們，隸屬於黑暗與寒冷的戰士們!聽從科爾蘇加德的召喚!"
})

L:SetWarningLocalization({
	WarningBlastTargets		= "冰霜衝擊: >%s<",
	WarningPhase2			= "第二階段",
	WarningFissure			= "暗影裂縫 出現了",
	WarningMana			= "爆裂法力: >%s<",
	WarningChainsTargets		= "科爾蘇加德之鍊(心控): >%s<"
})

L:SetTimerLocalization({
	TimerPhase2			= "第二階段"
})
