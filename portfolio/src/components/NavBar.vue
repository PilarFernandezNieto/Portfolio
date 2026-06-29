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
  <header class="sticky top-0 z-50 bg-stone-50 border-b border-stone-200">
    <nav
      class="max-w-5xl mx-auto px-6 py-4 flex justify-between items-center"
      aria-label="Navegación principal"
    >
      <RouterLink
        to="/"
        class="font-serif text-slate-800 text-base tracking-wide hover:text-slate-600 transition-colors"
        aria-label="Ir al inicio"
      >
        Pilar Fernández Nieto
      </RouterLink>

      <button
        class="md:hidden text-slate-600 hover:text-slate-800 transition-colors"
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
        class="hidden md:flex gap-8 items-center list-none"
        :class="{
          'flex flex-col absolute top-full left-0 w-full bg-stone-50 border-b border-stone-200 px-6 py-4 gap-4':
            menuOpen,
        }"
      >
        <li v-for="link in links" :key="link.to">
          <RouterLink
            :to="{ name: link.name }"
            class="font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-slate-800 transition-colors"
            :class="{ 'text-slate-800 font-semibold': route.name === link.name }"
          >
            {{ link.label }}
          </RouterLink>
        </li>
        <li v-if="auth.isAuthenticated">
          <RouterLink
            :to="{ name: 'admin' }"
            class="font-sans text-xs tracking-widest uppercase text-slate-400 border border-stone-300 px-3 py-1.5 rounded hover:text-slate-700 hover:border-slate-400 transition-colors"
          >
            Admin
          </RouterLink>
        </li>
      </ul>
    </nav>

    <ul
      v-if="menuOpen"
      class="md:hidden flex flex-col bg-stone-50 border-b border-stone-200 px-6 py-4 gap-4 list-none"
    >
      <li v-for="link in links" :key="link.to">
        <RouterLink
          :to="{ name: link.name }"
          class="font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-slate-800 transition-colors"
          :class="{ 'text-slate-800 font-semibold': route.name === link.name }"
          @click="menuOpen = false"
        >
          {{ link.label }}
        </RouterLink>
      </li>
      <li v-if="auth.isAuthenticated">
        <RouterLink
          :to="{ name: 'admin' }"
          class="font-sans text-xs tracking-widest uppercase text-slate-400 hover:text-slate-700 transition-colors"
          @click="menuOpen = false"
        >
          Admin
        </RouterLink>
      </li>
    </ul>
  </header>
</template>
