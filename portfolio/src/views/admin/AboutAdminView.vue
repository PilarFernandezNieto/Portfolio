<script setup>
import { ref, onMounted } from 'vue'
import { useToast } from 'primevue/usetoast'
import { useAboutStore } from '@/stores/about'
import RichTextEditor from '@/components/RichTextEditor.vue'
import FormLabel from '@/components/FormLabel.vue'
import ButtonDark from '@/components/ButtonDark.vue'
import { useRouter } from 'vue-router'

const store = useAboutStore()
const toast = useToast()
const router = useRouter()
const imagePreview = ref(null)

const form = ref({
  bio: '',
  details: [],
  image: null,
})

onMounted(async () => {
  await store.fetchAbout()
  if (store.about) {
    form.value = {
      bio: store.about.bio,
      details: [...store.about.details],
      image: null,
    }
    if (store.about.image) {
      imagePreview.value = `${import.meta.env.VITE_STORAGE_URL}/${store.about.image}`
    }
  }
})
function handleImageChange(e) {
  const file = e.target.files[0]
  if (!file) return
  form.value.image = file
  imagePreview.value = URL.createObjectURL(file)
}

function addDetail() {
  form.value.details.push({ label: '', value: '' })
}

function removeDetail(index) {
  form.value.details.splice(index, 1)
}

async function handleSubmit() {
  try {
    const formData = new FormData()
    formData.append('bio', form.value.bio)
    form.value.details.forEach((detail, index) => {
      formData.append(`details[${index}][label]`, detail.label)
      formData.append(`details[${index}][value]`, detail.value)
    })
    if (form.value.image) {
      formData.append('image', form.value.image)
    }

    const message = await store.updateAbout(formData)
    toast.add({ severity: 'success', summary: message, life: 3000 })
    router.push({ name: 'admin-projects' })
  } catch {
    // el error ya está en store.error
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

    <div
      v-if="store.error"
      role="alert"
      class="font-sans text-sm text-red-600 border border-red-300 px-4 py-3 mb-6"
    >
      {{ store.error }}
    </div>

    <form @submit.prevent="handleSubmit" class="flex flex-col gap-7" novalidate>
      <div>
        <FormLabel for="bio">Biografía</FormLabel>
        <RichTextEditor v-model="form.bio" />
      </div>
      <div>
        <FormLabel for="image"> Foto de perfil </FormLabel>
        <div v-if="imagePreview" class="w-40 overflow-hidden mb-2.5 border border-ink">
          <img :src="imagePreview" alt="Preview" class="w-full h-full object-cover" />
        </div>
        <input
          id="image"
          type="file"
          accept="image/jpeg,image/png,image/webp"
          @change="handleImageChange"
          class="font-sans text-sm text-ink file:mr-4 file:py-2 file:px-4 file:border file:border-ink file:bg-transparent file:text-xs file:font-semibold file:uppercase file:tracking-wider file:cursor-pointer"
        />
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
        <ButtonDark type="submit" :disabled="store.loading" size="lg"> Guardar cambios </ButtonDark>
      </div>
    </form>
  </div>
</template>
