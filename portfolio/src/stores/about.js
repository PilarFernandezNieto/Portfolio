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

  async function updateAbout(formData) {
    error.value = null
    try {
      const { data } = await api.post(`/admin/about/${about.value.id}?_method=PUT`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
      })
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
