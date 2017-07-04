<#include "staticPage/header.html">
<div class="g-bd f-cb">
    <div class="g-sd">
        <div class="g-sd-header">
            <span class="g-sd-header-title">著作</span>
            <span class="circle" style="display:none;"></span>
        </div>
        <ul class="g-sd-content">
            <div style="text-align:center;padding-bottom:14px;">
                <img style="max-width: 100%;height: auto;" src="/${composition.picUrl}">
            </div>
        </ul>
    </div>
    <div class="g-mn">
        <div class="g-mn-header">
            <span class="g-sd-header-crumb">著作简介</span>
        </div>
        <div class="g-mn-content-out2">
            <div class="g-mn-content2">
            <p style="font-size:14px;line-height:22px;margin:10px auto;">
                <#if composition??>
                    <h1 style="margin-bottom: 20px;text-align: center;">${composition.title}</h1>
                    <hr style="margin-bottom: 20px;">
                    ${composition.content}
                <#else >
                    暂无内容
                </#if>
            </p>
            </div>
        </div>
    </div>
</div>
<#include "staticPage/footer.html">