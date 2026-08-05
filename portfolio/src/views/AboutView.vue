<script setup>
import { computed, onMounted } from 'vue'
import { useAboutStore } from '@/stores/about'
import AppSpinner from '@/components/AppSpinner.vue'
import SectionTag from '@/components/SectionTag.vue'
import BackgroundBlob from '@/components/BackgroundBlob.vue'
import DOMPurify from 'dompurify'

const aboutStore = useAboutStore()

const sanitizedBio = computed(() =>
  aboutStore.about ? DOMPurify.sanitize(aboutStore.about.bio) : '',
)

onMounted(() => {
  aboutStore.fetchAbout()
})
</script>

<template>
  <div class="max-w-5xl mx-auto px-6 py-24">
    <AppSpinner v-if="aboutStore.loading" />
    <div v-else-if="aboutStore.error" class="flex justify-center py-23">
      <p class="font-sans text-sm text-red-400">{{ aboutStore.error }}</p>
    </div>
    <template v-else-if="aboutStore.about">
      <section class="relative mb-20" aria-labelledby="about-heading">
        <BackgroundBlob color="#F7DB88" size="300px" top="-4rem" right="-8rem" :opacity="0.35" />
        <SectionTag label="Sobre mí" class="mb-6" />
        <div
          class="rich-text font-serif text-2xl md:text-3xl text-slate-800 leading-relaxed bg-blush/40 border border-blush rounded-2xl px-8 py-10 md:px-12 md:py-12"
          v-html="sanitizedBio"
        />
      </section>

      <section aria-labelledby="details-heading">
        <SectionTag label="Detalles" color="periwinkle" class="mb-6" />
        <dl class="grid sm:grid-cols-2 gap-4">
          <div
            v-for="detail in aboutStore.about.details"
            :key="detail.label"
            class="border border-stone-200 rounded-lg px-5 py-4 bg-white"
          >
            <dt class="font-sans text-xs tracking-widest uppercase text-slate-500 mb-1">
              {{ detail.label }}
            </dt>
            <dd class="font-sans text-sm text-slate-800 font-medium">
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
