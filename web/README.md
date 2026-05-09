# 🎲 Serpientes y Escaleras - Edición Aprendizaje Multitemático

Una versión educativa, interactiva y moderna del clásico juego de mesa "Serpientes y Escaleras". Desarrollado con HTML, CSS y JavaScript vainilla (sin frameworks), este juego combina mecánicas clásicas con bancos de preguntas que ayudan a reforzar el aprendizaje en diferentes materias de forma divertida.

## ✨ Características Principales

- **🎮 Multijugador Local:** Soporte para jugar desde 1 hasta 4 jugadores simultáneamente en la misma pantalla.
- **📚 Multitemático:** Elige qué materia quieres repasar antes de empezar la partida. Temas integrados actualmente:
  - 🌿 Ciencias Naturales
  - 🏛️ Ciencias Sociales
  - 📖 Poesía
- **⚙️ Ajustes Dinámicos:**
  - **Dificultad:** Adapta la complejidad de las preguntas al nivel de los jugadores (Básico, Medio, Avanzado).
  - **Castigos Configurables:** Decide qué sucede si un jugador responde incorrectamente (Se queda en la casilla actual, retrocede o pierde su próximo turno).
- **🎨 Diseño Moderno:** Interfaz vibrante con temática 'Glassmorphism' (cristal esmerilado), animaciones fluidas, emojis interactivos y renderizado de animaciones por SVG en tiempo real.
- **📱 Responsivo:** Adaptado para jugarse tanto en ordenadores de escritorio como en dispositivos móviles.

## 🚀 Cómo Jugar

1. **Abrir el juego:** Debido a que el juego utiliza módulos modernos de JavaScript (`type="module"`), no se puede abrir simplemente haciendo doble clic en el archivo HTML por políticas de seguridad del navegador (CORS). Necesitas levantar un servidor local.
   - **Opción A (Recomendada):** Usa la extensión **Live Server** en Visual Studio Code. Haz clic derecho sobre `index.html` y selecciona "Open with Live Server".
   - **Opción B (Terminal):** Si tienes Python instalado, abre una terminal en la carpeta del juego y ejecuta: `python3 -m http.server 8000`. Luego entra a `http://localhost:8000` en tu navegador.
   - **Opción C (Node.js):** Si prefieres Node, ejecuta `npx serve .` en la carpeta.
2. **Configurar la Partida:** 
   - Añade el nombre de los jugadores (hasta 4).
   - Selecciona el tema a repasar en el menú inicial.
   - Ajusta la dificultad y las reglas de castigo por respuesta errónea.
3. **Mecánica de Turnos:**
   - En tu turno, presiona "Tirar Dado" (o usa la barra espaciadora).
   - Avanza las casillas correspondientes.
   - Si caes en una casilla especial (`❓`, `🪜`, `🐍`), se presentará una pregunta al azar de la temática elegida.
   - Un adulto, maestro o moderador puede pulsar "Correcto" o "Incorrecto" según la respuesta oral del jugador (¡o puedes usar el sistema de Pistas si no logras recordar la respuesta!).
4. **Objetivo:** Ser el primer jugador en llegar a la casilla número 100 🏆.

## 📂 Estructura del Proyecto

```text
/
├── index.html          # Interfaz principal, pantalla de inicio y tablero.
├── styles.css          # Estilos CSS, animaciones, variables de diseño y Glassmorphism.
├── game.js             # Motor central del juego (jugadores, dados, turnos, movimientos y eventos).
├── questions.js        # Gestor de lógica de preguntas, aleatorización y selección de tema activo.
└── questions_db.js     # Base de datos local (constantes) de preguntas divididas por tema y dificultad.
```

## 🛠️ Cómo agregar nuevas materias / temas

El juego está diseñado para ser muy extensible. Si eres educador y deseas agregar preguntas para otra materia (por ejemplo: Matemáticas):

1. Abre `questions_db.js` y crea una nueva constante con el mismo formato que las anteriores (divididas en listas `easy`, `medium`, `hard`). Por ejemplo:
   ```javascript
   export const PREGUNTAS_MATEMATICAS = {
     easy: [ { q: "¿Cuánto es 2+2?", hint: "Es un número par...", category: "Suma" } ],
     medium: [ ... ],
     hard: [ ... ]
   };
   ```
2. Abre `questions.js` y asegúrate de importar tu nueva constante al principio del archivo, y modificar la función `setTopic` para que acepte tu nuevo set:
   ```javascript
   export function setTopic(topic) {
     if (topic === 'PREGUNTAS_MATEMATICAS') activeQuestionsDB = PREGUNTAS_MATEMATICAS;
     /* ... else ifs existentes ... */
   }
   ```
3. Finalmente, abre `index.html` y agrega el nuevo radio button dentro del `.topic-selector` (cerca de la línea 66):
   ```html
   <label class="topic-option">
     <input type="radio" name="topic" value="PREGUNTAS_MATEMATICAS">
     <span class="topic-badge">🔢 Matemáticas</span>
   </label>
   ```

## 📝 Licencia

Desarrollado como proyecto de software libre para apoyar el aprendizaje lúdico y el estudio de los niños. Siéntete libre de modificarlo, mejorarlo o agregar nuevos sets de preguntas.
