<#assign menu="menu"> <#assign submenu="update_menu"> <#include
"/manage/head.ftl">
<style type="text/css">
</style>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<!-- page start-->
		<div class="row">
			<form id="update_folder_form" method="post"
				class="form-horizontal" autocomplete="off"
				action="${BASE_PATH}/manage/menu/update.json">
				<div class="col-lg-12">
					<input type="hidden" class="form-control" name="id"
						value="${Menu.id}">
					<section class="panel">
						<header class="panel-heading"> 
						修改菜单
						</header>
						<div class="panel-body">
                        	<div class="form-group">
	                          <label class="col-sm-2 col-sm-2 control-label">菜单名称</label>
	                          <div class="col-sm-10">
	                              <input type="text" style="font-size:15px;width: 300px;" class="form-control" name="name"
	                              	placeholder="菜单名称" id="name" value="${Menu.name}">
	                              </input>
	                          </div>
	                        </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-3  control-label">由系统生成URl</label>
                                <div class="col-sm-2">
                                    <input type="checkbox"  class="form-control" id="createUrl" name="createUrl" value="1" style="font-size:10px;height:20px">
                                </div>
                            </div>
                        	<div class="form-group">
	                          <label class="col-sm-2 col-sm-2 control-label">URL</label>
	                          <div class="col-sm-10">
	                              <input type="text" style="font-size:15px;width: 300px;" class="form-control" name="url"
	                              	placeholder="URL" id="ename" value="${Menu.url}">
	                              </input>
	                          </div>
	                        </div>
	                          <div class="form-group">
	                              <label class="col-sm-2 col-sm-2 control-label">菜单状态</label>
	                              <div class="col-sm-10">
	                              	<label class="radio-inline">
	                            		<input type="radio" name="status" value="display" <#if Menu.status=="display">checked</#if>/> 显示
	                          		</label>
	                          		<label class="radio-inline">
	                            		<input type="radio" name="status" value="hidden" <#if Menu.status=="hidden">checked</#if>/> 隐藏
	                          		</label>
	                              </div>
	                          </div>
	                        <div class="form-group">
	                      	  <div class="col-lg-offset-2 col-lg-10">
	                         	<button class="btn btn-shadow btn-primary" type="submit">更新菜单</button>
	                          </div>
	                      </div>
						</div>
					</section>
				</div>
			</form>
		</div>

		<!-- page end-->
	</section>
</section>
<!--main content end-->
<script type="text/javascript">
	$(function() {

        /*$("#createUrl").change(function () {
            if($("#createUrl").is(':checked'))
                $("#ename").attr("disabled","disabled");
            else
                $("#ename").removeAttr("disabled");
        });*/

		$('#update_folder_form').ajaxForm({
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					bootbox.alert("保存成功，将刷新页面", function() {
						window.location.reload();
					});
				}else{
					showErrors($('#update_folder_form'),data.errors);
				}
			}
		});

	});	
</script>
<#include "/manage/foot.ftl">
