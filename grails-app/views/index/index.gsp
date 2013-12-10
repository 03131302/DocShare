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
        <div class="col-md-2" style="padding-left: 5px;">
            <div class="row">
                <g:include view="wellcome.gsp"></g:include>
                <div class="panel panel-default" style="margin-top: 2px;">
                    <div class="panel-heading">
                        <h2 class="panel-title">按单位查询</h2>
                    </div>

                    <div class="panel-body">
                        <div id="indexzTree" class="ztree" style="margin-top: 0px;"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-10" style="padding-right: 0px;margin-right: 0px;">
            <nav class="navbar navbar-default" role="navigation" style="margin-bottom: 5px;">
                <form class="navbar-form navbar-left" role="search">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="搜索全部文件">
                    </div>
                    <button type="submit" class="btn btn-default">
                        <span class="glyphicon glyphicon-search"></span> 搜索</button>
                </form>
                <button type="button" class="btn btn-default navbar-btn">
                    <span class="glyphicon glyphicon-globe"></span> 关键字检索</button>
                <button type="button" class="btn btn-primary navbar-btn">
                    <span class="glyphicon glyphicon-plus-sign"></span> 信息发布</button>
            </nav>

            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-md-1"><img style="margin-top: 0px;"
                                                                   src="${resource(dir: "images", file: "fajianjia.gif")}"/>
                                        </div>

                                        <div class="col-md-11" style="padding-top: 5px;"><strong>发件夹</strong></div>
                                    </div>
                                </div>

                                <div class="panel-body">
                                    Panel content
                                </div>

                                <div class="panel-footer text-right" style="color: #1316e3"><span
                                        class="glyphicon glyphicon-th-large"></span>&nbsp;更多</div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-md-1"><img style="margin-top: 0px;"
                                                                   src="${resource(dir: "images", file: "shoujianjia.gif")}"/>
                                        </div>

                                        <div class="col-md-11" style="padding-top: 5px;"><strong>&nbsp;收件夹</strong>
                                        </div>
                                    </div>
                                </div>

                                <div class="panel-body">
                                    Panel content
                                </div>

                                <div class="panel-footer text-right" style="color: #1316e3"><span
                                        class="glyphicon glyphicon-th-large"></span>&nbsp;更多</div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class=" panel panel-default">
                                <div class="panel-heading">
                                    <img style="margin-top: 0px;"
                                         src="${resource(dir: "images", file: "quanjuxinxi.gif")}"/>
                                    <sapn style="padding-top: 10px;"><strong>最新共享信息</strong></sapn>
                                </div>

                                <div class="panel-body">
                                    Panel content
                                </div>

                                <div class="panel-footer text-right" style="color: #1316e3"><span
                                        class="glyphicon glyphicon-th-large"></span>&nbsp;更多</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<r:require module="index"></r:require>
</body>
</html>
