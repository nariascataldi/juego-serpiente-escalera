/// Para agregar una pregunta usa:
/// QuestionEntry(q: 'Tu pregunta', hint: 'Pista para papá', category: 'Categoría')
class QuestionEntry {
  final String q;
  final String hint;
  final String category;

  const QuestionEntry({
    required this.q,
    required this.hint,
    required this.category,
  });

  QuestionModel toModel() => QuestionModel(
    question: q,
    hint: hint,
    category: category,
  );
}

class QuestionModel {
  final String question;
  final String hint;
  final String category;

  const QuestionModel({
    required this.question,
    required this.hint,
    required this.category,
  });
}

enum QuestionTopic { poetry, naturalSciences, socialSciences }

extension QuestionTopicExtension on QuestionTopic {
  String get displayName {
    switch (this) {
      case QuestionTopic.poetry:
        return 'Poesía';
      case QuestionTopic.naturalSciences:
        return 'Cs. Naturales';
      case QuestionTopic.socialSciences:
        return 'Cs. Sociales';
    }
  }

  String get emoji {
    switch (this) {
      case QuestionTopic.poetry:
        return '📖';
      case QuestionTopic.naturalSciences:
        return '🌿';
      case QuestionTopic.socialSciences:
        return '🏛️';
    }
  }
}

enum QuestionCategory {
  definiciones,
  practica,
  tiposDeRima,
  elementos,
  figurasLiterarias,
  generos,
  comparacion,
  estructura,
  tipos,
  conceptos,
  analisis,
  creacion,
  formasPoeticas,
  hidrosfera,
  importanciaDelAgua,
  ambientesAcuat,
  contaminacion,
  subsistemas,
  ubicacion,
  relieves,
  clima,
  ambiente,
  recursosNaturales,
  espaciosRurales,
  poblacion,
  organizacionPolitica,
  biomas,
  limites,
  regiones,
  desarrollo,
}

extension QuestionCategoryExtension on QuestionCategory {
  String get label {
    switch (this) {
      case QuestionCategory.definiciones:
        return 'Definiciones';
      case QuestionCategory.practica:
        return 'Práctica';
      case QuestionCategory.tiposDeRima:
        return 'Tipos de rima';
      case QuestionCategory.elementos:
        return 'Elementos';
      case QuestionCategory.figurasLiterarias:
        return 'Figuras literarias';
      case QuestionCategory.generos:
        return 'Géneros';
      case QuestionCategory.comparacion:
        return 'Comparación';
      case QuestionCategory.estructura:
        return 'Estructura';
      case QuestionCategory.tipos:
        return 'Tipos';
      case QuestionCategory.conceptos:
        return 'Conceptos';
      case QuestionCategory.analisis:
        return 'Análisis';
      case QuestionCategory.creacion:
        return 'Creación';
      case QuestionCategory.formasPoeticas:
        return 'Formas poéticas';
      case QuestionCategory.hidrosfera:
        return 'Hidrósfera';
      case QuestionCategory.importanciaDelAgua:
        return 'Importancia del agua';
      case QuestionCategory.ambientesAcuat:
        return 'Ambientes acuáticos';
      case QuestionCategory.contaminacion:
        return 'Contaminación';
      case QuestionCategory.subsistemas:
        return 'Subsistemas';
      case QuestionCategory.ubicacion:
        return 'Ubicación';
      case QuestionCategory.relieves:
        return 'Relieves';
      case QuestionCategory.clima:
        return 'Clima';
      case QuestionCategory.ambiente:
        return 'Ambiente';
      case QuestionCategory.recursosNaturales:
        return 'Recursos naturales';
      case QuestionCategory.espaciosRurales:
        return 'Espacios rurales';
      case QuestionCategory.poblacion:
        return 'Población';
      case QuestionCategory.organizacionPolitica:
        return 'Organización política';
      case QuestionCategory.biomas:
        return 'Biomas';
      case QuestionCategory.limites:
        return 'Límites';
      case QuestionCategory.regiones:
        return 'Regiones';
      case QuestionCategory.desarrollo:
        return 'Desarrollo';
    }
  }
}