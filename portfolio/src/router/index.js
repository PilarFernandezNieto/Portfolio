import { useAuthStore } from '@/stores/auth.js'
import HomeView from '@/views/HomeView.vue'
import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/sobre-mi',
      name: 'about',
      component: () => import('../views/AboutView.vue'),
    },
    {
      path: '/proyectos',
      name: 'projects',
      component: () => import('../views/ProjectsView.vue'),
    },
    {
      path: '/proyectos/:id',
      name: 'project-detail',
      component: () => import('../views/ProjectDetailView.vue'),
    },
    {
      path: '/cv',
      name: 'cv',
      component: () => import('../views/CVView.vue'),
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
})

router.beforeEach((to) => {
  const auth = useAuthStore()
  if (to.meta.requiredAuth && !auth.isAuthenticated) {
    return { name: 'login' }
  }
  if (to.name === 'login' && auth.isAuthenticated) {
    return { name: 'admin-projects' }
  }
})

export default router
