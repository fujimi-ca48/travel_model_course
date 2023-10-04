$(function(){
    var open = $('.modal-open'),
      close = $('.modal-close'),
      container = $('.modal-container');

    open.on('click',function(){ 
      container.addClass('active');
      return false;
    });

    close.on('click',function(){  
      container.removeClass('active');
    });

    $(document).on('click',function(e) {
      if(!$(e.target).closest('.modal-body').length) {
        container.removeClass('active');
      }
    });
  });
  
  $(function(){
    function openModal() {
      $('.modal-container').addClass('active');
    }

  const queryParams = new URLSearchParams(window.location.search);
  if (queryParams.get('show_modal') === 'true') {
    openModal();
  }
  });

document.getElementById('createModelCourseButton').addEventListener('click', function () {
    window.location.href = '/model_courses?show_modal=true';
  });
