$(document).on 'turbolinks:load', ->
  $('#answers').on 'submit', '#new_answer', ->
    $('#new_answer > fieldset').prop('disabled', true)

  $('#answers').on 'submit', '.edit-form', ->
    $(this).find('> fieldset').prop('disabled', true)

  $('#answers').on 'submit', '.delete-form', ->
    $(this).closest('fieldset').prop('disabled', true)
