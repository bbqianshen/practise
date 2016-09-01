<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="login-bg">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0;" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>

    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap-overrides.css" type="text/css"/>
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap-responsive.css"/>
    <link rel="stylesheet" href="dist/css/bootstrapValidator.css"/>
    
    <!-- global styles -->
    <link rel="stylesheet" type="text/css" href="css/layout.css" />
    <link rel="stylesheet" type="text/css" href="css/elements.css" />
    <link rel="stylesheet" type="text/css" href="css/icons.css" />
    
    <!-- libraries -->
    <link rel="stylesheet" type="text/css" href="css/lib/font-awesome.css" />
    
    <!-- this page specific styles -->
    <link rel="stylesheet" href="css/compiled/signin.css" type="text/css" media="screen" />

    <!-- open sans font -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css' />

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    
    <script type="text/javascript" src="vendor/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="dist/js/bootstrapValidator.js"></script>
    <script type="text/javascript">
	$("html").css("background-image", "url('img/bgs/landscape.jpg')");
	
	$(function(){
		
		$('#loginForm').bootstrapValidator({
	        message: 'This value is not valid',
	        feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        threshold: 2,
	        fields: {
	            username: {
	                validators: {
	                    notEmpty: {
	                        message: '用户名不能为空!'
	                    }
	                }
	            },
	            password: {
	                validators: {
	                    notEmpty: {
	                        message: '密码不能为空!'
	                    }
	                }
	            }
	        }
	    }).on('success.form.bv', function(e) {
            // Prevent form submission
            e.preventDefault();

            // Get the form instance
            var $form = $(e.target);

            // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');

            // Use Ajax to submit form data
            $.post($form.attr('action'), $form.serialize(), function(result) {
            	if (result.valid == true || result.valid == 'true') {
            		window.location.href = "index";
            	}else{
            		$('#errors').removeClass('hide');
            		$("input").val("");
            	}
            }, 'json');
            
        });
		$("input").click(function(){
			$('#errors').addClass('hide');
		});
	});


</script>
</head>
<body>
	<div class="row-fluid login-wrapper">
        <a href="index.html">
            <img class="logo" src="img/logo-white.png" />
        </a>

		<form action="validateLogin" class="span4 box form-horizontal" method="post" id="loginForm">
	            <div class="content-wrap">
	                <h6>OA管理系统</h6>
	                <div class="form-group">
		                	<input class="span12 form-control" type="text" placeholder="输入用户名" name="username"/>
	                </div>
	                <div class="form-group">
	                		<input class="span12 form-control" type="password" placeholder="输入密码"  name="password"/>
	                </div>
	                <div class="hide" id="errors" style="color:#F00">用户名或密码错误!</div>
	                <a href="#" class="forgot">忘记密码?</a>
	                <div class="remember">
	                    <input id="remember-me" type="checkbox" />
	                    <label for="remember-me">记住我</label>
	                </div>
	                <div class="form-group">
                        <button type="submit" class="btn-glow primary login" id="login">登录</button>
               		</div>
	                
	            </div>
        </form>
    </div>
</body>
</html>