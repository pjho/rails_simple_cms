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

  initToolbarBootstrapBindings();  

  var scmsEditor = $("#scmsEditor");
  var editorRaw = scmsEditor.parents('.tab-content').find('textarea.editor-raw');

  scmsEditor.wysiwyg({ fileUploadError: showErrorAlert});

  scmsEditor.wysiwyg().on('change', function() {
    editorRaw.val($(this).cleanHtml());
  });

  editorRaw.on('change', function() {
    scmsEditor.wysiwyg().val($(this).cleanHtml());
  });

});
