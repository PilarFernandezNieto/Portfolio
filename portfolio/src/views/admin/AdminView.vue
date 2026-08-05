<script setup>
import { onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const auth = useAuthStore()

onMounted(() => {
  document.body.style.overflow = 'hidden'
})
onUnmounted(() => {
  document.body.style.overflow = ''
})

async function handleLogout() {
  await auth.logout()
  router.push({ name: 'login' })
}
</script>

<template>
  <div class="h-screen bg-stone-50 flex overflow-hidden">
    <aside class="w-64 bg-slate-800 flex flex-col shrink-0" aria-label="Panel de administración">
      <div class="px-6 py-8 border-b border-slate-700 flex items-center gap-2.5">
        <span
          class="w-7 h-7 rounded-md bg-marigold text-slate-900 flex items-center justify-center font-serif text-sm shrink-0"
          aria-hidden="true"
        >
          P
        </span>
        <div>
          <p class="font-serif text-white text-lg leading-none">Panel</p>
          <p class="font-sans text-xs text-slate-500 mt-1">Pilar Fernández Nieto</p>
        </div>
      </div>

      <nav class="flex-1 px-4 py-6 flex flex-col gap-2">
        <RouterLink
          :to="{ name: 'admin-projects' }"
          class="font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-marigold px-4 py-3 rounded hover:bg-slate-700 transition-colors"
          :class="{ 'text-marigold bg-slate-700 font-semibold': $route.name === 'admin-projects' }"
        >
          Proyectos
        </RouterLink>
        <RouterLink
          :to="{ name: 'admin-about' }"
          class="font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-marigold px-4 py-3 rounded hover:bg-slate-700 transition-colors"
          :class="{ 'text-marigold bg-slate-700 font-semibold': $route.name === 'admin-about' }"
        >
          Sobre mí
        </RouterLink>
      </nav>

      <div class="px-4 py-6 border-t border-slate-700 flex flex-col gap-2">
        <RouterLink
          :to="{ name: 'home' }"
          class="w-full font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-periwinkle px-4 py-3 rounded hover:bg-slate-700 transition-colors"
        >
          Ver portfolio
        </RouterLink>
        <button
          @click="handleLogout"
          class="w-full font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-periwinkle px-4 py-3 rounded hover:bg-slate-700 transition-colors text-left"
        >
          Cerrar sesión
        </button>
      </div>
    </aside>

    <main class="flex-1 p-10 overflow-y-auto min-h-0">
      <RouterView />
    </main>
  </div>
</template>
