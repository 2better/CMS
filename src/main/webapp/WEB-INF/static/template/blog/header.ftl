<#assign config_v="20141009044">
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="${seo_description}">
    <link rel="icon" href="${TEMPLATE_BASE_PATH}/images/favicon.ico">

    <title>${index_title}</title>

    <link rel="stylesheet" type="text/css" href="${TEMPLATE_BASE_PATH}/css/main.css"/>
    <link rel="stylesheet" type="text/css" href="${TEMPLATE_BASE_PATH}/css/slider.css"/>
    <link rel="stylesheet" type="text/css" href="${TEMPLATE_BASE_PATH}/css/login-layer.css"/>
</head>

<body>
<noscript>
    <div style="position:absolute;z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
        <img src="${TEMPLATE_BASE_PATH}/images/noscript.gif" alt="抱歉，请开启脚本支持！"/></div>
</noscript>
<!--头部-->
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/jquery.min.js"></script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/msclass.js"></script>
<script>
    var big = [
    <#list pictures as p>
        '${BASE_PATH}/${p.picUrl}',
    </#list>];
    var small = [
    <#list pics as p>
        '${BASE_PATH}/${p.picUrl}',
    </#list>
    ];
</script>
<script src="${TEMPLATE_BASE_PATH}/js/slider.js"></script>
<!--<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/jquery.kinslideshow-1.2.1.min.js"></script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/jquery.media.js"></script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/dd_belatedpng_0.0.8a.js"></script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/jquery.pagination.js"></script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/base.js"></script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/tablist.js"></script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/comm.js"></script>-->
<!--[if lte IE 6]>
<script src="${TEMPLATE_BASE_PATH}/js/dd_belatedpng_0.0.8a.js" type="text/javascript"></script>
<script type="text/javascript">
    DD_belatedPNG.fix('div,ul,img,li,input,a,span,p');
</script>
<![endif]-->
<!--登录遮罩层-->
<div class="login-layer" style="display:none">
    <div class="login">
        <h1>用户登录<i class="close" title="关闭"></i></h1>
        <form method="post" action="${BASE_PATH}/user/login.json" id="loginForm">
            <span id="error" style="color:red;"></span>
            <p><input type="text" name="name" value="user" placeholder="用户名" required></p>
            <p><input type="password" name="password" value="123456" placeholder="密码" maxlength="16" minlength="6"
                      required></p>
            <p>
                <input type="text" name="captcha" class="form-control" required maxlength="4" minlength="4"
                       placeholder="验证码" style="width: 100px; float: left;" id="captcha"> <img

                    style="cursor: pointer; cursor: hand; margin-top: -13px;"
                    onclick="this.src='${BASE_PATH}/admin/captcha.htm?'+Math.random();"
                    src="${BASE_PATH}/admin/captcha.htm" id="captchaImg">
            </p>
            <p class="remember_me">
                <label>
                    <input type="checkbox" name="rememberMe" id="remember_me" value="true">
                    记住密码
                </label>
            </p>
            <p class="submit"><input type="submit" name="commit" value="登录"></p>
        </form>
        <div class="login-help">
            <p>忘记密码? <a href="index.html">联系工作人员</a>.</p>
        </div>
    </div>
</div>
<!--登录遮罩层-->

<!--头部-->
<div class="header">
    <!-- banner -->
    <div class="banner">
        <div class="slider">
            <ul></ul>
        </div>
    </div>
    <!-- banner -->
    <div class="header-content">
        <div class="logo">
            <a href="${BASE_PATH}/index.htm">
                <img src="${TEMPLATE_BASE_PATH}/images/logo-new.png" alt=""/>
            </a>
        </div>
        <h3>
            创新理论与创新管理研究中心
            <span>INNOVATION THEORY AND INNOVATION MANAGEMENT RESERCH CENTER</span>
            <p>——广州市人文社会科学重点研究基地</p>
        </h3>
        <!--搜索-->
        <div class="search">
            <span class="widget"><i>2017年5月20日</i>&nbsp;<a class="eng_ver" href="#">[English Version]</a></span>
            <div class="searchGroup">
                <input type="text" value="" class="searchText" placeholder="请输入关键字搜索" id="key">
                <input type="button" value="搜索" class="searchButton" id="keyButton">
            </div>
        </div>
        <!--搜索-->
    </div>
    <div class="menu">
        <ul id="nav">
        <#if menuList?? && menuList?size gt 0>
            <#list menuList?sort_by("sort") as p>
                <li class="on">
                    <a href="<#if p.children?size gt 0>${p.children[0].url}<#else>${p.url}</#if>"
                       target="0">${p.name}</a>
                    <ul>
                        <#list p.children?sort_by("sort") as c>
                            <li class=""><a href="${c.url}" target="0">${c.name}</a>
                                <ul>
                                    <#if (c.children?size > 0)>
                                        <#list c.children?sort_by("sort") as s>
                                        <li class=""><a href="${s.url}" target="0">${s.name}</a>
                                        </#list>
                                    </#if>
                                </ul>
                            </li>
                        </#list>
                    </ul>
                </li>
            </#list>
        </#if>
        </ul>
    </div>
</div>
<script src="${BASE_PATH}/static/manage/js/jquery.form.min.js"></script>
<script>
    $(function () {
        var ele = null;
        $("#nav li").click(function (e) {
            var temp = $(this).find('a');
            if (temp.html() !== "智库专报") return;
            ele = $(this).find('a');
            e.preventDefault();
            $.ajax({
                url: '${BASE_PATH}/user/isLogin.json',
                type: 'POST',
                cache: false,
                success: function (data) {
                    if (data == false) {
                        $(".login-layer").css('display', 'flex');
                    } else {
                        window.location.href = temp.attr("href");
                    }
                },
                error: function () {
                    alert("系统繁忙，请稍后再试！");
                }
            });
        });

        $('#loginForm').ajaxForm({
            dataType: 'json',
            success: function (data) {
                if (data) {
                    $("#error").text(data.error);
                    $("#captcha").val("");
                    $("#captchaImg").click();
                }
            },
            error: function () {
                window.location.href=ele.attr("href");
            }
        });

    });

    //搜索功能

    $("#keyButton").click(function () {
        window.location.href = "${BASE_PATH}/article/search.html?key=" + $("#key").val();
    });
</script>
<div class="clear"></div>