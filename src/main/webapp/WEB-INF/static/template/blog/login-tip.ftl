<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>未登录</title>
</head>
<body>

    <h3>不好意思，请先登录，<span class="timeInterval">5</span>秒后返回<a href="/index.html">首页</a></h3>


    <script>
      var timeInterval = document.querySelector(".timeInterval");

      function timeOut(ele,start,speed){
        var n = parseInt(start);
        var speed = speed || 1;
        setTimeout(()=>{
          n--;
          if(n==0){
            window.location.href = "index.html";
            return ;
          }
          ele.textContent = n;
          timeOut(ele,n,1);
        },speed*1000)
      }

      timeOut(timeInterval,timeInterval.textContent,1);
    </script>
</body>
</html>