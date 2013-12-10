if (typeof jQuery !== 'undefined') {
    (function ($) {
        $('#spinner').ajaxStart(function () {
            $(this).fadeIn();
        }).ajaxStop(function () {
                $(this).fadeOut();
            });
        initPassWord()
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
