if (typeof jQuery !== 'undefined') {
    (function ($) {
        $('#spinner').ajaxStart(function () {
            $(this).fadeIn();
        }).ajaxStop(function () {
                $(this).fadeOut();
            });
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
    $('#orgForm').ajaxForm(options);

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
                $("#parent\\.id").val(pid);
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
                if (confirm("确认移动机构？")) {
                    $.ajax({
                        type: "GET",
                        url: "../organization/move",
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
        url: "getOrgTreeData",
        cache: false,
        async: false,
        success: function (msg) {
            var zNodes = msg;
            $.fn.zTree.init($("#zTree"), setting, zNodes);
            var zTree = $.fn.zTree.getZTreeObj("zTree");
            zTree.expandAll(true);
        }
    });
}

function updateOrg() {
    var zTree = $.fn.zTree.getZTreeObj("zTree");
    var nodes = zTree.getSelectedNodes();
    if (nodes && nodes[0]) {
        var treeNode = nodes[0];
        $.ajax({
            type: "GET",
            url: "../organization/show/" + treeNode.id,
            cache: false,
            async: false,
            success: function (responseText) {
                $.each(responseText, function (i, n) {
                    if (i == "parent") {
                        i = "parent\\.id";
                    }
                    $("#" + i).val(n);
                });
                $("#orgForm").attr("action", "../organization/update");
                $('#orgModal').modal('show');
            }
        });
    } else {
        alert("请选择需要修改的机构！")
    }
}

function deleteOrg() {
    var zTree = $.fn.zTree.getZTreeObj("zTree");
    var nodes = zTree.getSelectedNodes();
    if (nodes && nodes[0]) {
        var treeNode = nodes[0];
        if (confirm("确认删除该机构以及下面的所有机构？")) {
            $.ajax({
                type: "GET",
                url: "../organization/delete/" + treeNode.id,
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
        alert("请选择需要删除的机构！");
    }
}
