$(function () {  
  if (JOB_TYPE === 'export_html_job' && $("#files a").length) {
    

    var href = "/plugins/export_html" + $("#files a").attr('href') + ".html";
    $("#files a").attr("href", href);
    $("#files a").addClass('btn-success').addClass('btn');
    $("#files a").closest("ul").addClass('list-group');
    $("#files a").closest("li").addClass('list-group-item');
    $("#files a").html("Download the HTML Finding Aid");
    $("#files a").closest("div").css('paddingTop', '10px');
  }

});
