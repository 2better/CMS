<#include "staticPage/header.html">
<div class="g-bd f-cb">
<#--<div class="g-sd">-->
<#--<div class="g-sd-header">-->
<#--<span class="g-sd-header-name">${menus.name}</span>-->
<#--<span class="circle"></span>-->
<#--</div>-->
<#--<ul class="g-sd-content">-->
<#--<#list menus.children?sort_by("sort") as p>-->
<#--<a href="${p.url}">-->
<#--<li>-->
<#--<span>${p.name}</span>-->
<#--<div class="triangle_border_right">-->
<#--<span></span>-->
<#--</div>-->
<#--</li>-->
<#--</a>-->
<#--</#list>-->
<#--</ul>-->
<#--</div>-->
    <div class="g-mn">
        <div class="g-mn-header">
            <span class="g-sd-header-crumb">活动通知</span>
        </div>
        <div class="g-mn-content-out">
            <div class="g-mn-content">
                <#if event??>
                    <h2>${event.name}</h2>
                    <div>
                        ${event.content}
                    </div>
                <#else >
                    暂无内容

                </#if>

            </div>
        </div>
    </div>
</div>
<#include "staticPage/footer.html">