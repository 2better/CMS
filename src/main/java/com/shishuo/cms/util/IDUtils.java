package com.shishuo.cms.util;

import java.util.Random;

/**
 * @author zyl
 * @create 2017/6/10
 */

public class IDUtils
{
    public static long getId() {
        //取当前时间的长整形值包含毫秒
        long millis = System.currentTimeMillis();
        //long millis = System.nanoTime();
        //加上两位随机数
        Random random = new Random();
        int end2 = random.nextInt(99);
        //如果不足两位前面补0
        String str = millis + String.format("%02d", end2);
        return new Long(str);
    }
}
