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
  $('.comment-textarea').each(function () {
    this.setAttribute('style', 'min-height:34px;height:34px;overflow-y:hidden;');
  }).on('input', function () {
    this.style.height = '0px';
    this.style.height = (this.scrollHeight + 2) + 'px';
  });

  $('.show-new-comment-form').click(function() {
    let form = $(this).siblings('.new-comment-form').first();
    form.show();
    form.find('.new-comment-textarea').first().focus();
    $(this).siblings('.btn').andSelf().hide();
  });

  $('.show-edit-comment-form').click(function() {
    $(this).siblings('.comment-text').first().hide();
    $(this).siblings('.edit-comment-form').first().show();
    $('textarea').trigger('input');
    $(this).siblings('.btn').andSelf().hide();
  });

  $('.hide-edit-comment-form').click(function() {
    let form = $(this).parent();
    form.hide();
    form.siblings('.comment-text').show();
    form.siblings('.btn').show();
    form[0].reset();
  });

  $('.show-edit-answer-form').click(function() {
    $(this).siblings('.answer-text').first().hide();
    $(this).siblings('.edit-answer-form').first().show();
    $('textarea').trigger('input');
    $(this).siblings('.btn').andSelf().hide();
  });

  $('.hide-edit-answer-form').click(function() {
    let form = $(this).parent();
    form.hide();
    form.siblings('.answer-text').show();
    form.siblings('.btn').show();
    form[0].reset();
  });

  $('.new-comment-textarea').blur(function() {
    if($(this).val() == '') {
      let form = $(this).parent().parent();
      form.hide();
      form.siblings('.btn').show();
    }
  });
});
