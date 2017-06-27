<!--底部-->
<!--底部-->
<div id="foot">
    <div class="foot">
        <div class="copy">
                <span>
                    Copyright <font class="foot-info">${copyright}</font><br/>
                    电话：${phonenum}
                </span>
        </div>
        <div class="link2 right">
            <!--<select name="select" onchange="if(this.options[this.selectedIndex].value!=''){window.open(this.options[this.selectedIndex].value,'_blank');}">
            <option>--------友情链接--------</option>
            <option value="#">快速链接1-1</option><option value="#t">东莞市力拓网络科技有限公司</option><option value="#">快速链接1-2</option><option value="#">快速链接1-3</option><option value="#">快速链接1-4</option><option value="#m">xx大学</option><option value="#">艾慕</option><option value="#/">北京大学</option>
            </select>-->
            <span>友情连接:</span>
            <span style="display:inline-block;vertical-align:top">
            <#list linkList as link>
                <#if (link_index+1)%4 = 0>
                    <a href="${link.url}" target="_blank">${link.name}</a>
                    <br>
                <#else>
                    <a href="${link.url}" target="_blank">${link.name}</a>
                </#if>
            </#list>
                </span>
        </div>
    </div>
</div>
<!--<script language="javascript">
    window.onload = menuFix;
</script>-->
<!--底部-->
<!--底部-->
<script>
    // 设置时间
    var $timeEle = $(".search > .widget > i").eq(0);
    $timeEle.html( setDateStr() );

    function setDateStr() {
        var date = new Date(),
                year = date.getFullYear(),
                month = date.getMonth() + 1,
                day = date.getDate();
        return year + "年" + month + "月" + day + "日";
    }

    $("i.close").on('click',function (){
        $(".login-layer").css('display', 'none');
    });

    function trimStr(str){
        if(!str){
            return false;
        }
        var reg = /\s/g;
        return str.replace(reg,"");
    }

    // 空值判断
    $('.login-layer').submit(function (){
        $.each($('input'),function (index,value){
            if(!trimStr(value)){
                $(".error").text("输入不能为空！");
                return ;
            }
        })
    });
</script>
<!--底部-->
<!--底部-->

</body>

</html>