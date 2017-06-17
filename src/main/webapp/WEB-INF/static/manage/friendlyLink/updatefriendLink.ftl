<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="myModalLabel">修改友情链接</h4>
</div>
<form id="update_folder_form" method="post"
      class="form-horizontal" autocomplete="off"
      action="${BASE_PATH}/manage/config/update.json">
<div class="modal-body">
		<!-- page start-->
		<div class="row">
				<div class="col-lg-12">
					<input type="hidden" class="form-control" name="id"
						value="${friendlylink.id}">
					<section class="panel">
						<div class="panel-body">
                        	<div class="form-group">
	                          <label class="col-sm-2 col-sm-2 control-label">名称</label>
	                          <div class="col-sm-10">
	                              <input type="text" style="font-size:15px;width: 300px;" class="form-control" name="name"
	                              	placeholder="菜单名称" id="name" value="${friendlylink.name}" required>
	                              </input>
	                          </div>
	                        </div>
                        	<div class="form-group">
	                          <label class="col-sm-2 col-sm-2 control-label">链接地址</label>
	                          <div class="col-sm-10">
	                              <input type="text" style="font-size:15px;width:400px;" class="form-control" name="url" id="ename" value="${friendlylink.url}" required />
	                          </div>
	                        </div>
	                          <div class="form-group">
	                              <label class="col-sm-2 col-sm-2 control-label">菜单状态</label>
	                              <div class="col-sm-10">
	                              	<label class="radio-inline">
	                            		<input type="radio" name="status" value="display" <#if friendlylink.status=="display">checked</#if>/> 显示
	                          		</label>
	                          		<label class="radio-inline">
	                            		<input type="radio" name="status" value="hidden" <#if friendlylink.status=="hidden">checked</#if>/> 隐藏
	                          		</label>
	                              </div>
	                          </div>
	                        <div class="form-group">

	                      </div>
						</div>
					</section>
				</div>

		</div>
</div>
<div class="modal-footer">
    <button type="submit" id="btn_submit" class="btn btn-shadow btn-primary" ><span class="glyphicon glyphicon-floppy-disk"></span>修改</button>
    <button type="button" id="bt" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
</div>
</form>
<script type="text/javascript">
	$(function() {

		$('#update_folder_form').ajaxForm({
			dataType : 'json',
			success : function(data) {
				if (data.result) {
                    $("#bt").click();
					bootbox.alert("修改成功",function(){
                        window.location.reload();
					});
				}else{
					showErrors($('#update_folder_form'),data.errors);
				}
			}
		});

	});	
</script>
