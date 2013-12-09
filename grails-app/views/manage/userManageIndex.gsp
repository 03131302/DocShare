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
                        <a class="navbar-brand" href="javascript:void(0);">用户信息管理</a>
                    </div>
                    <button type="button" class="btn btn-primary navbar-btn" data-toggle="modal"
                            data-target="#userModal">
                        <span class="glyphicon glyphicon-plus-sign"></span> 添加</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="updateUser()">
                        <span class="glyphicon glyphicon-pencil"></span> 修改</button>
                    <button type="button" class="btn btn-default navbar-btn" onclick="deleteUser()">
                        <span class="glyphicon glyphicon-trash"></span> 删除</button>
                </nav>

                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>选择</th>
                        <th>#</th>
                        <th>用户名</th>
                        <th>登陆名</th>
                        <th>所在机构</th>
                        <th>是否停用</th>
                        <th>级别</th>
                        <th>排序号</th>
                        <th>备注</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${users}" var="user" status="n">
                        <tr>
                            <td><input id="${user.id}" class="dataOracle" name="${user.id}" type="checkbox"
                                       value="${user.id}"></td>
                            <td>${n + 1}</td>
                            <td>${user.userName}</td>
                            <td>${user.userCode}</td>
                            <td>${user.org.name}</td>
                            <td>${user.isStop ? "正常" : "已停用"}</td>
                            <td>${user.jb}</td>
                            <td>${user.pxh}</td>
                            <td>${user.text}</td>
                        </tr>
                    </g:each>
                    <g:if test="${adminUserInstanceCount > 20}">
                        <tr>
                            <td colspan="9" style="text-align: center;"><ul class="pagination">
                                <ocse:paginate total="${adminUserInstanceCount}" params="${params}"/>
                            </ul></td>
                        </tr>
                    </g:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">用户信息管理</h4>
            </div>

            <div class="modal-body">
                <g:form controller="adminUser" action="save" role="form" method="post" name="userForm">
                    <input type="hidden" class="form-control" id="org" name="org.id" value="">

                    <div class="row">
                        <div class="col-md-10">
                            <label for="org">机构名称</label>
                            <input type="text" class="form-control" id="orgName" name="orgName" disabled
                                   placeholder="机构名称" required>
                        </div>

                        <div class="col-md-2">
                            <label for="orgBt">点击添加</label>
                            <button type="button" class="btn btn-primary" id="orgBt" data-toggle="modal"
                                    data-target="#orgModal">
                                <span class="glyphicon glyphicon-plus-sign"></span> 添加</button>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label for="userName">用户姓名</label>
                            <input type="text" class="form-control" id="userName" name="userName" placeholder="用户姓名"
                                   required>
                        </div>

                        <div class="col-md-6">
                            <label for="userCode">登录名称</label>
                            <input type="text" class="form-control" id="userCode" name="userCode" placeholder="登录名称"
                                   required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label for="passWord">密码</label>
                            <input type="password" class="form-control" id="passWord" name="passWord" placeholder="密码"
                                   required>
                        </div>

                        <div class="col-md-6">
                            <label for="pxh">排序号</label>
                            <input type="text" class="form-control" id="pxh" name="pxh" placeholder="排序号" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label for="isStop">是否停用</label>
                            <select class="form-control" name="isStop" id="isStop">
                                <option value="1">正常</option>
                                <option value="0">已停用</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label for="jb">级别</label>
                            <select class="form-control" name="jb" id="jb">
                                <option value="普通用户">普通用户</option>
                                <option value="管理员">管理员</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="text">说明</label>
                        <input type="text" class="form-control" id="text" name="text" placeholder="说明">
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <span class="glyphicon glyphicon-remove-circle"></span> 取消</button>
                        <button type="submit" class="btn btn-primary">
                            <span class="glyphicon glyphicon-plus-sign"></span> 保存</button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="orgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">组织机构</h4>
            </div>

            <div class="modal-body">
                <div id="zTree" class="ztree" style="padding-top: 0px;">
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove-circle"></span> 取消</button>
                <button type="button" class="btn btn-primary" onclick="selectOrg()">
                    <span class="glyphicon glyphicon-plus-sign"></span> 确定</button>
            </div>
        </div>
    </div>
</div>
<r:require module="userManage"/>
</body>
</html>
