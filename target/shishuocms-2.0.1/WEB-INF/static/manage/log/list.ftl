<#assign menu="log">
<#assign submenu="cog">
<#include "/manage/head.ftl">
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

    #con {
        table-layout: fixed;
        width: 100%;
    }

    #con td {
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }
</style>
<!--main content start-->
<section id="main-content">
    <section class="wrapper">

        <!-- page start-->
        <section class="panel">
            <header class="panel-heading">
                <div class="row">
                    <div class="col-lg-8">
                        <input id="myArt" class="form-control" type="text" placeholder="选择时间" readonly
                               style="width:200px;display: inline-block;cursor: pointer" autocomplete="off"/>&nbsp;至&nbsp;
                        <input id="keywords" class="form-control" type="text" placeholder="选择时间" readonly
                               style="width:200px;display: inline-block;cursor: pointer" autocomplete="off"/>
                        <button class="btn btn-info" id="btn">搜索</button>
                    </div>
                    <div class="col-lg-4">
                        <a class="btn btn-primary" id="clean" style="float:right;"
                           href="javascript:void(0);">清空日志</a>
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table id="con" class="table table-striped table-advance table-hover">
                            <thead>
                            <tr>
                                <th width='10%'>用户名称</th>
                                <th width='20%'>类名称</th>
                                <th width='10%'>方法名称</th>
                                <th width='20%'>记录时间</th>
                                <th width='25%'>信息</th>
                                <th width='15%'>操作</th>
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
<script>
    var path = "${TEMPLATE_BASE_PATH}";
</script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/laypage.js"></script>
<script type="text/javascript" src="${BASE_PATH}/static/manage/js/laydate/laydate.js"></script>
<script>

    laydate.render({
        elem: '#myArt'
        ,type: 'datetime'
    });

    laydate.render({
        elem: '#keywords'
        ,type: 'datetime'
    });

    var adminId = $("#myArt").val();
    var keywords = $("#keywords").val();

    $(function () {

        pagination(1, adminId, keywords);

        $("#btn").click(function () {
            adminId = $("#myArt").val();
            keywords = $("#keywords").val();
            pagination(1, adminId, keywords);
        });


        $(document).on("click", ".js_article_preview", function () {
            var articleId = $(this).attr('articleId');
            $.post("${BASE_PATH}/manage/preview/preview.json", {"id": articleId}, function (data) {
                if (data.result) {
                    window.open("${BASE_PATH}/manage/preview/previewPage.htm?pdfFilePath="+data.t,'_blank',"fullscreen=yes");
                }else{
                    bootbox.alert(data.msg);
                }
            }, "json");
        });

        $(document).on("click", "#clean", function () {
            var articleId = $(this).attr('articleId');
            var status = "trash";
            bootbox.dialog({
                message: "确定要清空日志？",
                name: "提示",
                buttons: {
                    "delete": {
                        label: "确定",
                        className: "btn-success",
                        callback: function () {
                            $.post("${BASE_PATH}/manage/log/clean.json", {}, function (data) {
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

    });

    function pagination(curr, adminId, keywords) {
        $.ajax(
                {
                    url: "${BASE_PATH}/manage/log/list.json",
                    type: "post",
                    data: "p=" + curr + "&begin=" + adminId + "&end=" + keywords,

                    success: function (data) {

                        $("#con tbody").remove();
                        if (jQuery.isEmptyObject(data.list)) {
                            $("#page").hide();

                            return false;
                        }

                        $("#page").show();
                        var trs = "<tbody  role=\"alert\" aria-live=\"polite\" aria-relevant=\"all\">";
                        $.each(data.list, function (i, n) {
                            trs += "<tr class=\"gradeA odd\"><td >" + n.userName + "</td>";
                            trs += "<td  >" + n.className + "</td>";
                            trs += "<td>" + n.methodName + "</td>";
                            trs += "<td >" + n.createTimeView + "</td>";
                            trs += "<td >" + n.message + "</td>";
                            var str = n.createTimeView.substring(0,10) ;
                            str = str.replace(new RegExp("\/","gm"),"-");
                            trs += "<td ><a name=\"下载\" target=\"_self\" href=\"${BASE_PATH}/manage/log/download/" + str + "\" >日志下载</a> | <a href=\"${BASE_PATH}/manage/log/detail.htm?id=" + n.id + "\">详情</a></td></tr>";

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
                                    pagination(obj.curr, adminId, keywords);
                                }
                            }
                        });
                    }
                }
        );
    }
</script>
<#include "/manage/foot.ftl">
