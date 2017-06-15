<#assign menu="scholar">
<#assign submenu="add_scholar">
<#include "/manage/head.ftl">
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<!-- page start-->
		<form id="add_scholar_form" class="form-horizontal" action="${BASE_PATH}/manage/scholar/add.json" autocomplete="off" method="post"
		enctype="multipart/form-data">
		<div class="row">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading"> 
						增加学者
					</header>
					<div class="panel-body">
						<div class="form-group">
                          <label class="col-sm-2 col-sm-2 control-label">学者名称</label>
                          <div class="col-sm-10">
                              <input type="text" style="font-size:15px;width: 300px;" class="form-control" name="name"
                              	placeholder="学者名称" id="name" >
                              </input>
                          </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">发布时间</label>
                            <div class="col-sm-10">
                                <input type="text" data-link-format="yyyy-MM-dd" data-date-format="yyyy-MM-dd" style="font-size:15px;width: 200px;" class="js_create_time" name="createTime"
                                       placeholder="发布时间" id="createTime" value="${.now?string("yyyy-MM-dd")}">
                                </input>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">选择封面</label>
                            <div class="col-sm-10">
                                <input type="file" name="file"
                                       id="file" >
                            </div>
                        </div>
						<div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">简介内容</label>
                              <div class="col-sm-10">
                                  <script id="content" name="content" type="text/plain"
										style="width: 100%; height: 260px;"></script>
								  <script type="text/javascript">
									var contentEditor;
									$(function() {
										contentEditor = UE.getEditor('content');
									});
								  </script>
                              </div>
                        </div>

                        <div class="form-group">
                      	  <div class="col-lg-offset-2 col-lg-12">
                          <button class="btn btn-shadow btn-primary" type="submit">发布</button>
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
    $('#add_scholar_form').ajaxForm({
		dataType : 'json',
		success : function(data) {
			if (data.result) {
				bootbox.alert("保存成功，将刷新页面", function() {
					window.location.reload();
				});
			}else{
				showErrors($('#add_scholar_form'),data.errors);
			}
		}
	});

    $('.js_create_time').datetimepicker({
        language:  'zh-CN',
        format: "yyyy-mm-dd",
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
    });	
});
</script>
<#include "/manage/foot.ftl">