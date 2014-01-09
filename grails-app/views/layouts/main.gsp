<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="东营市环保局工作信息共享平台"/></title>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="stylesheet" href="${resource(dir: 'css/zTreeStyle', file: 'zTreeStyle.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'js/uploadify', file: 'uploadify.css')}" type="text/css">
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
        <td width="98%" id="herd00" align="right"></td>
        <td width="2%" id="herd00" align="left" style="padding-right: 30px;">
            <table width="111" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="25%" align="center"><g:link controller="index" action="index"><img
                            src="${resource(dir: "images", file: "shuaxin.gif")}" width="37" title="首页"
                            height="34"/></g:link></td>
                    <td width="25%" align="center"><g:link controller="manage" action="index"><img
                            src="${resource(dir: "images", file: "shezhi.gif")}" width="37" title="系统管理"
                            height="34"/></g:link></td>
                    <td width="25%" align="center"><g:link controller="index" action="index"><img
                            src="${resource(dir: "images", file: "help.gif")}" width="37" title="使用帮助"
                            height="34"/></g:link></td>
                    <td width="25%" align="center" style="padding-left: 10px;"><g:link controller="login" action="logout"><img
                            src="${resource(dir: "images", file: "tuichu.gif")}" width="37" title="退出系统"
                            height="34"/></g:link></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<g:layoutBody/>

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

<div class="modal fade" data-backdrop="" id="infoNewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 920px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">信息发布</h4>
            </div>

            <div class="modal-body">
                <g:form controller="infoData" action="save" method="post" class="form-horizontal" role="form"
                        name="infoDataForm">
                    <input type="hidden" id="infoDataObject" name="infoDataObject" value="${infoDataInstance?.id}">

                    <div class="form-group">
                        <div class="col-md-4" style="padding-left: 0px;margin-left: 0px;">
                            <label for="shareScope" class="col-md-4 control-label">发布类型</label>

                            <div class="col-md-8" style="padding-left: 0px;">
                                <select class="form-control" id="shareScope" name="shareScope">
                                    <option value="工作信息">工作信息</option>
                                    <option value="通知公告">通知公告</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label for="shareTypeName" class="col-md-4 control-label">关键字&nbsp;</label>

                            <div class="col-md-8">
                                <div class="input-group">
                                    <input type="hidden" class="form-control"
                                           id="type" name="type.id">
                                    <input type="text" readonly class="form-control"
                                           id="shareTypeName" name="shareTypeName" required>
                                    <span class="input-group-btn">
                                        <button id="typeButton" class="btn btn-default" type="button" data-toggle="modal"
                                                data-target="#infoTypeModal">选择</button>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label for="reType" class="col-md-4 control-label">反馈类型</label>

                            <div class="col-md-8">
                                <select class="form-control" id="reType" name="reType">
                                    <option value="">请选择类型</option>
                                    <option value="查收回执">查收回执</option>
                                    <option value="文件提交反馈">文件提交反馈</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="userScope" class="col-md-1 control-label">收件人</label>

                        <div class="col-md-11">
                            <input type="hidden" class="form-control"
                                   id="shareType" name="shareType" value="全部">
                            <input type="hidden" class="form-control"
                                   id="userScopeData" name="userScopeData" required>
                            <input type="text" readonly class="form-control" onclick="selectUser()"
                                   id="userScope" name="userScope" required value="全部" style="cursor: pointer;">
                        </div>

                    </div>

                    <div class="form-group">
                        <label for="title" class="col-md-1 control-label">主&nbsp;&nbsp;&nbsp;题</label>

                        <div class="col-md-11">
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="hidden" name="filePathValue" id="filePathValue">
                            <input type="hidden" name="fileNameValue" id="fileNameValue">
                            <input type="file" name="filePath" id="filePath">
                        </div>

                        <div class="col-md-12" id="fileList">
                        </div>
                    </div>

                    <div class="form-group" style="margin-left: 2px;">
                        <textarea name="textData" id="textData"></textarea>
                    </div>

                    <div class="modal-footer">
                        <button type="reset" class="btn btn-default">
                            <span class="glyphicon glyphicon-refresh"></span> 清空</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <span class="glyphicon glyphicon-remove-circle"></span> 取消</button>
                        <button type="submit" class="btn btn-primary">
                            <span class="glyphicon glyphicon-plus-sign"></span> 确定</button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" data-backdrop="" id="infoNewreTypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">提交回执</h4>
            </div>

            <div class="modal-body">
                <g:form controller="recipient" action="save" method="post" class="form-horizontal" role="form"
                        name="infoDatareTypeForm">
                    <input type="hidden" id="infoData" name="infoData.id" value="${infoDataInstance?.id}">
                    <input type="hidden" id="user" name="user.id" value="${session["adminUser"]?.id}">

                    <div class="form-group">
                        <textarea name="text" id="text" class="form-control" rows="3" required></textarea>
                    </div>

                    <div class="modal-footer">
                        <button type="reset" class="btn btn-default">
                            <span class="glyphicon glyphicon-refresh"></span> 清空</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <span class="glyphicon glyphicon-remove-circle"></span> 取消</button>
                        <button type="submit" class="btn btn-primary">
                            <span class="glyphicon glyphicon-plus-sign"></span> 确定</button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" data-backdrop="" id="infoTypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">信息类型</h4>
            </div>

            <div class="modal-body">
                <div id="infoTypezTree" class="ztree" style="padding-top: 0px;">
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove-circle"></span> 取消</button>
                <button type="button" class="btn btn-primary" onclick="selectInfoType()">
                    <span class="glyphicon glyphicon-plus-sign"></span> 确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" data-backdrop="" id="infoTypeModalSearch" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">信息类型</h4>
            </div>

            <div class="modal-body">
                <div id="infoTypeSearchzTree" class="ztree" style="padding-top: 0px;">
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove-circle"></span> 取消</button>
                <button type="button" class="btn btn-primary" onclick="selectInfoTypeSearch()">
                    <span class="glyphicon glyphicon-plus-sign"></span> 确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" data-backdrop="" id="infoOrgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn btn-primary navbar-btn" onclick="selectUserData(true)">
                    <span class="glyphicon glyphicon-check"></span> 全部用户</button>
            </div>

            <div class="modal-body">
                <div id="infoOrgzTree" class="ztree" style="padding-top: 0px;">
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove-circle"></span> 取消</button>
                <button type="button" class="btn btn-primary" onclick="selectUserData()">
                    <span class="glyphicon glyphicon-plus-sign"></span> 确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" data-backdrop="" id="userCommitModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">建议反馈</h4>
            </div>

            <div class="modal-body">
                <g:form controller="userCommit" action="save" method="post" class="form-horizontal" role="form"
                        name="userCommitForm">
                    <input type="hidden" id="user" name="user.id" value="${session["adminUser"]?.id}">

                    <div class="form-group">
                        <label for="oldPassWord">主题</label>
                        <input type="text" class="form-control" id="title" name="title"
                               placeholder="主题" required>
                    </div>
                    <div class="form-group">
                        <textarea name="content" id="content" class="form-control" rows="8" required></textarea>
                    </div>

                    <div class="modal-footer">
                        <button type="reset" class="btn btn-default">
                            <span class="glyphicon glyphicon-refresh"></span> 清空</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <span class="glyphicon glyphicon-remove-circle"></span> 取消</button>
                        <button type="submit" class="btn btn-primary">
                            <span class="glyphicon glyphicon-plus-sign"></span> 确定</button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" data-backdrop="" id="userWorkLogModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">工作日志</h4>
            </div>

            <div class="modal-body">
                <g:form controller="userWorkLog" action="save" method="post" class="form-horizontal" role="form"
                        name="userWorkLogForm">
                    <input type="hidden" id="user" name="user.id" value="${session["adminUser"]?.id}">

                    <div class="form-group">
                        <label for="oldPassWord">主题</label>
                        <input type="text" class="form-control" id="title" name="title"
                               placeholder="主题" required>
                    </div>

                    <div class="form-group">
                        <label for="oldPassWord">日期</label>
                        <input type="text" class="form-control" id="logDate" name="logDate" onClick="WdatePicker()"
                               placeholder="日期" required>
                    </div>

                    <div class="form-group">
                        <textarea name="content" id="content" class="form-control" rows="8" required></textarea>
                    </div>

                    <div class="modal-footer">
                        <button type="reset" class="btn btn-default">
                            <span class="glyphicon glyphicon-refresh"></span> 清空</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <span class="glyphicon glyphicon-remove-circle"></span> 取消</button>
                        <button type="submit" class="btn btn-primary">
                            <span class="glyphicon glyphicon-plus-sign"></span> 确定</button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.10.2.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: "js", file: "jquery.ztree.all-3.5.min.js")}"></script>
<script type="text/javascript" src="${resource(dir: "js/uploadify", file: "jquery.uploadify.min.js")}"></script>
<script type="text/javascript" src="${resource(dir: "js/ckeditor", file: "ckeditor.js")}"></script>
<script type="text/javascript" src="${resource(dir: "js", file: "bootstrap.min.js")}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.form.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/My97DatePicker', file: 'WdatePicker.js')}"></script>
<script type="text/javascript">
    function getLocation() {
        return "${request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"}";
    }
    function getSession() {
        return ";jsessionid=${session.id}";
    }
</script>
<r:layoutResources/>
</body>
</html>
