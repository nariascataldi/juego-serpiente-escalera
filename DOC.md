# Serpientes y Escaleras - Documentación Flutter

## 📱 Resumen del Proyecto

Este documento describe el juego "Serpientes y Escaleras" como aplicación Android usando **Flutter**.

---

## ¿Qué es Flutter?

**Flutter** es un framework de código abierto creado por Google para desarrollar aplicaciones nativas multiplataforma (Android, iOS, Web, Desktop) desde un solo código base.

### Características principales:
- **Lenguaje:** Dart (orientado a objetos, tipado)
- **Widgets:** Todo es un widget (componentes UI)
- **Hot Reload:** Cambios instantáneos en desarrollo
- **Compilación nativa:** Output directo a APK/AAB

---

## 📂 Estructura del Proyecto

```
snakes_and_ladders/
├── lib/
│   ├── main.dart                       # Entry point
│   ├── theme.dart                       # Tema y estilos
│   │
│   ├── models/
│   │   ├── player.dart                 # Jugador
│   │   ├── question.dart                # QuestionModel, QuestionEntry, QuestionTopic
│   │   └── game_config.dart            # GameConfig, WrongRule
│   │
│   ├── data/
│   │   ├── questions.dart               # Barrel export
│   │   ├── questions_db.dart           # Lógica de preguntas
│   │   ├── board_config.dart           # Serpientes, escaleras, casillas
│   │   ├── poetry_questions.dart       # Preguntas de poesía (43)
│   │   ├── natural_science_questions.dart  # Preguntas de ciencias naturales (15)
│   │   └── social_science_questions.dart  # Preguntas de ciencias sociales (16)
│   │
│   ├── providers/
│   │   └── game_provider.dart          # Estado del juego (ChangeNotifier + ValueNotifier)
│   │
│   ├── screens/
│   │   ├── start_screen.dart           # Configuración inicial
│   │   ├── game_screen.dart            # Pantalla principal
│   │   └── modals/
│   │       ├── question_modal.dart     # Modal de preguntas
│   │       ├── event_modal.dart        # Modal de serpiente/escalera
│   │       ├── win_modal.dart          # Modal de victoria
│   │       └── rules_modal.dart        # Modal de reglas
│   │
│   └── widgets/
│       ├── board_widget.dart          # Tablero 10x10 con CustomPaint
│       ├── cell_widget.dart           # Casilla individual
│       └── dice_widget.dart            # Dado animado
│
├── test/
│   └── widget_test.dart                # Tests unitarios
│
├── pubspec.yaml                        # v2.0.0
└── README.md                           # README del repo
```

---

## 🚀 Guía de Build

### 1. Actualizar dependencias
```bash
cd ~/Projects/Juego\ serpiente\ y\ escalera/snakes_and_ladders
flutter pub upgrade
```

### 2. Build APK Debug
```bash
flutter build apk --debug
```
El APK se genera en: `build/app/outputs/flutter-apk/app-debug.apk`

### 3. Build APK Release (producción)
```bash
flutter build apk --release
```
El APK se genera en: `build/app/outputs/flutter-apk/app-release.apk`

### 4. Instalar en dispositivo
```bash
# Transferir el archivo APK al teléfono
# O usar ADB:
adb install build/app/outputs/flutter-apk/app-debug.apk
```

---

## 📦 Diferencia APK Debug vs Release

| Característica | Debug APK | Release APK |
|----------------|-----------|-------------|
| **Tamaño** | ~100-140 MB | ~20-40 MB |
| **Optimización** | Sin optimizar | Optimizado (tree-shaking) |
| **Depuración** | Incluida | Eliminada |
| **Uso** | Testing | Producción |

### ¿Por qué es tan grande el debug APK?
- Incluye símbolos de depuración
- No tiene tree-shaking (eliminación de código muerto)
- Contiene herramientas de profiling
- Flutter engine completo

---

## 🛠️ Comandos Útiles

### Desarrollo
```bash
# Ir al directorio del proyecto
cd snakes_and_ladders

# Instalar dependencias
flutter pub get

# Ejecutar en emulador/dispositivo
flutter run

# Ejecutar con logging verbose
flutter run -v
```

### Build
```bash
# Debug APK (más rápido, para testing)
flutter build apk --debug

# Release APK (optimizado, para producción)
flutter build apk --release

# Web
flutter build web
```

### Análisis y Testing
```bash
# Analizar código (busca errores)
flutter analyze

# Correr tests
flutter test

# Diagnosticar problemas del entorno
flutter doctor
```

---

## ✅ Funcionalidades Implementadas

### 1. Pantalla de Inicio
- [x] Configuración de 1-4 jugadores
- [x] Nombre personalizado para cada jugador
- [x] Selección de tema:
  - 📖 Poesía
  - 🌿 Ciencias Naturales
  - 🏛️ Ciencias Sociales
- [x] Regla para respuesta incorrecta:
  - 🛑 Se queda
  - 🔙 Retrocede
  - ⏭️ Pierde turno

### 2. Tablero de Juego
- [x] Grid 10x10 (100 casillas)
- [x] Serpientes dibujadas con CustomPaint
- [x] Escaleras dibujadas con CustomPaint
- [x] Casillas especiales (preguntas, inicio, meta)
- [x] Indicador de posición resaltada durante animación

### 3. Mecánica del Juego
- [x] Tirar dado (animación)
- [x] Movimiento animado ficha a ficha (ValueNotifier)
- [x] Validación de posición exacta para llegar a 100
- [x] Sistema de turnos entre jugadores

### 4. Sistema de Preguntas
- [x] Preguntas según tema seleccionado
- [x] Preguntas específicas por casillero (44 casillas)
- [x] Sistema de pistas con hints
- [x] Validación por parte del padre/tutor
- [x] Categorías para organizar preguntas

### 5. Eventos
- [x] Escalera (sube si responde bien)
- [x] Serpiente (baja si responde mal, evita si responde bien)
- [x] Modal de evento con animación

### 6. Victoria
- [x] Detección de ganador
- [x] Modal de victoria
- [x] Estadísticas del juego:
  - Turnos jugados
  - Respuestas correctas/incorrectas
  - Precisión %
- [x] Botón para jugar de nuevo

### 7. Interfaz
- [x] Panel de jugadores
- [x] Registro de jugadas (log)
- [x] Indicador de turno actual
- [x] Leyenda del tablero
- [x] Modal de reglas

---

## 📝 Preguntas por Tema

| Tema | Cantidad | Archivo |
|------|----------|---------|
| Poesía | 43 | `poetry_questions.dart` |
| Ciencias Naturales | 15 | `natural_science_questions.dart` |
| Ciencias Sociales | 16 | `social_science_questions.dart` |
| **Total** | **74** | |

### Fuentes
- **Poesía:** Guía de preguntas del docente (5to grado)
- **Ciencias Naturales:** Guía de preguntas Cs. Naturales y Sociales (5to grado)
- **Ciencias Sociales:** Guía de preguntas Cs. Naturales y Sociales (5to grado) - texto literal

### Agregar nuevas preguntas
```dart
// En el archivo correspondiente (ej: poetry_questions.dart)
QuestionEntry(
  q: 'Tu pregunta aquí',
  hint: 'La respuesta o pista para papá',
  category: 'Definiciones',
),
```

### Categorías disponibles
**Poesía:** Definiciones, Práctica, Tipos de rima, Elementos, Figuras literarias, Géneros, Comparación, Estructura, Tipos, Conceptos, Análisis, Creación, Formas poéticas

**Ciencias Naturales:** Hidrósfera, Importancia del agua, Ambientes acuáticos, Contaminación, Subsistemas

**Ciencias Sociales:** Ubicación, Población, Organización política, Relieves, Biomas, Clima, Ambiente, Recursos naturales, Espacios rurales, Regiones, Desarrollo

---

## 🐍 Serpientes y Escaleras

### Escaleras
| Desde | Hacia |
|-------|-------|
| 4 | 14 |
| 9 | 31 |
| 21 | 42 |
| 28 | 84 |
| 36 | 44 |
| 51 | 67 |
| 71 | 91 |
| 80 | 100 |

### Serpientes
| Desde | Hacia |
|-------|-------|
| 17 | 7 |
| 54 | 34 |
| 62 | 19 |
| 64 | 60 |
| 87 | 24 |
| 93 | 73 |
| 95 | 75 |
| 99 | 78 |

### Casillas de Pregunta
- **Fijas:** 24 casillas (orden fijo)
- **Refuerzo:** 20 casillas (rotación)

---

## ⚡ Optimizaciones de Rendimiento

### Implementadas
- [x] `ValueNotifier` para animación (evita `notifyListeners()` en loop)
- [x] `const Map` para `cellTypes` y `const Set` para `questionCells`
- [x] `RepaintBoundary` para CustomPaint y celdas
- [x] `Container` estático en lugar de `AnimatedContainer`
- [x] Pre-cálculo de `playerEmojisByCell`
- [x] Cache de preguntas con spread operator

### Impacto
- **Antes:** ~7 `notifyListeners()` por cada paso del jugador durante animación
- **Después:** 0 `notifyListeners()` durante animación (ValueNotifier independiente)

---

## 🔧 Tecnologías

| Tecnología | Versión |
|------------|---------|
| Flutter | 3.41.9+ |
| Dart | 3.11.5 |
| Provider | 6.1.2+ |
| Android SDK | 36+ |

---

## 📄 Versionado

| Versión | Fecha | Cambios |
|---------|-------|---------|
| 1.0.0 | Mayo 2026 | Release inicial |
| 2.0.0 | Mayo 2026 | Breaking: Eliminada dificultad, preguntas modularizadas, optimizaciones |

---

*Documento actualizado el 14 de mayo de 2026*