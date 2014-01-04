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
                        <a class="navbar-brand" href="javascript:void(0);">信息日志查看</a>
                    </div>
                    <button type="button" class="btn btn-primary navbar-btn" onclick="cleanAll()">
                        <span class="glyphicon glyphicon-fire"></span> 清空日志</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="deleteLog()">
                        <span class="glyphicon glyphicon-trash"></span> 删除</button>
                </nav>

                <table class="table table-striped table-condensed table-hover">
                    <thead>
                    <tr>
                        <th style="text-align: center;">选择</th>
                        <th style="text-align: center;">#</th>
                        <th>用户名</th>
                        <th>操作信息</th>
                        <th>登陆IP</th>
                        <th>登陆时间</th>
                        <th>操作类型</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${logs}" var="data" status="n">
                        <tr>
                            <td style="text-align: center;"><input id="${data.id}" class="dataOracle" name="${data.id}"
                                                                   type="checkbox"
                                                                   value="${data.id}"></td>
                            <td style="text-align: center;">${n + 1}</td>
                            <td>${(data?.user?.userName)?data?.user?.userName:"[已删除]"}</td>
                            <td>
                                <g:if test="${data.infoData != null}">
                                    <g:link name="${data.infoData?.title}"
                                            title="${data.infoData?.title}" controller="infoData"
                                            action="show"
                                            params="${[id: data.infoData?.id]}">
                                        ${data.infoData?.title?.length() > 30 ? data.infoData?.title?.substring(0, 30) + "..." : data.infoData?.title}
                                    </g:link>
                                </g:if>
                                <g:else>
                                    [已删除]
                                </g:else>
                            </td>
                            <td>${data.ip}</td>
                            <td>${data.infoDate}</td>
                            <td>${data.type}</td>
                        </tr>
                    </g:each>
                    <g:if test="${infoLogInstanceCount > 30}">
                        <tr>
                            <td colspan="7" style="text-align: center;"><ul class="pagination">
                                <ocse:paginate total="${infoLogInstanceCount}" params="${params}"/>
                            </ul></td>
                        </tr>
                    </g:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<r:require module="infoLog"></r:require>
</body>
</html>