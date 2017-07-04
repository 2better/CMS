<#include "staticPage/header.html">
<div class="g-bd f-cb">
    <div class="g-sd">
        <div class="g-sd-header">
            <span class="g-sd-header-title">学者风采</span>
            <span class="circle" style="display:none;"></span>
        </div>
        <ul class="g-sd-content">
            <div style="text-align:center;padding-bottom:14px;">
                <img style="max-width: 100%;height: auto;" src="/${scholar.picUrl}">
            </div>
        </ul>
    </div>
    <div class="g-mn">
        <div class="g-mn-header">
            <span class="g-sd-header-crumb">学者简介</span>
        </div>
        <div class="g-mn-content-out">
            <div class="g-mn-content2">
            <p style="font-size:14px;line-height:22px;margin:10px auto;">
                <#if scholar??>
                    <h1 style="margin-bottom: 20px;text-align: center;">${scholar.name}</h1>
                    ${scholar.content}
                <#else >
                    暂无内容
                </#if>
              </p>
            </div>
        </div>
    </div>
</div>
<#include "staticPage/footer.html">