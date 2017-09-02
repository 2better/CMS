package com.shishuo.cms.action.manage;

import com.shishuo.cms.constant.FolderConstant;
import com.shishuo.cms.entity.Menu;
import com.shishuo.cms.entity.vo.JsonVo;
import com.shishuo.cms.service.ArticleService;
import com.shishuo.cms.service.MenuService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * @author zyl
 * @create 2017/6/6
 */
@Controller
@RequestMapping("/manage/menu")
public class ManageMenuAction extends ManageBaseAction
{
    @Autowired
    private MenuService menuService;

    @Autowired
    private ArticleService articleService;


    @RequestMapping(value = "/list.htm", method = RequestMethod.GET)
    public String list(@RequestParam(value = "id", defaultValue = "0") long id, ModelMap modelMap)
    {
        List<Menu> menuParentsList = menuService.getAll();
        Menu menuList = menuService.getWithChildById(id);
        if(menuList==null) {
            menuList = new Menu();
            menuList.setName("");
        }
        modelMap.put("menuParentsList", menuParentsList);
        modelMap.put("Menu",menuList);
        return "manage/menu/list";
    }

    @RequestMapping(value = "/add.htm", method = RequestMethod.GET)
    public String addPage(@RequestParam(value = "id", defaultValue = "0") long id, ModelMap modelMap)
    {
        List<Menu> menuParentsList = menuService.getAll();
        Menu menu = menuService.getByid(id);
        modelMap.put("menuParentsList", menuParentsList);
        modelMap.put("Menu",menu);
        return  "manage/menu/add";
    }

    @ResponseBody
    @RequestMapping(value = "/add.json", method = RequestMethod.POST)
    public JsonVo<String> add(
            @RequestParam(value = "pid", defaultValue = "0") long pid,
            @RequestParam(value = "name") String name,
            @RequestParam(value = "url",defaultValue = "") String url,
            @RequestParam(value = "status") FolderConstant.status status,
            @RequestParam(value = "createUrl",defaultValue = "1")int createUrl) {
        JsonVo<String> json = new JsonVo<String>();
        try {
            if (StringUtils.isBlank(name)) {
                json.getErrors().put("name", "菜单名称不能为空");
            }
            // 检测校验结果
            validate(json);

            Menu menu = new Menu();
            menu.setName(name.trim());
            menu.setPid(pid);
            menu.setStatus(status);
            menu.setUrl(url);

            menuService.add(menu,createUrl);

            json.setResult(true);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            json.setResult(false);
            json.setMsg(e.getMessage());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/sort.json", method = RequestMethod.POST)
    public JsonVo<String> delete(
            @RequestParam(value = "sortJson") String sortJson) {
        JsonVo<String> json = new JsonVo<String>();
        JSONArray array = JSONArray.fromObject(sortJson);
        for (int i = 0; i < array.size(); i++) {
            JSONObject menu = array.getJSONObject(i);
            String id = menu.get("id").toString();
            String sort = menu.get("sort").toString();
            menuService.modifySortById(Long.parseLong(id),
                    Integer.parseInt(sort));
        }
        json.setResult(true);
        return json;
    }

    @RequestMapping(value = "/update.htm", method = RequestMethod.GET)
    public String oneFolder(@RequestParam("id") long id,ModelMap modelMap) throws Exception {
        Menu menu = menuService.getByid(id);
        if (menu.getUrl() == null) {
            menu.setUrl("");
        }

        modelMap.put("Menu", menu);

        return "manage/menu/update";
    }

    /**
     * @author 修改目录资料
     *
     */
    @ResponseBody
    @RequestMapping(value = "/update.json", method = RequestMethod.POST)
    public JsonVo<String> update(
            @RequestParam(value = "id") long id,
            @RequestParam(value = "name") String name,
            @RequestParam(value = "url",defaultValue = "") String url,
            @RequestParam(value = "status") FolderConstant.status status,
            @RequestParam(value = "createUrl",defaultValue = "0")int createUrl) {
        JsonVo<String> json = new JsonVo<String>();
        try {
            if (name.equals("")) {
                json.getErrors().put("name", "菜单名称不能为空");
            }
            // 检测校验结果
            validate(json);
            Menu menu = new Menu();
            menu.setName(name.trim());
            menu.setUrl(url.trim());
            menu.setStatus(status);
            menu.setId(id);

            menuService.update(menu,createUrl);

            json.setResult(true);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            json.setResult(false);
            json.setMsg(e.getMessage());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/delete.json", method = RequestMethod.POST)
    public JsonVo<String> delete(long id,long pid) {
        JsonVo<String> json = new JsonVo<String>();
        if (pid == 0) {
            int count = menuService.getCountOfChilden(id);
            if (count > 0) {
                json.setResult(false);
                json.setMsg("此菜单下还有子菜单,不能被删除。");
            } else {
                json.setResult(true);
                menuService.delete(id);
            }
        } else {
            int count = articleService.getArticleCountByMenuId(id,"");
            if (count > 0) {
                json.setResult(false);
                json.setMsg("此菜单下有文章,不能被删除。");
            } else {
                json.setResult(true);
                menuService.delete(id);
            }
        }
        return json;
    }
}
