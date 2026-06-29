<script setup>
import { ref } from 'vue'
import api from '@/services/api'

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
  <div class="max-w-4xl mx-auto px-6 py-24">
    <header class="border-b border-stone-200 pb-12 mb-12">
      <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-4">
        Contacto
      </p>
      <h1 class="font-serif text-4xl text-slate-800 font-normal">Hablemos</h1>
    </header>

    <div class="grid md:grid-cols-3 gap-12 md:gap-16">
      <div>
        <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-4">
          Mensaje
        </p>
        <div class="w-10 h-0.5 bg-slate-300"></div>
      </div>

      <div class="md:col-span-2">
        <div
          v-if="success"
          role="status"
          class="font-sans text-sm text-green-700 bg-green-50 border border-green-200 rounded px-5 py-4 mb-8"
        >
          Mensaje enviado. Me pondré en contacto contigo pronto.
        </div>

        <form
          v-if="!success"
          @submit.prevent="handleSubmit"
          class="flex flex-col gap-6"
          novalidate
        >
          <div class="flex flex-col gap-2">
            <label
              for="name"
              class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
            >
              Nombre
            </label>
            <input
              id="name"
              v-model="form.name"
              type="text"
              required
              autocomplete="name"
              class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors"
            />
          </div>

          <div class="flex flex-col gap-2">
            <label
              for="email"
              class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
            >
              Email
            </label>
            <input
              id="email"
              v-model="form.email"
              type="email"
              required
              autocomplete="email"
              class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors"
            />
          </div>

          <div class="flex flex-col gap-2">
            <label
              for="message"
              class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
            >
              Mensaje
            </label>
            <textarea
              id="message"
              v-model="form.message"
              rows="6"
              required
              class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors resize-none"
            />
          </div>

          <div
            v-if="error"
            role="alert"
            class="font-sans text-sm text-red-500"
          >
            {{ error }}
          </div>

          <div>
            <button
              type="submit"
              :disabled="loading"
              class="font-sans text-xs tracking-widest uppercase text-white bg-slate-800 px-6 py-3 rounded hover:bg-slate-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {{ loading ? 'Enviando…' : 'Enviar mensaje' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
