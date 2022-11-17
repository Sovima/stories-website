console.log("Hello world")


function hoverByClass(classname,colorover = "#ffe369",colorout="transparent"){
	var elms=document.getElementsByClassName(classname);
	for(var i=0;i<elms.length;i++){
		elms[i].onmouseover = function(){
			for(var k=0;k<elms.length;k++){
				elms[k].style.backgroundColor=colorover;
			}
		};
		elms[i].onmouseout = function(){
			for(var k=0;k<elms.length;k++){
				elms[k].style.backgroundColor=colorout;
			}
		};
	}
}
hoverByClass("classA");
hoverByClass("classB");
hoverByClass("classC");
hoverByClass("classD");