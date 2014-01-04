if (typeof jQuery !== 'undefined') {
    (function ($) {
        initTreeUserManage();
    })(jQuery);
}

function initTreeUserManage() {
    $('#userModal').on('hidden.bs.modal', function (e) {
        document.location.reload();
    })
    $("#userCode").blur(function () {
        if (!$("#id").val()) {
            if ($("#userCode").val()) {
                $("#passWord").val($("#userCode").val().toString() + "@123");
            }
        }
    })
    $("#passWord").focus(function () {
        if (!$("#id").val()) {
            if (!$("#passWord").val()) {
                if ($("#userCode").val()) {
                    $("#passWord").val($("#userCode").val().toString() + "@123");
                }
            }
        }
    });
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
    $('#userForm').ajaxForm(options);

    var setting = {
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onDblClick: function (event, treeId, treeNode) {
                var pid = treeNode.id;
                $("#org").val(pid);
                $("#orgName").val(treeNode.name);
                $('#orgModal').modal('hide');
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
        }
    });
}

function selectOrg() {
    var zTree = $.fn.zTree.getZTreeObj("zTree");
    var nodes = zTree.getSelectedNodes();
    if (nodes && nodes[0]) {
        var treeNode = nodes[0];
        $("#org").val(treeNode.id);
        $("#orgName").val(treeNode.name);
        $('#orgModal').modal('hide');
    }
}

function updateUser() {
    var n = 0;
    var ids = "";
    $(".dataOracle").each(function () {
        if ($(this)[0].checked) {
            n += 1;
            ids = $(this).val();
        }
    });
    if (n == 1) {
        $.ajax({
            type: "GET",
            url: "../adminUser/show/" + ids,
            cache: false,
            async: false,
            success: function (responseText) {
                $("#userForm").append("<input type=\"hidden\" class=\"form-control\" id=\"id\" name=\"id\" value=\"\">");
                $.each(responseText, function (i, n) {
                    if (i == "isStop") {
                        if (n) {
                            $("#" + i).val(1);
                        } else {
                            $("#" + i).val(0);
                        }
                    } else {
                        $("#" + i).val(n);
                    }
                });
                $("#userForm").attr("action", "../adminUser/update");
                $('#userModal').modal('show');
            }
        });
    } else {
        alert("请选择需要修改的用户！并且只能同时修改一个用户！")
    }
}

function deleteUser() {
    var n = 0;
    var ids = "";
    $(".dataOracle").each(function () {
        if ($(this)[0].checked) {
            n += 1;
            ids += $(this).val() + ",";
        }
    });
    if (n <= 0) {
        alert("请选择需要删除的用户！");
        return false;
    } else {
        if (confirm("确定删除选择的用户？")) {
            $.ajax({
                type: "POST",
                url: "../adminUser/delete",
                cache: false,
                data: {id: ids, date: new Date()},
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
    }
}