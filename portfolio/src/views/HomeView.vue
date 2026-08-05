<script setup>
import HeroIllustration from '@/components/HeroIllustration.vue'
import BackgroundBlob from '@/components/BackgroundBlob.vue'
</script>

<template>
  <section
    class="relative overflow-hidden max-w-5xl mx-auto px-6 py-24 md:py-32 grid md:grid-cols-2 gap-12 md:gap-16 items-center border-b border-stone-200"
    aria-labelledby="hero-heading"
  >
    <BackgroundBlob color="#FBDDD5" size="380px" top="-8rem" left="-10rem" :opacity="0.6" />
    <BackgroundBlob color="#84A4F1" size="280px" bottom="-6rem" right="-6rem" :opacity="0.25" />

    <div>
      <p class="font-sans text-xs tracking-widest uppercase text-marigold font-semibold mb-6">
        Desarrolladora Full-Stack · Gijón
      </p>
      <h1
        id="hero-heading"
        class="font-serif text-5xl md:text-6xl leading-tight text-slate-800 font-normal mb-8"
      >
        Código que<br />
        funciona para<br />
        <em class="text-marigold not-italic">quien lo usa.</em>
      </h1>
      <p class="font-sans text-base text-slate-600 leading-relaxed mb-8">
        Llegué a la programación después de años trabajando de cara al público. Me importa que las
        cosas funcionen bien para quien las usa, no solo para quien las escribe.
      </p>
      <RouterLink
        to="/proyectos"
        class="font-sans text-xs tracking-widest uppercase text-slate-600 border-b-2 border-marigold pb-0.5 hover:text-slate-800 transition-colors"
      >
        Ver proyectos →
      </RouterLink>
    </div>

    <HeroIllustration />
  </section>
</template>
