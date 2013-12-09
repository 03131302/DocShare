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
        <div class="col-md-3" style="padding-left: 5px;">
            <div class="row">
                <div class="panel panel-default" style="margin-bottom: 5px;">
                    <div class="panel-heading">
                        <span class="glyphicon glyphicon-volume-up"></span>&nbsp;&nbsp;<span
                            class="panel-title">杨晓东，欢迎您。</span>
                    </div>
                </div>

                <div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion"
                                   href="#collapseOne">
                                    系统管理
                                </a>
                            </h4>
                        </div>

                        <div id="collapseOne" class="panel-collapse collapse in">
                            <div class="list-group" style="margin: 0 0 0 0">
                                <g:link controller="manage" action="index" class="list-group-item">组织机构管理</g:link>
                                <a href="#" class="list-group-item">用户信息管理</a>
                                <a href="#" class="list-group-item">角色权限管理</a>
                                <a href="#" class="list-group-item">本人密码修改</a>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion"
                                   href="#collapseTwo">
                                    信息管理
                                </a>
                            </h4>
                        </div>

                        <div id="collapseTwo" class="panel-collapse collapse">
                            <div class="list-group" style="margin: 0 0 0 0">
                                <a href="#" class="list-group-item">共享信息管理</a>
                                <a href="#" class="list-group-item">回收站信息管理</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-9" style="padding-right: 0px;margin-right: 0px;">
            <div class="panel panel-default">
                <nav class="navbar navbar-default" role="navigation" style="margin-bottom: 2px;">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="javascript:void(0);">组织机构管理</a>
                    </div>
                    <button type="button" class="btn btn-primary navbar-btn" data-toggle="modal"
                                        data-target="#orgModal">
                    <span class="glyphicon glyphicon-plus-sign"></span> 添加</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="updateOrg()">
                        <span class="glyphicon glyphicon-pencil"></span> 修改</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="deleteOrg()">
                        <span class="glyphicon glyphicon-trash"></span> 删除</button>
                </nav>

                <div class="panel-body">
                    <div id="zTree" class="ztree" style="padding-top: 0px;">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="orgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">组织机构维护</h4>
            </div>

            <div class="modal-body">
                <g:form controller="organization" action="save" role="form" method="post" name="orgForm">
                    <input type="hidden" class="form-control" id="parent.id" name="parent.id" value="">
                    <input type="hidden" class="form-control" id="id" name="id" value="">
                    <div class="form-group">
                        <label for="name">机构名称</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="机构名称" required>
                    </div>

                    <div class="form-group">
                        <label for="pxh">排序号</label>
                        <input type="text" class="form-control" id="pxh" name="pxh" placeholder="排序号" required>
                    </div>

                    <div class="form-group">
                        <label for="text">说明</label>
                        <input type="text" class="form-control" id="text" name="text" placeholder="说明" required>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
