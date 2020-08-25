<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>"><!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>
</head>
<body>

<div class="container-fluid" id="main-container">


    <div id="page-content" class="clearfix">

        <div class="row-fluid">

            <div class="row-fluid">

                <!-- 检索  -->
                <form action="informationinput/list.do" method="post" name="Form" id="Form">
                    <table>
                        <tr>
                            <td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="BARCODENAME" value="${pd.BARCODENAME}"
                                   placeholder="这里输入关键词"/>
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
                            </td>
                            <td style="vertical-align:top;">
                                <select class="chzn-select" name="SEXSTATUS" id="SEXSTATUS" data-placeholder="请选择性别" style="vertical-align:top;width: 120px;">
                                    <option value=""></option>
                                    <option value="">全部</option>
                                    <option value="1" <c:if test="${pd.SEXSTATUS == '1' }">selected</c:if> >男</option>
                                    <option value="2" <c:if test="${pd.SEXSTATUS == '2' }">selected</c:if> >女</option>
                                </select>
                            </td>
                            <td><input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart"
                                       value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd"
                                       readonly="readonly" style="width:88px;" placeholder="开始日期"/></td>
                            <td><input class="span10 date-picker" name="lastLoginEnd" id="lastLoginEnd"
                                       value="${pd.lastLoginEnd}" type="text" data-date-format="yyyy-mm-dd"
                                       readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
                            <td style="vertical-align:top;">
                                <button class="btn btn-mini btn-light" onclick="search();" title="检索"><i
                                        id="nav-search-icon" class="icon-search"></i></button>
                            </td>
                            <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();"
                                                               title="导出到EXCEL"><i id="nav-search-icon"
                                                                                   class="icon-download-alt"></i></a>
                            </td>
                        </tr>
                    </table>
                    <!-- 检索  -->


                    <table id="table_report" class="table table-striped table-bordered table-hover">

                        <thead>
                        <tr>
                            <th class="center">
                                <label><input type="checkbox" id="zcheckbox"/><span class="lbl"></span></label>
                            </th>
                            <th class="center">序号</th>
                            <th class="center">就诊中心</th>
                            <th class="center">送检医生</th>
                            <th class="center">姓名</th>
                            <th class="center">年龄</th>
                            <th class="center">性别</th>
                            <th class="center">与患者关系</th>
                            <th class="center">收样日期</th>
                            <th class="center">情况概述</th>
                            <th class="center">是否全血</th>
                            <th class="center">血液存放位置</th>
                            <th class="center">DNA质检结果</th>
                            <th class="center">DNA存放位置</th>
                            <th class="center">遗传检测相关</th>
                            <th class="center">操作</th>
                        </tr>
                        </thead>

                        <tbody>

                        <!-- 开始循环 -->
                        <c:choose>
                            <c:when test="${not empty varList}">
                                <c:forEach items="${varList}" var="var" varStatus="vs">
                                    <tr>
                                        <td class='center' style="width: 30px;">
                                            <label><input type='checkbox' name='ids'
                                                          value="${var.INFORMATIONINPUT_ID}"/><span class="lbl"></span></label>
                                        </td>
                                        <td class='center' style="width: 30px;">${vs.index+1}</td>
                                        <td class='center'>${var.CLINIC}</td>
                                        <td class='center'>${var.INSPECTION_DOCTOR}</td>
                                        <td class='center'>${var.NAME}</td>
                                        <td class='center'>${var.AGE}</td>
                                        <td class='center'><c:if test="${var.SEX == 1}">男</c:if><c:if test="${var.SEX == 2}">女</c:if></td>
                                        <td class='center'>${var.RELATIONSHIP_PATIENTS}</td>
                                        <td class='center'>${var.DATE}</td>
                                        <td class='center'>${var.INTRODUCE}</td>
                                        <td class='center'><c:if test="${var.IS_BLOOD == 1}">是</c:if><c:if test="${var.IS_BLOOD == 2}">否</c:if></td>
                                        <td class='center'>${var.BLOOD_STORAGE_LOCATION}</td>
                                        <td class='center'>${var.DNA_RESULT}</td>
                                        <td class='center'>${var.DNA_STORAGE_LOCATION}</td>
                                        <td class='center'><c:if test="${var.GENETIC_TESTING_ITEMS == 1}">全外测序</c:if><c:if test="${var.GENETIC_TESTING_ITEMS == 2}">Sanger测序</c:if><c:if test="${var.GENETIC_TESTING_ITEMS == 3}">全外/Sanger</c:if></td>
                                        <td style="width: 100px;" class="center">
                                            <a style="cursor:pointer;" title="编辑" onclick="edit('${var.INFORMATIONINPUT_ID}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left">编辑</a>&nbsp;
                                            <a style="cursor:pointer;" title="上传测序文件" onclick="uploadfile('${var.INFORMATIONINPUT_ID}','${var.NAME}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left">文件上传</a>&nbsp;
                                        </td>
                                    </tr>

                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr class="main_info">
                                    <td colspan="100" class="center">没有相关数据</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>


                        </tbody>
                    </table>

                    <div class="page-header position-relative">
                        <table style="width:100%;">
                            <tr>
                                <td style="vertical-align:top;">
                                    <a class="btn btn-small btn-success" onclick="add();">新增</a>
                                    <a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除"><i
                                            class='icon-trash'></i></a>
                                </td>
                                <td style="vertical-align:top;">
                                    <div class="pagination"
                                         style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </form>
            </div>


            <!-- PAGE CONTENT ENDS HERE -->
        </div><!--/row-->

    </div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->

<!-- 返回顶部  -->
<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
    <i class="icon-double-angle-up icon-only"></i>
</a>

<!-- 引入 -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>

<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
<!-- 引入 -->
<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
<script type="text/javascript">

    $(top.hangge());

    //检索
    function search() {
        top.jzts();
        $("#Form").submit();
    }

    //新增
    function add() {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "新增";
        diag.URL = '<%=basePath%>informationinput/goAdd.do';
        diag.Width = 800;
        diag.Height = 600;
        diag.CancelEvent = function () { //关闭事件
            if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                if ('${page.currentPage}' == '0') {
                    top.jzts();
                    setTimeout("self.location=self.location", 100);
                } else {
                    nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }

    //删除
    function del(Id) {
        bootbox.confirm("确定要删除吗?", function (result) {
            if (result) {
                top.jzts();
                var url = "<%=basePath%>informationinput/delete.do?INFORMATIONINPUT_ID=" + Id + "&tm=" + new Date().getTime();
                $.get(url, function (data) {
                    nextPage(${page.currentPage});
                });
            }
        });
    }

    //修改
    function edit(Id) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "编辑";
        diag.URL = '<%=basePath%>informationinput/goEdit.do?INFORMATIONINPUT_ID=' + Id;
        diag.Width = 800;
        diag.Height = 600;
        diag.CancelEvent = function () { //关闭事件
            if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                nextPage(${page.currentPage});
            }
            diag.close();
        };
        diag.show();
    }


    //上传测序文件
    function uploadfile(Id,Name) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "上传"+Name+"测序文件";
        diag.URL = '<%=basePath%>sequencefile/goAdd.do?INFORMATIONINPUT_ID=' + Id;
        diag.Width = 800;
        diag.Height = 600;
        diag.CancelEvent = function () { //关闭事件
            if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                if ('${page.currentPage}' == '0') {
                    top.jzts();
                    setTimeout("self.location=self.location", 100);
                } else {
                    nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }
</script>

<script type="text/javascript">

    $(function () {

        //下拉框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect: true});

        //日期框
        $('.date-picker').datepicker();

        //复选框
        $('table th input:checkbox').on('click', function () {
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
                .each(function () {
                    this.checked = that.checked;
                    $(this).closest('tr').toggleClass('selected');
                });

        });

    });


    //批量操作
    function makeAll(msg) {
        bootbox.confirm(msg, function (result) {
            if (result) {
                var str = '';
                for (var i = 0; i < document.getElementsByName('ids').length; i++) {
                    if (document.getElementsByName('ids')[i].checked) {
                        if (str == '') str += document.getElementsByName('ids')[i].value;
                        else str += ',' + document.getElementsByName('ids')[i].value;
                    }
                }
                if (str == '') {
                    bootbox.dialog("您没有选择任何内容!",
                        [
                            {
                                "label": "关闭",
                                "class": "btn-small btn-success",
                                "callback": function () {
                                    //Example.show("great success");
                                }
                            }
                        ]
                    );

                    $("#zcheckbox").tips({
                        side: 3,
                        msg: '点这里全选',
                        bg: '#AE81FF',
                        time: 8
                    });

                    return;
                } else {
                    if (msg == '确定要删除选中的数据吗?') {
                        top.jzts();
                        $.ajax({
                            type: "POST",
                            url: '<%=basePath%>informationinput/deleteAll.do?tm=' + new Date().getTime(),
                            data: {DATA_IDS: str},
                            dataType: 'json',
                            //beforeSend: validateData,
                            cache: false,
                            success: function (data) {
                                $.each(data.list, function (i, list) {
                                    nextPage(${page.currentPage});
                                });
                            }
                        });
                    }
                }
            }
        });
    }

    //导出excel
    function toExcel() {
        window.location.href = '<%=basePath%>informationinput/excel.do';
    }
</script>

</body>
</html>

