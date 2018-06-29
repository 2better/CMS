<#assign menu="preview">
<#assign submenu="preview_list">
<#include "/manage/head.ftl">
<link href="${TEMPLATE_BASE_PATH}/css/jquery.mloading.css"
      rel="stylesheet"/>
<style type="text/css">
    .pagination {
        border-radius: 4px;
        display: inline-block;
        margin: 0;
        padding-left: 0;
    }

    .howto, .nonessential, #edit-slug-box, .form-input-tip, .subsubsub {
        color: #666666;
    }

    .subsubsub {
        float: left;
        font-size: 12px;
        list-style: none outside none;
        margin: 8px 0 5px;
        padding: 0;
    }

    .form-group {
        width: 100%;
    }

    .count {
        position: absolute;
        right: 0px;
    }

    .arrticle_status {
        float: left;
    }
</style>
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <div class="row">
            <div class="col-lg-12">
                <!--breadcrumbs start -->
                <ul class="breadcrumb">
                    <li>
                        全部文档(${count})
                    </li>
                </ul>
                <!--breadcrumbs end -->
            </div>
        </div>

        <!-- page start-->
        <section class="panel">
            <header class="panel-heading">
                <div class="row">
                    <div class="col-lg-8">
                        <select class="form-control" id="myArt"
                                style="font-size:15px;width: 120px; display: inline-block">
                            <option value="-1">全部文章</option>
                            <option value="${SESSION_ADMIN.adminId}">我的文章</option>
                        </select>

                        <select class="form-control" id="column"
                                style="font-size:15px;width: 120px; display: inline-block">
                            <option value="-1">所有类目</option>
                            <option value="1">智库专报</option>
                            <option value="2">学术论文</option>
                        </select>

                        <input id="keywords" class="form-control" type="text" placeholder="请输入关键词"
                               style="width:200px;display: inline-block" autocomplete="off"/>
                        <button class="btn btn-info" id="btn">搜索</button>
                    </div>
                    <div class="col-lg-4">
                        <a class="btn btn-primary" style="float:right;"
                           href="${BASE_PATH}/manage/preview/add.htm">上传文档</a>
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table id="con" class="table table-striped table-advance table-hover">
                            <thead>
                            <tr>
                                <th>文档名称</th>
                                <th>所属类目</th>
                                <th>上传者</th>
                                <th>文档类型</th>
                                <th>上传时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody role="alert" aria-live="polite" aria-relevant="all">


                            </tbody>
                        </table>
                        <div style="height: 30px;">
                            <div id="page" style="float:right"></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- page end-->
    </section>
</section>
<!--main content end-->

<div id="myspin"></div>

<script>
    var path = "${TEMPLATE_BASE_PATH}";
</script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/laypage.js"></script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/jquery.mloading.js"></script>
<script>

    var adminId = $("#myArt").val();
    var keywords = $("#keywords").val();
    var column = $("#column").val();

    $(function () {

        pagination(1, adminId, keywords,column);

        $("#myArt").change(function () {
            adminId = $("#myArt").val();
            pagination(1, adminId, keywords,column);
        });

        $("#column").change(function () {
            column = $("#column").val();
            pagination(1, adminId, keywords,column);
        });

        $("#keywords").change(function () {
            keywords = $("#keywords").val();
        });

        $("#btn").click(function () {
            keywords = $("#keywords").val();
            pagination(1, adminId, keywords,column);
        });

        $(document).on("click", ".js_article_delete", function () {
            var articleId = $(this).attr('articleId');
            var status = "trash";
            bootbox.dialog({
                message: $(this).attr('name'),
                name: "提示",
                buttons: {
                    "delete": {
                        label: "确定",
                        className: "btn-success",
                        callback: function () {
                            $.post("${BASE_PATH}/manage/preview/delete.json", {"id": articleId}, function (data) {
                                window.location.reload();
                            }, "json");
                        }
                    },
                    "cancel": {
                        label: "取消",
                        className: "btn-primary",
                        callback: function () {

                        }
                    }
                }
            });
        });

        $(document).on("click", ".js_article_preview", function () {
            var articleId = $(this).attr('articleId');


            $.ajax({
                url:"${BASE_PATH}/manage/preview/preview.json",
                type:"post",
                data:{"id": articleId},
                dataType:"json",
                beforeSend:function () {//ajax处理之前出现spin图标
                    $("body").mLoading("show");
                },
                success:function (data) {
                    if (data.result) {
                        window.open("${BASE_PATH}/manage/preview/previewPage.htm?pdfFilePath="+data.t,'_blank',"fullscreen=yes");
                    }else{
                        bootbox.alert(data.msg);
                    }
                },
                complete:function () {//ajax请求成功0.3秒以后，关闭loading图标
                    $("body").mLoading("hide");
                }
        });

        });

    });

    function pagination(curr, adminId, keywords,column) {
        $.ajax(
                {
                    url: "${BASE_PATH}/manage/preview/list.json",
                    type: "post",
                    data: "p=" + curr + "&adminId=" + adminId + "&keywords=" + keywords+"&column="+column,

                    success: function (data) {

                        $("#con tbody").remove();
                        if (jQuery.isEmptyObject(data.list)) {
                            $("#page").hide();

                            return false;
                        }

                        $("#page").show();
                        var trs = "<tbody  role=\"alert\" aria-live=\"polite\" aria-relevant=\"all\">";
                        $.each(data.list, function (i, n) {
                            trs += "<tr class=\"gradeA odd\"><td style='width:46%'><a href=\"${BASE_PATH}/manage/preview/download.htm?id=" + n.id + "\">" + n.name + "</a></td>";
                            trs += "<td>" + n.columnView + "</td>";
                            trs += "<td>" + n.adminName + "</td>";
                            trs += "<td>" + n.type + "</td>";
                            trs += "<td>" + n.createdView + "</td>";

                            trs += "<td><a name=\"下载\" target=\"_self\" href=\"${BASE_PATH}/manage/preview/download.htm?id=" + n.id + "\" >下载</a> | <a name=\"是否删除文档\" href=\"javascript:void(0);\"  class=\"js_article_delete\" articleId=\"" + n.id + "\">删除</a> | <a href=\"javascript:void(0);\" class=\"js_article_preview\" articleId=\"" + n.id + "\">预览</a></td></tr>";

                        });
                        $("#con").append(trs + "</tbody>");

                        laypage({
                            cont: 'page', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
                            pages: data.pageCount, //通过后台拿到的总页数
                            curr: curr || 1, //当前页
                            skip: true, //是否开启跳页
                            groups: 3,//连续显示分页数
                            skin: '#5a98de',
                            first: 1,
                            last: data.pageCount,
                            jump: function (obj, first) { //触发分页后的回调
                                if (!first) { //点击跳页触发函数自身，并传递当前页：obj.curr
                                    pagination(obj.curr, adminId, keywords,column);
                                }
                            }
                        });
                    }
                }
        );
    }
</script>

<#include "/manage/foot.ftl">
