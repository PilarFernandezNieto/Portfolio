<script setup>
import { ref } from 'vue'
import { RouterLink, useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const route = useRoute()
const auth = useAuthStore()
const menuOpen = ref(false)

const toggleMenu = () => {
  menuOpen.value = !menuOpen.value
}

const links = [
  { to: '/', name: 'home', label: 'Inicio' },
  { to: '/sobre-mi', name: 'about', label: 'Sobre mí' },
  { to: '/proyectos', name: 'projects', label: 'Proyectos' },
  { to: '/cv', name: 'cv', label: 'CV' },
  { to: '/contacto', name: 'contact', label: 'Contacto' },
]
</script>
<template>
  <header class="sticky top-0 z-50 bg-cream border-b border-ink">
    <nav
      class="max-w-5xl mx-auto px-6 py-3.5 flex flex-wrap gap-4 justify-between items-center"
      aria-label="Navegación principal"
    >
      <RouterLink to="/" class="font-sans text-lg font-bold tracking-wide uppercase text-ink">
        Pilar Fernández Nieto
      </RouterLink>

      <button
        class="md:hidden text-ink"
        aria-label="Abrir menú"
        aria-controls="nav-menu"
        @click="toggleMenu"
        :aria-expanded="menuOpen.toString()"
      >
        <span v-if="!menuOpen">☰</span>
        <span v-else>✕</span>
      </button>

      <ul
        id="nav-menu"
        class="hidden md:flex flex-wrap gap-8 items-center list-none"
        :class="{
          'flex flex-col absolute top-full left-0 w-full bg-cream border-b border-ink px-6 py-4 gap-4':
            menuOpen,
        }"
      >
        <li v-for="link in links" :key="link.to">
          <RouterLink
            :to="{ name: link.name }"
            class="font-sans text-[13px] font-semibold tracking-[0.12em] uppercase text-ink focus-visible:outline focus-visible:outline-ink focus-visible:outline-offset-[3px]"
            :class="
              route.name === link.name
                ? 'border-b-2 border-ink pb-0.5'
                : 'hover:opacity-70 transition-opacity'
            "
          >
            {{ link.label }}
          </RouterLink>
        </li>
        <li v-if="auth.isAuthenticated">
          <RouterLink
            :to="{ name: 'admin' }"
            class="font-sans text-xs font-semibold tracking-widest uppercase text-ink border border-ink px-3 py-1.5 hover:bg-ink hover:text-cream transition-colors"
          >
            Admin
          </RouterLink>
        </li>
      </ul>
    </nav>

    <ul
      v-if="menuOpen"
      class="md:hidden flex flex-col bg-cream border-b border-ink px-6 py-4 gap-4 list-none"
    >
      <li v-for="link in links" :key="link.to">
        <RouterLink
          :to="{ name: link.name }"
          class="font-sans text-[13px] font-semibold tracking-[0.12em] uppercase text-ink"
          :class="route.name === link.name ? 'border-b-2 border-ink pb-0.5 w-fit' : ''"
          @click="menuOpen = false"
        >
          {{ link.label }}
        </RouterLink>
      </li>
      <li v-if="auth.isAuthenticated">
        <RouterLink
          :to="{ name: 'admin' }"
          class="font-sans text-xs font-semibold tracking-widest uppercase text-ink"
          @click="menuOpen = false"
        >
          Admin
        </RouterLink>
      </li>
    </ul>
  </header>
</template>
