<#assign menu="preview">
<#assign submenu="preview_list">
<#include "/manage/head.ftl">
<style type="text/css">
.pagination {
    border-radius: 4px;
    display: inline-block;
    margin: 0;
    padding-left: 0;
}

.howto, .nonessential, #edit-slug-box, .form-input-tip, .subsubsub {
    color: #666666;
}

.subsubsub {
    float: left;
    font-size: 12px;
    list-style: none outside none;
    margin: 8px 0 5px;
    padding: 0;
}

.form-group{
	width:100%;
}

.count{
	position:absolute ;
	right:0px;
}

.arrticle_status{
	float:left;
}
</style>
	<!--main content start-->
	<section id="main-content">
		<section class="wrapper">
			<div class="row">
	                  <div class="col-lg-12">
	                      <!--breadcrumbs start -->
	                      <ul class="breadcrumb">
					<li>
						<a href="${BASE_PATH}/manage/article/list.htm">全部文档(${list?size})</a>
					</li>
	                      </ul>
	                      <!--breadcrumbs end -->
	                  </div>
	              </div>

        	<!-- page start-->
            <section class="panel">
	                <header class="panel-heading">
		                <div class="row">
		                  		<div class="col-lg-4">
							<ul class="breadcrumb" style="margin-bottom:0px;">
								<li>
									<a href="${BASE_PATH}/manage/preview/list.htm">文档列表</a>
								</li>
							</ul>
						   </div>
						   <div class="col-lg-8">
								<a class="btn btn-primary" style="float:right;" href="${BASE_PATH}/manage/preview/add.htm">上传文档</a>
						   </div>
				</div>
			</header>
                <div class="panel-body">
                	<div class="adv-table">
                    	<div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                            <table class="table table-striped table-advance table-hover">
                            	<thead>
                                	<tr>
										<th>文档名称</th>
                                        <th>文档类型</th>
                						<th>上传时间</th>
                						<th>操作</th>
              						</tr>
                                </thead>
                            	<tbody role="alert" aria-live="polite" aria-relevant="all">
                            		<#list list as e>
                            		<tr class="gradeA odd">
               							<td>
               								<a href="javascript:void(0);">${e.name}</a>
               							</td>
                                        <td>
                                            ${e.type}
                                        </td>
                                    	<td>${e.created?string("yyyy-MM-dd")}</td>
                                    	<td>
                  							<!-- Icons -->
                  							<a href="${BASE_PATH}/manage/preview/download.htm?id=${e.id}" title="下载" target="_self">
                  								下载
                  							</a>
                  							| 
                  							<a href="${BASE_PATH}/manage/preview/preview.htm?id=${e.id}" target="_blank">
                  								预览
                  							</a>
                                            |
                                            <a href="javascript:void(0);" class="js_article_delete" articleId="${e.id}" title="是否删除文档">
                                                删除
                                            </a>
                						</td>
                                	</tr>
                                	</#list>
                               	</tbody>
                              </table>
                           </div>
                        </div>
                  </div>
              </section>
              <!-- page end-->
          </section>
		</section>
		<!--main content end-->
<script>
$(function(){
var pageNum = "";
	$('.js_article_delete').click(function(){
		var articleId = $(this).attr('articleId');
		var status= "trash";
		bootbox.dialog({
			message : $(this).attr('title'),
			title : "提示",
			buttons : {
				"delete" : {
					label : "确定",
					className : "btn-success",
					callback : function() {
						$.post("${BASE_PATH}/manage/preview/delete.json", { "id": articleId},function(data){
								window.location.reload();
						}, "json");
					}
				},
				"cancel" : {
					label : "取消",
					className : "btn-primary",
					callback : function() {
						
					}
				}
			}
		});					
	});	
	$(".js_article_check").change(function(){
		$.post("${BASE_PATH}/manage/article/check.json", 
			{"articleId": $(this).attr("articleId"),check:$(this).val()},
			function(data){
				if(data.result){
					window.location.href="${BASE_PATH}/manage/article/list.htm?p="+pageNum;
				}else{
					bootbox.alert(data.msg,
	                function() {
	                    window.location.href="${BASE_PATH}/manage/article/list.htm?p="+pageNum;
	                });
				}
        },"json");  	
    });		
});
</script>
<#include "/manage/foot.ftl">
