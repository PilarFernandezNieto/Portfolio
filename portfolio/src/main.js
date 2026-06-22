import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(createPinia())
app.use(router)

app.config.errorHandler = (err, _, info) => console.error('[Vue error]', info, err)
window.addEventListener('unhandledrejection', (e) => console.error('[Promise sin catch]', e.reason))
window.addEventListener('beforeunload', () => console.error('[NAVEGACIÓN DURA — página abandonando]'))
router.beforeEach((to, from) => console.log('[Router]', from.path, '→', to.path))

app.mount('#app')
