package com.shishuo.cms.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.ConnectException;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;

/**
 * 用OpenOffice将Office文档转换为PDF文档
 *
 */
public class Office2PDFUtil {

	//private String OpenOffice_HOME = PropertyUtils.getValue("OpenOffice_HOME");

	/**
	 * 将Office文档转换为PDF. 运行该函数需要用到OpenOffice, OpenOffice下载地址为
	 * <pre>
	 * 方法示例:
	 * String sourcePath = "F:\\office\\source.doc";
	 * String destFile = "F:\\pdf\\dest.pdf";
	 * Converter.office2PDF(sourcePath, destFile);
	 * </pre>
	 *
	 * @param sourceFile
	 *            源文件, 绝对路径. 可以是Office2003-2007全部格式的文档, Office2010的没测试. 包括.doc,
	 *            .docx, .xls, .xlsx, .ppt, .pptx等. 示例: F:\\office\\source.doc
	 * @param destFile
	 *            目标文件. 绝对路径. 示例: F:\\pdf\\dest.pdf
	 * @return 操作成功与否的提示信息. 如果返回 -1, 表示找不到源文件, 或url.properties配置错误; 如果返回 0,
	 *         则表示操作成功; 返回1, 则表示转换失败
	 */
	public void office2PDF(String sourceFile, String destFile) throws Exception {
			File inputFile = new File(sourceFile);
			if (!inputFile.exists()) {
				throw new FileNotFoundException();
			}

			// 如果目标路径不存在, 则新建该路径
			File outputFile = new File(destFile);
			if (!outputFile.getParentFile().exists()) {
				outputFile.getParentFile().mkdirs();
			}

			/*
			 * 从url.properties文件中读取OpenOffice的安装根目录, OpenOffice_HOME对应的键值.
			 * 我的OpenOffice是安装在D:\Program Files\OpenOffice.org 3下面的, 如果大家的
			 * OpenOffice不是安装的这个目录下面，需要修改url.properties文件中的 OpenOffice_HOME的键值.
			 * 但是需要注意的是：要用"\\"代替"\",用"\:"代替":" . 如果大家嫌麻烦,
			 * 可以直接给OpenOffice_HOME变量赋值为自己OpenOffice的安装目录
			 */
			//if (OpenOffice_HOME == null) //java.net.ConnectException
			//	throw new FileNotFoundException();
			// 如果从文件中读取的URL地址最后一个字符不是 '\'，则添加'\'
			/*if (OpenOffice_HOME.charAt(OpenOffice_HOME.length() - 1) != '\\') {
				OpenOffice_HOME += "\\";
			}*/
			// 启动OpenOffice的服务
			//String command = OpenOffice_HOME + "program"+File.separator+"soffice.exe -headless -accept=\"socket,host=127.0.0.1,port=8100;urp;\" -nofirststartwizard";
			//Process pro = Runtime.getRuntime().exec(command);
			// connect to an OpenOffice.org instance running on port 8100
			OpenOfficeConnection connection = new SocketOpenOfficeConnection(
					"127.0.0.1", 8100);
			connection.connect();

			// convert
			DocumentConverter converter = new OpenOfficeDocumentConverter(
					connection);
			converter.convert(inputFile, outputFile);

			// close the connection
			connection.disconnect();
			// 关闭OpenOffice服务的进程
			//pro.destroy();
	}
}
