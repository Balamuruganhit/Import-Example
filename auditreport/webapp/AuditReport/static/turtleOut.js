
    
   document.addEventListener("DOMContentLoaded", () => {
 
   console.log("It will work")
    const sideBoxLeft = document.getElementById("lg-sb-lf");
    const TopBoxLeft = document.getElementById("tp-lf");
    const TopBoxMiddle = document.getElementById("tp-md");
    const TopBoxRight= document.getElementById("tp-rg");
    const box1 = document.getElementById("md-lf");
    const box2 = document.getElementById("md-md");
    const box3 = document.getElementById("md-rg");
    const BottomBoxLeft = document.getElementById("bt-lf");
    const BottomBoxMiddle = document.getElementById("bt-md");
    const BottomBoxRight = document.getElementById("bt-rg");
    const sideBoxRight = document.getElementById("lg-sb-rg");
    const supplier = document.getElementById("supplier");
    const input = document.getElementById("input");
    const resources = document.getElementById("resources");
    const risk = document.getElementById("risk");
    const personel = document.getElementById("personel");
    const work = document.getElementById("work");
    const oppur = document.getElementById("oppur");
    const kpi = document.getElementById("kpi");
    const output = document.getElementById("output");
    const customer = document.getElementById("customer");

    
    function sideToside(box1,box2,start,end,arrow) {
      const rect1 = box1.getBoundingClientRect();
      const rect2 = box2.getBoundingClientRect();

      let x1, y1, x2, y2;
      if(start == "middle" && end == "middle"){
       x1 = rect1.right;
       y1 = rect1.top+2 + rect1.height/2;
       x2 =  rect2.left +10;
       y2 = rect2.top + rect2.height/2;
      }else if(start == "topcorner" && end == "bottomcorner"){
         x1 = rect1.right;
         y1 = rect1.top;
         x2 =  rect2.left ;
         y2 = rect2.bottom;
      }
      else if(start == "bottomcorner" && end == "topcorner"){
         x1 = rect1.right;
         y1 = rect1.bottom ;
         x2 =  rect2.left ;
         y2 = rect2.top ;
      }
      else if(start == "bottommiddle" && end == "topmiddle"){
         x1 = rect1.left + rect1.width/2;
         y1 = rect1.bottom ;
         x2 =  rect2.left + rect2.width/2 ;
         y2 = rect2.top ;
      }else{
         x1 = rect1.left;
         y1 = rect1.bottom;
         x2 =  rect2.right ;
         y2 = rect2.top;
      }

      
      const dx = x2 - x1;
      const dy = y2 - y1;
      const length = Math.sqrt(dx * dx + dy * dy);
      const angle = Math.atan2(dy, dx) * 180 / Math.PI;

      arrow.style.left = `${x1}px`;
      arrow.style.top = `${y1}px`;
      arrow.style.width = `${length}px`;
      arrow.style.transform = `rotate(${angle}deg)`;
    }
   
    window.addEventListener('DOMContentLoaded', ()=>{
        sideToside(sideBoxLeft,box1,"middle",'middle',supplier)
        sideToside(box1,box2,"middle",'middle',input)
        sideToside(box2,box3,"middle",'middle',output)
        sideToside(box3,sideBoxRight,"middle",'middle',customer)
        sideToside(TopBoxLeft,box2,"bottomcorner",'topcorner',resources)
        sideToside(box2,BottomBoxRight,"bottomcorner",'topcorner',kpi)
        sideToside(TopBoxMiddle,box2,"bottommiddle",'topmiddle',risk)
        sideToside(box2,BottomBoxMiddle,"bottommiddle",'topmiddle',oppur)
        sideToside(BottomBoxLeft,box2,"topcorner",'bottomcorner',work)
        sideToside(TopBoxRight,box2,"",'',personel)
    });

   
 });


