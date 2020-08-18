$(function() {

  function appendOption(category) {
    let html = `<option value="${category.id}" data-category="${category.id}">
                  ${category.name}
                </option>`;
    return html;
  }

  function childrenBox(insertHtml) {
    var childrenHtml = ``;
    var childrenHtml = `<div class="catagory-children">
                          <select class="category" name="item[category_id]" id="child_category">
                            <option value="">選択してください</option>
                            ${insertHtml}
                          <select>
                        <div>`;
    $(".categorySelect").append(childrenHtml);
  }

  function grandChildrenBox(insertHtml) {
    var grandChildren = "";
    var grandChildren = `<div class="catagory-grandchildren">
                          <select class="category" name="item[category_id]" id="grandchild_category">
                            <option value="">選択してください</option>
                            ${insertHtml}
                          <select>
                        <div>`;
    $(".categorySelect").append(grandChildren);
  }

  function childrenAjax(parentId) {
    $.ajax({
      url: "get_category_children",
      type: "GET",
      data: { parent_id: parentId },
      dataType: "JSON",
    })
    .done(function(children) {
      $(".catagory-children").remove();
      $(".catagory-grandchildren").remove();
      let insertHtml = "";
      children.forEach(function(child) {
        insertHtml += appendOption(child);
      });
      childrenBox(insertHtml)
    })
    .fail(function() {
      alert("カテゴリーの取得に失敗しました")
    })
  }

  function grandChildrenAjax(childId) {
    $.ajax({
      url: "get_category_grandchildren",
      type: "GET",
      data: { child_id: childId },
      dataType: "JSON"
    })
    .done(function(grandChildren){
      $(".catagory-grandchildren").remove();
      let insertHtml = "";
      grandChildren.forEach(function(grandchild) {
        insertHtml += appendOption(grandchild);
      });
      grandChildrenBox(insertHtml)
    })
    .fail(function() {
      alert("カテゴリーの取得に失敗しました")
    });
  }

  $("#parent_category").change(function() {
    let parentId = $(this).val();
      return childrenAjax(parentId)
  });

  $(".categorySelect").on("change", "#child_category", function() {
    let childId = $(this).val();
    return grandChildrenAjax(childId);
  });

  // items#edit
  // if ( location.pathname.includes("items") && location.pathname.includes("edit") ) {
  //   let selectedChildData = $(".hiddenData").data();
  //   console.log(selectedChildData);
  //   $(document).ready(function() {
  //     let selectedParentId = $("#parent_category option:selected").val();
  //     let selectedChildId = $("#child_category option:selected").val();
  //     // let selectedChildId = $(".hiddenData").data();
  //     // console.log(selectedChildId);
  //     // return childrenAjax(selectedParentId);
  //     // return grandChildrenAjax(selectedChildId);
  //   });
  // }
});
