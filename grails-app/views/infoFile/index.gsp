<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="${resource(dir: 'js/flexPaper/css', file: 'flexpaper.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <title>东营市环保局工作信息共享平台</title>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="597"><img src="${resource(dir: "images", file: "head01.jpg")}" width="597"
                             height="92"/></td>
        <td width="99%" id="herd00" align="right"></td>
        <td width="1%" id="herd00" align="right">
            <table width="111" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="33%" align="center"><g:link controller="index" action="index"><img
                            src="${resource(dir: "images", file: "shuaxin.gif")}" width="37" title="首页"
                            height="34"/></g:link></td>
                    <td width="33%" align="center"><g:link controller="manage" action="index"><img
                            src="${resource(dir: "images", file: "shezhi.gif")}" width="37" title="系统管理"
                            height="34"/></g:link></td>
                    <td width="33%" align="center"><g:link controller="login" action="logout"><img
                            src="${resource(dir: "images", file: "tuichu.gif")}" width="37" title="退出系统"
                            height="34"/></g:link></td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<div class="container" style="width: 100%;margin: 15px 0px 0px 0px;">
    <div class="row col-md-12" style="width: 100%;margin: 0px 0px 0px 0px;">
        <div class="col-md-12" style="padding-right: 0px;margin-right: 0px;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <img style="margin-top: 0px;"
                         src="${resource(dir: "images", file: "quanjuxinxi.gif")}"/>
                    <sapn style="padding-top: 10px;"><strong>${infoFileInstance?.name}</strong></sapn>
                </div>

                <div class="panel-body">
                    <div class="row">
                        <div id="documentViewer" class="col-md-12 flexpaper_viewer" style="height: 600px;z-index: 0;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="footer">
    <div class="panel panel-default">
        <div class="panel-body">
            <p class="text-muted text-center">
                版权所有：东营市环境保护局 Copyright 2013-2020 dyepb.gov.cn 鲁ICP备10003379号<br/>
                联系电话：（0546）8331789 12369 通讯地址：东营市东营区府前街100号 邮政编码：257091
            </p>
        </div>
    </div>
</div>

<script type="text/javascript" src="${resource(dir: 'js/flexPaper/js', file: 'jquery.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: "js", file: "jquery.ztree.all-3.5.min.js")}"></script>
<script type="text/javascript" src="${resource(dir: "js/uploadify", file: "jquery.uploadify.min.js")}"></script>
<script type="text/javascript" src="${resource(dir: "js/ckeditor", file: "ckeditor.js")}"></script>
<script type="text/javascript" src="${resource(dir: "js", file: "bootstrap.min.js")}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.form.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/flexPaper/js', file: 'flexpaper.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/flexPaper/js', file: 'flexpaper_handlers.js')}"></script>
<script type="text/javascript">
    if (typeof jQuery !== 'undefined') {
        (function ($) {
            $('#spinner').ajaxStart(function () {
                $(this).fadeIn();
            }).ajaxStop(function () {
                        $(this).fadeOut();
                    });
            initPage();
        })(jQuery);
    }
    function getLocation() {
        return "${request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"}";
    }
    function initPage() {
        $('#documentViewer').FlexPaperViewer(
                {config: {
                    SWFFile: getLocation() + "infoFile/line/${infoFileInstance?.id}",
                    Scale: 1.0,
                    ZoomTransition: 'easeOut',
                    ZoomTime: 0.5,
                    ZoomInterval: 0.2,
                    FitPageOnLoad: true,
                    FitWidthOnLoad: true,
                    FullScreenAsMaxWindow: false,
                    ProgressiveLoading: false,
                    MinZoomSize: 0.2,
                    MaxZoomSize: 5,
                    SearchMatchAll: false,
                    InitViewMode: 'Portrait',
                    RenderingOrder: 'flash',
                    StartAtPage: '',
                    ViewModeToolsVisible: true,
                    ZoomToolsVisible: true,
                    NavToolsVisible: true,
                    CursorToolsVisible: true,
                    SearchToolsVisible: true,
                    WMode: 'window',
                    localeChain: 'zh_CN'
                }}
        );
    }
</script>
</body>
</html>
