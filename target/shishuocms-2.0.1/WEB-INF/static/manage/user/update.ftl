<#assign menu="user">
<#assign submenu="user">
<#include "/manage/head.ftl">
<style type="text/css">
</style>
<!--main content start-->
	<section id="main-content">
		<section class="wrapper">
		<!-- page start-->
			<div class="row">
			<div class="col-lg-12">
			<section class="panel">
				<header class="panel-heading">
 					修改用户资料
				</header>
				<div class="panel-body">
					<form id="update_user_form" method="post" class="form-horizontal" autocomplete="off" action="${BASE_PATH}/user/update.json">
					<fieldset>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">用户名称</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="userName" value="${user.name}"
									placeholder="用户名称" id="userName">
							</div>
						</div>
                        <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">密码</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" name="password"
                                       value="" placeholder="密码" id="password">
                            </div>
                        </div>
						<div class="form-group">
                        	<label class="col-sm-2 col-sm-2 control-label"></label>
                        	<button class="btn btn-danger" type="submit">修改</button>
                        </div>
					</fieldset>
				</form>
				</div>
			</section>
		</div>
		</div>
<!-- page end-->
		</section>
	</section>
 <!--main content end-->
<script type="text/javascript">
	$(function() {
		$('#update_user_form').ajaxForm({
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					bootbox.alert("保存成功，将刷新页面", function() {
						window.location.reload();
					});
				}else{
					showErrors($('#update_user_form'),data.errors);
				}
			}
		});
	});	
</script>
<#include "/manage/foot.ftl">