<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const auth = useAuthStore()

const credentials = ref({
  email: '',
  password: '',
})

const loading = ref(false)

async function handleLogin() {
  loading.value = true
  try {
    await auth.login(credentials.value)
    router.push({ name: 'admin-projects' })
  } catch {
    // el error ya está en auth.error
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="min-h-screen bg-stone-50 flex items-center justify-center px-6">
    <div class="w-full max-w-sm">
      <div class="mb-10">
        <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-4">
          Panel de administración
        </p>
        <h1 class="font-serif text-4xl text-slate-800 font-normal">Acceder</h1>
      </div>

      <form @submit.prevent="handleLogin" class="flex flex-col gap-6" novalidate>
        <div class="flex flex-col gap-2">
          <label
            for="email"
            class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
          >
            Email
          </label>
          <input
            id="email"
            v-model="credentials.email"
            type="email"
            autocomplete="email"
            required
            class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors"
          />
        </div>

        <div class="flex flex-col gap-2">
          <label
            for="password"
            class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
          >
            Contraseña
          </label>
          <input
            id="password"
            v-model="credentials.password"
            type="password"
            autocomplete="current-password"
            required
            class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors"
          />
        </div>

        <div v-if="auth.error" role="alert" class="font-sans text-sm text-red-500">
          {{ auth.error }}
        </div>

        <button
          type="submit"
          :disabled="loading"
          class="font-sans text-xs tracking-widest uppercase text-white bg-slate-800 px-6 py-3 rounded hover:bg-slate-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {{ loading ? 'Accediendo...' : 'Acceder' }}
        </button>
      </form>
    </div>
  </div>
</template>
