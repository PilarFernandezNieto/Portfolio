<script setup>
import { onMounted, onUnmounted, ref, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const route = useRoute()
const auth = useAuthStore()

const mobileMenuOpen = ref(false)

onMounted(() => {
  document.body.style.overflow = 'hidden'
})
onUnmounted(() => {
  document.body.style.overflow = ''
})

watch(
  () => route.fullPath,
  () => {
    mobileMenuOpen.value = false
  },
)

async function handleLogout() {
  await auth.logout()
  router.push({ name: 'login' })
}
</script>

<template>
  <div class="h-screen bg-stone-50 flex flex-col md:flex-row overflow-hidden">
    <header class="md:hidden flex items-center justify-between px-4 py-4 bg-slate-800 shrink-0">
      <div class="flex items-center gap-2.5">
        <span
          class="w-7 h-7 rounded-md bg-marigold text-slate-900 flex items-center justify-center font-serif text-sm shrink-0"
          aria-hidden="true"
        >
          P
        </span>
        <p class="font-serif text-white text-lg leading-none">Panel</p>
      </div>
      <button
        type="button"
        @click="mobileMenuOpen = !mobileMenuOpen"
        class="text-slate-300 hover:text-white p-2 -mr-2"
        :aria-expanded="mobileMenuOpen"
        aria-label="Abrir menú de administración"
      >
        <svg
          v-if="!mobileMenuOpen"
          xmlns="http://www.w3.org/2000/svg"
          class="w-6 h-6"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
          aria-hidden="true"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M4 6h16M4 12h16M4 18h16"
          />
        </svg>
        <svg
          v-else
          xmlns="http://www.w3.org/2000/svg"
          class="w-6 h-6"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
          aria-hidden="true"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M6 18L18 6M6 6l12 12"
          />
        </svg>
      </button>
    </header>

    <div
      v-if="mobileMenuOpen"
      class="fixed inset-0 bg-slate-900/50 z-30 md:hidden"
      @click="mobileMenuOpen = false"
    />

    <aside
      class="w-64 bg-slate-800 flex flex-col shrink-0 fixed md:static inset-y-0 left-0 z-40 transition-transform duration-200 md:translate-x-0"
      :class="mobileMenuOpen ? 'translate-x-0' : '-translate-x-full'"
      aria-label="Panel de administración"
    >
      <div class="px-6 py-8 border-b border-slate-700 flex items-center gap-2.5">
        <span
          class="w-7 h-7 rounded-md bg-marigold text-slate-900 flex items-center justify-center font-serif text-sm shrink-0"
          aria-hidden="true"
        >
          P
        </span>
        <div>
          <p class="font-serif text-white text-lg leading-none">Panel</p>
          <p class="font-sans text-xs text-slate-300 mt-1">Pilar Fernández Nieto</p>
        </div>
      </div>

      <nav class="flex-1 px-4 py-6 flex flex-col gap-2">
        <RouterLink
          :to="{ name: 'admin-projects' }"
          class="font-sans text-xs tracking-widest uppercase text-slate-300 hover:text-marigold px-4 py-3 rounded hover:bg-slate-700 transition-colors"
          :class="{ 'text-marigold bg-slate-700 font-semibold': $route.name === 'admin-projects' }"
        >
          Proyectos
        </RouterLink>
        <RouterLink
          :to="{ name: 'admin-about' }"
          class="font-sans text-xs tracking-widest uppercase text-slate-300 hover:text-marigold px-4 py-3 rounded hover:bg-slate-700 transition-colors"
          :class="{ 'text-marigold bg-slate-700 font-semibold': $route.name === 'admin-about' }"
        >
          Sobre mí
        </RouterLink>
      </nav>

      <div class="px-4 py-6 border-t border-slate-700 flex flex-col gap-2">
        <RouterLink
          :to="{ name: 'home' }"
          class="w-full font-sans text-xs tracking-widest uppercase text-slate-300 hover:text-periwinkle px-4 py-3 rounded hover:bg-slate-700 transition-colors"
        >
          Ver portfolio
        </RouterLink>
        <button
          @click="handleLogout"
          class="w-full font-sans text-xs tracking-widest uppercase text-slate-300 hover:text-periwinkle px-4 py-3 rounded hover:bg-slate-700 transition-colors text-left"
        >
          Cerrar sesión
        </button>
      </div>
    </aside>

    <main class="flex-1 p-6 md:p-10 overflow-y-auto min-h-0">
      <RouterView />
    </main>
  </div>
</template>
