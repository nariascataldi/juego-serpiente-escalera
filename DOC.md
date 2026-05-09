# Serpientes y Escaleras - Documentación Flutter

## 📱 Resumen del Proyecto

Este documento describe la conversión del juego web "Serpientes y Escaleras" a una aplicación Android nativa usando **Flutter**.

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
snakes_and_ladders/                    # Proyecto Flutter
├── lib/                                # Código fuente Dart
│   ├── main.dart                       # Entry point
│   ├── theme.dart                      # Tema y estilos
│   │
│   ├── models/                        # Modelos de datos
│   │   ├── player.dart                 # Jugador (nombre, posición, estadísticas)
│   │   ├── question.dart               # Pregunta (texto, pista, nivel)
│   │   └── game_config.dart            # Configuración (tema, dificultad, regla)
│   │
│   ├── data/                           # Datos estáticos
│   │   ├── questions_db.dart           # Banco de preguntas migrado de JS
│   │   └── board_config.dart           # Serpientes, escaleras, casillas
│   │
│   ├── providers/                      # Gestión de estado
│   │   └── game_provider.dart          # Lógica central del juego (ChangeNotifier)
│   │
│   ├── screens/                        # Pantallas
│   │   ├── start_screen.dart           # Pantalla de configuración inicial
│   │   ├── game_screen.dart            # Pantalla principal del juego
│   │   └── modals/                     # Ventanas emergentes
│   │       ├── question_modal.dart     # Modal de preguntas
│   │       ├── event_modal.dart        # Modal de serpiente/escalera
│   │       ├── win_modal.dart          # Modal de victoria
│   │       └── rules_modal.dart         # Modal de reglas
│   │
│   └── widgets/                        # Componentes reutilizables
│       ├── board_widget.dart           # Tablero 10x10 con CustomPaint
│       ├── cell_widget.dart            # Casilla individual
│       └── dice_widget.dart            # Dado animado
│
├── build/app/outputs/flutter-apk/     # APK generado
│   └── app-debug.apk                   # Build debug (138 MB)
│
└── pubspec.yaml                        # Dependencias del proyecto
```

---

## 📦 El APK Generado

### Ubicación
```
snakes_and_ladders/build/app/outputs/flutter-apk/app-debug.apk
```

### Diferencia entre APK Debug vs Release

| Característica | Debug APK | Release APK |
|----------------|-----------|-------------|
| **Tamaño** | ~138 MB | ~20-30 MB |
| **Optimización** | Sin optimizar | Optimizado |
| **Depuración** | Incluida | Eliminada |
| **Firma** | Debug key | Tu firma |
| **Uso** | Testing | Producción |

### ¿Por qué es tan grande el debug APK?
- Incluye símbolos de depuración
- No tiene tree-shaking (eliminación de código muerto)
- Contiene herramientas de profiling
- Flutter engine completo

### Para generar un Release APK:
```bash
cd snakes_and_ladders
flutter build apk --release
```
Esto generará un APK mucho más pequeño y optimizado en:
```
build/app/outputs/flutter-release/app-release.apk
```

### Instalar en dispositivo:
```bash
# Transferir el archivo app-debug.apk al teléfono
# O usar ADB:
adb install snakes_and_ladders/build/app/outputs/flutter-apk/app-debug.apk
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
- [x] Selección de dificultad:
  - 🟢 Básico
  - 🟡 Medio
  - 🔴 Avanzado
- [x] Regla para respuesta incorrecta:
  - 🛑 Se queda
  - 🔙 Retrocede
  - ⏭️ Pierde turno

### 2. Tablero de Juego
- [x] Grid 10x10 (100 casillas)
- [x] Patrón serpiente (zigzag)
- [x] Visualización de serpientes (dibujadas con CustomPaint)
- [x] Visualización de escaleras (dibujadas con CustomPaint)
- [x] Casillas especiales (preguntas, inicio, meta)

### 3. Mecánica del Juego
- [x] Tirar dado (animación)
- [x] Movimiento animado ficha a ficha
- [x] Validación de posición exacta para llegar a 100
- [x] Sistema de turnos entre jugadores

### 4. Sistema de Preguntas
- [x] Preguntas según dificultad configurada
- [x] Preguntas específicas por casillero
- [x] Sistema de pistas
- [x] Validación por parte del padre/tutor

### 5. Eventos
- [x] Escalera (sube si responde bien)
- [x] Serpiente (baja si responde mal, evita si responde bien)
- [x] Modal de evento con animación

### 6. Victoria
- [x] Detección de ganador
- [x] Modal de victoria con confeti
- [x] Estadísticas del juego:
  - Turnos jugados
  - Respuestas correctas/incorrectas
  - Precisión %
- [x] Botón para jugar de nuevo

### 7. Interfaz
- [x] Panel de jugadores (sidebar/modal)
- [x] Registro de jugadas (log)
- [x] Indicador de turno actual
- [x] Leyenda del tablero
- [x] Modal de reglas

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

# Ejecutar con logging
flutter run -v
```

### Build
```bash
# Debug APK (más rápido)
flutter build apk --debug

# Release APK (optimizado)
flutter build apk --release

# Build para iOS (requiere Mac)
flutter build ios
```

### Análisis
```bash
# Analizar código
flutter analyze

# Ver estructura
flutter doctor
```

---

## 📝 Datos Migrados del Original

### Preguntas
- **Poesía:** 45 preguntas (15 easy, 15 medium, 15 hard)
- **Ciencias Naturales:** 15 preguntas (6 easy, 5 medium, 4 hard)
- **Ciencias Sociales:** 15 preguntas (6 easy, 5 medium, 4 hard)

### Tablero
- **Escaleras:** 8 (posiciones: 4→14, 9→31, 21→42, 28→84, 36→44, 51→67, 71→91, 80→100)
- **Serpientes:** 8 (posiciones: 17→7, 54→34, 62→19, 64→60, 87→24, 93→73, 95→75, 99→78)
- **Casillas de pregunta:** 24-fixed + 20-reforzamiento

---

## 🔧 Tecnologías Usadas

| Tecnología | Versión |
|------------|---------|
| Flutter | 3.41.9 |
| Dart | 3.11.5 |
| Provider | 6.1.5+1 |
| Android SDK | 36 |
| NDK | 28.2.13676358 |

---

## 📄 Archivos Originales vs Flutter

| Original (Web) | Migrado (Flutter) |
|----------------|-------------------|
| `index.html` | `screens/start_screen.dart`, `screens/game_screen.dart` |
| `game.js` | `providers/game_provider.dart` |
| `questions.js` | `data/questions_db.dart` |
| `questions_db.js` | `data/questions_db.dart` (integrado) |
| `styles.css` | `theme.dart`, `widgets/*.dart` |

---

*Documento generado automáticamente el 8 de mayo de 2026*