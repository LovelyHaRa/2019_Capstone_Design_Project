$(function () {
    $('#formEdit').validate({
        rules : {
            codeName : {
                required : true
            }
        },
        messages : {
            codeName : {
                required : "필수 입력 사항입니다.",
            }
        }
    });
});