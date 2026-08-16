<script setup>
import { ref } from 'vue'
import api from '@/services/api'
import FormLabel from '@/components/FormLabel.vue'

const form = ref({ name: '', email: '', message: '' })
const loading = ref(false)
const success = ref(false)
const error = ref(null)

async function handleSubmit() {
  loading.value = true
  error.value = null
  try {
    await api.post('/contact', form.value)
    success.value = true
    form.value = { name: '', email: '', message: '' }
  } catch (e) {
    error.value = e.response?.data?.message || 'Ha ocurrido un error. Inténtalo de nuevo.'
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="max-w-5xl mx-auto px-6 py-16 md:py-24 grid md:grid-cols-[3fr_2fr] gap-12 lg:gap-16 items-start">
    <div class="min-w-0">
      <p class="font-sans text-[13px] font-bold tracking-widest uppercase text-muted mb-4.5">
        Contacto
      </p>
      <h1 class="heading heading-1 mb-6 wrap-break-word">
        ¿Construyamos algo juntos?
      </h1>
      <p class="font-sans text-[17px] leading-relaxed text-ink/85 max-w-md mb-10">
        Cuéntame en qué estás trabajando. Respondo en un plazo de 24-48 horas.
      </p>
      <div class="flex flex-col gap-4.5">
        <a
          href="mailto:pilarfnieto@gmail.com"
          class="text-ink font-sans text-[15px] font-semibold focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
        >
          pilarfnieto@gmail.com
        </a>
        <div class="flex gap-6">
          <a
            href="#"
            class="text-ink font-sans text-[13px] font-bold tracking-wider uppercase focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
          >
            GitHub
          </a>
          <a
            href="#"
            class="text-ink font-sans text-[13px] font-bold tracking-wider uppercase focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
          >
            LinkedIn
          </a>
        </div>
      </div>
    </div>

    <div class="max-w-130 min-w-0">
      <div v-if="success" role="status" class="border border-ink px-8 py-8 font-sans text-base leading-relaxed text-ink">
        Gracias por tu mensaje. Te responderé lo antes posible.
      </div>

      <form v-else @submit.prevent="handleSubmit" aria-label="Formulario de contacto" novalidate>
        <div class="mb-6.5">
          <FormLabel for="name">Nombre</FormLabel>
          <input
            id="name"
            v-model="form.name"
            type="text"
            required
            autocomplete="name"
            placeholder="Tu nombre"
            class="w-full border-0 border-b border-ink bg-transparent font-sans text-base text-ink py-2.5 outline-none placeholder:text-ink/40 focus:border-b-2"
          />
        </div>

        <div class="mb-6.5">
          <FormLabel for="email">Email</FormLabel>
          <input
            id="email"
            v-model="form.email"
            type="email"
            required
            autocomplete="email"
            placeholder="tu@email.com"
            class="w-full border-0 border-b border-ink bg-transparent font-sans text-base text-ink py-2.5 outline-none placeholder:text-ink/40 focus:border-b-2"
          />
        </div>

        <div class="mb-9">
          <FormLabel for="message">Mensaje</FormLabel>
          <textarea
            id="message"
            v-model="form.message"
            rows="5"
            required
            placeholder="Cuéntame los detalles de tu proyecto"
            class="w-full border-0 border-b border-ink bg-transparent font-sans text-base text-ink py-2.5 outline-none resize-y placeholder:text-ink/40 focus:border-b-2"
          />
        </div>

        <div v-if="error" role="alert" class="font-sans text-sm text-red-500 mb-6">
          {{ error }}
        </div>

        <button
          type="submit"
          :disabled="loading"
          class="w-full bg-ink border border-ink text-cream py-4 font-sans font-bold text-sm uppercase tracking-widest disabled:opacity-50 disabled:cursor-not-allowed focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
        >
          {{ loading ? 'Enviando…' : 'Enviar mensaje' }}
        </button>
      </form>
    </div>
  </div>
</template>
