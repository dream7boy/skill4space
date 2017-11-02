//= require jquery
//= require jquery_ujs
//= require jquery.slick
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require_tree .


// $('.your-class').slick({
//   infinite: true,
//   slidesToShow: 3,
//   slidesToScroll: 3
// });


 $('.slider-for').slick({
  slidesToShow: 1,
  slidesToScroll: 1,
  autoplay: true,
  autoplaySpeed: 3000,
  arrows: true,
  accessibility: true,
  fade: true,
  asNavFor: '.slider-nav',
});
$('.slider-nav').slick({
  slidesToShow: 3,
  slidesToScroll: 1,
  asNavFor: '.slider-for',
  dots: true,
  centerMode: true,
  focusOnSelect: true
});

// $('.multiple-item').slick({
//   infinite: true,
//   slidesToShow: 3,
//   slidesToScroll: 3
// });
 $('.slider-for-two').slick({
  slidesToShow: 1,
  slidesToScroll: 1,
  arrows: true,
  autoplay: true,
  autoplaySpeed: 4000,
  fade: true,
  asNavFor: '.slider-nav-two',
});
$('.slider-nav-two').slick({
  slidesToShow: 2,
  slidesToScroll: 1,
  asNavFor: '.slider-for-two',
  dots: true,
  centerMode: true,
  focusOnSelect: true,
});

// code for sweet alert
// var popup = $('#booking-submit-button').click(function(event) {
//   event.preventDefault();
//   swal('Success!', 'You have booked this space!', 'success');
// });

// $('.swal-button').unbind('click', function(){
//   ('#form-submit').click();
// });
// $('#booking-submit-button').click(function(event) {
// swal('Success!', 'You have booked this space!', 'success');
// $(this).unbind('click').click('.swal-button');
// };

$('#booking-submit-button').submit(function(event) {
  $form = $(event.currentTarget);
  event.preventDefault();
  swal('Confirm booking?', "", {
    buttons: true,
    success: true
  }).then(ok => {
    $form.find('[type="submit"]').get(0).disabled = false;
    if (!ok) return;

    swal('Thanks for booking!', "Proceed to chat...", {
      icon: "success",
      button: false,
    });

    $.post({
      url: $form.attr('action'),
      type: $form.attr('method'),
      data: $form.serialize(),
      success: data => {
        window.location.href = `/conversations/${data.conversation.id}`;
      },
      error: err => {
        console.log('Error', err);
      }
    });
  });
});





// $('#booking-submit-button').submit(function(event) {
//   $form = $(event.currentTarget);
//   event.preventDefault();
//   swal('Confirm booking?', "", {
//     buttons: true,
//     success: true
//   }).then(ok => {
//     $form.find('[type="submit"]').get(0).disabled = false;
//     if (!ok) return;

//     $.post({
//       url: $form.attr('action'),
//       type: $form.attr('method'),
//       data: $form.serialize(),
//       success: data => {
//         window.location.href = `/conversations/${data.conversation.id}`;
//       },
//       error: err => {
//         console.log('Error', err);
//       }
//     });
//   });
// });







  // $('.swal-button').click(
  //   // $('#booking-submit-button').unbind('click').click();
  //   var new_path = <%= conversations_path %>
  //   window.location.href = new_path
  //   );

// $(document).ready(function() {
// swal({
//   //Your code for swel
//   position: 'top-right',
//   type: 'success',
//   title: 'Your work has been saved',
//   showConfirmButton: false,
//   timer: 1500
//   },
//   function(){
//     var new_path = <%= conversations_path %>
//     window.location.href = new_path
// });

// $('#booking-submit-button').click(function(event) {
//   event.preventDefault(); // Prevent the page from redirecting
  // if ($(document).click(function(e) {

  // }))
  // Put the swal-code here
  // swal('Success!', 'You have booked this space!', 'success');
  // function() {
  //   var new_path = <%= conversations_path %>;
  //   document.location.href = new_path;
  // };
  // // $('#booking-submit-button').off();
  // $('.swal-button').on("click", '.swal-button', function() {
  // $('.swal-button').unbind('click').click('#form-submit');
     // var new_path = <%= conversations_path %>;
     // document.location.href = new_path;);
  // };)
  // $('.swal-button').unbind('click').click();
  // swal({
  // position: 'top-right',
  // type: 'success',
  // title: 'Your work has been saved',
  // showConfirmButton: false,
  // timer: 1500
  // });
// });

// $("button").click(function (e) {
//     $("div").fadeToggle("fast");
//     e.stopImmediatePropagation();
// });

// $(document).click(function (e) {
//     if($("div").is(":visible") && !$("div").is(e.target)) {
//         $("div").fadeOut("fast");
//     }
// });

// $("#booking-submit-button").submit(function(e) {
//   e.preventDefault();
//   // var nm_unit = $("#namaunit").val();
//   // var almtunit = $("#almtunit").val();
//   var form = this;

//   swal('Success!', function(isConfirm) {
//     if (isConfirm) {
//       form.submit();
//     }
//   });
// });


$('#book-start-date, #book-end-date').change(function(event) {
  const id = $(event.target).closest('form').attr('data-id');
  const end_date = $('#book-end-date').val();
  const start_date = $('#book-start-date').val();
  console.log(start_date, end_date);
  if (!start_date || !end_date) {
    return;
  }
  const start_date_arr = start_date.split('-');
  const start = new Date(start_date_arr[0], parseInt(start_date_arr[1]) - 1, start_date_arr[2]);
  const end_date_arr = end_date.split('-');
  const end = new Date(end_date_arr[0], parseInt(end_date_arr[1]) - 1, end_date_arr[2]);
  const days = (end - start) / (1000*60*60*24) + 1;
  const daily_price = $('#total-cost').data('price');
  if (days < 1) {
    event.preventDefault();
    alert('Error! Please make sure your end date is after your start date.');
    $('#total-cost').text('ERROR: Please make sure your end date is after your start date.');
    return;
  }

  fetch(`/spaces/${id}/check_availability?start_date=${start_date}&end_date=${end_date}`, {
    credentials: 'include'
  }).then(res => res.json()).then(body => {
    $('#booking-button').prop("disabled", !body.available);
    $('#booking-cash-button').prop("disabled", !body.available);
    if (body.available) {
      console.log('Book it now!');

    } else {
      console.log('Dates taken!')
    }
  });
});
