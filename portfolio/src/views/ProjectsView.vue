<script setup>
import { useProjectsStore } from '@/stores/projects'
import ProjectCard from '@/components/ProjectCard.vue'
import AppSpinner from '@/components/AppSpinner.vue'
import SectionTag from '@/components/SectionTag.vue'
import { onMounted } from 'vue'

const projectsStore = useProjectsStore()

onMounted(() => {
  projectsStore.fetchProjects()
})
</script>

<template>
  <div class="max-w-5xl mx-auto px-6 py-24">
    <header class="pb-12 mb-12">
      <SectionTag label="Proyectos" class="mb-4" />
      <h1 class="font-serif text-4xl text-slate-800 font-normal">Cosas que he construido</h1>
    </header>

    <AppSpinner v-if="projectsStore.loading" />

    <div v-else-if="projectsStore.error" class="flex justify-center py-24">
      <p class="font-sans text-sm text-red-400">{{ projectsStore.error }}</p>
    </div>

    <ul v-else class="grid md:grid-cols-2 gap-8 list-none" aria-label="Lista de proyectos">
      <li v-for="(project, index) in projectsStore.projects" :key="project.id">
        <ProjectCard :project="project" :index="index" />
      </li>
    </ul>
  </div>
</template>
