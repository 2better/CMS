<#assign menu="preview">
<#assign submenu="add_preview">
<#include "/manage/head.ftl">
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<!-- page start-->
		<form id="add_article_form" class="form-horizontal" action="${BASE_PATH}/manage/preview/add.json"  autocomplete="off"  method="post"
			enctype="multipart/form-data">
		<div class="row">
			<input type="hidden" name="articleId">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading"> 
						上传文档
					</header>
					<div class="panel-body">
						<div class="form-group">
                          <label class="col-sm-2 col-sm-2 control-label">选择文档</label>
                          <div class="col-sm-10">
                          	<input type="file" name="file"
                              	id="file" >
                          </div>
                      	</div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <button class="btn btn-shadow btn-primary" type="submit">上传</button>
                            </div>
                        </div>
					</div>
				</section>
			</div>
		</div>
		</form>
		<!-- page end-->
	</section>
</section>
<!--main content end-->
<script type="text/javascript">
$(function(){
	$('#add_article_form').ajaxForm({
		dataType : 'json',
		success : function(data) {
            if (data.result) {
                bootbox.dialog({
                    message : "保存成功",
                    title : "提示",
                    buttons : {
                        add : {
                            label : "继续添加",
                            className : "btn-success",
                            callback : function() {
                                window.location.reload();
                            }
                        },
                        list : {
                            label : "返回列表",
                            className : "btn-primary",
                            callback : function() {
                                window.location.href="${BASE_PATH}/manage/preview/list.htm";
                            }
                        },
                    }
                });
            }else{
                showErrors($('#addFolder_form'),data.errors);
            }
		}
	});
});
</script>
<#include "/manage/foot.ftl">