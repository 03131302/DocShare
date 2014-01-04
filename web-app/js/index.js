if (typeof jQuery !== 'undefined') {
    (function ($) {
        initIndexTree();
    })(jQuery);
}

function initIndexTree() {
    var setting = {
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                var pid = treeNode.id;
                var location = document.location.toString()
                if (location.indexOf("?") >= 0) {
                    if (hasParameter("orgID")) {
                        document.location = replaceParamVal(location, "orgID", pid);
                    } else {
                        document.location = location + "&orgID=" + pid;
                    }
                } else {
                    document.location = location + "?orgID=" + pid;
                }
            }
        }
    };
    $.ajax({
        type: "GET",
        url: getLocation() + "index/getOrgTreeData",
        cache: false,
        async: false,
        success: function (msg) {
            var zNodes = msg;
            $.fn.zTree.init($("#indexzTree"), setting, zNodes);
            var zTree = $.fn.zTree.getZTreeObj("indexzTree");
            zTree.expandAll(true);
        }
    });
}

function replaceParamVal(oldUrl, paramName, replaceWith) {
    var re = eval('/(' + paramName + '=)([^&]*)/gi');
    var nUrl = oldUrl.replace(re, paramName + '=' + replaceWith);
    return nUrl;
}
function hasParameter(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}

function submitFile(id) {
    $("#infoDataObject").val(id);
    $('#infoNewModal').modal('show');
}

function submitText(id) {
    $("#infoData").val(id);
    $('#infoNewreTypeModal').modal('show');
}

function showOnLine(id) {
    $.ajax({
        type: "GET",
        url: getLocation() + "infoData/downloadFile",
        cache: false,
        async: false,
        data: {id: id, date: new Date()},
        success: function (responseText) {
            if (responseText && responseText.length == 1) {
                $.each(responseText, function (i, n) {
                    window.open(getLocation() + "infoFile/showOnLine/" + n);
                });
            } else {
                document.location = getLocation() + "infoData/show/" + id;
            }
        }
    });
}

function downloadFile(id) {
    $.ajax({
        type: "GET",
        url: getLocation() + "infoData/downloadFile",
        cache: false,
        async: false,
        data: {id: id, date: new Date()},
        success: function (responseText) {
            if (responseText && responseText.length == 1) {
                $.each(responseText, function (i, n) {
                    $("#fileDown").attr("src", getLocation() + "infoFile/show/" + n);
                });
            } else {
                document.location = getLocation() + "infoData/show/" + id;
            }
        }
    });
}

function deleteInfoData(id) {
    if (confirm("确定删除该信息？")) {
        $.ajax({
            type: "GET",
            url: getLocation() + "infoData/delete",
            cache: false,
            async: false,
            data: {id: id, date: new Date()},
            success: function (responseText) {
                if (responseText == "true") {
                    document.location.reload();
                } else {
                    alert(responseText);
                }
            }
        });
    }
}

function deleteReType(id) {
    if (confirm("确定删除该信息？")) {
        $.ajax({
            type: "GET",
            url: getLocation() + "recipient/delete",
            cache: false,
            async: false,
            data: {id: id, date: new Date()},
            success: function (responseText) {
                if (responseText == "true") {
                    document.location.reload();
                } else {
                    alert(responseText);
                }
            }
        });
    }
}