import '../models/question.dart';

class QuestionsDatabase {
  static const Map<QuestionTopic, Map<QuestionLevel, List<Map<String, String>>>> questions = {
    QuestionTopic.poetry: {
      QuestionLevel.easy: [
        {'q': '¿Qué es la poesía?', 'hint': 'Es un género literario que usa el lenguaje de manera especial...', 'category': 'Definiciones'},
        {'q': '¿Qué es un verso?', 'hint': 'Piensa en cada línea de un poema...', 'category': 'Definiciones'},
        {'q': '¿Qué es una estrofa?', 'hint': 'Es un grupo de versos, como un párrafo en prosa...', 'category': 'Definiciones'},
        {'q': '¿Qué es la rima?', 'hint': 'Tiene que ver con los sonidos al final de los versos...', 'category': 'Definiciones'},
        {'q': '¿Qué es un poema?', 'hint': 'Es una composición literaria escrita en verso...', 'category': 'Definiciones'},
        {'q': '¿Quién escribe los poemas?', 'hint': 'Se le llama poeta o poetisa...', 'category': 'Definiciones'},
        {'q': '¿Qué es el título de un poema?', 'hint': 'Es el nombre que el autor le da a su obra...', 'category': 'Definiciones'},
        {'q': '¿Los poemas siempre tienen que rimar?', 'hint': 'Existe algo llamado verso libre...', 'category': 'Definiciones'},
        {'q': '¿Qué son los sentimientos en un poema?', 'hint': 'Los poemas expresan emociones como alegría, tristeza, amor...', 'category': 'Definiciones'},
        {'q': '¿Qué es el lenguaje figurado?', 'hint': 'Es cuando las palabras no significan exactamente lo que dicen...', 'category': 'Definiciones'},
        {'q': '¿Qué es una canción de cuna? ¿Es poesía?', 'hint': 'Piensa en las canciones que se cantan a los bebés...', 'category': 'Definiciones'},
        {'q': '¿Qué es recitar un poema?', 'hint': 'Tiene que ver con leerlo en voz alta, con expresión...', 'category': 'Definiciones'},
        {'q': 'Decí un ejemplo de verso que rime con corazón.', 'hint': 'Pensá en palabras que terminen en -ón: canción, razón...', 'category': 'Práctica'},
        {'q': '¿Qué es una adivinanza? ¿Tiene algo de poesía?', 'hint': 'Las adivinanzas muchas veces riman y tienen ritmo...', 'category': 'Definiciones'},
        {'q': '¿Qué es un trabalenguas? ¿Tiene ritmo?', 'hint': 'Piensa en: Tres tristes tigres... Tiene musicalidad?', 'category': 'Definiciones'},
      ],
      QuestionLevel.medium: [
        {'q': '¿Qué diferencia hay entre rima consonante y asonante?', 'hint': 'En una coinciden TODOS los sonidos, en la otra solo las vocales...', 'category': 'Tipos de rima'},
        {'q': '¿Qué es el ritmo en un poema?', 'hint': 'Es la musicalidad, la cadencia al leerlo...', 'category': 'Elementos'},
        {'q': '¿Qué es una metáfora? Da un ejemplo.', 'hint': 'Es decir que algo ES otra cosa: tus ojos son estrellas...', 'category': 'Figuras literarias'},
        {'q': '¿Qué es una comparación o símil?', 'hint': 'Se usa como o parece: blanco como la nieve...', 'category': 'Figuras literarias'},
        {'q': '¿Qué es un poema lírico?', 'hint': 'Expresa sentimientos personales del autor...', 'category': 'Géneros'},
        {'q': '¿Qué diferencia hay entre un poema y una canción?', 'hint': 'Ambos tienen ritmo y pueden rimar, pero la canción tiene...', 'category': 'Comparación'},
        {'q': '¿Qué es la personificación? Da un ejemplo.', 'hint': 'Dar cualidades humanas a cosas: el sol sonríe...', 'category': 'Figuras literarias'},
        {'q': '¿Qué son los versos pareados?', 'hint': 'Son versos que riman de dos en dos (AA BB)...', 'category': 'Estructura'},
        {'q': '¿Cuántos versos tiene un soneto en una estrofa?', 'hint': 'El soneto tiene 14 versos en total, pero las estrofas...', 'category': 'Estructura'},
        {'q': 'Qué quiere decir verso libre?', 'hint': 'Es cuando el poeta no sigue reglas de rima ni métrica fija...', 'category': 'Tipos'},
        {'q': '¿Qué es la hipérbole? Da un ejemplo.', 'hint': 'Es una exageración: te lo dije un millón de veces...', 'category': 'Figuras literarias'},
        {'q': '¿Qué es una onomatopeya? Da un ejemplo.', 'hint': 'Son palabras que imitan sonidos: miau, tic-tac...', 'category': 'Figuras literarias'},
        {'q': 'Inventá una metáfora sobre la luna.', 'hint': 'La luna podría ser... una moneda, un ojo, una lámpara...', 'category': 'Práctica'},
        {'q': '¿Qué es la aliteración? Da un ejemplo.', 'hint': 'Repetir sonidos parecido: con el ala aleve del leve abanico...', 'category': 'Figuras literarias'},
        {'q': '¿Qué es el yo lírico?', 'hint': 'No es necesariamente el autor real, es la voz que habla en el poema...', 'category': 'Conceptos'},
      ],
      QuestionLevel.hard: [
        {'q': 'Leé estos versos e identificá la figura literaria: La luna es un espejo redondo.', 'hint': 'Dice que la luna ES algo... qué figura usa?', 'category': 'Análisis'},
        {'q': '¿Qué tipo de rima hay en: corazón / canción?', 'hint': 'Fijate si coinciden todos los sonidos a partir de la vocal acentuada...', 'category': 'Análisis'},
        {'q': '¿Qué tipo de rima hay en: cielo / viento?', 'hint': 'Coinciden solo las vocales (e-o) o también las consonantes?', 'category': 'Análisis'},
        {'q': 'Inventá dos versos que tengan rima consonante.', 'hint': 'Que terminen con los mismos sonidos: amor/dolor, estrella/bella...', 'category': 'Creación'},
        {'q': 'Qué figura literaria hay en: El viento susurraba entre los árboles?', 'hint': 'El viento puede susurrar de verdad? Eso es darle una cualidad...', 'category': 'Análisis'},
        {'q': 'Inventá una estrofa de 4 versos con rima ABAB.', 'hint': 'El verso 1 rima con el 3, y el 2 con el 4...', 'category': 'Creación'},
        {'q': '¿Qué es la anáfora? Dá un ejemplo.', 'hint': 'Es repetir una palabra al inicio de varios versos...', 'category': 'Figuras literarias'},
        {'q': 'Analizá: ¡Oh noche que guiaste! ¡Oh noche amable más que el alborada! ¿Qué figuras ves?', 'hint': 'Hay repetición al inicio de los versos y también personificación...', 'category': 'Análisis'},
        {'q': '¿Qué es un haiku? ¿Cuántas sílabas tiene?', 'hint': 'Es un poema japonés muy corto: 5-7-5 sílabas...', 'category': 'Formas poéticas'},
        {'q': 'Inventá un haiku (5-7-5 sílabas).', 'hint': 'Ejemplo: Viejo estanque / una rana salta / ruido de agua (Bashō)...', 'category': 'Creación'},
        {'q': '¿Qué diferencia hay entre poesía narrativa y poesía lírica?', 'hint': 'Una cuenta una historia, la otra expresa sentimientos...', 'category': 'Géneros'},
        {'q': 'Leé: La tierra es un plato azul. ¿Qué tipo de metáfora es?', 'hint': 'Compara la Tierra con un plato... es visual? Es pura?', 'category': 'Análisis'},
        {'q': 'Convertí esta frase en lenguaje figurado: La noche es oscura.', 'hint': 'Podrías usar una metáfora: La noche es un manto negro...', 'category': 'Creación'},
        {'q': '¿Qué es la métrica y por qué es importante en un poema?', 'hint': 'Tiene que ver con contar sílabas y el ritmo regular...', 'category': 'Conceptos'},
        {'q': 'Identificá las figuras literarias: Caminante, no hay camino, se hace camino al andar (Machado).', 'hint': 'Hay una paradoja (no hay camino/se hace camino) y metáfora (camino = vida)...', 'category': 'Análisis'},
      ],
    },
    QuestionTopic.naturalSciences: {
      QuestionLevel.easy: [
        {'q': '¿Dónde se encuentra el agua en la Tierra?', 'hint': 'En océanos, ríos, lagos, glaciares, el suelo y el aire.', 'category': 'Hidrósfera'},
        {'q': '¿Para qué se utiliza el agua subterránea?', 'hint': 'Para consumo humano, riego y actividades diarias.', 'category': 'Hidrósfera'},
        {'q': '¿Por qué el agua es un recurso natural esencial?', 'hint': 'Porque es necesaria para la vida y el funcionamiento del cuerpo.', 'category': 'Importancia del agua'},
        {'q': '¿Qué factores influyen en los ambientes acuáticos?', 'hint': 'La luz, la temperatura y la profundidad.', 'category': 'Ambientes acuáticos'},
        {'q': '¿Cómo afecta la contaminación a los seres vivos?', 'hint': 'Puede provocar enfermedades y dañar los ecosistemas.', 'category': 'Contaminación'},
        {'q': '¿Qué acciones ayudan a cuidar el agua?', 'hint': 'No contaminar, ahorrar agua y usar productos menos dañinos.', 'category': 'Contaminación'},
      ],
      QuestionLevel.medium: [
        {'q': '¿Qué función cumple la atmósfera y la biosfera?', 'hint': 'La atmósfera protege con aire, y la biosfera es donde habitan los seres vivos.', 'category': 'Subsistemas'},
        {'q': '¿Qué es la hidrósfera y qué tipos de agua la componen?', 'hint': 'Es el conjunto de toda el agua, incluyendo atmosférica y subterránea.', 'category': 'Hidrósfera'},
        {'q': '¿Qué es el agua subterránea y cómo se almacena?', 'hint': 'Es el agua bajo el suelo que se almacena en napas o acuíferos.', 'category': 'Hidrósfera'},
        {'q': '¿Qué es un ambiente acuático y cómo se clasifica?', 'hint': 'Lugar donde predomina el agua; continentales y oceánicos.', 'category': 'Ambientes acuáticos'},
        {'q': '¿Qué es la contaminación del agua y cuáles son sus causas?', 'hint': 'Presencia de sustancias dañinas por basura, químicos y desechos.', 'category': 'Contaminación'},
      ],
      QuestionLevel.hard: [
        {'q': '¿Cuáles son los subsistemas de la Tierra y qué incluye cada uno?', 'hint': 'Atmósfera (aire), hidrósfera (agua), geosfera (suelo) y biosfera (seres vivos).', 'category': 'Subsistemas'},
        {'q': '¿Cómo se distribuye el agua en la Tierra? ¿Por qué debemos cuidarla?', 'hint': '97% salada y 3% dulce. Es limitada y fundamental para la vida.', 'category': 'Importancia del agua'},
        {'q': '¿Cómo modifica el agua el paisaje?', 'hint': 'A través de la erosión (desgaste), transporte y sedimentación.', 'category': 'Importancia del agua'},
        {'q': '¿Qué adaptaciones tienen los seres vivos acuáticos?', 'hint': 'Plantas flotan o viven sumergidas; animales tienen branquias o piel adaptada.', 'category': 'Ambientes acuáticos'},
      ],
    },
    QuestionTopic.socialSciences: {
      QuestionLevel.easy: [
        {'q': '¿Dónde se ubica la República Argentina en el mundo y en América?', 'hint': 'Hemisferio sur y occidental, en América del Sur.', 'category': 'Ubicación'},
        {'q': '¿Qué características tiene la Cordillera de los Andes?', 'hint': 'Se ubica al oeste, allí se encuentra el Aconcagua.', 'category': 'Relieves'},
        {'q': '¿Qué tipos de climas se encuentran en Argentina?', 'hint': 'Cálido en el norte, templado en el centro, frío en el sur.', 'category': 'Clima'},
        {'q': '¿Qué se entiende por ambiente?', 'hint': 'Todo lo que rodea a los seres vivos (elementos naturales y sociales).', 'category': 'Ambiente'},
        {'q': '¿Qué son los recursos naturales?', 'hint': 'Elementos que ofrece la naturaleza como agua, suelo, minerales.', 'category': 'Recursos naturales'},
        {'q': '¿Qué son los espacios rurales?', 'hint': 'Zonas con menor población donde predominan actividades relacionadas con la naturaleza.', 'category': 'Espacios rurales'},
      ],
      QuestionLevel.medium: [
        {'q': '¿Qué superficie tiene Argentina y por qué es importante?', 'hint': 'Aprox. 2.780.400 km². Permite diversidad de climas y recursos.', 'category': 'Ubicación'},
        {'q': '¿Cómo se distribuye la población argentina?', 'hint': 'No es uniforme; la mayoría vive en ciudades (región pampeana).', 'category': 'Población'},
        {'q': '¿Cómo está organizada políticamente Argentina?', 'hint': 'País federal dividido en 23 provincias y una capital (CABA).', 'category': 'Organización política'},
        {'q': '¿Qué son los biomas y cuáles hay en Argentina?', 'hint': 'Regiones con clima y flora/fauna similares (selvas, bosques, desiertos).', 'category': 'Biomas'},
        {'q': '¿Qué actividades económicas se realizan en los espacios rurales?', 'hint': 'Agricultura, ganadería y explotación forestal.', 'category': 'Espacios rurales'},
      ],
      QuestionLevel.hard: [
        {'q': '¿Cuáles son los límites de la Argentina?', 'hint': 'Norte: Bolivia/Paraguay. Este: Brasil/Uruguay/Océano. Oeste: Chile.', 'category': 'Límites'},
        {'q': '¿Qué son los relieves y cuáles predominan en Argentina?', 'hint': 'Montañas (Cordillera), llanuras (Pampeana) y mesetas (Patagonia).', 'category': 'Relieves'},
        {'q': '¿Por qué son importantes los recursos naturales para la economía?', 'hint': 'Permiten la agricultura, minería, generan trabajo y bienes exportables.', 'category': 'Recursos naturales'},
        {'q': '¿Cuáles son las regiones de Argentina?', 'hint': 'Noroeste, Noreste, Cuyo, Pampeana, Patagonia y Metropolitana.', 'category': 'Regiones'},
        {'q': '¿Qué se entiende por desarrollo social, económico y cultural?', 'hint': 'Progreso de la sociedad, mejora de calidad de vida, educación y economía.', 'category': 'Desarrollo'},
      ],
    },
  };

  static List<Question> getQuestionsForLevel(QuestionTopic topic, QuestionLevel level) {
    final topicQuestions = questions[topic]?[level] ?? [];
    return topicQuestions.map((q) => Question.fromMap(q, level.name)).toList();
  }

  static Question getQuestionForCell(int cellNumber, QuestionTopic topic, QuestionLevel difficulty) {
    final fixedQuestions = _fixedQuestionCells[cellNumber];
    if (fixedQuestions != null) {
      final level = fixedQuestions['level'] as QuestionLevel;
      final index = fixedQuestions['index'] as int;
      final allQuestions = getQuestionsForLevel(topic, level);
      if (allQuestions.isNotEmpty) {
        return allQuestions[index % allQuestions.length];
      }
    }

    if (_reinforcementCells.contains(cellNumber)) {
      final allQuestions = getQuestionsForLevel(topic, difficulty);
      if (allQuestions.isNotEmpty) {
        return allQuestions[DateTime.now().millisecond % allQuestions.length];
      }
    }

    return getRandomQuestion(topic, difficulty);
  }

  static Question getRandomQuestion(QuestionTopic topic, QuestionLevel difficulty) {
    List<Question> pool = [];

    switch (difficulty) {
      case QuestionLevel.easy:
        pool = [
          ...getQuestionsForLevel(topic, QuestionLevel.easy),
          ...getQuestionsForLevel(topic, QuestionLevel.easy),
          ...getQuestionsForLevel(topic, QuestionLevel.medium),
        ];
        break;
      case QuestionLevel.medium:
        pool = [
          ...getQuestionsForLevel(topic, QuestionLevel.easy),
          ...getQuestionsForLevel(topic, QuestionLevel.medium),
          ...getQuestionsForLevel(topic, QuestionLevel.medium),
          ...getQuestionsForLevel(topic, QuestionLevel.hard),
        ];
        break;
      case QuestionLevel.hard:
        pool = [
          ...getQuestionsForLevel(topic, QuestionLevel.medium),
          ...getQuestionsForLevel(topic, QuestionLevel.hard),
          ...getQuestionsForLevel(topic, QuestionLevel.hard),
        ];
        break;
    }

    if (pool.isEmpty) {
      return Question(
        question: '¿Pregunta de ejemplo?',
        hint: 'Esta es una pregunta de ejemplo',
        category: 'General',
        level: difficulty.name,
      );
    }

    return pool[DateTime.now().millisecond % pool.length];
  }

  static const Map<int, Map<String, dynamic>> _fixedQuestionCells = {
    2: {'level': QuestionLevel.easy, 'index': 0},
    5: {'level': QuestionLevel.easy, 'index': 1},
    8: {'level': QuestionLevel.easy, 'index': 2},
    12: {'level': QuestionLevel.easy, 'index': 3},
    18: {'level': QuestionLevel.easy, 'index': 4},
    22: {'level': QuestionLevel.easy, 'index': 9},
    15: {'level': QuestionLevel.medium, 'index': 0},
    20: {'level': QuestionLevel.medium, 'index': 1},
    25: {'level': QuestionLevel.medium, 'index': 2},
    30: {'level': QuestionLevel.medium, 'index': 3},
    35: {'level': QuestionLevel.medium, 'index': 6},
    40: {'level': QuestionLevel.medium, 'index': 4},
    45: {'level': QuestionLevel.medium, 'index': 10},
    55: {'level': QuestionLevel.medium, 'index': 14},
    50: {'level': QuestionLevel.hard, 'index': 0},
    60: {'level': QuestionLevel.hard, 'index': 1},
    65: {'level': QuestionLevel.hard, 'index': 4},
    70: {'level': QuestionLevel.hard, 'index': 6},
    75: {'level': QuestionLevel.hard, 'index': 3},
    80: {'level': QuestionLevel.hard, 'index': 8},
    85: {'level': QuestionLevel.hard, 'index': 13},
    90: {'level': QuestionLevel.hard, 'index': 12},
    95: {'level': QuestionLevel.hard, 'index': 14},
    98: {'level': QuestionLevel.hard, 'index': 9},
  };

  static const List<int> _reinforcementCells = [
    3, 7, 10, 16, 23, 27, 33, 37, 42, 48,
    52, 57, 62, 68, 72, 77, 82, 88, 92, 97,
  ];

  static bool hasQuestion(int cellNumber) {
    return _fixedQuestionCells.containsKey(cellNumber) ||
        _reinforcementCells.contains(cellNumber);
  }
}