package com.fh.controller.information.informationinput;

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

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;

/** 
 * 类名称：InformationInputController
 * 创建人：FH 
 * 创建时间：2020-08-10
 */
@Controller
@RequestMapping(value="/informationinput")
public class InformationInputController extends BaseController {
	
	String menuUrl = "informationinput/list.do"; //菜单地址(权限用)
	@Resource(name="informationinputService")
	private InformationInputService informationinputService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增InformationInput");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("INFORMATIONINPUT_ID", this.get32UUID());	//主键
		informationinputService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除InformationInput");
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			informationinputService.delete(pd);
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
		logBefore(logger, "修改InformationInput");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		informationinputService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表InformationInput");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();

			/* ===============================条件筛选================================== */
			String BARCODENAME = pd.getString("BARCODENAME");
			if(null != BARCODENAME && !"".equals(BARCODENAME)){
				BARCODENAME = BARCODENAME.trim();
				pd.put("BARCODENAME", BARCODENAME);
			}

			String SEXSTATUS = pd.getString("SEXSTATUS");
			if(null != SEXSTATUS && !"".equals(SEXSTATUS)){
				SEXSTATUS = SEXSTATUS.trim();
				pd.put("SEXSTATUS", SEXSTATUS);
			}

			String lastLoginStart = pd.getString("lastLoginStart");
			String lastLoginEnd = pd.getString("lastLoginEnd");
			if(lastLoginStart != null && !"".equals(lastLoginStart)){
				lastLoginStart = lastLoginStart+" 00:00:00";
				pd.put("lastLoginStart", lastLoginStart);
			}
			if(lastLoginEnd != null && !"".equals(lastLoginEnd)){
				lastLoginEnd = lastLoginEnd+" 00:00:00";
				pd.put("lastLoginEnd", lastLoginEnd);
			}
			/* ===============================条件筛选================================== */

			page.setPd(pd);
			List<PageData>	varList = informationinputService.list(page);	//列出InformationInput列表
			mv.setViewName("information/informationinput/informationinput_list");
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
		logBefore(logger, "去新增InformationInput页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("information/informationinput/informationinput_edit");
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
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改InformationInput页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = informationinputService.findById(pd);	//根据ID读取
			mv.setViewName("information/informationinput/informationinput_edit");
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
		logBefore(logger, "批量删除InformationInput");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				informationinputService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, "导出InformationInput到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("就诊中心");	//1
			titles.add("送检医生");	//2
			titles.add("姓名");	//3
			titles.add("年龄");	//4
			titles.add("性别");	//5
			titles.add("与患者关系");	//6
			titles.add("收样日期");	//7
			titles.add("情况概述");	//8
			titles.add("详细情况");	//9
			titles.add("是否全血");	//10
			titles.add("血液存放地点");	//11
			titles.add("DNA样本浓度");	//12
			titles.add("260");	//13
			titles.add("280");	//14
			titles.add("260/280");	//15
			titles.add("260/230");	//16
			titles.add("DNA质检结果");	//17
			titles.add("样本存放位置");	//18
			titles.add("遗传检测相关项目");	//19
			titles.add("候选基因一");	//20
			titles.add("验证引无序列一");	//21
			titles.add("候选基因二");	//22
			titles.add("验证引物序列二");	//23
			titles.add("候选基因三");	//24
			titles.add("验证引物序列三");	//25
			dataMap.put("titles", titles);
			List<PageData> varOList = informationinputService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("CLINIC"));	//1
				vpd.put("var2", varOList.get(i).getString("INSPECTION_DOCTOR"));	//2
				vpd.put("var3", varOList.get(i).getString("NAME"));	//3
				vpd.put("var4", varOList.get(i).getString("AGE"));	//4
				vpd.put("var5", varOList.get(i).getString("SEX"));	//5
				vpd.put("var6", varOList.get(i).getString("RELATIONSHIP_PATIENTS"));	//6
				vpd.put("var7", varOList.get(i).getString("DATE"));	//7
				vpd.put("var8", varOList.get(i).getString("INTRODUCE"));	//8
				vpd.put("var9", varOList.get(i).getString("DETAIL_INTRODUCE"));	//9
				vpd.put("var10", varOList.get(i).getString("IS_BLOOD"));	//10
				vpd.put("var11", varOList.get(i).getString("BLOOD_STORAGE_LOCATION"));	//11
				vpd.put("var12", varOList.get(i).getString("DNA_CONCENTRATION"));	//12
				vpd.put("var13", varOList.get(i).getString("A260"));	//13
				vpd.put("var14", varOList.get(i).getString("A280"));	//14
				vpd.put("var15", varOList.get(i).getString("A260/280"));	//15
				vpd.put("var16", varOList.get(i).getString("A260/230"));	//16
				vpd.put("var17", varOList.get(i).getString("DNA_RESULT"));	//17
				vpd.put("var18", varOList.get(i).getString("DNA_STORAGE_LOCATION"));	//18
				vpd.put("var19", varOList.get(i).getString("GENETIC_TESTING_ITEMS"));	//19
				vpd.put("var20", varOList.get(i).getString("CANDIDATEGENE_ONE"));	//20
				vpd.put("var21", varOList.get(i).getString("VALIDATIONOPRIMERSEQUENCE_ONE"));	//21
				vpd.put("var22", varOList.get(i).getString("CANDIDATEGENE_TWO"));	//22
				vpd.put("var23", varOList.get(i).getString("VALIDATIONOPRIMERSEQUENCE_TWO"));	//23
				vpd.put("var24", varOList.get(i).getString("CANDIDATEGENE_THREE"));	//24
				vpd.put("var25", varOList.get(i).getString("VALIDATIONOPRIMERSEQUENCE_THREE"));	//25
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
