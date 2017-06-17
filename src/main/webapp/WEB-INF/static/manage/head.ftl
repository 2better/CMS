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
</head>
<body class="boxed-page">
	<div class="container">
	<section id="container" class="">
		<!--header start-->
		<header class="white-bg">
			<div class="container" style="background-color: #ffffff; padding: 10px;">
				<!--logo start-->
				<a href="${BASE_PATH}/index.htm" class="logo" title="访问前台页面" target="_blank">
					<img src="${TEMPLATE_BASE_PATH}/images/logo.png" style="height: 38px;width:140px;" />
				</a>
				<!--logo end-->
				<div class="nav notify-row" id="top_menu">
					<!--  notification goes here -->
				</div>
				<div class="top-nav ">

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
	                          <li><a href="${BASE_PATH}/admin/logout.htm"><i class="fa fa-external-link-square"></i> 安全退出</a></li>
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
                    <li>
                        <a class="link"><i class="fa fa-edit fa-4x "></i>&nbsp;&nbsp;研究成果 &nbsp;&nbsp;<i class="fa fa-chevron-down"></i></a>
                        <ul class="submenu">
                            <li><a class="link <#if menu="composition">active</#if>" href="${BASE_PATH}//manage/composition/listPage.htm">&nbsp;&nbsp;<span>学术著作</span> &nbsp;&nbsp;<#if menu="composition"><i class="fa fa-chevron-right"></i></#if></a></li>
                            <li><a class="link <#if menu="scholar">active</#if>" href="${BASE_PATH}/manage/scholar/listPage.htm">&nbsp;&nbsp;<span>学着风采</span> &nbsp;&nbsp;<#if menu="scholar"><i class="fa fa-chevron-right"></i></#if></a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="link"><i class="fa fa-user fa-4x "></i>&nbsp;&nbsp;用户管理 &nbsp;&nbsp;<i class="fa fa-chevron-down"></i></a>
                        <ul class="submenu">
                            <li><a class="link <#if menu="user_list">active</#if>" href="${BASE_PATH}/manage/user/manage.htm">&nbsp;&nbsp;<span>用户管理</span> &nbsp;&nbsp;<#if menu="user_list"><i class="fa fa-chevron-right"></i></#if></a></li>
                            <li><a class="link <#if menu="admin_list">active</#if>" href="${BASE_PATH}/manage/admin/manage.htm">&nbsp;<span>管理员管理</span> &nbsp;&nbsp;<#if menu="admin_list"><i class="fa fa-chevron-right"></i></#if></a></li>
                        </ul>
                    </li>
                    <li id="a">
                        <a class="link" ><i class="fa fa-cogs fa-4x "></i>&nbsp;&nbsp;网站设置 &nbsp;&nbsp;<i class="fa fa-chevron-down"></i></a>
                        <ul class="submenu" id="cog" >
                            <li><a  class="link <#if menu="system">active</#if>" href="${BASE_PATH}//manage/config/basic.htm">&nbsp;&nbsp;<span>基本设置</span> &nbsp;&nbsp;<#if menu="system"><i class="fa fa-chevron-right"></i></#if></a></li>
                            <li><a class="link <#if menu="menu">active</#if>" href="${BASE_PATH}/manage/menu/list.htm">&nbsp;&nbsp;<span>菜单管理</span> &nbsp;&nbsp;<#if menu="menu"><i class="fa fa-chevron-right"></i></#if></a></li>
                            <li><a class="link <#if menu="picture">active</#if>" href="${BASE_PATH}//manage/picture/listPage.htm">&nbsp;&nbsp;<span>展示图设置</span> &nbsp;&nbsp;<#if menu="picture"><i class="fa fa-chevron-right"></i></#if></a></li>
                            <li><a class="link <#if menu="friendlyLink">active</#if>" href="${BASE_PATH}/manage/friendlyLink/friendlyLink.htm">&nbsp;&nbsp;<span>友情链接</span> &nbsp;&nbsp;<#if menu="friendlyLink"><i class="fa fa-chevron-right"></i></#if></a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <script>

                $(document).ready(function(){
                    $("#cog").parent().slideDown();
                    $("#a").parent().toggleClass('open');
                });

                $(function() {

                    var Accordion = function(el, multiple) {
                        this.el = el || {};
                        this.multiple = multiple || false;

                        // Variables privadas
                        var links = this.el.find('.link');
                        // Evento
                        links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown)
                    };

                    Accordion.prototype.dropdown = function(e) {
                        var $el = e.data.el;
                        $this = $(this),
                                $next = $this.next();

                        $next.slideToggle();
                        $this.parent().toggleClass('open');

                        if (!e.data.multiple) {
                            $el.find('.submenu').not($next).slideUp().parent().removeClass('open');
                        };
                    };

                    var accordion = new Accordion($('#nav-accordion'), true);
                });
            </script>
        </aside>
        <!--sidebar end-->
