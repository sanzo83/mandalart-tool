document.addEventListener('DOMContentLoaded', function () {
  var button = document.querySelector('.menu-button');
  var navigation = document.querySelector('.site-navigation');
  if (!button || !navigation) return;
  button.addEventListener('click', function () {
    var open = navigation.classList.toggle('is-open');
    button.setAttribute('aria-expanded', String(open));
  });
});
