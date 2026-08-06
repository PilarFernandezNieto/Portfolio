<script setup>
import { ref } from 'vue'
import api from '@/services/api'
import SectionTag from '@/components/SectionTag.vue'
import BackgroundBlob from '@/components/BackgroundBlob.vue'
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
  <div class="relative overflow-hidden max-w-5xl mx-auto px-6 py-24 grid md:grid-cols-2 gap-12 md:gap-16 items-start">
    <BackgroundBlob color="#F7DB88" size="300px" top="-6rem" left="-8rem" :opacity="0.4" />

    <header>
      <SectionTag label="Contacto" class="mb-4" />
      <h1 class="font-serif text-4xl text-slate-800 font-normal mb-6">Hablemos</h1>
      <p class="font-sans text-base text-slate-600 leading-relaxed">
        ¿Tienes un proyecto en mente o quieres charlar sobre alguna colaboración? Cuéntame en qué
        andas y te responderé lo antes posible.
      </p>
    </header>

    <div class="bg-white border border-stone-200 rounded-2xl shadow-sm p-8">
      <div
        v-if="success"
        role="status"
        class="font-sans text-sm text-green-700 bg-green-50 border border-green-200 rounded px-5 py-4"
      >
        Mensaje enviado. Me pondré en contacto contigo pronto.
      </div>

      <form v-if="!success" @submit.prevent="handleSubmit" class="flex flex-col gap-6" novalidate>
        <div class="flex flex-col gap-2">
          <FormLabel for="name">Nombre</FormLabel>
          <input
            id="name"
            v-model="form.name"
            type="text"
            required
            autocomplete="name"
            class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-periwinkle transition-colors"
          />
        </div>

        <div class="flex flex-col gap-2">
          <FormLabel for="email">Email</FormLabel>
          <input
            id="email"
            v-model="form.email"
            type="email"
            required
            autocomplete="email"
            class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-periwinkle transition-colors"
          />
        </div>

        <div class="flex flex-col gap-2">
          <FormLabel for="message">Mensaje</FormLabel>
          <textarea
            id="message"
            v-model="form.message"
            rows="6"
            required
            class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-periwinkle transition-colors resize-none"
          />
        </div>

        <div v-if="error" role="alert" class="font-sans text-sm text-red-500">
          {{ error }}
        </div>

        <div>
          <button
            type="submit"
            :disabled="loading"
            class="font-sans text-xs tracking-widest uppercase text-slate-900 bg-marigold px-6 py-3 rounded hover:opacity-90 transition-opacity disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {{ loading ? 'Enviando…' : 'Enviar mensaje' }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
