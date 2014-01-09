function cleanAll() {
    if (confirm("确定删除所有的建议？")) {
        $.ajax({
            type: "POST",
            url: "../userCommit/deleteAll",
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
    $("#logFile").attr("src", getLocation() + "userCommit/exportToExcel");
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
        alert("请选择需要删除的建议！");
        return false;
    } else {
        if (confirm("确定删除选择的建议？")) {
            $.ajax({
                type: "POST",
                url: "../userCommit/delete",
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