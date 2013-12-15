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

                        <div class="col-md-12">
                            <div class=" panel panel-default">
                                <div class="panel-heading">
                                    <img style="margin-top: 0px;"
                                         src="${resource(dir: "images", file: "quanjuxinxi.gif")}"/>
                                    <sapn style="padding-top: 10px;"><strong>包含"${keyValue}"的${typeKeyName ? "\"" + typeKeyName + "\"类" : ""}共享信息</strong>
                                    </sapn>
                                </div>

                                <table class="table table-striped table-condensed table-hover">
                                    <thead>
                                    <tr>
                                        <th>主题</th>
                                        <th>发布时间</th>
                                        <th>信息类型</th>
                                        <th>发件人</th>
                                        <th>发布类型</th>
                                        <th>快速访问</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${searchList}" var="data" status="n">
                                        <tr>
                                            <td><g:link name="${data.title}"
                                                        title="${data.title}" controller="infoData"
                                                        action="show" params="${[id: data.id]}">${data.title.length() > 30 ? data.title.substring(0, 30) + "..." : data.title}</g:link></td>
                                            <td><g:formatDate format="yyyy-MM-dd" date="${data.date}"/></td>
                                            <td>${data.type}</td>
                                            <td>${data.user}</td>
                                            <td>${data.shareScope}</td>
                                            <td style="width: 90px;">
                                                <div class="row" style="width: 90px;">
                                                    <div class="col-md-4">
                                                        <img src="${resource(dir: "images", file: "yulan.png")}"
                                                             height="18"
                                                             width="18" title="预览"
                                                             onclick="showOnLine('${data.id}')"
                                                             style="cursor: pointer;">
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
                                                                <li role="presentation" ${session["adminUser"]?.userName?.equals(data.user) ? "" : raw("class=\"disabled\"")}>
                                                                    <a role="menuitem" tabindex="-1"
                                                                       onclick="deleteInfoData('${data.id}')"
                                                                       href="javascript:void(0);">删除</a>
                                                                </li>
                                                                <li role="presentation" ${session["adminUser"]?.userName?.equals(data.user) ? "" : raw("class=\"disabled\"")}>
                                                                    <a role="menuitem" tabindex="-1"
                                                                       href="javascript:void(0);"
                                                                       onclick="updateInfoNew('${data.id}')">修改</a>
                                                                </li>
                                                                <li role="presentation" class="divider"></li>
                                                                <g:set var="theType" value="-1"></g:set>
                                                                <g:if test="${data?.re_type != null}">
                                                                    <g:if test="${"文件提交反馈".equals(data?.re_type)}">
                                                                        <g:set var="theType" value="0"></g:set>
                                                                    </g:if>
                                                                    <g:if test="${"查收回执".equals(data?.re_type)}">
                                                                        <g:set var="theType" value="1"></g:set>
                                                                    </g:if>
                                                                </g:if>
                                                                <li role="presentation" ${theType.equals("0") ? "" : raw("class=\"disabled\"")}>
                                                                    <a role="menuitem" tabindex="-1"
                                                                       href="javascript:void(0);"
                                                                       onclick="submitFile('${data.id}')"
                                                                       data-toggle="modal"
                                                                       data-target="#infoNewModal">提交文件</a>
                                                                </li>
                                                                <li role="presentation" ${theType.equals("1") ? "" : raw("class=\"disabled\"")}>
                                                                    <a role="menuitem" tabindex="-1"
                                                                       href="javascript:void(0);"
                                                                       onclick="submitText('${data.id}')"
                                                                       data-toggle="modal"
                                                                       data-target="#infoNewreTypeModal">提交回执
                                                                    </a>
                                                                </li>
                                                                <li role="presentation" class="divider"></li>
                                                                <li role="presentation">
                                                                    <g:link name="${data.title}"
                                                                            title="${data.title}" controller="infoData"
                                                                            action="show"
                                                                            params="${[id: data.id]}" role="menuitem"
                                                                            tabindex="-1">查看详细
                                                                    </g:link>
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<iframe id="fileDown" src="" width="0" hidden="hidden" height="0"></iframe>
<r:require module="index"></r:require>
</body>
</html>
