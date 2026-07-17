<script setup></script>

<template>
  <div class="cv-page">
    <aside class="sidebar">
      <div class="name-block">
        <h1>Pilar<br />Fernández<br />Nieto</h1>
        <p class="role">Desarrolladora Full-Stack</p>
      </div>

      <div class="contact-block">
        <div class="sidebar-label">Contacto</div>
        <div class="contact-item">
          <span class="icon">✉</span><span>pilarfnieto@gmail.com</span>
        </div>
        <div class="contact-item"><span class="icon">☏</span><span>+34 626 34 01 44</span></div>
        <div class="contact-item"><span class="icon">⌂</span><span>Gijón, Asturias</span></div>
      </div>
      <div class="sidebar-section">
        <div class="sidebar-label">Trabajos</div>
        <div class="contact-item">
          <span class="icon">◈</span>
          <span>
            <a href="https://pilarfdez.es" target="_blank" rel="noopener noreferrer">
              https://pilarfdez.es
            </a>
          </span>
        </div>
      </div>

      <div class="sidebar-section">
        <div class="sidebar-label">Stack técnico</div>

        <div class="skill-group">
          <div class="skill-group-name">Backend</div>
          <div class="skill-tags">
            <span class="tag-highlight">PHP</span>
            <span class="tag-highlight">Laravel</span>
            <span class="tag">APIs REST</span>
            <span class="tag">MySQL</span>
            <span class="tag">Twig / Smarty</span>
          </div>
        </div>

        <div class="skill-group">
          <div class="skill-group-name">Frontend</div>
          <div class="skill-tags">
            <span class="tag-highlight">Vue.js 3</span>
            <span class="tag-highlight">Pinia</span>
            <span class="tag">Vue Router</span>
            <span class="tag">Axios</span>
            <span class="tag">Bootstrap</span>
            <span class="tag">JavaScript</span>
            <span class="tag">jQuery</span>
          </div>
        </div>

        <div class="skill-group">
          <div class="skill-group-name">Herramientas</div>
          <div class="skill-tags">
            <span class="tag">Git</span>
            <span class="tag">Postman</span>
            <span class="tag">Moodle</span>
            <span class="tag">Prestashop</span>
            <span class="tag">Tailwind CSS</span>
            <span class="tag">Blade / Livewire</span>
          </div>
        </div>
      </div>

      <div class="sidebar-section">
        <div class="sidebar-label">Idiomas</div>
        <div class="lang-item"><span>Español</span> — Nativo</div>
        <div class="lang-item"><span>Inglés</span> — B2 (en progreso)</div>
      </div>

      <div class="sidebar-section">
        <div class="sidebar-label">Perfil personal</div>
        <div class="soft-item">Trabajo en equipo</div>
        <div class="soft-item">Orientación al cliente</div>
        <div class="soft-item">Aprendizaje autónomo</div>
        <div class="soft-item">Resolución de problemas</div>
        <div class="soft-item">Adaptación al cambio</div>
      </div>
    </aside>

    <main class="main">
      <div class="summary-block">
        Desarrolladora full-stack con más de
        <strong>2 años de experiencia profesional</strong> en empresa de desarrollo de software.
        Combino desarrollo técnico con formación a clientes y soporte en producción — el ciclo
        completo, desde la API hasta el usuario final. Integro
        <strong>herramientas de IA como Claude</strong> en mi flujo de trabajo como apoyo al
        aprendizaje y la toma de decisiones técnicas.<br /><br />
        De manera autónoma desarrollo con <strong>Laravel + Vue.js</strong>, tanto en arquitectura
        monolítica como en API desacoplada. Presto especial atención a la
        <strong>accesibilidad web</strong> y la experiencia de usuario en todo lo que construyo.
      </div>

      <div class="section">
        <div class="section-title">Experiencia profesional</div>

        <div class="entry">
          <div class="entry-header">
            <div>
              <div class="entry-title">Desarrolladora Web Full-Stack</div>
              <div class="entry-company">Ticmedia Soluciones Profesionales · Gijón</div>
            </div>
            <span class="entry-date">Ene 2024 — Actualidad</span>
          </div>
          <ul class="bullet-list">
            <li>
              Desarrollo y mantenimiento de aplicaciones web con
              <strong>framework y CMS propios en PHP</strong>, utilizando HTML, CSS,
              <strong>Bootstrap</strong>, JavaScript y jQuery.
            </li>
            <li>
              Gestión y personalización de tiendas
              <strong>Prestashop</strong> y plataformas de formación <strong>Moodle</strong>.
            </li>
            <li>
              Desarrollo y mantenimiento de
              <strong>APIs REST</strong> consumidas por interfaces en <strong>Vue.js 3</strong> con
              Pinia y Vue Router.
            </li>
            <li>
              Soporte técnico, configuración y formación presencial a clientes en el uso de
              <strong>Restaurantic</strong>, plataforma de gestión de reservas para hostelería.
            </li>
            <li>Soporte técnico de incidencias en producción.</li>
          </ul>
        </div>

        <div class="entry">
          <div class="entry-header">
            <div>
              <div class="entry-title">Prácticas FCT — Desarrollo de Aplicaciones Web</div>
              <div class="entry-company">Ticmedia Soluciones Profesionales</div>
            </div>
            <span class="entry-date">Sep — Dic 2023</span>
          </div>
          <ul class="bullet-list">
            <li>
              Herramienta de migración de datos entre estructuras distintas (JSON → MySQL). Primera
              experiencia con
              <strong>Git y trabajo en equipo</strong> profesional.
            </li>
          </ul>
        </div>

        <div class="entry">
          <div class="entry-header">
            <div>
              <div class="entry-title">Instructora de Fitness · Promotora de Ventas</div>
              <div class="entry-company">Real Grupo Covadonga · El Corte Inglés</div>
            </div>
            <span class="entry-date">2007 — 2023</span>
          </div>
          <ul class="bullet-list">
            <li>
              Más de 15 años en atención al público, coordinación de grupos y trabajo bajo presión —
              habilidades directamente aplicables al trato con clientes en entornos técnicos.
            </li>
          </ul>
        </div>
      </div>

      <div class="section">
        <div class="section-title">Proyectos personales</div>
        <ul class="bullet-list">
          <li>
            Aplicaciones con <strong>Laravel 11</strong>: full-stack con Blade + Livewire, y API
            desacoplada con <strong>Vue.js + Pinia</strong>.
          </li>
          <li>
            Exploración del stack MEVN (MongoDB, Express, Vue, Node) para ampliar conocimientos de
            backend.
          </li>
          <li>
            Implementación de estándares de
            <strong>accesibilidad web</strong>: ARIA, semántica HTML, navegación por teclado y
            contraste de color.
          </li>
        </ul>
      </div>

      <div class="section">
        <div class="section-title">Formación</div>
        <div class="entry">
          <div class="edu-row">
            <div>
              <div class="edu-title">CFGS Desarrollo de Aplicaciones Web</div>
              <div class="edu-center">CIFP La Laboral · Gijón</div>
            </div>
            <span class="edu-date">2021 — 2023</span>
          </div>
        </div>
        <div class="entry">
          <div class="edu-row">
            <div>
              <div class="edu-title">Formación complementaria autónoma</div>
              <div class="edu-center">
                Laravel · Vue.js · PHP avanzado · Tailwind 3/4 · DOM · MySQL
              </div>
            </div>
            <span class="edu-date">2022 — hoy</span>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<style scoped>
.cv-page {
  box-sizing: border-box;
  --slate: #2c3e50;
  --slate-mid: #3d5166;
  --slate-light: #5b7a99;
  --accent: #7fb3d3;
  --bg: #f7f8fa;
  --text: #1a2530;
  --text-soft: #4a6070;
  --rule: #d0dde8;

  font-family: 'DM Sans', sans-serif;
  font-size: 9pt;
  color: var(--text);
  line-height: 1.45;

  display: grid;
  grid-template-columns: 64mm 1fr;
  width: 210mm;
  min-height: 297mm;
  background: white;
  box-shadow: 0 4px 32px rgba(0, 0, 0, 0.18);
}

.cv-page :deep(*) {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

@media print {
  .cv-page {
    box-shadow: none;
    height: 297mm;
    overflow: hidden;
  }
}

/* ── SIDEBAR ── */
.sidebar {
  background: var(--slate);
  color: white;
  padding: 8mm 6mm 8mm 7mm;
  display: flex;
  flex-direction: column;
  gap: 5mm;
}

.name-block {
  border-bottom: 1px solid var(--slate-light);
  padding-bottom: 5mm;
}

.name-block h1 {
  font-family: 'DM Serif Display', serif;
  font-size: 20pt;
  line-height: 1.05;
  color: white;
  margin-bottom: 2.5mm;
}

.role {
  font-size: 7pt;
  font-weight: 600;
  color: var(--accent);
  letter-spacing: 0.12em;
  text-transform: uppercase;
}

.contact-block {
  display: flex;
  flex-direction: column;
  gap: 2mm;
}

.contact-item {
  display: flex;
  align-items: flex-start;
  gap: 2mm;
  font-size: 8.2pt;
  color: rgba(255, 255, 255, 0.82);
  line-height: 1.35;
}

.contact-item .icon {
  color: var(--accent);
  flex-shrink: 0;
}
.contact-item a {
  color: rgba(255, 255, 255, 0.82);
  text-decoration: none;
}
.contact-item a:hover {
  text-decoration: underline;
}

.sidebar-section {
  display: flex;
  flex-direction: column;
  gap: 2.5mm;
}

.sidebar-label {
  font-size: 6.5pt;
  font-weight: 600;
  color: var(--accent);
  letter-spacing: 0.18em;
  text-transform: uppercase;
  padding-bottom: 1.5mm;
  border-bottom: 1px solid var(--slate-light);
}

.skill-group {
  margin-bottom: 2mm;
}

.skill-group-name {
  font-size: 8.2pt;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 1.2mm;
}

.skill-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 1.2mm;
}

.tag {
  display: inline-block;
  background: rgba(127, 179, 211, 0.15);
  border: 1px solid rgba(127, 179, 211, 0.3);
  color: rgba(255, 255, 255, 0.82);
  font-size: 7.8pt;
  padding: 0.8mm 2mm;
  border-radius: 2px;
  line-height: 1.3;
}

.tag-highlight {
  display: inline-block;
  background: rgba(127, 179, 211, 0.28);
  border: 1px solid rgba(127, 179, 211, 0.55);
  color: white;
  font-size: 7.8pt;
  font-weight: 600;
  padding: 0.8mm 2mm;
  border-radius: 2px;
  line-height: 1.3;
}

.lang-item {
  font-size: 8.5pt;
  color: rgba(255, 255, 255, 0.82);
}
.lang-item span {
  color: var(--accent);
  font-weight: 600;
}

.soft-item {
  font-size: 8.2pt;
  color: rgba(255, 255, 255, 0.75);
  padding-left: 3mm;
  position: relative;
}

.soft-item::before {
  content: '—';
  position: absolute;
  left: 0;
  color: var(--accent);
}

/* ── MAIN ── */
.main {
  background: white;
  padding: 8mm 9mm 8mm 8mm;
  display: flex;
  flex-direction: column;
  gap: 4.5mm;
}

.summary-block {
  background: var(--bg);
  border-left: 3px solid var(--accent);
  padding: 3mm 4mm;
  font-size: 9pt;
  color: var(--text-soft);
  line-height: 1.55;
  border-radius: 0 3px 3px 0;
}

.summary-block strong {
  color: var(--slate);
  font-weight: 600;
}

.section {
  display: flex;
  flex-direction: column;
  gap: 2.8mm;
}

.section-title {
  font-size: 6.5pt;
  font-weight: 600;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--slate-light);
  padding-bottom: 1.5mm;
  border-bottom: 1.5px solid var(--rule);
}

.entry {
  display: flex;
  flex-direction: column;
  gap: 1mm;
}

.entry-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 2mm;
}

.entry-title {
  font-family: 'DM Serif Display', serif;
  font-size: 9.5pt;
  color: var(--slate);
  line-height: 1.15;
}

.entry-company {
  font-size: 8.5pt;
  font-weight: 600;
  color: var(--slate-mid);
}

.entry-date {
  font-size: 7.8pt;
  color: var(--slate-light);
  font-weight: 500;
  white-space: nowrap;
  background: var(--bg);
  padding: 0.6mm 1.8mm;
  border-radius: 2px;
  flex-shrink: 0;
}

.entry-meta {
  font-size: 8.2pt;
  color: var(--text-soft);
  font-style: italic;
}

.bullet-list {
  display: flex;
  flex-direction: column;
  gap: 0.9mm;
  padding-left: 4mm;
}

.bullet-list li {
  font-size: 8.8pt;
  color: var(--text-soft);
  list-style: disc;
  padding-left: 1mm;
  line-height: 1.4;
}

.bullet-list li::marker {
  color: var(--accent);
  font-size: 10pt;
}

.bullet-list li strong {
  color: var(--slate);
  font-weight: 600;
}

.edu-row {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  gap: 2mm;
}

.edu-title {
  font-weight: 600;
  font-size: 9pt;
  color: var(--slate);
}
.edu-center {
  font-size: 8.5pt;
  color: var(--slate-mid);
}
.edu-date {
  font-size: 8pt;
  color: var(--slate-light);
  white-space: nowrap;
}

.projects-note {
  font-size: 8.2pt;
  color: var(--text-soft);
  font-style: italic;
}
.github-link {
  color: var(--slate-light);
  font-weight: 600;
  font-style: normal;
}
</style>
