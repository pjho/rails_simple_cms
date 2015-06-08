(function($) {
  $(document).on('page:change', function () {

    // Adds new row to menus interface
    $('a.add-row').on('click', function(){
      var table    = $(this).parent().prev(),
          template = table.find('tr').last(),
          newrow   = template.clone();

      $(newrow).find('input').val('');
      $(newrow).insertAfter(template);
    });

    // Deletes row from menus interface
    $('table.menu-table').on('click', 'a.del-row', function(){
      $(this).parents('tr').remove();
    });

    // Dirty validation for forms that require admin password to save
    $('#current_admin_pass').closest('form').on('submit', function(){
        if( $(this).find('#current_admin_pass').val().length < 1 ){
          alert ("You must enter your current password to make changes.");
          return false;
        };
    });
  });
})(jQuery);
