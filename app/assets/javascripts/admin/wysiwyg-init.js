$(function() {
    
  function initToolbarBootstrapBindings() {
        
    $('a[title]').tooltip({container:'body'});

    $('.dropdown-menu input').click(function() {return false;})
      .change(function () {
        $(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');
      }).keydown('esc', function () {
         this.value='';$(this).change();
      });

    $('[data-role=magic-overlay]').each(function () { 
      var overlay = $(this), target = $(overlay.data('target')); 
      overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
    });
    
  };

function showErrorAlert (reason, detail) {
  var msg='';
  if (reason==='unsupported-file-type') {
    msg = "Unsupported format " + detail;
  } else {
    console.log("error uploading file", reason, detail);
  }

  $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'+ 
    '<strong>File upload error</strong> '+msg+' </div>').prependTo('#alerts');
};

initToolbarBootstrapBindings();  

$('#editor').wysiwyg({ fileUploadError: showErrorAlert} );


$('#editor').wysiwyg().on('change', function() {
  $('#page_content').val($(this).cleanHtml());
});


});
