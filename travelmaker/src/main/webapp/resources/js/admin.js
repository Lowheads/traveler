/**
 * 
 */

var user=(function(){
	
	function detail(boardNo, callback, error){
		
		$.ajax({
			url : "/admin/getDetail",
			data:{"boardNo":boardNo},
			datatype:'json',
			method :'post',
			success:function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er)
				}
			}
		})
		
	}

function list(callback,error){
		$.ajax({
			url : '/admin/refresh.json',
			datatype:'json',
			success:function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er)
				}
			}
		})
	}
	
	function search(param, callback, error) {

		var type = param.type;
		var keyword = param.keyword;
		
		$.getJSON("/admin/searchUser?type="+type+"&keyword="+keyword
		,function(data){
			if(callback){
				callback(data)}}
				).fail(
			function(xhr, status,err){
				if(error){
					error();
				}
			});
	}
	
		function remove(memNo, callback, error){
		
		$.ajax({
			type:'delete',
			url:'/admin/deleteUser/'+memNo,
			success:function(deleteResult, status, xhr){
				
				if(callback){
					callback(deleteResult);
				}
			},
			error:function(xhr, satus, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	return {detail:detail,
			list:list,
			search:search,
			remove:remove
			};	
})();


