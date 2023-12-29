$(function (){
  function display(bool){
    if(bool){
      $("#container").show();
    } else {
      $("#container").hide();
    }
  }

  display(false)
  window.addEventListener("message",function(event){
    var item = event.data;
    if (item.type == "ui"){
      if (item.status == true ){
        display(true)}
        else {
          display(false)
        }
    }
    if (item.plate){
      $("#plate").html(item.plate)
    }
    if(item.speed){
      $("#speed").html(item.speed)
    }
    if (item.plate2){
      $("#plate2").html(item.plate2)
    }
    if(item.speed2){
      $("#speed2").html(item.speed2)
    }
    if (item.nume){
      $("#nume").html(item.nume)
    }
    if(item.nume2){
      $("#nume2").html(item.nume2)
    }
    
  })
})

