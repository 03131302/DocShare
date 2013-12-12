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
<g:include view="index/bar.gsp"></g:include>
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

        <table class="table table-striped table-condensed table-hover">
            <thead>
            <tr>
                <th style="text-align: center;">#</th>
                <th>主题</th>
                <th>发布时间</th>
                <th>快速访问</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${sendList}" var="data" status="n">
                <tr>
                    <td style="width: 30px;text-align: center;">${n + 1}</td>
                    <td><g:link name="${data.title}"
                                title="${data.title}">${data.title.length() > 20 ? data.title.substring(0, 20) + "..." : data.title}</g:link></td>
                    <td><g:formatDate format="yyyy-MM-dd" date="${data.date}"/></td>
                    <td style="width: 90px;">
                        <div class="row" style="width: 90px;">
                            <div class="col-md-4">
                                <img src="${resource(dir: "images", file: "yulan.png")}"
                                     height="18"
                                     width="18" title="预览" style="cursor: pointer;">
                            </div>

                            <div class="col-md-4">
                                <img
                                        src="${resource(dir: "images", file: "xiazai.png")}"
                                        height="18"
                                        width="18" title="下载" style="cursor: pointer;">
                            </div>

                            <div class="col-md-4">
                                <div class="dropdown">
                                    <img
                                            src="${resource(dir: "images", file: "gengduo.png")}"
                                            height="18" width="18" title="更多"
                                            data-toggle="dropdown" style="cursor: pointer;">
                                    <ul class="dropdown-menu" role="menu"
                                        aria-labelledby="dropdownMenu1">
                                        <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                   href="#">删除</a></li>
                                        <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                   href="#">修改</a>
                                        </li>
                                        <li role="presentation" class="divider"></li>
                                        <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                   href="#">查看详细</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="panel-footer text-right" style="color: #1316e3"><g:link controller="index" action="more"
                                                                            params="${[theType: 1]}"><span
                    class="glyphicon glyphicon-th-large"></span>&nbsp;更多</g:link></div>
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

        <table class="table table-striped table-condensed table-hover">
            <thead>
            <tr>
                <th style="text-align: center;">#</th>
                <th>主题</th>
                <th>发布时间</th>
                <th>快速访问</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${recveList}" var="data" status="n">
                <tr>
                    <td style="width: 30px;text-align: center;">${n + 1}</td>
                    <td><g:link name="${data.title}"
                                title="${data.title}">${data.title.length() > 20 ? data.title.substring(0, 20) + "..." : data.title}</g:link></td>
                    <td><g:formatDate format="yyyy-MM-dd" date="${data.date}"/></td>
                    <td style="width: 90px;">
                        <div class="row" style="width: 90px;">
                            <div class="col-md-4">
                                <img src="${resource(dir: "images", file: "yulan.png")}"
                                     height="18"
                                     width="18" title="预览" style="cursor: pointer;">
                            </div>

                            <div class="col-md-4">
                                <img
                                        src="${resource(dir: "images", file: "xiazai.png")}"
                                        height="18"
                                        width="18" title="下载" style="cursor: pointer;">
                            </div>

                            <div class="col-md-4">
                                <div class="dropdown">
                                    <img
                                            src="${resource(dir: "images", file: "gengduo.png")}"
                                            height="18" width="18" title="更多"
                                            data-toggle="dropdown" style="cursor: pointer;">
                                    <ul class="dropdown-menu" role="menu"
                                        aria-labelledby="dropdownMenu1">
                                        <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                   href="#">删除</a></li>
                                        <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                   href="#">修改</a>
                                        </li>
                                        <li role="presentation" class="divider"></li>
                                        <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                   href="#">查看详细</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="panel-footer text-right" style="color: #1316e3"><g:link controller="index" action="more"
                                                                            params="${[theType: 2]}"><span
                    class="glyphicon glyphicon-th-large"></span>&nbsp;更多</g:link></div>
    </div>
</div>

<div class="col-md-12">
    <div class=" panel panel-default">
        <div class="panel-heading">
            <img style="margin-top: 0px;"
                 src="${resource(dir: "images", file: "quanjuxinxi.gif")}"/>
            <sapn style="padding-top: 10px;"><strong>最新共享信息</strong></sapn>
        </div>

        <table class="table table-striped table-condensed table-hover">
            <thead>
            <tr>
                <th style="text-align: center;">#</th>
                <th>主题</th>
                <th>发布时间</th>
                <th>信息类型</th>
                <th>发件人</th>
                <th>发布类型</th>
                <th>快速访问</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${allList}" var="data" status="n">
                <tr>
                    <td style="width: 40px;text-align: center;">${n + 1}</td>
                    <td><g:link name="${data.title}"
                                title="${data.title}">${data.title.length() > 30 ? data.title.substring(0, 30) + "..." : data.title}</g:link></td>
                    <td><g:formatDate format="yyyy-MM-dd" date="${data.date}"/></td>
                    <td>${data.type}</td>
                    <td>${data.user}</td>
                    <td>${data.shareScope}</td>
                    <td style="width: 90px;">
                        <div class="row" style="width: 90px;">
                            <div class="col-md-4">
                                <img src="${resource(dir: "images", file: "yulan.png")}"
                                     height="18"
                                     width="18" title="预览" style="cursor: pointer;">
                            </div>

                            <div class="col-md-4">
                                <img
                                        src="${resource(dir: "images", file: "xiazai.png")}"
                                        height="18"
                                        width="18" title="下载" style="cursor: pointer;">
                            </div>

                            <div class="col-md-4">
                                <div class="dropdown">
                                    <img
                                            src="${resource(dir: "images", file: "gengduo.png")}"
                                            height="18" width="18" title="更多"
                                            data-toggle="dropdown" style="cursor: pointer;">
                                    <ul class="dropdown-menu" role="menu"
                                        aria-labelledby="dropdownMenu1">
                                        <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                   href="#">删除</a></li>
                                        <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                   href="#">修改</a>
                                        </li>
                                        <li role="presentation" class="divider"></li>
                                        <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                   href="#">查看详细</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="panel-footer text-right" style="color: #1316e3"><g:link controller="index" action="more"
                                                                            params="${[theType: 3]}"><span
                    class="glyphicon glyphicon-th-large"></span>&nbsp;更多</g:link></div>
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
