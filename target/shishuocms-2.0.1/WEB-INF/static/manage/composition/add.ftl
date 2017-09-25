<#assign menu="composition">
<#assign submenu="result">
<#include "/manage/head.ftl">
<link href="${BASE_PATH}/static/manage/assets/cropper/cropper.min.css" rel="stylesheet" type="text/css" media="all">
<link href="${BASE_PATH}/static/manage/assets/cropper/main.css" rel="stylesheet" type="text/css" media="all">
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <form id="add_composition_form" class="form-horizontal" action="${BASE_PATH}/manage/composition/add.json"
              autocomplete="off" method="post"
              enctype="multipart/form-data">
            <div class="avatar-body">
                <div class="row">
                    <div class="col-lg-12">
                        <section class="panel">
                            <header class="panel-heading">
                                增加著作
                            </header>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">著作名称</label>
                                    <div class="col-sm-10">
                                        <input type="text" style="font-size:15px;width: 300px;" class="form-control"
                                               name="title"
                                               placeholder="著作名称" id="name">
                                        </input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 col-sm-2 control-label">发布时间</label>
                                    <div class="col-sm-10">
                                        <input type="text" data-link-format="yyyy-MM-dd" data-date-format="yyyy-MM-dd"
                                               style="font-size:15px;width: 200px;" class="js_create_time"
                                               name="createTime"
                                               placeholder="发布时间" id="createTime" value="${.now?string("yyyy-MM-dd")}">
                                        </input>
                                    </div>
                                </div>
                                <div class="form-group panel panel-default">
                                    <label class="col-sm-2 control-label">
                                        著作封面
                                    </label>
                                    <div class="col-sm-10">
                                        <a href="#demo" data-toggle="collapse" style="font-size: 16px;">点击上传封面&nbsp;&nbsp;<i
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
                                    <label class="col-sm-2 col-sm-2 control-label">著作内容</label>
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
                                        <button class="btn btn-primary avatar-save" type="submit">发布</button>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
        </form>
        <!-- page end-->
    </section>
</section>
<!--main content end-->
<script type="text/javascript" src="${BASE_PATH}/static/manage/assets/cropper/cropper.min.js"></script>
<script type="text/javascript" src="${BASE_PATH}/static/manage/assets/cropper/main.js"></script>
<script type="text/javascript">

    $(function () {

        $('#demo').on('show.bs.collapse', function () {
            $("#ix").attr("class","fa fa-chevron-down");
        });
        $('#demo').on('hide.bs.collapse', function () {
            $("#ix").attr("class","fa fa-chevron-right");
        });

        $('#add_composition_form').ajaxForm({
            dataType: 'json',
            success: function (data) {
                if (data.result) {
                    bootbox.alert("保存成功，将刷新页面", function () {
                        window.location.reload();
                    });
                } else {
                    showErrors($('#add_composition_form'), data.errors);
                }
            }
        });

        $('.js_create_time').datetimepicker({
            language: 'zh-CN',
            format: "yyyy-mm-dd",
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        });
    });
</script>
<#include "/manage/foot.ftl">