<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta name="layout" content="main"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>东营市环保局工作信息共享平台</title>
</head>

<body>
<div class="container" style="width: 100%;margin: 15px 0px;0px;0px;">
    <div class="row col-md-12" style="width: 100%;margin: 0px 0px;0px;0px;">
        <g:include view="manage/manageLeft.gsp"></g:include>
        <div class="col-md-9" style="padding-right: 0px;margin-right: 0px;">
            <div class="panel panel-default">
                <nav class="navbar navbar-default" role="navigation" style="margin-bottom: 2px;">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="javascript:void(0);">系统登陆日志</a>
                    </div>
                    <button type="button" class="btn btn-primary navbar-btn" onclick="cleanAll()">
                        <span class="glyphicon glyphicon-plus-sign"></span> 清空日志</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="deleteLog()">
                        <span class="glyphicon glyphicon-trash"></span> 删除</button>
                </nav>

                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>选择</th>
                        <th>#</th>
                        <th>用户名</th>
                        <th>登陆IP</th>
                        <th>登陆时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${logList}" var="log" status="n">
                        <tr>
                            <td><input id="${log.id}" class="dataOracle" name="${log.id}" type="checkbox"
                                       value="${log.id}"></td>
                            <td>${n + 1}</td>
                            <td>${log.user.userName}</td>
                            <td>${log.ip}</td>
                            <td>${log.loginDate}</td>
                        </tr>
                    </g:each>
                    <g:if test="${loginLogInstanceCount > 20}">
                        <tr>
                            <td colspan="5" style="text-align: center;"><ul class="pagination">
                                <ocse:paginate total="${loginLogInstanceCount}" params="${params}"/>
                            </ul></td>
                        </tr>
                    </g:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<r:require module="loginLog"/>
</body>
</html>
