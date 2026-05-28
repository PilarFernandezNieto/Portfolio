<script setup>
import { useConfirm, useConfirmState } from '@/composables/useConfirm'

const { visible, title, message } = useConfirmState()
const { accept, cancel } = useConfirm()
</script>

<template>
  <Transition name="modal">
    <div
      v-if="visible"
      class="fixed inset-0 z-50 flex items-center justify-center"
      role="dialog"
      aria-modal="true"
      :aria-labelledby="'confirm-title'"
    >
      <div class="absolute inset-0 bg-slate-900/40 backdrop-blur-sm" @click="cancel" />

      <div class="relative bg-white rounded-lg shadow-xl w-full max-w-sm mx-4 px-8 py-8">
        <h2 id="confirm-title" class="font-serif text-xl text-slate-800 font-normal mb-3">
          {{ title }}
        </h2>
        <p class="font-sans text-sm text-slate-500 leading-relaxed mb-8">
          {{ message }}
        </p>

        <div class="flex justify-end gap-3">
          <button
            @click="cancel"
            class="font-sans text-xs tracking-widest uppercase text-slate-500 hover:text-slate-800 px-5 py-3 rounded border border-stone-200 hover:border-slate-400 transition-colors"
          >
            Cancelar
          </button>
          <button
            @click="accept"
            class="font-sans text-xs tracking-widest uppercase text-white bg-red-500 hover:bg-red-600 px-5 py-3 rounded transition-colors"
          >
            Eliminar
          </button>
        </div>
      </div>
    </div>
  </Transition>
</template>

<style scoped>
.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.15s ease;
}
.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}
.modal-enter-active .relative,
.modal-leave-active .relative {
  transition: transform 0.15s ease;
}
.modal-enter-from .relative,
.modal-leave-to .relative {
  transform: scale(0.97);
}
</style>
