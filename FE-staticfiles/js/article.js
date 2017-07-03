/**
 * Created by labber on 2017/6/12.
 */
function ajax(url, type, data, dataType, successDo, errorDo) {
    $.ajax({
        url: url,
        type: type,
        data: data,
        dataType: dataType,
        success: successDo,
        error: errorDo
    });
}

function getArticles(url,data,jqObj) {
    ajax(url, "GET", data, "JSON",function (data) {
        var list = data;
        var uLhtml = "";

        if(list.length > 0) {
            $.each(list, function (index, item) {
                console.log(index + ":-->" + item.title);
                uLhtml += "<li><a href='/article/" + item.articleId + ".htm'>" + item.title + "</a></li>"
            });
        }else {
            uLhtml = "暂无消息哦亲";
        }
        jqObj.html(uLhtml);
    }, function() {
        jqObj.html("服务器出错啦");
    });
}

//获取新闻动态
getArticles("/article/listNews", null, $("#newsUl"));
//获取合作交流动态
getArticles("/article/listCooperation",null,$("#cooperationUl"));
//获取学术论文
function getPaper() {
    ajax("/paper/list","GET",null,"JSON",function (data) {
        var list = data;
        var uLhtml = "";

        if(list.length > 0) {
            $.each(list, function (index, item) {
                uLhtml += "<li><a href='/paper/download/" + item.id + "'>" + item.name + "</a></li>"
            });
        }else {
            uLhtml = "暂无消息哦亲";
        }
        $("#paperUl").html(uLhtml);
    },function () {
        $("#paperUl").html("服务器出错啦");
    })
}
getPaper();

//加载活动公告
function loadEvent(jqObj,important,p,success) {
    ajax("/event/load.json","GET",{important:important,p:p},"JSON",success,function() {
        jqObj.html("服务器出错!");
    });
}
//重要活动
loadEvent($("#importantEvent"),1,0,function(data) {
    $("#importantEvent").html(data[0].content);
});
//公告
loadEvent($("#eventUl"),0,1,function (data) {
    console.log(data);
    var list = data;
    var uLhtml = "";

    if(list.length > 0) {
        $.each(list, function (index, item) {
            uLhtml += "<li><a href='/event/" + item.id + ".htm'>" + item.name + "</a></li>"
        });
    }else {
        uLhtml = "暂无消息哦亲";
    }
    $("#eventUl").html(uLhtml);
});

//获取著作
function getComposition() {
    ajax("/composition/list.json","GET",null,"JSON",function (data) {
        var list = data.list;
        var uLhtml = "";

        if(list.length > 0) {
            $.each(list, function (index, item) {
                uLhtml += "<li><a href='/composition/"+ item.id +".htm/'>" + item.title + "</a></li>"
            });
        }else {
            uLhtml = "暂无消息哦亲";
        }
        $("#compositionUl").html(uLhtml);
    },function () {
        $("#compositionUl").html("服务器出错啦");
    })
}

//学者简介
function getScholar() {
    ajax("/scholar/list.json","GET",null,"JSON",function (data) {
        var list = data.list;
        var uLhtml = "";

        if(list.length > 0) {
            $.each(list, function (index, item) {
                uLhtml += "<li><a href='/scholar/"+ item.id +".htm/'>" + item.name + "</a></li>"
            });
        }else {
            uLhtml = "暂无消息哦亲";
        }
        $("#scholarUl").html(uLhtml);
    },function () {
        $("#scholarUl").html("服务器出错啦");
    })
}

getComposition();
getScholar();