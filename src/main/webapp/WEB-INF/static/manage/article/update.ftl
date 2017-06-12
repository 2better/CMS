<#assign menu="article">
<#assign submenu="update_article">
<#include "/manage/head.ftl">
<!--main content start-->
<style type="text/css">

</style>
<section id="main-content">
	<section class="wrapper">
		<!-- page start-->
		<form id="update_article_form" class="form-horizontal" action="${BASE_PATH}/manage/article/update.json"  autocomplete="off"  method="post"
			>
			<fieldset>
		<div class="row">
			<input type="hidden" name="articleId" value="${article.articleId}">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading"> 
						修改文章
					</header>
					<div class="panel-body">
						<div class="form-group">
                          <label class="col-sm-2 col-sm-2 control-label">标题</label>
                          <div class="col-sm-10">
                              <input type="text" style="font-size:15px;width: 300px;" class="form-control" name="title"
                              	placeholder="文章标题" id="name" value="${article.title}">
                              </input>
                          </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">所属菜单</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="parentMenu" style="font-size:15px;width: 300px; display: inline-block">
								<#list menus?sort_by("sort") as f>
									<#if f.name != "首页">
                                        <option value="${f.id}" <#if Menu.pid ==f.id>selected</#if>>${f.name}</option>
									</#if>
								</#list>
                                </select>
                                <select class="form-control" id="childMenu" name="menuId" style="font-size:15px;width: 300px; display: inline-block"">

                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">发布时间</label>
                            <div class="col-sm-10">
                                <input type="text" data-link-format="yyyy-mm-dd" data-date-format="yyyy-MM-dd" style="font-size:15px;" class="js_create_time" name="createTime"
                                       placeholder="发布时间" id="createTime" value="${article.createTime?string("yyyy-MM-dd")}" readonly>
                                </input>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">文章状态</label>
                            <div class="col-sm-10" style="margin-bottom:10px;">
                                <input name="status" value="display" type="radio" <#if article.status=="display" || article.status=="init">checked</#if>> 显示
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input name="status" value="hidden" type="radio" <#if article.status=="hidden">checked</#if>> 隐藏
                            </div>
                        </div>
						<div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">内容</label>
                              <div class="col-sm-10">
                                  <script id="content" name="content" type="text/plain"
										style="width: 100%; height: 600px;">${article.content!}</script>
								  <script type="text/javascript">
									var contentEditor;
									$(function() {
										contentEditor = UE.getEditor('content');
									});
								  </script>
                              </div>
                        </div>

                        <div class="form-group">
                      	  <div class="col-lg-offset-2 col-lg-10">
                          <button class="btn btn-shadow btn-primary" type="submit">更新</button>
                          </div>
                      </div>
					</div>
				</section>
				<!-- section class="panel">
					<header class="panel-heading"> 附件 </header>
					<div class="panel-body">
						<div id="attachment"></div>
						<button id="file_upload"  class="btn btn-shadow btn-info" type="button"><i class="icon-cloud-upload"></i> 添加附件</button>
					</div>
				</section -->					
			</div>
		</div>
		</fieldset>
		</form>
		<!-- page end-->
	</section>
</section>
<!--main content end-->
<script type="text/javascript">
var kindId = ${article.articleId};
var kind = "article";
$.extend({
	getAttachment:function(){
		$.getJSON("${BASE_PATH}/manage/attachment/list.json?kindId="+kindId+"&v="+Math.random(),function(data){
			$('#attachment').html("");
			$.addAttachment(data.attachmentList);
		});
	},
	addAttachment:function(list){
		var html = '<table class="table"><thead><tr><th>文件名</th><th>大小</th><th>操作</th></tr></thead><tbody>';
		for(i=0;i<list.length;i++){
			var attachment = list[i];
			html += '<tr>';
			html += '<td>'+attachment.name+'</td>';
			html += '<td>'+attachment.size+'</td><td>';
			html += '<a href="javascript:void(0);" title="删除" name="'+attachment.name+'" class="btn btn-danger btn-xs js_delete" attachmentId="'+attachment.attachmentId+'">删除</a> ';
			html += '</td></tr>';
		}
		html += '</tbody></table>';
		$('#attachment').prepend(html);
		$('#attachment .js_delete').click(function(){
			var file = $(this);
			bootbox.confirm("是否要删除【"+$(this).attr("name")+"】文件？", function(result) {
				if (result) {
					$.post("${BASE_PATH}/manage/attachment/delete.json",{'attachmentId':file.attr("attachmentId")},function(data){
						if(data.result){
							$.getAttachment();
						}
					},"json");
				}
			});		
		});
		$('#attachment .js_picture').click(function(){
			$.post("${BASE_PATH}/manage/article/update_picture.json",{'attachmentId':$(this).attr("attachmentId"),'status':$(this).attr("status")},function(data){
				if(data.result){
					$.getAttachment();
				}
			},"json");
		});
		$('#attachment .js_link').click(function(){
			var attachmentId = $(this).attr("attachmentId");
			bootbox.prompt("为此附件增加链接", function(result) {
				if (result !="") {
					$.post("${BASE_PATH}/manage/attachment/update_link.json",{'attachmentId':attachmentId,'link':result},function(data){
						if(data.result){
							$.getAttachment();
						}
					},"json");					
				} 
			});			
		});
	}
});
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
            if(m[i].id=="${article.menuId}")
                childMenu.options.add(new Option(m[i].name, m[i].id,false,true));
            else
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

	$('#update_article_form').ajaxForm({
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

	$.getAttachment();
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
