<script setup>
import { ref, onMounted } from 'vue'
import { useAboutStore } from '@/stores/about'
import RichTextEditor from '@/components/RichTextEditor.vue'

const store = useAboutStore()
const successMessage = ref(null)

const form = ref({
  bio: '',
  details: [],
})

onMounted(async () => {
  await store.fetchAbout()
  if (store.about) {
    form.value = {
      bio: store.about.bio,
      details: [...store.about.details],
    }
  }
})

function addDetail() {
  form.value.details.push({ label: '', value: '' })
}

function removeDetail(index) {
  form.value.details.splice(index, 1)
}

async function handleSubmit() {
  try {
    const message = await store.updateAbout(form.value)
    successMessage.value = message
    setTimeout(() => (successMessage.value = null), 3000)
  } catch (e) {
    console.log(e)
  }
}
</script>

<template>
  <div class="max-w-2xl">
    <header class="mb-10">
      <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-2">
        Administración
      </p>
      <h1 class="font-serif text-3xl text-slate-800 font-normal">Sobre mí</h1>
    </header>

    <div
      v-if="successMessage"
      role="status"
      class="font-sans text-sm text-green-600 bg-green-50 border border-green-200 rounded px-4 py-3 mb-6"
    >
      {{ successMessage }}
    </div>

    <div
      v-if="store.error"
      role="alert"
      class="font-sans text-sm text-red-500 bg-red-50 border border-red-200 rounded px-4 py-3 mb-6"
    >
      {{ store.error }}
    </div>

    <form @submit.prevent="handleSubmit" class="flex flex-col gap-6" novalidate>
      <div class="flex flex-col gap-2">
        <label
          for="bio"
          class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
        >
          Biografía
        </label>
        <RichTextEditor v-model="form.bio" />
      </div>

      <div class="flex flex-col gap-4">
        <div class="flex justify-between items-center">
          <label class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold">
            Detalles
          </label>
          <button
            type="button"
            @click="addDetail"
            class="font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-slate-800 transition-colors"
          >
            + Añadir
          </button>
        </div>

        <div v-for="(detail, index) in form.details" :key="index" class="flex gap-4 items-center">
          <input
            v-model="detail.label"
            type="text"
            placeholder="Etiqueta"
            class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors flex-1"
          />
          <input
            v-model="detail.value"
            type="text"
            placeholder="Valor"
            class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors flex-1"
          />
          <button
            type="button"
            @click="removeDetail(index)"
            class="font-sans text-xs text-red-400 hover:text-red-600 transition-colors shrink-0"
            aria-label="Eliminar detalle"
          >
            ✕
          </button>
        </div>
      </div>

      <div class="pt-4">
        <button
          type="submit"
          :disabled="store.loading"
          class="font-sans text-xs tracking-widest uppercase text-white bg-slate-800 px-6 py-3 rounded hover:bg-slate-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Guardar cambios
        </button>
      </div>
    </form>
  </div>
</template>
