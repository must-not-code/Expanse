$(document).ready(function() {
  $('#contact').submit(function(e) {
    e.preventDefault();

    $.ajax({
      type: 'POST',
      url: $('#contact').attr('action'),
      data: $('#contact').serialize()
    })
    .done(function(data) {
      $('#form').empty();
      $('#form').text(data);
    })
    .fail(function(data) {
      $('#error').text(data.responseText);
    });
  });

  $('#modal-contact').submit(function(e) {
    e.preventDefault();

    $.ajax({
      type: 'POST',
      url: $('#modal-contact').attr('action'),
      data: $('#modal-contact').serialize()
    })
    .done(function(data) {
      $('#modal-body').html('<h1 class="text-dark">' + data + '</h1>');
    })
    .fail(function(data) {
      $('#modal-error').text(data.responseText);
    });
  });

  $('#film').on('click', function(ev) {
    ev.preventDefault();
    $('#film').attr('style', 'display: none !important');
    $('#youtube')[0].src += '&autoplay=1';
    $('#embed').show();
    $(document).scrollTop( $("#embed").offset().top );
    $('#youtube').click()
  });
});
