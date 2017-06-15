package com.shishuo.cms.action.manage;

import com.shishuo.cms.entity.Composition;
import com.shishuo.cms.entity.Scholar;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.ScholarService;
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
@RequestMapping("/manage/scholar")
public class ManageScholarAction extends ManageBaseAction {

    @Autowired
    private ScholarService scholarService;

    @RequestMapping(value = "/listPage.htm", method = RequestMethod.GET)
    public String listPage() {
        return "/manage/scholar/list";
    }

    @RequestMapping(value = "/list.json", method = RequestMethod.GET)
    @ResponseBody
    public PageVo<Scholar> getScholarList(@RequestParam("p") Integer p) {
        return scholarService.getByPage(p, configService.getIntKey("pagination_num"));
    }

    @RequestMapping(value = "/add.htm", method = RequestMethod.GET)
    public String addPage() {
        return "/manage/scholar/add";
    }

    @RequestMapping(value = "/add.json", method = RequestMethod.POST)
    @ResponseBody
    public JsonVo add(@RequestParam("name") String name,
                      @RequestParam("content") String content,
                      @RequestParam(value = "createTime", required = false) String createTime,
                      @RequestParam(value = "file", required = false) MultipartFile file) {
        JsonVo jv = new JsonVo();
        try {
            String picUrl = "";
            if (file != null && !file.isEmpty()) {
                picUrl = MediaUtils.save(file);
            }
            scholarService.add(name,content, createTime, picUrl);
            jv.setResult(true);
        } catch (Exception e) {
            jv.setResult(false);
        }
        return jv;
    }

    @RequestMapping(value = "/update.htm", method = RequestMethod.GET)
    public String updatePage(@RequestParam("id") Integer id, ModelMap m) {
        if (id != null)
            m.put("scholar", scholarService.getById(id));
        else
            m.put("scholar", new Composition());

        return "/manage/scholar/update";
    }

    @RequestMapping(value = "/update.json", method = RequestMethod.POST)
    @ResponseBody
    public JsonVo update(@RequestParam("id") Integer id,
                         @RequestParam("name") String name,
                         @RequestParam("content") String content,
                         @RequestParam(value = "createTime", required = false) String createTime,
                         @RequestParam(value = "picUrl") String picUrl,
                         @RequestParam(value = "file", required = false) MultipartFile file) {
        JsonVo jv = new JsonVo();
        try {
            if (file != null && !file.isEmpty()) {
                picUrl = MediaUtils.save(file);
            }
            scholarService.update(id, name,  content, createTime, picUrl);
            jv.setResult(true);
        } catch (Exception e) {
            jv.setResult(false);
        }
        return jv;
    }

    @RequestMapping(value = "/delete.json", method = RequestMethod.POST)
    @ResponseBody
    public JsonVo delete(@RequestParam("id") Integer id) {
        Scholar scholar = null;
        JsonVo jv = new JsonVo();
        jv.setResult(false);
        if (id != null) {
            scholar = scholarService.getById(id);
        }

        if (scholar != null) {
            try {
                scholarService.delete(id, scholar.getPicUrl());
                jv.setResult(true);
            }catch (Exception e) {

            }
        }
        return jv;
    }
}
