<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>东营市环保局工作信息共享平台</title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'login.css')}" type="text/css">
</head>

<body>
<div class="container" style="width: 320px;margin-top: 250px;margin-left: 620px;">
    <div>
        <g:form controller="login" action="login" class="form-horizontal" role="form" method="POST">
            <div class="form-group">
                <label for="userName" class="col-sm-3 control-label">用户名</label>

                <div class="col-sm-9">
                    <input type="text" class="form-control" id="userName" name="userName" placeholder="用户名" required>
                </div>
            </div>

            <div class="form-group">
                <label for="passWord" class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>

                <div class="col-sm-9">
                    <input type="password" class="form-control" id="passWord" name="passWord" placeholder="密码" required>
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
</div>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.10.2.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: "js", file: "bootstrap.min.js")}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.form.min.js')}"></script>
<script type="text/javascript">
    function reloadCaptcha() {
        var captchaURL = $('#imageCaptcha').attr('src');
        captchaURL = captchaURL.replace(captchaURL.substring(captchaURL.indexOf("=") + 1, captchaURL.length), Math.floor(Math.random() * 9999999999));
        $('#imageCaptcha').attr('src', captchaURL);
    }
</script>
</body>
</html>
