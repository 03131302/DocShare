if (typeof jQuery !== 'undefined') {
    (function ($) {
        initShareFileEdit();
        $('#shareFileModal').on('hidden.bs.modal', function (e) {
            document.location.reload();
        });
    })(jQuery);
}

function initShareFileEdit() {
    var options2 = {
        beforeSubmit: function showRequest() {
            return true;
        },
        success: function showResponse(responseText) {
            if (responseText == "true") {
                alert("操作成功！");
                document.location.reload();
            } else {
                alert(responseText);
            }
        }
    };
    $('#shareFileForm').ajaxForm(options2);
    $('#sharefilePath').uploadify({
        'swf': getLocation() + 'static/js/uploadify/uploadify.swf',
        'uploader': getLocation() + "shareFile/upload" + getSession(),
        'height': 35,
        'multi': false,
        'fileSizeLimit': '50MB',
        'removeCompleted': false,
        'buttonText': "选择文件",
        'onUploadSuccess': function (file, dataTemp, response) {
            var data = jQuery.parseJSON(dataTemp);
            var temp = $("#sharefilePathValue").val();
            if (!temp) {
                temp = "";
            }
            $("#sharefilePathValue").val(temp + data.path);
            var temp2 = $("#shareFileForm").find("#title").val();
            if (!temp2) {
                var t = file.name.toString();
                $("#shareFileForm").find("#title").val(t.substring(0, t.lastIndexOf(".")));
            }
        }
    });
}

function updateShareFile() {
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
            url: "../shareFile/show/" + ids,
            cache: false,
            async: false,
            success: function (responseText) {
                $("#shareFileForm").append("<input type=\"hidden\" class=\"form-control\" id=\"id\" name=\"id\" value=\"\">");
                $.each(responseText, function (i, n) {
                    $("#shareFileForm").find("#" + i).val(n);
                });
                $("#shareFileForm").attr("action", "../shareFile/update");
                $('#shareFileModal').modal('show');
            }
        });
    } else {
        alert("请选择需要修改的日志！并且只能同时修改一个日志！")
    }
}

function deleteShareFile() {
    var n = 0;
    var ids = "";
    $(".dataOracle").each(function () {
        if ($(this)[0].checked) {
            n += 1;
            ids += $(this).val() + ",";
        }
    });
    if (n <= 0) {
        alert("请选择需要删除的目录！");
        return false;
    } else {
        if (confirm("确定删除选择的目录？")) {
            $.ajax({
                type: "POST",
                url: "../shareFile/delete",
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