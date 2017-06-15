package com.shishuo.cms.action;

import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.entity.Scholar;
import com.shishuo.cms.entity.vo.PageVo;
import com.shishuo.cms.service.ConfigService;
import com.shishuo.cms.service.MenuService;
import com.shishuo.cms.service.ScholarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by labber on 2017/6/12.
 */
@Controller
@RequestMapping("/scholar")
public class ScholarAction extends BaseAction {

    @Autowired
    private ScholarService scholarService;
    @Autowired
    private MenuService menuService;
    @Autowired
    private ConfigService configService;

    @RequestMapping(value = "/{id}.htm", method = RequestMethod.GET)
    public String event(@PathVariable("id") Integer id, ModelMap m) {
        List<Menu> menuList = menuService.getAllDisplay();
        m.put("menuList", menuList);
        m.put("scholar", scholarService.getById(id));
        return "/template/blog/scholar";
    }

    @RequestMapping(value = "/list.json",method = RequestMethod.GET)
    @ResponseBody
    public PageVo<Scholar> list(@RequestParam(value = "p", defaultValue = "0") Integer p,
                                @RequestParam(value = "rows",required = false) Integer rows) {
        Integer r = configService.getIntKey("pagination_num");
        r = (rows == null || rows <= 0 || rows > 6) ? r : rows;
        return scholarService.getByPage(p, r);
    }

    @RequestMapping(value = "/list.htm",method = RequestMethod.GET)
    public String listPage(ModelMap m) {
        List<Menu> menuList = menuService.getAllDisplay();
        m.put("menuList",menuList);
        return "/template/blog/scholar_list";
    }
}
