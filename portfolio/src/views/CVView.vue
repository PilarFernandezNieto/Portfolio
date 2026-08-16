<script setup>
import ButtonDark from '@/components/ButtonDark.vue'

const experience = [
  {
    period: 'Ene 2024 — Actualidad',
    role: 'Desarrolladora Web Full-Stack',
    company: 'Ticmedia Soluciones Profesionales · Gijón',
    description:
      'Desarrollo y mantenimiento de aplicaciones web con framework y CMS propios de la empresa en PHP (HTML, CSS, Twig, Bootstrap, JavaScript, jQuery).\nGestión de tiendas Prestashop y plataformas de formación Moodle.\nAPIs REST consumidas por interfaces en Vue.js 3 con Pinia y Vue Router.\nSoporte técnico y formación presencial a clientes en Restaurantic, gestión de reservas para hostelería.',
  },
  {
    period: 'Sep — Dic 2023',
    role: 'Prácticas FCT — Desarrollo de Aplicaciones Web',
    company: 'Ticmedia Soluciones Profesionales',
    description:
      'Herramienta de migración de datos entre estructuras distintas (JSON → MySQL).\nPrimera experiencia con Git y trabajo en equipo profesional.',
  },
  {
    period: '2007 — 2023',
    role: 'Instructora de Fitness · Promotora de Ventas',
    company: 'Real Grupo Covadonga · El Corte Inglés',
    description:
      'Más de 15 años en atención al público, coordinación de grupos y trabajo bajo presión.',
  },
]

const education = [
  {
    period: '2021 — 2023',
    title: 'CFGS Desarrollo de Aplicaciones Web',
    place: 'CIFP La Laboral · Gijón',
    description: 'Formación de grado superior en desarrollo de aplicaciones web.',
  },
  {
    period: '2022 — hoy',
    title: 'Formación complementaria autónoma',
    place: '',
    description: 'Laravel · Vue.js · PHP avanzado · Tailwind 3/4 · DOM · MySQL',
  },
]

const stack = [
  { label: 'Backend', items: ['PHP', 'Laravel', 'APIs REST', 'MySQL', 'Twig / Smarty'] },
  {
    label: 'Frontend',
    items: ['Vue.js 3', 'Pinia', 'Vue Router', 'Axios', 'Bootstrap', 'JavaScript', 'jQuery'],
  },
  {
    label: 'Herramientas',
    items: ['Git', 'Postman', 'Moodle', 'Prestashop', 'Tailwind CSS', 'Blade / Livewire'],
  },
]

const languages = [
  { name: 'Español', level: 'Nativo' },
  { name: 'Inglés', level: 'B2 (en progreso)' },
]

const personalProjects = [
  'Aplicaciones con Laravel 11: full-stack con Blade + Livewire, y API desacoplada con Vue.js + Pinia.',
  'Exploración del stack MEVN (MongoDB, Express, Vue, Node) para ampliar conocimientos de backend.',
  'Implementación de estándares de accesibilidad web: ARIA, semántica HTML, navegación por teclado y contraste de color.',
]

const softSkills = [
  'Trabajo en equipo',
  'Orientación al cliente',
  'Aprendizaje autónomo',
  'Resolución de problemas',
  'Adaptación al cambio',
]
</script>

<template>
  <div class="max-w-5xl mx-auto px-6">
    <header
      class="pt-16 md:pt-24 pb-10 md:pb-14 border-b border-ink flex flex-wrap gap-8 justify-between items-end"
    >
      <div class="flex-[2_1_420px]">
        <p class="font-sans text-[13px] font-bold tracking-widest uppercase text-muted mb-4.5">
          Desarrolladora Full-Stack
        </p>
        <h1 class="heading heading-1 mb-5.5">Pilar Fernández Nieto</h1>
        <p class="font-sans text-[17px] leading-relaxed text-ink/85 max-w-2xl mb-4.5">
          Desarrolladora full-stack con más de dos años de experiencia profesional en empresa de
          desarrollo de software. Combino desarrollo técnico con formación a clientes y soporte en
          producción — el ciclo completo, desde la API hasta el usuario final. Integro herramientas
          de IA como Claude en mi flujo de trabajo como apoyo al aprendizaje y la toma de decisiones
          técnicas.
        </p>
        <p class="font-sans text-[17px] leading-relaxed text-ink/85 max-w-2xl">
          De manera autónoma desarrollo con Laravel + Vue.js, tanto en arquitectura monolítica como
          en API desacoplada. Presto especial atención a la accesibilidad web y la experiencia de
          usuario en todo lo que construyo.
        </p>
      </div>
      <div class="flex-[1_1_220px] flex flex-col gap-3 items-start">
        <ButtonDark href="/CV_PilarFernandezNieto.pdf" download variant="outline" size="lg">
          Descargar CV
        </ButtonDark>
        <div class="font-sans text-sm leading-relaxed text-ink/80">
          <div>pilarfnieto@gmail.com</div>
          <div>+34 626 34 01 44</div>
          <div>Gijón, Asturias</div>
          <div>
            <a href="https://pilarfdez.es" class="text-ink hover:opacity-70 transition-opacity"
              >pilarfdez.es</a
            >
          </div>
        </div>
      </div>
    </header>

    <section class="py-16 md:py-24" aria-labelledby="experiencia-heading">
      <h2 id="experiencia-heading" class="heading heading-2 mb-10">Experiencia profesional</h2>
      <div class="flex flex-col">
        <div
          v-for="job in experience"
          :key="job.role"
          class="flex flex-wrap gap-6 justify-between py-6.5 border-t border-ink"
        >
          <div
            class="flex-[0_0_140px] font-sans text-[13px] font-bold tracking-wider uppercase text-muted"
          >
            {{ job.period }}
          </div>
          <div class="flex-[1_1_320px]">
            <h3 class="font-serif text-xl mb-1.5 text-ink uppercase">{{ job.role }}</h3>
            <p class="font-sans text-sm leading-relaxed text-ink/80 max-w-xl whitespace-pre-line">
              {{ job.description }}
            </p>
          </div>
          <div class="flex-[0_0_180px] font-sans text-sm font-semibold text-right text-ink/75">
            {{ job.company }}
          </div>
        </div>
      </div>
    </section>

    <section class="pb-16 md:pb-24" aria-labelledby="formacion-heading">
      <h2 id="formacion-heading" class="heading heading-2 mb-10">Formación</h2>
      <div class="flex flex-col">
        <div
          v-for="ed in education"
          :key="ed.title"
          class="flex flex-wrap gap-6 justify-between py-6.5 border-t border-ink"
        >
          <div
            class="flex-[0_0_140px] font-sans text-[13px] font-bold tracking-wider uppercase text-muted"
          >
            {{ ed.period }}
          </div>
          <div class="flex-[1_1_320px]">
            <h3 class="font-serif text-lg mb-1.5 text-ink uppercase">{{ ed.title }}</h3>
            <p class="font-sans text-sm leading-relaxed text-ink/80 max-w-xl">
              {{ ed.description }}
            </p>
          </div>
          <div class="flex-[0_0_180px] font-sans text-sm font-semibold text-right text-ink/75">
            {{ ed.place }}
          </div>
        </div>
      </div>
    </section>

    <section class="pb-16 md:pb-24 flex flex-wrap gap-16">
      <div class="flex-[2_1_380px]">
        <h2 class="heading heading-2 mb-7">Stack técnico</h2>
        <div class="flex flex-col gap-5.5">
          <div v-for="group in stack" :key="group.label">
            <div class="font-sans text-xs font-bold tracking-wider uppercase text-muted mb-2.5">
              {{ group.label }}
            </div>
            <div class="flex flex-wrap gap-2">
              <span
                v-for="item in group.items"
                :key="item"
                class="font-sans text-[11px] font-semibold tracking-wider uppercase bg-tag text-cream px-2.5 py-1.5"
              >
                {{ item }}
              </span>
            </div>
          </div>
        </div>
      </div>
      <div class="flex-[1_1_220px]">
        <h2 class="heading heading-2 mb-7">Idiomas</h2>
        <div class="flex flex-col gap-2.5 text-[15px]">
          <div
            v-for="lang in languages"
            :key="lang.name"
            class="flex justify-between border-t border-ink py-3"
          >
            <span class="font-sans font-semibold text-ink">{{ lang.name }}</span>
            <span class="font-sans text-ink/75">{{ lang.level }}</span>
          </div>
        </div>
      </div>
    </section>

    <section class="pb-16 md:pb-24" aria-labelledby="proyectos-heading">
      <h2 id="proyectos-heading" class="heading heading-2 mb-7">Proyectos personales</h2>
      <ul class="list-none flex flex-col gap-4 max-w-2xl">
        <li
          v-for="project in personalProjects"
          :key="project"
          class="font-sans text-base leading-relaxed text-ink/85 pl-5 border-l-2 border-ink"
        >
          {{ project }}
        </li>
      </ul>
    </section>

    <section class="pb-16 md:pb-24" aria-labelledby="habilidades-heading">
      <h2 id="habilidades-heading" class="heading heading-2 mb-7">Habilidades personales</h2>
      <div class="flex flex-wrap gap-2">
        <span
          v-for="skill in softSkills"
          :key="skill"
          class="font-sans text-[13px] font-semibold border border-ink px-4.5 py-2.5"
        >
          {{ skill }}
        </span>
      </div>
    </section>
  </div>
</template>
