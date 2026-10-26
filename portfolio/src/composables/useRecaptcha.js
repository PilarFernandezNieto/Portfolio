const SITE_KEY = import.meta.env.VITE_RECAPTCHA_SITE_KEY

let scriptPromise = null

function loadScript() {
  if (!SITE_KEY) {
    return Promise.reject(new Error('Falta VITE_RECAPTCHA_SITE_KEY'))
  }
  if (scriptPromise) return scriptPromise

  scriptPromise = new Promise((resolve, reject) => {
    const script = document.createElement('script')
    script.src = `https://www.google.com/recaptcha/api.js?render=${encodeURIComponent(SITE_KEY)}`
    script.async = true
    script.onload = () => window.grecaptcha.ready(resolve)
    script.onerror = () => {
      script.remove()
      scriptPromise = null
      reject(new Error('No se pudo cargar reCAPTCHA'))
    }
    document.head.appendChild(script)
  })

  return scriptPromise
}

export function useRecaptcha() {
  async function execute(action) {
    await loadScript()
    return window.grecaptcha.execute(SITE_KEY, { action })
  }

  return { load: loadScript, execute }
}
