package com.shishuo.cms.action.manage;

import com.shishuo.cms.entity.Composition;
import com.shishuo.cms.entity.Picture;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.PictureService;
import com.shishuo.cms.util.MediaUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by labber on 2017/6/12.
 */
@Controller
@RequestMapping("/manage/picture")
public class ManagePictureAction extends ManageBaseAction {

    @Autowired
    private PictureService pictureService;

    @RequestMapping(value = "/listPage.htm", method = RequestMethod.GET)
    public String listPage() {
        return "/manage/pic/list";
    }

    @RequestMapping(value = "/add.json", method = RequestMethod.POST)
    @ResponseBody
    public String add(@RequestParam(value = "file") MultipartFile file,
                      @RequestParam(value = "type", defaultValue = "0") Integer type) {
        String result = "{\"error\":\"error\"}";
        try {
            if (file != null && !file.isEmpty()) {
                String picUrl = MediaUtils.save(file);
                System.out.println(type);
                pictureService.add(file.getOriginalFilename(), picUrl,type);
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
    public PageVo<Picture> pictureList(@RequestParam(value = "type",defaultValue = "0") Integer type,
                                       @RequestParam(value = "p",defaultValue = "1") Integer p) {
        return pictureService.getByPageByType(p,configService.getIntKey("pagination_num"),type);
    }
}
