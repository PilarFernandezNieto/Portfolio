<script setup>
defineProps({
  color: { type: String, default: '#FBDDD5' },
  size: { type: String, default: '320px' },
  top: { type: String, default: undefined },
  right: { type: String, default: undefined },
  bottom: { type: String, default: undefined },
  left: { type: String, default: undefined },
  opacity: { type: Number, default: 0.5 },
})
</script>

<template>
  <div
    class="absolute rounded-full blur-3xl pointer-events-none -z-10"
    :style="{
      backgroundColor: color,
      width: size,
      height: size,
      top,
      right,
      bottom,
      left,
      opacity,
    }"
    aria-hidden="true"
  />
</template>
