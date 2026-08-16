<script setup>
import ButtonLight from '@/components/ButtonLight.vue'

const focusAreas = [
  'Desarrollo full-stack con Laravel + Vue.js',
  'Interfaces accesibles y cuidadas',
  'Aprendizaje constante, del backend al frontend',
]
</script>

<template>
  <section
    class="min-h-[70vh] md:min-h-[calc(100vh-61px)] bg-ink px-6 md:px-16 py-10 md:py-12 flex flex-wrap gap-8 items-center"
    aria-labelledby="hero-heading"
  >
    <div class="flex-[3_1_500px]">
      <p class="font-sans text-xs font-bold tracking-[0.2em] uppercase text-subtle mb-3.5">
        Portfolio — Full-Stack Dev
      </p>
      <h1 id="hero-heading" class="heading heading-1 mb-4.5 text-cream tracking-tight">
        La tecnología funciona mejor cuando está pensada para las personas.
      </h1>
      <p class="font-sans text-[15px] leading-normal text-cream/90 max-w-120 mb-5.5">
        Después de años trabajando de cara al público, me formé como desarrolladora web para
        construir aplicaciones útiles, intuitivas y fáciles de mantener.
      </p>
      <p class="font-sans text-[15px] leading-normal text-cream/90 max-w-120 mb-5.5">
        Mi objetivo es crear productos funcionales, escalables y fáciles de utilizar.
      </p>
      <div class="flex flex-wrap gap-3.5 justify-center md:justify-start">
        <ButtonLight to="/proyectos">Ver proyectos</ButtonLight>
        <ButtonLight href="/CV_PilarFernandezNieto.pdf" download variant="outline">
          Descargar CV
        </ButtonLight>
      </div>
    </div>
    <div
      class="flex flex-col gap-4 border-l border-cream/30 pl-7 flex-[1_1_220px]"
      aria-label="Áreas de foco"
    >
      <div
        v-for="area in focusAreas"
        :key="area"
        class="font-sans text-sm leading-normal text-cream"
      >
        {{ area }}
      </div>
    </div>
  </section>
</template>
