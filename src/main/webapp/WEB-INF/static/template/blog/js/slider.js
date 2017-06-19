/**
 * Warning : Baseed off jquery
 * @param {NodeElement} $container 轮播的容器
 * @param {Array[srcString]} imgaes 轮播的图片
 * @param {jsonObject[NodeElement]} $ctrl 轮播切换的按钮
 * @param {boolean} auto 是否自动轮播
 */
function slider($container, auto, images) {
	// //图片路径/链接(数组形式)
    var images_url = images,
    	images_count = images.length;

    // 轮播起始值
    var num = 0;
    // 获取容器宽高度
    var window_width = $container.width();
    var window_height = $container.height();
    // 自动播放
    $container.timer = null;
    //创建节点
    //图片列表节点
    for(var i = 0; i < images_count+1; i++){
    	$container.find('ul').append('<li></li>');
      $container.find('ul > li').css('float','left');
      // $container.find('ul > li').css('height',window_height);
    }
    //轮播圆点按钮节点
    for(var j=0;j<images_count;j++){
        if(j==0){
            $container.find('ol').append('<li class="current"></li>');
        }else{
            $container.find('ol').append('<li></li>');
        }
    }
    // 设置小圆点的位置
    $container.find('ol').css('width',images_count*20+'px');
    $container.find('ol').css('margin-left',-images_count*20*0.5-10+'px');

    //轮播圆点
    $container.find('ol > li').mouseover(function(){//用hover的话会有两个事件(鼠标进入和离开)
        $(this).addClass('current').siblings().removeClass('current');
        //第一张图： 0 * window_width
        //第二张图： 1 * window_width
        //第三张图： 2 * window_width
        //获取当前编号
        var i = $(this).index();
        //console.log(i);
        $container.find('ul').stop().animate({left:-i*window_width},500);
        num = i;
    });

    //载入图片
    $container.find('ul > li').css('background-image','url('+images_url[0]+')');
    $.each(images_url,function(key,value){
        $container.find('ul > li').eq(key).css('background-image','url('+value+')');
    });

    // 设置图片宽度
    $container.find('ul').css('width',(images_count+1)*100+'%');

    // 设置轮播图片每一项宽度
    $container.find('ul > li').width(window_width);


    function prevPlay(){
    	num--;
        if(num<0){
            //悄悄把图片跳到最后一张图(复制页,与第一张图相同),然后做出图片播放动画，left参数是定位而不是移动的长度
            $container.find('ul').css({left:-window_width*images_count}).stop().animate({left:-window_width*(images_count-1)},500);
            num=images_count-1;
        }else{
            //console.log(num);
            $container.find('ul').stop().animate({left:-num*window_width},500);
        }
        if(num==images_count-1){
            $container.find('ol > li').eq(images_count-1).addClass('current').siblings().removeClass('current');
        }else{
            $container.find('ol > li').eq(num).addClass('current').siblings().removeClass('current');
        }
    }

    function nextPlay(){
        num++;
        if(num>images_count){
            //播放到最后一张(复制页)后,悄悄地把图片跳到第一张,因为和第一张相同,所以难以发觉,
            $container.find('ul').css({left:0}).stop().animate({left:-window_width},500);
            //css({left:0})是直接悄悄改变位置，animate({left:-window_width},500)是做出移动动画
            //随后要把指针指向第二张图片,表示已经播放至第二张了。
            num=1;
        }else{
            //在最后面加入一张和第一张相同的图片，如果播放到最后一张，继续往下播，悄悄回到第一张(肉眼看不见)，从第一张播放到第二张
            //console.log(num);
            $container.find('ul').stop().animate({left:-num*window_width},500);
        }
        if(num==images_count){
            $container.find('ol > li').eq(0).addClass('current').siblings().removeClass('current');
        }else{
            $container.find('ol > li').eq(num).addClass('current').siblings().removeClass('current');
        }
    }

    $container.timer = auto ? setInterval(nextPlay,2000) : null;

    //鼠标经过banner，停止定时器,离开则继续播放
    $container.mouseenter(function(){
        if(auto) clearInterval($container.timer);
        //左右箭头显示(淡入)
        $container.find('i').fadeIn();
    }).mouseleave(function(){
        if(auto) $container.timer = setInterval(nextPlay,2000);
        //左右箭头隐藏(淡出)
        $container.find('i').fadeOut();
    });

    //播放下一张
    $container.find('.right').click(function(){
        nextPlay();
    });
    //返回上一张
    $container.find('.left').click(function(){
        prevPlay();
    });
}


$(function (){
  slider($('.banner'), true,big);
  slider($('.area2-top'), false,small);
})