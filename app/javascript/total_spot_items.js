document.addEventListener("turbo:load", function() {
    $('#sortable-list').sortable({
      axis: 'y',
      items: 'li',
      update: function(e, ui) {
        var sortedIds = $(this).sortable('toArray');
        
        var totalSpotItemId = ui.item.data('id');
        
        $.ajax({
          url: '/total_spot_items/' + totalSpotItemId + '/sort',
          type: 'PATCH',
          data: { sorted_ids: sortedIds },
          dataType: 'script',
          headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
          },
        });
      }
    });
  });
