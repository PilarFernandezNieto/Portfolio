import { ref, shallowRef } from 'vue'

const visible = ref(false)
const title = ref('')
const message = ref('')
let resolveFn = null

const ConfirmOptions = shallowRef({})

export function useConfirmState() {
  return { visible, title, message }
}

export function useConfirm() {
  function confirm(options) {
    title.value = options.title ?? 'Confirmar'
    message.value = options.message ?? '¿Estás seguro?'
    visible.value = true

    return new Promise((resolve) => {
      resolveFn = resolve
    })
  }

  function accept() {
    visible.value = false
    resolveFn?.(true)
  }

  function cancel() {
    visible.value = false
    resolveFn?.(false)
  }

  return { confirm, accept, cancel }
}
