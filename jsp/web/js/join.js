$(function () {
    $(".form-signin").validate({
        rules : {
            ID : {
                required : true,
                minlength : 4
            },
            pw : {
                required : true,
                minlength : 3
            },
            confpw : {
                required : true,
                minlength : 3,
                equalTo : pw
            },
            name : {
                required : true,
                minlength : 4
            }
        },
        messages : {
            ID : {
                required : "필수 입력 사항입니다.",
                minlength : "최소 {0}자 이상이어야 합니다."
            },
            pw : {
                required : "필수 입력 사항입니다.",
                minlength : "최소 {0}자 이상이어야 합니다."
            },
            confpw : {
                required : "필수 입력 사항입니다.",
                minlength : "최소 {0}자 이상이어야 합니다.",
                equalTo : "비밀번호가 일치하지 않습니다."
            },
            name : {
                required : "필수 입력 사항입니다.",
                minlength : "최소 {0}자 이상이어야 합니다."
            }
        }
    });
});