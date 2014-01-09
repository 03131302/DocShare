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
                        <a class="navbar-brand" href="javascript:void(0);">信息共享目录</a>
                    </div>
                    <button type="button" class="btn btn-primary navbar-btn" data-toggle="modal"
                            data-target="#shareFileModal">
                        <span class="glyphicon glyphicon-calendar"></span> 添加</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="updateShareFile()">
                        <span class="glyphicon glyphicon-pencil"></span> 修改</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="deleteShareFile()">
                        <span class="glyphicon glyphicon-trash"></span> 删除</button>
                </nav>

                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th style="text-align: center;width: 80px;">选择</th>
                        <th style="text-align: center;width: 80px;">#</th>
                        <th>主题</th>
                        <th>时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${data}" var="log" status="n">
                        <tr>
                            <td style="text-align: center;"><input id="${log.id}" class="dataOracle" name="${log.id}"
                                                                   type="checkbox"
                                                                   value="${log.id}"></td>
                            <td style="text-align: center;">${n + 1}</td>
                            <td><g:link target="_blank" controller="shareFile" action="download"
                                        params="[id:log.id]">${log.title}</g:link></td>
                            <td>${log.logDate}</td>
                        </tr>
                    </g:each>
                    <g:if test="${shareFileInstanceCount > 30}">
                        <tr>
                            <td colspan="5" style="text-align: center;"><ul class="pagination">
                                <ocse:paginate total="${shareFileInstanceCount}" params="${params}"/>
                            </ul></td>
                        </tr>
                    </g:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" data-backdrop="" id="shareFileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">信息共享目录</h4>
            </div>

            <div class="modal-body">
                <g:form controller="shareFile" action="save" method="post" class="form-horizontal" role="form"
                        name="shareFileForm">
                    <div class="form-group">
                        <label for="oldPassWord">主题</label>
                        <input type="text" class="form-control" id="title" name="title"
                               placeholder="主题" required>
                    </div>

                    <div class="form-group">
                        <input type="hidden" name="sharefilePathValue" id="sharefilePathValue">
                        <input type="file" name="sharefilePath" id="sharefilePath">
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
<iframe id="logFile" src="" width="0" hidden="hidden" height="0"></iframe>
<r:require module="shareFile"/>
</body>
</html>