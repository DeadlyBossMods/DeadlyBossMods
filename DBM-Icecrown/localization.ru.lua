if GetLocale() ~= "ruRU" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Треш-мобы Шпиля"
}

L:SetWarningLocalization{
	specWarnTrap		= "Ловушка активирована! - Заклятый страж освобожден"--creatureid 37007
}

L:SetOptionLocalization{
	specWarnTrap		= "Спец-предупреждение для активации ловушки",
	SetIconOnDarkReckoning	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1		= "Кто... идет?",
	WarderTrap2		= "Я пробудился...",
	WarderTrap3		= "В покои господина проникли!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "Прелесть & Вонючка"
}

L:SetWarningLocalization{
	warnMortalWound	= "%s на |3-5(>%s<) (%s)",		-- Mortal Wound on >args.destName< (args.amount)
	specWarnTrap	= "Ловушка активирована! - приближаются Мстительные свежеватели"--creatureid 37038
}

L:SetOptionLocalization{
	specWarnTrap	= "Спец-предупреждение для активации ловушки",
	warnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "Скорей, нападем на них сзади!",
	FleshreaperTrap2		= "Вам не уйти от нас.",
	FleshreaperTrap3		= "Живые? Здесь?!"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "Треш-мобы Багрового зала"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Лорд Ребрад"
}

L:SetTimerLocalization{
	achievementBoned	= "Время до освобождения"
}

L:SetWarningLocalization{
	WarnImpale			= "Прокалывание: >%s<"
}

L:SetOptionLocalization{
	WarnImpale			= "Объявлять цели заклинания $spell:69062",
	achievementBoned	= "Отсчет времени для достижения Косточка попалась",
	SetIconOnImpale		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Леди Смертный Шепот"
}

L:SetTimerLocalization{
	TimerAdds	= "Призыв помощников"
}

L:SetWarningLocalization{
	WarnReanimating				= "Помощник воскрешается",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance		= "%s на |3-5(>%s<) (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon				= "Скоро призыв помощников",
	specWarnVengefulShade		= "Мстительный дух атакует вас - бегите"--creatureid 38222
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Предупреждать заранее о призыве помощников",
	WarnReanimating				= "Предупреждение при воскрешении помощников",											-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Отсчет времени до призыва помощников",
	specWarnVengefulShade		= "Спец-предупреждение, когда вас атакует Мстительный дух",--creatureid 38222
	ShieldHealthFrame			= "Показывать здоровье босса с индикатором здоровья для \n$spell:70842",
	WarnTouchInsignificance		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),	
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull				= "Как вы смеете ступать в эти священные покои? Это место станет вашей могилой!",
	YellReanimatedFanatic	= "Восстань и обрети истинную форму!",
	ShieldPercent			= "Барьер маны",--Translate Spell id 70842
	Fanatic1				= "Фанатик культа",
	Fanatic2				= "Кособокий фанатик",
	Fanatic3				= "Воскрешенный фанатик"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Боевой корабль"
}

L:SetWarningLocalization{
	WarnBattleFury	= "%s (%d)",
	WarnAddsSoon	= "Скоро призыв помощников"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "Battle Fury"),
	TimerCombatStart	= "Отсчет времени до начала боя",
	WarnAddsSoon		= "Предупреждать заранее о призыве помощников",
	TimerAdds			= "Отсчет времени до новых помощников"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Начало боя",
	TimerAdds			= "Призыв помощников"
}

L:SetMiscLocalization{
	PullAlliance	= "Запускайте двигатели! Летим навстречу судьбе.",
	KillAlliance	= "Ну не говорите потом, что я не предупреждал. В атаку, братья и сестры!",
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy! LOK'TAR OGAR!",
	KillHorde		= "The Alliance falter. Onward to the Lich King!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Саурфанг Смертоносный"
}

L:SetWarningLocalization{
	warnFrenzySoon	= "Скоро Бешенство"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Начало боя"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Отсчет времени до начала боя",
	warnFrenzySoon			= "Предупреждать о скором Бешенстве (на ~33%)",
	SetIconOnBoilingBlood	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	SetIconOnMarkCast		= "Устанавливать метки на цели заклинания $spell:72444\nво время его применения (экспериментально, может по ошибке\nпомечать танка)",
	RangeFrame				= "Показывать окно допустимой дистанции (12 м)",
	RunePowerFrame			= "Показывать здоровье босса + индикатор для $spell:72371"
}

L:SetMiscLocalization{
	RunePower			= "Сила крови",
	PullAlliance		= "Все павшие воины Орды, все дохлые псы Альянса – все пополнят армию Короля-лича. Даже сейчас валь'киры воскрешают ваших покойников, чтобы те стали частью Плети!",
	PullHorde			= "Kor'kron, move out! Champions, watch your backs! The Scourge have been..."
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Тухлопуз"
}

L:SetWarningLocalization{
	InhaledBlight		= "Гнилостные испарения в легких >%d<",
	WarnGastricBloat	= "%s на |3-5(>%s<) (%s)",		-- Gastric Bloat on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	InhaledBlight		= "Предупреждение для $spell:71912",
	RangeFrame			= "Показывать окно допустимой дистанции (8 м)",
	WarnGastricBloat	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72551, GetSpellInfo(72551) or "unknown"),	
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279)
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Гниломорд"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Малый слизнюк",
	WarnUnstableOoze			= "%s на |3-5(>%s<) (%s)",			-- Unstable Ooze on >args.destName< (args.amount)
	specWarnLittleOoze			= "Малый слизнюк атакует вас - бегите"--creatureid 36897
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "След. трубы для подачи ядовитой слизи"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "Отсчет времени до следующих труб для подачи ядовитой слизи",
	WarnOozeSpawn				= "Предупреждение при появлении Малого слизнюка",
	specWarnLittleOoze			= "Спец-предупреждение, когда вас атакует Малый слизнюк",--creatureid 36897
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown"),
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	ExplosionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69839)
}

L:SetMiscLocalization{
	YellSlimePipes1	= "Отличные новости, народ! Я починил трубы для подачи ядовитой слизи!",	-- Professor Putricide
	YellSlimePipes2	= "Отличные новости, народ! Слизь снова потекла!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Профессор Мерзоцид"
}

L:SetWarningLocalization{
	WarnPhase2Soon				= "Скоро фаза 2",
	WarnPhase3Soon				= "Скоро фаза 3",
	WarnMutatedPlague			= "%s на |3-5(>%s<) (%s)",	-- Mutated Plague on >args.destName< (args.amount)
	specWarnMalleableGoo		= "Вязкая гадость на вас - отбегите",
	specWarnMalleableGooNear	= "Вязкая гадость около вас - остерегайтесь"
}

L:SetOptionLocalization{
	WarnPhase2Soon				= "Предупреждать заранее о фазе 2 (на ~83%)",
	WarnPhase3Soon				= "Предупреждать заранее о фазе 3 (на ~38%)",
	specWarnMalleableGoo		= "Спец-предупреждение, когда Вязкая гадость на вас\n(работает только если вы - первая цель)",
	specWarnMalleableGooNear	= "Спец-предупреждение, когда Вязкая гадость около вас\n(работает только если вы около первой цели)",
	WarnMutatedPlague			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	MalleableGooIcon			= "Устанавливать метку на первую цель заклинания $spell:72295"
}

L:SetMiscLocalization{
	YellPull	= "Отличные новости, народ! Я усовершенствовал штамм чумы, которая уничтожит весь Азерот!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Кровавый Совет"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Смените цель на: %s",
	WarnTargetSwitchSoon	= "Скоро смена цели",
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Смена цели"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Предупреждение о смене цели",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Предупреждать заранее о смене цели",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Отсчет времени до смены цели",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Устанавливать метку на наполненного силой Принца (череп)"
}

L:SetMiscLocalization{
	Keleseth			= "Принц Келесет",
	Taldaram			= "Принц Талдарам",
	Valanar				= "Принц Валанар",
	EmpoweredFlames		= "Жаркое пламя тянется к (%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Королева Лана'тель"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkFallen			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838)
}

L:SetMiscLocalization{
	SwarmingShadows			= "Тени собираются и окружают (%S+)!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Валитрия Сноходица"
}

L:SetWarningLocalization{
	warnCorrosion	= "%s на |3-5(>%s<) (%s)"		-- Corrosion on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	warnCorrosion	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "unknown")
}

L:SetMiscLocalization{
	YellPull		= "Чужаки ворвались во внутренние покои. Уничтожьте зеленого дракона! Пусть останутся лишь кости и прах для воскрешения!",
	YellKill		= "Я ИЗЛЕЧИЛАСЬ! Изера, даруй мне силу покончить с этими нечестивыми тварями.",
	YellPortals		= "Я открыла портал в Изумрудный Сон. Там вы найдете спасение, герои...",
	YellPhase2		= "Силы возвращаются ко мне. Герои, еще немного!"--Need to confirm this is when adds spawn faster (phase 2) before used in mod
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Синдрагоса"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "След. воздушная фаза",
	TimerNextGroundphase	= "След. наземная фаза"
}

L:SetWarningLocalization{
	warnPhase2soon			= "Скоро фаза 2",
	WarnAirphase			= "Воздушная фаза",
	WarnGroundphaseSoon		= "Синдрагоса скоро приземлится",
	warnInstability			= "Неустойчивость >%d<",
	warnChilledtotheBone	= "Обморожение >%d<",
	warnMysticBuffet		= "Таинственная энергия >%d<"
}

L:SetOptionLocalization{
	WarnAirphase			= "Объявлять воздушную фазу",
	WarnGroundphaseSoon		= "Предупреждать заранее о наземной фазе",
	warnPhase2soon			= "Предупреждать заранее о фазе 2 (на ~38%)",
	TimerNextAirphase		= "Отсчет времени до следующей воздушной фазы",
	TimerNextGroundphase	= "Отсчет времени до следующей наземной фазы",
	warnInstability			= "Предупреждение о ваших стаках $spell:69766",
	warnChilledtotheBone	= "Предупреждение о ваших стаках $spell:70106",
	warnMysticBuffet		= "Предупреждение о ваших стаках $spell:70128",
	SetIconOnFrostBeacon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126)
}

L:SetMiscLocalization{
	YellAirphase	= "Здесь ваше вторжение и окончится! Никто не уцелеет.",
	YellPhase2		= "А теперь почувствуйте всю мощь господина и погрузитесь в отчаяние!",
	YellPull		= "Глупцы, зачем вы сюда явились! Ледяные ветра Нордскола унесут ваши души!"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "Король-лич"
}

L:SetWarningLocalization{
	WarnPhase2Soon			= "Скоро переход в фазу 2",
	WarnPhase3Soon			= "Скоро переход в фазу 3",
	specWarnDefileCast		= "Осквернение на вас - отбегите",
	specWarnDefileCastNear	= "Осквернение около вас - остерегайтесь"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Начало боя",
	PhaseTransition		= "Переходная фаза"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Отсчет времени до начала боя",
	PhaseTransition			= "Отсчет времени для переходной фазы",
	WarnPhase2Soon			= "Предупреждать заранее о переходе в фазу 2 (на ~73%)",
	WarnPhase3Soon			= "Предупреждать заранее о переходе в фазу 3 (на ~43%)",
	specWarnDefileCast		= "Спец-предупреждение, когда $spell:72762 на вас",
	specWarnDefileCastNear	= "Спец-предупреждение, когда $spell:72762 около вас",
	DefileIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912)
}

L:SetMiscLocalization{
	YellPull		= "So the Light's vaunted justice has finally arrived? Shall I lay down Frostmourne and throw myself at your mercy, Fordring?"
}