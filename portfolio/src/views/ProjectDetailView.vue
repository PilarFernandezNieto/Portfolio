<script setup>
import { computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useProjectsStore } from '@/stores/projects'
import AppSpinner from '@/components/AppSpinner.vue'
import DOMPurify from 'dompurify'

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
          class="font-sans text-xs tracking-widest uppercase text-slate-400 hover:text-slate-700 transition-colors"
        >
          ← Proyectos
        </RouterLink>
      </nav>

      <header class="border-b border-stone-200 pb-12 mb-12">
        <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-4">
          Proyecto
        </p>
        <h1 class="font-serif text-4xl text-slate-800 font-normal mb-6">
          {{ store.project.title }}
        </h1>
        <ul class="flex flex-wrap gap-2" aria-label="Tecnologías utilizadas">
          <li
            v-for="tech in store.project.technologies"
            :key="tech"
            class="font-sans text-xs bg-slate-100 text-slate-600 px-3 py-1 rounded-sm font-semibold"
          >
            {{ tech }}
          </li>
        </ul>
      </header>

      <!-- Galería de capturas -->
      <div v-if="hasGallery" class="mb-12">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div
            v-for="img in store.project.images"
            :key="img.id"
            class="rounded-lg overflow-hidden border border-stone-200"
          >
            <img
              :src="storageUrl(img.path)"
              :alt="`Captura de ${store.project.title}`"
              class="w-full object-cover"
            />
          </div>
        </div>
      </div>

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

      <section class="grid md:grid-cols-3 gap-12 md:gap-16">
        <div>
          <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-4">
            Descripción
          </p>
          <div class="w-10 h-0.5 bg-slate-300"></div>
        </div>
        <div class="md:col-span-2">
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
            class="font-sans text-xs tracking-widest uppercase text-slate-500 border-b-2 border-slate-300 pb-0.5 hover:text-slate-800 hover:border-slate-600 transition-colors"
            :aria-label="`Ver proyecto ${store.project.title}`"
          >
            Ver proyecto →
          </a>
        </div>
      </section>
    </template>
  </div>
</template>
