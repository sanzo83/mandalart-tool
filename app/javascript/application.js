// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const menuButton = document.querySelector(".menu-button")
  const navigation = document.querySelector(".site-navigation")

  if (menuButton && navigation) {
    menuButton.addEventListener("click", () => {
      const open = navigation.classList.toggle("is-open")
      menuButton.setAttribute("aria-expanded", String(open))
    })
  }

  const form = document.querySelector(".mandala-editor")
  if (!form || !window.localStorage) return

  const draftKey = form.dataset.localDraftKey
  const notice = form.querySelector(".local-draft-notice")
  const fields = Array.from(form.querySelectorAll('input[type="text"]'))

  const formData = () => Object.fromEntries(fields.map((field) => [field.name, field.value]))
  const saveDraft = () => localStorage.setItem(draftKey, JSON.stringify({ updatedAt: Date.now(), data: formData() }))

  try {
    const stored = JSON.parse(localStorage.getItem(draftKey))
    if (stored && stored.updatedAt > Number(form.dataset.updatedAt) * 1000 && stored.data) {
      fields.forEach((field) => {
        if (Object.prototype.hasOwnProperty.call(stored.data, field.name)) field.value = stored.data[field.name]
      })
      notice.textContent = "このブラウザに保存された、より新しい下書きを復元しました。"
      notice.hidden = false
    }
  } catch {
    localStorage.removeItem(draftKey)
  }

  fields.forEach((field) => field.addEventListener("input", saveDraft))
  form.addEventListener("submit", saveDraft)

  form.querySelector("[data-download-backup]")?.addEventListener("click", () => {
    const goal = formData().goal || "mandala-note"
    const backup = { format: "mandala-note", version: 1, exportedAt: new Date().toISOString(), data: formData() }
    const link = document.createElement("a")
    link.href = URL.createObjectURL(new Blob([JSON.stringify(backup, null, 2)], { type: "application/json" }))
    link.download = `${goal.replace(/[\\/:*?"<>|]/g, "_").slice(0, 60)}.mandala.json`
    document.body.appendChild(link)
    link.click()
    link.remove()
    URL.revokeObjectURL(link.href)
  })

  form.querySelector("[data-print-mandala]")?.addEventListener("click", () => window.print())
})
