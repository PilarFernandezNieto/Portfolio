<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useProjectsStore } from '@/stores/projects'
import RichTextEditor from '@/components/RichTextEditor.vue'

const router = useRouter()
const route = useRoute()
const store = useProjectsStore()

const isEditing = computed(() => !!route.params.id)
const imagePreview = ref(null)
const uploadingImages = ref(false)
const gallery = ref([])

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
    gallery.value = [...(p.images ?? [])]
  }
})

function handleImageChange(e) {
  const file = e.target.files[0]
  if (!file) return
  form.value.image = file
  imagePreview.value = URL.createObjectURL(file)
}

async function handleGalleryUpload(e) {
  const files = Array.from(e.target.files)
  if (!files.length) return
  e.target.value = ''
  uploadingImages.value = true
  try {
    const newImages = await store.addProjectImages(route.params.id, files)
    gallery.value = [...gallery.value, ...newImages]
  } finally {
    uploadingImages.value = false
  }
}

async function handleDeleteImage(imageId) {
  await store.deleteProjectImage(route.params.id, imageId)
  gallery.value = gallery.value.filter((img) => img.id !== imageId)
}

const dragIndex = ref(null)

function onDragStart(index) {
  dragIndex.value = index
}

function onDragOver(index) {
  if (dragIndex.value === null || dragIndex.value === index) return
  const arr = [...gallery.value]
  const [moved] = arr.splice(dragIndex.value, 1)
  arr.splice(index, 0, moved)
  gallery.value = arr
  dragIndex.value = index
}

async function onDragEnd() {
  dragIndex.value = null
  const payload = gallery.value.map((img, index) => ({ id: img.id, order: index }))
  await store.reorderProjectImages(route.params.id, payload)
}

function imageUrl(path) {
  return `${import.meta.env.VITE_STORAGE_URL}/${path}`
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
      router.push({ name: 'admin-projects' })
    } else {
      const created = await store.createProject(formData)
      router.push({ name: 'admin-projects-edit', params: { id: created.id } })
    }
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
        <RichTextEditor v-model="form.description" />
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
          Portada <span class="normal-case text-slate-300">(imagen del listado)</span>
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

    <!-- Sección galería — solo visible al editar -->
    <section v-if="isEditing && store.project" class="mt-16 pt-10 border-t border-stone-200">
      <div class="mb-6">
        <p class="font-sans text-xs tracking-widest uppercase text-slate-400 font-semibold mb-1">
          Galería de capturas
        </p>
        <p class="font-sans text-xs text-slate-400">
          Arrastra las imágenes para reordenarlas. Se guardan automáticamente.
        </p>
      </div>

      <div v-if="gallery.length > 0" class="grid grid-cols-2 gap-3 mb-4">
        <div
          v-for="(img, index) in gallery"
          :key="img.id"
          draggable="true"
          @dragstart="onDragStart(index)"
          @dragover.prevent="onDragOver(index)"
          @dragend="onDragEnd"
          class="relative group rounded overflow-hidden border border-stone-200 aspect-video bg-stone-50 cursor-grab active:cursor-grabbing"
          :class="{ 'opacity-50': dragIndex === index }"
        >
          <img
            :src="imageUrl(img.path)"
            :alt="`Captura ${index + 1}`"
            class="w-full h-full object-cover pointer-events-none"
          />
          <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity bg-slate-900/10" />
          <button
            type="button"
            @click.stop="handleDeleteImage(img.id)"
            class="absolute top-2 right-2 w-7 h-7 rounded-full bg-white/90 text-slate-600 hover:text-red-500 hover:bg-white flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity shadow-sm cursor-pointer"
            :aria-label="`Eliminar imagen ${index + 1}`"
          >
            ✕
          </button>
        </div>
      </div>

      <label
        class="relative flex items-center gap-3 cursor-pointer w-fit"
        :class="{ 'opacity-50 cursor-not-allowed pointer-events-none': uploadingImages }"
      >
        <span
          class="font-sans text-xs tracking-widest uppercase text-slate-500 border border-stone-200 rounded px-4 py-2 hover:border-slate-400 hover:text-slate-800 transition-colors"
        >
          {{ uploadingImages ? 'Subiendo…' : '+ Añadir capturas' }}
        </span>
        <input
          type="file"
          accept="image/jpeg,image/png,image/webp"
          multiple
          tabindex="-1"
          class="sr-only"
          @change="handleGalleryUpload"
          :disabled="uploadingImages"
        />
      </label>
    </section>
  </div>
</template>
