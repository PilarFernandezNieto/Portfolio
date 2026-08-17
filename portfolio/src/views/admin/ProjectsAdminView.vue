<script setup>
import { onMounted } from 'vue'
import { useToast } from 'primevue/usetoast'
import { useProjectsStore } from '@/stores/projects'
import { useConfirm } from '@/composables/useConfirm'
import AppSpinner from '@/components/AppSpinner.vue'
import ButtonDark from '@/components/ButtonDark.vue'

const store = useProjectsStore()
const toast = useToast()
const { confirm } = useConfirm()

onMounted(() => {
  store.fetchProjects()
})

async function handleDelete(id) {
  const ok = await confirm({
    title: 'Eliminar proyecto',
    message: '¿Seguro que quieres eliminar este proyecto? Esta acción no se puede deshacer.',
  })
  if (!ok) return
  try {
    const message = await store.deleteProject(id)
    toast.add({ severity: 'success', summary: message, life: 3000 })
  } catch {
    // el error ya está en store.error
  }
}
</script>

<template>
  <div>
    <header class="flex flex-wrap justify-between items-end gap-5 mb-10">
      <div>
        <p class="font-sans text-xs font-bold tracking-[0.2em] uppercase text-muted mb-2.5">
          Administración
        </p>
        <h1 class="heading heading-admin">
          Proyectos
        </h1>
      </div>
      <ButtonDark :to="{ name: 'admin-projects-create' }" variant="outline">
        Añadir proyecto
      </ButtonDark>
    </header>

    <div
      v-if="store.error"
      role="alert"
      class="font-sans text-sm text-red-600 border border-red-300 px-4 py-3 mb-6"
    >
      {{ store.error }}
    </div>

    <AppSpinner v-if="store.loading" />

    <div v-else role="table" aria-label="Listado de proyectos" class="flex flex-col">
      <div
        role="row"
        class="flex gap-5 pb-3.5 border-b border-ink font-sans text-[11px] font-bold tracking-wider uppercase text-muted"
      >
        <div class="flex-[0_0_60px]">Índice</div>
        <div class="flex-[2_1_260px]">Proyecto</div>
        <div class="flex-[0_0_160px] text-right">Acciones</div>
      </div>

      <div
        v-for="(project, index) in store.projects"
        :key="project.id"
        role="row"
        class="flex flex-wrap gap-5 items-center py-5 border-b border-border-soft"
      >
        <div class="flex-[0_0_60px] font-sans text-[13px] text-muted">
          {{ String(index + 1).padStart(2, '0') }}
        </div>
        <div class="flex-[2_1_260px]">
          <div class="font-serif text-[17px] text-ink uppercase">{{ project.title }}</div>
          <div v-if="project.intro" class="font-sans text-[13px] text-ink/65 mt-1">
            {{ project.intro }}
          </div>
        </div>
        <div class="flex-[0_0_160px] flex gap-2 justify-end">
          <RouterLink
            :to="{ name: 'admin-projects-edit', params: { id: project.id } }"
            class="text-cream font-sans text-xs font-bold tracking-wider uppercase bg-edit border border-edit px-3.5 py-2 focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-2"
          >
            Editar
          </RouterLink>
          <button
            type="button"
            @click="handleDelete(project.id)"
            class="text-cream font-sans text-xs font-bold tracking-wider uppercase bg-delete border border-delete px-3.5 py-2 focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-2"
          >
            Eliminar
          </button>
        </div>
      </div>

      <div v-if="!store.loading && store.projects.length === 0" class="text-center py-24">
        <p class="font-sans text-sm text-muted">No hay proyectos todavía.</p>
      </div>
    </div>
  </div>
</template>
