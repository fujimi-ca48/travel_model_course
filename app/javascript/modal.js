$(function() {
    var open = $('.modal-open'),
      close = $('.modal-close'),
      container = $('.modal-container');
  
    open.on('click', function() { 
      container.addClass('active');
      return false;
    });
  
    close.on('click', function() {  
      container.removeClass('active');
    });
  
    $(document).on('click', function(e) {
      if (!$(e.target).closest('.modal-body').length) {
        container.removeClass('active');
      }
    });
  
    // URLパラメータの取得
    const queryParams = new URLSearchParams(window.location.search);
    if (queryParams.get('show_modal') === 'true') {
      // 3秒後にモーダルを表示
      setTimeout(function() {
        openModal();
      }, 5000); // 3秒（3000ミリ秒）遅延
    }
  
    // モーダルの表示関数
    function openModal() {
      $('.modal-container').addClass('active');
    }
  });
  
  document.getElementById('createModelCourseButton').addEventListener('click', function () {
    // 新規作成画面に遷移し、3秒後にモーダルを表示する
    window.location.href = '/model_courses?show_modal=true';
  });
