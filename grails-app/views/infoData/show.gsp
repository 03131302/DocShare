<%@ page import="com.ocse.doc.domain.InfoData" %>
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
                <div class="panel-heading">
                    <img style="margin-top: 0px;"
                         src="${resource(dir: "images", file: "quanjuxinxi.gif")}"/>
                    <sapn style="padding-top: 10px;"><strong>${infoDataInstance.title}</strong></sapn>
                </div>

                <div class="panel-body">
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <td><strong>发布类型：</strong></td>
                            <td>${infoDataInstance?.shareType}</td>
                            <td><strong>信息类型：</strong></h4></td>
                            <td>${infoDataInstance?.type?.name}</td>
                            <td><strong>反馈类型：</strong></h4></td>
                            <td>${infoDataInstance?.reType}</td>
                        </tr>
                        <tr>
                            <td><strong>收件人：</strong></td>
                            <td colspan="3">${(infoDataInstance?.shareType.equals("全部") ? "全部" : users)}</td>
                            <td><strong>日期：</strong></h4></td>
                            <td><g:formatDate format="yyyy-MM-dd" date="${infoDataInstance?.saveDate}"/></td>
                        </tr>
                        <tr>
                            <td colspan="6"><strong>文件列表</strong></td>
                        </tr>
                        <g:each in="${fileList}" status="n" var="file">
                            <tr>
                                <td colspan="6"><g:link controller="infoFile" action="show"
                                                        params="${[id: file.id]}"><strong>${file.name}</strong></g:link>
                                </td>
                            </tr>
                        </g:each>
                        <tr>
                            <td><strong>主题：</strong></td>
                            <td colspan="5">${infoDataInstance?.title}</td>
                        </tr>
                        <tr>
                            <td colspan="6"><strong>简介</strong></td>
                        </tr>
                        <tr>
                            <td colspan="6">${raw(infoDataInstance?.textData)}</td>
                        </tr>
                        <tr>
                            <td colspan="6"><strong>反馈信息</strong></td>
                        </tr>
                        <g:each in="${reTypeList}" var="typeData" status="n">
                            <tr>
                                <td style="text-align: center;"><strong>${n + 1}</strong></td>
                                <td><strong>反馈人：</strong></td>
                                <td>${typeData.user.userName}</td>
                                <td><strong>反馈人内容：</strong></td>
                                <g:if test="${typeData.text.isInteger() && InfoData.get(typeData.text) != null}">
                                    <td colspan="1"><g:link controller="infoData" action="show"
                                                            params="${[id: InfoData.get(typeData.text).id]}">${InfoData.get(typeData.text).title}</g:link></td>
                                </g:if>
                                <g:else>
                                    <td colspan="1">${typeData.text}</td>
                                </g:else>
                                <td>
                                    <button ${(typeData.user.id == session["adminUser"].id || "管理员".equals(session["adminUser"].jb)) ? "" : "disabled"}
                                            type="button" class="btn btn-primary"
                                            onclick="deleteReType('${typeData.id}')"><span
                                            class="glyphicon glyphicon-trash"></span> 删除
                                    </button>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>

                <div class="panel-footer">
                    <g:if test="${infoDataInstance?.reType != null}">
                        <g:if test="${"文件提交反馈".equals(infoDataInstance?.reType)}">
                            <button type="button"
                                    class="btn btn-primary navbar-btn"
                                    data-toggle="modal"
                                    data-target="#infoNewModal">
                                <span class="glyphicon glyphicon-calendar"></span> 提交反馈</button>
                        </g:if>
                        <g:if test="${"查收回执".equals(infoDataInstance?.reType)}">
                            <button type="button"
                                    class="btn btn-primary navbar-btn"
                                    data-toggle="modal"
                                    data-target="#infoNewreTypeModal">
                                <span class="glyphicon glyphicon-calendar"></span> 提交回执</button>
                        </g:if>
                    </g:if>
                </div>
            </div>
        </div>
    </div>
</div>
<r:require module="index"></r:require>
</body>
</html>