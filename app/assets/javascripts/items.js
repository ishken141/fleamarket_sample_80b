$(function() {

    // 画像用のinputを生成する関数
    const buildFileField = (num)=> {
      const html = `<div data-index="${num}" class="js-file_group">
                      <input class="js-file" type="file"
                      name="item[images_attributes][${num}][image]"
                      id="item_images_attributes_${num}_image">
                    </div>`;
      return html;
    }
    // プレビュー用のimgタグを生成する関数
    const buildImg = (index, url)=> {
      const html = `<div class="preview__item" data-index="${index}">
                      <i class="fas fa-times-circle js-remove"></i>
                      <img data-index="${index}" src="${url}" width="100px" height="100px">
                    </div>`;
      return html;
    }

  // file_fieldのnameに動的なindexをつける為の配列
  // let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  let fileIndex = [...Array(100).keys()].map(i => ++i)
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  firstIndex = $(".js-file_group:first").data("index");
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();


  // カメラをクリックで画像選択
  $(document).on("click", ".triggericon", function(){
    let file_field = $(".js-file:last");
    file_field.trigger("click");
  })

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      // $('#previews').append(buildImg(targetIndex, blobUrl));
      $(".triggericon").before(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      let imglength = $("#previews").children().length;
      $(".js-remove").click(function() {
        $(".triggericon").show();
      });
      $('#image-box').append(buildFileField(fileIndex[0]));
      if (imglength == 11) {
        $(".triggericon").hide();
      }
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  });

  let imglength = $("#previews").children().length;
  if (imglength == 11) {
    $(".triggericon").hide();
  }

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();
    $(`div[data-index="${targetIndex}"]`).remove();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));

    let imglength = $("#previews").children().length;
    $(".triggericon").show();
    if (imglength == 11) {
      $(".triggericon").hide();
    }
  });

  // items#show
  $('.slider-5-thum').slick({
    arrows: true,
    asNavFor:'.slider-5-nav',
    slidesToShow: 1,
    fade: true,
  });
  $('.slider-5-nav').slick({
    autoplay: true,
    asNavFor:'.slider-5-thum',
    focusOnSelect: true,
    slidesToShow: 3,
    slidesToScroll: 1,
    centerMode: true,
  });
});

// $(document).ready(function(){
//   $('.sortable').sortable();
// });

// 販売手数料の記述
$(function(){
  function Delivery(delivery) {
    $(".shippingfee-span").text(delivery.price)
    $("#item_price").on('keyup', function(){
      var price = $("#item_price").val();
      if( 300 <= price && price <= 9999999) {
        var fee = Math.floor(price * 0.03);
        // var delivery = {delivery.price};
        var profit = (price - fee - delivery.price);
        $(".fee-span").text(`¥ ${fee}`);
        $(".profit-span").text(`¥ ${profit}`);
        $(".shippingfee-span").text(delivery.price);
      }else{
        $(".fee-span").text('');
        $(".profit-span").text('');
      }
    })
  }
  $("#item_delivery_id").change(function () {
    let delivery_id = $(this).val();
    if (delivery_id != "") {
      $.ajax({
        url:      "get_delivery_fee",
        dateType: "JSON",
        type:     "GET",
        data:     { delivery_id: delivery_id}
      })
      .done(function(delivery) {
        return Delivery(delivery);
        // $(".shippingfee-span").text(`¥ ${delivery.price}`)
      })
      .fail(function() {
        alert("失敗しました")
      });
    } else {
      $(".shippingfee-span").text("");
    }
  })
});


  //DropzoneJS snippet - js
    // instantiate the uploader
  // $('#file-dropzone').dropzone({
  //   url: "/items",
  //   maxFilesize: 100,
  //   paramName: "uploadfile",
  //   maxThumbnailFilesize: 99999,
  //   previewsContainer: '.visualizacao',
  //   previewTemplate : $('.preview').html(),
  //   init: function() {
  //     this.on('completemultiple', function(file, json) {
  //       $('.sortable').sortable('enable');
  //     });
  //     this.on('success', function(file, json) {
  //       alert('aa');
  //     });

  //     this.on('addedfile', function(file) {

  //     });

  //     this.on('drop', function(file) {
  //       console.log('File',file)
  //     });
  //   }
  // });
  // $(document).ready(function() {});

