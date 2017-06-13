<#include "header.ftl">
<div class="g-bd f-cb">
    <div class="g-sd">
        <div class="g-sd-header">
            <span class="g-sd-header-title">${menus.name}</span>
            <span class="circle"></span>
        </div>
        <ul class="g-sd-content">
        <#list menus.children?sort_by("sort") as p>
            <a href="${p.url}">
                <li>
                    <span>${p.name}</span>
                    <div class="triangle_border_right">
                        <span></span>
                    </div>
                </li>
            </a>
        </#list>
        </ul>
    </div>

    <div class="g-mn">
        <div class="g-mn-header">
            <span class="g-sd-header-crumb">${menus.name} > ${Menu.name}</span>
        </div>
        <div class="g-mn-content-out2">
            <div class="g-mn-content2">
                <ul id="content">



                </ul>
                <div class="page">
                    <span id="totalRecords">共${count}条</span>
                    <!--1为当前页，33为总页数-->
                    <span id="page"><span id="pageNum">1</span>/${pageCount}</span>
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
        var totalPage = "${pageCount}"*1;//总页数
        var newPage = 0;//新的一页
        var btnId = null;//按钮的id
        var toPage = 0;//跳转到哪一页
        var url = "${BASE_PATH}/article/listJson.json"//url
        var menuid = "${Menu.id}";

        $(function() {

            ajaxFun(1);

        if(totalPage==1)
        {
            $("#first").css("display","none");
            $("#prev").css("display","none");
            $("#next").css("display","none");
            $("#end").css("display","none");
            $("#to").css("display","none");
            $(".box2").css("display","none");
        }
        else if(currentPage==1)
        {
            $("#first").css("display","none");
            $("#prev").css("display","none");
        }
        else if(currentPage==totalPage)
        {
            $("#next").css("display","none");
            $("#end").css("display","none");
        }

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

    function ajaxFun(num)
    {
        $.ajax({
            type: "post",
            url: url,
            data: "pageNum="+num+"&menuId="+menuid,
            cache: false,
            async: false,
            success: function (data) {
                currentPage = data.pageNum;
                $("#content li").remove();
                if (jQuery.isEmptyObject(data))
                    return false;
                var con = "";
                $.each(data.list, function (i, n) {
                    con+="<li><span class=\"pic\"></span>";
                    con+="<a href=\"${BASE_PATH}/article/"+n.articleId+".htm\" target=\"_blank\">"+n.name+"</a>";
                    con+="<span class=\"time\">["+n.createTimeView+"]</span></li>";
                });
                $("#content").append(con);

                $("#pageNum").html(currentPage);

                if(currentPage==1)
                {
                    $("#first").css("display","none");
                    $("#prev").css("display","none");
                    $("#next").css("display","inline");
                    $("#end").css("display","inline");
                }
                else if(currentPage==totalPage)
                {
                    $("#first").css("display","inline");
                    $("#prev").css("display","inline");
                    $("#next").css("display","none");
                    $("#end").css("display","none");
                }
            },
            error: function () {
                alert("系统繁忙，请稍后再试！");
            }
        });
    }
</script>
<#include "footer.ftl">