package com.shishuo.cms.action.manage;

import com.shishuo.cms.entity.Composition;
import com.shishuo.cms.entity.Event;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.CompositionService;
import com.shishuo.cms.util.MediaUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * Created by labber on 2017/6/12.
 */
@Controller
@RequestMapping("/manage/composition")
public class ManageCompositionAction extends ManageBaseAction {

    @Autowired
    private CompositionService compositionService;

    @RequestMapping(value = "/listPage.htm", method = RequestMethod.GET)
    public String listPage() {
        return "/manage/composition/list";
    }

    @RequestMapping(value = "/list.json", method = RequestMethod.GET)
    @ResponseBody
    public PageVo<Composition> getCompositionList(@RequestParam("p") Integer p) {
        return compositionService.getByPage(p, configService.getIntKey("pagination_num"));
    }

    @RequestMapping(value = "/add.htm", method = RequestMethod.GET)
    public String addPage() {
        return "/manage/composition/add";
    }

    @RequestMapping(value = "/add.json", method = RequestMethod.POST)
    @ResponseBody
    public JsonVo add(@RequestParam("title") String title,
                      @RequestParam("content") String content,
                      @RequestParam(value = "createTime", required = false) String createTime,
                      @RequestParam(value = "file", required = false) MultipartFile file,
                      @RequestParam(value = "x") Double x,
                      @RequestParam(value = "y") Double y,
                      @RequestParam(value = "height") Double h,
                      @RequestParam(value = "width") Double w,
                      @RequestParam(value = "rotate",defaultValue = "0") Integer r) {
        JsonVo jv = new JsonVo();
        try {
            String picUrl = "";
            if (file != null && !file.isEmpty()) {
                if(MediaUtils.isFileType(file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")), MediaUtils.PHOTO_TYPE)) {
                    Map<String, Object> map = MediaUtils.saveImage(file, x.intValue(), y.intValue(),w.intValue(),h.intValue(),r.intValue());
                    picUrl = (String) map.get("path");
                }
            }
            compositionService.add(title,content, createTime, picUrl);
            jv.setResult(true);
        } catch (Exception e) {
            jv.setResult(false);
        }
        return jv;
    }

    @RequestMapping(value = "/update.htm", method = RequestMethod.GET)
    public String updatePage(@RequestParam("id") Integer id, ModelMap m) {
        if (id != null)
            m.put("composition", compositionService.getById(id));
        else
            m.put("composition", new Composition());

        return "/manage/composition/update";
    }

    @RequestMapping(value = "/update.json", method = RequestMethod.POST)
    @ResponseBody
    public JsonVo update(@RequestParam("id") Integer id,
                         @RequestParam("title") String title,
                         @RequestParam("content") String content,
                         @RequestParam(value = "createTime", required = false) String createTime,
                         @RequestParam(value = "picUrl") String picUrl,
                         @RequestParam(value = "file", required = false) MultipartFile file) {
        JsonVo jv = new JsonVo();
        try {
            if (file != null && !file.isEmpty()) {
                picUrl = MediaUtils.save(file);
            }
            compositionService.update(id, title,  content, createTime, picUrl);
            jv.setResult(true);
        } catch (Exception e) {
            jv.setResult(false);
        }
        return jv;
    }

    @RequestMapping(value = "/delete.json", method = RequestMethod.POST)
    @ResponseBody
    public JsonVo delete(@RequestParam("id") Integer id) {
        Composition composition = null;
        JsonVo jv = new JsonVo();
        jv.setResult(false);
        if (id != null) {
            composition = compositionService.getById(id);
        }

        if (composition != null) {
            try {
                compositionService.delete(id, composition.getPicUrl());
                jv.setResult(true);
            }catch (Exception e) {

            }
        }
        return jv;
    }
}
