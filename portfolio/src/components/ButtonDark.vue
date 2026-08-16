<script setup>
import { computed } from 'vue'
import { RouterLink } from 'vue-router'

const props = defineProps({
  to: {
    type: [String, Object],
    default: null,
  },
  href: {
    type: String,
    default: null,
  },
  variant: {
    type: String,
    default: 'solid',
    validator: (value) => ['solid', 'outline'].includes(value),
  },
  size: {
    type: String,
    default: 'md',
    validator: (value) => ['sm', 'md', 'lg'].includes(value),
  },
})

const tag = computed(() => {
  if (props.to) return RouterLink
  if (props.href) return 'a'
  return 'button'
})

const sizeClasses = {
  sm: 'px-5.5 py-2.5',
  md: 'px-6.5 py-3',
  lg: 'px-7 py-3.5',
}

const variantClasses = computed(() =>
  props.variant === 'outline'
    ? 'border border-ink hover:border-cream text-ink hover:text-cream hover:bg-ink focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]'
    : 'bg-ink border hover:bg-cream hover:text-ink border-ink text-cream focus-visible:outline-2 focus-visible:outline-ink focus-visible:outline-offset-[3px]',
)
</script>

<template>
  <component
    :is="tag"
    :to="to ?? undefined"
    :href="href ?? undefined"
    class="inline-block font-sans font-bold text-[13px] uppercase tracking-widest transition duration-400 ease-in-out disabled:opacity-50 disabled:cursor-not-allowed"
    :class="[sizeClasses[size], variantClasses]"
  >
    <slot />
  </component>
</template>
