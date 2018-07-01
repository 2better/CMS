package com.shishuo.cms.action.manage;

import com.shishuo.cms.entity.Event;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.EventService;
import com.shishuo.cms.util.MediaUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * Created by labber on 2017/6/12.
 */
@Controller
@RequestMapping("/manage/event")
public class ManageEventAction extends ManageBaseAction {

    @Autowired
    private EventService eventService;

    @RequestMapping(value = "/listPage.htm", method = RequestMethod.GET)
    public String listPage() {
        return "/manage/event/list";
    }

    @RequestMapping(value = "/list.json", method = RequestMethod.GET)
    @ResponseBody
    public PageVo<Event> getEventList(@RequestParam("p") Integer p) {
        return eventService.getByPage(p, configService.getIntKey("pagination_num"));
    }

    @RequestMapping(value = "/add.htm", method = RequestMethod.GET)
    public String addPage() {
        return "/manage/event/add";
    }

    @RequestMapping(value = "/add.json", method = RequestMethod.POST)
    @ResponseBody
    public JsonVo add(@RequestParam("name") String name,
                      @RequestParam("content") String content,
                      @RequestParam(value = "createTime", required = false) String createTime,
                      @RequestParam(value = "important") int important,
                      @RequestParam(value = "link", required = false) String link) {
        JsonVo jv = new JsonVo();
        try {
            eventService.add(name,content, createTime, important,link);
            jv.setResult(true);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            jv.setResult(false);
        }
        return jv;
    }

    @RequestMapping(value = "/update.htm", method = RequestMethod.GET)
    public String updatePage(@RequestParam("id") Integer id, ModelMap m) {
        if (id != null)
            m.put("event", eventService.getById(id));
        else
            m.put("event", new Event());

        return "/manage/event/update";
    }

    @RequestMapping(value = "/update.json", method = RequestMethod.POST)
    @ResponseBody
    public JsonVo update(@RequestParam("id") Integer id,
                         @RequestParam("name") String name,
                         @RequestParam("content") String content,
                         @RequestParam(value = "createTime", required = false) String createTime,
                         @RequestParam(value = "important") int important,
                         @RequestParam(value = "link", required = false) String link) {
        JsonVo jv = new JsonVo();
        try {
            eventService.update(id, name,  content, createTime, important,link);
            jv.setResult(true);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            jv.setResult(false);
        }
        return jv;
    }

    @RequestMapping(value = "/delete.json", method = RequestMethod.POST)
    @ResponseBody
    public JsonVo delete(@RequestParam("id") Integer id) {
        Event event = null;
        JsonVo jv = new JsonVo();
        jv.setResult(false);
        if (id != null) {
            event = eventService.getById(id);
        }

        if (event != null) {
            try {
                eventService.delete(id);
                jv.setResult(true);
            }catch (Exception e) {
                logger.error(e.getMessage(),e);
            }
        }
        return jv;
    }
}
