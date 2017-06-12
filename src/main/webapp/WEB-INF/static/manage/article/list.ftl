<#assign menu="article">
<#assign submenu="article_list">
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
</style>
<!--main content start-->
<section id="main-content">
    <section class="wrapper">

        <div class="row">
            <div class="col-lg-12">
                <!--breadcrumbs start -->
                <ul class="breadcrumb">
                    <li>
                        <a href="${BASE_PATH}/manage/article/list.htm">全部文章(${allCount})</a>
                    </li>
                    <li>
                        <a href="${BASE_PATH}/manage/article/list.htm?check=init">我的文章(${admidArtCount})</a>
                    </li>
                </ul>
                <!--breadcrumbs end -->
            </div>
        </div>

        <!-- page start-->
        <section class="panel">
            <header class="panel-heading">
                <div class="row">
                    <div class="col-lg-10">

                        <select class="form-control" id="parentMenu"
                                style="font-size:15px;width: 150px; display: inline-block">
                            <option value="-1">>>一级栏目<<</option>
                        <#list menus?sort_by("sort") as f>
                            <#if f.name != "首页">
                                <option value="${f.id}">${f.name}</option>
                            </#if>
                        </#list>
                        </select>
                        <select class="form-control" id="childMenu" name="menuId"
                                style="font-size:15px;width: 150px; display: inline-block">
                            <option value="-1">>>二级栏目<<</option>
                        </select>
                        <select class="form-control" id="status"
                                style="font-size:15px;width: 120px; display: inline-block">
                            <option value="all">全部状态</option>
                            <option value="hidden">隐藏</option>
                            <option value="display">显示</option>
                        </select>

                        <select class="form-control" id="myArt"
                                style="font-size:15px;width: 120px; display: inline-block">
                            <option value="-1">全部文章</option>
                            <option value="${SESSION_ADMIN.adminId}">我的文章</option>
                        </select>

                        <input id="keywords" class="form-control" type="text"  placeholder="请输入关键词"
                        style="width:170px;display: inline-block"/>
                        <button class="btn btn-info" id="btn">搜索</button>
                    </div>
                    <div class="col-lg-2">
                        <a class="btn btn-primary" style="float:right;"
                           href="${BASE_PATH}/manage/article/add.htm">增加文章</a>
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table class="table table-striped table-advance table-hover" id="con">
                            <thead>
                            <tr>
                                <th>文章名称</th>
                                <th>状态</th>
                                <th>作者</th>
                                <th>所属栏目</th>
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
        <!-- page end-->
    </section>
</section>
<!--main content end-->
<script>
    var path = "${TEMPLATE_BASE_PATH}";
</script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/laypage.js"></script>
<script>

    var menuId = $("#childMenu").val();
    var status = $("#status").val();
    var adminId = $("#myArt").val();
    var keywords = $("#keywords").val();

    $(function () {

        var menus = {
        <#list menus as f>
            <#if f.name != "首页">
                "${f.id}": [
                    <#list f.children as c>
                        {"id": "${c.id}", "name": "${c.name}"},
                    </#list>],
            </#if>
        </#list>};

        $("#parentMenu").change(function () {
            var parentMenu = $(this).val();
            var childMenu = $("#childMenu")[0];
            var m = menus[parentMenu];

            childMenu.options.length = 0;
            if (typeof m == "undefined") {
                childMenu.options.add(new Option(">>二级栏目<<", -1));
            }else {
                for (var i = 0; i < m.length; i++) {
                    childMenu.options.add(new Option(m[i].name, m[i].id));
                }
            }
            menuId = $("#childMenu").val();
            pagination(1, menuId,status,adminId,keywords);
        });

        $("#childMenu").change(function () {
            menuId = $("#childMenu").val();
            pagination(1, menuId,status,adminId,keywords);
        });

        $("#keywords").change(function () {
            keywords = $("#keywords").val();
        });

        $("#status").change(function () {
            status = $("#status").val();
            pagination(1, menuId,status,adminId,keywords);
        });

        $("#myArt").change(function () {
            adminId = $("#myArt").val();
            pagination(1, menuId,status,adminId,keywords);
        });

        $("#btn").click(function () {
            keywords = $("#keywords").val();
            pagination(1, menuId,status,adminId,keywords);
        });

        pagination(1, menuId,status,adminId,keywords);

        $(document).on("click",".js_article_delete",function () {
            var articleId = $(this).attr('articleId');
            var status = "trash";
            bootbox.dialog({
                message: $(this).attr('title'),
                title: "提示",
                buttons: {
                    "delete": {
                        label: "确定",
                        className: "btn-success",
                        callback: function () {
                            $.post("${BASE_PATH}/manage/article/delete.json", {"articleId": articleId}, function (data) {
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

    function pagination(curr, menuId,status,adminId,keywords) {
        var index;
        $.ajax(
                {
                    url: "${BASE_PATH}/manage/article/list.json",
                    type: "post",
                    data: "p="+curr+"&menuId="+menuId+"&status="+status+"&adminId="+adminId +"&keywords="+keywords,

                    success: function (data) {

                        $("#con tbody").remove();
                        if (jQuery.isEmptyObject(data.list)) {
                            $("#page").hide();

                            return false;
                        }

                        $("#page").show();
                        var trs = "<tbody  role=\"alert\" aria-live=\"polite\" aria-relevant=\"all\">";
                        $.each(data.list, function (i, n) {
                            trs += "<tr class=\"gradeA odd\"><td><a href=\"${BASE_PATH}/manage/article/update.htm?articleId=" + n.articleId + "\">" + n.title + "</a></td>";
                            trs += "<td>";
                            if (n.status == "display")
                                trs += "显示";
                            else
                                trs += "<span style=\"color:red;\">隐藏</span>";
                            trs += "</td><td>" + n.adminName + "</td><td><a href=\"${BASE_PATH}/manage/article/list.htm?menuId=" + n.menuId + "\">" + n.menuName + "</a></td><td>" + n.createTimeView + "</td>";

                            trs += "<td><a title=\"编辑\" href=\"${BASE_PATH}/manage/article/update.htm?articleId=" + n.articleId + "\" >编辑</a> | <a title=\"是否删除文章\" href=\"javascript:void(0);\"  class=\"js_article_delete\" articleId=\"" + n.articleId + "\">删除</a> | <a href=\"${BASE_PATH}/manage/article/preview.htm?articleId=" + n.articleId + "\" target=\"_blank\">预览</a></td></tr>";

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
                                    pagination(obj.curr, menuId,status,adminId,keywords);
                                }
                            }
                        });
                    }
                }
        );
    }

</script>
<#include "/manage/foot.ftl">
