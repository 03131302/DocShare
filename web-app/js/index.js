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
        url: "index/getOrgTreeData",
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