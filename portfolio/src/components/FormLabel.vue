<script setup>
defineProps({
  for: {
    type: String,
    default: undefined,
  },
})
</script>

<template>
  <label
    :for="for"
    class="block font-sans text-[11px] font-bold tracking-[0.14em] uppercase text-ink mb-2.5"
  >
    <slot />
  </label>
</template>
