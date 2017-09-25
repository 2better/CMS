<#assign menu="menu"> <#assign submenu="cog"> <#include
"/manage/head.ftl">
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
	                              	placeholder="菜单名称" id="name" value="${Menu.name}" required>
	                              </input>
	                          </div>
	                        </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">菜单类型</label>
                                <div class="col-sm-10">
                                    <select class="form-control input-lg m-bot15" id="createUrl"
                                            style="font-size:15px;width: 200px; height:46px;" name="createUrl">
                                        <option value="3" selected>不修改</option>
										<option value="1">站内链接(系统生成)</option>
                                        <option value="2">站内链接(自定义)</option>
                                        <option value="0">外部链接</option>
                                    </select>
                                </div>
                            </div>
                        	<div class="form-group">
	                          <label class="col-sm-2 col-sm-2 control-label">链接地址</label>
	                          <div class="col-sm-10">
	                              <input type="text" style="font-size:15px;width:500px;" class="form-control" name="url" readonly id="ename" value="${Menu.url}" required>
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

	    var urlvalue = $("#ename").val();
        $("#createUrl").change(function () {
            var a = $(this).val();
            if(a==1) {
                $("#ename").attr("readonly", "readonly");
                $("#ename").val('系统生成');
            }else if(a==2) {
                $("#ename").removeAttr("readonly");
                $("#ename").val('');
            }else if(a==0)
            {
                $("#ename").removeAttr("readonly");
                $("#ename").val('http://');
            }else {
                $("#ename").attr("readonly", "readonly");
                $("#ename").val(urlvalue);
			}
        });

		$('#update_folder_form').ajaxForm({
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					bootbox.alert("更新成功", function() {
						//window.location.reload();
                        window.location.href = "${BASE_PATH}/manage/menu/list.htm?id=${Menu.pid}";
					});
				}else{
					showErrors($('#update_folder_form'),data.errors);
				}
			}
		});

	});	
</script>
<#include "/manage/foot.ftl">
