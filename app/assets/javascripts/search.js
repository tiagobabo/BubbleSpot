$(function() {

$("#shoppings .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#shoppings_search input").keyup(function() {
    $.get($("#shoppings_search").attr("action"), $("#shoppings_search").serialize(), null, "script");
    return false;
  });
});