<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="robots" content="index,follow"/>
	<link rel="stylesheet" href="assets/dist/themes/proton/style.css"/>
	
	<script type="text/javascript" src="js/jquery-3.1.0.js"></script>
	<script type="text/javascript" src="js/jstree.js"></script>
	<style>.proton-demo{max-width:100%;padding:10px;border-radius:3px;}</style>
    <script type="text/javascript">
    	
    	$(function(){
    		$("#productManager").prepend("<div class='pointer'><div class='arrow'></div><div class='arrow_border'></div></div>");
    		$("#productManager").addClass("active");
    		$("#productCategory").addClass("active");
    		$("#productCategory").parent().parent().addClass("active");
    		
    		var url = "${pageContext.request.contextPath }/getJsonTree";
			var args = {"date":new Date()};
			$.post(url,args,function(data){
				
				$('#jstree-proton-3').jstree({
	    			plugins : ["contextmenu"], 
	    	        'core': {
	    	        	"check_callback": true,
	    	        	'data': eval(data),
	    	            'themes': {
	    	                'name': 'proton',
	    	                'responsive': true
	    	            }
	    	        },
	    	        "contextmenu": {    
		                "items": {    
		                    "create": {    
		                        "label": "创建子类",    
		                        "action": function (obj) {
		                            $('#createProductCategory').removeClass("hide");
		                            
		                            $("#confirm").click(function(){
		                            	var tree = $('#jstree-proton-3').jstree(true);
		                            	var clickedNode = tree.get_node(obj.reference);
		            	            	var text = $('#name').val();
		            	            	$('#createProductCategory').addClass("hide");
		            	                var url = "${pageContext.request.contextPath }/createTreeNode";
		            	    			var args = {"parentNodeId" : clickedNode.id, "text" : text, "date":new Date()};
		            	    			$.post(url,args,function(newNode){
		            	    				alert('post');
		            	    				if(newNode != 'false') {
		            	    					//将json字符串转换为json对象
		            	    					var newData = (new Function("","return "+ newNode))();
		            	    					 $("#jstree-proton-3").jstree(true).create_node(clickedNode,newData,'last',function(){
		            	    					        alert("创建分类成功");
		            						        }, true);
		            	                    }else{
		            	                    	alert("创建分类失败!");
		            	                    }
		            	    				//将输入框内容清空
		            	    				$('#name').val('');
		            	    				//移除点击事件
		            	    				$("#confirm").unbind("click");
		            	    			});
		            	            	
		            	            });
		            	            
		            	            $("#cancel").click(function(){
		            	            	$('#createProductCategory').addClass("hide");
		            	            });
		            	            
		                        }
		                    },
		                    "delete": {    
		                        "label": "删除分类",    
		                        "action": function (obj) {  
		                            var inst = jQuery.jstree.reference(obj.reference);    
		                            var clickedNode = inst.get_node(obj.reference);
		                            
		                            var flag = confirm("确定要删除" + clickedNode.text + "节点及其子节点吗?");
		                            if(flag){
		                            	var url = "${pageContext.request.contextPath }/deleteTreeNode";
		                    			var args = {"id" : clickedNode.id, "date":new Date()};
		                    			$.post(url,args,function(data){
		                    				if(data) {
		                    					$("#" + clickedNode.id).remove();
	                                        }else{
	                                        	alert("删除失败!");
	                                        }
		                    			});
		                            }
		                        }    
		                    },
		                    "rename": {    
		                        "label": "分类重命名",    
		                        "action": function (obj) {  
		                            var inst = jQuery.jstree.reference(obj.reference);    
		                            var clickedNode = inst.get_node(obj.reference);   
		                            $("#jstree-proton-3").jstree('rename_node', clickedNode , 'good' ); 
		                        }    
		                    }  
		                }    
		            } 
	    	    });
			
				
	            
			});
			
			
    		
    	});
    	
    </script>
</head>
<body>

    <div class="content">
        
        <div class="container-fluid">
            <div id="pad-wrapper">
                
                <div class="table-wrapper orders-table">
                    <div class="row-fluid head">
                        <div class="span12">
                            <h4>商品分类维护123</h4>
                        </div>
                    </div>
                    <div id="jstree-proton-3" style="margin-top:20px;" class="proton-demo"></div>
            </div>
        </div>
        
        
        <div class="modal hide fade in" id="createProductCategory">
	          <div class="modal-header">
	              <h4 class="modal-title">创建分类</h4>
	          </div>
		
	          <div class="modal-body">
	              <form class="form-horizontal">
	                 <label class="control-label pull-left">分类名称&nbsp;&nbsp;</label>
	                 <input type="text" id="name"/>
	              </form>
	          </div>
	          <div class="modal-footer">
			  		<a class="btn btn-success" id="confirm">确定</a>
					<a class="btn" data-dismiss="modal" id="cancel">取消</a>
			  </div>
		</div>
		
		
    </div>
    </div>
    <!-- end main container -->

</body>
</html>