import 'package:uuid/uuid.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';

class SeedData {
  SeedData._();

  static final _uuid = Uuid();

  static List<Canto> cantos() {
    final now = DateTime.now();
    return [
      // ─── ENTRADAS ───
      _canto(
        titulo: 'Aquí Estoy Señor',
        autor: 'Dan Schutte',
        categorias: ['entrada'],
        tiempos: ['ordinario'],
        tonalidad: 'G',
        letra: '{C}\nAquí estoy, Señor, vengo a tu altar,\na ofrecerte mi vida y mi cantar.\n\n{E1}\nDesde el alba te busco con fervor,\ntu presencia me llena de valor.\nEn silencio mi alma clama a ti,\ny en tu gracia encuentro mi vivir.\n\n{E2}\nCon humildad me acerco a tu mansión,\ny te entrego todo el corazón.\nGuíame, Señor, por tu sendero fiel,\nque tu amor me sabe siempre a miel.',
        acordes: '[G]Aquí estoy, [C]Señor, [D]vengo a tu al[G]tar,\na o[Em]frecerte mi [C]vida y mi [D]cantar.\n\n[G]Desde el [C]alba te [D]busco con fer[Em]vor,\ntu pre[C]sencia me [D]llena de va[G]lor.',
        now: now,
      ),
      _canto(
        titulo: 'Pescador de Hombres',
        autor: 'Cesáreo Gabaráin',
        categorias: ['entrada'],
        tiempos: ['todos'],
        tonalidad: 'D',
        letra: '{C}\nSeñor, me has mirado a los ojos,\nsonriendo has dicho mi nombre.\nEn la arena he dejado mi barca,\ny junto a ti buscaré otro mar.\n\n{E1}\nTú sabes bien lo que tengo,\nen mi barca no hay oro ni espada,\ntan solo redes y mi trabajo,\nmi voluntad de seguir tu mandar.\n\n{E2}\nTú necesitas mis manos,\nmi cansancio que a otros descanse,\namor que quiera seguir amando,\nen el camino de la verdad.',
        acordes: '[D]Señor, me has [G]mirado a los [A]ojos,\nson[Bm]riendo has [G]dicho mi [A]nom[D]bre.',
        now: now,
      ),
      _canto(
        titulo: 'Somos el Pueblo de Dios',
        autor: 'Tradicional',
        categorias: ['entrada'],
        tiempos: ['ordinario'],
        tonalidad: 'C',
        letra: '{C}\nSomos el pueblo de Dios,\ncaminando en la fe.\nCon esperanza y amor,\njuntos vamos hacia él.\n\n{E1}\nDesde los montes lejanos,\ndesde los valles del sur,\nvenimos todos cantando,\ncaminando hacia la luz.\n\n{E2}\nUna familia formamos,\nhijos del mismo Señor,\ny en su palabra confiamos,\nllenos de fe y de amor.',
        acordes: '[C]Somos el [F]pueblo de [G]Dios,\ncami[Am]nando en la [F]fe.\nCon espe[C]ranza y a[G]mor,\njuntos [F]vamos hacia [C]él.',
        now: now,
      ),
      _canto(
        titulo: 'Hosanna al Hijo de David',
        autor: 'Tradicional Litúrgico',
        categorias: ['entrada'],
        tiempos: ['semanaSanta'],
        tonalidad: 'Em',
        letra: '{C}\nHosanna, hosanna al Hijo de David,\nbendito el que viene en nombre del Señor.\nHosanna en las alturas,\ngloria en lo más alto.\n\n{E1}\nCon palmas y con ramos,\nrecibimos al Salvador,\nque viene lleno de gracia,\ntrayendo paz y amor.\n\n{E2}\nAbre las puertas del cielo,\nque el Rey de gloria va a entrar,\ncon júbilo y con canto,\nle vamos a aclamar.',
        acordes: '[Em]Hosanna, ho[Am]sanna al [B7]Hijo de Da[Em]vid,\n[Am]bendito el que [Em]viene en [B7]nombre del Se[Em]ñor.',
        now: now,
      ),
      _canto(
        titulo: 'Señor Ten Piedad',
        autor: 'Tradicional Litúrgico',
        categorias: ['entrada'],
        tiempos: ['cuaresma'],
        tonalidad: 'Am',
        letra: '{C}\nSeñor, ten piedad de nosotros.\nCristo, ten piedad de nosotros.\nSeñor, ten piedad de nosotros.\n\n{E1}\nTú que viniste a llamar a los pecadores,\nSeñor, ten piedad.\nTú que sanaste a los enfermos,\nCristo, ten piedad.\n\n{E2}\nTú que intercedes por nosotros ante el Padre,\nSeñor, ten piedad.\nTú que nos das tu cuerpo y sangre,\nCristo, ten piedad.',
        acordes: '[Am]Señor, ten [Dm]piedad de noso[E7]tros.\n[Am]Cristo, ten [Dm]piedad de noso[E7]tros.\n[Am]Señor, ten [Dm]piedad [E7]de noso[Am]tros.',
        now: now,
      ),
      _canto(
        titulo: 'Agua de Vida',
        autor: 'Tradicional',
        categorias: ['entrada'],
        tiempos: ['pascua'],
        tonalidad: 'G',
        letra: '{C}\nAgua de vida, fuente de gracia,\nmanantial que brota del costado de Cristo.\nVen a beber, ven a saciar tu sed,\nel agua viva que da vida eterna.\n\n{E1}\nEn el desierto de nuestra vida,\ntú eres oasis de consolación.\nAgua que limpia, agua que sana,\nrío de amor y de salvación.\n\n{E2}\nBautizados en tu nombre santo,\nrenacemos a una vida nueva.\nSumergidos en tu amor profundo,\nresurgimos llenos de tu gracia.',
        acordes: '[G]Agua de [C]vida, [D]fuente de [G]gracia,\n[Em]manantial que [C]brota del cos[D]tado de [G]Cristo.',
        now: now,
      ),
      _canto(
        titulo: 'Juntos Como Hermanos',
        autor: 'Cesáreo Gabaráin',
        categorias: ['entrada'],
        tiempos: ['todos'],
        tonalidad: 'D',
        letra: '{C}\nJuntos como hermanos,\nmiembros de una Iglesia,\nvamos caminando\nal encuentro del Señor.\n\n{E1}\nUn largo caminar\npor el desierto bajo el sol,\nno estamos solos,\nDios camina junto a nos.\n\n{E2}\nUnidos al rezar,\nunidos en una canción,\nviviremos juntos\ncerca del Señor.',
        acordes: '[D]Juntos como her[G]manos,\n[A]miembros de una I[D]glesia,\n[Bm]vamos cami[G]nando\nal en[A]cuentro del Se[D]ñor.',
        now: now,
      ),

      // ─── GLORIA ───
      _canto(
        titulo: 'Gloria a Dios en el Cielo',
        autor: 'Liturgia Romana',
        categorias: ['gloria'],
        tiempos: ['todos'],
        tonalidad: 'C',
        letra: '{C}\nGloria a Dios en el cielo,\ny en la tierra paz a los hombres\nque ama el Señor.\n\n{E1}\nPor tu inmensa gloria\nte alabamos, te bendecimos,\nte adoramos, te glorificamos,\nte damos gracias, Señor.\n\n{E2}\nSeñor, Hijo único, Jesucristo,\nSeñor Dios, Cordero de Dios,\nHijo del Padre,\ntú que quitas el pecado del mundo.',
        acordes: '[C]Gloria a [F]Dios en el [G]cie[C]lo,\ny en la [Am]tierra [F]paz a los [G]hombres\nque [F]ama el Se[G]ñor.',
        now: now,
      ),
      _canto(
        titulo: 'Gloria in Excelsis',
        autor: 'Tradicional Navideño',
        categorias: ['gloria'],
        tiempos: ['navidad'],
        tonalidad: 'G',
        letra: '{C}\nGloria in excelsis Deo,\ny en la tierra paz.\nCantemos al Señor que nace,\nal Emmanuel.\n\n{E1}\nLos ángeles del cielo cantan\nun canto de alegría,\nanunciando al mundo entero\nla noche de María.\n\n{E2}\nEn un pesebre humilde,\nnace el Salvador,\nla estrella guía a los pastores\nhacia el niño Dios.',
        acordes: '[G]Gloria in ex[C]celsis [D]De[G]o,\ny en la [Em]tierra [C]paz.\n[G]Cantemos al [C]Señor que [D]nace,\nal Emm[G]anuel.',
        now: now,
      ),

      // ─── SALMOS ───
      _canto(
        titulo: 'El Señor es Mi Pastor',
        autor: 'Salmo 22 (23)',
        categorias: ['salmo'],
        tiempos: ['todos'],
        tonalidad: 'D',
        letra: '{C}\nEl Señor es mi pastor, nada me falta.\nEn verdes praderas me hace reposar.\n\n{E1}\nMe conduce hacia fuentes tranquilas\ny repara mis fuerzas.\nMe guía por el sendero justo,\npor el honor de su nombre.\n\n{E2}\nAunque camine por cañadas oscuras,\nnada temo porque tú vas conmigo.\nTu vara y tu cayado me sosiegan,\ntú preparas una mesa ante mí.',
        acordes: '[D]El Señor es mi [G]pastor, [A]nada me [D]falta.\nEn [Bm]verdes pra[G]deras me hace [A]repo[D]sar.',
        now: now,
      ),
      _canto(
        titulo: 'Misericordia Señor',
        autor: 'Salmo 50 (51)',
        categorias: ['salmo'],
        tiempos: ['cuaresma'],
        tonalidad: 'Am',
        letra: '{C}\nMisericordia, Señor,\nhemos pecado.\nMisericordia, Señor,\nten piedad.\n\n{E1}\nOh Dios, crea en mí un corazón puro,\nrenuévame por dentro con espíritu firme.\nNo me arrojes lejos de tu rostro,\nno me quites tu santo espíritu.\n\n{E2}\nDevuélveme la alegría de tu salvación,\nafiánzame con espíritu generoso.\nSeñor, me abrirás los labios,\ny mi boca proclamará tu alabanza.',
        acordes: '[Am]Misericordia, [Dm]Señor,\n[E7]hemos peca[Am]do.\n[Dm]Misericordia, [Am]Señor,\n[E7]ten pie[Am]dad.',
        now: now,
      ),
      _canto(
        titulo: 'Gusten y Vean',
        autor: 'Salmo 33 (34)',
        categorias: ['salmo'],
        tiempos: ['todos'],
        tonalidad: 'G',
        letra: '{C}\nGusten y vean qué bueno es el Señor,\ndichoso el que se acoge a él.\nGusten y vean qué bueno es el Señor.\n\n{E1}\nBendigo al Señor en todo momento,\nsu alabanza está siempre en mi boca.\nMi alma se gloría en el Señor,\nque los humildes lo escuchen y se alegren.\n\n{E2}\nProclamemos la grandeza del Señor,\nensalcemos juntos su nombre.\nYo consulté al Señor y me respondió,\nme libró de todas mis ansias.',
        acordes: '[G]Gusten y [C]vean qué [D]bueno es el Se[G]ñor,\n[Em]dichoso el que se [C]acoge a [D]él.',
        now: now,
      ),

      // ─── OFERTORIO ───
      _canto(
        titulo: 'Pan de Vida',
        autor: 'Bob Hurd',
        categorias: ['ofertorio'],
        tiempos: ['todos'],
        tonalidad: 'F',
        letra: '{C}\nPan de vida, cuerpo del Señor,\nsanta copa, sangre de salvación.\nCada vez que comemos este pan,\ntu muerte anunciamos, Señor.\n\n{E1}\nFruto de la tierra y del trabajo,\nofrecemos este pan sobre el altar.\nQue se convierta en alimento santo,\ncuerpo del Señor para comulgar.\n\n{E2}\nFruto de la vid y del esfuerzo,\nofrecemos este vino al Señor.\nQue se transforme en bebida santa,\nsangre del Señor, fuente de amor.',
        acordes: '[F]Pan de [Bb]vida, [C]cuerpo del Se[F]ñor,\n[Dm]santa [Bb]copa, [C]sangre de salva[F]ción.',
        now: now,
      ),
      _canto(
        titulo: 'Toma Señor Recibe',
        autor: 'San Ignacio de Loyola / Trad.',
        categorias: ['ofertorio'],
        tiempos: ['todos'],
        tonalidad: 'G',
        letra: '{C}\nToma, Señor, recibe\ntoda mi libertad.\nMi memoria, mi entendimiento\ny toda mi voluntad.\n\n{E1}\nTodo mi haber y mi poseer,\ntú me lo diste,\na ti, Señor, lo retorno.\nTodo es tuyo, dispón de ello\nsegún tu voluntad.\n\n{E2}\nDame tu amor y tu gracia,\nque esas me bastan.\nNo te pido nada más,\ncon tu presencia a mi lado\ntodo lo demás me sobra ya.',
        acordes: '[G]Toma, [C]Señor, re[D]ci[G]be\ntoda mi liber[Em]tad.\n[C]Mi memo[D]ria, mi entendi[Em]miento\ny toda mi volun[D]tad.',
        now: now,
      ),
      _canto(
        titulo: 'Todo lo que Tengo',
        autor: 'Tradicional',
        categorias: ['ofertorio'],
        tiempos: ['todos'],
        tonalidad: 'C',
        letra: '{C}\nTodo lo que tengo,\nte lo vengo a entregar.\nMis manos, mis pasos,\nmi vida, mi cantar.\n\n{E1}\nTe ofrezco el trabajo de mis manos,\nel sudor de cada día,\nla alegría y los quebrantos,\ntodo es tuyo, vida mía.\n\n{E2}\nTe entrego los sueños de mi alma,\nlas palabras de mi boca,\ncada gesto de esperanza,\ncada lágrima que brota.',
        acordes: '[C]Todo lo que [F]tengo,\nte lo [G]vengo a entre[C]gar.\n[Am]Mis manos, mis [F]pasos,\nmi [G]vida, mi can[C]tar.',
        now: now,
      ),

      // ─── COMUNIÓN ───
      _canto(
        titulo: 'Cordero de Dios',
        autor: 'Liturgia Romana',
        categorias: ['comunion'],
        tiempos: ['todos'],
        tonalidad: 'Em',
        letra: '{C}\nCordero de Dios,\nque quitas el pecado del mundo,\nten piedad de nosotros.\n\n{E1}\nCordero de Dios,\nque quitas el pecado del mundo,\nten piedad de nosotros.\n\n{E2}\nCordero de Dios,\nque quitas el pecado del mundo,\ndanos la paz.',
        acordes: '[Em]Cordero de [Am]Dios,\nque [B7]quitas el pecado del [Em]mundo,\n[Am]ten pie[B7]dad de noso[Em]tros.',
        now: now,
      ),
      _canto(
        titulo: 'Tu Presencia',
        autor: 'Tradicional',
        categorias: ['comunion'],
        tiempos: ['todos'],
        tonalidad: 'G',
        letra: '{C}\nTu presencia, Señor, me transforma,\ntu presencia me llena de paz.\nEn el pan consagrado te encuentro,\nen el vino tu sangre me das.\n\n{E1}\nEn silencio me acerco a tu mesa,\ncon el alma dispuesta a escuchar.\nTu palabra es la luz de mi senda,\ntu presencia mi fuerza al caminar.\n\n{E2}\nGracias doy por el don de tu cuerpo,\npor la sangre que me hace vivir.\nEn la santa eucaristía te encuentro,\ny contigo ya puedo seguir.',
        acordes: '[G]Tu presen[C]cia, Se[D]ñor, me transfor[G]ma,\ntu pre[Em]sencia me [C]llena de [D]paz.',
        now: now,
      ),
      _canto(
        titulo: 'Ave María',
        autor: 'Tradicional Mariano',
        categorias: ['comunion'],
        tiempos: ['todos'],
        tonalidad: 'F',
        letra: '{C}\nAve María, llena eres de gracia,\nel Señor es contigo.\nBendita tú eres entre todas las mujeres,\ny bendito es el fruto de tu vientre, Jesús.\n\n{E1}\nSanta María, Madre de Dios,\nruega por nosotros, pecadores,\nahora y en la hora de nuestra muerte.\nAmén.\n\n{E2}\nMadre del cielo, reina de paz,\ncubre con tu manto a tus hijos.\nIntercede ante tu Hijo amado,\nllévanos siempre hacia su luz.',
        acordes: '[F]Ave Ma[Bb]ría, [C]llena eres de [F]gracia,\nel [Dm]Señor es [Bb]conti[C]go.',
        now: now,
      ),
      _canto(
        titulo: 'Yo Soy el Pan de Vida',
        autor: 'Tradicional Eucarístico',
        categorias: ['comunion'],
        tiempos: ['todos'],
        tonalidad: 'D',
        letra: '{C}\nYo soy el pan de vida,\nel que viene a mí no tendrá hambre.\nEl que cree en mí no tendrá sed.\nNadie viene a mí\nsi mi Padre no le atrae.\n\n{E1}\nEl pan que yo les daré\nes mi cuerpo, vida del mundo.\nEl que coma de este pan\nvivirá para siempre.\n\n{E2}\nYo soy la resurrección,\nyo soy la vida.\nEl que cree en mí,\naunque muera, vivirá.',
        acordes: '[D]Yo soy el [G]pan de [A]vi[D]da,\nel que [Bm]viene a [G]mí no ten[A]drá ham[D]bre.',
        now: now,
      ),
      _canto(
        titulo: 'Ven a Mí',
        autor: 'Tradicional',
        categorias: ['comunion'],
        tiempos: ['todos'],
        tonalidad: 'G',
        letra: '{C}\nVen a mí, todos los cansados,\nlos que llevan cargas de dolor.\nYo les daré descanso y alivio,\nvengan a beber de mi amor.\n\n{E1}\nNo tengas miedo, yo estoy contigo,\nyo te acompaño en el caminar.\nMi yugo es suave, mi carga ligera,\nen mis brazos puedes descansar.\n\n{E2}\nYo soy el agua que sacia la sed,\nel alimento que da la vida.\nVen a mi mesa, ven a comer,\nmi cuerpo entregado es tu comida.',
        acordes: '[G]Ven a [C]mí, [D]todos los can[G]sados,\nlos que [Em]llevan [C]cargas de [D]dolor.',
        now: now,
      ),

      // ─── SALIDA ───
      _canto(
        titulo: 'Gracias Señor',
        autor: 'Tradicional',
        categorias: ['salida', 'accionGracias'],
        tiempos: ['todos'],
        tonalidad: 'C',
        letra: '{C}\nGracias, Señor, por este día,\ngracias por tu amor sin fin.\nGracias por la eucaristía,\ngracias, Señor, por existir.\n\n{E1}\nPor la familia que me diste,\npor la fe que me sostiene,\npor la gracia que me asiste,\ngracias, Señor, que siempre vienes.\n\n{E2}\nAl salir de tu morada,\nllevo tu presencia en mí.\nCon el alma renovada,\nsalgo a servirte, Señor, así.',
        acordes: '[C]Gracias, Se[F]ñor, por [G]este dí[C]a,\n[Am]gracias por tu [F]amor sin [G]fin.',
        now: now,
      ),
      _canto(
        titulo: 'Vayan al Mundo',
        autor: 'Tradicional Misionero',
        categorias: ['salida'],
        tiempos: ['todos'],
        tonalidad: 'D',
        letra: '{C}\nVayan al mundo entero,\nanuncien la Buena Nueva.\nEl Señor los envía,\ncon su fuerza y con su luz.\n\n{E1}\nVayan sin miedo a proclamar\nla palabra del Señor.\nA los pobres y a los tristes,\nllévenles su amor.\n\n{E2}\nCon la fuerza del Espíritu,\ncon la fe como bandera,\nsalgan todos a anunciar\nla verdad del Redentor.',
        acordes: '[D]Vayan al [G]mundo en[A]tero,\na[Bm]nuncien la Buena [G]Nue[A]va.',
        now: now,
      ),
      _canto(
        titulo: 'El Señor Nos Convoca',
        autor: 'Tradicional',
        categorias: ['salida'],
        tiempos: ['todos'],
        tonalidad: 'G',
        letra: '{C}\nEl Señor nos convoca a su mesa,\ny después nos envía a servir.\nVamos juntos llevando su gracia,\nal hermano que espera por fin.\n\n{E1}\nEn el mundo seremos testigos\ndel amor que hoy aquí recibimos.\nCon las manos abiertas de hermanos,\nconstruyendo el reino de Dios.\n\n{E2}\nLa misión nos espera allá afuera,\nen la calle, el trabajo y el hogar.\nCon el gozo de Cristo en el alma,\nsalimos al mundo a anunciar.',
        acordes: '[G]El Señor nos con[C]voca a su [D]mesa,\ny des[Em]pués nos [C]envía a ser[D]vir.',
        now: now,
      ),
      _canto(
        titulo: 'Canto de Esperanza',
        autor: 'Tradicional',
        categorias: ['salida'],
        tiempos: ['todos'],
        tonalidad: 'C',
        letra: '{C}\nCaminemos con esperanza,\nel Señor va delante de ti.\nNo te rindas, no pierdas la calma,\nsu promesa se habrá de cumplir.\n\n{E1}\nAunque el mundo se llene de sombras,\ny la noche parezca sin fin,\nbrillará la estrella del alba,\ny un día nuevo vendrá para ti.\n\n{E2}\nDios camina contigo en la prueba,\nsu amor nunca te dejará.\nCon su gracia podrás cada día\ncaminar en su luz y su paz.',
        acordes: '[C]Caminemos con [F]esperan[G]za,\nel Se[Am]ñor va de[F]lante de [G]ti.',
        now: now,
      ),

      // ─── ESPECIALES ───
      _canto(
        titulo: 'Al Mundo Paz',
        autor: 'Isaac Watts / Trad. Navideño',
        categorias: ['entrada', 'varios'],
        tiempos: ['navidad'],
        tonalidad: 'D',
        letra: '{C}\nAl mundo paz, nació Jesús,\nnació ya nuestro Rey.\nEl corazón ya tiene luz,\ny paz su santa grey.\nY paz su santa grey.\n\n{E1}\nAl mundo paz, el Salvador\nen tierra reinará.\nYa es satisfecho el pecador,\nJesús perdón le da.\n\n{E2}\nAl mundo él gobernará\ncon gracia y con verdad.\nA las naciones mostrará\nsu amor y su bondad.',
        acordes: '[D]Al mundo [G]paz, na[A]ció Je[D]sús,\nna[D]ció ya nues[A]tro [D]Rey.',
        now: now,
      ),
      _canto(
        titulo: 'Oh Noche Santa',
        autor: 'Adolphe Adam / Trad.',
        categorias: ['varios'],
        tiempos: ['navidad'],
        tonalidad: 'C',
        letra: '{C}\nOh noche santa, noche de amor,\nnoche en que el Salvador nació.\nLos cielos brillan con su esplendor,\ny un nuevo día amaneció.\n\n{E1}\nEl mundo entero en oscuridad,\nyacía hasta que vino la luz.\nY en un pesebre de la ciudad,\nnació el niño Jesús.\n\n{E2}\nPostrémonos ante el Redentor,\ncantemos su gloria sin cesar.\nOh noche santa, de tanto amor,\nal niño Dios venid a adorar.',
        acordes: '[C]Oh noche [F]santa, [C]noche de a[G]mor,\n[C]noche en que el [F]Salva[C]dor na[G]ció.',
        now: now,
      ),
      _canto(
        titulo: 'De Sol a Sol',
        autor: 'Tradicional Fúnebre',
        categorias: ['varios'],
        tiempos: ['todos'],
        tonalidad: 'Am',
        letra: '{C}\nDe sol a sol te alabaré,\ndesde el alba hasta el ocaso.\nEn tu presencia viviré,\ny caminaré sin cansancio.\n\n{E1}\nCuando llegue el atardecer\ny mis fuerzas se agoten,\nen tus brazos descansaré,\ny tu paz será mi horizonte.\n\n{E2}\nNo le temo a la oscuridad,\nporque tú serás mi guía.\nHasta la eternidad\ncaminaré noche y día.',
        acordes: '[Am]De sol a [Dm]sol te ala[E7]ba[Am]ré,\ndesde el [Dm]alba hasta el o[E7]caso.',
        now: now,
      ),
      _canto(
        titulo: 'Cuando Pase el Temblor',
        autor: 'Tradicional',
        categorias: ['varios'],
        tiempos: ['todos'],
        tonalidad: 'G',
        letra: '{C}\nCuando pase la tormenta,\ncuando callen los temores,\nestarás ahí, Señor,\ncon tus brazos protectores.\n\n{E1}\nEn el valle de la sombra,\ntu luz brilla sin cesar.\nNo me dejas en la oscuridad,\nme acompañas al andar.\n\n{E2}\nDespués de cada prueba,\ntu gracia brilla más.\nEn la calma de tu gracia,\nencuentro siempre paz.',
        acordes: '[G]Cuando pase la tor[C]menta,\n[D]cuando callen los te[Em]mores,\nesta[C]rás ahí, Se[D]ñor,\ncon tus [G]brazos protec[G]tores.',
        now: now,
      ),
      _canto(
        titulo: 'Amor y Vida',
        autor: 'Tradicional Nupcial',
        categorias: ['varios'],
        tiempos: ['todos'],
        tonalidad: 'F',
        letra: '{C}\nAmor y vida, don de Dios,\nunidos en su nombre.\nDos almas, un solo corazón,\nbenditos por el Señor.\n\n{E1}\nEn este día tan especial,\nante el altar sagrado,\nprometemos caminar juntos\npor el sendero amado.\n\n{E2}\nQue tu bendición, Señor,\nacompañe este hogar.\nQue tu gracia y tu amor\nnunca dejen de brillar.',
        acordes: '[F]Amor y [Bb]vida, [C]don de [F]Dios,\n[Dm]unidos en [Bb]su nom[C]bre.',
        now: now,
      ),
      _canto(
        titulo: 'Ven Espíritu de Dios',
        autor: 'Tradicional de Pentecostés',
        categorias: ['entrada', 'varios'],
        tiempos: ['pentecostes'],
        tonalidad: 'Em',
        letra: '{C}\nVen, Espíritu de Dios,\nllena nuestros corazones.\nEnciende en nosotros el fuego de tu amor,\nrenueva la faz de la tierra.\n\n{E1}\nVen, Consolador divino,\nluz que alumbras todo ser.\nLlena lo más íntimo\ndel alma que confía en ti.\n\n{E2}\nDon de lenguas y de fuego,\nfuerza del amor de Dios.\nDanos valentía y coraje\npara ser testigos del Señor.',
        acordes: '[Em]Ven, Espí[Am]ritu de [B7]Dios,\n[Em]llena nuestros [Am]corazo[B7]nes.',
        now: now,
      ),
    ];
  }

  static Canto _canto({
    required String titulo,
    required String autor,
    required List<String> categorias,
    required List<String> tiempos,
    required String tonalidad,
    required String letra,
    required String acordes,
    required DateTime now,
  }) {
    return Canto()
      ..uuid = _uuid.v4()
      ..titulo = titulo
      ..autor = autor
      ..categorias = categorias
      ..tiempos = tiempos
      ..tonalidad = tonalidad
      ..letra = letra
      ..acordes = acordes
      ..esLocal = false
      ..esGlobal = true
      ..creadoEn = now
      ..actualizadoEn = now;
  }
}
