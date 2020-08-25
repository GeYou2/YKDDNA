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
    <base href="<%=basePath%>">
    <meta charset="utf-8"/>
    <title></title>
    <meta name="description" content="overview & stats"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="static/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="static/css/bootstrap-responsive.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="static/css/font-awesome.min.css"/>
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/css/chosen.css"/>

    <link rel="stylesheet" href="static/css/ace.min.css"/>
    <link rel="stylesheet" href="static/css/ace-responsive.min.css"/>
    <link rel="stylesheet" href="static/css/ace-skins.min.css"/>

    <link rel="stylesheet" href="static/css/datepicker.css"/><!-- 日期框 -->
    <script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
    <script type="text/javascript" src="static/js/jquery.tips.js"></script>

    <script type="text/javascript">


        //保存
        function save() {
            if ($("#CLINIC").val() == "") {
                $("#CLINIC").tips({
                    side: 3,
                    msg: '请输入就诊中心',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#CLINIC").focus();
                return false;
            }
            if ($("#INSPECTION_DOCTOR").val() == "") {
                $("#INSPECTION_DOCTOR").tips({
                    side: 3,
                    msg: '请输入送检医生',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#INSPECTION_DOCTOR").focus();
                return false;
            }
            if ($("#NAME").val() == "") {
                $("#NAME").tips({
                    side: 3,
                    msg: '请输入姓名',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#NAME").focus();
                return false;
            }
            if ($("#AGE").val() == "") {
                $("#AGE").tips({
                    side: 3,
                    msg: '请输入年龄',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#AGE").focus();
                return false;
            }
            if ($("#SEX").val() == "") {
                $("#SEX").tips({
                    side: 3,
                    msg: '请输入性别',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#SEX").focus();
                return false;
            }
            if ($("#RELATIONSHIP_PATIENTS").val() == "") {
                $("#RELATIONSHIP_PATIENTS").tips({
                    side: 3,
                    msg: '请输入与患者关系',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#RELATIONSHIP_PATIENTS").focus();
                return false;
            }
            if ($("#DATE").val() == "") {
                $("#DATE").tips({
                    side: 3,
                    msg: '请输入收样日期',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#DATE").focus();
                return false;
            }
            if ($("#INTRODUCE").val() == "") {
                $("#INTRODUCE").tips({
                    side: 3,
                    msg: '请输入情况概述',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#INTRODUCE").focus();
                return false;
            }
            if ($("#DETAIL_INTRODUCE").val() == "") {
                $("#DETAIL_INTRODUCE").tips({
                    side: 3,
                    msg: '请输入详细情况',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#DETAIL_INTRODUCE").focus();
                return false;
            }
            if ($("#IS_BLOOD").val() == "") {
                $("#IS_BLOOD").tips({
                    side: 3,
                    msg: '请输入是否全血',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#IS_BLOOD").focus();
                return false;
            }
            if ($("#BLOOD_STORAGE_LOCATION").val() == "") {
                $("#BLOOD_STORAGE_LOCATION").tips({
                    side: 3,
                    msg: '请输入血液存放地点',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#BLOOD_STORAGE_LOCATION").focus();
                return false;
            }
            if ($("#DNA_CONCENTRATION").val() == "") {
                $("#DNA_CONCENTRATION").tips({
                    side: 3,
                    msg: '请输入DNA样本浓度',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#DNA_CONCENTRATION").focus();
                return false;
            }
            if ($("#A260").val() == "") {
                $("#A260").tips({
                    side: 3,
                    msg: '请输入260',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#A260").focus();
                return false;
            }
            if ($("#A280").val() == "") {
                $("#A280").tips({
                    side: 3,
                    msg: '请输入280',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#A280").focus();
                return false;
            }
            if ($("#A260280").val() == "") {
                $("#A260280").tips({
                    side: 3,
                    msg: '请输入260/280',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#A260280").focus();
                return false;
            }
            if ($("#A260230").val() == "") {
                $("#A260230").tips({
                    side: 3,
                    msg: '请输入260/230',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#A260230").focus();
                return false;
            }
            if ($("#DNA_RESULT").val() == "") {
                $("#DNA_RESULT").tips({
                    side: 3,
                    msg: '请输入DNA质检结果',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#DNA_RESULT").focus();
                return false;
            }
            if ($("#DNA_STORAGE_LOCATION").val() == "") {
                $("#DNA_STORAGE_LOCATION").tips({
                    side: 3,
                    msg: '请输入样本存放位置',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#DNA_STORAGE_LOCATION").focus();
                return false;
            }
            if ($("#GENETIC_TESTING_ITEMS").val() == "") {
                $("#GENETIC_TESTING_ITEMS").tips({
                    side: 3,
                    msg: '请输入遗传检测相关项目',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#GENETIC_TESTING_ITEMS").focus();
                return false;
            }
            if ($("#CANDIDATEGENE_ONE").val() == "") {
                $("#CANDIDATEGENE_ONE").tips({
                    side: 3,
                    msg: '请输入候选基因一',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#CANDIDATEGENE_ONE").focus();
                return false;
            }
            if ($("#VALIDATIONOPRIMERSEQUENCE_ONE").val() == "") {
                $("#VALIDATIONOPRIMERSEQUENCE_ONE").tips({
                    side: 3,
                    msg: '请输入验证引无序列一',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#VALIDATIONOPRIMERSEQUENCE_ONE").focus();
                return false;
            }
            if ($("#CANDIDATEGENE_TWO").val() == "") {
                $("#CANDIDATEGENE_TWO").tips({
                    side: 3,
                    msg: '请输入候选基因二',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#CANDIDATEGENE_TWO").focus();
                return false;
            }
            if ($("#VALIDATIONOPRIMERSEQUENCE_TWO").val() == "") {
                $("#VALIDATIONOPRIMERSEQUENCE_TWO").tips({
                    side: 3,
                    msg: '请输入验证引物序列二',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#VALIDATIONOPRIMERSEQUENCE_TWO").focus();
                return false;
            }
            if ($("#CANDIDATEGENE_THREE").val() == "") {
                $("#CANDIDATEGENE_THREE").tips({
                    side: 3,
                    msg: '请输入候选基因三',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#CANDIDATEGENE_THREE").focus();
                return false;
            }
            if ($("#VALIDATIONOPRIMERSEQUENCE_THREE").val() == "") {
                $("#VALIDATIONOPRIMERSEQUENCE_THREE").tips({
                    side: 3,
                    msg: '请输入验证引物序列三',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#VALIDATIONOPRIMERSEQUENCE_THREE").focus();
                return false;
            }
            $("#Form").submit();
            $("#zhongxin").hide();
            $("#zhongxin2").show();
        }

    </script>
</head>
<body>
<form action="informationinput/${msg }.do" name="Form" id="Form" method="post">
    <input type="hidden" name="INFORMATIONINPUT_ID" id="INFORMATIONINPUT_ID" value="${pd.INFORMATIONINPUT_ID}"/>
    <div id="zhongxin">
        <table id="table_report" class="table table-striped table-bordered table-hover">
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">就诊中心:</td>
                <td><input type="text" name="CLINIC" id="CLINIC" value="${pd.CLINIC}" maxlength="32"
                           placeholder="这里输入就诊中心" title="就诊中心"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">送检医生:</td>
                <td><input type="text" name="INSPECTION_DOCTOR" id="INSPECTION_DOCTOR" value="${pd.INSPECTION_DOCTOR}"
                           maxlength="32" placeholder="这里输入送检医生" title="送检医生"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">姓名:</td>
                <td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="32" placeholder="这里输入姓名"
                           title="姓名"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">年龄:</td>
                <td><input type="text" name="AGE" id="AGE" value="${pd.AGE}" maxlength="32" placeholder="这里输入年龄"
                           title="年龄"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">性别:</td>
                <td>
                    <select class="chzn-select" name="SEX" id="SEX" data-placeholder="请选择性别" style="vertical-align:top;">
                        <option value=""></option>
                        <option value="1"  <c:if test="${pd.SEX == '1' }">selected</c:if> >男
                        </option>
                        <option value="2"  <c:if test="${pd.SEX == '2' }">selected</c:if> >女
                        </option>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">与患者关系:</td>
                <td><input type="text" name="RELATIONSHIP_PATIENTS" id="RELATIONSHIP_PATIENTS"
                           value="${pd.RELATIONSHIP_PATIENTS}" maxlength="32" placeholder="这里输入与患者关系" title="与患者关系"/>
                </td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">收样日期:</td>
                <td><input class="span10 date-picker" name="DATE" id="DATE"
                           value="${pd.DATE}" type="text" data-date-format="yyyy-mm-dd"
                           readonly="readonly" style="width:205px;" placeholder="收样日期"/>
                </td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">情况概述:</td>
                <td><input type="text" name="INTRODUCE" id="INTRODUCE" value="${pd.INTRODUCE}" maxlength="32"
                           placeholder="这里输入情况概述" title="情况概述"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">详细情况:</td>
                <td><input type="text" name="DETAIL_INTRODUCE" id="DETAIL_INTRODUCE" value="${pd.DETAIL_INTRODUCE}"
                           maxlength="32" placeholder="这里输入详细情况" title="详细情况"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">是否全血:</td>
                <td>
                    <select class="chzn-select" name="IS_BLOOD" id="IS_BLOOD"  data-placeholder="请选择是否全血" style="vertical-align:top;">
                        <option value=""></option>
                        <option value="1" <c:if test="${pd.IS_BLOOD == '1' }">selected</c:if> >是
                        </option>
                        <option value="2" <c:if test="${pd.IS_BLOOD == '2' }">selected</c:if> >否
                        </option>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">血液存放地点:</td>
                <td><input type="text" name="BLOOD_STORAGE_LOCATION" id="BLOOD_STORAGE_LOCATION"
                           value="${pd.BLOOD_STORAGE_LOCATION}" maxlength="32" placeholder="这里输入血液存放地点" title="血液存放地点"/>
                </td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">DNA样本浓度:</td>
                <td><input type="text" name="DNA_CONCENTRATION" id="DNA_CONCENTRATION" value="${pd.DNA_CONCENTRATION}"
                           maxlength="32" placeholder="这里输入DNA样本浓度" title="DNA样本浓度"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">260:</td>
                <td><input type="text" name="A260" id="A260" value="${pd.A260}" maxlength="32" placeholder="这里输入260"
                           title="260"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">280:</td>
                <td><input type="text" name="A280" id="A280" value="${pd.A280}" maxlength="32" placeholder="这里输入280"
                           title="280"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">260/280:</td>
                <td><input type="text" name="A260/280" id="A260/280" value="${pd.A260280}" maxlength="32"
                           placeholder="这里输入260/280" title="260/280"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">260/230:</td>
                <td><input type="text" name="A260/230" id="A260/230" value="${pd.A260230}" maxlength="32"
                           placeholder="这里输入260/230" title="260/230"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">DNA质检结果:</td>
                <td><input type="text" name="DNA_RESULT" id="DNA_RESULT" value="${pd.DNA_RESULT}" maxlength="32"
                           placeholder="这里输入DNA质检结果" title="DNA质检结果"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">样本存放位置:</td>
                <td><input type="text" name="DNA_STORAGE_LOCATION" id="DNA_STORAGE_LOCATION"
                           value="${pd.DNA_STORAGE_LOCATION}" maxlength="32" placeholder="这里输入样本存放位置" title="样本存放位置"/>
                </td>
            </tr>
            <tr>
                <td style="width:120px;text-align: right;padding-top: 13px;">遗传检测相关项目:</td>

                <td><select class="chzn-select" name="GENETIC_TESTING_ITEMS" id="GENETIC_TESTING_ITEMS"  data-placeholder="遗传检测相关项目" style="vertical-align:top;">
                    <option value=""></option>
                    <option value="1" <c:if test="${pd.GENETIC_TESTING_ITEMS == '1' }">selected</c:if> >全外测序</option>
                    <option value="2" <c:if test="${pd.GENETIC_TESTING_ITEMS == '2' }">selected</c:if> >Sanger测序</option>
                    <option value="3" <c:if test="${pd.GENETIC_TESTING_ITEMS == '3' }">selected</c:if> >全外/Sanger</option>
                </select></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">候选基因一:</td>
                <td><input type="text" name="CANDIDATEGENE_ONE" id="CANDIDATEGENE_ONE" value="${pd.CANDIDATEGENE_ONE}"
                           maxlength="32" placeholder="这里输入候选基因一" title="候选基因一"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">验证引无序列一:</td>
                <td><input type="text" name="VALIDATIONOPRIMERSEQUENCE_ONE" id="VALIDATIONOPRIMERSEQUENCE_ONE"
                           value="${pd.VALIDATIONOPRIMERSEQUENCE_ONE}" maxlength="32" placeholder="这里输入验证引无序列一"
                           title="验证引无序列一"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">候选基因二:</td>
                <td><input type="text" name="CANDIDATEGENE_TWO" id="CANDIDATEGENE_TWO" value="${pd.CANDIDATEGENE_TWO}"
                           maxlength="32" placeholder="这里输入候选基因二" title="候选基因二"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">验证引物序列二:</td>
                <td><input type="text" name="VALIDATIONOPRIMERSEQUENCE_TWO" id="VALIDATIONOPRIMERSEQUENCE_TWO"
                           value="${pd.VALIDATIONOPRIMERSEQUENCE_TWO}" maxlength="32" placeholder="这里输入验证引物序列二"
                           title="验证引物序列二"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">候选基因三:</td>
                <td><input type="text" name="CANDIDATEGENE_THREE" id="CANDIDATEGENE_THREE"
                           value="${pd.CANDIDATEGENE_THREE}" maxlength="32" placeholder="这里输入候选基因三" title="候选基因三"/></td>
            </tr>
            <tr>
                <td style="width:90px;text-align: right;padding-top: 13px;">验证引物序列三:</td>
                <td><input type="text" name="VALIDATIONOPRIMERSEQUENCE_THREE" id="VALIDATIONOPRIMERSEQUENCE_THREE"
                           value="${pd.VALIDATIONOPRIMERSEQUENCE_THREE}" maxlength="32" placeholder="这里输入验证引物序列三"
                           title="验证引物序列三"/></td>
            </tr>
            <tr>
                <td style="text-align: center;" colspan="10">
                    <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
                    <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
                </td>
            </tr>
        </table>
    </div>

    <div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img
            src="static/images/jiazai.gif"/><br/><h4 class="lighter block green">提交中...</h4></div>

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
    $(function () {

        //单选框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect: true});

        //日期框
        $('.date-picker').datepicker();

    });

</script>
</body>
</html>