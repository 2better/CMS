<#include "staticPage/header.html">
<div class="g-bd f-cb">
    <div class="g-mn">
        <div class="g-mn-header">
            <span class="g-sd-header-crumb">著作列表</span>
        </div>
        <div class="g-mn-content-out">
            <div class="g-mn-content">
                <section id="main-content">
                    <section class="wrapper">
                        <!-- page start-->
                    <section class="panel">
                        <div class="panel-body">
                            <div class="adv-table">
                                <div role="grid" class="dataTables_wrapper" id="hidden-table-info_wrapper">
                                    <table class="table table-striped table-advance table-hover" id="con">
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
<script>
    pagination(1);

    function pagination(curr) {
        var index;
        $.ajax(
                {
                    url: "${BASE_PATH}/composition/list.json",
                    type: "GET",
                    data: "p="+curr,

                    success: function (data) {
                        console.log(data);
                        $("#con tbody").remove();
                        if (jQuery.isEmptyObject(data.list)) {
                            $("#page").hide();

                            return false;
                        }

                        $("#page").show();
                        var trs = "<tbody  role=\"alert\" aria-live=\"polite\" aria-relevant=\"all\">";
                        $.each(data.list, function (i, n) {
                            trs += "<tr class=\"gradeA odd\"><td><a href=\"${BASE_PATH}/composition/"+ n.id +".htm\">" + n.title + "</a></td>";
                        });
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
</script>
<#include "staticPage/footer.html">