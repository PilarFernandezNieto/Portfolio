<script setup>
import ButtonDark from '@/components/ButtonDark.vue'
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
    <ButtonDark to="/" variant="outline" size="lg">Volver al inicio</ButtonDark>
  </div>
</template>
