$(function(){
  function buildHTML(comment){  
    console.log(comment)
    var html = `
    <div class="MessageInfo__userimage"> 
    <img src="${comment.image}" width="50px" height="50px" style="border-radius: 50%;">  
    </div>
    <div class="MessageBox">
<div class="Message">
<h1>${comment.text}</h1>
</div>
<div class="MessageInfo">
<div class="MessageInfo__userName">
<p>${comment.user_name}</p>
</div>
</div> 
</div> 
`
  return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({ 
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){ 
      var html = buildHTML(data); 
      $('.MessageField').append(html); 
      $('.form-area').val('');
      $('.submit').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
});
