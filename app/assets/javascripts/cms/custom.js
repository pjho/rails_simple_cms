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
  });
})(jQuery);