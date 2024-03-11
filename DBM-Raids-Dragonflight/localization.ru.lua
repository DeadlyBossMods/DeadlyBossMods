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
--  The Amalgamation Chamber --
---------------------------
L= DBM:GetModLocalization(2529)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "Активно сканировать расстояние до каждого из боссов на 1-й фазе и автоматически скрывать определенные оповещения и таймеры исчезновения для босса, рядом с которым Вы НЕ находитесь (расстояние более 43 м.)."
})

---------------------------
--  The Forgotten Experiments --
---------------------------
L= DBM:GetModLocalization(2530)

L:SetMiscLocalization({
	SafeClear		= "Безопасная очистка"
})

---------------------------
--  Assault of the Zaqali --
---------------------------
L= DBM:GetModLocalization(2524)

L:SetTimerLocalization{
	timerGuardsandHuntsmanCD	= "Большие адды (%s)"
}

L:SetOptionLocalization({
	timerGuardsandHuntsmanCD	= "Показывать таймеры для новых Охотников или Стражей, взбирающихся на стены"
})

L:SetMiscLocalization({
	northWall		= "Commanders ascend the northern battlement!",
	southWall		= "Commanders ascend the southern battlement!"
})

---------------------------
--  Rashok --
---------------------------
L= DBM:GetModLocalization(2525)

L:SetOptionLocalization({
	TankSwapBehavior	= "Установить поведение мода при смене танков",
	OnlyIfDanger		= "Показывать предупреждение о таунте только в том случае, если другой танк собирается принять небезопасный удар",
	MinMaxSoak			= "Показывать предупреждение о таунте после первой комбо-атаки или если другой танк собирается получить небезопасный удар",
	DoubleSoak			= "Показывать предупреждение о таунте после завершения комбо-атаки или если другой танк собирается получить небезопасный удар"--По умолчанию
})

L:SetMiscLocalization({
	pool		= "{rt%d}Лужа %d",
	soakpool	= "Поглощение лужи"
})

---------------------------
--  Zskarn --
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --
---------------------------
L= DBM:GetModLocalization(2527)

L:SetMiscLocalization({
	pool		= "{rt%d}Лужа %d",
	soakpool	= "Поглощение лужи"
})

---------------------------
--  Echo of Neltharion --
---------------------------
L= DBM:GetModLocalization(2523)

L:SetMiscLocalization({
	WallBreaker	= "Разрушение стены"
})

---------------------------
--  Scalecommander Sarkareth --
---------------------------
L= DBM:GetModLocalization(2520)

L:SetOptionLocalization({
	InfoFrameBehaviorTwo	= "Установить поведение мода для отслеживания стаков на инфофрейме",
	OblivionOnly			= "Показывать только стаки Забвения (фазы 1, 2 и 3)",--По умолчанию
	HowlOnly				= "Показывать только стаки Подавляющего воя (1-я фаза, в остальных случаях закрывается)",
	Hybrid					= "Показывать стаки Подавляющего воя на 1-й фазе и стаки Забвения на фазах 2 и 3"
})

L:SetMiscLocalization({
	EarlyStaging			= "Фаза завершилась досрочно из-за предела здоровья"
})

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
L= DBM:GetModLocalization(2557)

L:SetMiscLocalization({
	DebuffSoaks			= "Поглощение дебаффов (%s)"
})

---------------------------
--  Council of Dreams --
---------------------------
L= DBM:GetModLocalization(2555)

L:SetMiscLocalization({
	Ducks		= "Утки (%s)"
})

---------------------------
--  Larodar, Keeper of the Flame --
---------------------------
L= DBM:GetModLocalization(2553)

L:SetMiscLocalization({
	currentHealth		= "%d%%",
	currentHealthIcon	= "{rt%d}%d%%",
	Roots				= "Корни (%s)",
	HealAbsorb			= "Поглощение исцеления (%s)"
})

---------------------------
--  Nymue, Weaver of the Cycle --
---------------------------
L= DBM:GetModLocalization(2556)

L:SetMiscLocalization({
	Threads			= "Потоки (%s)"
})

---------------------------
--  Smolderon --
---------------------------
--L= DBM:GetModLocalization(2563)

---------------------------
--  Tindral Sageswift, Seer of the Flame --
---------------------------
L= DBM:GetModLocalization(2565)

L:SetMiscLocalization({
	TreeForm			= "Форма дерева",
	MoonkinForm			= "Форма Лунного совуха",
	Feathers			= "Перья"
})

---------------------------
--  Fyrakk the Blazing --
---------------------------
L= DBM:GetModLocalization(2519)

L:SetTimerLocalization{
	timerMythicDebuffs			= "Клетки (%s)"
}

L:SetWarningLocalization{
	warnMythicDebuffs			= "Клетки (%s)"
}

L:SetOptionLocalization{
	warnMythicDebuffs			= "Сообщать о наложении дебаффов $spell:428988 и $spell:428970 (со счетчиком)",
	timerMythicDebuffs			= "Показать таймер (со счетчиком) для дебаффов $spell:428988 и $spell:428970"
}

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AmirdrassilTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Амирдрассил, Надежда Сна"
})
