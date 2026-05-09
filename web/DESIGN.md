# DESIGN.md - Diseño de Mejoras del Proyecto

## Historial de Versiones
| Versión | Fecha | Descripción |
|---------|-------|-------------|
| 1.0 | 2026-05-08 | Versión inicial del plan de mejoras |

---

## 1. Mejoras de Accesibilidad (WCAG 2.2)

### 1.1 Skip Link
**Problema**: No existe forma de saltar la navegación para usuarios de teclado.
**Solución**: Agregar skip link al inicio del body.

```html
<!-- Añadir al inicio del body en index.html -->
<a href="#main-content" class="skip-link">Saltar al contenido principal</a>
```

```css
/* styles.css */
.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: var(--primary-color);
  color: white;
  padding: 8px 16px;
  z-index: 1000;
  transition: top 0.3s;
}

.skip-link:focus {
  top: 0;
}
```

### 1.2 ARIA Labels para Botones de Iconos
**Problema**: Los botones de reglas y reinicio no tienen nombres accesibles.
**Solución**: Agregar `aria-label` a los botones.

```html
<button class="btn-icon" id="btn-rules" aria-label="Ver reglas del juego">📜</button>
<button class="btn-icon" id="btn-restart" aria-label="Reiniciar el juego">🔄</button>
```

### 1.3 Gestión de Focus en Modales
**Problema**: Al cerrar modales no se retorna el foco al elemento que lo abrió.
**Solución**: Guardar elemento activo antes de abrir, restaurar al cerrar.

```javascript
// En game.js - método toggleModal
toggleModal(id, show) {
  const modal = document.getElementById(id);
  if (show) {
    // Guardar foco actual
    this.lastFocusedElement = document.activeElement;
    modal.classList.add('active');
    // Mover foco al modal
    modal.querySelector('.modal').focus();
  } else {
    modal.classList.remove('active');
    // Restaurar foco
    if (this.lastFocusedElement) {
      this.lastFocusedElement.focus();
    }
  }
}
```

### 1.4 ARIA Live Regions
**Problema**: Los cambios en el log de juego no son anunciados a lectores de pantalla.
**Solución**: Agregar `aria-live="polite"` al contenedor del log.

```html
<div class="log-entries" id="log-entries" aria-live="polite" aria-label="Registro del juego">
```

### 1.5 Indicadores de Focus Visibles
**Problema**: Posible outline insuficiente en elementos interactivos.
**Solución**: Asegurar styles de focus visibles.

```css
/* styles.css */
*:focus-visible {
  outline: 3px solid var(--focus-color, #2563eb);
  outline-offset: 2px;
}

button:focus-visible,
[role="button"]:focus-visible {
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.4);
}
```

---

## 2. Mejoras Responsive (Mobile-First)

### 2.1 Breakpoints Bootstrap
**Problema**: No hay media queries para diferentes tamaños de pantalla.
**Solución**: Implementar sistema de breakpoints.

```css
/* Base: mobile first (< 576px) */

/* Small: tablets (576px - 767px) */
@media (min-width: 576px) { }

/* Medium: landscape tablets (768px - 991px) */
@media (min-width: 768px) { }

/* Large: laptops (992px - 1199px) */
@media (min-width: 992px) { }

/* XL: desktops (1200px+) */
@media (min-width: 1200px) { }
```

### 2.2 Touch Targets 44x44px
**Problema**: Botones demasiado pequeños para interacción táctil.
**Solución**: Aumentar tamaño mínimo de targets interactivos.

```css
/* styles.css */
button,
.btn-icon,
input[type="radio"] + label,
input[type="checkbox"] + label {
  min-width: 44px;
  min-height: 44px;
  padding: 12px 16px;
}
```

### 2.3 Sidebar Colapsable en Móvil
**Problema**: El layout no se adapta bien a pantallas pequeñas.
**Solución**: Implementar sidebar colapsable con botón toggle.

```html
<!-- index.html -->
<button class="sidebar-toggle" id="sidebar-toggle" aria-label="Alternar panel de jugadores">
  👥
</button>
```

```css
/* styles.css - Mobile */
.sidebar {
  position: fixed;
  left: -100%;
  top: 60px;
  width: 280px;
  height: calc(100vh - 60px);
  transition: left 0.3s ease;
  z-index: 100;
}

.sidebar.open {
  left: 0;
}
```

---

## 3. Mejoras de HTML Semántico

### 3.1 Landmark Main
**Problema**: Falta landmark principal para contenido.
**Solución**: Envolver contenido principal en `<main>`.

```html
<!-- Cambiar en index.html -->
<main id="main-content" class="board-area">
```

### 3.2 Aside para Sidebar
**Problema**: El aside no está marcado semánticamente.
**Solución**: Usar elemento `<aside>` para sidebar y actions panel.

```html
<aside class="sidebar" aria-label="Información de jugadores">
<aside class="actions-panel" aria-label="Panel de control">
```

### 3.3 Fieldset para Grupos de Opciones
**Problema**: Los grupos de radios no están semanticamente relacionados.
**Solución**: Usar `<fieldset>` y `<legend>`.

```html
<fieldset class="topic-selector">
  <legend>📚 Tema del Cuestionario</legend>
  <!-- opciones -->
</fieldset>
```

---

## 4. Reduced Motion

### 4.1 Media Query prefers-reduced-motion
**Problema**: Las animaciones pueden afectar a usuarios sensibles.
**Solución**: Respetar preferencia del sistema.

```css
/* styles.css */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
  
  .confetti-piece {
    animation: none !important;
  }
  
  .floating-emoji {
    animation: none !important;
  }
}
```

---

## 5. Resumen de Archivos a Modificar

| Archivo | Cambios |
|---------|---------|
| `index.html` | Skip link, aria-labels, landmarks, fieldset |
| `styles.css` | Breakpoints, touch targets, focus, reduced motion |
| `game.js` | Focus management en modales |

---

## 6. Orden de Implementación

1. **Fase 1**: Accesibilidad básica (skip link, aria-labels, focus)
2. **Fase 2**: HTML semántico (main, aside, fieldset)
3. **Fase 3**: Responsive (breakpoints, touch targets)
4. **Fase 4**: Reduced motion
5. **Fase 5**: Revisión y testing

---

## 7. Criterios de Éxito

- ✅ Lighthouse Accessibility score ≥ 90
- ✅ Todos los elementos interactivos accesibles por teclado
- ✅ Contraste mínimo 4.5:1 en texto
- ✅ Touch targets ≥ 44x44px en móvil
- ✅ Respeto de `prefers-reduced-motion`
- ✅ Estructura semántica correcta (landmarks)