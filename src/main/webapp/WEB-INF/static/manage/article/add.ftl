<#assign menu="article">
<#assign submenu="add_article">
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
        <form id="add_article_form" class="form-horizontal" action="${BASE_PATH}/manage/article/add.json"
              autocomplete="off" method="post"
        >
            <div class="row">
                <input type="hidden" name="menuId" id="menuId" value=""/>
                <div class="col-lg-12">
                    <section class="panel">
                        <header class="panel-heading">
                            增加文章
                        </header>
                        <div class="panel-body">
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">文章标题</label>
                                <div class="col-sm-10">
                                    <input type="text" style="font-size:15px;width: 300px;" class="form-control" required
                                           name="title"
                                           placeholder="文章标题" id="title">
                                    </input>
                                </div>
                            </div>
                        <#--<div class="form-group">
                          <label class="col-sm-2 col-sm-2 control-label">所属菜单</label>
                          <div class="col-sm-10">
                              <select class="form-control" id="parentMenu" style="font-size:15px;width: 300px; display: inline-block">
								  <#list menus?sort_by("sort") as f>
									  <#if f.name != "首页">
									  <option value="${f.id}" >${f.name}</option>
									  </#if>
								  </#list>
	                          </select>
                              <select class="form-control" id="childMenu" name="menuId" style="font-size:15px;width: 300px; display: inline-block"">
                                  <option value="1" >所属菜单</option>
                              </select>
                          </div>
                        </div>-->
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">所属菜单</label>
                                <div class="dropdown col-sm-10" style="display: inline-block;">
                                    <a id="dLabel" role="button" data-toggle="dropdown" class="btn btn-primary"
                                       data-target="#"
                                       href="javascript:;">--请选择--<span class="caret"></span>
                                    </a>
                                    <ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
                                        <li class="divider"></li>
                                    <#list menus?sort_by("sort") as f>
                                        <#if (f.children?size > 0)>
                                            <li class="dropdown-submenu">
                                                <a tabindex="-1" href="javascript:;" class="dLabel"
                                                   menuId="${f.id}">${f.name}</a>
                                                <ul class="dropdown-menu">
                                                    <li class="divider"></li>
                                                    <#list f.children?sort_by("sort") as c>
                                                        <#if (c.children?size > 0)>
                                                            <li class="dropdown-submenu">
                                                                <a href="javascript:;" menuId="${c.id}"
                                                                   class="dLabel">${c.name}</a>
                                                                    <ul class="dropdown-menu">
                                                                        <li class="divider"></li>
                                                                        <#list c.children?sort_by("sort") as s>
                                                                            <li><a href="javascript:;" class="dLabel"
                                                                                   menuId="${s.id}">${s.name}</a></li>
                                                                            <li class="divider"></li>
                                                                        </#list>
                                                                    </ul>
                                                            </li>
                                                            <#else>
                                                                <li>
                                                                    <a href="javascript:;" menuId="${c.id}"
                                                                       class="dLabel">${c.name}</a>
                                                                </li>
                                                        </#if>
                                                        <li class="divider"></li>
                                                    </#list>
                                                </ul>
                                            </li>
                                            <li class="divider"></li>
                                        <#else>
                                            <li><a href="javascript:;" menuId="${f.id}" class="dLabel">${f.name}</a>
                                            </li>
                                            <li class="divider"></li>
                                        </#if>
                                    </#list>
                                    </ul>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">发布时间</label>
                                <div class="col-sm-10">
                                    <input type="text" data-link-format="yyyy-MM-dd" data-date-format="yyyy-MM-dd"
                                           style="font-size:15px;width: 200px;" class="js_create_time" name="createTime"
                                           placeholder="发布时间" id="createTime" value="${.now?string("yyyy-MM-dd")}">
                                    </input>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">文章状态</label>
                                <div class="col-sm-10" style="margin-bottom:10px;">
                                    <input name="status" value="display" type="radio" checked> 显示
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input name="status" value="hidden" type="radio"> 隐藏
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">文章内容</label>
                                <div class="col-sm-10">
                                    <script id="content" name="content" type="text/plain"
                                            style="width: 100%; height: 260px;"></script>
                                    <script type = "text/javascript">
                                    var contentEditor;
                                    $(function () {
                                        contentEditor = UE.getEditor('content');
                                    });
                                    </script>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-offset-2 col-lg-12">
                                    <button class="btn btn-shadow btn-primary" type="submit">发布</button>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </form>
        <!-- page end-->
    </section>
</section>
<!--main content end-->
<script type="text/javascript">

    $(function () {

        $("a.dLabel").click(function () {
            $("#dLabel").text($(this).text());
            $("#menuId").val($(this).attr("menuId"));
        });

        $('#add_article_form').ajaxForm({
            dataType: 'json',
            success: function (data) {
                if (data.result) {
                    bootbox.alert("保存成功，将刷新页面", function () {
                        window.location.reload();
                    });
                } else {
                    showErrors($('#add_article_form'), data.errors);
                }
            }
        });

        $('.js_create_time').datetimepicker({
            language: 'zh-CN',
            format: "yyyy-mm-dd",
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        });
    });
</script>
<#include "/manage/foot.ftl">