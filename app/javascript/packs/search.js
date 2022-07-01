/*global $*/
$(document).on('turbolinks:load', function() {
  // search__wordが入力されたときに発火
  $(document).on('input', '.search__word', function(){
    // tbodyの中身を一度空にする
    $('.scroll__tbody').html('');
    // 検索ワードの取得
    const keyword = $(this).val();
    const model = 'source';
    const method = 'all';
    // #indexにajax通信
    $.ajax({
      type: 'GET',
      url: '/search',
      data: {keyword: keyword, method: method, model: model},
      dataType: 'json'
    })
    .done(function(data){
      // 返ってきたdataに対して処理を実行
      const html = `
      
      <tr>
        <td class='scroll__td'>${data.purpose}</td>
      </tr>
      
      `;
      $('.scroll__tbody').prepend(html);
      
    })
  });
});