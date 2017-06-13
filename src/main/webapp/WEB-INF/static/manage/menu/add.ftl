<#assign menu="menu">
<#assign submenu="add_menu">
<#include "/manage/head.ftl">
<style type="text/css">
.m-bot15 {
    margin-bottom: 5px;
}
.form-control {
    border: 1px solid #E2E2E4;
    box-shadow: none;
    color: #C2C2C2;
}
.input-lg {
    border-radius: 6px;
    font-size: 15px;
    height: 40px;
    line-height: 1.33;
    padding: 9px 15px；
}
</style>
		<!--main content start-->
		<section id="main-content">
			<section class="wrapper">
              <!-- page start-->
              <div class="row">
                  <div class="col-lg-12">
                      <section class="panel">
                          <header class="panel-heading">
                              添加菜单
                          </header>
                          <div class="panel-body" style="color:black">
                              <form id="addFolder_form" method="post" class="form-horizontal" autocomplete="off"
                                    action="${BASE_PATH}/manage/menu/add.json">
                                  <fieldset>
                                      <div class="form-group">
                                          <label class="col-xs-3 control-label">菜单名称</label>
                                          <div class="col-xs-9">
                                              <input type="text" style="font-size:15px;width: 200px;" class="form-control"
                                                     name="name"
                                                     placeholder="菜单名称" id="folderName" maxlength="5" required="required">${menuName}
                                              </input>
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <label class="col-xs-3 control-label">菜单类型</label>
                                          <div class="col-xs-9">
                                              <select class="form-control input-lg m-bot15" id="createUrl"
                                                      style="font-size:15px;width: 200px; height:46px;" name="createUrl">
                                                  <option value="1" selected>站内链接(系统生成)</option>
                                                  <option value="2">站内链接(自定义)</option>
                                                  <option value="0">外部链接</option>
                                              </select>
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <label class="col-xs-3 control-label">链接地址</label>
                                          <div class="col-xs-9">
                                              <input style="font-size:15px;width: 500px;" class="form-control" required name="url" disabled value="系统生成"
                                                     id="url">
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <label class="col-xs-3 control-label">上级菜单</label>
                                          <div class="col-xs-9">
                                              <select class="form-control input-lg m-bot15"
                                                      style="font-size:15px;width: 200px;" name="pid">
                                                  <option value="0">根菜单</option>
											  <#list menuParentsList?sort_by("sort") as f>
                                                  <option value="${f.id}"<#if mid ==f.id>selected</#if>>${f.name}</option>
											  </#list>
                                              </select>
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <label class="col-xs-3 control-label">菜单状态</label>
                                          <div class="col-xs-9">
                                              <label class="radio-inline">
                                                  <input type="radio" name="status" value="display" checked/> 显示
                                              </label>
                                              <label class="radio-inline">
                                                  <input type="radio" name="status" value="hidden"/> 隐藏
                                              </label>
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <div class="col-lg-offset-3 col-xs-9">
                                              <button class="btn btn-danger" type="submit">保存</button>
                                          </div>
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

        $("#createUrl").change(function () {
            var a = $(this).val();
            if(a==1) {
                $("#url").attr("disabled", "disabled");
                $("#url").val('系统生成');
            }else if(a==2) {
                $("#url").removeAttr("disabled");
                $("#url").attr("");
                $("#url").val('');
            }else
            {
                $("#url").removeAttr("disabled");
                $("#url").val('http://');
            }

        });

		$('#addFolder_form').ajaxForm({
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
								label : "查看菜单列表",
								className : "btn-primary",
								callback : function() {
									window.location.href="${BASE_PATH}/manage/menu/list.htm?id=${mid}";
								}
							}
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
