<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useProjectsStore } from '@/stores/projects'
import AppSpinner from '@/components/AppSpinner.vue'
import Galleria from 'primevue/galleria'
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

const galleriaVisible = ref(false)
const galleriaIndex = ref(0)

function openGalleria(index) {
  galleriaIndex.value = index
  galleriaVisible.value = true
}

const galleriaPt = {
  mask: { class: 'bg-ink/[.92]' },
  closeButton:
    'border border-cream/40 rounded-full text-cream hover:bg-cream/10 focus-visible:outline-2 focus-visible:outline-cream focus-visible:outline-offset-2',
  prevButton:
    'border border-cream/40 rounded-full text-cream hover:bg-cream/10 focus-visible:outline-2 focus-visible:outline-cream focus-visible:outline-offset-2',
  nextButton:
    'border border-cream/40 rounded-full text-cream hover:bg-cream/10 focus-visible:outline-2 focus-visible:outline-cream focus-visible:outline-offset-2',
  thumbnails: { class: 'bg-ink border-t border-cream/20' },
  thumbnail: 'opacity-60 hover:opacity-100 data-[p-active=true]:opacity-100',
}
</script>

<template>
  <div class="max-w-5xl mx-auto px-6">
    <AppSpinner v-if="store.loading" />

    <div v-else-if="store.error" class="flex justify-center py-24">
      <p class="font-sans text-sm text-red-400">{{ store.error }}</p>
    </div>

    <template v-else-if="store.project">
      <header class="pt-16 md:pt-24 pb-8 md:pb-12 border-b border-ink">
        <div class="flex flex-wrap gap-8 justify-between items-end">
          <div class="flex-[2_1_480px]">
            <RouterLink
              :to="{ name: 'projects' }"
              class="font-sans text-xs font-bold tracking-widest uppercase text-muted mb-4 inline-block hover:text-ink transition-colors"
            >
              ← Proyectos
            </RouterLink>
            <h1
              class="heading heading-1 mb-5"
            >
              {{ store.project.title }}
            </h1>
            <p v-if="store.project.intro" class="font-sans text-[17px] leading-relaxed text-ink/85 max-w-2xl">
              {{ store.project.intro }}
            </p>
          </div>
          <div class="flex-[1_1_220px] flex flex-col gap-5">
            <div v-if="store.project.technologies?.length">
              <div class="font-sans text-xs font-bold tracking-widest uppercase text-muted mb-2.5">
                Tecnologías
              </div>
              <ul class="flex flex-wrap gap-2" aria-label="Tecnologías utilizadas">
                <li
                  v-for="tech in store.project.technologies"
                  :key="tech"
                  class="font-sans text-[11px] font-semibold tracking-wider uppercase bg-tag text-cream px-2.5 py-1"
                >
                  {{ tech }}
                </li>
              </ul>
            </div>
            <a
              v-if="store.project.url"
              :href="store.project.url"
              target="_blank"
              rel="noopener noreferrer"
              class="w-fit text-ink font-sans text-[13px] font-bold tracking-widest uppercase border border-ink px-6 py-3 focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
              :aria-label="`Ver proyecto ${store.project.title}`"
            >
              Ver sitio
            </a>
          </div>
        </div>
      </header>

      <!-- Galería de capturas -->
      <template v-if="hasGallery">
        <div class="py-16 md:py-24" aria-label="Galería de capturas del proyecto">
          <div class="columns-1 sm:columns-2 md:columns-3 gap-6">
            <button
              v-for="(img, index) in store.project.images"
              :key="img.id"
              type="button"
              @click="openGalleria(index)"
              class="group block w-full break-inside-avoid mb-6 p-0 border-none cursor-zoom-in bg-transparent focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
              :aria-label="`Ampliar captura ${index + 1} de ${store.project.images.length}`"
            >
              <img
                :src="storageUrl(img.path)"
                :alt="`Captura ${index + 1} de ${store.project.title}`"
                class="w-full h-auto border border-ink object-cover transition-opacity group-hover:opacity-80"
                loading="lazy"
              />
            </button>
          </div>
        </div>

        <Galleria
          v-model:visible="galleriaVisible"
          v-model:activeIndex="galleriaIndex"
          :value="store.project.images"
          :numVisible="5"
          :fullScreen="true"
          :showItemNavigators="true"
          :circular="true"
          :pt="galleriaPt"
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
      <div v-else-if="store.project.image" class="py-16 md:py-24">
        <img
          :src="storageUrl(store.project.image)"
          :alt="`Captura de ${store.project.title}`"
          class="w-full border border-ink object-cover"
        />
      </div>

      <section class="pb-16 md:pb-24">
        <h2 class="heading heading-2 mb-6">Descripción</h2>
        <div
          class="rich-text font-sans text-base text-ink/85 leading-relaxed max-w-2xl"
          v-html="sanitizedDescription"
        />
      </section>
    </template>
  </div>
</template>
