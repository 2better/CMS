<#assign menu="menu">
<#assign submenu="cog">
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

.dropdown-submenu {
    position: relative;
}
.dropdown-submenu > .dropdown-menu {
    top: 0;
    left: 100%;
    margin-top: -6px;
    margin-left: -1px;
    -webkit-border-radius: 0 6px 6px 6px;
    -moz-border-radius: 0 6px 6px;
    border-radius: 0 6px 6px 6px;
}
.dropdown-submenu:hover > .dropdown-menu {
    display: block;
}
.dropdown-submenu > a:after {
    display: block;
    content: " ";
    float: right;
    width: 0;
    height: 0;
    border-color: transparent;
    border-style: solid;
    border-width: 5px 0 5px 5px;
    border-left-color: #ccc;
    margin-top: 5px;
    margin-right: -10px;
}
.dropdown-submenu:hover > a:after {
    border-left-color: #fff;
}
.dropdown-submenu.pull-left {
    float: none;
}
.dropdown-submenu.pull-left > .dropdown-menu {
    left: -100%;
    margin-left: 10px;
    -webkit-border-radius: 6px 0 6px 6px;
    -moz-border-radius: 6px 0 6px 6px;
    border-radius: 6px 0 6px 6px;
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
                                                     placeholder="菜单名称" id="folderName" maxlength="5" required="required"/>

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
                                              <input style="font-size:15px;width: 500px;" class="form-control" required name="url" readonly value="系统生成"
                                                     id="url">
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <label class="col-xs-3 control-label">上级菜单</label>
                                          <#--<div class="col-xs-9">
                                              <select class="form-control input-lg m-bot15"
                                                      style="font-size:15px;width: 200px;" name="pid">
                                                  <option value="0">根菜单</option>
											  <#list menuParentsList?sort_by("sort") as f>
                                                  <option value="${f.id}"<#if mid ==f.id>selected</#if>>${f.name}</option>
											  </#list>
                                              </select>
                                          </div>-->
                                          <input id="hpid" type="hidden" value="${Menu.id}" name="pid"/>
                                          <div class="col-lg-9">
                                              <div class="dropdown" style="display: inline-block;">
                                                  <a id="dLabel" role="button" data-toggle="dropdown" class="btn btn-primary" data-target="#"
                                                     href="javascript:;" menuId="${Menu.id}">
                                                  ${Menu.name} <span class="caret"></span>
                                                  </a>
                                                  <ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
                                                      <li class="divider"></li>
                                                      <li><a href="javascript:;" menuId="0" class="dLabel hd">根菜单</a></li>
                                                      <li class="divider hd"></li>
                                                  <#list menuParentsList?sort_by("sort") as f>
                                                      <#if (f.children?size > 0)>
                                                          <li class="dropdown-submenu">
                                                              <a tabindex="-1" href="javascript:;" class="dLabel" menuId="${f.id}" >${f.name}</a>
                                                              <ul class="dropdown-menu">
                                                                  <li class="divider"></li>
                                                                  <#list f.children?sort_by("sort") as c>
                                                                      <li><a href="javascript:;"  menuId="${c.id}" class="dLabel">${c.name}</a></li>
                                                                      <li class="divider"></li>
                                                                  </#list>
                                                              </ul>
                                                          </li>
                                                          <li class="divider"></li>
                                                      <#else>
                                                          <li><a href="javascript:;" menuId="${f.id}" class="dLabel">${f.name}</a></li>
                                                          <li class="divider"></li>
                                                      </#if>
                                                  </#list>
                                                  </ul>
                                              </div>
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
                $("#url").attr("readonly", "readonly");
                $("#url").val('系统生成');
            }else if(a==2) {
                $("#url").removeAttr("readonly");
                $("#url").attr("");
                $("#url").val('');
            }else
            {
                $("#url").removeAttr("readonly");
                $("#url").val('http://');
            }

        });

       /* if($("#dLabel").attr("menuId")==0)
        {
            $(".hd").hide();
        }*/

        $("a.dLabel").click(function () {
            $("#dLabel").text($(this).text());
            $("#hpid").val($(this).attr("menuId"));
        });

		$('#addFolder_form').ajaxForm({
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					bootbox.dialog({
						message : "保存成功",
						name : "提示",
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
								    var id = $("#hpid").val();
									window.location.href="${BASE_PATH}/manage/menu/list.htm?id="+id;
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
