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
      return data.data
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
      project.value = data.data
      return data.data
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

  async function addProjectImages(projectId, files) {
    error.value = null
    const formData = new FormData()
    files.forEach((file) => formData.append('images[]', file))
    try {
      const { data } = await api.post(`/projects/${projectId}/images`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
      })
      if (project.value?.id === Number(projectId)) {
        project.value.images = [...(project.value.images || []), ...data.data]
      }
      return data.data
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al subir las imágenes'
      throw e
    }
  }

  async function deleteProjectImage(projectId, imageId) {
    error.value = null
    try {
      await api.delete(`/projects/${projectId}/images/${imageId}`)
      if (project.value?.id === Number(projectId)) {
        project.value.images = project.value.images.filter((img) => img.id !== imageId)
      }
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al eliminar la imagen'
      throw e
    }
  }

  async function reorderProjectImages(projectId, images) {
    error.value = null
    try {
      await api.put(`/projects/${projectId}/images/reorder`, { images })
    } catch (e) {
      error.value = e.response?.data?.message || 'Error al reordenar las imágenes'
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
    addProjectImages,
    deleteProjectImage,
    reorderProjectImages,
  }
})
