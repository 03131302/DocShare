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
                                    <sapn style="padding-top: 10px;"><strong>${title}</strong></sapn>
                                </div>

                                <table class="table table-striped table-condensed table-hover">
                                    <thead>
                                    <tr>
                                        <th style="text-align: center;">#</th>
                                        <th>科室单位</th>
                                        <th>本周发布</th>
                                        <th>本月发布</th>
                                        <th>本年发布</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${infoData}" var="data" status="n">
                                        <tr>
                                            <td style="width: 30px;text-align: center;">${n + 1}</td>
                                            <td>
                                                ${data.name.length() > 20 ? data.name.substring(0, 20) + "..." : data.name}
                                            </td>
                                            <td>${data.wid}</td>
                                            <td>${data.mid}</td>
                                            <td>${data.yid}</td>
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
