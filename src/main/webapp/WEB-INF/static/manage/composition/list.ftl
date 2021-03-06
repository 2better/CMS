<#assign menu="composition">
<#assign submenu="result">
<#include "/manage/head.ftl">
<!--main content start-->
<style>
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
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <section class="panel">
            <header class="panel-heading">
                <div class="row">
                    <div class="col-lg-12">
                        <a class="btn btn-primary" style="float:right;"
                           href="${BASE_PATH}/manage/composition/add.htm">增加著作</a>
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table class="table table-striped table-advance table-hover" id="con">
                            <thead>
                            <tr>
                                <th width='50%'>著作名称</th>
                                <th width='20%'>封面</th>
                                <th width='15%'>编辑时间</th>
                                <th width='15%'>操作</th>
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
        <!-- page end-->
    </section>
</section>
<!--main content end-->
<script>
    var path = "${TEMPLATE_BASE_PATH}";
</script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/laypage.js"></script>
<script>

    $(function () {
        $("#btn").click(function () {
            pagination(1);
        });

        pagination(1);

        $(document).on("click",".js_composition_delete",function () {
            var id = $(this).attr('id');
            var status = "trash";
            bootbox.dialog({
                message: $(this).attr('name'),
                name: "提示",
                buttons: {
                    "delete": {
                        label: "确定",
                        className: "btn-success",
                        callback: function () {
                            $.post("${BASE_PATH}/manage/composition/delete.json", {"id": id}, function (data) {
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

    function pagination(curr) {
        var index;
        $.ajax(
                {
                    url: "${BASE_PATH}/manage/composition/list.json",
                    type: "GET",
                    data: "p="+curr,

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
                            trs += "<tr class=\"gradeA odd\"><td><a href=\"${BASE_PATH}/manage/composition/update.htm?id=" + n.id + "\">" + n.title + "</a></td>";
                            trs += "<td><img src='/" + n.picUrl + "' width='100' height='50'/></td><td>" + n.createTimeView + "</td>";

                            trs += "<td><a name=\"编辑\" href=\"${BASE_PATH}/manage/composition/update.htm?id=" + n.id + "\" >编辑</a> | <a name=\"是否删除活动\" href=\"javascript:void(0);\"  class=\"js_composition_delete\" id=\"" + n.id + "\">删除</a> | <a href=\"${BASE_PATH}/composition/"+ n.id +".htm\" target=\"_blank\">预览</a></td></tr>";

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
