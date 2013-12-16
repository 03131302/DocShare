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
                        <a class="navbar-brand" href="javascript:void(0);">回收站信息管理</a>
                    </div>
                    <g:form controller="infoData" action="recycleIndex" name="titleLike" class="navbar-form navbar-left"
                            role="search" method="get">
                        <div class="form-group">
                            <input id="titleLikeValue" name="titleLikeValue" type="text" class="form-control"
                                   value="${titleLikeValue}"
                                   placeholder="主题">
                        </div>
                        <button type="submit" class="btn btn-default">
                            <span class="glyphicon glyphicon-search"></span> 搜索主题</button>
                    </g:form>
                    <button type="button" class="btn btn-primary navbar-btn" onclick="recover()">
                        <span class="glyphicon glyphicon-plus-sign"></span> 恢复</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="cleanAll()">
                        <span class="glyphicon glyphicon-fire"></span> 清空回收站</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="deleteInfoDataManage(1)">
                        <span class="glyphicon glyphicon-trash"></span> 删除</button>
                </nav>

                <table class="table table-striped table-condensed table-hover">
                    <thead>
                    <tr>
                        <th style="text-align: center;">选择</th>
                        <th style="text-align: center;">#</th>
                        <th>主题</th>
                        <th>发布时间</th>
                        <th>信息类型</th>
                        <th>发件人</th>
                        <th>发布类型</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${infoDataList}" var="data" status="n">
                        <tr>
                            <td style="text-align: center;"><input id="${data.id}" class="dataOracle" name="${data.id}"
                                                                   type="checkbox"
                                                                   value="${data.id}"></td>
                            <td style="text-align: center;">${n + 1}</td>
                            <td><g:link name="${data.title}"
                                        title="${data.title}" controller="infoData"
                                        action="show"
                                        params="${[id: data.id]}">${data.title.length() > 30 ? data.title.substring(0, 30) + "..." : data.title}</g:link></td>
                            <td><g:formatDate format="yyyy-MM-dd" date="${data.saveDate}"/></td>
                            <td>${data.type.name}</td>
                            <td>${data.user.userName}</td>
                            <td>${data.shareScope}</td>
                        </tr>
                    </g:each>
                    <g:if test="${infoDataInstanceCount > 30}">
                        <tr>
                            <td colspan="7" style="text-align: center;"><ul class="pagination">
                                <ocse:paginate total="${infoDataInstanceCount}" params="${params}"/>
                            </ul></td>
                        </tr>
                    </g:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<r:require module="infoDataManage"></r:require>
</body>
</html>