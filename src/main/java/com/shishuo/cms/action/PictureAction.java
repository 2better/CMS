package com.shishuo.cms.action;

import com.shishuo.cms.action.manage.ManageBaseAction;
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

import java.util.List;

/**
 * Created by labber on 2017/6/12.
 */
@Controller
@RequestMapping("/picture")
public class PictureAction extends BaseAction {

    @Autowired
    private PictureService pictureService;

    @RequestMapping(value = "/list.json", method = RequestMethod.GET)
    @ResponseBody
    public List<Picture> getList(@RequestParam(value = "type", defaultValue = "0") Integer type) {
        return pictureService.getAllByType(type);
    }
}
