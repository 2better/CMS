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
            <div class="g-mn-content2" id="content">
            <#--<ul>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">南方杂志：杨小帆：新点子走出新路子</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">广东卫视：陈新接受广东电视台采访 谈深化人才发展体制机制改革</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">人民政协报：顶天立地办大学——广东高校的产学研用之路</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">人民日报：广东高校科技成果转化中心助推产学研融合</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">中国网：广东省"双高"建设取得累累硕果</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">广东教育（综合） 广东工业大学：内培外引，加大青年教师培养力度</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">广东电视台：第五届“合泰杯”单片机应用大赛在我校举办</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">广东电视台：第五届“合泰杯”单片机应用大赛在我校举办</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">广东电视台：第五届“合泰杯”单片机应用大赛在我校举办</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">广东电视台：第五届“合泰杯”单片机应用大赛在我校举办</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">广东电视台：第五届“合泰杯”单片机应用大赛在我校举办</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">广东电视台：第五届“合泰杯”单片机应用大赛在我校举办</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--<li>-->
            <#--<span class="pic"></span>-->
            <#--<a href="#">广东电视台：第五届“合泰杯”单片机应用大赛在我校举办</a>-->
            <#--<span class="time">[2017-07-02]</span>-->
            <#--</li>-->
            <#--</ul>-->
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
    </div>
</div>
<script>
    var path = "${TEMPLATE_BASE_PATH}";
</script>
<script type="text/javascript" src="${TEMPLATE_BASE_PATH}/js/laypage.js"></script>
<script>
    $("key").val("${key}");
    pagination(1);

    function pagination(curr) {
        var index;
        $.ajax(
                {
                    url: "${BASE_PATH}/article/search.json",
                    type: "GET",
                    data: "p=" + curr + "&key=${key}",

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
                            trs += "<tr class=\"gradeA odd\"><td><a href=\"${BASE_PATH}/article/" + n.articleId + ".htm\">" + n.title + "</a></td>";
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