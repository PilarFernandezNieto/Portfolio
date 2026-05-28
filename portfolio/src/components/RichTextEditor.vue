<script setup>
import { useEditor, EditorContent } from '@tiptap/vue-3'
import StarterKit from '@tiptap/starter-kit'
import { watch } from 'vue'

const props = defineProps({
  modelValue: { type: String, default: '' },
})

const emit = defineEmits(['update:modelValue'])

const editor = useEditor({
  content: props.modelValue,
  extensions: [StarterKit],
  onUpdate({ editor }) {
    emit('update:modelValue', editor.getHTML())
  },
})

watch(
  () => props.modelValue,
  (value) => {
    if (editor.value && editor.value.getHTML() !== value) {
      editor.value.commands.setContent(value, false)
    }
  },
)
</script>

<template>
  <div
    class="border border-stone-200 rounded overflow-hidden focus-within:border-slate-400 transition-colors"
  >
    <div class="flex flex-wrap gap-1 border-b border-stone-200 bg-stone-50 px-3 py-2">
      <button
        type="button"
        @click="editor.chain().focus().toggleBold().run()"
        :class="
          editor?.isActive('bold')
            ? 'bg-slate-200 text-slate-900'
            : 'text-slate-500 hover:text-slate-800 hover:bg-slate-100'
        "
        class="w-8 h-8 flex items-center justify-center text-sm font-bold rounded transition-colors"
        title="Negrita"
      >
        B
      </button>

      <button
        type="button"
        @click="editor.chain().focus().toggleItalic().run()"
        :class="
          editor?.isActive('italic')
            ? 'bg-slate-200 text-slate-900'
            : 'text-slate-500 hover:text-slate-800 hover:bg-slate-100'
        "
        class="w-8 h-8 flex items-center justify-center text-sm italic rounded transition-colors"
        title="Cursiva"
      >
        I
      </button>

      <div class="w-px bg-stone-200 mx-1"></div>

      <button
        type="button"
        @click="editor.chain().focus().toggleHeading({ level: 2 }).run()"
        :class="
          editor?.isActive('heading', { level: 2 })
            ? 'bg-slate-200 text-slate-900'
            : 'text-slate-500 hover:text-slate-800 hover:bg-slate-100'
        "
        class="w-8 h-8 flex items-center justify-center text-xs font-bold rounded transition-colors"
        title="Encabezado"
      >
        H2
      </button>

      <button
        type="button"
        @click="editor.chain().focus().toggleHeading({ level: 3 }).run()"
        :class="
          editor?.isActive('heading', { level: 3 })
            ? 'bg-slate-200 text-slate-900'
            : 'text-slate-500 hover:text-slate-800 hover:bg-slate-100'
        "
        class="w-8 h-8 flex items-center justify-center text-xs font-bold rounded transition-colors"
        title="Subencabezado"
      >
        H3
      </button>

      <div class="w-px bg-stone-200 mx-1"></div>

      <button
        type="button"
        @click="editor.chain().focus().toggleBulletList().run()"
        :class="
          editor?.isActive('bulletList')
            ? 'bg-slate-200 text-slate-900'
            : 'text-slate-500 hover:text-slate-800 hover:bg-slate-100'
        "
        class="w-8 h-8 flex items-center justify-center text-sm rounded transition-colors"
        title="Lista"
      >
        <span class="material-symbols-outlined text-base">format_list_bulleted</span>
      </button>

      <button
        type="button"
        @click="editor.chain().focus().toggleOrderedList().run()"
        :class="
          editor?.isActive('orderedList')
            ? 'bg-slate-200 text-slate-900'
            : 'text-slate-500 hover:text-slate-800 hover:bg-slate-100'
        "
        class="w-8 h-8 flex items-center justify-center text-xs rounded transition-colors"
        title="Lista numerada"
      >
        <span class="material-symbols-outlined text-base">format_list_numbered</span>
      </button>

      <div class="w-px bg-stone-200 mx-1"></div>

      <button
        type="button"
        @click="editor.chain().focus().undo().run()"
        :disabled="!editor?.can().undo()"
        class="w-8 h-8 flex items-center justify-center text-sm text-slate-500 hover:text-slate-800 hover:bg-slate-100 disabled:opacity-30 rounded transition-colors"
        title="Deshacer"
      >
        ↩
      </button>

      <button
        type="button"
        @click="editor.chain().focus().redo().run()"
        :disabled="!editor?.can().redo()"
        class="w-8 h-8 flex items-center justify-center text-sm text-slate-500 hover:text-slate-800 hover:bg-slate-100 disabled:opacity-30 rounded transition-colors"
        title="Rehacer"
      >
        ↪
      </button>
    </div>

    <EditorContent
      :editor="editor"
      class="tiptap-editor px-4 py-3 min-h-48 font-sans text-sm text-slate-800"
    />
  </div>
</template>

<style scoped>
.tiptap-editor :deep(.tiptap) {
  outline: none;
  min-height: 12rem;
}
.tiptap-editor :deep(p) {
  margin-bottom: 0.5rem;
  line-height: 1.75;
}
.tiptap-editor :deep(p:last-child) {
  margin-bottom: 0;
}
.tiptap-editor :deep(h2) {
  font-size: 1.125rem;
  font-weight: 600;
  color: #1e293b;
  margin-top: 1rem;
  margin-bottom: 0.5rem;
}
.tiptap-editor :deep(h3) {
  font-size: 1rem;
  font-weight: 600;
  color: #1e293b;
  margin-top: 0.75rem;
  margin-bottom: 0.25rem;
}
.tiptap-editor :deep(ul) {
  list-style-type: disc;
  padding-left: 1.5rem;
  margin-bottom: 0.5rem;
}
.tiptap-editor :deep(ol) {
  list-style-type: decimal;
  padding-left: 1.5rem;
  margin-bottom: 0.5rem;
}
.tiptap-editor :deep(li) {
  margin-bottom: 0.125rem;
}
.tiptap-editor :deep(li p) {
  margin-bottom: 0;
}
.tiptap-editor :deep(strong) {
  font-weight: 700;
}
.tiptap-editor :deep(em) {
  font-style: italic;
}
</style>
