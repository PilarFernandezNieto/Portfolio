<script setup></script>

<template>
  <section
    class="max-w-5xl mx-auto px-6 py-24 md:py-32 grid md:grid-cols-2 gap-12 md:gap-16 items-end border-b border-stone-200"
    aria-labelledby="hero-heading"
  >
    <div>
      <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-6">
        Desarrolladora Full-Stack · Gijón
      </p>
      <h1
        id="hero-heading"
        class="font-serif text-5xl md:text-6xl leading-tight text-slate-800 font-normal"
      >
        Código que<br />
        funciona para<br />
        <em class="text-slate-400 not-italic">quien lo usa.</em>
      </h1>
    </div>

    <div>
      <p class="font-sans text-base text-slate-500 leading-relaxed mb-8">
        Llegué a la programación después de años trabajando de cara al público. Me importa que las
        cosas funcionen bien para quien las usa, no solo para quien las escribe.
      </p>
      <RouterLink
        to="/proyectos"
        class="font-sans text-xs tracking-widest uppercase text-slate-500 border-b-2 border-slate-300 pb-0.5 hover:text-slate-800 hover:border-slate-600 transition-colors"
      >
        Ver proyectos →
      </RouterLink>
    </div>
  </section>
</template>
