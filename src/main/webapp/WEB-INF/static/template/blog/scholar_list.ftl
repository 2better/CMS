<#include "staticPage/header.html">
<div class="g-bd f-cb">
    <div class="g-sd">
        <div class="g-sd-header">
            <span class="g-sd-header-title">研究人员</span>
            <span class="circle"></span>
        </div>
        <ul class="g-sd-content">
            <a href="/article/list.htm?menuId=149715143466311">
                <li>
                    <span>研究顾问</span>
                    <div class="triangle_border_right">
                        <span></span>
                    </div>
                </li>
            </a>
            <a href="/article/list.htm?menuId=149715145693790">
                <li>
                    <span>专职研究员</span>
                    <div class="triangle_border_right">
                        <span></span>
                    </div>
                </li>
            </a>
            <a href="/article/list.htm?menuId=149715147705703">
                <li>
                    <span>兼职研究院</span>
                    <div class="triangle_border_right">
                        <span></span>
                    </div>
                </li>
            </a>
            <a href="/article/list.htm?menuId=149715148797574">
                <li>
                    <span>其它人员</span>
                    <div class="triangle_border_right">
                        <span></span>
                    </div>
                </li>
            </a>
        </ul>
    </div>

    <div class="g-mn">
        <div class="g-mn-header">
            <span class="g-sd-header-crumb">学者列表</span>
        </div>
        <div class="g-mn-content-out">
            <div class="g-mn-content2">
                <section id="main-content">
                    <section class="wrapper">
                        <!-- page start-->
                        <section class="panel">
                            <div class="panel-body">
                                <div class="adv-table">
                                    <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                                        <table class="table table-striped table-advance table-hover" id="tableCon">
                                        </table>
                                        <div style="height: 30px;">
                                            <div id="page" style="float:right"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- page end-->
                    </section>
                </section>
            </div>
        </div>
    </div>
</div>
<script>
    var path = "${TEMPLATE_BASE_PATH}";
</script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/laypage.js"></script>
<style>
    #tableCon{
        margin:0px;
    }
    .forTable .pic{
        display: inline-block;
        width:100px;
        height: 125px;
        background-color: rebeccapurple;
        margin: 17px;
    }
    .forTable .pic img{
        max-width: 100%;
    }
    .forTable .name{
        text-align: center;
        font-size: 14px;
    }
    #tableCon .forTable{
        float: left;
    }
    #tableCon tbody::after{
        content: '';
        display: block;
        clear: both;
        height: 0;
        zoom: 1;
    }
</style>
<script>
    pagination(1);

    function pagination(curr) {
        var index;
        $.ajax(
                {
                    url: "${BASE_PATH}/scholar/list.json",
                    type: "GET",
                    data: "p="+curr,

                    success: function (data) {
                        console.log(data);
                        $("#tableCon tbody").remove();
                        if (jQuery.isEmptyObject(data.list)) {
                            $("#page").hide();

                            return false;
                        }

                        $("#page").show();
                        var trs = "<tbody  role=\"alert\" aria-live=\"polite\" aria-relevant=\"all\">";
                        $.each(data.list, function (i, n) {
                            trs += "<tr class=\"gradeA odd forTable\">" +
                                    "<td>"+
                                    "<div class=\"pic\"><a href=\"${BASE_PATH}/scholar/"+ n.id +".htm\"><img src='/" + n.picUrl +"'></a></div>"+
                                    "<div class=\"name\"><a href=\"${BASE_PATH}/scholar/"+ n.id +".htm\">" + n.name + "</a></div>" +
                                    "</td></tr>";
                        });
                        $("#tableCon").append(trs + "</tbody>");

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
</script>
<#include "staticPage/footer.html">