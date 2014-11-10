$( document ).ready(function() {
  $(".sidebar").click
});








$(document).on('page:change', function() {
  $(".sentence").click(function(event){
    $('.popup').remove()
    var sentence = $(this)
    fetchPopup(sentence.data('id'), function(template){
      sentence.after(template)
      listenForComment()
      popupClose()
    })
  })


})