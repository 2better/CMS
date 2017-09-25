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
                <div class="g-mn-content-out">
                    <div class="g-mn-content">
                        <section id="main-content">
                            <section class="wrapper">
                                <!-- page start-->
                                <section class="panel">
                                    <div class="panel-body">
                                                <ul id="conUl">
                                                </ul>
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
    $("key").val("${key}");
    pagination(1);
    console.log(encodeURI("${BASE_PATH}/article/search.json"));
    function pagination(curr) {
        var index;
        $.ajax(
                {
                    url: encodeURI("${BASE_PATH}/article/search.json"),
                    type: "GET",
                    data: "p=" + curr + "&key=${key}",

                    success: function (data) {
                        console.log(data);
                        if (jQuery.isEmptyObject(data.list)) {
                            $("#page").hide();

                            return false;
                        }

                        $("#page").show();
                        var trs = "";
                        $.each(data.list, function (i, n) {
                            trs += "<li><a href=\"${BASE_PATH}/article/" + n.articleId + ".htm\">" + n.title + "</a></li>";
                        });
                        $("#conUl").html(trs);
                        console.log(trs);

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