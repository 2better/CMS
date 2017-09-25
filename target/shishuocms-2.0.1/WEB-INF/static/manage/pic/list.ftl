<#assign menu="picture">
<#assign submenu="cog">
<#include "/manage/head.ftl">
<link rel="stylesheet" href="${BASE_PATH}/static/manage/pic/ssi-uploader.css"/>
<section id="main-content">
    <section class="wrapper">
        <div class="row">
            <div class="col-md-12">
                <h3>上传轮播图</h3>
                <h4>是否为大图:
                    <input type="radio" name="type" value="1">是
                    <input type="radio" name="type" value="0" checked>否
                </h4>
                <input type="file" multiple id="ssi-upload"/>
            </div>
        </div>
        <!-- page end-->
        <!-- page start-->
        <section class="panel">
            <header class="panel-heading">
                <div class="row">
                    轮播图列表
                </div>
            </header>
            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table class="table table-striped table-advance table-hover" id="con">
                            <thead>
                            <tr>
                                <th>图片</th>
                                <th>是否为大图</th>
                                <th>编辑时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                        </table>
                        <div style="height: 30px;">
                            <div id="page" style="float:right"></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </section>
</section>
<script src="${BASE_PATH}/static/manage/pic/ssi-uploader.js"></script>
<script type="text/javascript">
    $('#ssi-upload').ssi_uploader({
        url: '${BASE_PATH}/manage/picture/add.json', allowed: ['jpg', 'gif', 'png'], maxFileSize: 50,
        maxNumberOfFiles:6,
        responseValidation: {
            validationKey: {
                success: 'success',
                error: 'error'
            },
            resultKey: 'validationKey'
        }, onUpload: function () {
            pagination(1);
        },
        beforeEachUpload: function (file) {
            console.log(file);
            console.log(file.width);
        }
    });
</script>
<script>
    var path = "${TEMPLATE_BASE_PATH}";
</script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/laypage.js"></script>
<script>
    pagination(1);

    $(document).on("click", ".js_picture_delete", function () {
        var id = $(this).attr('id');
        var status = "trash";
        bootbox.dialog({
            message: "是否删除图片",
            name: "提示",
            buttons: {
                "delete": {
                    label: "确定",
                    className: "btn-success",
                    callback: function () {
                        $.post("${BASE_PATH}/manage/picture/delete.json", {"id": id}, function (data) {
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
    function pagination(curr) {
        var index;
        $.ajax(
                {
                    url: "${BASE_PATH}/manage/picture/list.json",
                    type: "GET",
                    data: "p=" + curr,

                    success: function (data) {
                        console.log(data);
                        $("#con tbody").remove();
                        if (jQuery.isEmptyObject(data.list)) {
                            $("#page").hide();

                            return false;
                        }

                        $("#page").show();
                        var trs = "<tbody  role=\"alert\" aria-live=\"polite\" aria-relevant=\"all\">";
                        $.each(data.list, function (i, n) {
                            trs += "<tr class=\"gradeA odd\"><td><img src='/" + n.picUrl + "'width='100' height='50'/></td>";
                            trs += "<td>" + n.picType + "</td>";
                            trs += "<td>" + n.createTimeView + "</td>";
                            trs += "<td><a name=\"是否删除活动\" href=\"javascript:void(0);\"  class=\"js_picture_delete\" id=\"" + n.id + "\">删除</a></td></tr>";
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
                                    pagination(obj.curr);
                                }
                            }
                        });
                    }
                }
        );
    }
</script>

<#include "/manage/foot.ftl">