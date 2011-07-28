$(function() {
	$("#styles .pagination a, #styles ").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#styles_search input").keyup(function() {
    $.get($("#styles_search").attr("action"), $("#styles_search").serialize(), null, "script");
    return false;
  });
  $("#attr_Search input").keyup(function() {
    $.get($("#attr_search").attr("action"), $("#atrr_search").serialize(), null, "script");
    return false;
  });
});