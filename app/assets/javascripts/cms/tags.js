$(document).on( 'page:change', function(){
    
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


    $("form.update-tag")
      .on('ajax:before', function(evt,data,status,xhr) { 
          $(this).find('.save-tag').toggleClass('btn-primary btn-default').val('saving');
      })
      .on("ajax:success", function(evt, data, status, xhr) {
          // console.log(data);
          $(this).find('.color-preview').css('background-color',data.color)
          $(this).find('.save-tag').toggleClass('btn-primary btn-default').val('save');
          // console.log('success')
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

});