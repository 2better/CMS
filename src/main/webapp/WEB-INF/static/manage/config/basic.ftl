<#assign menu="system">
<#assign submenu="cog">
<#include "/manage/head.ftl">

<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!-- page start-->
        <section class="panel">
                    <div class="panel-body">
                        <form  action="${BASE_PATH}/manage/config/basic.json" role="form"
                              class="form-horizontal basicForm" autocomplete="off" method="POST">
                        <#list configs as c>
                            <div class="form-group">
                                <label class="col-lg-2 col-sm-2 control-label"
                                       for="inputEmail1">${c.description}</label>
                                <div class="col-lg-10">
                                    <input type="text" id="inputEmail1" name="${c.key}" required
                                           class="form-control" value="${c.value!}">
                                </div>
                            </div>
                        </#list>
                            <div class="form-group">
                                <div class="col-lg-offset-2 col-lg-10">
                                    <button class="btn btn-danger" type="submit">保存</button>
                                </div>
                            </div>
                        </form>
                    </div>
        </section>
        <!-- page end-->
    </section>
</section>

<!--main content end-->
<script type="text/javascript">
    $(function () {

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
    });
</script>
<#include "/manage/foot.ftl">
