document.addEventListener('DOMContentLoaded', function () {
  var menuButton = document.querySelector('.menu-button');
  var navigation = document.querySelector('.site-navigation');

  if (menuButton && navigation) {
    menuButton.addEventListener('click', function () {
      var open = navigation.classList.toggle('is-open');
      menuButton.setAttribute('aria-expanded', String(open));
    });
  }

  var form = document.querySelector('.mandala-editor');
  if (!form || !window.localStorage) return;

  var draftKey = form.dataset.localDraftKey;
  var notice = form.querySelector('.local-draft-notice');
  var fields = Array.prototype.slice.call(form.querySelectorAll('input[type="text"]'));

  function formData() {
    return fields.reduce(function (data, field) {
      data[field.name] = field.value;
      return data;
    }, {});
  }

  function saveDraft() {
    localStorage.setItem(draftKey, JSON.stringify({ updatedAt: Date.now(), data: formData() }));
  }

  try {
    var stored = JSON.parse(localStorage.getItem(draftKey));
    if (stored && stored.updatedAt > Number(form.dataset.updatedAt) * 1000 && stored.data) {
      fields.forEach(function (field) {
        if (Object.prototype.hasOwnProperty.call(stored.data, field.name)) field.value = stored.data[field.name];
      });
      notice.textContent = 'このブラウザに保存された、より新しい下書きを復元しました。';
      notice.hidden = false;
    }
  } catch (error) {
    localStorage.removeItem(draftKey);
  }

  fields.forEach(function (field) { field.addEventListener('input', saveDraft); });
  form.addEventListener('submit', saveDraft);

  var downloadButton = form.querySelector('[data-download-backup]');
  if (downloadButton) {
    downloadButton.addEventListener('click', function () {
      var goal = formData().goal || 'mandala-note';
      var backup = { format: 'mandala-note', version: 1, exportedAt: new Date().toISOString(), data: formData() };
      var blob = new Blob([JSON.stringify(backup, null, 2)], { type: 'application/json' });
      var link = document.createElement('a');
      link.href = URL.createObjectURL(blob);
      link.download = goal.replace(/[\\/:*?"<>|]/g, '_').slice(0, 60) + '.mandala.json';
      document.body.appendChild(link);
      link.click();
      link.remove();
      URL.revokeObjectURL(link.href);
    });
  }

  var printButton = form.querySelector('[data-print-mandala]');
  if (printButton) printButton.addEventListener('click', function () { window.print(); });
});
