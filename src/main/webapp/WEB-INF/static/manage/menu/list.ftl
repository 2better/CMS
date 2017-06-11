<#assign menu="menu">
<#assign submenu="menu_list">
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
                    <li><i class="icon-home"></i> 菜单管理</a></li>
                </ul>
                <!--breadcrumbs end -->
            </div>
        </div>
        <div class="row">
            <div class="col-lg-5">
                <section class="panel">
                    <header class="panel-heading">
                        添加菜单
                    </header>
                    <div class="panel-body">
                        <form id="addFolder_form" method="post" class="form-horizontal" autocomplete="off"
                              action="${BASE_PATH}/manage/menu/add.json">
                            <fieldset>
                                <div class="form-group">
                                    <label class="col-xs-3 control-label">菜单名称</label>
                                    <div class="col-xs-9">
                                        <input type="text" style="font-size:15px;width: 200px;" class="form-control"
                                               name="name"
                                               placeholder="菜单名称" id="folderName" maxlength="5">${menuName}
                                        </input>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4 control-label">由系统生成URl</label>
                                    <div class="col-xs-3">
                                        <input type="checkbox" checked class="form-control" id="createUrl" name="createUrl" value="1" style="font-size:10px;height:20px">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3 control-label">url</label>
                                    <div class="col-xs-9">
                                        <input style="font-size:15px;width: 200px;" class="form-control" name="url"
                                               placeholder="url" id="url">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3 control-label">父级菜单</label>
                                    <div class="col-xs-9">
                                        <select class="form-control input-lg m-bot15"
                                                style="font-size:15px;width: 200px;" name="pid">
                                            <option value="0">根菜单</option>
                                        <#list menuParentsList?sort_by("sort") as f>
                                            <option value="${f.id}"<#if Menu.id ==f.id>selected</#if>>${f.name}</option>
                                        </#list>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3 control-label">菜单状态</label>
                                    <div class="col-xs-9">
                                        <label class="radio-inline">
                                            <input type="radio" name="status" value="display" checked/> 显示
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="status" value="hidden"/> 隐藏
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-offset-3 col-xs-9">
                                        <button class="btn btn-danger" type="submit">保存</button>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </section>
            </div>
            <div class="col-lg-7">
                <section class="panel">
                    <header class="panel-heading">
                        <select id="mm" class="input-lg" style="font-size:12px;width: 150px;height:40px">
                            <option value="0">根菜单</option>
                        <#list menuParentsList?sort_by("sort") as f>
                            <option value="${f.id}" <#if Menu.id ==f.id>selected</#if>>${f.name}</option>
                        </#list>
                        </select>
                    </header>
                    <div class="panel-body">
                        <div class="adv-table">
                            <div role="grid" class="dataTables_wrapper"
                                 id="hidden-table-info_wrapper">
                                <table class="table table-striped table-advance table-hover">
                                    <thead>
                                    <tr>
                                        <th>顺序</th>
                                        <th width="100" >名称</th>
                                        <th >URL</th>
                                        <th width="50" >状态</th>
                                        <th width="100" >操作</th>
                                    </tr>
                                    </thead>
                                    <tbody role="alert" aria-live="polite" aria-relevant="all">
                                    <#list Menu.children?sort_by("sort") as folder>
                                    <tr class="gradeA_firstFolder">
                                        <td class="folderSort"><input type="text"
                                                                      folderId="${folder.id}" value="${folder.sort}"
                                                                      name="sort"
                                                                      class="js_folder_sort" style="width: 40px;"></td>
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
                                            <a href="${BASE_PATH}/manage/menu/update.htm?id=${folder.id}" title="修改">
                                                修改
                                            </a>
                                            |
                                            <a class="js_folder_delete" folderId="${folder.id}" pid="${folder.pid}"
                                               href="javascript:void(0);" title="删除">
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
    var pageFolderId = ${Menu.id};
    $(function () {

        $("#createUrl").change(function () {
            if($("#createUrl").is(':checked'))
                $("#url").attr("disabled","disabled");
            else
                $("#url").removeAttr("disabled");
        });

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
                                        window.location.href = "${BASE_PATH}/manage/menu/list.htm?id=" + pageFolderId;
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
                message: "是否" + $(this).attr('title') + "文件夹",
                title: "提示",
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
                                                        window.location.href = "${BASE_PATH}/manage/menu/list.htm?id=" + pageFolderId;
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
        $(".js_folder_status").change(function () {
            $.post("${BASE_PATH}/manage/menu/status.json", {
                "id": $(this).attr("folderId"),
                status: $(this).val()
            }, function () {
                window.location.reload();
            }, "json");
        });

        $('#addFolder_form').ajaxForm({
            dataType: 'json',
            success: function (data) {
                if (data.result) {
                    bootbox.alert("保存成功", function () {
                        window.location.reload();
                    });
                } else {
                    showErrors($('#addFolder_form'), data.errors);
                }
            }
        });
    });
</script>
<#include "/manage/foot.ftl">
