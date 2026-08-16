<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import FormLabel from '@/components/FormLabel.vue'
import ButtonDark from '@/components/ButtonDark.vue'

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
  <div class="min-h-screen bg-cream flex items-center justify-center px-6 py-16">
    <div class="w-full max-w-sm">
      <div class="text-center mb-12">
        <div class="font-sans text-[22px] uppercase tracking-tight mb-4 text-ink">
          Pilar Fernández Nieto
        </div>
        <div class="font-sans text-[13px] font-bold tracking-widest uppercase text-muted">
          Acceso al panel
        </div>
      </div>

      <form @submit.prevent="handleLogin" novalidate>
        <div class="mb-6.5">
          <FormLabel for="email">Email</FormLabel>
          <input
            id="email"
            v-model="credentials.email"
            type="email"
            autocomplete="email"
            required
            placeholder="tu@email.com"
            class="w-full border-0 border-b border-ink bg-transparent font-sans text-base text-ink py-2.5 outline-none placeholder:text-ink/40 focus:border-b-2"
          />
        </div>

        <div class="mb-4.5">
          <FormLabel for="password">Contraseña</FormLabel>
          <input
            id="password"
            v-model="credentials.password"
            type="password"
            autocomplete="current-password"
            required
            placeholder="••••••••"
            class="w-full border-0 border-b border-ink bg-transparent font-sans text-base text-ink py-2.5 outline-none placeholder:text-ink/40 focus:border-b-2"
          />
        </div>

        <div class="flex justify-between items-center mb-9">
          <label class="flex items-center gap-2 font-sans text-[13px] text-ink">
            <input type="checkbox" class="accent-ink" /> Recordarme
          </label>
          <a
            href="#"
            class="font-sans text-[13px] font-semibold text-ink hover:opacity-70 transition-opacity"
          >
            ¿Olvidaste tu contraseña?
          </a>
        </div>

        <div v-if="auth.error" role="alert" class="font-sans text-sm text-red-500 mb-6">
          {{ auth.error }}
        </div>

        <ButtonDark type="submit" :disabled="loading" size="lg" class="w-full">
          {{ loading ? 'Accediendo…' : 'Entrar' }}
        </ButtonDark>
      </form>
    </div>
  </div>
</template>
