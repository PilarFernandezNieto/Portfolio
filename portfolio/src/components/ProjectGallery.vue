<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'

const props = defineProps({
  images: { type: Array, required: true },
  storageUrl: { type: Function, required: true },
})

const lightboxIndex = ref(null)

const isOpen = computed(() => lightboxIndex.value !== null)
const current = computed(() => (isOpen.value ? props.images[lightboxIndex.value] : null))

function open(index) {
  lightboxIndex.value = index
}

function close() {
  lightboxIndex.value = null
}

function prev() {
  if (lightboxIndex.value > 0) lightboxIndex.value--
}

function next() {
  if (lightboxIndex.value < props.images.length - 1) lightboxIndex.value++
}

function onKeydown(e) {
  if (!isOpen.value) return
  if (e.key === 'Escape') close()
  if (e.key === 'ArrowLeft') prev()
  if (e.key === 'ArrowRight') next()
}

onMounted(() => window.addEventListener('keydown', onKeydown))
onUnmounted(() => window.removeEventListener('keydown', onKeydown))
</script>

<template>
  <div class="grid grid-cols-2 md:grid-cols-3 gap-3">
    <button
      v-for="(img, index) in images"
      :key="img.id"
      type="button"
      @click="open(index)"
      class="group relative aspect-video rounded-lg overflow-hidden border border-stone-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-slate-400 cursor-pointer"
      :aria-label="`Ver captura ${index + 1} de ${images.length}`"
    >
      <img
        :src="storageUrl(img.path)"
        :alt="`Captura ${index + 1}`"
        class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
        loading="lazy"
      />
      <div class="absolute inset-0 bg-slate-900/0 group-hover:bg-slate-900/20 transition-colors" />
    </button>
  </div>

  <Teleport to="body">
    <div
      v-if="isOpen"
      class="fixed inset-0 z-50 flex items-center justify-center"
      role="dialog"
      aria-modal="true"
      :aria-label="`Imagen ${lightboxIndex + 1} de ${images.length}`"
    >
      <div class="absolute inset-0 bg-slate-900/90 backdrop-blur-sm" @click="close" />

      <div class="relative z-10 flex items-center gap-4 max-w-5xl w-full px-4">
        <button
          type="button"
          @click="prev"
          :disabled="lightboxIndex === 0"
          class="shrink-0 w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 text-white flex items-center justify-center transition-colors disabled:opacity-20 disabled:cursor-not-allowed"
          aria-label="Imagen anterior"
        >
          ←
        </button>

        <div class="flex-1 flex items-center justify-center">
          <img
            :src="storageUrl(current.path)"
            :alt="`Captura ${lightboxIndex + 1} de ${images.length}`"
            class="max-h-[85vh] max-w-full object-contain rounded-lg shadow-2xl"
          />
        </div>

        <button
          type="button"
          @click="next"
          :disabled="lightboxIndex === images.length - 1"
          class="shrink-0 w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 text-white flex items-center justify-center transition-colors disabled:opacity-20 disabled:cursor-not-allowed"
          aria-label="Imagen siguiente"
        >
          →
        </button>
      </div>

      <div class="absolute top-4 right-4 flex items-center gap-4 z-10">
        <span class="font-sans text-xs text-white/60">
          {{ lightboxIndex + 1 }} / {{ images.length }}
        </span>
        <button
          type="button"
          @click="close"
          class="w-9 h-9 rounded-full bg-white/10 hover:bg-white/20 text-white flex items-center justify-center transition-colors"
          aria-label="Cerrar galería"
        >
          ✕
        </button>
      </div>
    </div>
  </Teleport>
</template>
