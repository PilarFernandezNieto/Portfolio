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
      <div class="absolute inset-0 bg-ink/60" @click="cancel" />

      <div class="relative bg-cream border border-ink w-full max-w-sm mx-4 px-9 py-9">
        <h2 id="confirm-title" class="heading text-xl mb-4">
          {{ title }}
        </h2>
        <p class="font-sans text-[15px] text-ink/85 leading-relaxed mb-7">
          {{ message }}
        </p>

        <div class="flex justify-between gap-4">
          <button
            @click="accept"
            class="text-cream font-sans text-[13px] font-bold tracking-widest uppercase bg-delete border border-delete px-6 py-3 focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-2"
          >
            Eliminar
          </button>
          <button
            @click="cancel"
            class="text-ink font-sans text-[13px] font-bold tracking-widest uppercase border border-ink px-6 py-3 focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-2"
          >
            Cancelar
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
