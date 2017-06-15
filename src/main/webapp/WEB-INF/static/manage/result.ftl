<#assign menu="result">
<#assign submenu="result_basic">
<#include "/manage/head.ftl">

<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <section class="panel">

            <ul id="myTab" class="nav nav-tabs">
                <li class="active">
                    <a href="#home" data-toggle="tab">
                        学术著作
                    </a>
                </li>
                <li>
                    <a href="#scholar" data-toggle="tab">学者风采</a>
                </li>
            </ul>

            <div id="myTabContent" class="tab-content">
                <div class="tab-pane active" id="home">
                    <#include "/manage/composition/list.ftl">
                </div>

                <div class="tab-pane" id="scholar">
                    <#include "/manage/scholar/list.ftl">
                </div>

            </div>
        </section>
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
            $.post("${BASE_PATH}/manage/config/sort.json", {
                        "sortJson": $.toJSON(folderSort)
                    },
                    function (data) {
                        if (data.result) {
                            bootbox.alert("更新成功",
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
        });

        $('#myTab a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });

        $('.basicForm').ajaxForm({
            dataType: 'json',
            success: function (data) {
                if (data.result) {
                    bootbox.alert("保存成功，将刷新页面", function () {
                        window.location.reload();
                    });
                } else {
                    showErrors($('#basicForm'), data.errors);
                }
            }
        });

        $('.js_delete_admin').click(function () {
            var adminId = $(this).attr('adminId');
            bootbox.dialog({
                message: "是否" + $(this).attr('title') + "该链接",
                title: "提示",
                buttons: {
                    "delete": {
                        label: "删除",
                        className: "btn-success",
                        callback: function () {
                            $.post("${BASE_PATH}/manage/config/delete.json", {
                                        "id": adminId
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
</script>
<#include "/manage/foot.ftl">
