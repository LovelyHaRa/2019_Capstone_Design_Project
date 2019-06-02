$(function () {
   $('#searchInput').keydown(function (key) {
       if(key.keyCode==13) {
           $("#searchBtn").trigger("click");
           $("#searchBtn1").trigger("click");
           $("#searchBtn2").trigger("click");
       }
   });
   $('#searchBtn').click(function () {
       var query=$('#searchInput').val();
       if(query !="")
           location.href="../search/?query="+query;
       return false;
   });

    $('#goBtn').click(function () {
        var query=$('#searchInput').val();
        if(query !="")
            location.href="../search/direct.jsp?query="+query;
        return false;
    });

    $('#searchBtn1').click(function () {
        var query=$('#searchInput').val();
        if(query !="")
            location.href="./?query="+query;
        return false;
    });

    $('#goBtn1').click(function () {
        var query=$('#searchInput').val();
        if(query !="")
            location.href="./direct.jsp?query="+query;
        return false;
    });

    $('#searchBtn2').click(function () {
        var query=$('#searchInput').val();
        if(query !="")
            location.href="../../search/?query="+query;
        return false;
    });

    $('#goBtn2').click(function () {
        var query=$('#searchInput').val();
        if(query !="")
            location.href="../../search/direct.jsp?query="+query;
        return false;
    });
});