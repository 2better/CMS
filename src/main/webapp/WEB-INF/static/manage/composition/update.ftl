<#assign menu="composition">
<#assign submenu="result">
<#include "/manage/head.ftl">
<!--main content start-->
<link href="${BASE_PATH}/static/manage/assets/cropper/cropper.min.css" rel="stylesheet" type="text/css" media="all">
<link href="${BASE_PATH}/static/manage/assets/cropper/main.css" rel="stylesheet" type="text/css" media="all">
<section id="main-content">
	<section class="wrapper">
		<!-- page start-->
		<form id="update_composition_form" class="form-horizontal" action="${BASE_PATH}/manage/composition/update.json"  autocomplete="off"  method="post"
              enctype="multipart/form-data">
			<fieldset>
		<div class="row">
			<input type="hidden" name="id" value="${composition.id}">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading"> 
						修改著作
					</header>
					<div class="panel-body">
						<div class="form-group">
                          <label class="col-sm-2 col-sm-2 control-label">名称</label>
                          <div class="col-sm-10">
                              <input type="text" style="font-size:15px;width: 300px;" class="form-control" name="title"
                              	placeholder="著作名称" id="name" value="${composition.title}">
                              </input>
                          </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">发布时间</label>
                            <div class="col-sm-10">
                                <input type="text" data-link-format="yyyy-MM-dd" data-date-format="yyyy-MM-dd" style="font-size:15px;width: 200px;" class="js_create_time" name="createTime"
                                       placeholder="发布时间" id="createTime" value="${composition.createTime?string("yyyy-MM-dd")}">
                                </input>
                            </div>
                        </div>
                        <input type="hidden" name="picUrl" value="${composition.picUrl!}">
                        <div class="form-group panel panel-default">
                            <label class="col-sm-2 control-label">
                                著作封面
                            </label>
                            <div class="col-sm-10">
                                <a href="#demo" data-toggle="collapse" style="font-size: 16px;">重新上传封面&nbsp;&nbsp;<i
                                        class="fa fa-chevron-right" id="ix"
                                        style="float: none;right:6px;font-size: 16px;position: static;"></i></a>
                            </div>
                        </div>
                        <div id="demo" class="collapse">

                            <input type="hidden" class="avatar-src" name="avatar_src">
                            <input type="hidden" class="avatar-data" name="x">
                            <input type="hidden" class="avatar-data" name="y">
                            <input type="hidden" class="avatar-data" name="height">
                            <input type="hidden" class="avatar-data" name="width">
                            <input type="hidden" class="avatar-data" name="rotate">

                            <!-- Crop and preview -->
                            <div class="row">

                                <div class="col-md-2">
                                    <div class="docs-preview clearfix">
                                        <div class="img-preview preview-lg" style="width:12rem"></div>
                                    </div>

                                </div>

                                <div class="col-md-10">
                                    <div class="docs-buttons">

                                        <div class="btn-group avatar-upload">
                                            <a href="javascript:;" class="file">选择图片
                                                <input type="file" id="inputImage" name="file"
                                                       accept=".jpg,.jpeg,.png,.gif,.bmp,.tiff">
                                            </a>
                                        </div>

                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary" data-method="rotate"
                                                    data-option="-45" title="Rotate Left">
                                                 <span class="docs-tooltip" data-toggle="tooltip" data-animation="false"
                                                       title="向左旋转"><span class="fa fa-rotate-left"></span>
                                             </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="rotate"
                                                    data-option="45" title="Rotate Right">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="向右旋转">
              <span class="fa fa-rotate-right"></span>
            </span>
                                            </button>
                                        </div>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary" data-method="zoom"
                                                    data-option="0.1" title="Zoom In">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="放大">
              <span class="fa fa-search-plus"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="zoom"
                                                    data-option="-0.1" title="Zoom Out">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="缩小">
              <span class="fa fa-search-minus"></span>
            </span>
                                            </button>
                                        </div>

                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary" data-method="scaleX"
                                                    data-option="-1" title="Flip Horizontal">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="上下反转">
              <span class="fa fa-arrows-h"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="scaleY"
                                                    data-option="-1" title="Flip Vertical">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="左右反转">
              <span class="fa fa-arrows-v"></span>
            </span>
                                            </button>
                                        </div>

                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary" data-method="move"
                                                    data-option="-10" data-second-option="0" title="Move Left">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="左移">
              <span class="fa fa-arrow-left"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="move"
                                                    data-option="10" data-second-option="0" title="Move Right">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="右移">
              <span class="fa fa-arrow-right"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="move"
                                                    data-option="0" data-second-option="-10" title="Move Up">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="上移">
              <span class="fa fa-arrow-up"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="move"
                                                    data-option="0" data-second-option="10" title="Move Down">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="下移">
              <span class="fa fa-arrow-down"></span>
            </span>
                                            </button>
                                        </div>

                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary" data-method="crop"
                                                    title="Crop">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="图片裁剪">
              <span class="fa fa-check"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="clear"
                                                    title="Clear">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="不裁剪">
              <span class="fa fa-remove"></span>
            </span>
                                            </button>
                                        </div>

                                    </div>
                                    <div class="img-container">
                                        <img id="image" src="" alt="请选择图片">
                                    </div>
                                </div>

                            </div>

                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">活动内容</label>
                            <div class="col-sm-10">
                                <script id="content" name="content" type="text/plain"
                                        style="width: 100%; height: 260px;">${composition.content!}</script>
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
<script type="text/javascript" src="${BASE_PATH}/static/manage/assets/cropper/cropper.min.js"></script>
<script type="text/javascript" src="${BASE_PATH}/static/manage/assets/cropper/main.js"></script>
<script type="text/javascript">
<#--var kindId = ${event.id};-->
<#--var kind = "article";-->
<#--$.extend({-->
	<#--getAttachment:function(){-->
		<#--$.getJSON("${BASE_PATH}/manage/attachment/list.json?kindId="+kindId+"&v="+Math.random(),function(data){-->
			<#--$('#attachment').html("");-->
			<#--$.addAttachment(data.attachmentList);-->
		<#--});-->
	<#--},-->
	<#--addAttachment:function(list){-->
		<#--var html = '<table class="table"><thead><tr><th>文件名</th><th>大小</th><th>操作</th></tr></thead><tbody>';-->
		<#--for(i=0;i<list.length;i++){-->
			<#--var attachment = list[i];-->
			<#--html += '<tr>';-->
			<#--html += '<td>'+attachment.name+'</td>';-->
			<#--html += '<td>'+attachment.size+'</td><td>';-->
			<#--html += '<a href="javascript:void(0);" name="删除" name="'+attachment.name+'" class="btn btn-danger btn-xs js_delete" attachmentId="'+attachment.attachmentId+'">删除</a> ';-->
			<#--html += '</td></tr>';-->
		<#--}-->
		<#--html += '</tbody></table>';-->
		<#--$('#attachment').prepend(html);-->
		<#--$('#attachment .js_delete').click(function(){-->
			<#--var file = $(this);-->
			<#--bootbox.confirm("是否要删除【"+$(this).attr("name")+"】文件？", function(result) {-->
				<#--if (result) {-->
					<#--$.post("${BASE_PATH}/manage/attachment/delete.json",{'attachmentId':file.attr("attachmentId")},function(data){-->
						<#--if(data.result){-->
							<#--$.getAttachment();-->
						<#--}-->
					<#--},"json");-->
				<#--}-->
			<#--});		-->
		<#--});-->
		<#--$('#attachment .js_picture').click(function(){-->
			<#--$.post("${BASE_PATH}/manage/article/update_picture.json",{'attachmentId':$(this).attr("attachmentId"),'status':$(this).attr("status")},function(data){-->
				<#--if(data.result){-->
					<#--$.getAttachment();-->
				<#--}-->
			<#--},"json");-->
		<#--});-->
		<#--$('#attachment .js_link').click(function(){-->
			<#--var attachmentId = $(this).attr("attachmentId");-->
			<#--bootbox.prompt("为此附件增加链接", function(result) {-->
				<#--if (result !="") {-->
					<#--$.post("${BASE_PATH}/manage/attachment/update_link.json",{'attachmentId':attachmentId,'link':result},function(data){-->
						<#--if(data.result){-->
							<#--$.getAttachment();-->
						<#--}-->
					<#--},"json");					-->
				<#--} -->
			<#--});			-->
		<#--});-->
	<#--}-->
<#--});-->
$(function(){

    <#--var menus = {-->
	<#--<#list menus as f>-->
		<#--<#if f.name != "首页">-->
            <#--"${f.id}":[-->
				<#--<#list f.children as c>-->
                    <#--{"id":"${c.id}","name":"${c.name}"},-->
				<#--</#list>-->
            <#--],-->
		<#--</#if>-->
	<#--</#list>-->
    <#--};-->

    <#--var parentMenu=$("#parentMenu").val();-->
    <#--var childMenu=$("#childMenu")[0];-->
    <#--var m=menus[parentMenu];-->
    <#--childMenu.options.length=0;-->
    <#--if (typeof m == "undefined") {-->
        <#--childMenu.options.add(new Option(">>二级栏目<<", -1));-->
    <#--}else {-->
        <#--for (var i = 0; i < m.length; i++) {-->
            <#--if(m[i].id=="${article.menuId}")-->
                <#--childMenu.options.add(new Option(m[i].name, m[i].id,false,true));-->
            <#--else-->
            <#--childMenu.options.add(new Option(m[i].name, m[i].id));-->
        <#--}-->
    <#--}-->

    <#--$("#parentMenu").change(function()-->
    <#--{-->
        <#--var parentMenu=$(this).val();-->
        <#--var childMenu=$("#childMenu")[0];-->
        <#--var m=menus[parentMenu];-->
        <#--childMenu.options.length=0;-->
        <#--if (typeof m == "undefined") {-->
            <#--childMenu.options.add(new Option(">>二级栏目<<", -1));-->
        <#--}else {-->
            <#--for (var i = 0; i < m.length; i++) {-->
                <#--childMenu.options.add(new Option(m[i].name, m[i].id));-->
            <#--}-->
        <#--}-->
    <#--});-->

    $('#demo').on('show.bs.collapse', function () {
        $("#ix").attr("class","fa fa-chevron-down");
    });
    $('#demo').on('hide.bs.collapse', function () {
        $("#ix").attr("class","fa fa-chevron-right");
    });

	$('#update_composition_form').ajaxForm({
			dataType : 'json',
			success : function(data) {
				if (data.result) {
					bootbox.alert("保存成功，将刷新页面", function() {
						window.location.reload();
						
					});
				}else{
					showErrors($('#update_composition_form'),data.errors);
				}
			}
		});

//	$.getAttachment();
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
