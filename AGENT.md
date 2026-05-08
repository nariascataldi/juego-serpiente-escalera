# AGENT.md - Configuración de Agentes para Mejoras del Proyecto

## Visión General
Este documento define la configuración y responsabilidades de los agentes especializados que trabajarán en paralelo para implementar las mejoras de accesibilidad, responsive y calidad de código del juego "Serpientes y Escaleras".

## Agentes del Equipo

### 1. Agente: accessibility-specialist
**Rol**: Especialista en Accesibilidad Web (WCAG 2.2)
**Skills Asignados**:
- `@.agents/skills/accessibility` - Auditoría y mejora de accesibilidad
- `@.agents/skills/frontend-specialist` - Estándares WCAG 2.1 AA

**Responsabilidades**:
- Implementar skip links
- Agregar aria-labels a botones de iconos
- Implementar gestión de focus en modales
- Agregar regiones live para notificaciones
- Verificar contraste de colores
- Asegurar indicadores de focus visibles

**Archivo Principal**: `index.html`

---

### 2. Agente: responsive-developer
**Rol**: Desarrollador Frontend Responsive
**Skills Asignados**:
- `@.agents/skills/frontend-specialist` - Mobile-first, Bootstrap breakpoints
- `@.agents/skills/frontend-design` - Diseño de interfaces

**Responsabilidades**:
- Implementar breakpoints responsive (576px, 768px, 992px)
- Aumentar touch targets a 44x44px mínimo
- Hacer sidebar colapsable en móvil
- Asegurar textos legibles sin zoom

**Archivo Principal**: `styles.css`, `index.html`

---

### 3. Agente: semantic-html-editor
**Rol**: Editor de HTML Semántico
**Skills Asignados**:
- `@.agents/skills/frontend-specialist` - Semantic HTML
- `@.agents/skills/accessibility` - Landmark regions

**Responsabilidades**:
- Agregar landmark `<main>`
- Usar `<aside>` para sidebar
- Implementar `<fieldset>` y `<legend>` para grupos de opciones
- Mejorar estructura de headings

**Archivo Principal**: `index.html`

---

### 4. Agente: motion-reducer
**Rol**: Especialista en Animaciones y Accesibilidad
**Skills Asignados**:
- `@.agents/skills/css-animations` - CSS animations
- `@.agents/skills/accessibility` - Reduced motion (2.3.3)

**Responsabilidades**:
- Implementar media query `prefers-reduced-motion`
- Asegurar que todas las animaciones respeten la preferencia
- Optimizar transiciones CSS

**Archivo Principal**: `styles.css`

---

### 5. Agente: code-reviewer-main
**Rol**: Revisor de Código Principal
**Skills Asignados**:
- `@.agents/skills/code-reviewer` - Revisión constructiva
- `@.agents/skills/security-auditor` - Detección de vulnerabilidades

**Responsabilidades**:
- Revisar cada cambio implementado
- Verificar cumplimiento de mejores prácticas
- Detectar bugs potenciales

---

## Distribución de Tareas

| Tarea | Agente Asignado | Prioridad |
|-------|-----------------|-----------|
| Skip links | accessibility-specialist | ALTA |
| aria-labels en botones | accessibility-specialist | ALTA |
| Focus management modales | accessibility-specialist | ALTA |
| aria-live regions | accessibility-specialist | ALTA |
| Contraste colores | accessibility-specialist | ALTA |
| Breakpoints responsive | responsive-developer | ALTA |
| Touch targets 44x44px | responsive-developer | ALTA |
| Sidebar colapsable | responsive-developer | MEDIA |
| Landmark main/aside | semantic-html-editor | MEDIA |
| Fieldset en opciones | semantic-html-editor | MEDIA |
| prefers-reduced-motion | motion-reducer | MEDIA |

## Flujo de Trabajo

1. **Planificación**: Director asigna tareas a cada agente
2. **Desarrollo**: Agentes trabajan en paralelo en sus tareas
3. **Revisión**: code-reviewer-main revisa cada implementación
4. **Commit**: Director realiza commits en español con descripciones claras
5. **Validación**: QA verifica que las mejoras funcionan correctamente

## Configuración del Repositorio
- **Rama de trabajo**: `dev`
- **Rama principal**: `juego`
- **Commits en**: Español
- **Prefijo de commits**: `[MEJORA]` para mejoras, `[FIX]` para correcciones