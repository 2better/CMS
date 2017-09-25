<#assign menu="log">
<#assign submenu="cog">
<#include "/manage/head.ftl">
<!--main content start-->
<section id="main-content">
    <section class="wrapper">

        <!-- page start-->
        <section class="panel">
            <header class="panel-heading">
                <div class="row">
                    <div class="col-lg-12">
                        <a class="btn btn-primary" id="clean"
                           href="javascript:history.go(-1);">返回</a>
                    </div>
                </div>
            </header>
            <div class="panel-body">
                <div class="adv-table">
                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                        <table id="con" class="table table-striped table-advance table-hover">
                            <tbody role="alert" aria-live="polite" aria-relevant="all">
                                <tr>
                                    <td >用户名称</td>
                                    <td>${log.userName}</td>
                                </tr>
                                <tr>
                                    <td >类名称</td>
                                    <td>${log.className}</td>
                                </tr>
                            <tr>
                                <td >方法名称</td>
                                <td>${log.methodName}</td>
                            </tr>
                            <tr>
                                <td >记录时间</td>
                               <td>
                               ${log.createTimeView}
                               </td>
                            </tr>
                            <tr>
                                <td>信息</td>
                                <td>${log.message}</td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
        <!-- page end-->
    </section>
</section>
<!--main content end-->

<#include "/manage/foot.ftl">
