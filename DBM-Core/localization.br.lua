-- Last update by GlitterStorm @ Azralon on Feb,28th,2015
if GetLocale() ~= "ptBR" then return end

DBM_CORE_NEED_SUPPORT				= "Are you good with programming or languages? If yes, the DBM team needs your help to keep DBM the best boss mod for WoW. Join the team by visiting http://forums.elitistjerks.com/topic/132449-dbm-localizers-needed/"
DBM_HOW_TO_USE_MOD					= "Bem vindo ao DBM. Digite /dbm help para obter uma lista dos comandos disponíveis. Para acessar as opções, digite /dbm no seu chat para começar a configuração. Carregue zonas específicas manualmente para configurar opções específicas de cada chefe para o seu gosto pessoal. O DBM tenta fazer isso automaticamente para você, observando sua spec na primeira vez que é executado. De qualquer forma, você pode querer habilitar outras opções."

DBM_FORUMS_MESSAGE					= "Achou um bug, tradução ruim ou temporizadores de chefes incorretos? Acha que alguma mod de chefe precisa de aviso adicional, temporizador ou recurso especial? me mande por correio se for de Azralon @ GlitterStorm ou \nVisit the new Deadly Boss Mods discussion, bug report and feature request forums at |HDBM:forums|h|cff3588ffhttp://www.deadlybossmods.com|r (you can click the link to copy the URL)"
DBM_FORUMS_COPY_URL_DIALOG			= "Come visit our discussion and support forums\r\n(hosted by Elitist Jerks!)"

DBM_CORE_LOAD_MOD_ERROR				= "Erro ao carregar módulo %s: %s "
DBM_CORE_LOAD_MOD_SUCCESS			= "Módulo '%s' carregado. Para mais opções, digite /dbm ou /dbm help no chat"
DBM_CORE_LOAD_MOD_COMBAT			= "Carregamento de '%s' adiado até que você saia de combate"
DBM_CORE_LOAD_GUI_ERROR				= "Não foi possível carregar interface gráfica: %s"
DBM_CORE_LOAD_GUI_COMBAT			= "A interface gráfica não pode ser carregada em combate e será assim que você o sair. Quando estiver carregada, você poderá chama-la em combate."
DBM_CORE_LOAD_SKIN_COMBAT			= "Os DBM temporizadores falharam em aparecer em combate e provavelmente funcionarão incorretamente, além de gerar diversos erros no lua. Isso ocorre geralmente por tentativas de mods de terceiros aplicando skins em combate. Recomendamos que você use o comando /reloadui assim que sair de combate."
DBM_CORE_BAD_LOAD					= "DBM detectou que a sua mod desta área falhou ao tentar carregar por completo por estar em combate. Use o comando /reloadui assim que sair de combate para corrigir o problema."
DBM_CORE_LOAD_MOD_VER_MISMATCH		= "%s não foi carregado por não cumprir os requerimentos. Uma atualização da mod é necessária. Obrigado."

DBM_CORE_BLIZZ_BUGS					= "Blizzard mudanças para addons na 6.0:\n1. Caso você jogue com efeitos sonoros habilitados, poderá 'perder' os de addons em combate, se os mesmos excederem o numero máximo de canais de sons. Para tentar corrigir isso, DBM agora força os canais de sons em 64, caso o perda de sim persista a única solução e desabilitar efeitos sonoros por completo."

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "DBM desabilitou o quadro de alcance dinâmico nesta luta, por falta de informação sobre o numero de jogadores à ficarem amontoados para um grupo desse tamanho."

DBM_CORE_DYNAMIC_ADD_COUNT			= "DBM desabilitou aviso da contagem de adds nesta luta, por falta de informação da quantidade de adds para um grupo deste tamanho."
DBM_CORE_DYNAMIC_MULTIPLE			= "DBM desabilitou varias funções desta luta por causa da falta de informação sobre certas mecânicas para um grupo deste tamanho."

DBM_CORE_LOOT_SPEC_REMINDER			= "A sua especialização atual é %s. A sua escolha atual de loot é %s."

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM detectou que você tem ícones habilitados tanto no BigWigs quanto no DBM. Por favor desabilite um dos dois para evitar conflitos com o líder da raid"

DBM_CORE_PROVINGGROUNDS_AD			= "DBM-ProvingGrounds esta disponível para este conteúdo. Esta disponível em deadlybossmods.com ou no site da curse. Está mensagem só será exibida uma vez."

DBM_CORE_MOLTENCORE_AD				= "DBM-MC esta disponível para este conteúdo. Esta disponível em deadlybossmods.com. Está mensagem só será exibida uma vez."

DBM_CORE_COMBAT_STARTED				= "%s na mira. Boa sorte e divirta-se! :)"

DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "Entrando em uma luta em progresso contra %s. Boa sorte e divirta-se! :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "%s engrenou em combate com a Guild"
DBM_CORE_SCENARIO_STARTED			= "%s começou. Boa sorte e divirta-se! :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	= "Juntando-se à %s em progresso. Boa sorte e divirta-se! :)"
DBM_CORE_BOSS_DOWN					= "%s derrotado após %s!"
DBM_CORE_BOSS_DOWN_I				= "%s derrotado! você tem %d vitorias no total."
DBM_CORE_BOSS_DOWN_L				= "%s derrotado após %s! Sua última vitória levou %s, sua vitória mais rápida %s. Você tem um total de %d vitórias."
DBM_CORE_BOSS_DOWN_NR				= "%s derrotado após %s! Esse é um novo recorde! (Recorde antigo era %s). Você tem um total de %d vitórias."
DBM_CORE_GUILD_BOSS_DOWN			= "%s foi derrotado pela guild após %s!"
DBM_CORE_SCENARIO_COMPLETE			= "%s completado após %s!"
DBM_CORE_SCENARIO_COMPLETE_I		= "%s completado! Você tem %d vitórias no total."
DBM_CORE_SCENARIO_COMPLETE_L		= "%s completado após %s! A sua ultima vitória demorou %s e a mais rápida %s. Você tem %d vitórias no total."
DBM_CORE_SCENARIO_COMPLETE_NR		= "%s completado após %s! Esse é o seu novo recorde! (Ultimo recorde era %s). Você tem %d vitórias no total."
DBM_CORE_COMBAT_ENDED_AT			= "Combate contra %s (%s) encerrado após %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Combate contra %s (%s) encerrado após %s. Você tem um total de %d derrotas nessa dificuldade."
DBM_CORE_GUILD_COMBAT_ENDED_AT		= "Guild foi derrotada por %s (%s) após %s."
DBM_CORE_SCENARIO_ENDED_AT			= "%s finalizado após %s."
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s finalizado após %s. Você tem %d de vitórias parciais nessa dificuldade."
DBM_CORE_COMBAT_STATE_RECOVERED		= "Luta contra %s começou %s atrás, reajustando cronógrafos..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Gravação do Transcritor começou."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Gravação do Transcritor finalizado."

DBM_CORE_PROFILE_NOT_FOUND			= "<Deadly Boss Mods> Seu perfil atual esta corrompido. DBM carregara o perfil 'padrão/default'."
DBM_CORE_PROFILE_CREATED			= "'%s' perfil criado."
DBM_CORE_PROFILE_CREATE_ERROR		= "Falha ao criar perfil. nome de perfil invalido."
DBM_CORE_PROFILE_CREATE_ERROR_D		= "Falha ao criar perfil. '%s' perfil já existe."
DBM_CORE_PROFILE_APPLIED			= "'%s' perfil aplicado."
DBM_CORE_PROFILE_APPLY_ERROR		= "Falha ao aplicar perfil. '%s' perfil não existe."
DBM_CORE_PROFILE_COPIED				= "'%s' perfil copiado."
DBM_CORE_PROFILE_COPY_ERROR			= "Falha ao copiar perfil. '%s' perfil não existe."
DBM_CORE_PROFILE_COPY_ERROR_SELF	= "Falha ao copiar perfil, não é possível copiar a si mesmo."
DBM_CORE_PROFILE_DELETED			= "'%s' perfil deletado. Perfil 'padrão/default' será aplicado."
DBM_CORE_PROFILE_DELETE_ERROR		= "Falha ao deletar perfil. '%s' perfil não existe."
DBM_CORE_PROFILE_CANNOT_DELETE		= "Não é possível deletar o perfil 'padrão/Default'."
DBM_CORE_MPROFILE_COPY_SUCCESS		= "%s's (%d spec) preferencias da mod foram copiadas."
DBM_CORE_MPROFILE_COPY_SELF_ERROR	= "Não é possível copiar às preferencias do char para ele mesmo"
DBM_CORE_MPROFILE_COPY_S_ERROR		= "Origem esta corrompida. Preferencias não foram copias ou foram copiadas parcialmente. Falha ao copiar."
DBM_CORE_MPROFILE_COPYS_SUCCESS		= "%s's (%d spec) preferencias de sons da mod foram copiadas."
DBM_CORE_MPROFILE_COPYS_SELF_ERROR	= "Não é possível copiar as preferencias de sons do char para ele mesmo"
DBM_CORE_MPROFILE_COPYS_S_ERROR		= "Origem esta corrompida. Preferencias de sons não foram copiadas ou foram copiadas parcialmente. Falha ao copiar."
DBM_CORE_MPROFILE_DELETE_SUCCESS	= "%s's (%d spec) preferencias da mod deletadas."
DBM_CORE_MPROFILE_DELETE_SELF_ERROR	= "Não é possível deletar preferencias que estão em uso."
DBM_CORE_MPROFILE_DELETE_S_ERROR	= "Origem esta corrompida. Preferencias não foram deletadas ou foram deletadas parcialmente. Falha ao deletar."

DBM_CORE_ALLMOD_DEFAULT_LOADED		= "Foram carregadas preferencias padrões para todas as mods desta area."
DBM_CORE_ALLMOD_STATS_RESETED		= "Todas as estatísticas da mod foram apagadas."
DBM_CORE_MOD_DEFAULT_LOADED			= "Foram carregadas opções padrão para esta luta."

DBM_CORE_WORLDBOSS_ENGAGED			= "%s foi possivelmente puxado no seu reino %s por cento de vida. (Enviado por %s)"
DBM_CORE_WORLDBOSS_DEFEATED			= "%s foi possivelmente derrotado no seu reino (Enviado por %s)."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4segundo:segundos;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minuto:minutos;"
DBM_CORE_TIMER_FORMAT				= "%d |4minuto:minutos; e %d |4segundo:segundos;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "seg"
DBM_CORE_SEC_FMT					= "%s seg"
DBM_CORE_DEAD						= "morto"
DBM_CORE_OK							= "Ok"

DBM_CORE_GENERIC_WARNING_OTHERS		= "e mais um"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "e %d outros"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Frenético em %s %s" 
DBM_CORE_GENERIC_TIMER_BERSERK		= "Frenético" 
DBM_CORE_OPTION_TIMER_BERSERK		= "Exibir cronógrafo para $spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Combate começou"
DBM_CORE_OPTION_TIMER_COMBAT		= "Exibir cronógrafo para começo do combate"
DBM_CORE_OPTION_HEALTH_FRAME		= "Exibir quadro de vida do chefe"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Barras"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Categoria de anúncios"
DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU	= "Anúncios pessoais"
DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER	= "Anúncios de alvo"
DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE	= "Anúncios de função"
DBM_CORE_OPTION_CATEGORY_SOUNDS			= "Sons"

DBM_CORE_AUTO_RESPONDED						= "Respondido automaticamente"
DBM_CORE_STATUS_WHISPER						= "%s: %s, %d/%d pessoas vivas"
--Chefes
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s está ocupado lutando contra %s (%s, %d/%d pessoas vivas)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s derrotou %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s derrotou %s! Eles tem um total de %d vitórias."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s foi derrotado por %s em %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s foi derrotado por %s em %s. Eles tem um total de %d derrotas nessa dificuldade."
--Cenários (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s esta ocupado em %s (%d/%d pessoas vivas)"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "%s foi completado %s!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "%s foi completado %s! Eles tem um total de %d vitórias."
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s não foi completado %s"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s não foi completado %s. Eles tem um total de %d vitórias parciais nesta dificuldade."

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versões"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (r%d) & %s (r%d)"--Two Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM não instalado"
DBM_CORE_VERSIONCHECK_FOOTER		= "Encontrados %d jogadores com DBM & %d jogadores com Bigwigs"
DBM_CORE_VERSIONCHECK_OUTDATED		= "Os seguintes %d jogadores estão com versões desatualizadas de boss mods: %s"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Sua versão do Deadly Boss Mods está desatualizada. Por favor, acesse www.deadlybossmods.com para baixar a versão mais recente."
DBM_CORE_VOICE_PACK_OUTDATED		= "O pacote de vozes do seu DBM pode estar sem alguns dos sons suportados por esta versão do DBM. Filtro de aviso especial sonoro foi desativado. Por favor baixe a versão mais recente do pacote de vozes ou contate o autor para um pacote que contenha os sons aqui referidos."
DBM_CORE_VOICE_MISSING				= "Você tinha um pacote de vozes DBM selecionado que não pode ser encontrado. Sua seleção foi restaurada para 'Nenhum/None'. Caso seja um erro, certifique-se que o pacote esta instalado corretamente e habilitado em addons."
DBM_CORE_VOICE_COUNT_MISSING		= "Voz de contagem regressiva %d esta selecionada para um pacote de voz que não pode ser encontrado. Foi restaurada a configuração padrão."

DBM_CORE_UPDATEREMINDER_HEADER		= "Sua versão do Deadly Boss Mods está desatualizada.\n A versão %s (r%d) está disponível para baixar no site da curse, WoWI ou aqui:"
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "A sua versão alpha do DBM está desatualizada.\n Você esta pelo menos %d versões de testes para trás. É recomendado que os usuários do DBM utilizem a versão mais recente do alpha ou a mais recente das versões estáveis. Versões alphas desatualizadas podem resultar em faltas de algumas funcionalidades ou totalmente inoperante."
DBM_CORE_UPDATEREMINDER_FOOTER		= "Pressione Ctrl+C para copiar o link de download para a área de transferência."
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "Pressione Ctrl+C para copiar o link de download para a área de transferência."
DBM_CORE_UPDATEREMINDER_DISABLE			= "AVISO: O seu DBM foi desativado por estar drasticamente desatualizado (pelo menos %d revisões), atualize para utilizar novamente. Isso garante que versões antigas ou códigos incompatíveis não arruínem à experiência de jogo para você ou para os membros da raid."
DBM_CORE_UPDATEREMINDER_HOTFIX			= "A sua versão do DBM contem temporizadores ou avisos incorretos para este chefe. Isso foi corrigido em uma versão mais recente ( ou alpha caso não exista versão estável mais recente disponível)"
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "AVISO: O seu DBM foi desativado por estar drasticamente desatualizado (pelo menos %d revisões), atualize para utilizar novamente. Isso garante que versões antigas ou códigos incompatíveis não arruínem à experiência de jogo para você ou para os membros da raid. Certifique-se de baixar a versão mais recente em deadlybossmods.com ou curse o mais breve possível."
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "AVISO: Você esta usando uma versão do DBM que não foi criada para esta versão do jogo. Por favor, certifique-se de baixar a versão correta em deadlybossmods.com ou curse."
DBM_CORE_VEM				= "AVISO: Você esta usando DBM e Voice Encounter Mods. DBM não funcionara corretamente nesta configuração e portanto não será carregada."
DBM_CORE_3RDPROFILES				= "AVISO: DBM-Profiles não é compatível com esta versão de DBM. Deve ser removida antes de DBM continuar para evitar conflitos."
DBM_CORE_UPDATE_REQUIRES_RELAUNCH		= "AVISO: Esta versão de DBM não funcionara corretamente até que você recomece o jogo por completo. Esta atualização contem novos arquivos ou mudanças no .toc que não podem ser carregadas via ReloadUI. Você pode encontrar funcionalidades quebradas ou erros caso continue sem recomeçar o jogo por completo."

DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Exibir pop-up quando houver uma nova versão disponível"

DBM_CORE_MOVABLE_BAR				= "Arraste-me!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h te enviou um cronógrafo do DBM: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancelar esse cronógrafo]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorar cronógrafos de %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Você tem certeza de que realmente deseja ignorar cronógrafos de %s até o fim desta sessão?"
DBM_PIZZA_ERROR_USAGE				= "Uso: /dbm [broadcast] timer <tempo> <texto>"

--DBM_CORE_MINIMAP_TOOLTIP_HEADER (Same as English locales)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Use shift+click ou clique com o botão direito para mover\nUse alt+shift+click para arrastar livremente"

DBM_CORE_RANGECHECK_HEADER			= "Medir distância: (%d m)"
DBM_CORE_RANGECHECK_SETRANGE		= "Definir distância"
DBM_CORE_RANGECHECK_SETTHRESHOLD	= "Definir limite para jogador"
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
	"/dbm version: Realiza uma checagem de versão de toda a raid. (ou: ver).",
--	"/dbm version2: Realiza uma checagem de versão de toda a raid e sussurra para avisando os membros que estão desatualizados (alias: ver2).",
	"/dbm unlock: Exibe uma barra de cronógrafo móvel. (ou: move).",
	"/dbm timer <x> <texto>: Inicia um cronógrafo de <x> segundos com o nome <texto>.",
	"/dbm broadcast timer <x> <texto>: Espalha um cronógrafo de <x> segundos com o nome <texto> para a raid (requer status de líder/guia).",
	"/dbm break <min>: Inicia um cronógrafo de intervalo de <min> minutos. Dá a todos os integrantes da raid um cronógrafo de intervalo (requer status de líder/guia).",
	"/dbm pull <seg>: Dispara um cronógrafo para iniciar a luta em <seg> segundos. Dá a todos os integrantes da raid um cronógrafo para iniciar a luta (requer status de líder/guia).",
	"/dbm arrow: Exibe a seta do DBM, veja /dbm arrow help para detalhes.",
	"/dbm lockout: Pergunta a todos os membros da raid, por seus vínculos de raid (ou: lockouts, ids) (requer status de líder/guia)..",
	"/dbm help: Exibe essa mensagem."
}

DBM_ERROR_NO_PERMISSION				= "Você não tem as permissões necessárias para fazer isso."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Esconder quadro de vida"

DBM_CORE_ALLIANCE					= "Aliança"
DBM_CORE_HORDE						= "Horda"

DBM_CORE_UNKNOWN					= "desconhecido"
DBM_CORE_LEFT						= "Esquerda"
DBM_CORE_RIGHT						= "Direita"
DBM_CORE_BACK						= "Atrás"
DBM_CORE_FRONT						= "A frente"
DBM_CORE_INTERMISSION				= "Intermissão"--No blizz global for this, and will probably be used in most end tier fights with intermission phases

DBM_CORE_BREAK_START				= "Intervalo começando agora -- você tem %s minuto(s)!"
DBM_CORE_BREAK_MIN					= "Intervalo encerra-se em %s minuto(s)!"
DBM_CORE_BREAK_SEC					= "Intervalo encerra-se em %s segundos!"
DBM_CORE_TIMER_BREAK				= "Intervalo!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "O intervalo acabou"

DBM_CORE_TIMER_PULL					= "Puxando em"
DBM_CORE_ANNOUNCE_PULL				= "Puxando em %d seg"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Puxando agora!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Vitória mais rápida."

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
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count			= "%s (%%s)"
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
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount = DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch--FIXME, Translate needed
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount = DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt--FIXME, Translate needed

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
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "Set icons on $spell:%s"
DBM_CORE_AUTO_SOUND_OPTION_TEXT		= "Tocar som \"Fuja garotinha\" para $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT	= "Tocar som de contagem regressiva para $spell:%s"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT	= "Tocar som de contagem regressiva para duração de $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT		= "Gritar quando você é afetado por $spell:%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell	= "%s em " .. UnitName("player") .. "!"


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

DBM_SPEED_KILL_TIMER_TEXT	= "Vitória em tempo recorde"
DBM_SPEED_KILL_TIMER_OPTION	= "Exibir cronógrafo para bater sua vitória mais rápida"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s solicitou suas IDs de instância e progresso atuais.\nVocê deseja enviar essa informação para %s? Ele(a) poderá requisitar essa informação durante a sessão atual (i. e. até que você reconecte)."
DBM_ERROR_NO_RAID					= "Você precisa estar em um grupo de raide para utilizar essa funcionalidade."
DBM_INSTANCE_INFO_REQUESTED			= "Enviadas requisições de vínculos de raid para o grupo.\nPor favor, note que a permissão dos usuários será solicitada antes de os dados serem enviados para você, portanto pode levar um minuto para que você receba todas as respostas."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Recebidas respostas de %d jogadores de um total de %d usuários do DBM: %d enviaram os dados, %d negaram a solicitação. Esperando mais %d segundos pelas respostas restantes..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Recebidas respostas de tosos os membros da raid"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Sender: %s ResultType: %s InstanceName: %s InstanceID: %s Difficulty: %d Size: %d Progress: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, dificuldade %s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, progresso %d: %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    progresso %d: %s"
DBM_INSTANCE_INFO_STATS_DENIED		= "Negou a solicitação: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Ausente: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Não possui uma versão recente do DBM instalada: %s"
DBM_INSTANCE_INFO_RESULTS			= "Resultados da busca por  IDs de raid. Note que instâncias podem aparecer mais de uma vez, se houver jogadores com clientes de WoW em outra língua."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Jogadores que ainda não responderam: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Exibir resultados agora]|r|h"