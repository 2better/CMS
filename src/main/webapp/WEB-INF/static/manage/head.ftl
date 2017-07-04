<#assign config_v="20140830004">
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Mosaddek">
    <meta name="keyword"
          content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>ITIMRC后台管理</title>
    <!-- Bootstrap core CSS -->
    <link href="${BASE_PATH}/static/manage/css/bootstrap.min.css?v=${config_v}" rel="stylesheet">
    <link href="${BASE_PATH}/static/manage/css/bootstrap-reset.css?v=${config_v}"
          rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${BASE_PATH}/static/manage/css/gallery.css?v=${config_v}"/>
    <!--external css-->
    <link href="${BASE_PATH}/static/manage/assets/font-awesome/css/font-awesome.min.css"
            rel="stylesheet"/>
    <link href="${BASE_PATH}/static/manage/assets/fancybox/source/jquery.fancybox.css?v=${config_v}" rel="stylesheet"/>
    <!-- Custom styles for this template -->
    <link href="${BASE_PATH}/static/manage/css/style.css?v=${config_v}" rel="stylesheet">
    <link href="${BASE_PATH}/static/manage/css/style-responsive.css?v=${config_v}" rel="stylesheet"/>
    <link href="${BASE_PATH}/static/manage/assets/uploadify/uploadify.css?v=${config_v}" rel="stylesheet"/>
    <link href="${BASE_PATH}/static/manage/assets/bootstrap.datetimepicker/css/bootstrap-datetimepicker.min.css?v=${config_v}"
          rel="stylesheet"/>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
    <script src="${BASE_PATH}/static/manage/js/html5shiv.js"></script>
    <script src="${BASE_PATH}/static/manage/js/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript">
        window.BasePath = "${BASE_PATH}";
        window.UEDITOR_HOME_URL = "${BASE_PATH}/";
        kindId = 0;
        kind = "article";
    </script>
    <script src="${BASE_PATH}/static/manage/js/jquery.js?v=${config_v}"></script>
    <script src="${BASE_PATH}/static/manage/js/jquery-accordion-menu.js" type="text/javascript"></script>
</head>
<body class="boxed-page">
	<div class="container">
	<section id="container" class="">
		<!--header start-->
		<header class="white-bg">
			<div class="container" style="background-color: #ffffff; padding: 10px;height:130px;">
				<!--logo start-->
                <div class="logo" style="float: left;width: 100px;height:96px;margin-right: 1em;">
                    <a style="display: inline-block;width: 100%;height: 100%;" href="${BASE_PATH}/index.htm"  title="访问前台页面" target="_blank">
                        <img src="${TEMPLATE_BASE_PATH}/images/logo-new.png" style="height:  width: 100%;height: 100%;" />
                    </a>
                </div>
				<!--logo end-->

                    <h3 id="top_menu" style="font-weight: bold;position: relative;bottom: 42px;display: inline-block;font-size: 2.8em;line-height: 110px;vertical-align: text-bottom;color: #a82e17;font-family: "黑体", sans-serif;">
                        创新理论与创新管理研究中心
                        <span style=" position: absolute;display: block;width: 100%;line-height: 1.6;font-weight: normal;font-size: 17px;white-space: nowrap;text-align: center;left: 0;bottom: 16px;">Innovation Theory And Innovation Management Research Center</span>
                        <p style=" position: absolute;display: block;width: 100%;line-height: 1.6;font-weight: normal;font-size: 15px;white-space: nowrap;text-align: center;bottom: -18px;font-size: 20px;font-weight: bold;text-align: left;color: #333;background: url(${TEMPLATE_BASE_PATH}/images/line.png) no-repeat center right;">广东省决策咨询研究基地</p>
                    </h3>

				<div class="top-nav" style="float: right;margin-right:20px;">

					<ul class="nav pull-right top-menu">
	                  <!-- user login dropdown start-->
	                  <li class="dropdown">
	                      <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                          <span class="username">${SESSION_ADMIN.name}</span>
	                          <b class="caret"></b>
	                      </a>
	                      <ul class="dropdown-menu extended logout">
	                          <div class="log-arrow-up"></div>
	                          <li><a href="${BASE_PATH}/manage/admin/update.htm"><i class="fa fa-cog "></i> 修改密码</a></li>
	                          <li><a href="${BASE_PATH}/admin/logout.htm"><i class="fa fa-sign-out"></i> 安全退出</a></li>
	                      </ul>
	                  </li>
	                  <!-- user login dropdown end -->
	              </ul>

				</div>
			</div>
		</header>
		<!--header end-->
		<!--sidebar start-->
		<aside>
			<div id="sidebar" class="nav-collapse ">
				<!-- sidebar menu goes here-->
				<ul class="sidebar-menu" id="nav-accordion">

                    <li>
                        <a class="link <#if menu="index">active</#if>" href="${BASE_PATH}/manage/index.htm"><i class="fa fa-home fa-4x"></i>&nbsp;&nbsp;后台首页 &nbsp;&nbsp;<#if menu="index"><i class="fa fa-chevron-right"></i></#if></a>
                    </li>
                    <li>
                        <a class="link <#if menu="article">active</#if>" href="${BASE_PATH}/manage/article/listPage.htm"><i class="fa fa-file-pdf-o fa-4x"></i>&nbsp;&nbsp;<span>文章管理</span> &nbsp;&nbsp;<#if menu="article"><i class="fa fa-chevron-right"></i></#if></a>
                    </li>
                    <li>
                        <a class="link <#if menu="preview">active</#if>" href="${BASE_PATH}/manage/preview/listPage.htm"><i class="fa fa-file-text fa-4x"></i>&nbsp;&nbsp;<span>文档管理</span> &nbsp;&nbsp;<#if menu="preview"><i class="fa fa-chevron-right"></i></#if></a>
                    </li>
                    <li>
                        <a class="link <#if menu="event">active</#if>" href="${BASE_PATH}/manage/event/listPage.htm"><i class="fa fa-play-circle fa-4x"></i>&nbsp;&nbsp;<span>活动管理</span> &nbsp;&nbsp;<#if menu="event"><i class="fa fa-chevron-right"></i></#if></a>
                    </li>
                    <li id="result">
                        <a  class="link" href="javascript:void(0);"><i class="fa fa-edit fa-4x "></i>&nbsp;&nbsp;研究成果 &nbsp;&nbsp;</a>
                        <ul class="submenu">
                            <li><a class="link <#if menu="composition">active</#if>" href="${BASE_PATH}//manage/composition/listPage.htm"><i class="fa fa-caret-right"></i>&nbsp;&nbsp;<span>学术著作</span> &nbsp;&nbsp;<#if menu="composition"><i class="fa fa-chevron-right"></i></#if></a></li>
                            <li><a class="link <#if menu="scholar">active</#if>" href="${BASE_PATH}/manage/scholar/listPage.htm"><i class="fa fa-caret-right"></i>&nbsp;&nbsp;<span>学者风采</span> &nbsp;&nbsp;<#if menu="scholar"><i class="fa fa-chevron-right"></i></#if></a></li>
                        </ul>
                    </li>
                    <li id="user">
                        <a class="link" href="javascript:void(0);"><i class="fa fa-user fa-4x "></i>&nbsp;&nbsp;用户管理 &nbsp;&nbsp;</a>
                        <ul class="submenu">
                            <li><a class="link <#if menu="user_list">active</#if>" href="${BASE_PATH}/manage/user/manage.htm"><i class="fa fa-caret-right"></i>&nbsp;&nbsp;<span>用户管理</span> &nbsp;&nbsp;<#if menu="user_list"><i class="fa fa-chevron-right"></i></#if></a></li>
                            <li><a class="link <#if menu="admin_list">active</#if>" href="${BASE_PATH}/manage/admin/manage.htm"><i class="fa fa-caret-right"></i>&nbsp;<span>管理员管理</span> &nbsp;<#if menu="admin_list"><i class="fa fa-chevron-right"></i></#if></a></li>
                        </ul>
                    </li>
                    <li id="cog">
                        <a class="link" href="javascript:void(0);"><i class="fa fa-cogs fa-4x "></i>&nbsp;&nbsp;网站设置 &nbsp;&nbsp;</a>
                        <ul class="submenu" >
                            <li><a  class="link <#if menu="system">active</#if>" href="${BASE_PATH}//manage/config/basic.htm"><i class="fa fa-caret-right"></i>&nbsp;&nbsp;<span>基本设置</span> &nbsp;&nbsp;<#if menu="system"><i class="fa fa-chevron-right"></i></#if></a></li>
                            <li><a class="link <#if menu="menu">active</#if>" href="${BASE_PATH}/manage/menu/list.htm"><i class="fa fa-caret-right"></i>&nbsp;&nbsp;<span>菜单管理</span> &nbsp;&nbsp;<#if menu="menu"><i class="fa fa-chevron-right"></i></#if></a></li>
                            <li><a class="link <#if menu="picture">active</#if>" href="${BASE_PATH}//manage/picture/listPage.htm"><i class="fa fa-caret-right"></i>&nbsp;<span>展示图设置</span>&nbsp;&nbsp;<#if menu="picture"><i class="fa fa-chevron-right"></i></#if></a></li>
                            <li><a class="link <#if menu="friendlyLink">active</#if>" href="${BASE_PATH}/manage/friendlyLink/friendlyLink.htm"><i class="fa fa-caret-right"></i>&nbsp;&nbsp;<span>友情链接</span> &nbsp;&nbsp;<#if menu="friendlyLink"><i class="fa fa-chevron-right"></i></#if></a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <script>
                jQuery(document).ready(function () {

                    $("#${submenu}").children(".submenu").delay(0).slideDown(300);
                    $("#${submenu}").children(".submenu").siblings("a").addClass("active");
                    jQuery("#sidebar").jqueryAccordionMenu();

                });

            </script>
        </aside>
        <!--sidebar end-->
