<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useProjectsStore } from '@/stores/projects'

const router = useRouter()
const route = useRoute()
const store = useProjectsStore()

const isEditing = computed(() => !!route.params.id)
const imagePreview = ref(null)

const form = ref({
  title: '',
  description: '',
  url: '',
  technologies: '',
  order: 0,
  visible: true,
  image: null,
})

onMounted(async () => {
  if (isEditing.value) {
    await store.fetchProject(route.params.id)
    const p = store.project
    form.value = {
      title: p.title,
      description: p.description,
      url: p.url || '',
      technologies: p.technologies.join(', '),
      order: p.order,
      visible: p.visible,
      image: null,
    }
    if (p.image) {
      imagePreview.value = `${import.meta.env.VITE_STORAGE_URL}/${p.image}`
    }
  }
})

function handleImageChange(e) {
  const file = e.target.files[0]
  if (!file) return
  form.value.image = file
  imagePreview.value = URL.createObjectURL(file)
}

async function handleSubmit() {
  const formData = new FormData()
  formData.append('title', form.value.title)
  formData.append('description', form.value.description)
  formData.append('url', form.value.url)
  formData.append('order', form.value.order)
  formData.append('visible', form.value.visible ? 1 : 0)

  const technologies = form.value.technologies
    .split(',')
    .map((t) => t.trim())
    .filter((t) => t)

  technologies.forEach((tech) => formData.append('technologies[]', tech))

  if (form.value.image) {
    formData.append('image', form.value.image)
  }

  try {
    if (isEditing.value) {
      await store.updateProject(route.params.id, formData)
    } else {
      await store.createProject(formData)
    }
    router.push({ name: 'admin-projects' })
  } catch {
    // el error ya está en store.error
  }
}
</script>

<template>
  <div class="max-w-2xl">
    <header class="mb-10">
      <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-2">
        {{ isEditing ? 'Editar proyecto' : 'Nuevo proyecto' }}
      </p>
      <h1 class="font-serif text-3xl text-slate-800 font-normal">
        {{ isEditing ? form.title : 'Crear proyecto' }}
      </h1>
    </header>

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
          for="title"
          class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
        >
          Título
        </label>
        <input
          id="title"
          v-model="form.title"
          type="text"
          required
          class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors"
        />
      </div>

      <div class="flex flex-col gap-2">
        <label
          for="description"
          class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
        >
          Descripción
        </label>
        <textarea
          id="description"
          v-model="form.description"
          rows="4"
          required
          class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors resize-none"
        />
      </div>

      <div class="flex flex-col gap-2">
        <label
          for="url"
          class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
        >
          URL externa
        </label>
        <input
          id="url"
          v-model="form.url"
          type="url"
          class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors"
        />
      </div>

      <div class="flex flex-col gap-2">
        <label
          for="technologies"
          class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
        >
          Tecnologías <span class="normal-case text-slate-300">(separadas por comas)</span>
        </label>
        <input
          id="technologies"
          v-model="form.technologies"
          type="text"
          placeholder="PHP, Laravel, Vue.js"
          required
          class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors"
        />
      </div>

      <div class="flex gap-6">
        <div class="flex flex-col gap-2 flex-1">
          <label
            for="order"
            class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
          >
            Orden
          </label>
          <input
            id="order"
            v-model="form.order"
            type="number"
            min="0"
            class="font-sans text-sm text-slate-800 bg-white border border-stone-200 rounded px-4 py-3 focus:outline-none focus:border-slate-400 transition-colors"
          />
        </div>

        <div class="flex flex-col gap-2 justify-end pb-1">
          <label class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold">
            Visible
          </label>
          <div class="flex items-center gap-3 px-4 py-3">
            <input
              id="visible"
              v-model="form.visible"
              type="checkbox"
              class="w-4 h-4 accent-slate-800"
            />
            <label for="visible" class="font-sans text-sm text-slate-600">
              Mostrar en el portfolio
            </label>
          </div>
        </div>
      </div>

      <div class="flex flex-col gap-2">
        <label
          for="image"
          class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold"
        >
          Imagen
        </label>
        <div
          v-if="imagePreview"
          class="w-full h-48 rounded overflow-hidden mb-2 border border-stone-200"
        >
          <img :src="imagePreview" alt="Preview" class="w-full h-full object-cover" />
        </div>
        <input
          id="image"
          type="file"
          accept="image/jpeg,image/png,image/webp"
          @change="handleImageChange"
          class="font-sans text-sm text-slate-600 file:mr-4 file:py-2 file:px-4 file:rounded file:border-0 file:text-xs file:font-semibold file:bg-slate-100 file:text-slate-600 hover:file:bg-slate-200 transition-colors"
        />
      </div>

      <div class="flex gap-4 pt-4">
        <button
          type="submit"
          :disabled="store.loading"
          class="font-sans text-xs tracking-widest uppercase text-white bg-slate-800 px-6 py-3 rounded hover:bg-slate-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {{ isEditing ? 'Guardar cambios' : 'Crear proyecto' }}
        </button>
        <RouterLink
          :to="{ name: 'admin-projects' }"
          class="font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-slate-800 px-6 py-3 transition-colors"
        >
          Cancelar
        </RouterLink>
      </div>
    </form>
  </div>
</template>
