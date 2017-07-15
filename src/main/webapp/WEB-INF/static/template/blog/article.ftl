<#include "staticPage/header.html">
<div class="g-bd f-cb">
    <div class="g-sd">
        <div class="g-sd-header">
            <span class="g-sd-header-title"><#if menus??>${menus.name}</#if></span>
            <span class="circle"></span>
        </div>
        <ul class="g-sd-content">
<#if menus??>
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
</#if>
        </ul>
    </div>
    <div class="g-mn">
        <div class="g-mn-header">
            <span class="g-sd-header-crumb"><a href="${article.menu.url!}" style="color:#fff;">${article.menuName}</a> > ${article.title}</span>
        </div>
        <div class="g-mn-content-out">
        <div class="g-mn-content">
            ${article.content}
        </div>
		</div>
    </div>
</div>
<#include "staticPage/footer.html">