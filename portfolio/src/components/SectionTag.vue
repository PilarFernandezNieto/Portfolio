<script setup>
defineProps({
  label: { type: String, required: true },
  color: { type: String, default: 'marigold' },
})
</script>

<template>
  <div class="inline-flex items-center gap-2">
    <span
      class="w-1.5 h-1.5 rounded-full"
      :class="{
        'bg-marigold': color === 'marigold',
        'bg-periwinkle': color === 'periwinkle',
      }"
    />
    <span class="font-sans text-xs tracking-widest uppercase font-semibold text-slate-500">
      {{ label }}
    </span>
  </div>
</template>
