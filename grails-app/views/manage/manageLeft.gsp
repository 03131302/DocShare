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

                <div id="collapseOne" class="panel-collapse collapse in">
                    <div class="list-group" style="margin: 0 0 0 0">
                        <g:link controller="manage" action="index" class="list-group-item">组织机构管理</g:link>
                        <g:link controller="manage" action="userManageIndex" class="list-group-item">用户信息管理</g:link>
                        <g:link controller="loginLog" action="index" class="list-group-item">登陆日志查看</g:link>
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

                <div id="collapseTwo" class="panel-collapse collapse">
                    <div class="list-group" style="margin: 0 0 0 0">
                        <a href="#" class="list-group-item">共享信息管理</a>
                        <a href="#" class="list-group-item">信息日志查看</a>
                        <g:link controller="infoType" action="index" class="list-group-item">关键字管理</g:link>
                        <a href="#" class="list-group-item">回收站信息管理</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>