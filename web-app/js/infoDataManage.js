function updateInfoDataManage() {
    var n = 0;
    var ids = "";
    $(".dataOracle").each(function () {
        if ($(this)[0].checked) {
            n += 1;
            ids = $(this).val();
        }
    });
    if (n == 1) {
        updateInfoNew(ids);
    } else {
        alert("请选择需要修改的信息！并且只能同时修改一个信息！")
    }
}

function cleanAll() {
    if (confirm("确定清空回收站的信息？")) {
        $.ajax({
            type: "POST",
            url: "../infoData/cleanAll",
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
}

function recover() {
    var n = 0;
    var ids = "";
    $(".dataOracle").each(function () {
        if ($(this)[0].checked) {
            n += 1;
            ids += $(this).val() + ",";
        }
    });
    if (n <= 0) {
        alert("请选择需要恢复的信息！");
        return false;
    } else {
        $.ajax({
            type: "POST",
            url: "../infoData/recover",
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

function deleteInfoDataManage(theType) {
    var n = 0;
    var ids = "";
    $(".dataOracle").each(function () {
        if ($(this)[0].checked) {
            n += 1;
            ids += $(this).val() + ",";
        }
    });
    if (n <= 0) {
        alert("请选择需要删除的信息！");
        return false;
    } else {
        if (confirm("确定删除选择的信息？")) {
            var url = "../infoData/deleteAll";
            if (theType) {
                url = "../infoData/deleteInfo";
            }
            $.ajax({
                type: "POST",
                url: url,
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