class Page
  controller: () =>
    $('body').data('controller')
  action: () =>
    $('body').data('action')

@page = new Page
