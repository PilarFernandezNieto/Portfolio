<script setup>
import { ref } from 'vue'
import api from '@/services/api'
import FormLabel from '@/components/FormLabel.vue'
import ButtonDark from '@/components/ButtonDark.vue'

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
  <div
    class="max-w-5xl mx-auto px-6 py-16 md:py-24 grid md:grid-cols-[3fr_2fr] gap-12 lg:gap-16 items-start"
  >
    <div class="min-w-0">
      <p class="font-sans text-[13px] font-bold tracking-widest uppercase text-muted mb-4.5">
        Contacto
      </p>
      <h1 class="heading heading-1 mb-6 wrap-break-word">Gracias por visitar mi portfolio.</h1>
      <p class="font-sans text-[17px] leading-relaxed text-ink/85 max-w-md mb-10">
        Si has llegado hasta aquí y crees que mi perfil puede encajar en tu equipo, puedes contactar
        conmigo a través del correo electrónico, LinkedIn o mediante el siguiente formulario.
      </p>
      <div class="flex flex-col gap-4.5">
        <a
          href="mailto:pilarfnieto@gmail.com"
          class="text-ink font-sans text-[15px] font-semibold focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
        >
          pilarfnieto@gmail.com
        </a>
        <div>
          <a
            href="https://www.linkedin.com/in/pilar-fernandez-nieto-03639224b/"
            target="_blank"
            rel="noopener noreferrer"
            class="group"
          >
            <svg
              class="h-8 w-8 transition-transform duration-200 group-hover:scale-110"
              viewBox="0 0 24 24"
              fill="currentColor"
              xmlns="http://www.w3.org/2000/svg"
              aria-hidden="true"
            >
              <path
                d="M6.5 8C7.32843 8 8 7.32843 8 6.5C8 5.67157 7.32843 5 6.5 5C5.67157 5 5 5.67157 5 6.5C5 7.32843 5.67157 8 6.5 8Z"
              />
              <path
                d="M5 10C5 9.44772 5.44772 9 6 9H7C7.55228 9 8 9.44771 8 10V18C8 18.5523 7.55228 19 7 19H6C5.44772 19 5 18.5523 5 18V10Z"
              />
              <path
                d="M11 19H12C12.5523 19 13 18.5523 13 18V13.5C13 12 16 11 16 13V18.0004C16 18.5527 16.4477 19 17 19H18C18.5523 19 19 18.5523 19 18V12C19 10 17.5 9 15.5 9C13.5 9 13 10.5 13 10.5V10C13 9.44771 12.5523 9 12 9H11C10.4477 9 10 9.44772 10 10V18C10 18.5523 10.4477 19 11 19Z"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M20 1C21.6569 1 23 2.34315 23 4V20C23 21.6569 21.6569 23 20 23H4C2.34315 23 1 21.6569 1 20V4C1 2.34315 2.34315 1 4 1H20ZM20 3C20.5523 3 21 3.44772 21 4V20C21 20.5523 20.5523 21 20 21H4C3.44772 21 3 20.5523 3 20V4C3 3.44772 3.44772 3 4 3H20Z"
              />
            </svg>
          </a>
        </div>
      </div>
    </div>

    <div class="max-w-130 min-w-0">
      <div
        v-if="success"
        role="status"
        class="border border-ink px-8 py-8 font-sans text-base leading-relaxed text-ink"
      >
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
            placeholder="Nombre"
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
            placeholder="correo@ejemplo.com"
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
            placeholder="Cuéntame el motivo de tu contacto"
            class="w-full border-0 border-b border-ink bg-transparent font-sans text-base text-ink py-2.5 outline-none resize-y placeholder:text-ink/40 focus:border-b-2"
          />
        </div>

        <div v-if="error" role="alert" class="font-sans text-sm text-red-500 mb-6">
          {{ error }}
        </div>

        <ButtonDark type="submit" :disabled="loading" size="lg" class="w-full">
          {{ loading ? 'Enviando…' : 'Enviar mensaje' }}
        </ButtonDark>
      </form>
    </div>
  </div>
</template>
