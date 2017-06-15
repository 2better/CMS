package com.shishuo.cms.action;

import com.shishuo.cms.action.manage.ManageBaseAction;
import com.shishuo.cms.entity.Event;
import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.ConfigService;
import com.shishuo.cms.service.EventService;
import com.shishuo.cms.service.MenuService;
import com.shishuo.cms.util.MediaUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * Created by labber on 2017/6/12.
 */
@Controller
@RequestMapping("/event")
public class EventAction extends BaseAction {

    @Autowired
    private EventService eventService;
    @Autowired
    private MenuService menuService;
    @Autowired
    private ConfigService configService;

    @RequestMapping(value = "/{id}.htm", method = RequestMethod.GET)
    public String event(@PathVariable("id") Integer id, ModelMap m) {
        List<Menu> menuList = menuService.getAllDisplay();
        m.put("menuList", menuList);
        m.put("event", eventService.getById(id));
        return "/template/blog/event";
    }

    //加载活动公告
    @RequestMapping(value = "/load.json", method = RequestMethod.GET)
    @ResponseBody
    public List<Event> loadEvent(@RequestParam(value = "important", defaultValue = "0") Integer important,
                                 @RequestParam(value = "p", defaultValue = "0") Integer p) {
        List<Event> events = null;
        if (important == 1) {
            events = eventService.getByPageByImportant(0, 1, 1).getList();
        } else {
            events = eventService.getByPageByImportant(p, 7, 0).getList();
        }

        return events;
    }

    //加载公告列表
    @RequestMapping(value = "/list.json", method = RequestMethod.GET)
    @ResponseBody
    public PageVo<Event> list(@RequestParam(value = "p", defaultValue = "0") Integer p) {
        return eventService.getByPageByImportant(p, configService.getIntKey("pagination_num"), 0);
    }

    @RequestMapping(value = "/list.htm",method = RequestMethod.GET)
    public String listPage(ModelMap m) {
        List<Menu> menuList = menuService.getAllDisplay();
        m.put("menuList",menuList);
        return "/template/blog/event_list";
    }

}
