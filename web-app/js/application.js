if (typeof jQuery !== 'undefined') {
    (function ($) {
        $('#spinner').ajaxStart(function () {
            $(this).fadeIn();
        }).ajaxStop(function () {
                $(this).fadeOut();
            });
        initPassWord();
        initEdit();
        initTree();
    })(jQuery);
}

function initPassWord() {
    var options = {
        beforeSubmit: function showRequest() {
            return true;
        },
        success: function showResponse(responseText) {
            if (responseText == "true") {
                alert("密码修改成功，请退出并重新登陆。");
                document.location.reload();
            } else {
                alert(responseText);
            }
        }
    };
    $('#updatePassWord').ajaxForm(options);
}

function initEdit() {
    var options = {
        beforeSerialize: function () {
            for (instance in CKEDITOR.instances) {
                CKEDITOR.instances[instance].updateElement();
            }
            return true;
        },
        beforeSubmit: function showRequest() {
            return true;
        },
        success: function showResponse(responseText) {
            if (responseText == "true") {
                alert("信息发布成功！");
                document.location.reload();
            } else {
                alert(responseText);
            }
        }
    };
    $('#infoDataForm').ajaxForm(options);

    if ($("#textData").length) {
        CKEDITOR.replace('textData', {
            toolbar: 'Basic',
            width: 873
        });
    }
    $('#filePath').uploadify({
        'swf': getLocation() + 'static/js/uploadify/uploadify.swf',
        'uploader': getLocation() + 'infoFile/upload',
        height: 35,
        removeCompleted: false,
        buttonText: "选择文件",
        'onUploadSuccess': function (file, data, response) {
            var temp = $("#filePathValue").val();
            if (!temp) {
                temp = "";
            }
            $("#filePathValue").val(temp + data + ";");
            var temp2 = $("#title").val();
            if (!temp2) {
                temp2 = "";
            }
            $("#title").val(temp2 + file.name + ";")
        }
    });
}

function initTree() {
    var setting = {
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onDblClick: function (event, treeId, treeNode) {
                var pid = treeNode.id;
                $("#type").val(pid);
                $("#shareTypeName").val(treeNode.name);
                $('#infoTypeModal').modal('hide');
            }
        }
    };
    $.ajax({
        type: "GET",
        url: getLocation() + "infoType/getOrgTreeData",
        cache: false,
        async: false,
        success: function (msg) {
            var zNodes = msg;
            $.fn.zTree.init($("#infoTypezTree"), setting, zNodes);
            var zTree = $.fn.zTree.getZTreeObj("infoTypezTree");
            zTree.expandAll(true);
        }
    });

    var setting2 = {
        check: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true
            }
        }
    };
    $.ajax({
        type: "GET",
        url: getLocation() + "infoData/getUserTree",
        cache: false,
        async: false,
        success: function (msg) {
            var zNodes = msg;
            $.fn.zTree.init($("#infoOrgzTree"), setting2, zNodes);
        }
    });

    var setting3 = {
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onDblClick: function (event, treeId, treeNode) {
                var pid = treeNode.id;
                $("#typeKey").val(pid);
                $("#typeKeyBut").text(treeNode.name);
                $("#typeKeyName").val(treeNode.name);
                $('#infoTypeModalSearch').modal('hide');
                $("#search")[0].submit();
            }
        }
    };
    $.ajax({
        type: "GET",
        url: getLocation() + "infoType/getOrgTreeData",
        cache: false,
        async: false,
        success: function (msg) {
            var zNodes = msg;
            $.fn.zTree.init($("#infoTypeSearchzTree"), setting3, zNodes);
            var zTree = $.fn.zTree.getZTreeObj("infoTypeSearchzTree");
            zTree.expandAll(true);
        }
    });
}

function selectInfoTypeSearch() {
    var zTree = $.fn.zTree.getZTreeObj("infoTypeSearchzTree");
    var nodes = zTree.getSelectedNodes();
    if (nodes && nodes[0]) {
        var treeNode = nodes[0];
        $("#typeKey").val(treeNode.id);
        $("#typeKeyName").val(treeNode.name);
        $("#typeKeyBut").text(treeNode.name);
        $('#infoTypeModalSearch').modal('hide');
        $("#search")[0].submit();
    }
}

function selectInfoType() {
    var zTree = $.fn.zTree.getZTreeObj("infoTypezTree");
    var nodes = zTree.getSelectedNodes();
    if (nodes && nodes[0]) {
        var treeNode = nodes[0];
        $("#type").val(treeNode.id);
        $("#shareTypeName").val(treeNode.name);
        $('#infoTypeModal').modal('hide');
    }
}

function selectUser() {
    $('#infoOrgModal').modal('show');
}

function selectUserData() {
    var zTree = $.fn.zTree.getZTreeObj("infoOrgzTree");
    var data = zTree.getCheckedNodes(true);
    var temp = "";
    var tempName = "";
    for (i = 0; i < data.length; i++) {
        if (!data[i].isParent) {
            temp += data[i].id + ";";
            tempName += data[i].name + ";";
        }
    }
    $("#shareType").val("局部");
    $("#userScope").val(tempName);
    $("#userScopeData").val(temp);
    $('#infoOrgModal').modal('hide');
}
