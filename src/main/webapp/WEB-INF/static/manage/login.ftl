<!DOCTYPE html>
<html lang="zh_CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Mosaddek">
<meta name="keyword"
	content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

<title>ITIMRC后台登录</title>

<!-- Bootstrap core CSS -->
<link rel="icon" href="${TEMPLATE_BASE_PATH}/images/favicon.ico"  type="image/x-icon">
<link href="${BASE_PATH}/static/manage/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${BASE_PATH}/static/manage/css/bootstrap-reset.css"
	rel="stylesheet">
<!--external css-->
<link
	href="${BASE_PATH}/static/manage/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="${BASE_PATH}/static/manage/css/style.css" rel="stylesheet">
<link href="${BASE_PATH}/static/manage/css/style-responsive.css"
	rel="stylesheet" />

<!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
<!--[if lt IE 9]>
    <script src="${BASE_PATH}/static/manage/js/html5shiv.js"></script>
    <script src="${BASE_PATH}/static/manage/js/respond.min.js"></script>
    <![endif]-->
<script src="${BASE_PATH}/static/manage/js/jquery.js"></script>
<script src="${BASE_PATH}/static/manage/js/jquery.form.min.js"></script>
<style type="text/css">
p.error {
	color: #DE5959;
}

.form-signin input[type="text"].error, .form-signin input[type="password"].error
	{
	border-color: #b94a48;
	color: #b94a48;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
}

input.error:focus {
	border-color: #953b39;
	color: #b94a48;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px
		#d59392;
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 6px #d59392;
}
</style>
</head>

<body class="login-body">

	<div class="container">

		<form class="form-signin" id="adminForm"
			action="${BASE_PATH}/admin/login.json" autocomplete="off"
			method="post">
			<h2 class="form-signin-heading">
				<img src="${TEMPLATE_BASE_PATH}/images/logo-bg.png"
					style="height: 38px;" />
			</h2>
			<div class="login-wrap">
				<div class="form-group">
                                      <label for="exampleInputEmail1">用户名</label>
                                      <input type="text" name="name" id="name" required class="form-control" placeholder="用户名" value="admin" style="*width: 250px;" autofocus>
                                  </div>
 				<div class="form-group">
                                      <label for="exampleInputEmail1">密码</label>
                                      <input type="password" required id="password" name="password" required class="form-control" placeholder="密码" value="123456" style="*width: 250px;">
                                  </div>	                                 	
				<div class="form-group">
					<input type="text" name="captcha" class="form-control"  required
						placeholder="验证码" style="width: 100px; float: left;" id="captcha" value="abcd"> <img

						style="cursor: pointer; cursor: hand; margin-top: -13px;"
						onclick="this.src='${BASE_PATH}/admin/captcha.htm?'+Math.random();"
						src="${BASE_PATH}/admin/captcha.htm">
				</div>
				<div class="clearfix"></div>
				<div>
					<p class="error" >${error!}</p>
				</div>
				<input class="btn btn-lg btn-login btn-block" type="submit" value="登录"/>
			</div>
		</form>

	</div>

</body>
<script>
    $("#adminForm").submit(function(){
        var name = $('#name').val();
        var pwd = $('#password').val();
        var captcha = $('#captcha').val();
        if(name==null||name==""){
            alert("请输入用户名");
            return false;
        }
        if(pwd==null||pwd==""){
            alert("请输入密码");
            return false;
        }
        if(captcha==null||captcha==""){
            alert("请输入验证码");
            return false;
        }
        return true;
    });
</script>
</html>