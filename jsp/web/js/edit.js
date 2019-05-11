$(function () {
   $('#btnSubmit').click(function () {
       event.preventDefault();
       CKEDITOR.instances.editor1.updateElement()
       var text=$('#editor1').val();
       var codeid=$('#codeID').val()
       alert(text);
       if(text=="") {
           alert("내용을 입력해 주십시오.");
           return false;
       }
       else if(codeid=="null") {
           alert("비정상적인 접근입니다.");
           return false;
       }
       else
           $('#formEdit').submit();
       //return false;
   });
    $('#btnEdit').click(function () {
        event.preventDefault();
        $('#contentForm').submit();
        //return false;
    });
});