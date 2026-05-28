<script setup></script>

<template>
  <div class="max-w-5xl mx-auto px-6 py-24">
    <header class="border-b border-stone-200 pb-12 mb-12">
      <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-4">
        CV
      </p>
      <h1 class="font-serif text-4xl text-slate-800 font-normal mb-8">Currículum Vitae</h1>
      <a
        href="/cv.pdf"
        download
        class="inline-flex items-center gap-2 font-sans text-xs tracking-widest uppercase text-slate-500 border-b-2 border-slate-300 pb-0.5 hover:text-slate-800 hover:border-slate-600 transition-colors"
        aria-label="Descargar CV en PDF"
      >
        <span>↓</span> Descargar CV en PDF
      </a>
    </header>

    <div class="flex justify-center">
      <iframe
        src="/cv.pdf"
        class="w-full border border-stone-200 rounded-lg"
        style="height: 80vh"
        title="Currículum Vitae de Pilar Fernández Nieto"
        aria-label="Visualización del CV en PDF"
      />
    </div>
  </div>
</template>
