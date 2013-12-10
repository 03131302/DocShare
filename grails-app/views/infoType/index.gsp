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
                        <a class="navbar-brand" href="javascript:void(0);">关键字管理</a>
                    </div>
                    <button type="button" class="btn btn-primary navbar-btn" data-toggle="modal"
                            data-target="#infoTypeModal">
                        <span class="glyphicon glyphicon-plus-sign"></span> 添加</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="updateOrg()">
                        <span class="glyphicon glyphicon-pencil"></span> 修改</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="deleteOrg()">
                        <span class="glyphicon glyphicon-trash"></span> 删除</button>
                </nav>

                <div class="panel-body">
                    <div id="infoTypezTree" class="ztree" style="margin-top: 0px;">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="infoTypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">关键字信息维护</h4>
            </div>

            <div class="modal-body">
                <g:form controller="infoType" action="save" role="form" method="post" name="infoForm">
                    <input type="hidden" class="form-control" id="parentInfoType" name="parentInfoType.id" value="">
                    <input type="hidden" class="form-control" id="id" name="id" value="">

                    <div class="form-group">
                        <label for="name">关键字</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="关键字" required>
                    </div>

                    <div class="form-group">
                        <label for="pxh">排序号</label>
                        <input type="text" class="form-control" id="pxh" name="pxh" placeholder="排序号" required>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <span class="glyphicon glyphicon-remove-circle"></span> 取消</button>
                        <button type="submit" class="btn btn-primary">
                            <span class="glyphicon glyphicon-plus-sign"></span>保存</button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
</body>
<r:require module="infoType"/>
</html>