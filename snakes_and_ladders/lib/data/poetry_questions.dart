/// Para agregar una pregunta, usa:
/// QuestionEntry(q: 'Tu pregunta', hint: 'Pista para papá', category: 'Definiciones')
/// 
/// Categorías disponibles: Definiciones, Práctica, Tipos de rima, Elementos,
/// Figuras literarias, Géneros, Comparación, Estructura, Tipos, Conceptos,
/// Análisis, Creación, Formas poéticas
import '../models/question.dart';

const List<QuestionEntry> poetryQuestions = [
  QuestionEntry(
    q: '¿Qué es la poesía?',
    hint: 'Es un género literario que usa el lenguaje de manera especial...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué es un verso?',
    hint: 'Piensa en cada línea de un poema...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué es una estrofa?',
    hint: 'Es un grupo de versos, como un párrafo en prosa...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué es la rima?',
    hint: 'Tiene que ver con los sonidos al final de los versos...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué es un poema?',
    hint: 'Es una composición literaria escrita en verso...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Quién escribe los poemas?',
    hint: 'Se le llama poeta o poetisa...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué es el título de un poema?',
    hint: 'Es el nombre que el autor le da a su obra...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Los poemas siempre tienen que rimar?',
    hint: 'Existe algo llamado verso libre...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué son los sentimientos en un poema?',
    hint: 'Los poemas expresan emociones como alegría, tristeza, amor...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué es el lenguaje figurado?',
    hint: 'Es cuando las palabras no significan exactamente lo que dicen...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué es una canción de cuna? ¿Es poesía?',
    hint: 'Piensa en las canciones que se cantan a los bebés...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué es recitar un poema?',
    hint: 'Tiene que ver con leerlo en voz alta, con expresión...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: 'Decí un ejemplo de verso que rime con corazón.',
    hint: 'Pensá en palabras que terminen en -ón: canción, razón...',
    category: 'Práctica',
  ),
  QuestionEntry(
    q: '¿Qué es una adivinanza? ¿Tiene algo de poesía?',
    hint: 'Las adivinanzas muchas veces riman y tienen ritmo...',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué es un trabalenguas? ¿Tiene ritmo?',
    hint: 'Piensa en: Tres tristes tigres... Tiene musicalidad?',
    category: 'Definiciones',
  ),
  QuestionEntry(
    q: '¿Qué diferencia hay entre rima consonante y asonante?',
    hint: 'En una coinciden TODOS los sonidos, en la otra solo las vocales...',
    category: 'Tipos de rima',
  ),
  QuestionEntry(
    q: '¿Qué es el ritmo en un poema?',
    hint: 'Es la musicalidad, la cadencia al leerlo...',
    category: 'Elementos',
  ),
  QuestionEntry(
    q: '¿Qué es una metáfora? Da un ejemplo.',
    hint: 'Es decir que algo ES otra cosa: tus ojos son estrellas...',
    category: 'Figuras literarias',
  ),
  QuestionEntry(
    q: '¿Qué es una comparación o símil?',
    hint: 'Se usa como o parece: blanco como la nieve...',
    category: 'Figuras literarias',
  ),
  QuestionEntry(
    q: '¿Qué es un poema lírico?',
    hint: 'Expresa sentimientos personales del autor...',
    category: 'Géneros',
  ),
  QuestionEntry(
    q: '¿Qué diferencia hay entre un poema y una canción?',
    hint: 'Ambos tienen ritmo y pueden rimar, pero la canción tiene...',
    category: 'Comparación',
  ),
  QuestionEntry(
    q: '¿Qué es la personificación? Da un ejemplo.',
    hint: 'Dar cualidades humanas a cosas: el sol sonríe...',
    category: 'Figuras literarias',
  ),
  QuestionEntry(
    q: '¿Qué son los versos pareados?',
    hint: 'Son versos que riman de dos en dos (AA BB)...',
    category: 'Estructura',
  ),
  QuestionEntry(
    q: '¿Cuántos versos tiene un soneto en una estrofa?',
    hint: 'El soneto tiene 14 versos en total, pero las estrofas...',
    category: 'Estructura',
  ),
  QuestionEntry(
    q: 'Qué quiere decir verso libre?',
    hint: 'Es cuando el poeta no sigue reglas de rima ni métrica fija...',
    category: 'Tipos',
  ),
  QuestionEntry(
    q: '¿Qué es la hipérbole? Da un ejemplo.',
    hint: 'Es una exageración: te lo dije un millón de veces...',
    category: 'Figuras literarias',
  ),
  QuestionEntry(
    q: '¿Qué es una onomatopeya? Da un ejemplo.',
    hint: 'Son palabras que imitan sonidos: miau, tic-tac...',
    category: 'Figuras literarias',
  ),
  QuestionEntry(
    q: 'Inventá una metáfora sobre la luna.',
    hint: 'La luna podría ser... una moneda, un ojo, una lámpara...',
    category: 'Práctica',
  ),
  QuestionEntry(
    q: '¿Qué es la aliteración? Da un ejemplo.',
    hint: 'Repetir sonidos parecido: con el ala aleve del leve abanico...',
    category: 'Figuras literarias',
  ),
  QuestionEntry(
    q: '¿Qué es el yo lírico?',
    hint: 'No es necesariamente el autor real, es la voz que habla en el poema...',
    category: 'Conceptos',
  ),
  QuestionEntry(
    q: 'Leé estos versos e identificá la figura literaria: La luna es un espejo redondo.',
    hint: 'Dice que la luna ES algo... qué figura usa?',
    category: 'Análisis',
  ),
  QuestionEntry(
    q: '¿Qué tipo de rima hay en: corazón / canción?',
    hint: 'Fijate si coinciden todos los sonidos a partir de la vocal acentuada...',
    category: 'Análisis',
  ),
  QuestionEntry(
    q: '¿Qué tipo de rima hay en: cielo / viento?',
    hint: 'Coinciden solo las vocales (e-o) o también las consonantes?',
    category: 'Análisis',
  ),
  QuestionEntry(
    q: 'Inventá dos versos que tengan rima consonante.',
    hint: 'Que terminen con los mismos sonidos: amor/dolor, estrella/bella...',
    category: 'Creación',
  ),
  QuestionEntry(
    q: 'Qué figura literaria hay en: El viento susurraba entre los árboles?',
    hint: 'El viento puede susurrar de verdad? Eso es darle una cualidad...',
    category: 'Análisis',
  ),
  QuestionEntry(
    q: 'Inventá una estrofa de 4 versos con rima ABAB.',
    hint: 'El verso 1 rima con el 3, y el 2 con el 4...',
    category: 'Creación',
  ),
  QuestionEntry(
    q: '¿Qué es la anáfora? Dá un ejemplo.',
    hint: 'Es repetir una palabra al inicio de varios versos...',
    category: 'Figuras literarias',
  ),
  QuestionEntry(
    q: 'Analizá: ¡Oh noche que guiaste! ¡Oh noche amable más que el alborada! ¿Qué figuras ves?',
    hint: 'Hay repetición al inicio de los versos y también personificación...',
    category: 'Análisis',
  ),
  QuestionEntry(
    q: '¿Qué es un haiku? ¿Cuántas sílabas tiene?',
    hint: 'Es un poema japonés muy corto: 5-7-5 sílabas...',
    category: 'Formas poéticas',
  ),
  QuestionEntry(
    q: 'Inventá un haiku (5-7-5 sílabas).',
    hint: 'Ejemplo: Viejo estanque / una rana salta / ruido de agua (Bashō)...',
    category: 'Creación',
  ),
  QuestionEntry(
    q: '¿Qué diferencia hay entre poesía narrativa y poesía lírica?',
    hint: 'Una cuenta una historia, la otra expresa sentimientos...',
    category: 'Géneros',
  ),
  QuestionEntry(
    q: 'Leé: La tierra es un plato azul. ¿Qué tipo de metáfora es?',
    hint: 'Compara la Tierra con un plato... es visual? Es pura?',
    category: 'Análisis',
  ),
  QuestionEntry(
    q: 'Convertí esta frase en lenguaje figurado: La noche es oscura.',
    hint: 'Podrías usar una metáfora: La noche es un manto negro...',
    category: 'Creación',
  ),
  QuestionEntry(
    q: '¿Qué es la métrica y por qué es importante en un poema?',
    hint: 'Tiene que ver con contar sílabas y el ritmo regular...',
    category: 'Conceptos',
  ),
  QuestionEntry(
    q: 'Identificá las figuras literarias: Caminante, no hay camino, se hace camino al andar (Machado).',
    hint: 'Hay una paradoja (no hay camino/se hace camino) y metáfora (camino = vida)...',
    category: 'Análisis',
  ),
];