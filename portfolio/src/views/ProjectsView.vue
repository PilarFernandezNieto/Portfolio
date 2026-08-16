<script setup>
import { useProjectsStore } from '@/stores/projects'
import ProjectCard from '@/components/ProjectCard.vue'
import AppSpinner from '@/components/AppSpinner.vue'
import { onMounted } from 'vue'

const projectsStore = useProjectsStore()

onMounted(() => {
  projectsStore.fetchProjects()
})
</script>

<template>
  <div class="max-w-5xl mx-auto px-6">
    <header class="pt-16 md:pt-24 pb-8 md:pb-12 border-b border-ink">
      <p class="font-sans text-[13px] font-bold tracking-[0.2em] uppercase text-muted mb-4.5">
        Portfolio
      </p>
      <h1
        class="heading heading-1 mb-5"
      >
        Proyectos
      </h1>
      <p class="font-sans text-[17px] leading-normal text-ink/85 max-w-xl">
        Una selección de trabajos de desarrollo full-stack: arquitectura, backend e interfaz de
        punta a punta.
      </p>
    </header>

    <AppSpinner v-if="projectsStore.loading" />

    <div v-else-if="projectsStore.error" class="flex justify-center py-24">
      <p class="font-sans text-sm text-red-400">{{ projectsStore.error }}</p>
    </div>

    <ul
      v-else
      class="list-none py-8 md:py-14"
      aria-label="Lista de proyectos"
    >
      <li v-for="(project, index) in projectsStore.projects" :key="project.id">
        <ProjectCard :project="project" :index="index" />
      </li>
    </ul>
  </div>
</template>
