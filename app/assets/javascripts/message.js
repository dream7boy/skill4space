$(function(){
  function buildMESSAGE(message) {
    // const newmessage = $(`
    //   <div class="message-wrapper" data-receipt-id=${message.receipt_id}>
    //     <div class="sender-profile">
    //       <img class="profile-avatar" src="http://res.cloudinary.com/dlzzsx5ex/image/upload/${message.sender_photo.path}" >
    //     </div>
    //     <div class="message-body">
    //      <p>FROM: ${message.sender_name} <span>on ${message.created}</span></p>
    //       <p>${message.body}</p>
    //     </div>
    //   </div>`).hide()

    const messages = $('#message-container').append(newmessage);
    newmessage.slideDown();
    //'tbody'に'tr'以下のhtml全てをappendする
  }

  // $(function(){
  //   setInterval(update, 1000);
  //   //1000ミリ秒ごとにupdateという関数を実行する
  // });
  function update(){ //この関数では以下のことを行う
    if($('.message-wrapper')[0]){ //もし'messages'というクラスがあったら
      var receipt_id = $('.message-wrapper:last').data('receipt-id'); //一番最後にある'messages'というクラスの'id'というデータ属性を取得し、'message_id'という変数に代入
    } else { //ない場合は
      var receipt_id = 0; //0を代入
    }
    $.ajax({ //ajax通信で以下のことを行う
      url: location.href, //urlは現在のページを指定
      type: 'GET', //メソッドを指定
      data: { //railsに引き渡すデータは
        receipt: { id: receipt_id } //このような形(paramsの形をしています)で、'id'には'message_id'を入れる
      },
      dataType: 'json' //データはjson形式
      // dataType: 'text/javascript' //データはjs形式
    })
    .always(function(data){ //通信したら、成功しようがしまいが受け取ったデータ（@new_message)を引数にとって以下のことを行う
      $.each(data, function(i, data){ //'data'を'data'に代入してeachで回す
        // buildMESSAGE(data.new_messages); //buildMESSAGEを呼び出す
        console.log(data); //buildMESSAGEを呼び出す
      });
      setTimeout(update, 5000);
    });
  }
  update();
});

