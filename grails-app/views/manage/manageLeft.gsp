<g:set var="collapse0" value=""></g:set>
<g:set var="collapse1" value=""></g:set>
<g:if test="${controllerName == "manage" || controllerName == "loginLog" || controllerName == "userCommit" || controllerName == "userWorkLog"}">
    <g:set var="collapse0" value="in"></g:set>
    <g:set var="collapse1" value=""></g:set>
</g:if>
<g:else>
    <g:set var=" collapse0" value=""></g:set>
    <g:set var="collapse1" value="in"></g:set>
</g:else>
<div class="col-md-3" style="padding-left: 5px;">
    <div class="row">
        <g:include view="wellcome.gsp"></g:include>
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

                <div id="collapseOne" class="panel-collapse collapse ${collapse0}">
                    <div class="list-group" style="margin: 0 0 0 0">
                        <g:if test="${"管理员".equals(session["adminUser"].jb)}">
                            <g:link controller="manage" action="index"
                                    class="list-group-item ${(controllerName == "manage" && actionName == "index") ? "active" : ""}">组织机构管理</g:link>
                            <g:link controller="manage" action="userManageIndex"
                                    class="list-group-item ${(controllerName == "manage" && actionName == "userManageIndex") ? "active" : ""}">用户信息管理</g:link>
                            <g:link controller="loginLog" action="index"
                                    class="list-group-item ${(controllerName == "loginLog" && actionName == "index") ? "active" : ""}">登陆日志查看</g:link>
                            <g:link controller="userCommit" action="index"
                                    class="list-group-item ${(controllerName == "userCommit" && actionName == "index") ? "active" : ""}">用户建议反馈</g:link>
                        </g:if>
                        <g:if test="${!"管理员".equals(session["adminUser"].jb)}">
                            <g:link controller="userWorkLog" action="index"
                                    class="list-group-item ${(controllerName == "userWorkLog" && actionName == "index") ? "active" : ""}">工作日志管理</g:link>
                        </g:if>
                        <a href="javascript:void(0)" data-toggle="modal"
                           data-target="#myModalUpdatePassWord" class="list-group-item">本人密码修改</a>
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

                <div id="collapseTwo" class="panel-collapse collapse ${collapse1}">
                    <div class="list-group" style="margin: 0 0 0 0">
                        <g:link controller="infoData" action="index"
                                class="list-group-item ${(controllerName == "infoData" && actionName == "index") ? "active" : ""}">共享信息管理</g:link>
                        <g:if test="${"管理员".equals(session["adminUser"].jb)}">
                            <g:link controller="infoLog" action="index"
                                    class="list-group-item ${(controllerName == "infoLog" && actionName == "index") ? "active" : ""}">信息日志查看</g:link>
                            <g:link controller="infoType" action="index"
                                    class="list-group-item ${(controllerName == "infoType" && actionName == "index") ? "active" : ""}">关键字管理</g:link>
                            <g:link controller="shareFile" action="index"
                                    class="list-group-item ${(controllerName == "shareFile" && actionName == "index") ? "active" : ""}">信息共享目录</g:link>
                            <g:link controller="infoData" action="recycleIndex"
                                    class="list-group-item ${(controllerName == "infoData" && actionName == "recycleIndex") ? "active" : ""}">回收站信息管理</g:link>
                        </g:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>