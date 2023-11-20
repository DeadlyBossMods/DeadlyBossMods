if GetLocale() ~= "ruRU" then return end
local L

---------------------------
--  Eranog --
---------------------------
--L= DBM:GetModLocalization(2480)

--L:SetWarningLocalization({
--})
--
--L:SetTimerLocalization{
--}
--
--L:SetOptionLocalization({
--})
--
--L:SetMiscLocalization({
--})

---------------------------
--  Terros --
---------------------------
--L= DBM:GetModLocalization(2500)

---------------------------
--  The Primalist Council --
---------------------------
--L= DBM:GetModLocalization(2486)

---------------------------
--  Sennarth, The Cold Breath --
---------------------------
--L= DBM:GetModLocalization(2482)

---------------------------
--  Dathea, Ascended --
---------------------------
--L= DBM:GetModLocalization(2502)

---------------------------
--  Kurog Grimtotem --
---------------------------
L= DBM:GetModLocalization(2491)

L:SetTimerLocalization({
	timerDamageCD = "Урон (%s)",
	timerAvoidCD = "Избежание (%s)",
	timerUltimateCD = "Ультимейт (%s)",
	timerAddEnrageCD = "Ярость (%s)"
})

L:SetOptionLocalization({
	timerDamageCD = "Показывать таймеры для атак с уроном на цели: $spell:382563, $spell:373678, $spell:391055, $spell:373487",
	timerAvoidCD = "Показывать таймеры для атак, которые можно избежать: $spell:373329, $spell:391019, $spell:395893, $spell:390920",
	timerUltimateCD = "Показывать таймеры для ультимативных атак на 100 энергии: $spell:374022, $spell:372456, $spell:374691, $spell:374215",
	timerAddEnrageCD = "Показывать таймеры ярости только на эпохальном уровне сложности"
})

L:SetMiscLocalization({
	Fire	= "Огонь",
	Frost	= "Мороз",
	Earth	= "Земля",
	Storm	= "Буря"
})

---------------------------
--  Broodkeeper Diurna --
---------------------------
L= DBM:GetModLocalization(2493)

L:SetMiscLocalization({
	staff	= "Великий посох",
	eStaff	= "Усиленный Великий посох"
})

---------------------------
--  Raszageth the Storm-Eater --
---------------------------
L= DBM:GetModLocalization(2499)

L:SetOptionLocalization({
	SetBreathToBait = "Настроить таймеры дыхания во время переходных фаз так, чтобы они истекали в зависимости от времени байта, а не от времени каста (оповещения по-прежнему будут срабатывать при касте дыхания)"
})

L:SetMiscLocalization({
	negative = "отрицательную",
	positive = "положительную",
	BreathEmote	= "Рашагет делает глубокий вдох..."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("VaultoftheIncarnatesTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Хранилище Воплощений"
})

---------------------------
--  Kazzara --
---------------------------
--L= DBM:GetModLocalization(2522)

---------------------------
--  Molgoth --
---------------------------
--L= DBM:GetModLocalization(2529)

---------------------------
--  Experimentation of the Dracthyr --
---------------------------
--L= DBM:GetModLocalization(2530)

---------------------------
--  Zaqali Invasion/ Djaradin Assault --
---------------------------
--L= DBM:GetModLocalization(2524)

---------------------------
--  Rashok --
---------------------------
--L= DBM:GetModLocalization(2525)

---------------------------
--  Zskarn --
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --
---------------------------
--L= DBM:GetModLocalization(2527)

---------------------------
--  Echo of Neltharion --
---------------------------
--L= DBM:GetModLocalization(2523)

---------------------------
--  Scalecommander Sarkareth --
---------------------------
--L= DBM:GetModLocalization(2520)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AberrusTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Аберрий, Затененное Горнило"
})

---------------------------
--  Amirdrassil, the Dream's Hope --
---------------------------
---------------------------
--  Gnarlroot --
---------------------------
--L= DBM:GetModLocalization(2564)

---------------------------
--  Igira the Cruel --
---------------------------
--L= DBM:GetModLocalization(2554)

---------------------------
--  Volcoross --
---------------------------
--L= DBM:GetModLocalization(2557)

---------------------------
--  Council of Dreams --
---------------------------
--L= DBM:GetModLocalization(2555)

---------------------------
--  Larodar, Keeper of the Flame --
---------------------------
--L= DBM:GetModLocalization(2553)

---------------------------
--  Nymue, Weaver of the Cycle --
---------------------------
--L= DBM:GetModLocalization(2556)

---------------------------
--  Smolderon --
---------------------------
--L= DBM:GetModLocalization(2563)

---------------------------
--  Tindral Sageswift, Seer of the Flame --
---------------------------
--L= DBM:GetModLocalization(2565)

---------------------------
--  Fyrakk the Blazing --
---------------------------
--L= DBM:GetModLocalization(2519)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AmirdrassilTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Амирдрассил, Надежда Сна"
})
