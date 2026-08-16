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

const displayIndex = computed(() => String(props.index + 1).padStart(2, '0'))
</script>

<template>
  <article class="flex flex-wrap gap-8 items-center py-9 border-t border-ink">
    <div
      class="flex-[0_0_200px] w-50 aspect-4/3 flex items-center justify-center bg-border-soft overflow-hidden"
      :style="
        !imageUrl
          ? {
              backgroundImage:
                'repeating-linear-gradient(135deg, #161513 0px, #161513 1px, transparent 1px, transparent 12px)',
            }
          : undefined
      "
      role="img"
      :aria-label="`Marcador de captura de pantalla para el proyecto ${project.title}`"
    >
      <img
        v-if="imageUrl"
        :src="imageUrl"
        :alt="project.title"
        class="w-full h-full object-cover"
      />
      <span v-else class="font-mono text-xs text-ink bg-cream px-2.5 py-1.5">captura</span>
    </div>

    <div class="flex-[1_1_320px]">
      <div class="font-sans text-xs font-bold tracking-widest text-muted mb-2">
        {{ displayIndex }}
      </div>
      <h2 class="font-serif text-2xl mb-2.5 text-ink uppercase">
        {{ project.title }}
      </h2>
      <p v-if="project.intro" class="font-sans text-[15px] leading-normal text-ink/75 max-w-xl">
        {{ project.intro }}
      </p>
      <ul
        v-else-if="project.technologies?.length"
        class="flex flex-wrap gap-2 mt-1"
        aria-label="Tecnologías utilizadas"
      >
        <li
          v-for="tech in project.technologies"
          :key="tech"
          class="font-sans text-[11px] font-semibold tracking-wider uppercase bg-tag text-cream px-2.5 py-1"
        >
          {{ tech }}
        </li>
      </ul>
    </div>

    <div class="flex-[0_0_auto] flex flex-col gap-3 items-start">
      <RouterLink
        :to="{ name: 'project-detail', params: { id: project.id } }"
        class="text-ink font-sans text-[13px] font-bold tracking-widest uppercase border border-ink px-5.5 py-2.5 whitespace-nowrap focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
        :aria-label="`Ver ficha de ${project.title}`"
      >
        Ver ficha
      </RouterLink>
      <a
        v-if="project.url"
        :href="project.url"
        target="_blank"
        rel="noopener noreferrer"
        class="text-ink font-sans text-[13px] font-bold tracking-widest uppercase px-5.5 py-2.5 whitespace-nowrap focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
        :aria-label="`Abrir ${project.title} en nueva pestaña`"
      >
        Ver sitio ↗
      </a>
    </div>
  </article>
</template>
