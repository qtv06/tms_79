$(document).on('turbolinks:load', function() {
  $('body').on('click', '.add-member', function(event) {
    var listCB = $('.user-remaining');
    var usersChecked = [];
    var courseId = $('#course-id').val();
    listCB.each(function(index, el) {
      if(el.checked){
        var idUser = $(el).parent().parent().find('input[type="hidden"]').val();
        usersChecked.push(idUser);
      }
    });
    if(usersChecked.length == 0){
      alert(I18n.t("alert.dont_chose_member"));
    }else{
      $.ajax({
        url: '/courses/add_member',
        type: 'GET',
        data: {
          usersChecked: usersChecked,
          courseId: courseId
        },
        success: function(data) {
          if(data.status == 404){
            alert(I18n.t("flash.course.not_found"));
          }else if(data.status == 403){
            alert(I18n.t("alert.user_not_exit"));
          }else{
            alert(I18n.t("flash.course.add_member_succ"));
          }
        }
      });
    }
  });

  $('body').on('click', '.add-subject', function(event) {
    var listSubject = $('.subject-remaining');
    var subjectsChecked = [];
    var courseId = $('#course-id').val();
    listSubject.each(function(index, el) {
      if(el.checked) {
        console.log(el);
        var idSubject = $(el).parent().parent().find('input[type="hidden"]').val();
        subjectsChecked.push(idSubject);
      }
    });

    if(subjectsChecked.length == 0) {
      alert(I18n.t("alert.dont_chose_member"));
    }else{
      $.ajax({
        url: '/courses/add_subject',
        type: 'GET',
        data: {
          subjectsId: subjectsChecked,
          courseId: courseId
        },
        success: function(data) {
          if(data.status == 404){
            alert(I18n.t("flash.course.not_found"));
          }else if(data.status == 403) {
            alert(I18n.t("alert.subject_not_exit"));
          }else{
            alert(I18n.t("flash.course.add_subject_succ"));
          }
        }
      });
    }
  });

  $('body').on('click', '.show-content', function(event) {
    $(this).parent().find('.content-sub').toggleClass('hidden');
  });
});
