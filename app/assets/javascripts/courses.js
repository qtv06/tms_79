$(document).ready(function() {
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

  $('body').on('click', '.btn-remove-trainee', function(event) {
    var userId = $(this).parent().find('input[type="hidden"]').val();
    var courseId = $('#course-id').val();

    $.ajax({
      url: '/courses/delete_member',
      type: 'get',
      data: {
        courseId: courseId,
        user_id: userId
      },
      success: function(data) {
        if(data.status == 404) {
          alert(I18n.t("flash.user_courses.not_found"));
        }
      }
    });
  });

  $('body').on('click', '.save-task', function(event) {
    var name = $('#task_name').val();
    var description = $('#task_description').val();
    if(name == "" && description == "") {
      alert(I18n.t("alert.fill_in"));
      return false;
    }
  });

  moment().format('MMMM Do YYYY');
  var subjects = gon.subjects;
  var mainTimeLine = $('.main-timeline');
  var numDay = 0;
  subjects.forEach(function(subject) {
    var dayLearnSubject = moment().add(numDay, 'days');
    var divTimeLine = $('<div></div>');
    $(divTimeLine).attr('class', 'timeline');

    var divTimeLineIcon = $('<div></div>');
    $(divTimeLineIcon).attr('class', 'timeline-icon');
    if(moment() > dayLearnSubject) {
      $(divTimeLineIcon).css('background', 'red');
    }
    $(divTimeLine).append(divTimeLineIcon);

    var divTimeLineContent = $('<div></div>');
    $(divTimeLineContent).attr('class', 'timeline-content');

    var spanDate = $('<span></span>');
    $(spanDate).attr('class', 'date');
    numDay += subject.duration;
    $(spanDate).text(dayLearnSubject.format('MMMM Do YYYY'));
    $(divTimeLineContent).append(spanDate);

    var title = $('<h5></h5>');
    $(title).attr('class', 'title');
    $(title).text(subject.name);
    $(divTimeLineContent).append(title);

    var pDesctiption = $('<p></p>');
    $(pDesctiption).attr('class', 'description');
    $(pDesctiption).text(subject.description);
    $(divTimeLineContent).append(pDesctiption);

    $(divTimeLine).append(divTimeLineContent);

    $(mainTimeLine).append(divTimeLine);
  });
});
