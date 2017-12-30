if GetLocale() ~= "ptBR" then return end
local L

-----------------------
-- <<<Black Rook Hold>>> --
-----------------------
-----------------------
-- The Amalgam of Souls --
-----------------------
L= DBM:GetModLocalization(1518)

-----------------------
-- Illysanna Ravencrest --
-----------------------
L= DBM:GetModLocalization(1653)

-----------------------
-- Smashspite the Hateful --
-----------------------
L= DBM:GetModLocalization(1664)

-----------------------
-- Lord Kur'talos Ravencrest --
-----------------------
L= DBM:GetModLocalization(1672)

-----------------------
--Black Rook Hold Trash
-----------------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name =	"Black Rook Hold Trash"
})

-----------------------
-- <<<Darkheart Thicket>>> --
-----------------------
-----------------------
-- Arch-Druid Glaidalis --
-----------------------
L= DBM:GetModLocalization(1654)

-----------------------
-- Oakheart --
-----------------------
L= DBM:GetModLocalization(1655)

-----------------------
-- Dresaron --
-----------------------
L= DBM:GetModLocalization(1656)

-----------------------
-- Shade of Xavius --
-----------------------
L= DBM:GetModLocalization(1657)

-----------------------
--Darkheart Thicket Trash
-----------------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name =	"Darkheart Thicket Trash"
})


-----------------------
-- <<<Eye of Azshara>>> --
-----------------------
-----------------------
-- Warlord Parjesh --
-----------------------
L= DBM:GetModLocalization(1480)

-----------------------
-- Lady Hatecoil --
-----------------------
L= DBM:GetModLocalization(1490)

L:SetWarningLocalization({
	specWarnStaticNova			= "Static Nova - move to land",
	specWarnFocusedLightning	= "Focused Lightning - move to water"
})

-----------------------
-- King Deepbeard --
-----------------------
L= DBM:GetModLocalization(1491)

-----------------------
-- Serpentrix --
-----------------------
L= DBM:GetModLocalization(1479)

-----------------------
-- Wrath of Azshara --
-----------------------
L= DBM:GetModLocalization(1492)

-----------------------
--Eye of Azshara Trash
-----------------------
L = DBM:GetModLocalization("EoATrash")

L:SetGeneralLocalization({
	name =	"Eye of Azshara Trash"
})

-----------------------
-- <<<Halls of Valor>>> --
-----------------------
-----------------------
-- Hymdall --
-----------------------
L= DBM:GetModLocalization(1485)

-----------------------
-- Hyrja --
-----------------------
L= DBM:GetModLocalization(1486)

-----------------------
-- Fenryr --
-----------------------
L= DBM:GetModLocalization(1487)

-----------------------
-- God-King Skovald --
-----------------------
L= DBM:GetModLocalization(1488)

-----------------------
-- Odyn --
-----------------------
L= DBM:GetModLocalization(1489)

L:SetMiscLocalization({
	tempestModeMessage		=	"Not tempest sequence: %s. Rechecking in 8 seconds."
})

-----------------------
--Halls of Valor Trash
-----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"Halls of Valor Trash"
})

-----------------------
-- <<<Neltharion's Lair>>> --
-----------------------
-----------------------
-- Rokmora --
-----------------------
L= DBM:GetModLocalization(1662)

-----------------------
-- Ularogg Cragshaper --
-----------------------
L= DBM:GetModLocalization(1665)

-----------------------
-- Naraxas --
-----------------------
L= DBM:GetModLocalization(1673)

-----------------------
-- Dargrul the Underking --
-----------------------
L= DBM:GetModLocalization(1687)

-----------------------
--Neltharion's Lair Trash
-----------------------
L = DBM:GetModLocalization("NLTrash")

L:SetGeneralLocalization({
	name =	"Neltharion's Lair Trash"
})

-----------------------
-- <<<The Arcway>>> --
-----------------------
-----------------------
-- Ivanyr --
-----------------------
L= DBM:GetModLocalization(1497)

-----------------------
-- Nightwell Sentry --
-----------------------
L= DBM:GetModLocalization(1498)

-----------------------
-- General Xakal --
-----------------------
L= DBM:GetModLocalization(1499)

L:SetMiscLocalization({
	batSpawn		=	"Reinforcements to me! NOW!"
})

-----------------------
-- Nal'tira --
-----------------------
L= DBM:GetModLocalization(1500)

-----------------------
-- Advisor Vandros --
-----------------------
L= DBM:GetModLocalization(1501)

-----------------------
--The Arcway Trash
-----------------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name =	"The Arcway Trash"
})

-----------------------
-- <<<Court of Stars>>> --
-----------------------
-----------------------
-- Patrol Captain Gerdo --
-----------------------
L= DBM:GetModLocalization(1718)

-----------------------
-- Talixae Flamewreath --
-----------------------
L= DBM:GetModLocalization(1719)

-----------------------
-- Advisor Melandrus --
-----------------------
L= DBM:GetModLocalization(1720)

-----------------------
--Court of Stars Trash
-----------------------
L = DBM:GetModLocalization("CoSTrash")

L:SetGeneralLocalization({
	name =	"Court of Stars Trash"
})

L:SetOptionLocalization({
	SpyHelper	= "Help identify the spy"
})

L:SetMiscLocalization({
	Gloves1			= "Alguém disse que o espião usa luvas para esconder cicatrizes.",
	Gloves2			= "Dizem que o espião fica escondendo as mãos.",
	Gloves3			= "Corre um boato de que o espião sempre usa luvas.",
	Gloves4			= "Ouvi dizer que o espião sempre usa luvas.",
	NoGloves1		= "Sabe de uma coisa... Encontrei um par de luvas lá atrás. Imagino que o espião esteja por aí de mãos nuas.",
	NoGloves2		= "Estão dizendo que o espião nunca usa luvas.",
	NoGloves3		= "Estão dizendo que o espião evita usar luvas, para o caso de precisar agir rapidamente.",
	NoGloves4		= "Ouvi dizer que o espião não gosta de usar luvas.",
	Cape1			= "Ouvi dizer que o espião gosta de usar capas.",
	Cape2			= "Alguém falou que o espião chegou mais cedo usando uma capa.",
	NoCape1			= "Ouvi dizer que o espião não gosta de capas e se recusa a usar uma.",
	NoCape2			= "Ouvi dizer que o espião deixou a capa no palácio antes de vir pra cá.",
	LightVest1		= "O espião definitivamente prefere coletes de cor clara.",
	LightVest2		= "Estão dizendo que o espião não está usando colete escuro hoje.",
	LightVest3		= "Ouvi dizer que o espião está usando um colete claro.",
	DarkVest1		= "O espião definitivamente prefere roupas escuras.",
	DarkVest2		= "Ouvi dizer que as vestes do espião têm um tom escuro e rico esta noite.",
	DarkVest3		= "Corre um boato que o espião evitou roupas de cores claras para não chamar a atenção.",
	DarkVest4		= "O espião gosta de coletes escuros... como a noite.",
	Female1			= "Ouvi falar que uma mulher está fazendo várias perguntas sobre o distrito...",
	Female2			= "Um convidado viu ela e Elisande chegarem juntas.",
	Female3			= "Tem gente dizendo que é uma nova convidada, e não convidado.",
	Female4			= "Dizem que a espiã está aqui e que ela é um colírio para os olhos.",
	Male1			= "Ouvi dizer que o espião está aqui e é muito bonito.",
	Male2			= "Ouvi dizer por aí que o espião não é uma mulher.",
	Male3			= "Um dos músicos disse que ele não parava de perguntar sobre o distrito.",
	Male4			= "Um convidado disse que o viu entrando na mansão ao lado da Grã-magistra.",
	ShortSleeve1	= "Uma amiga minha disse que viu a roupa espião. Não tinha mangas longas.",
	ShortSleeve2	= "Alguém me disse que o espião odeia mangas compridas.",
	ShortSleeve3	= "Dizem que o espião usa mangas curtas para manter os braços livres.",
	ShortSleeve4	= "Ouvi dizer que o espião gosta de ar fresco e não está usando mangas compridas.",
	LongSleeve1 	= "Alguém me disse que o espião está cobrindo os braços com mangas compridas.",
	LongSleeve2 	= "Ouvi dizer que a roupa do espião é de manga comprida.",
	LongSleeve3 	= "Um amigo meu disse que o espião está de mangas compridas.",
	LongSleeve4 	= "Eu mal consegui espiar as mangas compridas do espião.",
	Potions1		= "Disseram que o espião trouxe poções, por que será?",
	Potions2		= "Disseram que o espião trouxe algumas poções... só por garantia.",
	Potions3		= "Eu não lhe disse nada... mas o espião está disfarçado de alquimista, carregando poções no cinto.",
	Potions4		= "Tenho certeza de que o espião tem poções no cinto.",
	NoPotions1		= "Disseram que o espião não está carregando poções.",
	NoPotions2		= "Uma musicista me contou que viu o espião jogar fora a última poção que tinha. Agora ele não tem mais nenhuma.",
	Book1			= "Corre um boato de que o espião adora ler e sempre carrega pelo menos um livro.",
	Book2			= "Soube que o espião sempre carrega um caderno de segredos no cinto.",
	Pouch1			= "Ouvi dizer que a pochete do espião é forrada com fios finos.",
	Pouch2			= "Ouvi dizer que a pochete do espião está cheia de ouro para mostrar extravagância.",
	Pouch3			= "Um amigo disse que o espião ama ouro e uma pochete bem cheia disso.",
	Pouch4			= "Ouvi dizer que o espião sempre anda com uma bolsa mágica.",
	--
	Gloves		= "gloves",
	NoGloves	= "no gloves",
	Cape		= "cape",
	Nocape		= "no cape",
	LightVest	= "light vest",
	DarkVest	= "dark vest",
	Female		= "female",
	Male		= "male",
	ShortSleeve = "short sleeves",
	LongSleeve	= "long sleeves",
	Potions		= "potions",
	NoPotions	= "no potions",
	Book		= "book",
	Pouch		= "pouch"
})


-----------------------
-- <<<The Maw of Souls>>> --
-----------------------
-----------------------
-- Ymiron, the Fallen King --
-----------------------
L= DBM:GetModLocalization(1502)

-----------------------
-- Harbaron --
-----------------------
L= DBM:GetModLocalization(1512)

-----------------------
-- Helya --
-----------------------
L= DBM:GetModLocalization(1663)

-----------------------
--Maw of Souls Trash
-----------------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name =	"Maw of Souls Trash"
})

-----------------------
-- <<<Assault Violet Hold>>> --
-----------------------
-----------------------
-- Mindflayer Kaahrj --
-----------------------
L= DBM:GetModLocalization(1686)

-----------------------
-- Millificent Manastorm --
-----------------------
L= DBM:GetModLocalization(1688)

-----------------------
-- Festerface --
-----------------------
L= DBM:GetModLocalization(1693)

-----------------------
-- Shivermaw --
-----------------------
L= DBM:GetModLocalization(1694)

-----------------------
-- Blood-Princess Thal'ena --
-----------------------
L= DBM:GetModLocalization(1702)

-----------------------
-- Anub'esset --
-----------------------
L= DBM:GetModLocalization(1696)

-----------------------
-- Sael'orn --
-----------------------
L= DBM:GetModLocalization(1697)

-----------------------
-- Fel Lord Betrug --
-----------------------
L= DBM:GetModLocalization(1711)

-----------------------
--Assault Violet Hold Trash
-----------------------
L = DBM:GetModLocalization("AVHTrash")

L:SetGeneralLocalization({
	name =	"Assault Violet Hold Trash"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "New portal soon",
	WarningPortalNow	= "Portal #%d",
	WarningBossNow		= "Boss incoming"
})

L:SetTimerLocalization({
	TimerPortal			= "Portal CD"
})

L:SetOptionLocalization({
	WarningPortalNow		= "Show warning for new portal",
	WarningPortalSoon		= "Show pre-warning for new portal",
	WarningBossNow			= "Show warning for boss incoming",
	TimerPortal				= "Show timer for next portal (after Boss)"
})

L:SetMiscLocalization({
	Malgath		=	"Lord Malgath"
})

-----------------------
-- <<<Vault of the Wardens>>> --
-----------------------
-----------------------
-- Tirathon Saltheril --
-----------------------
L= DBM:GetModLocalization(1467)

-----------------------
-- Inquisitor Tormentorum --
-----------------------
L= DBM:GetModLocalization(1695)

-----------------------
-- Ash'golm --
-----------------------
L= DBM:GetModLocalization(1468)

-----------------------
-- Glazer --
-----------------------
L= DBM:GetModLocalization(1469)

-----------------------
-- Cordana --
-----------------------
L= DBM:GetModLocalization(1470)

-----------------------
--Vault of Wardens Trash
-----------------------
L = DBM:GetModLocalization("VoWTrash")

L:SetGeneralLocalization({
	name =	"Vault of Wardens Trash"
})

-----------------------
-- <<<Return To Karazhan>>> --
-----------------------
-----------------------
-- Maiden of Virtue --
-----------------------
L= DBM:GetModLocalization(1825)

-----------------------
-- Opera Hall: Wikket  --
-----------------------
L= DBM:GetModLocalization(1820)

-----------------------
-- Opera Hall: Westfall Story --
-----------------------
L= DBM:GetModLocalization(1826)

-----------------------
-- Opera Hall: Beautiful Beast  --
-----------------------
L= DBM:GetModLocalization(1827)

-----------------------
-- Attumen the Huntsman --
-----------------------
L= DBM:GetModLocalization(1835)

-----------------------
-- Moroes --
-----------------------
L= DBM:GetModLocalization(1837)

-----------------------
-- The Curator --
-----------------------
L= DBM:GetModLocalization(1836)

-----------------------
-- Shade of Medivh --
-----------------------
L= DBM:GetModLocalization(1817)

-----------------------
-- Mana Devourer --
-----------------------
L= DBM:GetModLocalization(1818)

-----------------------
-- Viz'aduum the Watcher --
-----------------------
L= DBM:GetModLocalization(1838)

-----------------------
--Nightbane
-----------------------
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization({
	name =	"Nightbane"
})

-----------------------
--Return To Karazhan Trash
-----------------------
L = DBM:GetModLocalization("RTKTrash")

L:SetGeneralLocalization({
	name =	"Return To Karazhan Trash"
})

L:SetMiscLocalization({
	speedRun		=	"The strange chill of a dark presence winds through the air..."
})

-----------------------
-- <<<Cathedral of Eternal Night >>> --
-----------------------
-----------------------
-- Agronox --
-----------------------
L= DBM:GetModLocalization(1905)

-----------------------
-- Trashbite the Scornful  --
-----------------------
L= DBM:GetModLocalization(1906)

-----------------------
-- Domatrax --
-----------------------
L= DBM:GetModLocalization(1904)

-----------------------
-- Mephistroth  --
-----------------------
L= DBM:GetModLocalization(1878)

-----------------------
--Cathedral of Eternal Night Trash
-----------------------
L = DBM:GetModLocalization("CoENTrash")

L:SetGeneralLocalization({
	name =	"Cathedral of Eternal Night Trash"--Maybe something shorter?
})

