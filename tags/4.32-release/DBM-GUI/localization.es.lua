if GetLocale() ~= "esES" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods - Español"

L.TranslationBy 	= "Interplay"

L.TabCategory_Options 	= "Opciones"
L.TabCategory_WOTLK 	= "Wrath of the Lich King"
L.TabCategory_BC 	= "The Burning Crusade"
L.TabCategory_CLASSIC 	= "WoW Classic Bosses"
L.TabCategory_OTHER     = "Other Boss Mods"

L.BossModLoaded 	= "%s estadisticas"
L.BossModLoad_now 	= [[Este modulo no esta cargado. 
Si no se carga al entrar en la estancia. 
Puedes pulsar en el boton para cargar el modulo manualmente.]]

L.PosX = 'Posicion X'
L.PosY = 'Posicion Y'

L.MoveMe 		= 'mueve me'
L.Button_OK 		= 'Aceptar'
L.Button_Cancel 	= 'Cancelar'
L.Button_LoadMod 	= 'Cargar Modulo'
L.Mod_Enabled		= "Habilitar modulo de este boss"
L.Mod_EnableAnnounce	= "Avisar a raid"
L.Reset 		= "resetear"

L.Enable  		= "habilitar"
L.Disable		= "desabilitar"

L.NoSound		= "Sin sonido"

L.IconsInUse	= "Iconos usados por este mod"

-- Tab: Boss Statistics
L.BossStatistics	= "Estadisticas de Boss"
L.Statistic_Kills	= "Muertes:"
L.Statistic_Wipes	= "Wipes:"
L.Statistic_BestKill	= "Mejor muerte:"
L.Statistic_Heroic	= "heroico"

-- Tab: General Options
L.General 		= "Opciones de DBM"
L.EnableDBM 		= "Habilitar DBM"
L.EnableStatus 		= "Responder 'estado' a los que te susurren en raid"
L.AutoRespond 		= "Habilitar auto-responder si estas en un Boss"
L.EnableMiniMapIcon	= "Mostrar icono de DBM en el mapa"

L.Button_RangeFrame	= "Mostrar/Ocultar cuadro de rango"
L.Button_TestBars	= "Testear barras"

L.PizzaTimer_Headline 	= 'Crear "Cronomentro"'
L.PizzaTimer_Title	= 'Nombre (ej. "Pizza!")'
L.PizzaTimer_Hours 	= "Horas"
L.PizzaTimer_Mins 	= "Min"
L.PizzaTimer_Secs 	= "Seg"
L.PizzaTimer_ButtonStart = "Iniciar"
L.PizzaTimer_BroadCast	= "Anunciar a Raid"

-- Tab: Raidwarning
L.Tab_RaidWarning 	= "Avisos a raid"
L.RaidWarnColors 	= "Colores de Avisos a raid"
L.RaidWarnColor_1 	= "Color 1"
L.RaidWarnColor_2 	= "Color 2"
L.RaidWarnColor_3 	= "Color 3"
L.RaidWarnColor_4 	= "Color 4"
L.InfoRaidWarning	= [[Puedes especificar la posición y los colores del cuadro de advertencia de banda. 
Este marco se utiliza para mensajes como "El jugador X está afectado por Y"]]
L.ColorResetted 	= "Los ajustes de color de este campo se han reiniciado"
L.ShowWarningsInChat 	= "Mostrar avisos en el chat"
L.ShowFakedRaidWarnings = "Mostrar avisos en el chat de raid"
L.WarningIconLeft 	= "Mostrar icono en el lado izquierdo"
L.WarningIconRight 	= "Mostrar icono en el lado derecho"
L.RaidWarnMessage 	= "Gracias por usar Deadly Boss Mods - Español"
L.BarWhileMove 		= "Avisos de raid se pueden mover"
L.RaidWarnSound		= "Reproducir sonido para aviso-banda"
L.SpecialWarnSound	= "Reproducir sonido para aviso-especial"

-- Tab: Barsetup
L.BarSetup   = "Estilo de barra"
L.BarTexture = "Textura de barra"
L.BarStartColor = "Empieza con color"
L.BarEndColor = "Termina con color"
L.ExpandUpwards		= "Ampliar las barras hacia arriba"

L.Slider_BarOffSetX 	= "Desplazamiento X: %d"
L.Slider_BarOffSetY 	= "Desplazamiento Y: %d"
L.Slider_BarWidth 	= "Ancho de barra: %d"
L.Slider_BarScale 	= "Escala de barra: %0.2f"
L.AreaTitle_BarSetup 	= "Opciones de Barras"
L.AreaTitle_BarSetupSmall = "Barra de la derecha"
L.AreaTitle_BarSetupHuge = "Barra del medio"
L.BarIconLeft 		= "Icono izq."
L.BarIconRight 		= "Icono der."
L.EnableHugeBar 	= "Habilitar barra del medio (Bar 2)"
L.FillUpBars		= "Llénese Barras"
L.ClickThrough		= "Desabilitar acciones de raton ( si pulsas en las barras )"

-- Tab: Spam Filter
L.Panel_SpamFilter		= "Filtro de Spam"
L.Area_SpamFilter		= "Opciones de spam"
L.HideBossEmoteFrame		= "Esconder lo que dice el boss"
L.SpamBlockRaidWarning		= "Filtrar anuncios de otros Boss Mods" 
L.SpamBlockBossWhispers		= "Avisar por susurros spam de cada boss <DBM> "
L.BlockVersionUpdatePopup	= "Desabilitar actualizaciones"


L.ShowBigBrotherOnCombatStart	= "Perform Big Brother buff check on combat start"

