<#assign menu="article">
<#assign submenu="add_article">
<#include "/manage/head.ftl">
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<!-- page start-->
		<form id="add_article_form" class="form-horizontal" action="${BASE_PATH}/manage/article/add.json"  autocomplete="off"  method="post"
		>
		<div class="row">
			<input type="hidden" name="articleId">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading"> 
						增加文章
					</header>
					<div class="panel-body">
						<div class="form-group">
                          <label class="col-sm-2 col-sm-2 control-label">文章标题</label>
                          <div class="col-sm-10">
                              <input type="text" style="font-size:15px;width: 300px;" class="form-control" name="name"
                              	placeholder="文章标题" id="name" >
                              </input>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 col-sm-2 control-label">所属菜单</label>
                          <div class="col-sm-10">
                              <select class="form-control" id="parentMenu" style="font-size:15px;width: 300px; display: inline-block">
								  <#list menus?sort_by("sort") as f>
									  <#if f.name != "首页">
									  <option value="${f.id}" >${f.name}</option>
									  </#if>
								  </#list>
	                          </select>
                              <select class="form-control" id="childMenu" name="menuId" style="font-size:15px;width: 300px; display: inline-block"">
                                  <option value="1" >所属菜单</option>
                              </select>
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
                            <label class="col-sm-2 col-sm-2 control-label">文章状态</label>
                            <div class="col-sm-10" style="margin-bottom:10px;">
                                <input name="status" value="display" type="radio" checked> 显示
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input name="status" value="hidden" type="radio"> 隐藏
                            </div>
                        </div>
						<div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">文章内容</label>
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

    var menus = {
		<#list menus as f>
			<#if f.name != "首页">
				"${f.id}":[
					<#list f.children as c>
						{"id":"${c.id}","name":"${c.name}"},
					</#list>
				],
			</#if>
		</#list>
	};


    var parentMenu=$("#parentMenu").val();
    var childMenu=$("#childMenu")[0];
    var m=menus[parentMenu];
    childMenu.options.length=0;
    if (typeof m == "undefined") {
        childMenu.options.add(new Option(">>二级栏目<<", -1));
    }else {
        for (var i = 0; i < m.length; i++) {
            childMenu.options.add(new Option(m[i].name, m[i].id));
        }
    }


    $("#parentMenu").change(function()
	{
        var parentMenu=$(this).val();
        var childMenu=$("#childMenu")[0];
        var m=menus[parentMenu];
        childMenu.options.length=0;
        if (typeof m == "undefined") {
            childMenu.options.add(new Option(">>二级栏目<<", -1));
        }else {
            for (var i = 0; i < m.length; i++) {
                childMenu.options.add(new Option(m[i].name, m[i].id));
            }
        }
	});


    $('#add_article_form').ajaxForm({
		dataType : 'json',
		success : function(data) {
			if (data.result) {
				bootbox.alert("保存成功，将刷新页面", function() {
					window.location.reload();
				});
			}else{
				showErrors($('#add_article_form'),data.errors);
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