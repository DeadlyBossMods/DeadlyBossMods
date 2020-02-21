if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------------------
-- Campeona de la Luz --
------------------------
--L= DBM:GetModLocalization(2344)--Ra'wani Kanae (Alianza)

--L= DBM:GetModLocalization(2333)--Frida Fuelleférreo (Horda)

-----------
-- Grong --
-----------
--L= DBM:GetModLocalization(2325)--Rey Grong (Horda)

--L= DBM:GetModLocalization(2340)--Grong el Resucitado (Alianza)

----------------------------
-- Maestros Fuego de Jade --
----------------------------
--L= DBM:GetModLocalization(2323)--Ma'ra Colmillosiniestro y Anathos Clamafuegos (Alianza)

--L= DBM:GetModLocalization(2341)--Manceroy Puñoígneo y Mestrah la Iluminada (Horda)

---------------
-- Opulencia --
---------------
L= DBM:GetModLocalization(2342)

L:SetMiscLocalization({
	Bulwark =	"Baluarte",
	Hand	=	"Mano"
})

------------------------------
-- Cónclave de los Elegidos --
------------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"Si tantah ganah tieneh de morir, ¡deberíah haber venido anteh!",
	BwonsamdiWrath2 =	"Anteh o dehpuéh... ¡todoh me sirven!",
	Bird			 =	"Pa'ku"
})

-------------------
-- Rey Rastakhan --
-------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "Mostrar avisos generales del reino de la muerte si te encuentras en el de los vivos, y viceversa (esta opción no afecta a los temporizadores, los cuales se muestran siempre)"
})

-------------------------------
-- Manitas mayor Mekkatorque --
-------------------------------
--L= DBM:GetModLocalization(2332)

----------------------------
-- Bloqueo de la tormenta --
----------------------------
--L= DBM:GetModLocalization(2337)

-------------------------
-- Lady Jaina Valiente --
-------------------------
L= DBM:GetModLocalization(2343)

L:SetOptionLocalization({
	ShowOnlySummary2	= "Mostrar solo la cantidad de jugadores cercanos en la comprobación de distancia en lugar de listar sus nombres",
	InterruptBehavior	= "Patrón de interrupción para el elemental (sobrescribe la configuración del resto de jugadores si eres el líder de banda)",
	Three				= "Rotación de tres jugadores",--Default
	Four				= "Rotación de cuatro jugadores",
	Five				= "Rotación de cinco jugadores",
	SetWeather			= "Bajar automáticamente la densidad del clima al mínimo al iniciar el encuentro (se restaurará a su configuración anterior al terminar el combate)"
})

L:SetMiscLocalization({
	Port			=	"babor",
	Starboard		=	"estribor",
	Freezing		=	"Congelación en %s"
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
