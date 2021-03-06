$(function(){
  var dropzone = $('.dropzone-area');
  var dropzone2 = $('.dropzone-area2');
  var dropzone_box = $('.dropzone-box');
  var images = [];
  var inputs  =[];
  var input_area = $('.input_area');
  var preview = $('#preview');
  var preview2 = $('#preview2');

  //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    var file = $(this).prop('files')[0]; //propは指定した属性の値を取得する
    var reader = new FileReader(); //FileReaderは選択した画像を読み込むためのオブジェクト
    inputs.push($(this)); //inputタグを配列に入れて、後で画像を削除する時に使う
    var img = $(`<div class= "img_view"><img></div>`);
    reader.onload = function(e) { //onloadは画面の全要素を読み込み終えて初めてスクリプトが動き出す
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
      img.append(btn_wrapper); //img要素の一番後ろにbtn_wrapperを挿入する
      img.find('img').attr({ //img要素が指定された縦横比に置換される
        src: e.target.result,
        width: "120px",
        height: "140px",
      })
    }
    reader.readAsDataURL(file); //readAsDataURLに引数でファイルを渡してあげることでreader.onloadから先の関数が動く
    images.push(img); //imageを配列に入れて、後で画像を削除する時に使う

    if(images.length >= 5) {
      dropzone2.css({
        'display': 'block'
      })
      dropzone.css({
        'display': 'none'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index); //attrは指定した属性の値を取得
        preview2.append(image);
        dropzone2.css({
          'width': `calc(100% - (135px * ${images.length - 5}))`
        })
      })
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    } else {
        $('#preview').empty(); //emptyは要素内の子要素(テキストも対象)を全て削除
        $.each(images, function(index, image) {
          image.attr('data-image', index); //attrは指定した属性の値を取得
          preview.append(image);
        })
        dropzone.css({
          'width': `calc(100% - (135px * ${images.length}))`
        })
      }
      if(images.length == 4) {
        dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    if(images.length == 10) {
      dropzone2.css({
        'display': 'none'
      })
      return;
    }
    var new_image = $(`<input multiple= "multiple" name="images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
    input_area.append(new_image);
  });
  // 削除ボタンを押すと発火
  $(document).on('click', '.delete', function() {
    var target_image = $(this).parent().parent(); //削除ボタンの親の親要素（data-image）を変数target_imageに代入
    $.each(inputs, function(index, input){
      if ($(this).data('image') == target_image.data('image')){
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
        inputs.splice(num, 1);
        if(inputs.length == 0) {
          $('input[type= "file"].upload-image').attr({
            'data-image': 0
          })
        }
      }
    })
    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
    })
    $.each(inputs, function(index, input) {
      var input = $(this)
      input.attr({
        'data-image': index
      })
      $('input[type= "file"].upload-image:first').after(input)
    })
    if (images.length >= 5) {
      dropzone2.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
      })
      dropzone2.css({
        'width': `calc(100% - (135px * ${images.length - 5}))`
      })
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    } else {
      dropzone.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (135px * ${images.length}))`
      })
    }
    if(images.length == 4) {
      dropzone2.css({
        'display': 'none'
      })
    }
  })
});

$(function(){
  $("#postage").click(function() { //配送料の負担がクリックされたら発火
    $(".shipping_method").fadeIn();
  });
});