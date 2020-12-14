
var placeService = (function(){
	
		function getList(param,callback,error) {
			var title = param.title;
			var regionNo = param.regionNo;
			var pageNum = param.pageNum;
			$.getJSON("/place/pages/"+title+"/"+regionNo+"/"+pageNum+".json", function(data){
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