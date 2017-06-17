<#assign menu="menu">
<#assign submenu="cog">
<#include "/manage/head.ftl">
<style type="text/css">
    .dropdown-submenu {
        position: relative;
    }
    .dropdown-submenu > .dropdown-menu {
        top: 0;
        left: 100%;
        margin-top: -6px;
        margin-left: -1px;
        -webkit-border-radius: 0 6px 6px 6px;
        -moz-border-radius: 0 6px 6px;
        border-radius: 0 6px 6px 6px;
    }
    .dropdown-submenu:hover > .dropdown-menu {
        display: block;
    }
    .dropdown-submenu > a:after {
        display: block;
        content: " ";
        float: right;
        width: 0;
        height: 0;
        border-color: transparent;
        border-style: solid;
        border-width: 5px 0 5px 5px;
        border-left-color: #ccc;
        margin-top: 5px;
        margin-right: -10px;
    }
    .dropdown-submenu:hover > a:after {
        border-left-color: #fff;
    }
    .dropdown-submenu.pull-left {
        float: none;
    }
    .dropdown-submenu.pull-left > .dropdown-menu {
        left: -100%;
        margin-left: 10px;
        -webkit-border-radius: 6px 0 6px 6px;
        -moz-border-radius: 6px 0 6px 6px;
        border-radius: 6px 0 6px 6px;
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
                    <li><i class="icon-home"></i> 菜单管理</a></li>
                </ul>
                <!--breadcrumbs end -->
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <section class="panel ">
                    <header class="panel-heading">
                        <#--<div class="col-lg-8">
                        <label class="control-label">上级菜单</label>
                        <select id="mm" class="input-lg" style="font-size:12px;width: 150px;height:40px">
                            <option value="0">根菜单</option>
                        <#list menuParentsList?sort_by("sort") as f>
                            <option value="${f.id}" <#if Menu.id ==f.id>selected</#if>>${f.name}</option>
                        </#list>
                        </select>
                        </div>-->
                            <div class="col-lg-8">
                                <label class="control-label" style="font-size: 14px;">上级菜单</label>
                                <div class="dropdown" style="display: inline-block;">
                                    <a id="dLabel" role="button" data-toggle="dropdown" class="btn btn-primary" data-target="#"
                                       href="javascript:;" menuId="${Menu.id}">
                                        ${Menu.name} <span class="caret"></span>
                                    </a>
                                    <ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
                                        <li class="divider"></li>
                                        <li><a href="javascript:;" menuId="0" class="dLabel hd">根菜单</a></li>
                                        <li class="divider hd"></li>
                                        <#list menuParentsList?sort_by("sort") as f>
                                            <#if (f.children?size > 0)>
                                                <li class="dropdown-submenu">
                                                    <a tabindex="-1" href="javascript:;" class="dLabel" menuId="${f.id}" >${f.name}</a>
                                                    <ul class="dropdown-menu">
                                                        <li class="divider"></li>
                                                         <#list f.children?sort_by("sort") as c>
                                                                <li><a href="javascript:;"  menuId="${c.id}" class="dLabel">${c.name}</a></li>
                                                                <li class="divider"></li>
                                                         </#list>
                                                    </ul>
                                                </li>
                                                <li class="divider"></li>
                                            <#else>
                                                <li><a href="javascript:;" menuId="${f.id}" class="dLabel">${f.name}</a></li>
                                                <li class="divider"></li>
                                            </#if>
                                        </#list>
                                    </ul>
                                </div>
                            </div>
                        <div class="col-lg-4">
                            <a class="btn btn-primary" style="float:right;"
                               href="${BASE_PATH}/manage/menu/add.htm?id=${Menu.id}">增加菜单</a>
                        </div>
                    </header>
                    <div class="panel-body">
                        <div class="adv-table">
                            <div role="grid" class="dataTables_wrapper"
                                 id="hidden-table-info_wrapper">
                                <table class="table table-striped table-advance table-hover">
                                    <thead>
                                    <tr>
                                        <th>顺序</th>
                                        <th  >名称</th>
                                        <th >链接地址</th>
                                        <th  >状态</th>
                                        <th  >操作</th>
                                    </tr>
                                    </thead>
                                    <tbody role="alert" aria-live="polite" aria-relevant="all">
                                    <#list Menu.children?sort_by("sort") as folder>
                                    <tr class="gradeA_firstFolder">
                                        <td class="folderSort"><input type="number"
                                                                      folderId="${folder.id}" value="${folder.sort}"
                                                                      name="sort"
                                                                      class="js_folder_sort" style="width: 40px;" required ></td>
                                        <td>${folder.name}</td>
                                        <td><a href="${folder.url}">${folder.url}</a></td>
                                        <td>
                                            <#if folder.status=="display">
                                                显示
                                            <#else>
                                                隐藏
                                            </#if>
                                        </td>
                                        <td>
                                            <a href="${BASE_PATH}/manage/menu/update.htm?id=${folder.id}" name="修改">
                                                修改
                                            </a>
                                            |
                                            <a class="js_folder_delete" folderId="${folder.id}" pid="${folder.pid}"
                                               href="javascript:void(0);" name="删除">
                                                删除
                                            </a>
                                        </td>
                                    </tr>
                                    </#list>
                                    </tbody>
                                </table>
                            </div>
                            <div>
                            <#if Menu.children?size gt 0>
                                <button class="btn btn-info js_update_sort" type="button">
                                    <i class="icon-refresh"></i> 更新排序
                                </button>
                            </#if>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <!-- page end-->
    </section>
</section>
<!--main content end-->
<script type="text/javascript">
    $(function () {

        $('.js_update_sort').click(function () {
            var folderSort = new Array();
            $('.js_folder_sort').each(function (i, element) {
                var folder = {};
                folder.id = $(element).attr('folderId');
                folder.sort = $(element).val();
                folderSort.push(folder);
            });
            $.post("${BASE_PATH}/manage/menu/sort.json", {
                        "sortJson": $.toJSON(folderSort)
                    },
                    function (data) {
                        if (data.result) {
                            bootbox.alert("更新成功",
                                    function () {
                                        window.location.href = "${BASE_PATH}/manage/menu/list.htm?id=${Menu.id}";
                                    });
                        } else {
                            bootbox.alert(data.msg,
                                    function () {
                                    });
                        }
                    },
                    "json");
        });
        $('.js_folder_delete').click(function () {
            var folderId = $(this).attr('folderId');
            var pid = $(this).attr('pid');
            bootbox.dialog({
                message: "是否" + $(this).attr('name') + "文件夹",
                name: "提示",
                buttons: {
                    "delete": {
                        label: "删除",
                        className: "btn-success",
                        callback: function () {
                            $.post("${BASE_PATH}/manage/menu/delete.json", {
                                        "id": folderId,
                                        "pid": pid
                                    },
                                    function (data) {
                                        if (data.result) {
                                            bootbox.alert("删除成功",
                                                    function () {
                                                        window.location.href = "${BASE_PATH}/manage/menu/list.htm?id=${Menu.id}";
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

        $("#mm").change(function () {
            window.location.href = "${BASE_PATH}/manage/menu/list.htm?id=" + $(this).val();
        });

        if($("#dLabel").attr("menuId")==0)
        {
            $(".hd").hide();
        }

        $("a.dLabel").click(function () {
            window.location.href = "${BASE_PATH}/manage/menu/list.htm?id=" + $(this).attr("menuId");
        });

        $(".js_folder_status").change(function () {
            $.post("${BASE_PATH}/manage/menu/status.json", {
                "id": $(this).attr("folderId"),
                status: $(this).val()
            }, function () {
                window.location.reload();
            }, "json");
        });
    });
</script>
<#include "/manage/foot.ftl">
