import { defineStore } from 'pinia'
import { ref } from 'vue'
import api from '@/services/api'

export const useProjectsStore = defineStore('projects', () => {
  const projects = ref([])
  const project = ref(null)
  const error = ref(null)
  const loading = ref(false)

  async function fetchProjects() {
    loading.value = true
    error.value = null
    try {
      const { data } = await api.get('/projects')
      projects.value = data.data
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al cargar los proyectos'
    } finally {
      loading.value = false
    }
  }

  async function fetchProject(id) {
    loading.value = true
    error.value = null
    try {
      const { data } = await api.get(`/projects/${id}`)
      project.value = data.data
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al cargar el proyecto'
    } finally {
      loading.value = false
    }
  }

  async function createProject(formData) {
    error.value = null
    try {
      const { data } = await api.post('/projects', formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
      })
      projects.value.push(data.data)
      return data.message
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al crear el proyecto'
      throw e
    }
  }

  async function updateProject(id, formData) {
    error.value = null
    try {
      const { data } = await api.post(`/projects/${id}?_method=PUT`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
      })
      const index = projects.value.findIndex((p) => p.id === id)
      if (index !== -1) projects.value[index] = data.data
      return data.message
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al actualizar el proyecto'
      throw e
    }
  }

  async function deleteProject(id) {
    error.value = null
    try {
      const { data } = await api.delete(`/projects/${id}`)
      projects.value = projects.value.filter((p) => p.id !== id)
      return data.message
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al eliminar el proyecto'
      throw e
    }
  }

  return {
    projects,
    project,
    error,
    loading,
    fetchProjects,
    fetchProject,
    createProject,
    updateProject,
    deleteProject,
  }
})
