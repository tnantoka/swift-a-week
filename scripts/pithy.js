function parseDate(date) {
  return new Date(Date.parse(date + ' 00:00:00 GMT+0900'));
}

$(function(){
    $("#gotop").click(function(){
        jQuery("html,body").animate({
            scrollTop:0
        }, 500);
    });
    $(window).load(function() {
		$('#gotop').hide();
    })
    
    $(window).scroll(function() {
        if ( $(this).scrollTop() > 300){
            $('#gotop').fadeIn("fast");
        } else {
            $('#gotop').stop().fadeOut("fast");
        }
    });

    $('[data-date]').each(function() {
      var $this = $(this);
      var current = parseDate($this.data('date'));
      var beginning = parseDate('Dec, 21, 2015');
      var week = Math.ceil(345600000 / 1000 / 60 / 60 / 24 / 7);
      var prefix = '[Week ' + week + '] ';
      $this.text(prefix);
      if ($this.data('title')) {
        document.title = prefix + document.title;
      }
    });
});
