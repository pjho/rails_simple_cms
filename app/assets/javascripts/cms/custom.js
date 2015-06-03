(function($) {
  $(document).ready( function(){   


  $('a.add-row').on('click', function(){
    var table    = $(this).parent().prev(),
        template = table.find('tr').last(),
        newrow   = template.clone();

    $(newrow).find('input').val('');
    $(newrow).insertAfter(template);
  });

  $('table.menu-table').on('click', 'a.del-row', function(){
    $(this).parents('tr').remove();
  });



  });
})(jQuery);


