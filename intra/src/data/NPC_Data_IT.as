// This file was automatically generated! Don't touch it!
package data{
public class NPC_Data_IT {
public static var test:Object =
{
	DEBUG: {
		scene_1: {
			dialogue: new Array(
				"Ti piace la musica?  Parla con questo terminal!",
				"Ti piace il dolore?  Vai a sud!")
		}
	}
};

public static var test_state:Object =
{
	does_reset: true,
	DEBUG: {
		scene_1: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var arthur:Object =
{
	CIRCUS: {
		alone: {
			dialogue: new Array(
				"Quell'acrobata sta perdendo l'equilibrio! Dov'è la rete di sicurezza?",
				"...")
		}
,
		holyshit: {
			dialogue: new Array(
				"WOOAH")
		}
	}
};

public static var arthur_state:Object =
{
	CIRCUS: {
		alone: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		holyshit: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var javiera:Object =
{
	CIRCUS: {
		alone: {
			dialogue: new Array(
				"I leoni si stanno avvicinando a quel giocoliere!",
				"...")
		}
	}
};

public static var javiera_state:Object =
{
	CIRCUS: {
		alone: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var briar:Object =
{
	GO: {
		before_fight: {
			dialogue: new Array(
				"Briar: Sono stanco, Young. Sono stanco di tutti questi cicli. Mi sembra di rivivere lo stesso sogno, lo stesso incubo ancora e ancora, all'infinito.",
				"Briar: ...",
				"Briar: Non cambierà, Young.  Rimarremo così per sempre.")
		}
,
		after_fight: {
			dialogue: new Array(
				"Briar: Addio, Young.")
		}
,
		final: {
			dialogue: new Array(
				"Briar: Young, amico.",
				"Briar: Scalcia.  Muovi le braccia.  Diamine, non sai fare niente senza di me!",
				"Briar: Beh, andiamo a farci un paino.",
				"Sage: Sei stato... bravino. Forse ci rivedremo, un giorno. Addio.")
		}
	}
};

public static var briar_state:Object =
{
	GO: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		final: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var sage:Object =
{
	BLANK: {
		intro: {
			dialogue: new Array(
				"Voce Misteriosa: Ehi... ... Young? EHI!  ... oh, riesci a sentirmi?  Bene, allora ascolta.  Stai per svegliarti.  Usa le frecce direzionali per muoverti.",
				"Premi \'",
				"\' per interagire con gli oggetti e le persone accanto a te.",
				"Premi \'",
				"\' per accedere al menù, che ti darà informazioni su te stesso e su ciò che ti circonda.")
		}
	}
	,
	GO: {
		posthappy_sage: {
			dialogue: new Array(
				"Young... Volevo solo che tutto tornasse com'era.",
				"Spero... Spero che tu saprai fare meglio di me.")
		}
,
		posthappy_mitra: {
			dialogue: new Array(
				"Buona fortuna, Young.",
				"Sage non ha tutti i torti.  Voglio che tutto sia perfetto, e a volte questo mi fa ignorare la realtà.",
				"Non so di cosa hai bisogno per aiutare Briar.  Non capisco come funziona questo mondo, o perché tutto sembra così strano.  Ma so che voglio essere tua amica, Young.",
				"Tu stai lottando, Young.  Stai cercando di capire.  Spero che riesca a sistemare le cose.")
		}
,
		one: {
			dialogue: new Array(
				"Sage: Young... questo è il mio ultimo avvertimento... aspetta, chi è quella?",
				"Mitra: Io sono Mitra, e questa è la mia bici, Manu!",
				"Sage: Non ho chiesto il nome della tua bici, che ci fai qui?  Non mi ricordo di te.",
				"Mitra: Sono qui per aiutare il mio amico, Young...",
				"Sage: Young non ha amici.  Young non ha nemmeno Briar.  E se tu gli stai dando corda, ti voglio fuori dal mio mondo!",
				"Mitra: Che vuoi dire? Manu e io...",
				"Sage: NON MI INTERESSA DELLA TUA STUPIDA BICICLETTA!!!")
		}
,
		hit: {
			dialogue: new Array(
				"Sage: ...",
				"Mitra: Young! Va tutto bene?  Hai fatto una cosa meravigliosa... Vai avanti e falla finita con questa stupida area! Sappiamo che ce la puoi fare!",
				"Mitra: Manu!!!",
				"Mitra: Manu...",
				"Mitra: Senti, signor personaggio misterioso incappucciato, non so chi tu creda di essere, ma perché non ci lasci in pace?",
				"Sage: Dici di essere amica di Young, ma gli mentirai, gli dirai che in fondo lui è perfetto così e tutto si sistemerà.  Beh, se è questo quello che vuoi, BENE.  Sparisci dalla mia vista, Young.",
				"Sage: Va' a parlare con la tua \"amica\".",
				"Mitra: Stiamo solo facendo del nostro meglio...")
		}
	}
	,
	NEXUS: {
		enter_nexus: {
			dialogue: new Array(
				"Uomo incappucciato: Ah, era ora.  Ehm... ^Volevo dire...^ Benvenuto, Young! Io sono Sage, il saggio del villaggio. Sei stato convocato perché l'Oscurità si è diffusa per tutta la Landa. L'Oscurità cerca il leggendario Briar. Vuole usarne i poteri per scopi malvagi.  Devi raggiungerlo per primo. Devi proteggere Briar.",
				"Entra nel portale attivo alla tua sinistra per iniziare la tua avventura.",
				"*Sospira* non va bene che tu stia ancora qui a ciondolare.  Entra nel portale per iniziare la tua avventura.  Briar e, per estensione, il mondo intero è in pericolo!",
				"Entra in quel maledetto portale!")
		}
,
		after_ent_str: {
			dialogue: new Array(
				"Sei ancora qui?")
		}
,
		after_bed: {
			dialogue: new Array(
				"Continua, Young.  Potrebbero esserci altre chiavi come quella che hai trovato. Trovale.",
				"Viaggia fino ai confini più remoti della Landa, Young. È l'unico modo di fermare l'Oscurità.")
		}
,
		before_windmill: {
			dialogue: new Array(
				"Prendi quelle tre chiavi, Young, e apri la strada che porta alle zone più recondite della Landa.")
		}
,
		after_windmill: {
			dialogue: new Array(
				"Hai fatto quello che ho chiesto, Young, ma c'è ancora molto altro da fare.  Forse esplorando le zone più remote della Landa diventerai qualcuno... forse addirittura qualcuno degno della considerazione di Briar.")
		}
,
		all_card_first: {
			dialogue: new Array(
				"Ottimo lavoro, Young. Hai trovato tutte le carte in un'area della Landa, e una gemma è apparsa sulla cima del portale dell'area.")
		}
	}
	,
	OVERWORLD: {
		bedroom_entrance: {
			dialogue: new Array(
				"Sage: Presto le tue abilità saranno messe alla prova, Young. Per uscire vivo da questo tempio ti serviranno forza e intelletto.  Immagino che tu abbia già trovato un'arma, no?",
				"Cos...?  ... Volevo dire... Ma sì, certo... una scopa!  Proprio come predetto nella Leggenda...",
				"*sgrunt* di tutti gli incompeten... Ehi! Che stai facendo lì impalato?",
				"Tieni gli occhi aperti, Young.")
		}
	}
	,
	BEDROOM: {
		after_boss: {
			dialogue: new Array(
				"Sage: Per il momento sei ancora debole. Se speri di proteggere Briar dall'Oscurità, devi affrontare le tue paure. La carta che troverai in questo forziere, e le altre come questa, sono simboli della tua crescita. Ottenerle tutte è di vitale importanza per la tua missione.",
				"Anche quella chiave è fondamentale per la tua missione. Devi trovare anche le altre chiavi.  Seleziona la mappa sul menu per teletrasportarti all'entrata del tempio, e continua la tua eroica impresa.",
				"Viaggia a est e sud attraversando la zona del tempio... La chiave ti servirà.",
				"Che c'è? Vuoi che ti porti in spalla fino al cancello?")
		}
	}
	,
	TERMINAL: {
		before_fight: {
			dialogue: new Array(
				"Sage: Perché non mi ascolti?!  Se fai le cose di fretta come un idiota, metterai in pericolo Briar, la Landa e tutto quello per cui ho lavorato!",
				"Mi dispiace, Young, ma se non intendi ascoltarmi, dovrò convincerti in altri modi...")
		}
,
		after_fight: {
			dialogue: new Array(
				"Sage: Young... Non volevo che finisse così... Volevo solo che tu diventassi una persona migliore.  Volevo che tu diventassi in grado di aiutare Briar.  Ma questo è solo uno stupido gioco... Non posso impedirti di raggiungerlo.  Ricordati le mie parole quando andrà tutto a puttane.")
		}
,
		entrance: {
			dialogue: new Array(
				"Sage: Ciao, Young.  Quando diventerai una persona più forte e più saggia, questo sentiero ti condurrà da Briar.",
				"Sage: Non sei pronto, Young. Prima devi affrontare altre prove nella Landa.",
				"Sage: Hai fatto progressi, Young, ma devi possedere almeno 36 carte per attraversare questo cancello.")
		}
,
		etc: {
			dialogue: new Array(
				"Sage: Oh... Uh... hai già almeno 36 carte?  Ma io non sono sicuro che tu sia pronto per la vera prova.  Infatti guarda, stavamo leggendo male questo cancello, in realtà ti servono...\n...\n........\n92 carte per passare, non 36!",
				"Sage: Young, non andare, non sei ancora pronto!  Pensa a Briar!  Alla Landa!  Tutto questo non sarà servito a nulla se non sarai pronto!")
		}
	}
	,
	REDCAVE: {
		one: {
			dialogue: new Array(
				"Sage: Ottimo lavoro, Young.  Non solo hai sconfitto questo mostro, ma anche la tua paura di prevalere!!!",
				"Sage: Ovviamente, hai ancora molta strada da fare.  Stai esplorando la Landa?")
		}
	}
	,
	CROWD: {
		one: {
			dialogue: new Array(
				"Sage: Ben fatto, Young. Tuttavia, ci sono altre prove che dovrai affrontare. Non abbassare la guardia.",
				"Sage: Hai già trovato tutte le chiavi, Young? Se non le hai trovate, vai alla spiaggia.")
		}
	}
};

public static var sage_state:Object =
{
	BLANK: {
		intro: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	GO: {
		posthappy_sage: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		posthappy_mitra: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		one: {
			top: true,
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		hit: {
			top: true,
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	NEXUS: {
		enter_nexus: {
			top: true,
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
,
		after_ent_str: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_bed: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		before_windmill: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_windmill: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		all_card_first: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	OVERWORLD: {
		bedroom_entrance: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
	}
	,
	BEDROOM: {
		after_boss: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
	}
	,
	TERMINAL: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		entrance: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		etc: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDCAVE: {
		one: {
			top: true,
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CROWD: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var cliff_dog:Object =
{
	CLIFF: {
		top_left: {
			dialogue: new Array(
				"Non sono come gli altri! *Bau* non ti farò niente...",
				"C'è molta pace quassù.",
				"Sai di bietole.",
				"*woof*")
		}
	}
};

public static var cliff_dog_state:Object =
{
	CLIFF: {
		top_left: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
	}
};

public static var happy_npc:Object =
{
	HAPPY: {
		beautiful: {
			dialogue: new Array(
				"Ce l'hai fatta, Young! Hai sconfitto l'Oscurità! Guarda questo posto! È bellissimo!",
				"Così bello...")
		}
,
		dump: {
			dialogue: new Array(
				"Oh, meno male che sei qui! Temevo rimanessi bloccato in quella discarica di neve... cazzo se è deprimente lì!  Ha!",
				"Ahahahah. Ahahahahahahah. AHAHAHAHAHAHAHA!")
		}
,
		drink: {
			dialogue: new Array(
				"Ehi splendore, ti offro da bere!",
				"Bevi ancora, merdaccia!  Ahahah!")
		}
,
		hot: {
			dialogue: new Array(
				"Cazzo fa caldo qui... il calore... il sudore...",
				"Maledizione! Allenarmi qui mi eccita così tanto!")
		}
,
		gold: {
			dialogue: new Array(
				"Sai che questo posto è fatto d'oro?  Oro vero!  Potremmo scappare insieme e vivere di questo mattone!  Ahahahahah!",
				"Sul serio, che fai lì impalato?  Aiutami a staccare questo mattone!")
		}
,
		briar: {
			dialogue: new Array(
				"???: Young... Ce l'hAi FatTa! mI hAi salVaTo!  Oora TutTo tOrnErà ComE pRimA!!!!!!")
		}
	}
};

public static var happy_npc_state:Object =
{
	HAPPY: {
		beautiful: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		dump: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		drink: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		hot: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		gold: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		briar: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var mitra:Object =
{
	OVERWORLD: {
		initial_overworld: {
			dialogue: new Array(
				"OCCHIO!",
				"Scusami... Andavo troppo veloce.  Ehi, non ti ho mai visto prima!  Sei un viaggiatore come me?  ... Eh?  Vuoi salvare Briar dalla Malefica Oscurità?  ... ^Ehm... Non ci ho capito niente, ma ok, figo!",
				"Ero qui, assieme a Manu... Cosa?   Certo che non sono da sola, Manu è qui con me.  Non hai capito, Manu è il nome della mia bici!",
				"Beh, forse ci incontreremo di nuovo.  Ti farò sapere se scoprirò qualcosa di questo Briar.")
		}
	}
	,
	BLUE: {
		one: {
			dialogue: new Array(
				"OCCHIO!  Forza Manu, andiamo!",
				"Eeeee via!",
				"Continua Young, siamo con te!")
		}
	}
	,
	FIELDS: {
		init: {
			dialogue: new Array(
				"Ti ricordi di me?  L'altra volta ti ho presentato solo Manu, la mia bici.  Il mio nome è Mitra.",
				"Ti ricordi di me?  L'ultima volta ho dimenticato di presentarmi. Sono Mitra, e questa bella bici qui si chiama Manu.",
				"Mitra: Come va, Young?   ... Cosa?  Come so il tuo nome?   Pensi che sia strano, eh?  Beh, l'ho letto sul retro della tua felpa.",
				"Mitra: Ci vediamo, Young!")
		}
,
		quest_event: {
			dialogue: new Array(
				"Mitra: Ah, mi sono appena ricordata. Prima qualcuno ha detto che stava cercando di trovare qualcosa. Non sono sicura di che stesse parlando, ma è andato in tutta fretta verso le montagne.")
		}
,
		game_hints: {
			dialogue: new Array(
				"Niente.",
				"Oh, non sai che fare? Hai cercato in giro per la spiaggia? Forse lì qualcuno può aiutarti. Sembra che quella tua chiave sia parte di un set. Forse te ne servono altre?",
				"Oh, non sai che fare? Hai cercato nella foresta a est?  Sembra che quella tua chiave sia parte di un set. Forse te ne servono altre?",
				"Guarda tutte quelle chiavi! Penso di aver visto dei cancelli a sudest. Forse puoi usarle lì?",
				"Ehi, ho visto che hai azionato la turbina!  Sai se ha avuto effetti sulla Landa?",
				"Ehi, Young. Wow!  Stai accumulando un sacco di carte!  Hai già capito a che servono?  Potresti farci un sacco di soldi!",
				"Cos'è quel nuovo accessorio attaccato alla scopa?  Ti permette di alterare la... struttura del mondo?  Young, sinceramente mi sembra pericoloso.  Per fortuna sembra non funzionare da nessuna parte, forse solo nei più strani e reconditi recessi della Landa.",
				"Ti piacciono le mie scarpe da salto?  Ingegnose eh?  Io adoro le mie nuove scarpe da bici.  Con queste io e Manu siamo un team ancora migliore!",
				"Ottimo Young, hai trovato un'altra chiave!  A Manu piace il colore!  Hai già trovato un posto dove usarla?")
		}
,
		card_hints: {
			dialogue: new Array(
				"Mitra: Ehi young, stai cercando una carta?\nHai cercato nell'area attorno al tempio di Colui Che Vede?",
				"Mitra: Ehi young, stai cercando una carta?\nHo sentito che c'è un labirinto vicino all'uscita sul retro del tempio di Colui Che Vede.",
				"Mitra: Ehi young, stai cercando una carta?\nPotresti trovare qualcosa vicino all'antro di Colui Che Vede.",
				"Mitra: Ehi young, stai cercando una carta?\nC'era una stanza piena di nemici nel tempio di Colui Che Vede, no?",
				"Mitra: Ehi young, stai cercando una carta?\nHai cercato bene in tutto il tempio di Colui Che Vede?",
				"Mitra: Ehi young, stai cercando una carta?\nProva a cercare nell'area vestigiale vicino all'uscita sul retro dell'antro di Colui Che Vede.",
				"Mitra: Ehi young, stai cercando una carta?\nForse il tuo vicino ne sa qualcosa.",
				"Mitra: Ehi young, stai cercando una carta?\nSo che il tipo nel tuo appartamento stava nascondendo qualcosa...",
				"Mitra: Ehi young, stai cercando una carta?\nProva a cercare vicino all'entrata del tuo appartamento!",
				"Mitra: Ehi young, stai cercando una carta?\nHai cercato *ovunque* nel tuo appartamento?",
				"Mitra: Ehi young, stai cercando una carta?\nProprio a sud di qui c'è un'isola! Non ci sono stata, ma dovresti cercare lì.",
				"Mitra: Ehi young, stai cercando una carta?\nSeguendo i fiumi si trova un sacco di roba. Guarda bene!",
				"Mitra: Ehi young, stai cercando una carta?\nSo che qualcuno ha lasciato una carta vicino alla pala eolica.",
				"Mitra: Ehi young, stai cercando una carta?\nCerca vicino ai fiumi nella foresta...",
				"Mitra: Ehi young, stai cercando una carta?\nProva a curiosare vicino alla base delle montagne.",
				"Mitra: Ehi young, stai cercando una carta?\nProva a raggiungere la cima delle montagne.",
				"Mitra: Ehi young, stai cercando una carta?\nForse qualcosa è nascosto all'estremità della spiaggia.",
				"Mitra: Ehi young, stai cercando una carta?\nFai una passeggiata nei boschi cremisi.",
				"Mitra: Ehi young, stai cercando una carta?\nC'erano molte porte chiuse in una di quelle caverne rosse, giusto?",
				"Mitra: Ehi young, stai cercando una carta?\nVai alla caverna rossa a nord, controlla la fonte del fiume!",
				"Mitra: Ehi young, stai cercando una carta?\nHai cercato bene in quel labirinto oscuro?",
				"Mitra: Ehi young, stai cercando una carta?\nRicordo che da qualche parte c'era un poco rassicurante sentiero di lanciafiamme. Alla fine deve esserci qualcosa!",
				"Mitra: Ehi young, stai cercando una carta?\nQuei tizi del circo devono star nascondendo qualcosa. Hai cercato ovunque?",
				"Mitra: Ehi young, stai cercando una carta?\nHai cercato attorno al perimetro del fosso di quella coppia?",
				"Mitra: Ehi young, stai cercando una carta?\nC'è questa coppia che ama stare vicino a un fosso. Devono nascondere qualcosa.",
				"Mitra: Ehi young, stai cercando una carta?\nA volte ci sono cose nascoste fra le voragini, soprattutto nelle caverne di montagna!",
				"Mitra: Ehi young, stai cercando una carta?\nHai setacciato le one più alte della caverna di montagna?",
				"Mitra: Ehi young, stai cercando una carta?\nC'è qualcosa nelle profondità della caverna di montagna?",
				"Mitra: Ehi young, stai cercando una carta?\nQuel cubo colorato in quel posto strano... Forse ha qualcosa!",
				"Mitra: Ehi young, stai cercando una carta?\nHai parlato con il cubo grigio in quel posto strambo?  Forse sa qualcosa.",
				"Mitra: Ehi young, stai cercando una carta?\nL'ultimo piano dell'hotel è un po' dimesso, ma deve esserci qualcosa!",
				"Mitra: Ehi young, stai cercando una carta?\nSei entrato in tutte le stanze del terzo piano dell'hotel?",
				"Mitra: Ehi young, stai cercando una carta?\nScommetto che qualcuno ha lasciato qualcosa al secondo piano dell'hotel.",
				"Mitra: Ehi young, stai cercando una carta?\Il proprietario dell'hotel potrebbe averti lasciato qualcosa!",
				"Mitra: Ehi young, stai cercando una carta?\nQuei ponti distrutti a nordovest... guarda lì!",
				"... Cosa? Non hai trovato *nessuna* carta? Young, amico, ma sei fuori? A volte nella vita bisogna essere avventurosi, aprire qualche scatola, sai?")
		}
,
		general_banter: {
			dialogue: new Array(
				"Hai incontrato quel tipo che stava cercando qualcosa nelle montagne?",
				"Sai qual è il cognome della mia bici? ... Brio!  L'hai capita?  Manu Brio!  ... Scherzo, le biciclette non hanno cognomi.",
				"Pensi che debba comprare una catena?  Non mi piacerebbe tenere legata Manu ma sai, se ne sentono tante di bici rubate al giorno d'oggi...",
				"Allora, cos'è Briar?  Una specie di artefatto antico di una cultura perduta?",
				"Mi chiedo perché non ho sentito niente dell'arrivo dell'Oscurità.  Immagino che molta gente nella Landa sia impegnata nelle sue battaglie quotidiane.",
				"Ehi Young, volevo solo dirti che... hai dei bellissimi capelli.")
		}
	}
};

public static var mitra_state:Object =
{
	OVERWORLD: {
		initial_overworld: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BLUE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	FIELDS: {
		init: {
			cur: "",
			pos: 0,
			loop: 2,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		game_hints: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		card_hints: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		general_banter: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var statue:Object =
{
	NEXUS: {
		enter_nexus: {
			dialogue: new Array(
				"Statua: Anziano del villaggio solo di nome, di fatto non è né saggio né anziano.")
		}
	}
	,
	OVERWORLD: {
		bedroom_entrance: {
			dialogue: new Array(
				"Statua: Ho visto una scopa in una leggenda... era sulla mappa nell'armadietto di un inserviente.")
		}
	}
	,
	BEDROOM: {
		after_boss: {
			dialogue: new Array(
				"Statua: Le carte sono vitali per la tua missione.  Le carte, soprattutto quelle di credito, sono vitali anche per altre missioni, come l'acquisto di bevande alcoliche.")
		}
	}
	,
	REDCAVE: {
		one: {
			dialogue: new Array(
				"Statua: Ottimo lavoro, Sage.  Hai dovuto superare ogni limite del tuo carattere e ogni forma di amor proprio per dire una cosa così imbarazzante!!!")
		}
	}
	,
	TERMINAL: {
		one: {
			dialogue: new Array(
				"Se continui così, quando sarai diventato un individuo più stressato e apatico finirai per sfogarti sul gelato.  Trova conforto nella bottiglia, perdente!")
		}
	}
};

public static var statue_state:Object =
{
	NEXUS: {
		enter_nexus: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	OVERWORLD: {
		bedroom_entrance: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BEDROOM: {
		after_boss: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDCAVE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	TERMINAL: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var sadbro:Object =
{
	OVERWORLD: {
		initial_forced: {
			dialogue: new Array(
				"Edward: Una volta un uomo venne a installare uno specchio nel nostro bagno. Avevo paura che ci avesse nascosto una telecamera.  Ho controllato ogni centimetro della cornice di legno, ho versato del Mastro Ligno in ogni fessura sperando di mandarla in cortocircuito.    Ovviamente non ho mai trovato nulla.",
				"Edward: Questo tempio è dedicato a Colui Che Vede.   Non so perché sono venuto qui, e ho troppa paura di entrare.")
		}
,
		bedroom_not_done: {
			dialogue: new Array(
				"Edward: Ci sono problemi?  Immagino di sì.  Tutto quello che hai è una scopa, e tutto quello che le scope fanno è spostare la polvere.")
		}
,
		bedroom_done: {
			dialogue: new Array(
				"Edward: hai detto di aver sconfitto Colui Che Vede?   Ha.  Non hai capito che non funziona così?  Stai solo versando Mastro Ligno nelle fessure.")
		}
	}
};

public static var sadbro_state:Object =
{
	OVERWORLD: {
		initial_forced: {
			cur: "",
			pos: 0,
			loop: 1,
			dirty: false,
			finished: false
		}
,
		bedroom_not_done: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		bedroom_done: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var sun_guy:Object =
{
	BEDROOM: {
		before_fight: {
			dialogue: new Array(
				"Oh, sei così dolce.  Il piccolo, tenero Young che gioca a fare l'eroe.  Ma io ho visto ogni passo che hai mosso nella Landa, e lascia che te lo dica Young, non tutti qui sono onesti come lo sono io.  Stai attento a coloro di cui ti fidi!")
		}
,
		after_fight: {
			dialogue: new Array(
				"Sarò con te, Young, ogni volta che sarai solo.  E ricorda il mio consiglio sulla tua piccola \"avventura\".")
		}
	}
};

public static var sun_guy_state:Object =
{
	BEDROOM: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var rock:Object =
{
	BEDROOM: {
		one: {
			dialogue: new Array(
				"Roccia: La visione periferica è il covo dei demoni.")
		}
,
		two: {
			dialogue: new Array(
				"Roccia: Da fare - Costruire un sistema di teletrasporto al Nexus. Progresso -  in stato di fermo. Colui Che Vede non intende fornire i fondi per rendere il progetto possibile. Dovremo tornare a usare il metodo originale, l'inspiegabile portale dimensionale.")
		}
,
		three: {
			dialogue: new Array(
				"Roccia: Sono intrappolata qui, tutta sola. Il lavoro procede a buon ritmo in questo tunnel, almeno posso vedere ogni giorno piccoli progressi.")
		}
	}
	,
	BLUE: {
		one: {
			dialogue: new Array(
				"Questa ruota serve a sollevare la diga.")
		}
	}
	,
	CIRCUS: {
		one: {
			dialogue: new Array(
				"24 giugno, 1957: Si sono rotte le corde del trapezio.  Alice Rutgers è precipitata al suolo e si è fratturata gli stinchi.")
		}
,
		two: {
			dialogue: new Array(
				"17 luglio, 1957: sette clown si sono ritirati per problemi quasi fatali ai polmoni.  Si sospettano responsabilità della linea di makeup Landan Look, ma non è in corso nessuna investigazione.")
		}
,
		three: {
			dialogue: new Array(
				"21 luglio, 1957: A seguito del malfunzionamento di una gabbia, la mia faccia e il mio fianco sono stati gravemente mutilati da un leone non ancora domato. Sono sopravvissuto, ma rabbrividisco guardandomi allo specchio.")
		}
,
		four: {
			dialogue: new Array(
				"5 agosto, 1957: In sogno, ho visto un volto di pietra con occhi feroci e luccicanti.  Parlava della verità sulla nostra esistenza, ed è stato il primo a offrire libertà dal dolore.")
		}
,
		five: {
			dialogue: new Array(
				"7 agosto, 1957: Quanti altri di noi dovranno soffrire prima che tutti accettino la verità di Colui Che Vede?")
		}
,
		six: {
			dialogue: new Array(
				"8 agosto, 1957: Ho preso una decisione.  Degli altri, qualcuno ha detto che mi seguirà.  Questa sarà la mia ultima annotazione.  Possa Colui Che Vede vegliare su tutti noi.")
		}
	}
	,
	CLIFF: {
		one: {
			dialogue: new Array(
				"(Segni indecifrabili)")
		}
,
		two: {
			dialogue: new Array(
				"7 dicembre, 2010. (nome illeggibile). Non c'è niente quassù a parte questa stupida roccia!")
		}
,
		three: {
			dialogue: new Array(
				"Pericolo! Questa caverna è inesplorata.")
		}
,
		four: {
			dialogue: new Array(
				"Questo dirupo va verso l'alto a perdita d'occhio, ma nessuno è mai arrivato abbastanza in alto per capire fin dove arriva.")
		}
	}
	,
	CROWD: {
		one: {
			dialogue: new Array(
				"Roccia: Come?")
		}
,
		two: {
			dialogue: new Array(
				"Roccia: Attenzione! Caduta verticale, saltate a vostro rischio e pericolo.")
		}
	}
	,
	DEBUG: {
		one: {
			dialogue: new Array(
				"Questo serviva come segnaposto per l'animazione dei cancelli delle carte. Avvicinati due volte per vedere le animazioni di apertura e chiusura!",
				"Ho dimenticato perché non l'abbiamo più usata. Forse era un po' troppo.")
		}
,
		two: {
			dialogue: new Array(
				"Qui ci sono dei test per vari tipi di terreno e collisioni! Non riuscivo a far funzionare i terreni a direzione unica da ogni lato (tipo i muri), quindi ho lasciato perdere... credo.",
				"Abbiamo lasciato perdere per vari motivi. Semplificare il design era importante per riuscire a finire il gioco.")
		}
,
		three: {
			dialogue: new Array(
				"All'inizio i nemici potevano droppare chiavi. Poi ho scartato l'idea, anche se poteva essere divertente.",
				"Abbiamo anche considerato di creare dei cancelli sfida alla fine di alcuni percorsi, che si aprivano solo se li raggiungevi senza subire danni.",
				"Volevamo basare tutti i dungeon su questo sistema e lasciar perdere completamente i punti vita, ma a quanto pare il gioco era troppo difficile!")
		}
,
		four: {
			dialogue: new Array(
				"PRIGIONE!!!",
				"Liberaci!!!",
				"Per favore!")
		}
,
		five: {
			dialogue: new Array(
				"Benvenuto nel MONDO DI DEBUG! Sei uscito dai confini de \"La Landa\", quindi considera questo mondo (al 90 percento) \"non canonico\". Ad ogni modo.",
				"Prima che ci fossero set di tile per molte delle aree, usavo tile stupide tipo queste per segnare dove andavano le porte. Infatti, ogni dungeon è stato arrangiato con i set di quest'area, e poi Marina li ha aggiustati con i suoi set di tile.")
		}
,
		six: {
			dialogue: new Array(
				"fille")
		}
	}
	,
	DRAWER: {
		five: {
			dialogue: new Array(
				"-ARCHIVI-",
				"PROCEDERE CON CAUTELA")
		}
,
		four: {
			dialogue: new Array(
				"Ovest. Fessura. Realtà! Basso valore immobiliare, uragano, vecchio, fatiscente. Rilassante.")
		}
,
		three: {
			dialogue: new Array(
				"Colui Che Vede, da quel che ric- crr,,,,, Bei Momenti in Casa.")
		}
,
		two: {
			dialogue: new Array(
				"CELLA FRIGORIFERA\n\n^  -- LA DIREZIONE")
		}
,
		one: {
			dialogue: new Array(
				"CONTINUA")
		}
	}
	,
	FIELDS: {
		one: {
			dialogue: new Array(
				"Ovest: Spiaggia\n\nEst: Foresta\n\nSudest:\n Area Piovosa\n\nNord: \nZona del tempio\n\nNordovest: Dirupo")
		}
	}
	,
	FOREST: {
		one: {
			dialogue: new Array(
				"Ovest: Lago\nSud, poi est: Dirupo")
		}
,
		two: {
			dialogue: new Array(
				"Laghetto della quiete. Resta un po', sappiamo che hai tempo.")
		}
,
		three: {
			dialogue: new Array(
				"Temo di dover rimanere in questo angolino per sempre.")
		}
,
		four: {
			dialogue: new Array(
				"Est: Dirupo")
		}
	}
	,
	GO: {
		one: {
			dialogue: new Array(
				"Il sentiero si aprirà quando le tessere guardiane nere saranno sostituite con le pietre del loro colore spirituale nella griglia sottostante.")
		}
,
		two: {
			dialogue: new Array(
				"Quando la statua di pietra blu si è spostata,\nsi è aperto un nuovo sentiero.\nDopo il dirupo, attraverso strane dimensioni,\nc'è un hotel per viandanti.\n\n\n\"Chi è il guardiano?\" Chiedo,\n\"Chi governa questo affollato luogo d'affari?\"\nMolte anime sono qui riunite,\nma io mi sento comunque solo.")
		}
,
		three: {
			dialogue: new Array(
				"La statua rossa e rugginosa si è mossa,\ne ha svelato la via per abissi più profondi.\nNe segue un sotterraneo labirintico\ne un grosso tendone da circo.\n\n\n\"Chi sono i guardiani?\" Chiedo, \n\"Chi ha rinunciato alla vita per fuggire in questo posto?\"\nIo, come loro, temo il dolore.\nMa temo di più la morte.")
		}
,
		four: {
			dialogue: new Array(
				"La statua metallica verde si è spostata,\naprendo un sentiero più profondo.\nQuartieri residenziali e marciapiedi formano\nil sentiero per un appartamento.\n\n\n\"Chi è il guardiano?\" Chiedo, \n\"Chi cerca conforto nelle stelle?\"\nSolo, sento che qualcosa mi osserva.\nE non è l'amichevole luce stellare.")
		}
	}
	,
	BLANK: {
		one: {
			dialogue: new Array(
				"Roccia: Questa è terra di nessuno - non ancora parte della Landa.")
		}
,
		two: {
			dialogue: new Array(
				"Roccia: Questi - ^ io e i miei cerchi siamo^ - promesse... Io^ - cerchi^ - cercherò di portare tutto a termine...^ - concentrici.  Bzrt, bzrt.")
		}
,
		three: {
			dialogue: new Array(
				"Roccia: Stai attento ^ -...ma riesco sempre^ - a dove metti i piedi^ - a riapparire ,no?^ - in questo posto!")
		}
,
		four: {
			dialogue: new Array(
				"Roccia: Guardando in basso ^ - E ho capito:^ - da qui, - ^ Di amarlo.^ - non si vede... niente, a dire il vero.")
		}
,
		five: {
			dialogue: new Array(
				"Roccia: Mi scuso -^ Sì ma, -^ per questa confusione -^ dobbiamo rimanere in contatto -^ ma quel portale dovrebbe ^- e cercherò di darti le mie opinioni - ^ riportarti nella Landa.")
		}
	}
	,
	NEXUS: {
		one: {
			dialogue: new Array(
				"A volte, se parli più volte con le persone, ti diranno cose diverse.",
				"Le rocce no.  Le rocce non lo fanno.")
		}
,
		two: {
			dialogue: new Array(
				"Roccia: Così vicino! Se solo...")
		}
,
		three: {
			dialogue: new Array(
				"Roccia: La curiosità è una gran cosa.")
		}
,
		four: {
			dialogue: new Array(
				"Roccia: Oh!...?")
		}
,
		five: {
			dialogue: new Array(
				"C'è una mail aperta sul computer. Alcune parti dello schermo sono rotte, e il messaggio è solo parzialmente visibile fra le chiazze nere. La mail dice: \"Ciao Young!\" Sembra che [...] cinquantesima carta [...] forse non dovresti... [...] vale la pena pensarci!  Pensi di essere pronto?  Svegliati...\"")
		}
	}
	,
	OVERWORLD: {
		one: {
			dialogue: new Array(
				"Roccia: Scommetto che stai leggendo una roccia perché non hai amici.")
		}
,
		two: {
			dialogue: new Array(
				"Roccia: Benvenuto alla Stazione Oltremondo. Speriamo che ti sia goduto la tua permanenza nella Landa.")
		}
,
		three: {
			dialogue: new Array(
				"Roccia: Em… You are normále? Capeesh?",
				"Roccia: Per favore, non andare a sud. Ci sono lavori in corso.")
		}
,
		four: {
			dialogue: new Array(
				"Roccia: Tesoro in 5, 3!")
		}
,
		five: {
			dialogue: new Array(
				"Roccia: Ahah, fregato!")
		}
	}
	,
	REDCAVE: {
		one: {
			dialogue: new Array(
				"NASCIAMO NELLA PUTREFAZIONE DEL CORPO DI NOSTRA MADRE.")
		}
,
		two: {
			dialogue: new Array(
				"UN GIORNO NOSTRA MADRE HA LASCIATO SUA MADRE E SI È AVVENTURATA NELLA NEBBIA VENEFICA.")
		}
,
		three: {
			dialogue: new Array(
				"NON LO ABBIAMO VOLUTO NOI.  NON AVREMMO COMPRATO LE NOSTRE VITE A COSTO DELLA SUA SOFFERENZA.")
		}
	}
	,
	REDSEA: {
		one: {
			dialogue: new Array(
				"Roccia: I segni indicano che gli alberi non sono stati attivi per un lungo periodo di tempo.")
		}
,
		two: {
			dialogue: new Array(
				"Roccia: Sud: ???^  Nord: ???")
		}
,
		three: {
			dialogue: new Array(
				"Roccia: Si dice che il terreno irregolare sia opera dei progenitori degli abitanti di questa zona.")
		}
,
		four: {
			dialogue: new Array(
				"Roccia: Sembrano essere una specie pacifica.")
		}
	}
	,
	SPACE: {
		one: {
			dialogue: new Array(
				"Scarabocchiato in quello che sembra essere pennarello indelebile: Salve, compagno viaggiatore dello SPAZIO e del TEMPO. Ti sei avventurato in uno squarcio lontano dall'aera giustapposta di YOUNG. Hai attraversato un OCEANO o due, per così dire. Non preoccuparti per il CONTRASTO, potrai presto tornare alla tua consueta avventura. non TEMERE questo luogo, anche se può sembrare TENEBROSO e PERICOLOSO i suoi abitanti sono molto AMICHEVOLI \n      -- La Direzione",
				"(Sotto il messaggio, una incisione:) Qui giace ___ (illeggibile). Si è perso nei boschi.",
				"(Ancora più sotto il messaggio:) (non andare troppo a sud.)")
		}
,
		two: {
			dialogue: new Array(
				"Qui giace ____ (illeggibile. Chi l'ha scritto?) È stato impalato da arcobaleni!",
				"Sarebbe stato meglio con i trofei.")
		}
,
		three: {
			dialogue: new Array(
				"Qui giace Burd. I precipizi non gli furono troppo amici.")
		}
,
		four: {
			dialogue: new Array(
				"Qui giace borsa.  Non ha mai avuto alcuna possibilità.",
				"Arrogante!")
		}
,
		five: {
			dialogue: new Array(
				"Qui giace Savitch. Una volta ha provato ad aggiustarmi il computer in garage, e non occupava molto spazio mentre lo faceva. Dopo tre anni, non aveva ancora finito. Poi, è morto.")
		}
,
		six: {
			dialogue: new Array(
				"Qui giace Dave. Non era molto d'ispirazione.")
		}
	}
	,
	SUBURB: {
		one: {
			dialogue: new Array(
				"--- YOUNG TOWN --- ^\nBenvenuto a Young Town. Per piacere, stai attento ad alcuni dei cittadini. Non sono molto amichevoli. Procedi con cautela.  Young Town è stata fondata negli anni '90 dal sindaco Ying come parte di un progetto di edilizia urbana. Il nome è stato scelto in base al rifuto di Ying di chiamarsi Ying, e in base al suo affermare di chiamarsi Young.  Ti auguriamo un piacevole soggiorno.")
		}
,
		two: {
			dialogue: new Array(
				"A ovest ci sono i leggendari templi di Colui Che Vede. A est c'è l'appartamento del nostro fantastico sindaco Ying, che è chiuso al pubblico - i trasgressori sono avvisati.")
		}
,
		three: {
			dialogue: new Array(
				"Durante la sua quinta visita, Ying mostrò frustrazione per la mancanza di parcheggi. Questo parcheggio riflette la frustrazione di Ying per la mancanza di parcheggi. Ying ha occasionalmente parcheggiato in questo parcheggio nelle sue visite seguenti.")
		}
,
		four: {
			dialogue: new Array(
				"Ricordo le lunghe frasi che scrivevo. Ha! Frammentato.")
		}
,
		five: {
			dialogue: new Array(
				"UNA SITUAZIONE PERICOLOSA")
		}
	}
	,
	TRAIN: {
		one: {
			dialogue: new Array(
				"Colui Che Vede sa tutto, e conduce all'illuminazione. Il cammino per l'illuminazione non è illuminato da alcuna torcia.")
		}
,
		two: {
			dialogue: new Array(
				"Non allontanarti dal cammino di Colui Che Vede, neanche per i tesori che si trovano agli angoli remoti del labirinto.")
		}
,
		three: {
			dialogue: new Array(
				"Cammina.")
		}
,
		four: {
			dialogue: new Array(
				"Non far adirare gli inseguitori con la violenza.")
		}
	}
	,
	WINDMILL: {
		one: {
			dialogue: new Array(
				"PUNTO PANORAMICO: Torri sorelle. Costruite tempo fa, le torri sorelle svettano sulle montagne in lontananza. La prima torre è stata precedentemente danneggiata, e da allora è stata destinata ad altri usi. La seconda si erge a est, toccando il cielo. Per ragioni di sicurezza, il sentiero per la torre è stato chiuso fino a nuovo avviso.")
		}
,
		two: {
			dialogue: new Array(
				"AVVISO PER LA PUBBLICA SICUREZZA:^\nSebbene non danneggiata, pare che in cima a questa torre ci sia uno squarcio dimensionale. Procedete con cautela e con una mente aperta.^\n      -- La Direzione")
		}
	}
};

public static var rock_state:Object =
{
	BEDROOM: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BLUE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CIRCUS: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		six: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CLIFF: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CROWD: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	DEBUG: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		six: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	DRAWER: {
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	FIELDS: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	FOREST: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	GO: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BLANK: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	NEXUS: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	OVERWORLD: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDCAVE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDSEA: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	SPACE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		six: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	SUBURB: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		five: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	TRAIN: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		three: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		four: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	WINDMILL: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var dungeon_statue:Object =
{
	BEDROOM: {
		one: {
			dialogue: new Array(
				"Sembra che questa statua non abbia intenzione di spostarsi.")
		}
,
		two: {
			dialogue: new Array(
				"La statua si è spostata.")
		}
	}
	,
	REDCAVE: {
		one: {
			dialogue: new Array(
				"Sembra che questa statua sia saldamente a posto.")
		}
,
		two: {
			dialogue: new Array(
				"La statua si è spostata.")
		}
	}
	,
	CROWD: {
		one: {
			dialogue: new Array(
				"La statua non sembra essere spostabile.")
		}
,
		two: {
			dialogue: new Array(
				"La statua si è spostata.")
		}
	}
};

public static var dungeon_statue_state:Object =
{
	BEDROOM: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDCAVE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CROWD: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		two: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var splitboss:Object =
{
	APARTMENT: {
		before_fight: {
			dialogue: new Array(
				"Il fuoco è affascinante, non è vero? È un vero peccato che il bagliore dei lampioni nasconda il fuoco delle stelle.")
		}
,
		after_fight: {
			dialogue: new Array(
				"Ok, le stelle non sono davvero fatte di fuoco.  ^Ma tanto non fotte nulla a nessuno.")
		}
	}
};

public static var splitboss_state:Object =
{
	APARTMENT: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var cube_king:Object =
{
	SPACE: {
		color: {
			dialogue: new Array(
				"Come va? Sono il sovrano di questa partizione e interpretazione di spazio.",
				"Vuoi sapere perché sono il sovrano di questo posto? Te lo dirò, ma ci vorrà un po'. Un bel po'. Tipo un sacco di tempo.",
				"Sul serio, ci metterò molto.  Davvero eh, ti sto avvisando! Ho la tendenza a divagare. Forse faresti meglio a prendere il contenuto di quel forziere laggiù. O ad andare verso quell'hotel in lontananza. Non so come ci è finito lì, ma ho sentito che fanno dei prezzi abbastanza buoni. Non che il denaro abbia importanza qui.",
				"Perché sono il sovrano?^... Non ne sono sicuro, ma i miei amici hanno deciso che fosse appropriato mettermi qui, date le condizioni attuali di questo spazio. Forse è perché i cubi sono i migliori nel restare seduti sulle superfici piatte. Sul perché è necessario che qualcuno sia seduto qui - ah, non ne ho idea!",
				"Gli altri - i miei amici laggiù - hanno ognuno i propri meriti. Non è impossibile che in futuro siano loro a sedersi qui, è che non possono farlo ora. A volte cambiamo chi fa il sovrano, ma ogni volta dobbiamo reinterpretare questa porzione di spazio! Può succedere che il Signor o la Signora Piramide vengano qui perché decidiamo di dare al trono una forma che si confà meglio alla loro forma, reimmaginando questo mondo, per così dire. Ti sembra stupido? Può essere. Però qui funziona così. Succede abbastanza in fretta. Minuti, ore - i regni non sono necessariamente lunghi.",
				"Però, quando sono il sovrano, mi sento strano... come se fossi isolato, come se volessi evitare gli altri...",
				"... ma isolamento non è la parola giusta, anche se descrive in parte la sensazione. Non sono isolato, e non odio gli altri. Ci consideriamo tutti amici, ma sai, nessuno viene effettivamente qui se non per scambiare qualche parola. Quindi devo mettermi a pensare, o rischio di impazzire! Forse è parte dell'isolamento.",
				"A parte domande folli sul *perché* siamo qui a occupare questo spazio, sarei anche curioso di capire perché siamo amici.",
				"Mi piace pensare che quando siamo sotto l'interpretazione che sia io la migliore scelta come sovrano, loro mi danno conforto permettendomi di mantenere la mia posizione per tutto il tempo che serve a raggiungere l'interpretazione successiva. Sai, i loro incoraggiamenti, la loro presenza fisica, quelle cose mi danno conforto.",
				"Immagino che siano abbastanza per soddisfarmi, anche se sarebbe bello che qualcuno provasse a capire come mi sento a essere sovrano. Non che mi stia lamentando degli incoraggiamenti! Però forse potremmo avere più sovrani... che idea! Il che forse implica che quando non sono sovrano devo agire come ogni tanto vorrei che loro facessero... chissà se si può fare.",
				"Mi sono dilungato troppo. Se vai nella direzione opposta, c'è una regione di spazio simile a questa, anche se penso abbia un odore diverso.",
				"È stato un piacere incontrarti.",
				"Oh, vuoi ascoltare di nuovo la mia storia?",
				"Bene, mettiti comodo.")
		}
,
		gray: {
			dialogue: new Array(
				"Ciao. Sono il sovrano di questa parte di spazio.",
				"Cosa? Vuoi sapere perché sono qui? Sei sicuro? Ci vorrà un po' per spiegarti perché!",
				"Beh, se insisti. Anche se faresti meglio ad andare verso quell'hotel in lontananza. Non so perché abbiano deciso di costruirlo. Se dovessi pagarci delle tasse, sicuramente protesterei!",
				"Allora, anche se sono il sovrano di questa parte di spazio, non sto effetivamente regnando su nessuno.",
				"I miei amici sono tutti sovrani delle loro parti di spazio. Neanche loro regnano su qualcuno - in un certo senso siamo tutti soli. Ma non nel senso che non possiamo parlare fra noi. In quel senso, non siamo soli. Questo è solo un posto in cui io esisto.",
				"La mia parte di spazio e quelle dei miei amici sono molto simili nel modo in cui esistono e per come sono organizzate. Abbiamo interessi e desideri simili. Ci piace parlare molto su come regnare e così via.",
				"Ma è triste che non riusciamo quasi mai a incontrarci di persona.",
				"In realtà non stai parlando con loro nella loro forma fisica, ma con una loro rappresentazione olografica.",
				"Lo so, è un peccato. È un peccato perché abbiamo così tanto in comune, ma possiamo aiutarci a vicenda così poco.",
				"Quando non puoi parlare sempre faccia a faccia con qualcuno sembra come se manchi qualcosa.",
				"Ma non mi sto lamentando. È meglio del nulla assoluto! Non riesco a immaginare come sarebbe diversamente. Sarebbe terribile.",
				"È stato bello parlare con te, buona fortuna per qualunque cosa tu stia facendo.",
				"Sei ancora qui? Posso dirti tutto di nuovo, se vuoi.")
		}
	}
};

public static var cube_king_state:Object =
{
	SPACE: {
		color: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
,
		gray: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
	}
};

public static var forest_npc:Object =
{
	FOREST: {
		bunny: {
			dialogue: new Array(
				"Crickson: Ehi tu, brutto bullo!  Non ho paura di te!",
				"Crickson: Zucca vuota!  Non scapperò!  Neanche se me le darai di santa ragione!",
				"Crickson: Sei solo un grosso bruto con una scopa, ecco cosa sei!  Dovresti vergognarti di te stesso!")
		}
,
		thorax: {
			dialogue: new Array(
				"Thorax: Io sono il Thorax, e lasciamelo dire\n^Le api stan male, non fan che patire!\n^Alcune operaie son volate via\n^E nelle loro colonie ora c'è una moria!",
				"Thorax: Forse è un virus, o forse un veleno\n^Che qualcuno ha gettato nel loro terreno!\n^Qualche grossa azienda, per fare più soldi\n^Sporchi assassini, ladri, manigoldi!",
				"Thorax: Ok, non ho idea di che stia succedendo\n^Ma le api davvero stanno morendo.\n^Che posso fare, agire a casaccio?\n^... Trovato! Lo posto su Facebook, oh se lo faccio!")
		}
	}
};

public static var forest_npc_state:Object =
{
	FOREST: {
		bunny: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		thorax: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var shopkeeper:Object =
{
	FIELDS: {
		init: {
			dialogue: new Array(
				"Comprami qualcosa")
		}
	}
};

public static var shopkeeper_state:Object =
{
	FIELDS: {
		init: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var goldman:Object =
{
	FIELDS: {
		outside: {
			dialogue: new Array(
				"Che ci fai qui, delinquente?  Vai via! È mia di diritto!",
				"Non mollo mica!  Mai, nemmeno fra un milione di anni!")
		}
,
		inside: {
			dialogue: new Array(
				"Oh, sei tornato qui per terrorizzarmi ancora?",
				"Sei dalla parte dei gatti solo perché sono tutti carini e pelosi.")
		}
,
		etc: {
			dialogue: new Array(
				"Che ci fai qui, delinquente?  Vai via! È mio di diritto!^ Coooos?^ È un...?^ ALTRO GATTO???^  AAAAAHHHHHH!!!",
				"Tu hai... pulito casa mia... sono commosso!  Prendi, voglio donarti la cosa più bella che ho!",
				"Young prende e apre la scatola. C'è qualcosa dentro!",
				"Icky: Oh.  Ehi Miao.^\n\nMiao: Sono così felice che tu sia salvo!^\n\nIcky: Ehm... grazie per l'aiuto, Young.",
				"Icky: A essere sincero, mi piace sedere nelle scatole.")
		}
	}
};

public static var goldman_state:Object =
{
	FIELDS: {
		outside: {
			top: true,
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		inside: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		etc: {
			top: true,
			cur: "",
			pos: 0,
			loop: 4,
			dirty: false,
			finished: false
		}
	}
};

public static var miao:Object =
{
	FIELDS: {
		init: {
			dialogue: new Array(
				"Oh!!  Tu sei Young, Il Prescelto!!!!  Ommioddio, che onore!  Io sono Miao Xiao Tuan Er, aspirante Prescelto!",
				"Posso seguirti un po' per vedere un Prescelto in azione?",
				"Ciao di nuovo, Young!  Posso seguirti?")
		}
,
		randoms: {
			dialogue: new Array(
				"Miao: Ehi, Young... hai mai rubato qualcosa?",
				"Miao: Mi piace Mitra... e Manu è una bicicletta bellissima, non è vero?",
				"Miao: Cos'è quella specie di pietra fighissima, Young?  Ti fa tornare indietro nel tempo?!",
				"Miao: Sto iniziando a preoccuparmi per Icky... Young, hai visto un gatto più grande di recente? L'ultima volta Icky ha detto che sarebbe andato a fare una passeggiata nella piccola foresta a est.",
				"Miao: Icky ha detto che non dovrei andare in posti pericolosi. Ci vediamo, Young.",
				"Miao: Ti sei mai seduto in un mucchio di buste della spesa?",
				"Miao: Ehi Young, secondo te è sbagliato farsi di erba gatta?",
				"Miao: Scommetto che ci è voluto un sacco di lavoro per diventare il Prescelto, eh Young?")
		}
,
		philosophy: {
			dialogue: new Array(
				"Quella situazione spaventosa con Icky mi ha dato da pensare... Secondo te che succede dopo che muoriamo?  Come è possibile riuscire a portare a compimento il nostro scopo nel corso di una sola vita?",
				"È possibile che ci reincarniamo fino a compiere il nostro destino.  O renderebbe le cose troppo facili?",
				"E qual è la nostra ricompensa per aver portato a termine il percorso?  O semplicemente svaniamo nel nulla?",
				"Hmm...")
		}
,
		icky: {
			dialogue: new Array(
				"Oh.  Ciao, Young.",
				"Il mio nome in realtà non è Icky. È Ichabod.",
				"Spero che Miao Xiao Tuan Er non ti abbia dato troppo fastidio.",
				"Ci vediamo, Young.")
		}
	}
};

public static var miao_state:Object =
{
	FIELDS: {
		init: {
			cur: "",
			pos: 0,
			loop: 2,
			dirty: false,
			finished: false
		}
,
		randoms: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		philosophy: {
			cur: "",
			pos: 0,
			loop: 3,
			dirty: false,
			finished: false
		}
,
		icky: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var generic_npc:Object =
{
	DEBUG: {
		melos: {
			dialogue: new Array(
				"Ehi ciao, come va? Mi hai trovato! Io rimango qui, fuori fa troppo freddo.",
				"Puoi dare la colpa a me per tutte quelle stanze orribili! Le ho create con il DAME map editor.",
				"Ho creato questo gioco con L'IDE FlashDevelop e il framework Flixel AS3!",
				"Ah sì, e ho creato la musica con REAPER DAW E a volte Audacity.",
				"In realtà prendo il mio nutrimento dal calore di tutti questi computer... ^Che vuol dire \"non è biologicamente possibile\"?",
				"Ciao mamma! ^e papà!",
				"Vuoi sapere come finire il gioco in 20 minuti?",
				"Ha! E pensi che te lo dica?",
				"(...forse se me lo chiedi cortesemente...)")
		}
,
		marina: {
			dialogue: new Array(
				"Ehi woah!",
				"Ho scritto un sacco di dialoghi per questo gioco!^ (...non questo dialogo però. Di questo se ne è occupato Melos.)",
				"Per la parte artistica ho usato Adobe Photoshop CS5 , Graphics Gale Free Edition e lo Snipping Tool di Windows 7!")
		}
	}
	,
	REDSEA: {
		first: {
			dialogue: new Array(
				"L'umidità qui è ottima per la pelle, ma pessima per i capelli.",
				"Mi piace stare qui.  Al giorno d'oggi, la gente passa l'intera estate correndo avanti e indietro fra il sole cocente e l'aria condizionata glaciale.  Quei cambi di temperatura repentini indeboliscono le ossa.",
				"È come quella maledetta mania di masticare i cubetti di ghiaccio.  Mia madre masticava i cubetti di ghiaccio quando aveva quasi 30 anni.  Ora i suoi molari sono pieni di microfratture.")
		}
,
		second: {
			dialogue: new Array(
				"Mi raccomando a cambiarti le scarpe e a riempirle con carta di giornale per farle asciugare.  Non vorrai creare un nido di batteri.",
				"Perché nei buffet servono solo gelatina ROSSA? È come se volessero farci venire il cancro.")
		}
,
		bomb: {
			dialogue: new Array(
				"Allontanati da me.",
				"Dico davvero... lasciami in pace.")
		}
	}
	,
	BLUE: {
		one: {
			dialogue: new Array(
				"Non mi serve la tua pietà, Young.",
				"Certo, continua a vivere nel tuo piccolo mondo felice, \"Prescelto\"...",
				"Sai Young, l'amicizia è solo un modo che la gente usa per ingannarsi.  La verità è che siamo dei pezzi di merda, e alla fine siamo tutti soli.",
				"Hah, sapevo che mi odiavi, Young.",
				"Sto bene.",
				"Chiaramente non ti importa, a nessuno importa.")
		}
	}
	,
	HOTEL: {
		one: {
			dialogue: new Array(
				"So che le città sono sporche e caotiche, ma a me piace venire qui e guardare tutte queste luci.",
				"È bello, a modo suo.  Non è una bellezza infinita come quella delle stelle, ma nella loro umanità queste luci hanno un fascino più profondo, più complesso.",
				"Dietro ogni luce c'è una persona, ci sono speranze, paure e segreti... Guardare mi fa sentire terribilmente solo, ma in profonda intimità.",
				"Credo di amare ogni persona dietro ogni finestra.  Io vi amo, perché siete le mie stelle.  Vi amo, e non importa quanto di merda sia la vostra vita, o quanto in basso pensate di essere caduti.  Stanotte siete stupendi...",
				"Scusami, sto blaterando.  Grazie per avermi ascoltato.")
		}
	}
	,
	REDCAVE: {
		easter_egg: {
			dialogue: new Array(
				"Eeeehiiii... rilassati e rimani un pooooo', eh?")
		}
	}
	,
	APARTMENT: {
		easter_egg: {
			dialogue: new Array(
				"Ah! Mi hai trovato!")
		}
	}
	,
	CLIFF: {
		quest_normal: {
			dialogue: new Array(
				"Golem: Ti ho colpito con un masso mentre salivi?  A volte lancio massi quando sono arrabbiato.  Scusami se ti ho colpito.",
				"Golem: Mia madre diceva sempre che se avessi continuato a farlo, avrei finito la montagna.  Prima che la trivellassero.")
		}
,
		second: {
			dialogue: new Array(
				"Golem: Se sei una roccia, vedi molte generazioni andare e venire.  Diventi antico, e più saggio del più saggio fra gli uomini.",
				"Golem: O almeno, quella è l'idea.  Ho rotto in mio binocolo un po' di tempo fa e da allora non riesco a capire che sta succedendo.",
				"Golem: In realtà non mi manca molto guardare la gente. È una noia.")
		}
,
		quest_event: {
			dialogue: new Array(
				"Golem: Oh sì, ho incontrato qualcuno che si era un po' perso... mi ha detto che sarebbe andato a dare un'occhiata alla spiaggia.")
		}
	}
	,
	BEACH: {
		quest_normal: {
			dialogue: new Array(
				"Non sono un'aragosta, sono un gambero.  Mi chiamo Hews.",
				"Hews: Sai qual è la cosa migliore dell'oceano?  Poter guardare l'orizzonte.",
				"Hews: L'oceano è come un piccolo assaggio salato di infinito.",
				"Hews: Una spiaggia affollata perde la sua magia.")
		}
,
		second: {
			dialogue: new Array(
				"Hews: Hai mai sentito parlare degli stomatopodi?  Hanno 16 fotorecettori che permettono loro di vedere la luce ultravioletta.  Riesci a immaginare di poter vedere altri colori?",
				"Hews: Penso che sarebbe bellissimo.  O forse no, abbiamo già abbastanza modi di odiarci l'un l'altro con i colori che abbiamo.")
		}
,
		quest_event: {
			dialogue: new Array(
				"Hews: Stai cercando qualcuno? Ero seduto qui quando alcune nuvole sono passate davanti al sole. Mentre il sole era coperto, qualcuno è venuto vicino a me e mi ha chiesto dove fosse qualcosa. Non ricordo cosa fosse, ma la persona è corsa via dicendo di andare verso la foresta.")
		}
	}
	,
	FOREST: {
		quest_normal: {
			dialogue: new Array(
				"James: I frutti di bosco sono un buon cibo.  Mi piacciono i frutti di bosco.",
				"James: Per piacere, stai attento a non defecare sui frutti di bosco.",
				"James: Finora, in questa stagione ho avuto rapporti sessuali 18 volte.   E ho mangiato 389 zampate di frutti di bosco.",
				"James: Hai dei frutti di bosco per James?")
		}
,
		second: {
			dialogue: new Array(
				"James: Ho scritto una poesia:\n^Quanto amo i frutti bosco\n^Quando son triste mi mettono a posto\n^Le farei a pezzettini e ne mangerei un pozzo\n^Di crostate ai frutti di... bosco!",
				"James: Cosa preferisci? Mirtilli o lamponi?",
				"James: Hai dei frutti di bosco per James?")
		}
,
		quest_event: {
			dialogue: new Array(
				"James: È venuto qualcuno. Non voleva i frutti di bosco. È andato nella zona sudest del lago a ovest.")
		}
	}
	,
	FIELDS: {
		easter_egg: {
			dialogue: new Array(
				"Olivia: Ciao, sono Olivia la coniglietta.",
				"Olivia: Mi sono rimasti così tanti cereali da mangiare! Amo i cereali.",
				"Olivia: La scatola è così grande. Non finisce mai!",
				"Olivia: Cereali infiniti!",
				"Olivia: Mhhhh... forse non è così male.")
		}
,
		bush: {
			dialogue: new Array(
				"Lonk: Eheheh, che scemo che sei, Young! Una scopa non è fatta per tagliare i cespugli!")
		}
,
		quest_normal: {
			dialogue: new Array(
				"Lonk: Mi guadagno da vivere tagliando cespugli.  A volte trovi oro nei cespugli tagliati! Eheheh!",
				"Lonk: L'economia sta andando davvero male sotto questo cespuglio...",
				"Lonk: A volte è difficile mantenere moglie e figli tagliando i cespugli... non sempre abbiamo da mangiare... ma il nostro focolare è sempre acceso! Eheheh!")
		}
,
		quest_event: {
			dialogue: new Array(
				"Lonk: Come? Sì! È venuto qualcuno. Ha detto che stava andando in un labirinto sotterraneo... scommetto che ci sono molti cespugli lì, eh Young? Eheheh!")
		}
,
		marvin: {
			dialogue: new Array(
				"Marvin: Ehi ciao, come va?",
				"Marvin: Dov'è Justin?",
				"Marvin: Non c'è nessuno qui attorno...")
		}
,
		chikapu: {
			dialogue: new Array(
				"Chika Chi!",
				"Chika Chika!!",
				"CHIIIII^\nKAAAA^\nPUUUUUUUUUU!!!!")
		}
,
		hamster: {
			dialogue: new Array(
				"Bob: A Bob il criceto piace parlare di sé in terza persona.",
				"Bob: Gli apostrofi sono la radice di tutti i ma'li.",
				"Bob: Silenzio! Sono impegnato a emanare un'aura cricetosa.",
				"Bob: ... Immagino che il modo migliore per imparare qualcosa è farla... Però... se facciamo qualcosa male, non stiamo solo migliorando nel farla male?",
				"Bob: Un vero uomo non piange mai... beh, al massimo lascia scorrere una singola lacrima dall'angolo del suo occhio lungo la sua faccia inaridita dal sole, mentre guida la sua Harley nel deserto senza usare casco né occhialoni. Ma non piange mai.",
				"Bob: Questo gioco è stato creato da un infinito numero di scimmie che hanno lavorato su un infinito numero di macchine da scrivere.",
				"Bob: Mi manca James...")
		}
,
		electric: {
			dialogue: new Array(
				"Kuribu: Il curry è giallo e piccante!",
				"Kuribu: Per l'avversario intelligente, danni aumentati!",
				"Kuribu: Hai guadagnato un'esperienza di 2!",
				"Kuribu: Ti dico il mio numero di telefono!  0*1-51*7-*4386")
		}
	}
	,
	TRAIN: {
		quest_normal: {
			dialogue: new Array(
				"Che STO FACENDO qui? Bella domanda! Sono capitato qui per caso. Mi sto nascondendo. Questo posto è sicuro, se non ti avventuri troppo lontano e lasci che quei tizi ti prendano.",
				"Sembra che io sia relativamente fortunato. Tutti questi morti appesi alle pareti - come sono morti? È un po' affascinante pensare a come sia successo. Sono stati attaccati dai mostri? Sono inciampati e caduti sugli spuntoni?",
				"È un po' macabro. Spero che non mi succeda. Il dolore fisico è una terribile prospettiva.")
		}
,
		quest_event: {
			dialogue: new Array(
				"Ah... ora che ci penso, una persona è passata di qui un po' di tempo fa. Ha detto che stava cercando qualcosa... e ti somigliava anche! Non ricordo quando, scusami. Qui si perde la cognizione del tempo. Però ha detto di essere diretto verso una città vicina.")
		}
	}
	,
	SUBURB: {
		quest_normal: {
			dialogue: new Array(
				"Ciao.",
				"Stai cercando qualcosa?",
				"Che stai guardando?",
				"No, non sono di qui. La cosa strana è che tu puoi vedermi e parlarmi, ma io non posso interagire con nessuno di loro. Ci sono tutti quegli assassini in giro, e nessuno sembra accorgersene. È strano.")
		}
,
		quest_event: {
			dialogue: new Array(
				"Sì. Ho visto una persona passare. Stava cercando qualcosa. Non so cosa fosse questo \"qualcosa\". Il tipo è andato via di fretta. Ha detto di dover andare in un'area di spazio alternativa. Sembra interessante.")
		}
	}
	,
	SPACE: {
		quest_normal: {
			dialogue: new Array(
				"EHI EHI EHIIIII - - - CHI SEI TU? ? ?",
				"IO SONO UN VIANDANTE. . . QUESTO È UNO DEI PUNTI DI SOSTA PIÙ POPOLARI LUNGO IL TRAGITTO DA A VERSO B.",
				"COSA È \"A\"? ? ? È LA MIA CITTÀ NATALE. . . VADO A VISITARE UN VECCHIO AMICO A B. . . È UN LUNGO VIAGGIO. . . MA FACCIO SACRIFICI. . . TU NO? ? ? RENDONO LA VITA PIÙ INTERESSANTE! ! !")
		}
,
		quest_event: {
			dialogue: new Array(
				"OHH - - - CERCHI UN ALTRO UMANO - - - CAPISCO. ^ LASCIA CHE ACCEDA ALLA MIA MEMORIA. . . READ ( 0X0C00400 , STDOUT , 100 ) ; \n . . . . . . \n . . . . . . \n A HA. . . \n QUEL TIPO HA AVUTO UN LAMPO DI GENIO E HA DETTO CHE SAREBBE ANDATO VERSO UNA CASETTA IN UN GIARDINO BEN CURATO. \n ORA CHE CI PENSO. . . TU GLI SOMIGLI MOLTO! ! ! SEI SICURO CHE LUI NON FOSSE TE? ?  EH? MMH?")
		}
	}
	,
	GO: {
		quest_normal: {
			dialogue: new Array(
				"In realtà stavi... ehm, ah. Ben fatto.",
				"La roccia riflette parzialmente la luce accecante della stanza. C'è inciso qualcosa: \"Presto, prima di dovermene andare di nuovo (si sta illuminando sempre di più, succede ogni volta) - la parte a nordovest della foresta blu - Ho visto un'altra entrata del tempio appena a nord, dopo quegli alberi - se solo potessi scambiare le cose a piacimento potrei raggiungerla... forse lo farò la prossima volta che tornerò in questo mondo.\"")
		}
,
		quest_event: {
			dialogue: new Array(
				"La roccia lucente riflette solo parzialmente la luce della stanza. C'è inciso qualcosa: \"Presto, prima di dovermene andare di nuovo (si sta illuminando sempre di più, succede ogni volta) - la parte a nordovest della foresta blu - Ho visto un'altra entrata del tempio appena a nord, dopo quegli alberi - se solo potessi scambiare le cose a piacimento potrei raggiungerla... forse lo farò la prossima volta che tornerò in questo mondo.\"")
		}
	}
};

public static var generic_npc_state:Object =
{
	DEBUG: {
		melos: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		marina: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDSEA: {
		first: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		second: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		bomb: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BLUE: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	HOTEL: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	REDCAVE: {
		easter_egg: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	APARTMENT: {
		easter_egg: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	CLIFF: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		second: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	BEACH: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 1,
			dirty: false,
			finished: false
		}
,
		second: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	FOREST: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		second: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	FIELDS: {
		easter_egg: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		bush: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		marvin: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		chikapu: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		hamster: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		electric: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	TRAIN: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	SUBURB: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	SPACE: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
	,
	GO: {
		quest_normal: {
			cur: "",
			pos: 0,
			loop: 1,
			dirty: false,
			finished: false
		}
,
		quest_event: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var geoms:Object =
{
	SPACE: {
		gray1: {
			dialogue: new Array(
				"CIAO. HAI GIÀ INCONTRATO cubo?",
				"cubo È UN OTTIMO SOVRANO DI QUESTA PORZIONE DI SPAZIO. ANCHE NOI ALTRI SOVRANI FACCIAMO DEL NOSTRO MEGLIO NEI NOSTRI SPAZI.")
		}
,
		gray2: {
			dialogue: new Array(
				"CHE NE PENSI DI QUESTA PARTE DI SPAZIO? È UN BUON PUNTO DI INCONTRO, NO?",
				"UNA INTERSEZIONE DI MONDI!")
		}
,
		gray3: {
			dialogue: new Array(
				"NESSUNA DI NOI PIRAMIDI GRIGIE È DAVVERO QUI. USIAMO DEI CONGEGNI SPECIALI CHE CI PERMETTONO DI PROIETTARCI QUI.",
				"PERCHÉ LO FACCIAMO? PERCHÉ VOGLIAMO PARLARE CON IL NOSTRO AMICO cubo E TENERE COMPAGNIA A cubo.")
		}
,
		graydead: {
			dialogue: new Array(
				"*bzrrrrt*")
		}
,
		grayspin: {
			dialogue: new Array(
				"... IL DISPOSITIVO OLOGRAFICO STA FUNZIONANDO CORRETTAMENTE?",
				"NO?^...^MALEDIZIONE!")
		}
,
		color1: {
			dialogue: new Array(
				"Hai conosciuto CUBO? Fa delle cose fantastiche! Ho sentito che una volta è rimasto appoggiato su uno spigolo per circa dodici secondi. Oh cielo! Sai che significa per la Lega degli Appoggiatori sugli Spigoli? No? Beh, molto!")
		}
,
		color2: {
			dialogue: new Array(
				"CUBO fa un sacco di lavoro interessante!",
				"Hai sentito? Pare che fra poco toccherà a me fare il sovrano! Fra qualche minuto, credo.")
		}
,
		color3: {
			dialogue: new Array(
				"Vengo da Pan di Zucchero, vado verso Taipei. Perché sono qui? Oh, sono passato a salutare CUBO!",
				"Non essere così abbattuto! Questo posto è solo una strana rappresentazione per non shockare tutti i visitatori. Per quanto ne sappiamo, è per la maggior parte innocuo.")
		}
,
		colordead: {
			dialogue: new Array(
				"(... sta facendo un pisolino?)")
		}
	}
};

public static var geoms_state:Object =
{
	SPACE: {
		gray1: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		gray2: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		gray3: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		graydead: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		grayspin: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		color1: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		color2: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		color3: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		colordead: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var redboss:Object =
{
	REDCAVE: {
		before_fight: {
			dialogue: new Array(
				"OGNI GENERAZIONE NASCE NEL DOLORE PER MORIRE NEL DOLORE.  NON SOFFRIREMO PER CONTINUARE IL CICLO.  NON ANDREMO ALL'ESTERNO.")
		}
,
		after_fight: {
			dialogue: new Array(
				"È QUESTO IL TUO CASTIGO PER LA NOSTRA RIBELLIONE?")
		}
	}
};

public static var redboss_state:Object =
{
	REDCAVE: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var circus_folks:Object =
{
	CIRCUS: {
		before_fight: {
			dialogue: new Array(
				"Perché privi Colui Che Vede dei suoi sacrifici? Perché ci hai rubato la nostra salvezza?")
		}
,
		after_fight: {
			dialogue: new Array(
				"... Abbiamo fallito nel fartela pagare per la tua interferenza.  Eppure... ci hai ridato la possibilità di essere liberi.  Grazie, Young.  Possa Colui Che Vede concederti nuovamente il suo favore.")
		}
	}
};

public static var circus_folks_state:Object =
{
	CIRCUS: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var wallboss:Object =
{
	CROWD: {
		before_fight: {
			dialogue: new Array(
				"Che bello vederti, Yang.  Ne è passato di tempo.  Stai ancora giocando a quei nintendo, eh?")
		}
,
		after_fight: {
			dialogue: new Array(
				"Per amor del cielo, Yon, quando ti deciderai a crescere? Sai, dovrai imparare ad avere a che fare con la gente prima o poi.")
		}
	}
};

public static var wallboss_state:Object =
{
	CROWD: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var eyeboss:Object =
{
	HOTEL: {
		before_fight: {
			dialogue: new Array(
				"Qui disponiamo di tutti i comfort.  Ti piace la nostra piscina?")
		}
,
		middle_fight: {
			dialogue: new Array(
				"Che ne pensi del nostro centro fitness di ultima generazione?")
		}
,
		after_fight: {
			dialogue: new Array(
				"Speriamo che ti sia goduto il soggiorno!")
		}
	}
};

public static var eyeboss_state:Object =
{
	HOTEL: {
		before_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		middle_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		after_fight: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var suburb_walker:Object =
{
	SUBURB: {
		words_adult: {
			dialogue: new Array(
				"Oggi è una bella giornata.",
				"Grazie per avermi grattato la parte che mi prudeva sul collo - non riuscivo a raggiungerla.",
				"Ho sentito che il ristorante qui in zona fa delle ottime uova.  Ho anche un coupon per prenderle.",
				"Hai visto l'incidente d'auto di oggi? È stato orribile! Lui era al cellulare. Che peccato, così giovane!",
				"Mio figlio non è riuscito a entrare nella squadra giovanile dell'università.  Che delusione. Abbiamo investito così tanto nella sua carriera sportiva.",
				"Oggi è il giorno del ringraziamento. Sono grato per molte cose. Non vedo l'ora che arrivi domani mattina per i saldi. Farò un sacco di affari.",
				"Ah, penso che potrei far tardi a lavoro.",
				"Vado un po' di fretta, devo tornare a casa per mettere in ordine prima che arrivino i miei suoceri.",
				"Stiamo facendo un mercatino dell'usato in garage!",
				"Benvenuto!")
		}
,
		words_teen: {
			dialogue: new Array(
				"Non ho visto l'ultimo film.")
		}
,
		words_kid: {
			dialogue: new Array(
				"Non devo mai vedere l'ultimo cartone!")
		}
,
		family: {
			dialogue: new Array(
				"Benvenuto nella nostra casa, straniero! Mi sembri familiare. Questa è una cittadina pacifica. Abbastanza tranquilla, senza molti visitatori.",
				"Ti piacciono i Davement? Mio fratello Dave mi ha fatto sentire una loro canzone molto bella!")
		}
,
		older_kid: {
			dialogue: new Array(
				"I miei amici amano ascoltare \"Nessuna sopresa\" delle \"Teste di radio\" e lamentarsi di questo posto. Non sarà fantastico, ma che diamine, almeno mostra un po' di gratitudine! O fa' qualcosa per cambiarlo! Sono tutti dei... Oh, scusa. A volte tendo a fare così...",
				"Andrò a scrivere sul mio blog.",
				"Certo che sembri intontito.",
				"Ho difficoltà a sentire i miei stessi pensieri con gli sport a tutto volume alla TV, ma ai miei genitori piace.")
		}
,
		hanged: {
			dialogue: new Array(
				"Un biglietto sul cadavere: \"Così non sarò più in pericolo.\"")
		}
,
		festive: {
			dialogue: new Array(
				"Oh, che succede fuori? Un festival? Una parata?",
				"Sembra che ci sia una bella confusione lì fuori! Hai guardato fuori dalla finestra di recente? Mi chiedo cosa possa essere.")
		}
,
		paranoid: {
			dialogue: new Array(
				"In casa mia ci sono molte finestre. Non mi piacciono le finestre. È come se qualcuno stesse sempre guardando dentro. E tu sai che CI DEVE essere qualcosa là fuori. Non può essere sempre così silenzioso, così silenzioso e tranquillo - mi inquieta.",
				"Assassini? Cosa? Fuori? Di che stai parlando? Mi stai prendendo in giro? Non ci sono mai stati assassinii in questa città prima d'ora, ma... stai iniziando a farmi preoccupare... penso che forse dovresti andartene.",
				"Per piacere, vai via.")
		}
,
		dead: {
			dialogue: new Array(
				"Questa donna è stata colpita a morte con un corpo contundente.",
				"È stato davvero un duro colpo...")
		}
	}
};

public static var suburb_walker_state:Object =
{
	SUBURB: {
		words_adult: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		words_teen: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		words_kid: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		family: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		older_kid: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		hanged: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		festive: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		paranoid: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		dead: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var suburb_blocker:Object =
{
	SUBURB: {
		one: {
			dialogue: new Array(
				"Oh, sei tu! Mi sembri familiare... non posso muovermi finché non uccidi abbastanza cittadini, ricordi? Torna fra un po'.",
				"Secondo questo volantino... devi uccidere ancora qualche persona! Continua così.",
				"Ci serve solo un altro corpo, poi potremo continuare.",
				"Ben fatto. Sentiti libero di entrare. Non ho idea di cosa ci sia lì dentro. Ci vediamo domani a quest'ora, giusto? O la notte successiva?")
		}
	}
};

public static var suburb_blocker_state:Object =
{
	SUBURB: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var card:Object =
{
	ETC: {
		one: {
			dialogue: new Array(
				"Non mi importa se gli alberi mi guardano.",
				"Dov'è lei?!",
				"Sarò con te, Young, ogni volta che sarai solo.",
				"Sei un Ookchot?  Mia madre mi ha sempre messo in guardia contro il Pericoloso Ookchot.",
				"È da un gel po' che non ci vediamo, Young!  Blobabilmente non dovrei pensarci ma...  Mi trovi flaccido?  Mi hanno dato del Buddhino!",
				"Pew, Pew, Pew, Pew, Pew, Pew, Pew, Pew, Pew, Pew, Pew, Pew, Meno, Per, Diviso, Fratto...",
				"Offerta limitata! Compra uno, prendi uno gratis - solo per oggi!",
				"Ricordi quella volta che hai acceso una candela perché era andata via la luce?",
				"Mmmm, si stava comodi sul tuo cuscino ieri notte.",
				"Questo  gli insegnerà a non chiamarmi fumi-GAY-tore.",
				"Manu e io facciamo una bella squadra.",
				"Sono l'Aspirante Prescelto!!!",
				"A volte non ti sembra che, qualunque cosa tu faccia, non puoi impedire la fine del mondo?",
				"Attento ai funghi della foresta...",
				"Mi dispiace. È la mia natura.",
				"In che senso, SOLO una roccia??  Anche le rocce possono stare sulle carte, sai?!",
				"Dai un pesce a un uomo, e lui mangerà per un giorno.  Insegna a pescare a un uomo, e gli darai dei momenti in cui legare con suo figlio Jimmy.",
				"A volte la risposta è fare una passeggiata.",
				"Perché i pipistrelli volano basso ogni volta che ti avvicini?",
				"NO, *TU* HAI BISOGNO DELL'APPARECCHIO!",
				"SEI FELICE ORA?",
				"Non usare la violenza vicino a me.",
				"Ho sempre voluto partecipare a Master Chef.",
				"La mamma diceva sempre, 'se inarchi così la schiena finirai per rimanere così!'",
				"Ti stai divertendo, umano?",
				"...",
				"Scientificamente parlando, i rospi sono un sottoinsieme delle rane.",
				"AHAHAHAH!  Sì!  LO SO!",
				"Oh, anche tu collezioni carte?  È molto di classe, Ying.",
				"Mi dicevano sempre, \"Smettila di stare al computer! O non avrai nessun amico!\"",
				"Sono il sovrano solo per la durata di una conversazione.",
				"Scommetto che pensi di 'star rendendo il mio lavoro interessante'!",
				"Odio le diagonali.",
				"Non pensare che uno stupido antistaminico funzioni con me.",
				"Usa questa carta per sbloccare la porta della tua stanza!",
				"Sto facendo un ottimo lavoro.",
				"........??",
				"Chi diavolo ci ha scolpiti?",
				"Spero che tu abbia trascorso un piacevole soggiorno.",
				"Visto che sei arvrivato fin qui, devi essere un tipo interassante.",
				"Sono qui solo per portarti fuori strada.",
				"Tu ci sembri una piramide!",
				"È sempre lo stesso maledetto spettacolo, notte dopo notte, e la paga fa schifo.",
				"Lasciami in pace! Il mio cognome non è Sachs!",
				"Almeno non sono solo una mazza.",
				"Il denaro non cresce sugli alberi? Che vuoi dire? Eheheheh!",
				"Non sono altro che un'illusione.",
				"MI SFOGHERO' CON TE.")
		}
	}
};

public static var card_state:Object =
{
	ETC: {
		one: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

public static var misc:Object =
{
	any: {
		controls: {
			dialogue: new Array(
				"Premi",
				"Per selez. comandi.",
				"Per cancellare.",
				"Su",
				"Giù",
				"Sinistra",
				"Destra",
				"Salta",
				"Attacca",
				"Menù",
				"Premi",
				"per uscire",
				"per impostare i comandi.")
		}
,
		title: {
			dialogue: new Array(
				"Premi le\nfrecce direzionali per ridimensionare\nla finestra finché\nnon riesci a vedere\nzone nere sui\nbordi.\n\nPremi",
				"Quando hai terminato.",
				"ANODYNE",
				"Melos Han-Tani\Marina Kittaka",
				"Qualunque tasto",
				"Premi",
				"Per iniziare",
				"Versione",
				"Continua",
				"Nuovo gioco",
				"Sei sicuro?\nNo\nSì",
				"Davvero?\nNah\nDai, sì",
				"Davvero davvero??\nScherzavo\nCerto",
				"morti",
				"carte",
				"Anodyne supporta\nla maggior parte dei controller.\n\nNe userai uno?\n\nSì   No\n\nSe sì, connettilo adesso.\n\nMuoviti con le frecce direzionali\n\nSeleziona usando\nC, SPAZIO, o ENTER\n\nSi applicherà sì di default in\n",
				"Press BACK again\nto exit.\nUnsaved progress\nwill be lost.",
				"NOTA\n\nSe ci sono lag di movimento\ndurante la partita,\nritorna alla schermata inziale e\nrientra in Anodyne.\n\nPREMI C PER CONTINUARE\n\nL'interfaccia grafica non appare come dovrebbe?\nPremi il tasto qui sotto\n\ne orienta di nuovo il dispositivo.")
		}
,
		gui: {
			dialogue: new Array(
				"menù=enter",
				"Salvataggio...")
		}
,
		map: {
			dialogue: new Array(
				"Mappa",
				"Stanza attuale",
				"Porta/Uscita",
				"Ness. mappa",
				"Ritorna al\nNexus",
				"Ritorna\nall' entrata")
		}
,
		items: {
			dialogue: new Array(
				"Oggetti",
				"Normale",
				"Scambia",
				"Estendi",
				"Amplia",
				"Un paio di scarpe a molla - premi",
				"per saltare!",
				"Un paio di scarpe da ciclismo.",
				"Una scatola di cartone vuota.",
				"Una chiave trovata nel tempio di Colui Che Vede.",
				"Una chiave trovata in una caverna sotterranea rossa.",
				"Una chiave trovata in una caverna di montagna.")
		}
,
		cards: {
			dialogue: new Array(
				"Carte",
				"carte")
		}
,
		save: {
			dialogue: new Array(
				"Salva",
				"Salvato!",
				"ERRORE",
				"Salva e torna\nalla schermata iniziale",
				"Vai alla schermata iniziale",
				"Salva ed esci",
				"Esci dal gioco",
				"Morti:")
		}
,
		config: {
			dialogue: new Array(
				"Config",
				"Imposta comandi",
				"Imposta volume",
				"Autosalvataggio nei\ncheckpoint:",
				"Attivato",
				"Disattivato",
				"Cambia\nRisoluzione:",
				"Config. interfaccia",
				"Touch + Frecce",
				"Solo frecce",
				"Solo touch",
				"Impostazioni movimento:",
				"Risoluzione:",
				"Mod. finestra",
				"Regola int.",
				"Estendi",
				"risoluz.:",
				"Lingua:",
				"ja",
				"en",
				"Trascina i\npulsanti\nfino a raggiungere\n una posizione ideale.\n\nPoi, tocca il\nmenù\nper continuare.\n\n",
				"Dimensione\nfinestra",
				"Config. joypad")
		}
,
		secrets: {
			dialogue: new Array(
				"Ci sei dentro fino al collo!",
				"Un tempo di proprietà di un famoso Mago delle Bolle.",
				"Se la grafica sembra criptata, cerca la definizione del pokedex di un pokemon ufficiale.",
				"Questo cuore non ha nome.",
				"Prego, fai visita al mondo dei mostri elettrici.",
				"La statua di un gattino. Carina, ma inutile.",
				"Oh cielo!!!!",
				"Oh no!!!!",
				"È nero.",
				"È rosso.",
				"È verde.",
				"È blu.",
				"È bianco.",
				":Seleziona",
				":Indietro")
		}
,
		swap: {
			dialogue: new Array(
				"Scusa!",
				"Lo swap non funzionerà qui.",
				"Young non è riuscito a raccogliere forze a sufficienza per usare lo swap qui.")
		}
,
		keyblock: {
			dialogue: new Array(
				"Questa porta è chiusa.")
		}
,
		treasure: {
			dialogue: new Array(
				"Una forza misteriosa ti impedisce di aprire questo forziere.",
				"L'incisione sul manico della scopa recita: Premi",
				"per spazzare.",
				"Questa chiave può essere usata una sola volta per aprire un ostacolo che blocca il tuo percorso.",
				"Un misterioso paio di scarpe di marca con su scritto\"Premi",
				"\".",
				"Le poche parole sulla miglioria della scopa recitano\"Equipaggia la miglioria AMPLIA dal menù per permettere alla scopa di rilasciare polvere nociva a destra e sinistra.\"",
				"Le poche parole sulla miglioria della scopa recitano\"Equipaggia la miglioria ESTENDI dal menù per permettere alla scopa di rilasciare polvere nociva in avanti, oltre il suo normale raggio.\"",
				"Una nota accanto alla miglioria della scopa:\"Ciao, Young. Usa questa miglioria SWAP per scambiare di posto due pezzi di terreno. Potrebbe volerci un po' affinché tu possa usarla ovunque, ma dovrebbe esserti utile per ora.\"",
				"HAI TROVATO UN CUORE!!!! Vita massima aumentata di... zero.",
				"Goldman: Cosa? Non è qui? Quel negoziante deve averlo rubato!")
		}
,
		dust: {
			dialogue: new Array(
				"La tua scopa ora è piena di polvere!  Attacca di nuovo per farla posare.")
		}
,
		checkpoint: {
			dialogue: new Array(
				"Vuoi salvare?\n  Sì\n  No",
				"Mentre sei su un checkpoint, premi",
				"Per salvare i tuoi progressi e ripartire da qui se dovessi morire.")
		}
,
		rock: {
			dialogue: new Array(
				"C'è qualcosa scarabocchiato su questa roccia:")
		}
,
		door: {
			dialogue: new Array(
				"Il portale non sembra essere attivo.")
		}
,
		keyblockgate: {
			dialogue: new Array(
				"Il cancello non si muove. Non si aprirà finché non percepirà la presenza di quattro carte...",
				"Avendo percepito la presenza di quattro carte, il cancello decide di aprirsi.",
				"Il cancello rimane ostinatamente chiuso.",
				"Il cancello percepisce tutte le carte e decide di aprirsi.",
				"Il cancello percepisce abbastanza carte e decide di aprirsi.",
				"Si apre!",
				"Rimane chiuso.")
		}
,
		solidsprite: {
			dialogue: new Array(
				"Il cartello indica a est ma le parole sono sbiadite.",
				"Il cartello indica a ovest ma le parole sono sbiadite.",
				"Le parole sul cartello sono sbiadite.")
		}
,
		mitra: {
			dialogue: new Array(
				"Ehi Young!",
				"Queste scarpe da ciclismo sono per me?  Wow!  Grazie, Young!  Stavo proprio pensando di prenderne un paio, visto che Manu ha dei pedali ai quali puoi attaccare questo tipo di scarpe.  Tieni Young, prendi le mie scarpe in cambio!  Hanno queste molle fighissime che ti fanno saltare molto in alto! Premi",
				"per saltare mentre le indossi!",
				"Ciao, Young!  Noti niente di nuovo? ^... ^... Oh beh, vedi, ho comprato questo nuovo paio di scarpe da ciclismo!  Si attaccano ai pedali di Manu. Visto che non mi serviranno più le mie vecchie scarpe, voglio che le abbia tu, Young!  Hanno queste molle fighissime che ti fanno saltare molto in alto!",
				"per saltare mentre le indossi!",
				"Beh, ciao!",
				"Forza, provale!  ... Non puzzano COSì tanto.",
				"Belle, eh?",
				"Ehi, quelle sono le scarpe da ciclismo del negozio di Flinty?  Le stai dando a me?  Grazie Young, lo apprezzo moltissimo!  Tieni, in cambio prova queste scarpe -- Sono sicura che le troverai molto utili!  Sulle scarpe c'è scritto \"Premi",
				"per saltare\"  Non è molto chiaro però, non c'è nessun \"",
				"\" sulle scarpe...")
		}
,
		tradenpc: {
			dialogue: new Array(
				"Finty: Benvenuto, benvenuto Young, amico mio!  Io sono Prasandhoff--Finty Prasandhoff!  Dai un'occhiata e fammi sapere se ti interessa qualcosa!",
				"Finty: Ti sono ancora grato per quella scatola!",
				"Finty: Ah, una scatola! Grazie mille! Ora posso portare la mia merce a casa di notte e di nuovo qui al mattino!",
				"Aspetta un momento... non è qui! Che è successo? Aspetta, lasciami tamponare le tue ferite!",
				"Come segno della mia gratitudine, prendi queste eleganti scarpe da ciclismo!",
				"Buongiorno, amico mio! Una splendida mattinata, non trovi?  Un'ottima giornata per fare compere! Vorrei solo avere una scatola per poter trasportare la mia merce.",
				"Peccato, pare che non ti possa permettere questo oggetto!  Torna più tardi, quando avrai il denaro!",
				"Finty: Ah, hai buon occhio! Hai bisogno di un'arma migliore, non è così? Fai saltare in aria i tuoi nemici per soli $499.99!",
				"Finty: Quel sacco per le monete ti permetterà di accumulare il denaro che trovi nella Landa! È tuo per soli $869.99!",
				"Finty: Oh ho ho, questo è un oggetto assolutamente speciale: scarpe da ciclismo che si attaccano ai pedali, per essere veloci ED eleganti! È in offerta a soli $299.99!",
				"Finty: Stanco di spostare la polvere con la tua misera, piccola scopa?  Oblitera le particelle di polvere nociva con questo aspirapolvere all'avanguardia! A soli $749.99, o in quattro piccole, comode rate mensili da $199.99!",
				"Come segno della mia gratitudine, ti dono questa orribile--volevo dire, stupenda carta da collezione!^")
		}
,
		ending: {
			dialogue: new Array(
				"Anodyne\n-------\n\n\n\nUn gioco creato da\n\nMelos Han-Tani\n\ne\n\nMarina Kittaka\n\n-------------",
				"Creato fra\n\nmarzo 2012\n\ne\n\ngennaio 2013",
				"DESIGN\n------\nEntrambi",
				"PROGRAMMAZIONE\n-----------\nMelos, con la\nlibreria di Flixel\nper Actionscript 3\n\n\n\nART\n---\nMarina\n",
				"MUSICA/SFX\n---------\nMelos, con REAPER\ne soundfonts\ngratuiti.\n\n\n\nDIALOGHI\n--------------\nPrincipalmente Marina\n",
				"TRAMA\n-----\nEntrambi\nLocalizzazione\ngiapponese:\nKakehashi Games\nLocalizzazione\nspagnola:\nDiego Fenollar\nLocalizzazione\nitaliana:\nFrancesco D'Aucelli",
				"Un immenso grazie ai\nnostri testers,\nche hanno sofferto\naffinché voi\nnon doveste\nfarlo!\n--------------\n\nMarina, che ha\nsofferto molto\nper i bug iniziali.\n\nEtan, per il sostegno\ncostante, fin dal\nprincipio, con\nmolti bug \ntrovati, e il\nterzo umano a\ngiocare a quasi tutto\nil gioco.",
				"Olivia - grazie,\nsorellina!\n\nRunnan, Nick Reineke,\nEmmett, Poe, AD1337,\n Dennis, Andrew,\nAndrew MM\n Carl, Max, Amidos,\nLyndsey, Nathan\n",
				"Melos vorrebbe\nringraziare:\n\nMamma e Papà, per il\nloro sostegno costante\nin questa impresa.\n\nS\n\nMolti TIGSourcers\ne altri\ndevs incontrati!\n\nMarina, per aver reso\nquesto gioco possibile,\ne per averlo\nmigliorato in\nmille aspetti.",
				"Adobe, Adam Saltsman,\nFlashDevelop devs,\nREAPER devs,\nDAME creator,\nDesura, Gamersgate,\nIndieDB, TIGSource\n\n\nE i mei altri amici\nche mi hanno\nmostrato sostegno\n(Grazie!)\n\nInfine, ma non \n per importanza,\nTina Chen.\nVecchia amica,\ngraze per il sostegno\ne anche per\navermi presentato\na Marina.",
				"I ringraziamenti\n di Marina vanno a...\n\nColin Meloy, per\naver ampliato\nil mio vocabolario\n\nTsugumo, per\n\"E così vuoi fare il\nPixel Artist?\"\n\nAlla mia famiglia,\nper il sostegno\ne il cibo.\n\nA Daniel, per essere un\n\"Indie games dev\"\ncrescendo insieme.",
				"Mo, per aver creduto\n in me.\n\nTina, per\navermi presentato\na Melos.\n\nMelos, per aver creato\nun gioco e per esserti\nfidato così\ntanto\ndi me.",
				"CAST\n----\n\n\nSlime\n\n\nAnnoyer\n\n\nPew Pew\n\n\nShieldy\n\n\nSeer",
				"Mover\n\n\nOn Off\n\n\nFour Shooter\n\n\nSlasher\n\n\nRogue\n",
				"Dog\n\n\nFrog\n\n\nRotator\n\n\nPerson\n\n\nWall\n\n",
				"Rat\n\n\nGasguy\n\n\nSilverfish\n\n\nDasher\n\n\nRoller\n\nWatcher\n\n\n",
				"Dustmaid\n\n\nBurst Plant\n\n\nManager\n\n\n",
				"Lion\n\n\nContort\n\n\nFlame Pillar\n\n\nServants\nArthur\nJaviera",
				"Follower\n\n\nEdward\n\n\nFisherman\n\n\nRed Walker\n\nHews",
				"Rabbit\n\n\nIcky\n\n\nShopkeeper\n\nMiao Xiao Tuan Er\n\nRank\n\nGoldman",
				"Thorax\n\nJames\n\nMushroom\n\nCrickson\n\nGolem\n\nSuburbanites",
				"Chaser\n\n\nEntities\n\n\nSpace Faces\n\n\Cube Kings",
				"Young\n\n\nMitra\n\n\nSage\n\n\nBriar",
				"\n\n\n\n\n\n\n\n",
				"Vorremmo infine\nringraziare TE!\nPer aver giocato!\n\n\nSperiamo che\nti sia piaciuto.",
				"Ora sei in grado\n di esplorare il mondo\ndi Young senza\n(quasi) alcuna\nlimitazione, spostando\nil terreno con\nlo swap.\n")
		}
,
		elevator: {
			dialogue: new Array(
				"Piano?",
				"1\n",
				"2\n",
				"3\n",
				"4\n",
				"Cancella")
		}
	}
};

public static var misc_state:Object =
{
	any: {
		controls: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		title: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		gui: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		map: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		items: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		cards: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		save: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		config: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		secrets: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		swap: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		keyblock: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		treasure: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		dust: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		checkpoint: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		rock: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		door: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		keyblockgate: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		solidsprite: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		mitra: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		tradenpc: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		ending: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
,
		elevator: {
			cur: "",
			pos: 0,
			loop: 0,
			dirty: false,
			finished: false
		}
	}
};

}
}