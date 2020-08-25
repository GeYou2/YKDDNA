package com.fh.controller.information.sequencefile;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.fh.service.information.informationinput.InformationInputService;
import com.fh.service.information.sequencefile.SequenceFileService;
import com.fh.util.*;
import org.apache.shiro.SecurityUtils;
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
 * 类名称：SequenceFileController
 * 创建人：FH 
 * 创建时间：2020-08-20
 */
@Controller
@RequestMapping(value="/sequencefile")
public class SequenceFileController extends BaseController {
	
	String menuUrl = "sequencefile/list.do"; //菜单地址(权限用)
	@Resource(name="sequencefileService")
	private SequenceFileService sequencefileService;
	@Resource(name="informationinputService")
	private InformationInputService informationinputService;

	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public Object save(
			@RequestParam(required=false) MultipartFile file
	) throws Exception{
		logBefore(logger, "新增SequenceFile");
		Map<String,String> map = new HashMap<String,String>();
		String  ffile = DateUtil.getDays(), fileName = "";
		String  choiceFileName = file.getOriginalFilename();//选择上传的文件名
		String  extName = file.getOriginalFilename().substring((file.getOriginalFilename().lastIndexOf(".")+1),file.getOriginalFilename().length());//选择上传的文件后缀
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){
			if (null != file && !file.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;		//文件上传路径
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//执行上传
			}else{
				System.out.println("上传失败");
			}

			pd.put("FILE_ID", this.get32UUID());			//主键
			pd.put("INFORID", pd.getString("INFORMATIONINPUT_ID"));//信息Id
			pd.put("NAME", choiceFileName);			//文件名
			pd.put("EXTNAME", extName);//后缀名
			pd.put("PATH", ffile + "/" + fileName);				//路径
			pd.put("CREATETIME", Tools.date2Str(new Date()));	//创建时间
			pd.put("BZ", "信息管理处上传");						//备注
			sequencefileService.save(pd);
		}
		map.put("result", "ok");
		return AppUtil.returnObject(pd, map);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除SequenceFile");
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			sequencefileService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, "修改SequenceFile");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		sequencefileService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表SequenceFile");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();


			String SWQUENCENAME = pd.getString("SWQUENCENAME");
			if(null != SWQUENCENAME && !"".equals(SWQUENCENAME)){
				SWQUENCENAME = SWQUENCENAME.trim();
				pd.put("SWQUENCENAME", SWQUENCENAME);
			}

			page.setPd(pd);
			List<PageData>	varList = sequencefileService.list(page);	//列出SequenceFile列表
			mv.setViewName("information/sequencefile/sequencefile_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增SequenceFile页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = informationinputService.findById(pd);	//根据ID读取
			mv.setViewName("information/sequencefile/sequencefile_add");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改SequenceFile页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = sequencefileService.findById(pd);	//根据ID读取
			mv.setViewName("information/sequencefile/sequencefile_edit");
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
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除SequenceFile");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				sequencefileService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
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
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出SequenceFile到excel");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("String");	//1
			titles.add("文件名");	//2
			titles.add("文件后缀名");	//3
			titles.add("路径");	//4
			titles.add("创建时间");	//5
			titles.add("备注");	//6
			dataMap.put("titles", titles);
			List<PageData> varOList = sequencefileService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("INFORID"));	//1
				vpd.put("var2", varOList.get(i).getString("NAME"));	//2
				vpd.put("var3", varOList.get(i).getString("EXTNAME"));	//3
				vpd.put("var4", varOList.get(i).getString("PATH"));	//4
				vpd.put("var5", varOList.get(i).getString("CREATETIME"));	//5
				vpd.put("var6", varOList.get(i).getString("BZ"));	//6
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	

	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
