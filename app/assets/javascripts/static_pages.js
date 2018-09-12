$(document).ready(function() {
  var listA = $('.profile-usermenu ul li a');
  $(listA).filter(function() {
    let currentLoca = location.origin + "/" + location.pathname.split("/")[1];
    return this.href == currentLoca;
  }).parents().addClass('active').siblings().removeClass('active');

  $(listA).on('click', function(event) {
    $(this).parent().addClass('active').siblings().removeClass('active');
  });
});
