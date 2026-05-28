import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import api from '@/services/api'

export const useAuthStore = defineStore('auth', () => {
  const token = ref(localStorage.getItem('token') || null)
  const user = ref(null)
  const error = ref(null)

  const isAuthenticated = computed(() => !!token.value)

  async function login(credentials) {
    error.value = null
    try {
      const { data } = await api.post('/login', credentials)
      token.value = data.token
      localStorage.setItem('token', data.token)
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al iniciar sesión'
      throw e
    }
  }

  async function logout() {
    error.value = null
    try {
      await api.post('/logout')
    } catch (e) {
      // Si falla el logout en el servidor borramos el token igualmente
    } finally {
      token.value = null
      user.value = null
      localStorage.removeItem('token')
    }
  }

  return { token, user, error, isAuthenticated, login, logout }
})
