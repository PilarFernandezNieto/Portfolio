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
    class="font-sans text-xs tracking-widest uppercase text-slate-500 font-semibold"
  >
    <slot />
  </label>
</template>
