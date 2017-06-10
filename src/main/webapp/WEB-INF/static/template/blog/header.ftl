<#assign config_v="20141009044">
<!DOCTYPE html>
<html lang="zh_CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="${shishuo_seo_description}">
<meta name="author" content="CMS">
<link rel="icon" href="${TEMPLATE_BASE_PATH}/images/favicon.ico">

<title>${shishuo_seo_title}</title>

<link rel="stylesheet" type="text/css" href="${TEMPLATE_BASE_PATH}/css/main.css" />
</head>

<body>
<noscript>
    <div style="position:absolute;z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;"><img src="${TEMPLATE_BASE_PATH}/images/noscript.gif" alt="抱歉，请开启脚本支持！" /></div>
</noscript>
<!--头部-->
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/jquery.min.js"></script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/msclass.js"></script>
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
<!--头部-->
<div class="header">
    <div class="header-content">
        <div class="logo">
            <a href="${BASE_PATH}/index.htm"></a>
        </div>
        <h3>
            创新理论与创新管理研究中心
            <span>INNOVATION THEORY AND INNOVATION MANAGEMENT RESERCH CENTER</span>
            <p>——广州市人文社会科学重点研究基地</p>
        </h3>
        <!--搜索-->
        <div class="search">
            <span class="widget"><i>${.now?string('yyyy年MM月dd日')}</i>&nbsp;<a class="eng_ver" href="#">[English Version]</a></span>
            <input id="keywords" name="keywords" class="input-text" type="text" x-webkit-speech="" placeholder="请输入关键字搜索" onkeydown="if(event.keyCode==13){SiteSearch('/001lt269/search.html', '#keywords');return false};"
            />
            <input class="input-btn" type="submit" value="" onclick="SiteSearch('/001lt269/search.html', '#keywords');" />
        </div>
        <!--搜索-->
    </div>
    <div class="menu">
        <ul id="nav">
        <#if menuList?? && menuList?size gt 0>
            <#list menuList?sort_by("sort") as p>
            <li class="on"><a href="${p.url}" target="0">${p.name}</a>
                <ul>

                <#list p.children?sort_by("sort") as c>
                    <li class=""><a href="${c.url}" target="0">${c.name}</a>
                        <ul></ul>
                    </li>
                </#list>

                </ul>
            </li>
            </#list>
        </#if>
        </ul>
    </div>
</div>
<div class="clear"></div>