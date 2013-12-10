if (typeof jQuery !== 'undefined') {
    (function ($) {
        initTree();
    })(jQuery);
}

function initTree() {
    var options = {
        beforeSubmit: function showRequest() {
            return true;
        },
        success: function showResponse(responseText) {
            if (responseText == "true") {
                document.location.reload();
            } else {
                alert(responseText);
            }
        }
    };
    $('#infoTypeModal').ajaxForm(options);

    var setting = {
        edit: {
            enable: true,
            showRemoveBtn: false,
            showRenameBtn: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                var pid = treeNode.id;
                $("#parentInfoType").val(pid);
            },
            beforeDrag: function (treeId, treeNodes) {
                for (var i = 0, l = treeNodes.length; i < l; i++) {
                    if (treeNodes[i].drag === false) {
                        return false;
                    }
                }
                return true;
            },
            onDrop: function (event, treeId, treeNodes, targetNode) {
                if (confirm("确认移动关键字？")) {
                    $.ajax({
                        type: "GET",
                        url: "../infoType/move",
                        data: {id: treeNodes[0].id, tid: targetNode.id},
                        cache: false,
                        async: false,
                        success: function (responseText) {
                            if (responseText == "true") {
                                document.location.reload();
                            } else {
                                alert(responseText);
                            }
                        }
                    });
                } else {
                    document.location.reload();
                }
            }
        }
    };
    $.ajax({
        type: "GET",
        url: "../infoType/getOrgTreeData",
        cache: false,
        async: false,
        success: function (msg) {
            var zNodes = msg;
            $.fn.zTree.init($("#infoTypezTree"), setting, zNodes);
            var zTree = $.fn.zTree.getZTreeObj("infoTypezTree");
            zTree.expandAll(true);
        }
    });
}

function updateOrg() {
    var zTree = $.fn.zTree.getZTreeObj("infoTypezTree");
    var nodes = zTree.getSelectedNodes();
    if (nodes && nodes[0]) {
        var treeNode = nodes[0];
        $.ajax({
            type: "GET",
            url: "../infoType/show/" + treeNode.id,
            cache: false,
            async: false,
            success: function (responseText) {
                $.each(responseText, function (i, n) {
                    if (i == "parentInfoType") {
                        i = "parentInfoType";
                    }
                    $("#" + i).val(n);
                });
                $("#infoForm").attr("action", "../infoType/update");
                $('#infoTypeModal').modal('show');
            }
        });
    } else {
        alert("请选择需要修改的关键字！")
    }
}

function deleteOrg() {
    var zTree = $.fn.zTree.getZTreeObj("infoTypezTree");
    var nodes = zTree.getSelectedNodes();
    if (nodes && nodes[0]) {
        var treeNode = nodes[0];
        if (confirm("确认删除该关键字以及下面的所有关键字？")) {
            $.ajax({
                type: "GET",
                url: "../infoType/delete/" + treeNode.id,
                cache: false,
                async: false,
                success: function (responseText) {
                    if (responseText == "true") {
                        document.location.reload();
                    } else {
                        alert(responseText);
                    }
                }
            });
        }
    } else {
        alert("请选择需要删除的关键字！");
    }
}