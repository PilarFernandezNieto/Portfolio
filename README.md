# Portfolio

Una aplicación fullstack moderna que combina un **frontend dinámico con Vue 3** y un **backend robusto con Laravel** para crear un portafolio profesional interactivo.

## 📋 Descripción

Este proyecto es una solución completa para gestionar y mostrar un portafolio profesional. Está dividido en dos componentes principales:

- **Frontend (`portfolio/`)**: Aplicación moderna con Vue 3 + Vite, diseñada para ofrecer una experiencia de usuario fluida e interactiva
- **Backend (`portfolio-api/`)**: API REST construida con Laravel 13 para gestionar datos del portafolio y autenticación

## 🎯 Funcionalidades Principales

### Frontend (Vue 3 + Vite)
- ✨ Interfaz moderna y responsiva con **Tailwind CSS**
- 🛣️ Enrutamiento con **Vue Router**
- 📦 Gestión de estado con **Pinia**
- 🔄 Comunicación con API mediante **Axios**
- 🛡️ Sanitización de contenido HTML con **DOMPurify**
- ⚡ Desarrollo rápido con Vite y Hot Module Replacement
- 🔍 Linting con ESLint y Oxlint
- 💻 Formatting automático con Prettier

### Backend (Laravel 13)
- 🔐 Autenticación con **Laravel Sanctum**
- 🗄️ ORM elegante con **Eloquent**
- 📦 Migraciones de base de datos
- 🧪 Testing con PHPUnit
- ⚙️ Validación y procesamiento de datos
- 📝 Logging y debugging con Laravel Pail

## 🚀 Requisitos Previos

### Frontend
- Node.js v20.19.0 o superior / v22.12.0 o superior
- npm o yarn

### Backend
- PHP 8.3 o superior
- Composer
- SQLite o base de datos MySQL/PostgreSQL
- Node.js (para assets frontend de Laravel)

## 📦 Instalación

### Setup Completo (Recomendado)

Desde la raíz del proyecto, ejecuta el setup automático del backend:

```bash
cd portfolio-api
composer run setup
```

Este comando ejecutará:
1. Instalación de dependencias PHP
2. Configuración de archivo `.env`
3. Generación de clave de aplicación
4. Migraciones de base de datos
5. Instalación de dependencias Node.js
6. Compilación de assets

### Setup Manual

#### Backend

```bash
cd portfolio-api

# Instalar dependencias
composer install

# Configurar variables de entorno
cp .env.example .env

# Generar clave de aplicación
php artisan key:generate

# Ejecutar migraciones
php artisan migrate

# Instalar dependencias frontend (para assets)
npm install --ignore-scripts

# Compilar assets
npm run build
```

#### Frontend

```bash
cd portfolio

# Instalar dependencias
npm install

# (Opcional) Construir para producción
npm run build
```

## 🏃 Ejecución

### Desarrollo (Backend + Frontend Simultáneamente)

Desde la carpeta `portfolio-api`:

```bash
npm run dev
```

Este comando inicia:
- Servidor Laravel (http://localhost:8000)
- Queue listener para trabajos en background
- Laravel Pail para logging
- Dev server de Vite

### Solo Frontend

```bash
cd portfolio
npm run dev
```

El servidor estará disponible en `http://localhost:5173`

### Solo Backend

```bash
cd portfolio-api
php artisan serve
```

El servidor estará disponible en `http://localhost:8000`

## 🏗️ Compilación y Despliegue

### Frontend - Producción

```bash
cd portfolio
npm run build
```

Genera los archivos optimizados en `dist/`

### Backend - Producción

```bash
cd portfolio-api
php artisan optimize
```

## 📝 Scripts Disponibles

### Frontend

| Comando | Descripción |
|---------|-------------|
| `npm run dev` | Inicia servidor de desarrollo |
| `npm run build` | Compila para producción |
| `npm run preview` | Previsualiza build de producción |
| `npm run lint` | Ejecuta todos los linters |
| `npm run lint:oxlint` | Ejecuta Oxlint con fix |
| `npm run lint:eslint` | Ejecuta ESLint con fix |
| `npm run format` | Formatea código con Prettier |

### Backend

| Comando | Descripción |
|---------|-------------|
| `composer run dev` | Modo desarrollo completo |
| `composer run test` | Ejecuta tests |
| `php artisan migrate` | Ejecuta migraciones |
| `php artisan tinker` | Shell interactivo |

## 🛠️ Stack Tecnológico

### Frontend
- **Vue 3** - Framework progresivo de JavaScript
- **Vite** - Bundler y servidor de desarrollo ultrarrápido
- **Tailwind CSS** - Framework CSS utilitario
- **Vue Router** - Enrutamiento client-side
- **Pinia** - Gestión de estado
- **Axios** - Cliente HTTP
- **DOMPurify** - Sanitización de HTML
- **ESLint + Oxlint** - Linting
- **Prettier** - Code formatting

### Backend
- **Laravel 13** - Framework PHP moderno
- **PHP 8.3** - Lenguaje de programación
- **Laravel Sanctum** - Autenticación API
- **Eloquent ORM** - Mapeo de objetos relacionales
- **PHPUnit** - Testing
- **Composer** - Gestor de dependencias

## 📊 Composición del Repositorio

```
Blade:       38.2% - Templates y configuración
PHP:         36.3% - Lógica backend
Vue:         19.8% - Componentes frontend
JavaScript:   5.1% - Lógica adicional
Otros:        0.6% - Configuraciones
```

## 🔐 Autenticación

El proyecto utiliza **Laravel Sanctum** para autenticación segura:
- Tokens SPA (Single Page Application)
- Protección CSRF automática
- Rate limiting en endpoints sensibles

## 🗄️ Base de Datos

Por defecto, el proyecto usa **SQLite** para desarrollo. Para cambiar a otra base de datos:

1. Edita `.env` en `portfolio-api/`
2. Cambia las variables `DB_*`
3. Ejecuta: `php artisan migrate:fresh`

## 🧪 Testing

```bash
cd portfolio-api
composer run test
```

## 🤝 Estructura del Proyecto

```
Portfolio/
├── portfolio/               # Frontend - Vue 3 + Vite
│   ├── src/
│   │   ├── components/     # Componentes reutilizables
│   │   ├── views/          # Páginas de la aplicación
│   │   ├── stores/         # Estado Pinia
│   │   └── App.vue         # Componente raíz
│   └── package.json        # Dependencias frontend
│
└── portfolio-api/           # Backend - Laravel
    ├── app/
    │   ├── Http/           # Controllers y middleware
    │   ├── Models/         # Modelos Eloquent
    │   └── Services/       # Lógica de negocio
    ├── routes/             # Definición de rutas API
    ├── database/
    │   └── migrations/     # Migraciones
    ├── tests/              # Tests unitarios
    └── composer.json       # Dependencias backend
```

## 📚 Documentación Adicional

- [Documentación de Vue 3](https://vuejs.org/)
- [Documentación de Vite](https://vitejs.dev/)
- [Documentación de Laravel](https://laravel.com/docs)
- [Tailwind CSS](https://tailwindcss.com/)
- [Pinia State Management](https://pinia.vuejs.org/)

## 📄 Licencia

Este proyecto está licenciado bajo la licencia MIT. Ver archivo [LICENSE](LICENSE) para más detalles.

## 👤 Autor

**Pilar Fernández Nieto**

## 🐛 Reportar Problemas

Si encuentras algún problema, por favor crea un issue en el repositorio de GitHub.

---

**Última actualización:** Mayo 2026
