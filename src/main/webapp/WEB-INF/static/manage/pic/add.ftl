<#assign menu="picture">
<#assign submenu="cog">
<#include "/manage/head.ftl">
<link href="${BASE_PATH}/static/manage/assets/cropper/cropper.min.css" rel="stylesheet" type="text/css" media="all">
<link href="${BASE_PATH}/static/manage/assets/cropper/main.css" rel="stylesheet" type="text/css" media="all">

<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <form class="avatar-form form-horizontal"  action="${BASE_PATH}/manage/picture/add.action" enctype="multipart/form-data" method="post">
        <div class="row">
                <div class="col-lg-12">
                    <section class="panel">
                        <header class="panel-heading">
                            增加展示图
                        </header>
                        <div class="panel-body">

                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">展示图类型</label>
                                <div class="col-sm-10">
                                    <#--<div class="checkbox checkbox-info" style="display: inline-block">
                                        <input type="radio" name="type" id="radio1" value="1" checked>
                                        <label for="radio1">
                                            大图
                                        </label>
                                    </div>
                                    <div class="checkbox checkbox-info" style="display: inline-block">
                                        <input type="radio" name="type" id="radio2" value="0" >
                                        <label for="radio2">
                                            小图
                                        </label>
                                    </div>-->
                                        <select class="form-control input-lg m-bot15"
                                                style="font-size:15px;width: 200px;" name="type">
                                            <option value="0">轮播图</option>
                                            <option value="1">重要活动</option>
                                            <option value="2">主任致辞</option>
                                        </select>
                                </div>
                            </div>

                            <div class="avatar-body">

                                <!-- Upload image and data -->

                                    <input type="hidden" class="avatar-src" name="avatar_src">
                                    <input type="hidden" class="avatar-data" name="x">
                                    <input type="hidden" class="avatar-data" name="y">
                                    <input type="hidden" class="avatar-data" name="height">
                                    <input type="hidden" class="avatar-data" name="width">
                                    <input type="hidden" class="avatar-data" name="rotate">

                                <div class="form-group avatar-upload">
                                    <label class="col-xs-2 control-label">选择图片</label>
                                    <div class="col-xs-10">
                                        <a href="javascript:;" class="file">选择图片
                                        <input type="file"  id="inputImage" name="img" accept=".jpg,.jpeg,.png,.gif,.bmp,.tiff">
                                        </a>
                                    </div>
                                </div>


                                <!-- Crop and preview -->
                                <div class="row">
                                    <div class="col-md-9">
                                        <div class="img-container">
                                            <img id="image" src="" alt="请选择图片">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="docs-preview clearfix">
                                            <div class="img-preview preview-lg"></div>
                                        </div>
                                        <div class="docs-data">
                                        <div class="input-group input-group-sm">
                                            <label class="input-group-addon" for="dataX">X</label>
                                            <input type="text" class="form-control" id="dataX" name="x" placeholder="x" >
                                            <span class="input-group-addon">px</span>
                                        </div>
                                        <div class="input-group input-group-sm">
                                            <label class="input-group-addon" for="dataY">Y</label>
                                            <input type="text" class="form-control" id="dataY" name="y" placeholder="y">
                                            <span class="input-group-addon">px</span>
                                        </div>
                                        <div class="input-group input-group-sm">
                                            <label class="input-group-addon" for="dataWidth">Width</label>
                                            <input type="text" class="form-control" id="dataWidth" name="width" placeholder="width">
                                            <span class="input-group-addon">px</span>
                                        </div>
                                        <div class="input-group input-group-sm">
                                            <label class="input-group-addon" for="dataHeight">Height</label>
                                            <input type="text" class="form-control" id="dataHeight" name="height" placeholder="height">
                                            <span class="input-group-addon">px</span>
                                        </div>
                                        <div class="input-group input-group-sm">
                                            <label class="input-group-addon" for="dataRotate">旋转</label>
                                            <input type="text" class="form-control" id="dataRotate" placeholder="rotate">
                                            <span class="input-group-addon">度</span>
                                        </div>
                                        <div class="input-group input-group-sm">
                                            <label class="input-group-addon" for="dataScaleX">宽高比</label>
                                            <input type="text" class="form-control" id="dataScaleX" placeholder="scale">
                                        </div>
                                    </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-9 docs-buttons">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary" data-method="rotate" data-option="-45" title="Rotate Left">
                                                 <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="向左旋转"><span class="fa fa-rotate-left"></span>
                                             </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="rotate" data-option="45" title="Rotate Right">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="向右旋转">
              <span class="fa fa-rotate-right"></span>
            </span>
                                            </button>
                                        </div>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary" data-method="zoom" data-option="0.1" title="Zoom In">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="放大">
              <span class="fa fa-search-plus"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="zoom" data-option="-0.1" title="Zoom Out">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="缩小">
              <span class="fa fa-search-minus"></span>
            </span>
                                            </button>
                                        </div>

                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary" data-method="scaleX" data-option="-1" title="Flip Horizontal">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="上下反转">
              <span class="fa fa-arrows-h"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="scaleY" data-option="-1" title="Flip Vertical">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="左右反转">
              <span class="fa fa-arrows-v"></span>
            </span>
                                            </button>
                                        </div>

                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary" data-method="move" data-option="-10" data-second-option="0" title="Move Left">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="左移">
              <span class="fa fa-arrow-left"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="move" data-option="10" data-second-option="0" title="Move Right">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="右移">
              <span class="fa fa-arrow-right"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="move" data-option="0" data-second-option="-10" title="Move Up">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="上移">
              <span class="fa fa-arrow-up"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="move" data-option="0" data-second-option="10" title="Move Down">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="下移">
              <span class="fa fa-arrow-down"></span>
            </span>
                                            </button>
                                        </div>

                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary" data-method="crop" title="Crop">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="图片裁剪">
              <span class="fa fa-check"></span>
            </span>
                                            </button>
                                            <button type="button" class="btn btn-primary" data-method="clear" title="Clear">
            <span class="docs-tooltip" data-toggle="tooltip" data-animation="false" title="不裁剪">
              <span class="fa fa-remove"></span>
            </span>
                                            </button>
                                        </div>

                                    </div>
                                    <div class="col-md-3">
                                        <button type="submit" class="btn btn-primary btn-block avatar-save">上传</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </section>
                    <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
                </div>
            </div>
        </form>
        <!-- page end-->
    </section>
</section>
<!--main content end-->
<script type="text/javascript" src="${BASE_PATH}/static/manage/assets/cropper/cropper.min.js"></script>
<script type="text/javascript" src="${BASE_PATH}/static/manage/assets/cropper/main.js"></script>

<#include "/manage/foot.ftl">

