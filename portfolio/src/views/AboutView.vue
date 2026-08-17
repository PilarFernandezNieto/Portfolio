<script setup>
import { computed, onMounted } from 'vue'
import { useAboutStore } from '@/stores/about'
import AppSpinner from '@/components/AppSpinner.vue'
import ButtonDark from '@/components/ButtonDark.vue'
import DOMPurify from 'dompurify'

const aboutStore = useAboutStore()

const imageUrl = computed(() =>
  aboutStore.about.image ? `${import.meta.env.VITE_STORAGE_URL}/${aboutStore.about.image}` : null,
)

const sanitizedBio = computed(() =>
  aboutStore.about ? DOMPurify.sanitize(aboutStore.about.bio) : '',
)

onMounted(() => {
  aboutStore.fetchAbout()
})
</script>

<template>
  <div class="max-w-5xl mx-auto px-6 py-16 md:py-24">
    <AppSpinner v-if="aboutStore.loading" />
    <div v-else-if="aboutStore.error" class="flex justify-center py-24">
      <p class="font-sans text-sm text-red-400">{{ aboutStore.error }}</p>
    </div>
    <template v-else-if="aboutStore.about">
      <section
        class="flex flex-wrap gap-12 items-center pb-16 mb-16 border-b border-ink"
        aria-labelledby="about-heading"
      >
        <div
          role="img"
          aria-label="Marcador de foto de retrato"
          class="flex-[1_1_260px] max-w-80 aspect-3/4 flex items-center justify-center bg-border-soft"
        >
          <img v-if="imageUrl" :src="imageUrl" alt="" class="w-full h-full object-cover" />
        </div>

        <div class="flex-[2_1_420px]">
          <p class="font-sans text-[13px] font-bold tracking-[0.2em] uppercase text-muted mb-4.5">
            Sobre mí
          </p>
          <h1 id="about-heading" class="heading heading-1 mb-5.5">
            Full-stack, de la base de datos a la última interacción
          </h1>
          <div
            class="rich-text font-sans text-[17px] leading-relaxed text-ink/85 max-w-145 mb-7"
            v-html="sanitizedBio"
          />
          <ButtonDark href="/CV_PilarFernandezNieto.pdf" download variant="outline">
            Descargar CV
          </ButtonDark>
        </div>
      </section>

      <section aria-labelledby="details-heading">
        <h2 id="details-heading" class="heading heading-2 mb-8">Detalles</h2>
        <dl class="grid sm:grid-cols-2 gap-4">
          <div
            v-for="detail in aboutStore.about.details"
            :key="detail.label"
            class="border border-ink px-5 py-4"
          >
            <dt class="font-sans text-xs font-bold tracking-[0.14em] uppercase text-muted mb-1">
              {{ detail.label }}
            </dt>
            <dd class="font-sans text-sm text-ink font-medium">
              {{ detail.value }}
            </dd>
          </div>
        </dl>
      </section>
    </template>
    <div v-else class="flex justify-center py-24">
      <p class="font-sans text-sm text-slate-500">No hay información disponible.</p>
    </div>
  </div>
</template>
