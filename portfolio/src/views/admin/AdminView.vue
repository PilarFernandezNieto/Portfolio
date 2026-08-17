<script setup>
import { onMounted, onUnmounted, ref, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import Toast from 'primevue/toast'

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
  <div class="h-screen bg-cream flex flex-col md:flex-row overflow-hidden">
    <Toast position="top-right" />

    <header class="md:hidden flex items-center justify-between px-5 py-4 bg-ink shrink-0">
      <p class="font-sans text-base uppercase tracking-tight text-cream">Panel</p>
      <button
        type="button"
        @click="mobileMenuOpen = !mobileMenuOpen"
        class="text-cream p-2 -mr-2"
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
      class="fixed inset-0 bg-ink/50 z-30 md:hidden"
      @click="mobileMenuOpen = false"
    />

    <aside
      class="w-60 bg-ink flex flex-col shrink-0 fixed md:static inset-y-0 left-0 z-40 transition-transform duration-200 md:translate-x-0"
      :class="mobileMenuOpen ? 'translate-x-0' : '-translate-x-full'"
      aria-label="Panel de administración"
    >
      <div class="px-7 pt-7 pb-8">
        <p class="font-sans text-lg uppercase tracking-tight text-cream">Panel</p>
        <p class="font-sans text-xs text-subtle mt-1">Pilar Fernández Nieto</p>
      </div>

      <nav class="flex-1 flex flex-col gap-1">
        <RouterLink
          :to="{ name: 'admin-projects' }"
          class="text-left font-sans text-[13px] font-bold tracking-widest uppercase text-cream px-7 py-3.5"
          :class="$route.name?.startsWith('admin-projects') ? 'bg-cream/10' : 'hover:bg-cream/5'"
        >
          Proyectos
        </RouterLink>
        <RouterLink
          :to="{ name: 'admin-about' }"
          class="text-left font-sans text-[13px] font-bold tracking-widest uppercase text-cream px-7 py-3.5"
          :class="$route.name === 'admin-about' ? 'bg-cream/10' : 'hover:bg-cream/5'"
        >
          Sobre mí
        </RouterLink>
      </nav>

      <div class="border-t border-cream/20">
        <RouterLink
          :to="{ name: 'home' }"
          class="block w-full font-sans text-xs font-semibold tracking-widest uppercase text-subtle hover:text-cream px-7 py-3.5 transition-colors"
        >
          Ver portfolio
        </RouterLink>
        <button
          @click="handleLogout"
          class="w-full text-left font-sans text-xs font-semibold tracking-widest uppercase text-subtle hover:text-cream px-7 py-3.5 transition-colors"
        >
          Cerrar sesión
        </button>
      </div>
    </aside>

    <main class="flex-1 p-6 md:p-14 overflow-y-auto min-h-0">
      <RouterView />
    </main>
  </div>
</template>
