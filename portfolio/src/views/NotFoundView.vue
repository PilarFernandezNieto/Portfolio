<script setup>
import { RouterLink } from 'vue-router'
</script>

<template>
  <div
    class="max-w-5xl mx-auto px-6 py-24 flex flex-col items-center justify-center text-center min-h-96"
  >
    <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-6">404</p>
    <h1 class="font-serif text-5xl text-slate-800 font-normal mb-6">Página no encontrada</h1>
    <p class="font-sans text-base text-slate-500 leading-relaxed mb-10 max-w-md">
      La página que buscas no existe o ha sido movida.
    </p>
    <RouterLink
      to="/"
      class="font-sans text-xs tracking-widest uppercase text-slate-500 border-b-2 border-slate-300 pb-0.5 hover:text-slate-800 hover:border-slate-600 transition-colors"
    >
      ← Volver al inicio
    </RouterLink>
  </div>
</template>
