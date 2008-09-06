local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan 10")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetMiscLocalization({
	yell1 = "Which one shall I eat first? So difficult to choose. They all smell so delicious...", 
	yell2 = "There is no way out.",
	yell3 = "Just a little taste...",
	yell4 = "Yes, run! It makes the blood pump faster!"
})

L:SetWarningLocalization({
	SpecialLocust		= "Locust Swarm!",
	WarningLocustSoon	= "Locust Swarm in 15 sec",
	WarningLocustNow	= "Locust Swarm!",
	WarningLocustFaded	= "Locust Swarm faded"
})

L:SetTimerLocalization({
	TimerLocustIn	= "Locust Swarm", 
	TimerLocustFade = "Locust Swarm active"
})

L:SetOptionLocalization({
	SpecialLocust		= "Show special warning for Locust Swarm",
	WarningLocustSoon	= "Show Locust Swarm pre-warning",
	WarningLocustNow	= "Show Locust Swarm warning",
	WarningLocustFaded	= "Show Locust Swarm fade warning",
	TimerLocustIn		= "Show Locust Swarm timer", 
	TimerLocustFade 	= "Show Locust Swarm timer"
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina 10")

L:SetGeneralLocalization({
	name = "Grand Widow Faerlina"
})

L:SetMiscLocalization({
	yell1 = "You cannot hide from me!",
	yell2 = "Run while you still can!",
	yell3 = "Kneel before me, worm!",
})


---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna 10")

L:SetGeneralLocalization({
	name = "Maexxna"
})

L:SetWarningLocalization({
	WarningWebWrap		= "Web Wrap: >%s<",
	WarningWebSpraySoon	= "Web Spray in 5 sec",
	WarningWebSprayNow	= "Web Spray!",
	WarningSpidersSoon	= "Spiders in 5 sec",
	WarningSpidersNow	= "Spiders spawned!"
})

L:SetTimerLocalization({
	TimerWebSpray	= "Web Spray",
	TimerSpider		= "Spiders"
})

L:SetOptionLocalization({
	WarningWebWrap		= "Announce Web Wrap targets",
	WarningWebSpraySoon	= "Show Web Spray pre-warning",
	WarningWebSprayNow	= "Show Web Spray warning",
	WarningSpidersSoon	= "Show Spider pre-warning",
	WarningSpidersNow	= "Show Spider warning",
	TimerWebSpray		= "Show Web Spray timer",
	TimerSpider			= "Show Spider timer"
})


---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb 10")

L:SetGeneralLocalization({
	name = "Loatheb"
})

L:SetWarningLocalization({
	WarningSporeNow		= "Spore spawned!",
	WarningSporeSoon	= "Spore in 5 sec"
})

L:SetTimerLocalization({

})

L:SetOptionLocalization({

})
