package com.shishuo.cms.action.manage;

import com.shishuo.cms.constant.SystemConstant;
import com.shishuo.cms.entity.Picture;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.PictureService;

import com.shishuo.cms.util.MediaUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;


@Controller
@RequestMapping("/manage/picture")
public class ManagePictureAction extends ManageBaseAction {

    @Autowired
    private PictureService pictureService;

    @RequestMapping(value = "/listPage.htm", method = RequestMethod.GET)
    public String listPage() {
        return "/manage/pic/list1";
    }

    @RequestMapping(value = "/add.htm",method = RequestMethod.GET)
    public String add()
    {
        return "/manage/pic/add";
    }

    @RequestMapping(value = "/add.json", method = RequestMethod.POST)
    @ResponseBody
    public String add(@RequestParam(value = "file") MultipartFile file,
                      @RequestParam(value = "type", defaultValue = "0") Integer type) {
        String result = "{\"error\":\"error\"}";
        try {
            if (file != null && !file.isEmpty()) {
                String picUrl = MediaUtils.save(file);
                pictureService.add(file.getOriginalFilename(), picUrl,0,type);
                result = "{\"success\":\"success\"}";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    @RequestMapping(value = "/delete.json", method = RequestMethod.POST)
    @ResponseBody
    public JsonVo delete(@RequestParam("id") Integer id) {
        Picture pic = null;
        JsonVo jv = new JsonVo();
        jv.setResult(false);
        if (id != null) {
            pic = pictureService.getById(id);
        }

        if (pic != null) {
            try {
                pictureService.delete(id, pic.getPicUrl());
                jv.setResult(true);
            } catch (Exception e) {
            }
        }
        return jv;
    }

    @RequestMapping(value = "/list.json", method = RequestMethod.GET)
    @ResponseBody
    public PageVo<Picture> pictureList(@RequestParam(value = "p",defaultValue = "1") Integer p) {
        return pictureService.getByPage(p,configService.getIntKey("pagination_num"));
    }


    @ResponseBody
    @RequestMapping(value="/add.action",method = RequestMethod.POST)
    public String shearphoto(@RequestParam("UpFile")MultipartFile file,
                             @RequestParam(value = "type", defaultValue = "0") Integer type) throws IOException  {

        String str = "";
        try {
            if (file != null && !file.isEmpty()) {
                int height = 0;
                int width = 0;
                if(type==1){
                    height = configService.getIntKey("bigheight");
                    width = configService.getIntKey("bigwidth");
                }else{
                    height = configService.getIntKey("smallheight");
                    width = configService.getIntKey("smallwidth");
                }
                Map<String,Object> map = MediaUtils.saveImage(file,width,height);
                pictureService.add(file.getOriginalFilename(), (String)map.get("path"),(Integer)map.get("size"),type);
                str =  "{\"status\":\"success\"}";
            }else{
                str =  "{\"status\":\"false\"}";
            }
        } catch (Exception e) {
            e.printStackTrace();
            str =   "{'status':'false'}";
        }
        return str;
    }


}
