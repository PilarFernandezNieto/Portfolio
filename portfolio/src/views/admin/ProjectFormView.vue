<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useProjectsStore } from '@/stores/projects'
import RichTextEditor from '@/components/RichTextEditor.vue'
import FormLabel from '@/components/FormLabel.vue'

const router = useRouter()
const route = useRoute()
const store = useProjectsStore()

const isEditing = computed(() => !!route.params.id)
const imagePreview = ref(null)
const uploadingImages = ref(false)
const gallery = ref([])

const form = ref({
  title: '',
  intro: '',
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
      intro: p.intro || '',
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
  formData.append('intro', form.value.intro)
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
      <p class="font-sans text-xs font-bold tracking-[0.2em] uppercase text-muted mb-2.5">
        {{ isEditing ? 'Editar proyecto' : 'Nuevo proyecto' }}
      </p>
      <h1 class="heading heading-admin">
        {{ isEditing ? form.title : 'Crear proyecto' }}
      </h1>
    </header>

    <div v-if="store.error" role="alert" class="font-sans text-sm text-red-600 border border-red-300 px-4 py-3 mb-6">
      {{ store.error }}
    </div>

    <form @submit.prevent="handleSubmit" class="flex flex-col gap-6.5" novalidate>
      <div>
        <FormLabel for="title">Título</FormLabel>
        <input
          id="title"
          v-model="form.title"
          type="text"
          required
          class="w-full border border-ink bg-transparent font-sans text-[15px] text-ink px-3.5 py-3 outline-none focus:border-2"
        />
      </div>

      <div>
        <FormLabel for="intro">
          Intro
          <span class="normal-case font-normal tracking-normal text-muted"
            >(resumen breve para el listado, máx. 500 caracteres)</span
          >
        </FormLabel>
        <textarea
          id="intro"
          v-model="form.intro"
          rows="3"
          maxlength="500"
          class="w-full border border-ink bg-transparent font-sans text-[15px] text-ink px-3.5 py-3 outline-none resize-none focus:border-2"
        />
      </div>

      <div>
        <FormLabel for="description">
          Descripción
          <span class="normal-case font-normal tracking-normal text-muted">(texto completo en la ficha del proyecto)</span>
        </FormLabel>
        <RichTextEditor v-model="form.description" />
      </div>

      <div>
        <FormLabel for="url">URL externa</FormLabel>
        <input
          id="url"
          v-model="form.url"
          type="url"
          class="w-full border border-ink bg-transparent font-sans text-[15px] text-ink px-3.5 py-3 outline-none focus:border-2"
        />
      </div>

      <div>
        <FormLabel for="technologies">
          Tecnologías <span class="normal-case font-normal tracking-normal text-muted">(separadas por comas)</span>
        </FormLabel>
        <input
          id="technologies"
          v-model="form.technologies"
          type="text"
          placeholder="PHP, Laravel, Vue.js"
          required
          class="w-full border border-ink bg-transparent font-sans text-[15px] text-ink px-3.5 py-3 outline-none focus:border-2"
        />
      </div>

      <div class="flex flex-wrap gap-6.5">
        <div class="flex-1">
          <FormLabel for="order">Orden</FormLabel>
          <input
            id="order"
            v-model="form.order"
            type="number"
            min="0"
            class="w-full border border-ink bg-transparent font-sans text-[15px] text-ink px-3.5 py-3 outline-none focus:border-2"
          />
        </div>

        <div class="flex-[0_0_160px]">
          <label class="flex items-center gap-2.5 font-sans text-sm font-semibold text-ink mt-2.5">
            <input id="visible" v-model="form.visible" type="checkbox" class="w-4 h-4 accent-ink" />
            Visible en el portfolio
          </label>
        </div>
      </div>

      <div>
        <FormLabel for="image">
          Portada <span class="normal-case font-normal tracking-normal text-muted">(imagen del listado)</span>
        </FormLabel>
        <div v-if="imagePreview" class="w-full h-48 overflow-hidden mb-2.5 border border-ink">
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

      <div class="flex flex-wrap gap-4 pt-2">
        <button
          type="submit"
          :disabled="store.loading"
          class="bg-ink border border-ink text-cream font-sans text-[13px] font-bold tracking-widest uppercase px-7 py-3.5 disabled:opacity-50 disabled:cursor-not-allowed focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
        >
          {{ isEditing ? 'Guardar cambios' : 'Crear proyecto' }}
        </button>
        <RouterLink
          :to="{ name: 'admin-projects' }"
          class="border border-ink text-ink font-sans text-[13px] font-bold tracking-widest uppercase px-7 py-3.5 focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]"
        >
          Cancelar
        </RouterLink>
      </div>
    </form>

    <!-- Sección galería — solo visible al editar -->
    <section v-if="isEditing && store.project" class="mt-16 pt-10 border-t border-ink">
      <div class="mb-6">
        <p class="font-sans text-xs font-bold tracking-widest uppercase text-ink mb-1.5">
          Galería de capturas
        </p>
        <p class="font-sans text-xs text-muted">
          Arrastra las imágenes para reordenarlas. Se guardan automáticamente.
        </p>
      </div>

      <div v-if="gallery.length > 0" class="grid grid-cols-2 sm:grid-cols-3 gap-3 mb-4">
        <div
          v-for="(img, index) in gallery"
          :key="img.id"
          draggable="true"
          @dragstart="onDragStart(index)"
          @dragover.prevent="onDragOver(index)"
          @dragend="onDragEnd"
          class="relative group overflow-hidden border border-ink aspect-video bg-border-soft cursor-grab active:cursor-grabbing"
          :class="{ 'opacity-50': dragIndex === index }"
        >
          <img
            :src="imageUrl(img.path)"
            :alt="`Captura ${index + 1}`"
            class="w-full h-full object-cover pointer-events-none"
          />
          <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity bg-ink/10" />
          <button
            type="button"
            @click.stop="handleDeleteImage(img.id)"
            class="absolute top-2 right-2 w-7 h-7 rounded-full border border-ink bg-cream/90 text-ink hover:bg-cream flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity cursor-pointer"
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
          class="font-sans text-xs font-bold tracking-widest uppercase text-ink border border-ink px-5 py-2.5"
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
