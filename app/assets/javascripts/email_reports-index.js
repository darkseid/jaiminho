$().ready(function(){

  var $selectAll = $('.js-select-all'),
      $checkAction = $('.js-check-action'),
      $formRetry = $('.js-form-retry');

  $selectAll.click(function(){
    $checkAction.prop('checked', this.checked);
  });

  $formRetry.submit(function(event){
    event.preventDefault();
    
    var ids = [], params = $(this).serializeArray();

    if(params.length){
      for(var i=0; i < params.length; i++){
        ids.push(parseInt(params[i].value));
      }
      $.ajax({
        url: this.action,
        data: {'ids': ids},
        method: this.method,
        success: function(response){
          return window.location.href = window.location.href;
        }
      });
    }
  });
});
