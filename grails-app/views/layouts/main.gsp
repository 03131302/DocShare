<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="东营市环保局工作信息共享平台"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/zTreeStyle', file: 'zTreeStyle.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <g:layoutHead/>
    <g:javascript library="application"/>
    <r:layoutResources/>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="597"><img src="${resource(dir: "images", file: "head01.jpg")}" width="597"
                             height="92"/></td>
        <td width="99%" id="herd00" align="right"></td>
        <td width="1%" id="herd00" align="right">
            <table width="111" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="33%" align="center"><g:link controller="index" action="index"><img
                            src="${resource(dir: "images", file: "shuaxin.gif")}" width="37" title="首页"
                            height="34"/></g:link></td>
                    <td width="33%" align="center"><g:link controller="manage" action="index"><img
                            src="${resource(dir: "images", file: "shezhi.gif")}" width="37" title="系统管理"
                            height="34"/></g:link></td>
                    <td width="33%" align="center"><g:link controller="login" action="logout"><img
                            src="${resource(dir: "images", file: "tuichu.gif")}" width="37" title="退出系统"
                            height="34"/></g:link></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<g:layoutBody/>
<div id="footer">
    <div class="panel panel-default">
        <div class="panel-body">
            <p class="text-muted text-center">
                版权所有：东营市环境保护局 Copyright 2013-2020 dyepb.gov.cn 鲁ICP备10003379号<br/>
                联系电话：（0546）8331789 12369 通讯地址：东营市东营区府前街100号 邮政编码：257091
            </p>
        </div>
    </div>
</div>

<div class="modal fade" id="myModalUpdatePassWord" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改密码</h4>
            </div>

            <div class="modal-body">
                <g:form name="updatePassWord" controller="manage" action="updatePassWord" role="form" method="POST">
                    <div class="form-group">
                        <label for="oldPassWord">旧密码</label>
                        <input type="password" class="form-control" id="oldPassWord" name="oldPassWord"
                               placeholder="密码" required>
                    </div>

                    <div class="form-group">
                        <label for="newPassWord">新密码</label>
                        <input type="password" class="form-control" id="newPassWord" name="newPassWord"
                               placeholder="密码" required>
                    </div>

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">确定</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.10.2.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: "js", file: "jquery.ztree.all-3.5.min.js")}"></script>
<script type="text/javascript" src="${resource(dir: "js", file: "bootstrap.min.js")}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.form.min.js')}"></script>
<r:layoutResources/>
</body>
</html>
