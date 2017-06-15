package com.shishuo.cms.action;

import com.shishuo.cms.action.manage.ManageDocumentAction;
import com.shishuo.cms.entity.Document;
import com.shishuo.cms.service.DocumentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by labber on 2017/6/12.
 */
@Controller
@RequestMapping("/paper")
public class DocumentAction extends ManageDocumentAction{

    @Resource
    private DocumentService documentService ;

    @RequestMapping(value = "/download/{id}", method = RequestMethod.GET)
    public String download(@PathVariable(value = "id") long id, HttpServletResponse response) {
        return super.downloadFile(id, response);
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public List<Document> getPapers() {
        return documentService.getBy_Column(1,0,6);
    }


}
