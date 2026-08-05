<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useProjectsStore } from '@/stores/projects'
import AppSpinner from '@/components/AppSpinner.vue'
import Galleria from 'primevue/galleria'
import DOMPurify from 'dompurify'
import SectionTag from '@/components/SectionTag.vue'

const route = useRoute()
const router = useRouter()
const store = useProjectsStore()

onMounted(async () => {
  await store.fetchProject(route.params.id)
  if (!store.project) {
    router.replace({ name: 'not-found' })
  }
})

const storageUrl = (path) => `${import.meta.env.VITE_STORAGE_URL}/${path}`

const sanitizedDescription = computed(() =>
  store.project ? DOMPurify.sanitize(store.project.description) : '',
)

const hasGallery = computed(() => store.project?.images?.length > 0)

const galleriaVisible = ref(false)
const galleriaIndex = ref(0)

function openGalleria(index) {
  galleriaIndex.value = index
  galleriaVisible.value = true
}
</script>

<template>
  <div class="max-w-4xl mx-auto px-6 py-24">
    <AppSpinner v-if="store.loading" />

    <div v-else-if="store.error" class="flex justify-center py-24">
      <p class="font-sans text-sm text-red-400">{{ store.error }}</p>
    </div>

    <template v-else-if="store.project">
      <nav class="mb-12">
        <RouterLink
          :to="{ name: 'projects' }"
          class="font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-marigold transition-colors"
        >
          ← Proyectos
        </RouterLink>
      </nav>

      <header class="pb-12 mb-12">
        <SectionTag label="Proyecto" class="mb-4" />
        <h1 class="font-serif text-4xl text-slate-800 font-normal mb-6 mt-2">
          {{ store.project.title }}
        </h1>
        <ul class="flex flex-wrap gap-2" aria-label="Tecnologías utilizadas">
          <li
            v-for="tech in store.project.technologies"
            :key="tech"
            class="font-sans text-xs bg-blush/60 text-slate-700 px-3 py-1 rounded-sm font-semibold"
          >
            {{ tech }}
          </li>
        </ul>
      </header>

      <!-- Galería de capturas -->
      <template v-if="hasGallery">
        <div class="grid grid-cols-2 md:grid-cols-3 gap-3 mb-12">
          <button
            v-for="(img, index) in store.project.images"
            :key="img.id"
            type="button"
            @click="openGalleria(index)"
            class="group relative aspect-video rounded-lg overflow-hidden border border-stone-200 cursor-pointer focus:outline-none focus-visible:ring-2 focus-visible:ring-periwinkle"
            :aria-label="`Ver captura ${index + 1} de ${store.project.images.length}`"
          >
            <img
              :src="storageUrl(img.path)"
              :alt="`Captura ${index + 1}`"
              class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
              loading="lazy"
            />
            <div
              class="absolute inset-0 bg-slate-900/0 group-hover:bg-slate-900/20 transition-colors"
            />
          </button>
        </div>

        <Galleria
          v-model:visible="galleriaVisible"
          v-model:activeIndex="galleriaIndex"
          :value="store.project.images"
          :numVisible="5"
          :fullScreen="true"
          :showItemNavigators="true"
          :circular="true"
        >
          <template #item="{ item }">
            <img
              :src="storageUrl(item.path)"
              :alt="`Captura de ${store.project.title}`"
              class="max-h-screen max-w-full object-contain"
            />
          </template>
          <template #thumbnail="{ item }">
            <img :src="storageUrl(item.path)" alt="" class="h-16 w-24 object-cover" />
          </template>
        </Galleria>
      </template>

      <!-- Imagen portada como fallback si no hay galería -->
      <div
        v-else-if="store.project.image"
        class="w-full rounded-lg overflow-hidden border border-stone-200 mb-12"
      >
        <img
          :src="storageUrl(store.project.image)"
          :alt="`Captura de ${store.project.title}`"
          class="w-full object-cover"
        />
      </div>

      <section class="mt-4">
        <SectionTag label="Descripción" color="periwinkle" class="mb-6" />
        <div>
          <p
            v-if="store.project.intro"
            class="font-sans text-lg text-slate-700 leading-relaxed mb-6 font-normal"
          >
            {{ store.project.intro }}
          </p>
          <div
            class="rich-text font-sans text-base text-slate-600 leading-relaxed mb-8"
            v-html="sanitizedDescription"
          />
          <a
            v-if="store.project.url"
            :href="store.project.url"
            target="_blank"
            rel="noopener noreferrer"
            class="font-sans text-xs tracking-widest uppercase text-slate-600 border-b-2 border-marigold pb-0.5 hover:text-slate-800 transition-colors"
            :aria-label="`Ver proyecto ${store.project.title}`"
          >
            Ver proyecto →
          </a>
        </div>
      </section>
    </template>
  </div>
</template>
