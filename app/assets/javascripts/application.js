// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function() {
  $('.forms textarea').each(function () {
    this.setAttribute('style', 'min-height:34px;height:34px;overflow-y:hidden;');
  }).on('input', function () {
    this.style.height = '0px';
    this.style.height = (this.scrollHeight + 2) + 'px';
  });

  $('.show-new-form').click(function() {
    showForm(this, '.new-form');
  });

  $('.show-edit-form').click(function() {
    showForm(this, '.edit-form');
    $('textarea').trigger('input');
  });

  $('.new-form textarea').blur(function() {
    if($(this).val() == '') {
      hideForm(this, '.new-form');
    }
  });

  $('.hide-edit-form').click(function() {
    hideForm(this, '.edit-form');
    $(this).closest('.edit-form')[0].reset();
  });

  $('.toggle-comments').click(function() {
    hideComments(this);
  });

  $('.toggle-comment').click(function() {
    hideComments(this);
  });

  function showForm(elem, formClass) {
    $(elem).parent().prev().find(formClass).show();
    $(elem).parent().prev().find(formClass + ' textarea').first().focus();
    $(elem).parent().hide();
  }

  function hideForm(elem, formClass) {
    $(elem).closest(formClass).hide();
    $(elem).closest('.forms').next().show();
  }

  function hideComments(elem) {
    $(elem).next().slideToggle();
    $(elem).next().find('.comment').slideUp();
  }
});
