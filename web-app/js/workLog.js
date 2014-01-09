function updateWork() {
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
            url: "../userWorkLog/show/" + ids,
            cache: false,
            async: false,
            success: function (responseText) {
                $("#userWorkLogForm").append("<input type=\"hidden\" class=\"form-control\" id=\"id\" name=\"id\" value=\"\">");
                $.each(responseText, function (i, n) {
                    $("#userWorkLogForm").find("#" + i).val(n);
                });
                $("#userWorkLogForm").attr("action", "../userWorkLog/update");
                $('#userWorkLogModal').modal('show');
            }
        });
    } else {
        alert("请选择需要修改的日志！并且只能同时修改一个日志！")
    }
}

function cleanAll() {
    if (confirm("确定删除所有的日志？")) {
        $.ajax({
            type: "POST",
            url: "../userWorkLog/deleteAll",
            cache: false,
            data: {date: new Date()},
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


function exportExcel() {
    $("#logFile").attr("src", getLocation() + "userWorkLog/exportToExcel");
}

function deleteLog() {
    var n = 0;
    var ids = "";
    $(".dataOracle").each(function () {
        if ($(this)[0].checked) {
            n += 1;
            ids += $(this).val() + ",";
        }
    });
    if (n <= 0) {
        alert("请选择需要删除的日志！");
        return false;
    } else {
        if (confirm("确定删除选择的日志？")) {
            $.ajax({
                type: "POST",
                url: "../userWorkLog/delete",
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