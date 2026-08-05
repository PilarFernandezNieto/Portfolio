<script setup>
import CVDocument from '@/components/CVDocument.vue'
import SectionTag from '@/components/SectionTag.vue'
</script>

<template>
  <div class="max-w-5xl mx-auto px-6 py-24">
    <header class="pb-12 mb-12">
      <SectionTag label="CV" class="mb-4" />
      <h1 class="font-serif text-4xl text-slate-800 font-normal mb-8">Currículum Vitae</h1>
      <a
        href="/CV_PilarFernandezNieto.pdf"
        download
        class="inline-flex items-center gap-2 font-sans text-xs tracking-widest uppercase text-slate-600 border-b-2 border-marigold pb-0.5 hover:text-slate-800 transition-colors"
        aria-label="Descargar CV en PDF"
      >
        <span>↓</span> Descargar CV en PDF
      </a>
    </header>

    <CVDocument />
  </div>
</template>
