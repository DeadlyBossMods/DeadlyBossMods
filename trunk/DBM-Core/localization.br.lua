if GetLocale() ~= "ptBR" then return end

DBM_CORE_NEED_SUPPORT				= "Are you good with programming or languages? If yes, the DBM team needs your help to keep DBM the best boss mod for WoW. Join the team by visiting http://forums.elitistjerks.com/topic/132449-dbm-localizers-needed/"
DBM_HOW_TO_USE_MOD					= "Bem vindo ao DBM. Digite /dbm help para obter uma lista dos comandos disponíveis. Para acessar as opções, digite /dbm no seu chat para começar a configuração. Carrege zonas específicas manualmente para configurar opções específicas de cada chefe para o seu gosto pessoal. O DBM tenta fazer isso automaticamente para você, observando sua spec na primeira vez que é executado. De qualquer forma, você pode querer habilitar outras opções."

DBM_CORE_LOAD_MOD_ERROR				= "Erro ao carregar módulo %s: %s "
DBM_CORE_LOAD_MOD_SUCCESS			= "Módulo '%s' carregado. Para mais opções, digite /dbm ou /dbm help no chat"
DBM_CORE_LOAD_GUI_ERROR				= "Não foi possível carregar interface gráfica: %s"

DBM_CORE_COMBAT_STARTED				= "%s na mira. Divirta-se e boa sorte! :)"
DBM_CORE_BOSS_DOWN					= "%s derrotado após %s!"
DBM_CORE_BOSS_DOWN_L				= "%s derrotado após %s! Sua última vitória levou %s, sua vitória mais rápida %s. Você tem um total de %d vitórias."
DBM_CORE_BOSS_DOWN_NR				= "%s derrotado após %s! Esse é um novo récorde! (Récorde antigo era %s). Você tem um total de %d vitórias."
DBM_CORE_COMBAT_ENDED_AT			= "Combate contra %s (%s) encerrado após %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Combate contra %s (%s) encerrado após %s. Você tem um total de %d derrotas nessa dificuldade."
DBM_CORE_COMBAT_STATE_RECOVERED		= "Luta contra %s começou %s atrás, reajustando cronógrafos..."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4segundo:segundos;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minuto:minutos;"
DBM_CORE_TIMER_FORMAT				= "%d |4minuto:minutos; and %d |4segundo:segundos;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "seg"
DBM_CORE_SEC_FMT					= "%s seg"
DBM_CORE_DEAD						= "morto"
DBM_CORE_OK							= "Ok"

DBM_CORE_GENERIC_WARNING_BERSERK	= "Berserk in %s %s" --TODO
DBM_CORE_GENERIC_TIMER_BERSERK		= "Berserk" --TODO
DBM_CORE_OPTION_TIMER_BERSERK		= "Exibir cronógrafo para $spell:26662"
DBM_CORE_OPTION_HEALTH_FRAME		= "Exibir quadro de vida do chefe"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Barras"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Anúncios"
DBM_CORE_OPTION_CATEGORY_MISC		= "Diversos"

DBM_CORE_AUTO_RESPONDED						= "Respondido automaticamente"
DBM_CORE_STATUS_WHISPER						= "%s: %s, %d/%d pessoas vivas"
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s está ocupado lutando contra %s (%s, %d/%d pessoas vivas)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s derrotou %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s derrotou %s! Ele tem um total de %d vitórias."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s foi derrotado por %s em %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s foi derrotado por %s em %s. Ele tem um total de %d derrotas nessa dificuldade."

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versões"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM não instalado"
DBM_CORE_VERSIONCHECK_FOOTER		= "Encontrados %d jogadores com Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Sua versão do Deadly Boss Mods está desatualizada. Por favor, acesse www.deadlybossmods.com para baixar a versão mais recente."

DBM_CORE_UPDATEREMINDER_HEADER		= "Sua versão do Deadly Boss Mods está desatualizada.\n A versão %s (r%d) está disponível para baixar aqui:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Pressione Ctrl+C para copiar o link de download para a área de transferência."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Exibir pop-up quando houver uma nova versão disponível"

DBM_CORE_MOVABLE_BAR				= "Arraste-me!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h te enviou um cronógrafo do DBM: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancelar esse cronógrafo]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorar cronógrafos de %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Você tem certeza de que realmente deseja ignorar cronógrafos de %s até o fim desta sessão?"
DBM_PIZZA_ERROR_USAGE				= "Uso: /dbm [broadcast] timer <tempo> <texto>"

--DBM_CORE_MINIMAP_TOOLTIP_HEADER (Same as English locales)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Use shift+click ou clique com o botão direito para mover\nUse alt+shift+click para arrastar livremente"

DBM_CORE_RANGECHECK_HEADER			= "Medir distância: (%d m)"
DBM_CORE_RANGECHECK_SETRANGE		= "Definir distância"
DBM_CORE_RANGECHECK_SOUNDS			= "Sons"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Soar quando um jogador entrar na distância"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Soar quando mais de um jogador entrar na distância"
DBM_CORE_RANGECHECK_SOUND_0			= "Sem som"
DBM_CORE_RANGECHECK_SOUND_1			= "Som padrão"
DBM_CORE_RANGECHECK_SOUND_2			= "Bip irritante"
DBM_CORE_RANGECHECK_HIDE			= "Esconder"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d m"
DBM_CORE_RANGECHECK_LOCK			= "Travar posição"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Quadros"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Mostrar quadro do radar"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Mostrar quadro de texto"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Mostrar ambos"
DBM_CORE_RANGECHECK_OPTION_SPEED	= "Taxa de atualização (Necessário recarregar)"
DBM_CORE_RANGECHECK_OPTION_SLOW		= "Lenta (menor uso de CPU)"
DBM_CORE_RANGECHECK_OPTION_AVERAGE	= "Média"
DBM_CORE_RANGECHECK_OPTION_FAST		= "Rápida (Melhor velocidade de resposta)"
DBM_CORE_RANGERADAR_HEADER			= "Radar (%d m)"

DBM_CORE_INFOFRAME_LOCK				= "Travar posição"
DBM_CORE_INFOFRAME_HIDE				= "Esconder"
DBM_CORE_INFOFRAME_SHOW_SELF		= "Sempre exibir seu poder"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "Aceitar convite"

DBM_CORE_SLASHCMD_HELP				= {
	"Comandos disponíveis:",
	"/dbm version: Realiza uma checagem de versão de toda a raide. (ou: ver).",
--	"/dbm version2: Performs a raid-wide version check and whispers members who are out of date (alias: ver2).",
	"/dbm unlock: Exibe uma barra de cronógrafo móvel. (ou: move).",
	"/dbm timer <x> <texto>: Inicia um cronógrafo de <x> segundos com o nome <texto>.",
	"/dbm broadcast timer <x> <texto>: Espalha um cronógrafo de <x> segundos com o nome <texto> para a raide (requer status de líder/guia).",
	"/dbm break <min>: Inicia um cronógrafo de invervalo de <min> minutos. Dá a todos os integrantes da raide um cronógrafo de intervalo (requer status de líder/guia).",
	"/dbm pull <seg>: Dispara um cronógrafo para iniciar a luta em <seg> segundos. Dá a todos os integrantes da raide um cronógrafo para iniciar a luta (requer status de líder/guia).",
	"/dbm arrow: Exibe a seta do DBM, veja /dbm arrow help para detalhes.",
	"/dbm lockout: Pergunta a todos os membros da raid, por seus vínculos de raide (ou: lockouts, ids) (requer status de líder/guia)..",
	"/dbm help: Exibe essa mensagem."
}

DBM_ERROR_NO_PERMISSION				= "Você não tem as permissões necessárias para fazer isso."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Esconder quadro de vida"

DBM_CORE_ALLIANCE					= "Aliança"
DBM_CORE_HORDE						= "Horda"

DBM_CORE_UNKNOWN					= "desconhecido"

DBM_CORE_BREAK_START				= "Intervalo começando agora -- você tem %s minuto(s)!"
DBM_CORE_BREAK_MIN					= "Intervalo encerra-se em %s minuto(s)!"
DBM_CORE_BREAK_SEC					= "Intervalo encerra-se em %s segundos!"
DBM_CORE_TIMER_BREAK				= "Intervalo!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "O intervalo acabou"

DBM_CORE_TIMER_PULL					= "Puxando em"
DBM_CORE_ANNOUNCE_PULL				= "Puxando em %d seg"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Puxando agora!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Morte rápida." -- This will do, but far from perfect

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s acaba" --Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades			= "%s desvanece" --Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.cd			= "%s recarrega"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "%s recarrega (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource		= "%s recarrega: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.next			= "Próx. %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount		= "Próx. %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "Próx %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target		= "Exibir cronógrafo para a penalidade $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cast		= "Exibir cronógrafo para lançar $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.active		= "Exibir cronógrafo para a duração de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Exibir cronógrafo para quando $spell:%s desvanecerá dos jogadores"
DBM_CORE_AUTO_TIMER_OPTIONS.cd			= "Exibir cronógrafo para recarga de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount		= "Exibir cronógrafo para recarga de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Exibir cronógrafo para recarga de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.next		= "Exibir cronógrafo para o próximo $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount	= "Exibir cronógrafo para o próximo $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Exibir cronógrafo para o próximo $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement	= "Exibir cronógrafo para %s"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target			= "%s em >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%d) em >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell			= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds			= "%s restantes: %%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast			= "Lançando %s: %.1f seg"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon			= "%s em breve"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn		= "%s em %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase			= "Fase %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase		= "Fase %s em breve"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count			= "%s (%%d)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack			= "%s em >%%s< (%%d)"

local prewarnOption = "Exibir aviso antecipado para $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "Anunciar alvos de $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Anunciar alvos de $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell		= "Exibir aviso para $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds			= "Announce how many $spell:%s remain"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast			= "Exibir aviso quando $spell:%s está sendo lançado"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon			= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase		= "Anunciar Fase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase		= "Mostrar aviso antecipado para a Fase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "Exibir aviso para $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack		= "Anunciar empilhamento de $spell:%s"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 		= "Exibir aviso especial para $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 		= "Exibir aviso especial para remover/roubar $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "Exibir aviso especial para interromper $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 		= "Exibir aviso especial quando você é afetado por $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 		= "Exibir aviso especial quando alguém é afetador por $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 		= "Exibir aviso especial quando alguém próximo de você é afetado por $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 		= "Exibir aviso especial quando você é afetado por $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge 		= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move--FIXME (this is a temp until localized properly as a dodge warning)
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 		= "Exibir aviso especial para $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 		= "Exibir aviso especial para o lançamento de $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 		= "Exibir aviso especial para pilha >=%d de $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch		= "Exibir aviso especial para mudar de alvo para $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount = DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount = DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell		= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel	= "%s em >%%s< - remova agora"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt	= "%s - interrompa >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - interrompa >%%s< (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you		= "%s em você"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target	= "%s em >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close		= "%s em >%%s< perto de você"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move		= "%s - saia de perto"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge 	= DBM_CORE_AUTO_SPEC_WARN_TEXTS.move--FIXME (this is a temp until localized properly as a dodge warning)
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run		= "%s - corra para longe"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast		= "%s - pare de lançar"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack		= "%s (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch	= ">%s< - mude de alvo"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount	= ">%s< - mude de alvo (%%d)"


DBM_CORE_AUTO_ICONS_OPTION_TEXT		= "Colocar ícones nos alvos de $spell:%s"
DBM_CORE_AUTO_SOUND_OPTION_TEXT		= "Tocar som \"Fuja garotinha\" para $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT	= "Tocar som de contagem regressiva para $spell:%s"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT	= "Tocar som de contagem regressiva para duração de $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT		= "Gritar quando você é afetado por $spell:%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT	= "%s em " .. UnitName("player") .. "!"


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Aviso especial móvel"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Aviso especial"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "Medição de distância de %d metros não suportada nessa zona.\nAs distâncias suportadas são 10, 11, 15 e 28 metros."

DBM_ARROW_MOVABLE					= "Seta móvel"
DBM_ARROW_ERROR_USAGE	= {
	"Uso da seta do DBM:",
	"/dbm arrow <x> <y>  cria uma seta que aponta para um local específico (0 < x/y < 100)",
	"/dbm arrow <jogador>  cria uma seta que aponta para um jogador específico no seu grupo",
	"/dbm arrow hide  esconde a seta",
	"/dbm arrow move  torna móvel a seta"
}

DBM_SPEED_KILL_TIMER_TEXT	= "Vitória em tempo récorde"
DBM_SPEED_KILL_TIMER_OPTION	= "Exibir cronógrafo para bater sua vitória mais rápida"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s solicitou suas IDs de instância e progresso atuais.\nVocê deseja enviar essa informação para %s? Ele(a) poderá requisitar essa informação durante a sessão atual (i. e. até que você reconecte)."
DBM_ERROR_NO_RAID					= "Você precisa estar em um grupo de raide para utilizar essa funcionalidade."
DBM_INSTANCE_INFO_REQUESTED			= "Enviadas requisições de vínculos de raide para o grupo.\nPor favor, note que a permissão dos usuários será solicitada antes de os dados serem enviados para você, portanto pode levar um minuto para que você receba todas as respostas."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Recebidas respostas de %d jogadores de um total de %d usuários do DBM: %d enviaram os dados, %d negaram a solicitação. Esperando mais %d segundos pelas respostas restantes..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Recebidas respostas de tosos os membros da raide"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Sender: %s ResultType: %s InstanceName: %s InstanceID: %s Difficulty: %d Size: %d Progress: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, dificuldade %s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, progresso %d: %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    progresso %d: %s"
DBM_INSTANCE_INFO_STATS_DENIED		= "Negou a solicitação: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Ausente: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Não possui uma versão recente do DBM instalada: %s"
DBM_INSTANCE_INFO_RESULTS			= "Resultados da busca por  IDs de raid. Note que instâncias podem aparecer mais de uma vez, se houver jogadores com clientes de WoW em outra língua."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Jogadores que ainda não responderam: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Exibir resultados agora]|r|h"
