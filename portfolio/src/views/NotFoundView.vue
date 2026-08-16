<script setup>
import { RouterLink } from 'vue-router'
</script>

<template>
  <div
    class="max-w-5xl mx-auto px-6 py-24 flex flex-col items-center justify-center text-center min-h-[60vh]"
  >
    <div class="font-serif font-bold text-[clamp(80px,16vw,160px)] leading-[0.9] mb-5 text-ink">
      404
    </div>
    <h1
      class="heading heading-2 leading-[1.1] mb-4.5"
    >
      Página no encontrada
    </h1>
    <p class="font-sans text-base leading-relaxed text-ink/80 mb-8 max-w-md">
      La página que buscas no existe o se ha movido.
    </p>
    <RouterLink
      to="/"
      class="text-ink font-sans text-[13px] font-bold tracking-widest uppercase border border-ink px-7 py-3.5 focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
    >
      Volver al inicio
    </RouterLink>
  </div>
</template>
