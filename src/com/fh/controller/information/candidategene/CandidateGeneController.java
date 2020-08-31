package com.fh.controller.information.candidategene;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.fh.entity.system.Role;
import com.fh.service.information.candidategene.CandidateGeneService;
import com.fh.util.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;

/**
 * 类名称：CandidateGeneController
 * 创建人：FH
 * 创建时间：2020-08-21
 */
@Controller
@RequestMapping(value = "/candidategene")
public class CandidateGeneController extends BaseController {

    String menuUrl = "candidategene/list.do"; //菜单地址(权限用)
    @Resource(name = "candidategeneService")
    private CandidateGeneService candidategeneService;

    /**
     * 新增
     */
    @RequestMapping(value = "/save")
    public ModelAndView save() throws Exception {
        logBefore(logger, "新增CandidateGene");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("CANDIDATEGENE_ID", this.get32UUID());    //主键
        candidategeneService.save(pd);
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delete")
    public void delete(PrintWriter out) {
        logBefore(logger, "删除CandidateGene");
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            candidategeneService.delete(pd);
            out.write("success");
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

    }

    /**
     * 修改
     */
    @RequestMapping(value = "/edit")
    public ModelAndView edit() throws Exception {
        logBefore(logger, "修改CandidateGene");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        candidategeneService.edit(pd);
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 列表
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(Page page) {
        logBefore(logger, "列表CandidateGene");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            page.setPd(pd);
            List<PageData> varList = candidategeneService.list(page);    //列出CandidateGene列表
            mv.setViewName("information/candidategene/candidategene_list");
            mv.addObject("varList", varList);
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 去新增页面
     */
    @RequestMapping(value = "/goAdd")
    public ModelAndView goAdd() {
        logBefore(logger, "去新增CandidateGene页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            mv.setViewName("information/candidategene/candidategene_edit");
            mv.addObject("msg", "save");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 去修改页面
     */
    @RequestMapping(value = "/goEdit")
    public ModelAndView goEdit() {
        logBefore(logger, "去修改CandidateGene页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            pd = candidategeneService.findById(pd);    //根据ID读取
            mv.setViewName("information/candidategene/candidategene_edit");
            mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 批量删除
     */
    @RequestMapping(value = "/deleteAll")
    @ResponseBody
    public Object deleteAll() {
        logBefore(logger, "批量删除CandidateGene");
        PageData pd = new PageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            pd = this.getPageData();
            List<PageData> pdList = new ArrayList<PageData>();
            String DATA_IDS = pd.getString("DATA_IDS");
            if (null != DATA_IDS && !"".equals(DATA_IDS)) {
                String ArrayDATA_IDS[] = DATA_IDS.split(",");
                candidategeneService.deleteAll(ArrayDATA_IDS);
                pd.put("msg", "ok");
            } else {
                pd.put("msg", "no");
            }
            pdList.add(pd);
            map.put("list", pdList);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return AppUtil.returnObject(pd, map);
    }

    /**
     * 打开上传EXCEL页面
     */
    @RequestMapping(value = "/goUploadExcel")
    public ModelAndView goUploadExcel() throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("information/candidategene/uploadexcel");
        return mv;
    }

    /**
     * 下载模版
     */
    @RequestMapping(value = "/downExcel")
    public void downExcel(HttpServletResponse response) throws Exception {

        FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "cadidate geness.xls", "cadidate_geness.xls");

    }


    /**
     * 从EXCEL导入到数据库
     */
    @RequestMapping(value = "/readExcel")
    public ModelAndView readExcel(
            @RequestParam(value = "excel", required = false) MultipartFile file
    ) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        if (null != file && !file.isEmpty()) {
            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;                                //文件上传路径
            String fileName = FileUpload.fileUp(file, filePath, "cadidate_genessexcel");                            //执行上传
            List<PageData> listPd = (List) ObjectExcelRead.readExcelContent(filePath, fileName);    //执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet

            /*存入数据库操作======================================*/
            /**
             * var0 :ID no
             * var1 :基因
             * var2 :Gene.ensGene
             * var3 :表型
             * var4 :表型分类
             * var5 :补充
             * var6 :参考文献
             * var7 ：PMID
             */
            for (int i = 0; i < listPd.size(); i++) {
                pd.put("CANDIDATEGENE_ID", this.get32UUID());
                pd.put("GENE", listPd.get(i).getString("var1"));//ID
                String GENEENSGENE = listPd.get(i).getString("var2");
                pd.put("GENEENSGENE", GENEENSGENE);
                if(candidategeneService.findByGeneEnsgene(pd) != null){										//判断用户名是否重复
                    pd.put("USERNAME", listPd.get(i).getString("var2"));
                }
                pd.put("GENEENSGENE", listPd.get(i).getString("var2"));
                pd.put("TYPE", listPd.get(i).getString("var3"));
                pd.put("SUMMARY", listPd.get(i).getString("var4"));
                pd.put("SUPPLEMENT", listPd.get(i).getString("var5"));
                pd.put("REFERENCE", listPd.get(i).getString("var6"));
                pd.put("PMID", listPd.get(i).getString("var7"));

                candidategeneService.saveU(pd);
            }
            /*存入数据库操作======================================*/

            mv.addObject("msg", "success");

        }
        mv.setViewName("save_result");
        return mv;
    }

    /*
     * 导出到excel
     * @return
     */
    @RequestMapping(value = "/excel")
    public ModelAndView exportExcel() {
        logBefore(logger, "导出CandidateGene到excel");
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            Map<String, Object> dataMap = new HashMap<String, Object>();
            List<String> titles = new ArrayList<String>();
            titles.add("Gene.ensGene");    //1
            titles.add("表型");    //2
            titles.add("表型分类");    //3
            titles.add("补充");    //4
            titles.add("参考文献");    //5
            titles.add("PMID");    //6
            dataMap.put("titles", titles);
            List<PageData> varOList = candidategeneService.listAll(pd);
            List<PageData> varList = new ArrayList<PageData>();
            for (int i = 0; i < varOList.size(); i++) {
                PageData vpd = new PageData();
                vpd.put("var1", varOList.get(i).getString("GENEENSGENE"));    //1
                vpd.put("var2", varOList.get(i).getString("TYPE"));    //2
                vpd.put("var3", varOList.get(i).getString("SUMMARY"));    //3
                vpd.put("var4", varOList.get(i).getString("SUPPLEMENT"));    //4
                vpd.put("var5", varOList.get(i).getString("REFERENCE"));    //5
                vpd.put("var6", varOList.get(i).getString("PMID"));    //6
                varList.add(vpd);
            }
            dataMap.put("varList", varList);
            ObjectExcelView erv = new ObjectExcelView();
            mv = new ModelAndView(erv, dataMap);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
    }
}
