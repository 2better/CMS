<#include "staticPage/header.html">
<!--头部-->
<!--头部-->
<!--主体-->
<div class="g-bd f-cb">
    <div class="g-mn" style="width:1200px">
        <div class="g-mn-header">
            <span class="g-sd-header-crumb">搜索结果</span>
        </div>

        <div class="g-mn-content-out2">
            <div class="g-mn-content2">
                <div class="g-sd-content" id="nolist">
                    没有相关记录
                </div>
                <ul id="content">

                </ul>
                <div class="page">
                    <span id="totalRecords">共<span id="count">1</span>条</span>
                    <!--1为当前页，33为总页数-->
                    <span id="page"><span id="pageNum">1</span>/<span id="totalPage">1</span></span>
                    <span class="box" id="first">首页</span>
                    <span class="box" id="prev">上页</span>
                    <span class="box" id="next">下页</span>
                    <span class="box" id="end">尾页</span>
                    <span class="box" id="to">转到</span>
                    <input class="box2" type="number">页
                </div>
            </div>
        </div>

    </div>
</div>

<script>

    var currentPage = 1;//当前页
    var totalPage = 10;//总页数
    var newPage = 0;//新的一页
    var btnId = null;//按钮的id
    var toPage = 0;//跳转到哪一页
    var url = "${BASE_PATH}/article/search.json";

    $(function() {

        $("#key").val("${key}");
        ajaxFun(1);

        $(document).on('click', '.box', function () {

            btnId = $(this).attr('id');

            toPage = parseInt($('.box2').val());
            switch (btnId) {
                case "first":
                    newPage = 1;
                    break;
                case "prev":
                    newPage = currentPage - 1;
                    break;
                case "next":
                    newPage = currentPage + 1;
                    break;
                case "end":
                    newPage = totalPage;
                    break;
                case "to":
                    if (toPage > totalPage) {
                        newPage = totalPage
                    } else if (toPage < 1) {
                        newPage = 1
                    } else {
                        newPage = toPage
                    }
                    break;
                default:
                    newPage = 1
            }
            ajaxFun(newPage);
        });

    });

    function ajaxFun(curr)
    {
        $.ajax({
            type: "get",
            url: url,
            data: "p=" + curr + "&key=${key}",
            cache: false,
            async: false,
            success: function (data) {
                totalPage = data.pageCount;
                currentPage = data.pageNum;
                $("#content li").remove();
                if (jQuery.isEmptyObject(data))
                    return false;
                var con = "";
                $.each(data.list, function (i, n) {
                    con+="<li>";
                    con+="<a href=\"${BASE_PATH}/article/"+n.articleId+".htm\">"+n.title+"</a>";
                    con+="</li>";

                });
                $("#content").append(con);

                if(totalPage>0) {

                    $("#nolist").hide();

                    $("#pageNum").html(currentPage);
                    $("#totalPage").html(totalPage);
                    $("#count").html(data.count);

                    if(currentPage===1)
                    {
                        $("#first").css("display","none");
                        $("#prev").css("display","none");
                        $("#next").css("display","inline");
                        $("#end").css("display","inline");
                    }
                    else if(currentPage===totalPage)
                    {
                        $("#first").css("display","inline");
                        $("#prev").css("display","inline");
                        $("#next").css("display","none");
                        $("#end").css("display","none");
                    }

                    if (totalPage === 1) {
                        $("#first").css("display", "none");
                        $("#prev").css("display", "none");
                        $("#next").css("display", "none");
                        $("#end").css("display", "none");
                        $("#to").css("display", "none");
                        $(".box2").css("display", "none");
                    }
                    /*else if (currentPage === 1) {
                        $("#first").css("display", "none");
                        $("#prev").css("display", "none");
                    }
                    else if (currentPage === totalPage) {
                        $("#next").css("display", "none");
                        $("#end").css("display", "none");
                    }*/
                }else {
                    $("#content").hide();
                    $(".page").hide();
                }

            },
            error: function () {
                alert("系统繁忙，请稍后再试！");
            }
        });
    }
</script>

<#--<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/laypage.js"></script>
<script>
    $(function () {
        $("#key").val("${key}");
        pagination(1);
    });

    function pagination(curr) {
        var index;
        $.ajax(
                {
                    url: "${BASE_PATH}/article/search.json",
                    type: "GET",
                    data: "p=" + curr + "&key=${key}",

                    success: function (data) {
                        console.log(data);
                        //$("#con tbody").remove();
                        $("#con").append("<tbody ></tbody>");
                        if (jQuery.isEmptyObject(data.list)) {
                            $("#page").hide();

                            return false;
                        }

                        $("#page").show();
                        var trs = "<tbody  role=\"alert\" aria-live=\"polite\" aria-relevant=\"all\">";
                        $.each(data.list, function (i, n) {
                            trs += "<tr class='gradeA odd'><td><a href='${BASE_PATH}/article/" + n.articleId + ".htm'>" + n.title + "</a></td></tr>";
                        });
                        console.log(trs + "</tbody>");
                        $("#con").append(trs + "</tbody>");

                        laypage({
                            cont: 'page', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
                            pages: data.pageCount, //通过后台拿到的总页数
                            curr: curr || 1, //当前页
                            skip: true, //是否开启跳页
                            groups: 3,//连续显示分页数
                            skin: '#5a98de',
                            first: 1,
                            last: data.pageCount,
                            jump: function (obj, first) { //触发分页后的回调
                                if (!first) { //点击跳页触发函数自身，并传递当前页：obj.curr
                                    pagination(obj.curr);
                                }
                            }
                        });
                    }
                }
        );
    }
</script>-->
<#include "staticPage/footer.html">