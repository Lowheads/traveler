
var placeService = (function(){
	
		function getList(param,callback,error) {
			var title = param.title;
			$.getJSON("/place/pages/" + title + ".json", function(data){
				if(callback) {			
					callback(data);
				}
			}).fail(function(xhr,status,err){
				if(error){
					error();
				}
			});
		}
		
		return {
			getList : getList
		};
})();