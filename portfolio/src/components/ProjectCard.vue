<script setup>
import { computed } from 'vue'

const props = defineProps({
  project: {
    type: Object,
    required: true,
  },
  index: {
    type: Number,
    default: 0,
  },
})

const imageUrl = computed(() =>
  props.project.image ? `${import.meta.env.VITE_STORAGE_URL}/${props.project.image}` : null,
)

const accents = ['bg-marigold', 'bg-periwinkle', 'bg-butter']
const accentClass = computed(() => accents[props.index % accents.length])
</script>

<template>
  <article
    class="bg-white border border-stone-200 rounded-lg overflow-hidden hover:shadow-md hover:border-marigold/50 transition-all"
  >
    <div class="h-1" :class="accentClass" aria-hidden="true" />
    <div class="h-48 bg-slate-800 flex items-center justify-center">
      <img
        v-if="imageUrl"
        :src="imageUrl"
        :alt="project.title"
        class="w-full h-full object-cover"
      />
      <span v-else class="font-serif text-butter text-lg">{{ project.title }}</span>
    </div>

    <div class="p-6">
      <h2 class="font-serif text-xl text-slate-800 mb-2">
        {{ project.title }}
      </h2>
      <p v-if="project.intro" class="font-sans text-sm text-slate-600 leading-relaxed mb-4">
        {{ project.intro }}
      </p>

      <ul class="flex flex-wrap gap-2 mb-6" aria-label="Tecnologías utilizadas">
        <li
          v-for="tech in project.technologies"
          :key="tech"
          class="font-sans text-xs bg-blush/60 text-slate-700 px-3 py-1 rounded-sm font-semibold"
        >
          {{ tech }}
        </li>
      </ul>

      <div class="flex flex-wrap gap-4">
        <RouterLink
          :to="{ name: 'project-detail', params: { id: project.id } }"
          class="font-sans text-xs tracking-widest uppercase text-slate-600 border-b-2 border-marigold pb-0.5 hover:text-slate-800 transition-colors"
          :aria-label="`Ver ficha de ${project.title}`"
        >
          Ver ficha →
        </RouterLink>
        <a
          v-if="project.url"
          :href="project.url"
          target="_blank"
          rel="noopener noreferrer"
          class="font-sans text-xs tracking-widest uppercase text-slate-500 border-b-2 border-periwinkle/60 pb-0.5 hover:text-slate-800 hover:border-periwinkle transition-colors"
          :aria-label="`Abrir ${project.title} en nueva pestaña`"
        >
          Enlace externo ↗
        </a>
      </div>
    </div>
  </article>
</template>
