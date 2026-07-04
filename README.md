# Portfolio — Pilar Fernández Nieto

Portfolio profesional fullstack: **Vue 3 + Vite** en el frontend y **Laravel 13** como API REST en el backend.

## Estructura del repositorio

```
Portfolio/
├── portfolio/          # Frontend — Vue 3 + Vite + Tailwind CSS 4
└── portfolio-api/       # Backend — Laravel 13 API REST
```

## Stack tecnológico

### Frontend (`portfolio/`)
- **Vue 3** + **Vite**
- **Vue Router** + **Pinia** (estado)
- **Tailwind CSS 4**
- **Axios** — cliente HTTP, con interceptores para token y logout automático en 401
- **PrimeVue** (Galleria) — galería de imágenes de proyecto
- **Tiptap** — editor de texto enriquecido (bio y descripción de proyectos)
- **vue-draggable-plus** — reordenar imágenes de un proyecto por arrastre
- **DOMPurify** — sanitizado de HTML antes de renderizar contenido enriquecido
- **ESLint + Oxlint + Prettier** — linting y formato

### Backend (`portfolio-api/`)
- **Laravel 13** sobre **PHP 8.3**
- **Laravel Sanctum** — autenticación por *personal access tokens* (Bearer), sin cookies ni CSRF
- **Eloquent ORM** + migraciones
- **MySQL** (ver `DB_*` en `.env`)

## Requisitos previos

- Node.js `^20.19.0` o `>=22.12.0`
- PHP `^8.3` + Composer
- MySQL

## Instalación

### Backend

```bash
cd portfolio-api
composer install
cp .env.example .env
php artisan key:generate
# Configura DB_* en .env (por defecto MySQL)
php artisan migrate
php artisan storage:link   # necesario para servir imágenes subidas
php artisan db:seed --class=AdminSeeder   # crea el único usuario admin
```

### Frontend

```bash
cd portfolio
npm install
```

Variables de entorno (`portfolio/.env` o `.env.local`):

```env
VITE_API_URL=http://127.0.0.1:8000/api
VITE_STORAGE_URL=http://127.0.0.1:8000/storage
```

## Desarrollo

```bash
# Backend
cd portfolio-api
php artisan serve                # http://localhost:8000

# Frontend (en otra terminal)
cd portfolio
npm run dev                       # http://localhost:5173
```

Alternativa: `composer run dev` en `portfolio-api/` levanta a la vez el servidor de Laravel, el queue listener, `pail` (logs) y Vite, vía `concurrently`.

## Scripts disponibles

### Frontend

| Comando | Descripción |
|---------|-------------|
| `npm run dev` | Servidor de desarrollo |
| `npm run build` | Build de producción |
| `npm run preview` | Previsualiza el build |
| `npm run lint` | Oxlint + ESLint con autofix |
| `npm run format` | Formatea `src/` con Prettier |

### Backend

| Comando | Descripción |
|---------|-------------|
| `composer run dev` | Servidor + queue + logs + Vite en paralelo |
| `composer run test` | Ejecuta la suite de PHPUnit |
| `php artisan migrate` | Ejecuta migraciones |
| `php artisan route:list --path=api` | Lista las rutas de la API |
| `php artisan tinker` | Shell interactivo |

## API

Todas las rutas cuelgan de `/api`. Las de solo lectura son públicas; el resto vive bajo `/api/admin/*` y requiere `Authorization: Bearer {token}`.

**Públicas**
- `GET /projects` — proyectos visibles
- `GET /projects/{id}` — ficha de un proyecto
- `GET /about` — datos de "sobre mí"
- `POST /login`
- `POST /contact` (rate-limited)

**Protegidas (`/admin/*`, requieren token Sanctum)**
- `POST /admin/logout`
- CRUD completo de `projects` y `about` (excepto `index`)
- Subida, borrado y reordenado de imágenes de proyecto

Respuestas con el formato `{ "message": "...", "data": { ... } }`.

## Autenticación

- Login devuelve un *personal access token* de Sanctum (`token` en la respuesta), no una cookie de sesión.
- El frontend lo guarda en `localStorage` y lo añade como `Authorization: Bearer {token}` en cada petición (`portfolio/src/services/api.js`).
- Un 401 de la API borra el token y redirige a `/admin/login`.
- Solo existe un usuario administrador (sin registro público).

## Testing

```bash
cd portfolio-api
composer run test
```

> La suite actual solo contiene los tests de ejemplo generados por Laravel; no hay cobertura real todavía.

## Autora

**Pilar Fernández Nieto**
