import { ref } from 'vue'

const pageReady = ref(true)

export function usePageReady() {
  const setReady = (value) => {
    pageReady.value = value
  }

  return {
    pageReady,
    setReady,
  }
}
