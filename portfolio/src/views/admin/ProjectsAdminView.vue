<script setup>
import { onMounted, ref } from 'vue'
import { useProjectsStore } from '@/stores/projects'
import { useConfirm } from '@/composables/useConfirm'
import AppSpinner from '@/components/AppSpinner.vue'

const store = useProjectsStore()
const successMessage = ref(null)
const { confirm } = useConfirm()

onMounted(() => {
  store.fetchProjects()
})

async function handleDelete(id) {
  const ok = await confirm({ title: 'Eliminar proyecto', message: '¿Seguro que quieres eliminar este proyecto? Esta acción no se puede deshacer.' })
  if (!ok) return
  try {
    const message = await store.deleteProject(id)
    successMessage.value = message
    setTimeout(() => (successMessage.value = null), 3000)
  } catch {
    // el error ya está en store.error
  }
}
</script>

<template>
  <div>
    <header class="flex justify-between items-center mb-10">
      <div>
        <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-2">
          Administración
        </p>
        <h1 class="font-serif text-3xl text-slate-800 font-normal">Proyectos</h1>
      </div>
      <RouterLink
        :to="{ name: 'admin-projects-create' }"
        class="font-sans text-xs tracking-widest uppercase text-white bg-slate-800 px-5 py-3 rounded hover:bg-slate-700 transition-colors"
      >
        + Nuevo proyecto
      </RouterLink>
    </header>

    <div
      v-if="successMessage"
      role="status"
      class="font-sans text-sm text-green-600 bg-green-50 border border-green-200 rounded px-4 py-3 mb-6"
    >
      {{ successMessage }}
    </div>

    <div
      v-if="store.error"
      role="alert"
      class="font-sans text-sm text-red-500 bg-red-50 border border-red-200 rounded px-4 py-3 mb-6"
    >
      {{ store.error }}
    </div>

    <AppSpinner v-if="store.loading" />

    <div v-else class="flex flex-col gap-4">
      <div
        v-for="project in store.projects"
        :key="project.id"
        class="bg-white border border-stone-200 rounded-lg px-6 py-4 flex justify-between items-center"
      >
        <div>
          <p class="font-serif text-lg text-slate-800">{{ project.title }}</p>
          <div class="flex gap-2 mt-2 flex-wrap">
            <span
              v-for="tech in project.technologies"
              :key="tech"
              class="font-sans text-xs bg-slate-100 text-slate-600 px-2 py-0.5 rounded-sm"
            >
              {{ tech }}
            </span>
          </div>
        </div>

        <div class="flex gap-4 shrink-0 ml-6">
          <RouterLink
            :to="{ name: 'admin-projects-edit', params: { id: project.id } }"
            class="font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-slate-800 transition-colors"
          >
            Editar
          </RouterLink>
          <button
            @click="handleDelete(project.id)"
            class="font-sans text-xs tracking-widest uppercase text-red-400 hover:text-red-600 transition-colors"
          >
            Eliminar
          </button>
        </div>
      </div>

      <div v-if="!store.loading && store.projects.length === 0" class="text-center py-24">
        <p class="font-sans text-sm text-slate-400">No hay proyectos todavía.</p>
      </div>
    </div>
  </div>
</template>
