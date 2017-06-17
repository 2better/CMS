package com.shishuo.cms.action;

import com.shishuo.cms.entity.Composition;
import com.shishuo.cms.entity.Event;
import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.CompositionService;
import com.shishuo.cms.service.ConfigService;
import com.shishuo.cms.service.EventService;
import com.shishuo.cms.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by labber on 2017/6/12.
 */
@Controller
@RequestMapping("/composition")
public class CompositionAction extends BaseAction {

    @Autowired
    private CompositionService compositionService;
    @Autowired
    private ConfigService configService;

    @RequestMapping(value = "/{id}.htm", method = RequestMethod.GET)
    public String event(@PathVariable("id") Integer id, ModelMap m, HttpServletRequest request) {
        pageStaticUtils.headerAndFooterStaticPage(request);
        m.put("composition", compositionService.getById(id));
        return "/template/blog/composition";
    }

    @RequestMapping(value = "/list.json",method = RequestMethod.GET)
    @ResponseBody
    public PageVo<Composition> list(@RequestParam(value = "p", defaultValue = "0") Integer p,
                                    @RequestParam(value = "rows",required = false) Integer rows) {
        Integer r = configService.getIntKey("pagination_num");
         r = (rows == null || rows <= 0 || rows > 6) ? r : rows;
        return compositionService.getByPage(p, r);
    }

    @RequestMapping(value = "/list.htm",method = RequestMethod.GET)
    public String listPage(HttpServletRequest request) {
        pageStaticUtils.headerAndFooterStaticPage(request);
        return "/template/blog/composition_list";
    }

}
