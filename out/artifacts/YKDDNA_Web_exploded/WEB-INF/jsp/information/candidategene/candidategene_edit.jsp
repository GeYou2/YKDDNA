<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		
<script type="text/javascript">
	
	
	//保存
	function save(){
		if($("#GENE").val()==""){
			$("#GENE").tips({
				side:3,
				msg:'请输入基因',
				bg:'#AE81FF',
				time:2
			});
			$("#GENE").focus();
			return false;
		}
			if($("#GENEENSGENE").val()==""){
			$("#GENEENSGENE").tips({
				side:3,
	            msg:'请输入Gene.ensGene',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#GENEENSGENE").focus();
			return false;
		}
		if($("#TYPE").val()==""){
			$("#TYPE").tips({
				side:3,
	            msg:'请输入表型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TYPE").focus();
			return false;
		}
		if($("#SUMMARY").val()==""){
			$("#SUMMARY").tips({
				side:3,
	            msg:'请输入表型分类',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SUMMARY").focus();
			return false;
		}
		if($("#SUPPLEMENT").val()==""){
			$("#SUPPLEMENT").tips({
				side:3,
	            msg:'请输入补充',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SUPPLEMENT").focus();
			return false;
		}
		if($("#REFERENCE").val()==""){
			$("#REFERENCE").tips({
				side:3,
	            msg:'请输入参考文献',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#REFERENCE").focus();
			return false;
		}
		if($("#PMID").val()==""){
			$("#PMID").tips({
				side:3,
	            msg:'请输入PMID',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PMID").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="candidategene/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="CANDIDATEGENE_ID" id="CANDIDATEGENE_ID" value="${pd.CANDIDATEGENE_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">基因:</td>
				<td><input type="text" name="GENE" id="GENE" value="${pd.GENE}" maxlength="32" placeholder="这里输入基因" title="GENE"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">Gene.ensGene:</td>
				<td><input type="text" name="GENEENSGENE" id="GENEENSGENE" value="${pd.GENEENSGENE}" maxlength="32" placeholder="这里输入Gene.ensGene" title="Gene.ensGene"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">表型:</td>
				<td><input type="text" name="TYPE" id="TYPE" value="${pd.TYPE}" maxlength="32" placeholder="这里输入表型" title="表型"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">表型分类:</td>
				<td><input type="text" name="SUMMARY" id="SUMMARY" value="${pd.SUMMARY}" maxlength="32" placeholder="这里输入表型分类" title="表型分类"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">补充:</td>
				<td><input type="text" name="SUPPLEMENT" id="SUPPLEMENT" value="${pd.SUPPLEMENT}" maxlength="32" placeholder="这里输入补充" title="补充"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">参考文献:</td>
				<td><input type="text" name="REFERENCE" id="REFERENCE" value="${pd.REFERENCE}" maxlength="32" placeholder="这里输入参考文献" title="参考文献"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">PMID:</td>
				<td><input type="text" name="PMID" id="PMID" value="${pd.PMID}" maxlength="32" placeholder="这里输入PMID" title="PMID"/></td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		</script>
</body>
</html>