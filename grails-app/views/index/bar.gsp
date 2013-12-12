<nav class="navbar navbar-default" role="navigation" style="margin-bottom: 5px;">
    <g:form controller="index" action="search" name="search" class="navbar-form navbar-left" role="search">
        <div class="form-group">
            <input type="hidden" name="typeKey" id="typeKey" value="${typeKey}">
            <input type="hidden" name="typeKeyName" id="typeKeyName" value="${typeKeyName}">
            <input id="keyValue" name="keyValue" type="text" class="form-control" value="${keyValue}" placeholder="搜索全部文件">
        </div>
        <button type="submit" class="btn btn-default">
            <span class="glyphicon glyphicon-search"></span> 搜索</button>
    </g:form>
    <button type="button" class="btn btn-default navbar-btn" id="typeKeyBut" data-toggle="modal"
            data-target="#infoTypeModalSearch">
        <span class="glyphicon glyphicon-globe"></span> ${typeKey?typeKeyName:"关键字检索"}</button>
    <button type="button" class="btn btn-primary navbar-btn" data-toggle="modal"
            data-target="#infoNewModal">
        <span class="glyphicon glyphicon-random"></span> 信息发布</button>
</nav>