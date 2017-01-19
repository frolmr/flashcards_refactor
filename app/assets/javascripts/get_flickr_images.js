$(document).ready(function() {
  $('#search_images').on("ajax:complete", function() {
    $.ajax({
      data: { flickr_tag: $('#card_flickr_tag').val() },
      url: $(this).attr('href'),
      dataType: 'json',
      success: function(json) {
        images = json.list
        images.forEach(function(item, i , images) {
          $('<img />', {'src': item, 'class': "flickr_image"}).appendTo('#photos');
        })
      }
    });
  });
});
