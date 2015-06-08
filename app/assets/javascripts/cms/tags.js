$(document).on( 'page:change', function(){
    
    // Ajax for deleting a tag
    $("a.delete-tag")
      .on('ajax:before', function(evt,data,status,xhr) {
          if ( ! confirm("Do you want to delete this tag?\nThis will also remove the tag from all associated posts.") ) {
            return false;
          };
      })
      .on("ajax:success", function(evt, data, status, xhr) {
        var row = $(this).closest('.tag-edit-form');
        row.css('background-color','#C9302C').fadeOut('slow', function(){
          this.remove();
        });
      })
      .on("ajax:error", function(evt, data, status, xhr) {
        alert("There was a problem deleting this tag.")
      });

    // Ajax for updating a tag
    $("form.update-tag")
      .on('ajax:before', function(evt,data,status,xhr) {
          $(this).find('.save-tag').toggleClass('btn-primary btn-default').val('saving');
      })
      .on("ajax:success", function(evt, data, status, xhr) {
          $(this).find('.color-preview').css('background-color',data.color)
          color = $(this).find('.tag-color-input');
          colorV = color.val();
          color.val(colorV.toUpperCase());
          $(this).find('.save-tag').toggleClass('btn-primary btn-default').val('save');
      })
      .on("ajax:error", function(evt, data, status, xhr) {
          $(this).find('.save-tag').toggleClass('btn-primary btn-default').val('save'); // eek the repetition
          var errors = "There were errors in you submission."
          for( var error in data.responseJSON ){
            if (data.responseJSON.hasOwnProperty(error)) {
              errors += "\n" + data.responseJSON[error];
            }
          }
          alert(errors);
      });

    // Ajax for Generate Tag Stylesheet
    $(".tags-recompile")
      .on('ajax:before', function(evt,data,status,xhr) {
          $(this).text('generating...').toggleClass('btn-warning btn-default');
      })
      .on("ajax:success", function(evt, data, status, xhr) {
          $(this).text('Recompile Stylesheets').toggleClass('btn-warning btn-default');
          alert("Tag Stylesheets successfully regenerated.")
      })
      .on("ajax:error", function(evt, data, status, xhr) {
          $(this).text('Recompile Stylesheets').toggleClass('btn-warning btn-default');
          alert("There was a problem updating the stylesheets. Please try again.");
      });

    // Ajax to remove tags from post
    $(".tag-remove")
      .on('ajax:before', function(evt,data,status,xhr) {
          $(this).text('(-)');
      })
      .on("ajax:success", function(evt, data, status, xhr) {
        $(this).prev().fadeOut('slow');
        $(this).fadeOut('slow');
      })
      .on("ajax:error", function(evt, data, status, xhr) {
          $(this).text('(x)');
          alert("There was a problem removing the tag.");
      });
});
