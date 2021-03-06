<g:if test="${org != null}">
    <div class="alert alert-info">当前信息所属单位：${org.name}</div>
</g:if>
<nav class="navbar navbar-default" role="navigation" style="margin-bottom: 5px;">
    <g:form controller="index" action="search" name="search" class="navbar-form navbar-left" role="search" method="get">
        <div class="form-group">
            <input type="hidden" name="typeKey" id="typeKey" value="${typeKey}">
            <input type="hidden" name="typeKeyName" id="typeKeyName" value="${typeKeyName}">
            <input id="keyValue" name="keyValue" type="text" class="form-control" value="${keyValue}"
                   placeholder="搜索全部文件">
        </div>
        <button type="submit" class="btn btn-default">
            <span class="glyphicon glyphicon-search"></span> 搜索</button>
    </g:form>
    <button type="button" class="btn btn-default navbar-btn" id="typeKeyBut" data-toggle="modal"
            data-target="#infoTypeModalSearch">
        <span class="glyphicon glyphicon-globe"></span> ${typeKey ? typeKeyName : "关键字检索"}</button>
    <button type="button" class="btn btn-primary navbar-btn" data-toggle="modal"
            data-target="#infoNewModal">
        <span class="glyphicon glyphicon-random"></span> 信息发布</button>
    <button type="button" class="btn btn-default navbar-btn" onclick="javascript:history.go(-1);">
        <span class="glyphicon glyphicon-arrow-left"></span> 返回</button>
    <g:if test="${(controllerName == "index" && actionName == "search") || org != null}">
        <button type="button" class="btn btn-default navbar-btn" onclick="exitKey();">
            <span class="glyphicon glyphicon-repeat"></span> 退出关键字</button>
    </g:if>
    <button type="button" class="btn btn-default navbar-btn" data-toggle="modal"
            data-target="#userWorkLogModal">
        <span class="glyphicon glyphicon-calendar"></span> 工作日志</button>

    <div class="btn-group navbar-btn">
        <button type="button" class="btn btn-default">信息共享目录</button>
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
            <span class="caret"></span>
            <span class="sr-only">Toggle Dropdown</span>
        </button>
        <ul class="dropdown-menu" role="menu">
            <g:each in="${sharefile}" var="fileData">
                <li><g:link target="_blank" controller="shareFile" action="download" params="[id:fileData.id]">${fileData.title}</g:link></li>
            </g:each>
        </ul>
    </div>
    <button type="button" class="btn btn-default navbar-btn" data-toggle="modal"
            data-target="#userCommitModal">
        <span class="glyphicon glyphicon-comment"></span> 建议反馈</button>
</nav>