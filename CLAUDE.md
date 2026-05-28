# Portfolio Pilar Fernández Nieto — CLAUDE.md

## Contexto del proyecto

Portfolio personal de Pilar Fernández Nieto, desarrolladora full-stack con base en Gijón.
Proyecto en desarrollo activo. Este archivo recoge todas las decisiones técnicas y de contenido tomadas hasta ahora para no repetirlas.

---

## Arquitectura

- **Frontend:** SPA en Vue 3 + Vite + Tailwind CSS 4 + Vue Router + Pinia
- **Backend:** Laravel 13 API REST
- **Base de datos:** MySQL
- **Autenticación:** Laravel Sanctum con tokens
- **Hosting:** VPS propio con Apache y PHP (despliegue pendiente)

---

## Estructura de carpetas

### Frontend (`/portfolio`)
```
src/
├── assets/
├── components/
│   ├── NavBar.vue
│   ├── AppFooter.vue
│   └── ProjectCard.vue
├── views/
│   ├── HomeView.vue
│   ├── AboutView.vue
│   ├── ProjectsView.vue
│   ├── CVView.vue
│   ├── NotFoundView.vue
│   └── admin/
│       ├── LoginView.vue
│       ├── AdminView.vue
│       ├── ProjectsAdminView.vue
│       ├── ProjectFormView.vue
│       └── AboutAdminView.vue
├── stores/
│   ├── auth.js
│   ├── projects.js
│   └── about.js
├── services/
│   └── api.js
├── router/
│   └── index.js
├── App.vue
├── main.js
└── style.css
```

### Backend (`/portfolio-api`)
```
app/
├── Http/
│   ├── Controllers/Api/
│   │   ├── AuthController.php
│   │   ├── ProjectController.php
│   │   └── AboutController.php
│   ├── Requests/
│   │   ├── ProjectRequest.php
│   │   └── AboutRequest.php
│   └── Resources/
│       ├── ProjectResource.php
│       └── AboutResource.php
├── Models/
│   ├── Project.php
│   └── About.php
```

---

## Variables de entorno

### Frontend (`.env`)
```env
VITE_API_URL=http://127.0.0.1:8000/api
VITE_STORAGE_URL=http://127.0.0.1:8000/storage
```

### Frontend (`.env.production`)
```env
VITE_API_URL=https://tudominio.com/api
VITE_STORAGE_URL=https://tudominio.com/storage
```

---

## Base de datos

### Tabla `projects`
- `id`
- `title` — string
- `description` — text
- `image` — string nullable (ruta en storage)
- `url` — string nullable (enlace externo)
- `technologies` — json (array)
- `order` — integer (para ordenar)
- `visible` — boolean
- `timestamps`

### Tabla `about`
- `id`
- `bio` — text (HTML enriquecido, pendiente editor)
- `details` — json (array de {label, value})
- `timestamps`

Nota: el modelo `About` tiene `protected $table = 'about'` porque Laravel pluralizaría a `abouts`.

---

## API endpoints

### Públicos
- `GET /api/projects` — lista proyectos visibles ordenados
- `GET /api/about` — devuelve el primer registro de about

### Autenticación
- `POST /api/login` — devuelve token Sanctum
- `POST /api/logout` — requiere token

### Protegidos (requieren `Authorization: Bearer {token}`)
- `POST /api/projects`
- `GET /api/projects/{id}`
- `PUT /api/projects/{id}`
- `DELETE /api/projects/{id}`
- `POST /api/about`
- `GET /api/about/{id}`
- `PUT /api/about/{id}`
- `DELETE /api/about/{id}`

Nota: para subida de imágenes usar `POST /api/projects/{id}?_method=PUT` con `multipart/form-data` porque PHP no maneja bien `PUT` con ficheros.

---

## Decisiones técnicas importantes

### Axios (`src/services/api.js`)
- Siempre envía `Accept: application/json` y `Content-Type: application/json`
- El token se añade automáticamente desde `localStorage` en cada petición
- Para subida de imágenes sobrescribir `Content-Type: multipart/form-data` en la petición concreta

### Imágenes
- Se guardan en Laravel storage (`storage/app/public/projects/`)
- Se sirven desde `VITE_STORAGE_URL/projects/nombre-archivo.jpg`
- Ejecutar `php artisan storage:link` para que sean accesibles públicamente

### Booleanos en form-data
- PHP no convierte bien `"true"`/`"false"` a booleano
- Enviar `1`/`0` y usar `filter_var($data['visible'] ?? true, FILTER_VALIDATE_BOOLEAN)` en el controlador

### Respuestas de la API
Todas las respuestas siguen esta estructura:
```json
{
  "message": "Mensaje descriptivo",
  "data": { ... }
}
```

### Autenticación en el frontend
- El token se guarda en `localStorage`
- Las rutas `/admin/*` están protegidas con navigation guard en el router
- Solo hay un usuario administrador (creado con AdminSeeder)
- No hay registro — es un portfolio personal

---

## Pendiente de implementar

- [ ] Editor de texto enriquecido para el campo `bio` del about (acordado usar uno, pendiente elegir cuál)
- [ ] El bio renderiza HTML con `v-html` + DOMPurify ya instalado
- [ ] Modo oscuro con Tailwind
- [ ] Despliegue en VPS con Apache
- [ ] Configurar CORS para producción en `config/cors.php`
- [ ] Revisar y pulir detalles visuales del panel de administración
- [ ] Posibilidad de reordenar proyectos desde el panel (drag and drop)

---

## Estilo y diseño

- **Paleta:** colores de Tailwind, familia `slate` para azules grisáceos, `stone` para fondos cálidos
- **Tipografía:** DM Serif Display (títulos) + DM Sans (cuerpo) — importadas desde Google Fonts en `index.html`
- **Fondo:** `stone-50` (crema muy suave), no fondo oscuro
- **Acento:** `slate-400` / `slate-500` para enlaces y detalles
- **Diseño:** editorial, limpio, mucho espacio, sin florituras
- **Accesibilidad:** ARIA labels, roles, skip to content, semántica HTML correcta
- **Responsive:** mobile first con Tailwind

---

## Convenciones de código

- `<script setup>` siempre primero, luego `<template>`, luego `<style>` si hace falta
- Desestructuración en peticiones Axios: `const { data } = await api.get(...)`
- Try/catch en todas las peticiones con error guardado en el store
- Un solo Request por modelo en Laravel (se detecta si es POST o PUT con `$this->isMethod`)
- Sin comentarios innecesarios en el código
- Sin `ValidationRule` importado en los Request si no se usa

---

## Comandos útiles

### Frontend
```bash
npm run dev       # servidor de desarrollo
npm run build     # build para producción
```

### Backend
```bash
php artisan serve                    # servidor de desarrollo
php artisan route:list --path=api    # ver rutas de la API
php artisan storage:link             # enlazar storage público
php artisan optimize:clear           # limpiar toda la caché
php artisan db:seed --class=AdminSeeder  # crear usuario admin
```
