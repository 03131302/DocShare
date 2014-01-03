<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>东营市环保局工作信息共享平台</title>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'login.css')}" type="text/css">
</head>

<body>
<div class="container" style="width: 460px;margin-top: 250px;margin-left: 600px;">
    <div class="row">
        <div class="col-md-9">
            <g:form controller="login" action="login" class="form-horizontal" role="form" method="POST">
                <div class="form-group">
                    <label for="userName" class="col-sm-3 control-label">用户名</label>

                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="userName" name="userName" placeholder="用户名"
                               required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="passWord" class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>

                    <div class="col-sm-9">
                        <input type="password" class="form-control" id="passWord" name="passWord" placeholder="密码"
                               required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="code" class="col-sm-3 control-label">验证码</label>

                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="code" name="code" placeholder="验证码" required>
                    </div>

                    <div class="col-sm-3">
                        <jcaptcha:jpeg id="imageCaptcha" name="imageCaptcha" height="32px" width="51px"
                                       onclick="reloadCaptcha();"
                                       title="点击刷新" style="cursor: pointer;"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-6">
                        <button type="submit" class="btn btn-primary">
                            <span class="glyphicon glyphicon-lock"></span> 登陆</button>
                    </div>
                </div>
            </g:form>
            <g:if test="${!data.empty}">
                <div class="alert alert-warning alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <strong>错误：</strong> ${data}
                </div>
            </g:if>
        </div>

        <div class="col-md-3">
            <div class="row">
                <div class="col-md-4">
                    <a href="${resource(dir: "js/browsers", file: "ChromeStandaloneSetup.exe")}" target="_blank">
                        <img src="${resource(dir: "images", file: "chrome.png")}" width="40" height="40"
                             title="Chrome 下载">
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <a href="${resource(dir: "js/browsers", file: "Firefox-setup.zip")}" target="_blank">
                        <img src="${resource(dir: "images", file: "firefox.png")}" width="40" height="40"
                             title="Firefox 下载">
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <a href="${resource(dir: "js/browsers", file: "IE10-Windows6.1-x86-zh-cn.exe")}" target="_blank">
                        <img src="${resource(dir: "images", file: "ie.png")}" width="40" height="40" title="IE10 下载">
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.10.2.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: "js", file: "bootstrap.min.js")}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.form.min.js')}"></script>
<!--[if lt IE 9]>
	<script  type="text/javascript" src="${resource(dir: 'js', file: 'html5shiv.js')}"></script>
	<script  type="text/javascript" src="${resource(dir: 'js', file: 'respond.min.js')}"></script>
<![endif]-->
<script type="text/javascript">
    function reloadCaptcha() {
        var captchaURL = $('#imageCaptcha').attr('src');
        captchaURL = captchaURL.replace(captchaURL.substring(captchaURL.indexOf("=") + 1, captchaURL.length), Math.floor(Math.random() * 9999999999));
        $('#imageCaptcha').attr('src', captchaURL);
    }
    $(document).ready(function () {
        var msie = /msie/.test(navigator.userAgent.toLowerCase());
        if (msie) {
            if ('undefined' == typeof(document.body.style.maxHeight)) {
                if (confirm("检测到您的浏览器版本小于IE8，因此为了您访问网络的安全与快速建议您安装Chrome浏览器，您是否同意安装？")) {
                    document.location = "${resource(dir: "js/browsers", file: "ChromeStandaloneSetup.exe")}";
                } else {
                    window.close();
                }
            }
        }
    });
</script>
</body>
</html>
