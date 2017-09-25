<#assign menu="index">
<#assign submenu="">
<#include "/manage/head.ftl">
<style>
    .list-group-item {
        background-color: #FFFFFF;
        border: 1px solid #DDDDDD;
        display: block;
        margin-bottom: -1px;
        padding: 3px 15px;
        position: relative;
        font-size: 18px;
    }

    .pull-right a:hover{color: #000;background-color:#DFF0D8;}

    .zxx_text_overflow{width:21em; float:left;overflow:hidden; zoom:1;}
    .zxx_text_overflow .text_con{float:left; height:1.3em; margin-right:3em; overflow:hidden;}
    .zxx_text_overflow .text_dotted{width:3em; height:1.31em; float:right; margin-top:-1.3em;}
</style>
<!--main content start-->
<section id="main-content">
    <section class="wrapper">
        <!--state overview start-->
        <div class="row state-overview">
            <div class="col-lg-3 col-sm-6">
                <section class="panel">
                    <div class="symbol terques">
                        <a href="${BASE_PATH}/manage/user/manage.htm"><i class="fa fa-user" title="前往用户列表"></i></a>
                    </div>
                    <div class="value">
                        <h1>${userCount}</h1>
                        <p>用户</p>
                    </div>
                </section>
            </div>
            <div class="col-lg-3 col-sm-6">
                <section class="panel">
                    <div class="symbol red">
                        <a href="${BASE_PATH}/manage/article/listPage.htm" title="前往文章列表"><i
                                class="fa fa-file-pdf-o"></i></a>
                    </div>
                    <div class="value">
                        <h1>${articleCount}</h1>
                        <p>文章</p>
                    </div>
                </section>
            </div>
            <div class="col-lg-3 col-sm-6">
                <section class="panel">
                    <div class="symbol yellow">
                        <a href="${BASE_PATH}/manage/event/listPage.htm" title="前往活动列表"><i class="fa fa-comment-o"></i></a>
                    </div>
                    <div class="value">
                        <h1>${eventCount}</h1>
                        <p>活动</p>
                    </div>
                </section>
            </div>
            <div class="col-lg-3 col-sm-6">
                <section class="panel">
                    <div class="symbol blue">
                        <a href="${BASE_PATH}/manage/preview/listPage.htm" title="前往文档列表"><i
                                class="fa fa-file-text"></i></a>
                    </div>
                    <div class="value">
                        <h1>${documentCount}</h1>
                        <p>文档</p>
                    </div>
                </section>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <section class="panel">
                    <header class="panel-heading">
                        最新活动
                        <span class="tools pull-right">
                            </span>
                    </header>
                    <ul class="list-group">
                    <#list eventTop10 as event>
                        <li class="list-group-item " style="background-color:#f0f0f0;height:33px;">
                            <a style="width:50% float:left" href="${BASE_PATH}/manage/event/update.htm?id=${event.id}">
                            <i class="fa fa-paw"></i>&nbsp;${event.name}</a>
                                <a href="${BASE_PATH}/manage/event/update.htm?id=${event.id}"
                                   title="修改" style="float:right;">
                                    [修改]
                                </a>
                        </li>
                    </#list>
                    </ul>
                </section>
            </div>
            <div class="col-lg-6">
                <section class="panel">
                    <header class="panel-heading">
                        最新文章
                        <span class="tools pull-right">
                            <a href="${BASE_PATH}/manage/article/add.htm" class="list-group-item" >添加文章</a>
                        </span>
                    </header>
                    <ul class="list-group">
                    <#list articleTop10 as article>
                        <li class="list-group-item " style="background-color:#f0f0f0;height:33px;">
                            <div class="zxx_text_overflow">
                            <a class="text_con" href="${BASE_PATH}/manage/article/preview.htm?articleId=${article.articleId}" target="_blank"><i class="fa fa-star-o"></i>&nbsp;${article.title}</a>
                                <div class="text_dotted" >…</div>
                            </div>

                        <a href="${BASE_PATH}/manage/article/update.htm?articleId=${article.articleId}" title="修改"
                               style="float:right;">
                                [修改]
                            </a>
                        </li>
                    </#list>
                    </ul>
                </section>
            </div>
        </div>
        <!--state overview end-->
        <!-- page end-->
    </section>
</section>
<!--main content end-->
<#include "/manage/foot.ftl">
