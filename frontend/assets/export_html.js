$(function () {


  $(document).bind("loadedrecordform.aspace", function(event, $container) {

    $("body").append("<div id='export_html_job_redirect_modal_template'><!--<div class='modal-body'>Export HTML Job Created</div><div class='modal-footer'><button id='viewHtmlJobPage' class='btn btn-primary'>Proceed to Job page</button><button id='dismissHtmlJobModal' class='btn btn-cancel btn-default' data-dismiss='modal'>Close</button></div>--></div>");



    if ($("li#download-ead-dropdown").length) {

      var $menuItem = $("<li><a href='#'>Generate HTML Finding Aid</a></li>");

      $menuItem.click(function(e) {
        e.preventDefault();
        e.stopPropagation();
        console.log("generate html");

        $.ajax({
          url: APP_PATH+'plugins/export_html',
          type: 'POST',
          data: {
            'resource_id': $("#archives_tree").data('root-id')
          },
          success: function(json) {
            console.log(json);

            AS.openCustomModal("jobCreatedModal", "Job Created", AS.renderTemplate("export_html_job_redirect_modal_template"));
            $("#viewHtmlJobPage", "#jobCreatedModal").on("click", function() {
              window.location = json['uri'].replace(/\/repositories\/\d+/, '');
            });

            // $("#dismissHtmlJobModal", "#jobCreatedModal").on("click", function() {
              

            

          },
          error: function(obj, errorText, errorDesc) {
            console.log(errorText);
          }
        });

      });

      $("li#download-ead-dropdown").after($menuItem);
    }
  });
});

