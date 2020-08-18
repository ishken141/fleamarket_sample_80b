// $(function() {
//   Payjp.setPublicKey('pk_test_31d4180a73af244259d7daf0');
//   $("#charge_form").on('click', function(e) {
//     // 「追加する」のクリックイベントが行われた時に動作を一時停止
//     e.preventDefault();
//     var year = $("#exp_year").val()
//     var month = $("#exp_month").val()
//     exp_year = String(year);
//     exp_month = String(month);
//     // カード登録に入力された情報をハッシュで格納
//     let card = {
//       number: $("#number").val(),
//       cvc: $("#cvc").val(),
//       exp_month: exp_month,
//       exp_year: exp_year
//     };

//     // PAY.JPのサーバーと通信し、カード情報を送信することで認証を行い、カードトークンをresponse.idで受け取る。
//     Payjp.createToken(card, function(status, response){
//       // サーバーとのやり取りが200=正常に行えた場合(?)
//       if (status === 200) {
//         $("#all-form").append(
//           $('<input type="hidden" name="payjp-token">').val(response.id)
//         );
//         // all-formはform_withのidであり、createアクションにparamsを送信する
//         $('#all-form').submit();
//       } else {
//         alert("カード情報が正しくありません。");
//       }
//     });
//   });
// });

document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_31d4180a73af244259d7daf0"); //ここに公開鍵を直書き
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得されます
      btn.addEventListener("click", e => { //ボタンが押されたときに作動します
        e.preventDefault(); //ボタンを一旦無効化します
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        }; //入力されたデータを取得します。
        Payjp.createToken(card, (status, response) => {
          if (status === 200) { //成功した場合
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            ); //取得したトークンを送信できる状態にします
            document.inputForm.submit();
            alert("登録が完了しました"); //確認用
          } else {
            alert("カード情報が正しくありません。"); //確認用
          }
        });
      });
    }
  },
  false
);