<#assign menu="user_list">
<#assign submenu="user_list">
<#include "/manage/head.ftl">
<style type="text/css">
    .pagination {
        border-radius: 4px;
        display: inline-block;
        margin: 0;
        padding-left: 0;
    }
</style>
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <div class="row">
            <div class="col-lg-12">
                <!--breadcrumbs start -->
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>用户管理</a>
                    </li>
                </ul>
                <!--breadcrumbs end -->
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4">
                <section class="panel">
                    <header class="panel-heading"> 添加用户</header>
                    <div class="panel-body">
                        <form id="add_user_form" method="post" class="form-horizontal" autocomplete="off"
                              action="${BASE_PATH}/manage/user/addNew.json">
                            <fieldset>
                                <div class="form-group">
                                    <label class="col-sm-3 col-sm-3 control-label">姓名</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" name="userName"
                                               placeholder="姓名" id="userName">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 col-sm-3 control-label">密码</label>
                                    <div class="col-sm-9">
                                        <input type="password" class="form-control" name="password"
                                               placeholder="密码">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 col-sm-3 control-label"></label>
                                    <div class="col-sm-9">
                                        <button class="btn btn-danger" type="submit">增加</button>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </section>
            </div>
            <div class="col-lg-8">
                <section class="panel">
                    <header class="panel-heading"> 用户列表</header>
                    <div class="panel-body">
                        <div class="adv-table">
                            <div role="grid" class="dataTables_wrapper"
                                 id="hidden-table-info_wrapper">
                                <table class="table table-striped table-advance table-hover" id="con">
                                    <thead>
                                    <tr>
                                        <th>姓名</th>
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
            </div>
            <!-- page end-->
    </section>
</section>
<script>
    var path = "${TEMPLATE_BASE_PATH}";
</script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/laypage.js"></script>
<script type="text/javascript">
    $(function () {

        pagination(1);

        $('#add_user_form').ajaxForm({
            dataType: 'json',
            success: function (data) {
                if (data.result) {
                    bootbox.alert("保存成功，将刷新页面", function () {
                        window.location.reload();
                    });
                } else {
                    showErrors($('#add_user_form'), data.errors);
                }
            }
        });
        $(document).on("click",".js_delete_user",function () {
            var userId = $(this).attr('userId');
            bootbox.dialog({
                message: "是否" + $(this).attr('title') + "用户",
                title: "提示",
                buttons: {
                    "delete": {
                        label: "删除",
                        className: "btn-success",
                        callback: function () {
                            $.post("${BASE_PATH}/manage/user/delete.json", {
                                        "userId": userId
                                    },
                                    function (data) {
                                        if (data.result) {
                                            bootbox.alert("删除成功",
                                                    function () {
                                                        window.location.reload();
                                                    });
                                        } else {
                                            bootbox.alert(data.msg,
                                                    function () {
                                                    });
                                        }
                                    },
                                    "json");
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
                    url: "${BASE_PATH}/manage/user/list.json",
                    type: "post",
                    data: "p=" + curr,

                    success: function (data) {

                        $("#con tbody").remove();
                        if (jQuery.isEmptyObject(data.list)) {
                            $("#page").hide();

                            return false;
                        }

                        $("#page").show();
                        var trs = "<tbody  role=\"alert\" aria-live=\"polite\" aria-relevant=\"all\">";
                        $.each(data.list, function (i, n) {
                            trs += "<tr class=\"gradeA odd\"><td>"+n.name+"</td>";

                            trs += "<td><a title=\"是否删除该用户\" href=\"javascript:void(0);\"  class=\"js_delete_user\" userId=\"" + n.userId + "\">删除</a></td></tr>";

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