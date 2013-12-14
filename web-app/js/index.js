if (typeof jQuery !== 'undefined') {
    (function ($) {
        initTree();
    })(jQuery);
}
function initTree() {
    var setting = {
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                var pid = treeNode.id;
                alert(pid);
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

function submitFile(id) {
    $("#infoDataObject").val(id);
    $('#infoNewModal').modal('show');
}

function submitText(id) {
    $("#infoData").val(id);
    $('#infoNewreTypeModal').modal('show');
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