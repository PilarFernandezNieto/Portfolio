<script setup>
import { ref, onMounted } from 'vue'
import { useAboutStore } from '@/stores/about'
import RichTextEditor from '@/components/RichTextEditor.vue'
import FormLabel from '@/components/FormLabel.vue'
import ButtonDark from '@/components/ButtonDark.vue'

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
      <p class="font-sans text-xs font-bold tracking-[0.2em] uppercase text-muted mb-2.5">
        Administración
      </p>
      <h1 class="heading heading-admin">Sobre mí</h1>
    </header>

    <div v-if="successMessage" role="status" class="font-sans text-sm text-ink border border-ink px-4 py-3 mb-6">
      {{ successMessage }}
    </div>

    <div v-if="store.error" role="alert" class="font-sans text-sm text-red-600 border border-red-300 px-4 py-3 mb-6">
      {{ store.error }}
    </div>

    <form @submit.prevent="handleSubmit" class="flex flex-col gap-7" novalidate>
      <div>
        <FormLabel for="bio">Biografía</FormLabel>
        <RichTextEditor v-model="form.bio" />
      </div>

      <div class="flex flex-col gap-4">
        <div class="flex justify-between items-center">
          <FormLabel>Detalles</FormLabel>
          <ButtonDark type="button" @click="addDetail" variant="outline" size="sm">
            + Añadir
          </ButtonDark>
        </div>

        <div
          v-for="(detail, index) in form.details"
          :key="index"
          class="flex flex-col sm:flex-row gap-3 sm:gap-4 sm:items-center"
        >
          <input
            v-model="detail.label"
            type="text"
            placeholder="Etiqueta"
            class="flex-1 border border-ink bg-transparent font-sans text-[15px] text-ink px-3.5 py-3 outline-none focus:border-2"
          />
          <div class="flex gap-4 items-center">
            <input
              v-model="detail.value"
              type="text"
              placeholder="Valor"
              class="flex-1 border border-ink bg-transparent font-sans text-[15px] text-ink px-3.5 py-3 outline-none focus:border-2"
            />
            <button
              type="button"
              @click="removeDetail(index)"
              class="font-sans text-xs text-red-600 hover:text-red-800 transition-colors shrink-0"
              aria-label="Eliminar detalle"
            >
              ✕
            </button>
          </div>
        </div>
      </div>

      <div class="pt-2">
        <ButtonDark type="submit" :disabled="store.loading" size="lg">
          Guardar cambios
        </ButtonDark>
      </div>
    </form>
  </div>
</template>
