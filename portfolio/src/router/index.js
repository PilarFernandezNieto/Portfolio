import { useAuthStore } from '@/stores/auth.js';
import HomeView from '@/views/HomeView.vue';
import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      meta: {
        title: 'Desarrolladora full-stack en Gijón',
        description: 'Portfolio de Pilar Fernández Nieto. PHP, Vue, Laravel',
      },
      component: HomeView,
    },
    {
      path: '/sobre-mi',
      name: 'about',
      meta: {
        title: 'Sobre mí',
        description: 'Quién soy, cómo trabajo y qué tecnologías uso.',
      },
      component: () => import('../views/AboutView.vue'),
    },
    {
      path: '/proyectos',
      name: 'projects',
      meta: {
        title: 'Proyectos',
        description: 'Proyectos web que he diseñado y desarrollado',
      },
      component: () => import('../views/ProjectsView.vue'),
    },
    {
      path: '/proyectos/:id',
      name: 'project-detail',
      meta: { title: 'Proyecto :id', description: 'Detalles del proyecto.' },
      component: () => import('../views/ProjectDetailView.vue'),
    },
    {
      path: '/cv',
      name: 'cv',
      meta: { title: 'Currículum', description: 'Experiencia y formación.' },
      component: () => import('../views/CVView.vue'),
    },
    {
      path: '/contacto',
      name: 'contact',
      meta: { title: 'Contacto', description: 'Cómo contactar con Pilar Fernández Nieto.' },
      component: () => import('../views/ContactView.vue'),
    },
    {
      path: '/politica-de-privacidad',
      name: 'privacy',
      meta: {
        title: 'Política de privacidad',
        description: 'Política de privacidad de pilarfdez.es',
      },
      component: () => import('../views/PoliticaPrivacidadView.vue'),
    },
    {
      path: '/admin/login',
      name: 'login',
      component: () => import('../views/admin/LoginView.vue'),
    },
    {
      path: '/admin',
      name: 'admin',
      component: () => import('../views/admin/AdminView.vue'),
      meta: { requiredAuth: true },
      redirect: { name: 'admin-projects' },
      children: [
        {
          path: '',
          name: 'admin-projects',
          component: () => import('../views/admin/ProjectsAdminView.vue'),
        },
        {
          path: 'proyectos/nuevo',
          name: 'admin-projects-create',
          component: () => import('../views/admin/ProjectFormView.vue'),
        },
        {
          path: 'proyectos/:id/editar',
          name: 'admin-projects-edit',
          component: () => import('../views/admin/ProjectFormView.vue'),
        },

        {
          path: 'sobre-mi',
          name: 'admin-about',
          component: () => import('../views/admin/AboutAdminView.vue'),
        },
      ],
    },
    {
      path: '/:pathMatch(.*)*',
      name: 'not-found',
      component: () => import('../views/NotFoundView.vue'),
    },
  ],
});

router.beforeEach((to) => {
  const auth = useAuthStore();
  if (to.meta.requiredAuth && !auth.isAuthenticated) {
    return { name: 'login' };
  }
  if (to.name === 'login' && auth.isAuthenticated) {
    return { name: 'admin-projects' };
  }
});

const defaultTitle = 'Pilar Fernández Nieto - Desarrolladora full-stack';
const defaultDescription = 'Portfolio de Pilar Fernández Nieto';

router.afterEach((to) => {
  document.title = to.meta.title ? `${to.meta.title} - Pilar Fernández Nieto` : defaultTitle;
  document
    .querySelector('meta[name="description"]')
    ?.setAttribute('content', to.meta.description ?? defaultDescription);
});
export default router;
