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
        $('#infoNewModal').on('hidden.bs.modal', function (e) {
            document.location.reload();
        });
        $('#userCommitModal').on('hidden.bs.modal', function (e) {
            document.location.reload();
        });
        $('#userWorkLogModal').on('hidden.bs.modal', function (e) {
            document.location.reload();
        });
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
            if (!$("#shareTypeName").val()) {
                alert("请选择关键字！")
                $("#typeButton")[0].focus();
                return false;
            }
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


    var optionscommit = {
        success: function showResponse(responseText) {
            if (responseText == "true") {
                alert("感谢您的宝贵意见，管理员会查收您的建议！");
                document.location.reload();
            } else {
                alert(responseText);
            }
        }
    };
    $('#userCommitForm').ajaxForm(optionscommit);

    var optionsWorkLog = {
        success: function showResponse(responseText) {
            if (responseText == "true") {
                alert("日志填写完成，您可以到后台查看并编辑！");
                document.location.reload();
            } else {
                alert(responseText);
            }
        }
    };
    $('#userWorkLogForm').ajaxForm(optionsWorkLog);


    var options2 = {
        beforeSubmit: function showRequest() {
            return true;
        },
        success: function showResponse(responseText) {
            if (responseText == "true") {
                alert("提交回执成功！");
                document.location.reload();
            } else {
                alert(responseText);
            }
        }
    };
    $('#infoDatareTypeForm').ajaxForm(options2);

    if ($("#textData").length) {
        CKEDITOR.replace('textData', {
            toolbar: 'Basic',
            width: 873
        });
    }
    $('#filePath').uploadify({
        'swf': getLocation() + 'static/js/uploadify/uploadify.swf',
        'uploader': getLocation() + "infoFile/upload" + getSession(),
        'height': 35,
        'fileSizeLimit': '50MB',
        'removeCompleted': false,
        'buttonText': "选择文件",
        'onUploadSuccess': function (file, dataTemp, response) {
            var data = jQuery.parseJSON(dataTemp);
            var temp = $("#filePathValue").val();
            if (!temp) {
                temp = "";
            }
            $("#filePathValue").val(temp + data.path + ";");

            temp = $("#fileNameValue").val();
            if (!temp) {
                temp = "";
            }
            $("#fileNameValue").val(temp + data.name + ";");

            var temp2 = $("#title").val();
            if (!temp2) {
                var t = file.name.toString();
                $("#title").val(t.substring(0, t.lastIndexOf(".")));
            }
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
                if (!treeNode.children) {
                    var pid = treeNode.id;
                    $("#type").val(pid);
                    $("#shareTypeName").val(treeNode.name);
                    $('#infoTypeModal').modal('hide');
                } else {
                    alert("请选择二级目录！");
                    return false;
                }
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
    var data = $("#userScopeData").val();
    if (data) {
        var zTree = $.fn.zTree.getZTreeObj("infoOrgzTree");
        $.each(data.split(";"), function (i, n) {
            if (n) {
                var nodes = zTree.getNodesByParam("id", n + "#", null);
                $.each(nodes, function (i, node) {
                    zTree.checkNode(node, true);
                });
            }
        });
    }
    $('#infoOrgModal').modal('show');
}

function selectUserData(type) {
    if (type) {
        $("#shareType").val("全部");
        $("#userScope").val("全部");
        $("#userScopeData").val("");
        $('#infoOrgModal').modal('hide');
    } else {
        var zTree = $.fn.zTree.getZTreeObj("infoOrgzTree");
        var data = zTree.getCheckedNodes(true);
        var temp = "";
        var tempName = "";
        for (i = 0; i < data.length; i++) {
            if (!data[i].isParent) {
                temp += data[i].id.replace("#", "") + ";";
                tempName += data[i].name + ";";
            }
        }
        $("#shareType").val("局部");
        $("#userScope").val(tempName);
        $("#userScopeData").val(temp);
        $('#infoOrgModal').modal('hide');
    }
}

function updateInfoNew(id) {
    $("#infoDataObject").val("");
    $.ajax({
        type: "GET",
        url: getLocation() + "infoData/edit",
        cache: false,
        async: false,
        data: {id: id, date: new Date()},
        success: function (msg) {
            if (msg) {
                $("#infoDataForm").append("<input type=\"hidden\" class=\"form-control\" id=\"id\" name=\"id\" value=\"\">");
                $("#infoDataForm").attr("action", getLocation() + "infoData/update")
                var infoData = msg.infoData;
                if (infoData) {
                    $.each(infoData, function (i, n) {
                        $("#" + i).val(n);
                        if (i == "type") {
                            if (n) {
                                $("#type").val(n.id);
                            }
                        }
                        if (i == "textData") {
                            for (instance in CKEDITOR.instances) {
                                CKEDITOR.instances[instance].setData(n);
                            }
                        }
                    });
                }
                var type = msg.type
                if (type) {
                    $("#shareTypeName").val(type.name);
                }
                var files = msg.files;
                if (files) {
                    $.each(files, function (i, n) {
                        if (i == 0) {
                            $("#fileList").html("");
                            $("#fileList").append("<ul id=\"list\" class=\"list-group\"></ul>");
                        }
                        $("#filePathValue").val(n.path + ";" + $("#filePathValue").val());
                        $("#fileNameValue").val(n.name + ";" + $("#fileNameValue").val());
                        $("#list").append("<li class=\"list-group-item\">" + n.name + " <button onclick=\"deleteFile('" + n.path + "',this,'" + n.name + "')\" type=\"button\" class=\"btn btn-link\">删除</button></li>");
                    });
                }
                var users = msg.users;
                if (users) {
                    $.each(users, function (i, n) {
                        if (i == 0) {
                            $("#userScope").val("");
                        }
                        $("#userScope").val(n.name + ";" + $("#userScope").val());
                        $("#userScopeData").val(n.id + ";" + $("#userScopeData").val());
                        $("#shareType").val("局部");
                    });
                }
            }
            $('#infoNewModal').modal('show');
        }
    });
}

function deleteFile(path, obj, name) {
    if (confirm("确定删除该文件？")) {
        var pathAll = $("#filePathValue").val().toString();
        pathAll = pathAll.replace(path, "");
        $("#filePathValue").val(pathAll);

        pathAll = $("#fileNameValue").val().toString();
        pathAll = pathAll.replace(name, "");
        $("#fileNameValue").val(pathAll);

        $(obj).parent().remove();
    }
}

function exitKey() {
    document.location = getLocation();
}