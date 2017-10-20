$(document).on 'turbolinks:load', ->
  showForm = (elem, formClass) ->
    $(elem).parent().prev().find(formClass).show()
    $(elem).parent().prev().find(formClass + ' textarea').first().focus()
    $(elem).parent().hide()
    return

  hideForm = (elem, formClass) ->
    $(elem).closest(formClass).hide()
    $(elem).closest('.forms').next().show()
    return

  $('.input-group textarea').each(->
    @setAttribute 'style', 'min-height:34px;height:34px;overflow-y:hidden;'
    return
  ).on 'input', ->
    @style.height = '0px'
    @style.height = @scrollHeight + 2 + 'px'
    return

  $('.show-new-form').click ->
    showForm this, '.new-form'
    return

  $('.show-edit-form').click ->
    showForm this, '.edit-form'
    $(this).parent().prevAll('.text:first').hide()
    $('textarea').trigger 'input'
    return

  $('.new-form textarea').blur ->
    if $(this).val() == ''
      hideForm this, '.new-form'
    return

  $('.hide-edit-form').click ->
    hideForm this, '.edit-form'
    $(this).closest('.forms').prevAll('.text:first').show()
    $(this).closest('.edit-form')[0].reset()
    return
  return
