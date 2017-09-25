<#assign menu="picture">
<#assign submenu="cog">
<#include "/manage/head.ftl">
<link href="${BASE_PATH}/static/manage/assets/shearphoto/css/MIN_ShearPhoto.css" rel="stylesheet" type="text/css" media="all">
<script>
    var relativeUrl = "${BASE_PATH}/static/manage/assets/shearphoto/";
    var actionUrl = "${BASE_PATH}//manage/picture/add.action";
</script>
<script type="text/javascript" src="${BASE_PATH}/static/manage/assets/shearphoto/js/ShearPhoto.js"></script>
<script type="text/javascript" src="${BASE_PATH}/static/manage/assets/shearphoto/js/MIN_alloyimage.js"></script>
<script type="text/javascript" src="${BASE_PATH}/static/manage/assets/shearphoto/js/handle.js"></script>
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <form id="ShearPhotoForm" class="form-horizontal" target="POSTiframe"  method="post" enctype="multipart/form-data">
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
                                    <div class="checkbox checkbox-info" style="display: inline-block">
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
                                    </div>
                                </div>
                            </div>

                            <div id="shearphoto_loading">程序加载中......</div>
                            <div id="shearphoto_main">
                                <!--primary范围开始-->
                                <div class="primary">
                                    <!--main范围开始-->
                                    <div id="main">
                                        <div class="point">
                                        </div>
                                        <!--选择加载图片方式开始-->
                                        <div id="SelectBox">
                                                <!--示例传参数到服务端，后端文件UPLOAD.php用$_POST['shearphoto']接收,注意：HTML5切图时，这个参数是不会传的-->
                                                <a href="javascript:;" id="selectImage">
                                                    <input type="file" name="UpFile" autocomplete="off" />
                                                </a>
                                        </div>
                                        <!--选择加载图片方式结束--->
                                        <div id="relat">
                                            <div id="black">
                                            </div>
                                            <div id="movebox">
                                                <div id="smallbox">
                                                    <img src="${BASE_PATH}/static/manage/assets/shearphoto/images/default.gif" class="MoveImg" />
                                                    <!--截框上的小图-->
                                                </div>
                                                <!--动态边框开始-->
                                                <i id="borderTop">
                                                </i>

                                                <i id="borderLeft">
                                                </i>

                                                <i id="borderRight">
                                                </i>

                                                <i id="borderBottom">
                                                </i>
                                                <!--动态边框结束-->
                                                <i id="BottomRight">
                                                </i>
                                                <i id="TopRight">
                                                </i>
                                                <i id="Bottomleft">
                                                </i>
                                                <i id="Topleft">
                                                </i>
                                                <i id="Topmiddle">
                                                </i>
                                                <i id="leftmiddle">
                                                </i>
                                                <i id="Rightmiddle">
                                                </i>
                                                <i id="Bottommiddle">
                                                </i>
                                            </div>
                                            <img src="${BASE_PATH}/static/manage/assets/shearphoto/images/default.gif" class="BigImg" />
                                            <!--MAIN上的大图-->
                                        </div>
                                    </div>
                                    <!--main范围结束-->
                                    <div style="clear: both"></div>
                                    <!--工具条开始-->
                                    <div id="Shearbar">
                                        <a id="LeftRotate" href="javascript:;">
                                            <em>
                                            </em> 向左旋转
                                        </a>
                                        <em class="hint L">
                                        </em>
                                        <div class="ZoomDist" id="ZoomDist">
                                            <div id="Zoomcentre">
                                            </div>
                                            <div id="ZoomBar">
                                            </div>
                                            <span class="progress">
                        </span>
                                        </div>
                                        <em class="hint R">
                                        </em>
                                        <a id="RightRotate" href="javascript:;">
                                            向右旋转
                                            <em>
                                            </em>
                                        </a>
                                        <p class="Psava">
                                            <a id="againIMG" href="javascript:;">重新选择</a>
                                            <a id="saveShear" href="javascript:;">确定上传</a>
                                        </p>
                                    </div>
                                    <!--工具条结束-->
                                </div>
                                <!--primary范围结束-->
                                <div style="clear: both"></div>
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
<#include "/manage/foot.ftl">