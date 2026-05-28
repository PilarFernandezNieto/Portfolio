<script setup>
import { computed, onMounted } from 'vue'
import { useAboutStore } from '@/stores/about'
import AppSpinner from '@/components/AppSpinner.vue'
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
      <section
        class="grid md:grid-cols-3 gap-12 md:gap-16 border-b border-stone-200 pb-16 mb-16"
        aria-labelledby="about-heading"
      >
        <div>
          <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-4">
            Sobre mí
          </p>
          <div class="w-10 h-0.5 bg-slate-300"></div>
        </div>
        <div class="md:col-span-2">
          <div class="rich-text font-serif text-2xl text-slate-800 leading-relaxed" v-html="sanitizedBio" />
        </div>
      </section>
      <section class="grid md:grid-cols-3 gap-12 md:gap-16" aria-labelledby="details-heading">
        <div>
          <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-4">
            Detalles
          </p>
          <div class="w-10 h-0.5 bg-slate-300"></div>
        </div>
        <dl class="md:col-span-2 flex flex-col gap-4">
          <div
            v-for="detail in aboutStore.about.details"
            :key="detail.label"
            class="flex justify-between items-baseline border-b border-stone-200 pb-4 last:border-0 last:pb-0"
          >
            <dt class="font-sans text-xs tracking-widest uppercase text-slate-400">
              {{ detail.label }}
            </dt>
            <dd class="font-sans text-sm text-slate-700">
              {{ detail.value }}
            </dd>
          </div>
        </dl>
      </section>
    </template>
    <div v-else class="flex justify-center py-24">
      <p class="font-sans text-sm text-slate-400">No hay información disponible.</p>
    </div>
  </div>
</template>
