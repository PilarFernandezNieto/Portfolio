import { defineStore } from 'pinia'
import { ref } from 'vue'
import api from '@/services/api'

export const useAboutStore = defineStore('about', () => {
  const about = ref(null)
  const error = ref(null)
  const loading = ref(false)

  async function fetchAbout() {
    loading.value = true
    error.value = null
    try {
      const { data } = await api.get('/about')
      about.value = data.data
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al cargar la información'
    } finally {
      loading.value = false
    }
  }

  async function updateAbout(payload) {
    error.value = null
    try {
      const { data } = await api.put(`/about/${about.value.id}`, payload)
      about.value = data.data
      return data.message
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al actualizar la información'
      throw e
    }
  }

  return {
    about,
    error,
    loading,
    fetchAbout,
    updateAbout,
  }
})
