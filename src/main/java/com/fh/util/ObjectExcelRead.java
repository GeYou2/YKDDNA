package com.fh.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


/**
 * 从EXCEL导入到数据库
 * 创建人：FH 创建时间：2014年12月23日
 */
public class ObjectExcelRead {

    /**
     * @param filepath //文件路径
     * @param filename //文件名
     * @param startrow //开始行号
     * @param startcol //开始列号
     * @param sheetnum //sheet
     * @return list
     */
    public static List<Object> readExcel(String filepath, String filename, int startrow, int startcol, int sheetnum) {
        List<Object> varList = new ArrayList<Object>();

        try {
            File target = new File(filepath, filename);
            FileInputStream fi = new FileInputStream(target);
            HSSFWorkbook wb = new HSSFWorkbook(fi);
            HSSFSheet sheet = wb.getSheetAt(sheetnum);                    //sheet 从0开始
            int rowNum = sheet.getLastRowNum() + 1;                    //取得最后一行的行号

            for (int i = startrow; i < rowNum; i++) {                    //行循环开始

                PageData varpd = new PageData();
                HSSFRow row = sheet.getRow(i);                            //行
                int cellNum = row.getLastCellNum();                    //每行的最后一个单元格位置

                for (int j = startcol; j < cellNum; j++) {                //列循环开始

                    HSSFCell cell = row.getCell(Short.parseShort(j + ""));
                    String cellValue = null;
                    if (null != cell) {
                        switch (cell.getCellType()) {                    // 判断excel单元格内容的格式，并对其进行转换，以便插入数据库
                            case 0:
                                cellValue = String.valueOf((int) cell.getNumericCellValue());
                                break;
                            case 1:
                                cellValue = cell.getStringCellValue();
                                break;
                            case 2:
                                cellValue = cell.getNumericCellValue() + "";
                                // cellValue = String.valueOf(cell.getDateCellValue());
                                break;
                            case 3:
                                cellValue = "";
                                break;
                            case 4:
                                cellValue = String.valueOf(cell.getBooleanCellValue());
                                break;
                            case 5:
                                cellValue = String.valueOf(cell.getErrorCellValue());
                                break;
                        }
                    } else {
                        cellValue = "";
                    }

                    varpd.put("var" + j, cellValue);

                }
                varList.add(varpd);
            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return varList;
    }

    /**
     * @return java.util.Map
     * @Author maokaixuan
     * @Description //读取Excel数据内容
     * @Date 13:24 2019/2/16
     * @Param [is]
     **/
    public static List<Object> readExcelContent(String filepath, String filename) {
        List<Object> varList = new ArrayList<Object>();
        Workbook wb = null;
        try {
            wb = WorkbookFactory.create(new File(filepath,filename));

            Sheet sheet = wb.getSheetAt(0);
            // 得到总行数
            int rowNum = getExcelRealRow(sheet);
            if (rowNum < 1) {
                System.out.println("导入文件数据为空！");
            }
            //由于第0行是表头在这里表数据索引从1开始
            Row row = sheet.getRow(1);
            int colNum = row.getPhysicalNumberOfCells();
            // 正文内容应该从第二行开始,第一行为表头的标题
            for (int i = 1; i <= rowNum; i++) {
                PageData varpd = new PageData();
                String[] strValue = new String[colNum];
                row = sheet.getRow(i);
                int j = 0;
                while (j < colNum) {
                    strValue[j] = getCellFormatValue(row.getCell((short) j)).trim();
                    varpd.put("var" + j, strValue[j]);
                    j++;
                }
                varList.add(varpd);
            }
        } catch (InvalidFormatException e) {
            System.out.println(e);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return varList;
    }

    // 获取Excel表的真实行数
    static int getExcelRealRow(Sheet sheet) {
        boolean flag = false;
        for (int i = 1; i <= sheet.getLastRowNum(); ) {
            Row r = sheet.getRow(i);
            if (r == null) {
                // 如果是空行（即没有任何数据、格式），直接把它以下的数据往上移动
                sheet.shiftRows(i + 1, sheet.getLastRowNum(), -1);
                continue;
            }
            flag = false;
            for (Cell c : r) {
                if (c.getCellType() != Cell.CELL_TYPE_BLANK) {
                    flag = true;
                    break;
                }
            }
            if (flag) {
                i++;
                continue;
            } else {
                // 如果是空白行（即可能没有数据，但是有一定格式）
                if (i == sheet.getLastRowNum())// 如果到了最后一行，直接将那一行remove掉
                    sheet.removeRow(r);
                else//如果还没到最后一行，则数据往上移一行
                    sheet.shiftRows(i + 1, sheet.getLastRowNum(), -1);
            }
        }
        return sheet.getLastRowNum();
    }

    /**
     * @return java.lang.String
     * @Author maokaixuan
     * @Description //根据HSSFCell类型设置数据
     * @Date 17:51 2019/3/3
     * @Param [cell]
     **/
    private static String getCellFormatValue(Cell cell) {
        String cellvalue = "";
        if (cell != null) {
            // 判断当前Cell的Type
            switch (cell.getCellType()) {
                // 如果当前Cell的Type为NUMERIC
                case HSSFCell.CELL_TYPE_NUMERIC:
                case HSSFCell.CELL_TYPE_FORMULA: {
                    // 判断当前的cell是否为Date
                    if (HSSFDateUtil.isCellDateFormatted(cell)) {
                        Date date = cell.getDateCellValue();
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        cellvalue = sdf.format(date);
                    }
                    // 如果是纯数字
                    else {
                        // 取得当前Cell的数值
                        cell.setCellType(Cell.CELL_TYPE_STRING);
                        cellvalue = String.valueOf(cell.getStringCellValue().trim());
                    }
                    break;
                }
                // 如果当前Cell的Type为STRIN
                case HSSFCell.CELL_TYPE_STRING:
                    // 取得当前的Cell字符串
                    cellvalue = cell.getRichStringCellValue().getString();
                    break;
                // 默认的Cell值
                default:
                    cellvalue = " ";
            }
        } else {
            cellvalue = "";
        }
        return cellvalue;

    }
}
