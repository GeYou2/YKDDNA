package com.fh.service.information.candidategene;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("candidategeneService")
public class CandidateGeneService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("CandidateGeneMapper.save", pd);
	}

	/*
	 * 保存用户
	 */
	public void saveU(PageData pd)throws Exception{
		dao.save("CandidateGeneMapper.saveU", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("CandidateGeneMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("CandidateGeneMapper.edit", pd);
	}

	/*
	 * 通过Gene.ensGene获取数据
	 */
	public PageData findByGeneEnsgene(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CandidateGeneMapper.findByGeneEnsgene", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("CandidateGeneMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CandidateGeneMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CandidateGeneMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("CandidateGeneMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

