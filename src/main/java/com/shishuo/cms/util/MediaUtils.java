
package com.shishuo.cms.util;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.imageio.ImageIO;


import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import com.shishuo.cms.constant.SystemConstant;

/**
 * @author Herbert
 * 
 */
public class MediaUtils {
	
	//private String uploadpath;

	/**
	 * 文件允许格式
	 */
	public static String[] FILE_TYPE = { ".rar", ".doc", ".docx", ".zip",
			".pdf", ".txt", ".swf", ".wmv" };

	/**
	 * 图片允许格式
	 */
	public static String[] PHOTO_TYPE = { ".gif", ".jpg", ".png", ".jpeg",
			".bmp" };

	public static boolean isFileType(String fileName, String[] typeArray) {
		for (String type : typeArray) {
			if (fileName.toLowerCase().endsWith(type)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 递归获得目录的所有地址
	 * 
	 * @param realpath
	 * @param files
	 * @param fileType
	 * @return
	 */
	public static List<java.io.File> getFiles(String realpath,
			List<File> files, String[] fileType) {
		File realFile = new File(realpath);
		if (realFile.isDirectory()) {
			File[] subfiles = realFile.listFiles();
			for (File file : subfiles) {
				if (file.isDirectory()) {
					getFiles(file.getAbsolutePath(), files, fileType);
				} else {
					if (isFileType(file.getName(), fileType)) {
						files.add(file);
					}
				}
			}
		}
		return files;
	}

	/**
	 * 得到文件上传的相对路径
	 * 
	 * @param fileName
	 *            文件名
	 * @return
	 */
	public static String getPath(String fileName) {
		SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd");
		String uploadPath = "upload"+ File.separator + formater.format(new Date()) + File.separator
				+ UUID.randomUUID().toString().replaceAll("-", "")
				+ getFileExt(fileName);
		return uploadPath;
	}

	/**
	 * 获取文件扩展名
	 * 
	 * @return string
	 */
	public static String getFileExt(String fileName) {
		return fileName.substring(fileName.lastIndexOf("."));
	}

	/**
	 * 删除物理文件
	 * 
	 * @param path
	 */
	public static void deleteFile(String path) {
		File file = new File(SystemConstant.SHISHUO_CMS_ROOT + path);
		file.delete();
	}

	public static Map<String,Object> saveImage(MultipartFile multipartFile, int x, int y, int desWidth,
											   int desHeight,int rotate) throws IOException {
		SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd");
		String path = "upload"+File.separator+"images"+File.separator + formater.format(new Date()) + File.separator
				+ UUID.randomUUID().toString().replaceAll("-", "") + ".jpg";
		File file = new File(SystemConstant.SHISHUO_CMS_ROOT + File.separator + path);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
		multipartFile.transferTo(file);
		if(desWidth>0&&desHeight>0) {
			imgCut(file, x, y, desWidth, desHeight, rotate);
		}
		resize(file);
		Map<String,Object> map = new HashMap<String,Object>(2);
		map.put("path",path.replace("\\","/"));
		map.put("size",(int)(file.length()/1024));
		return map;
	}

	/**
	 * @param multipartFile
	 * @return
	 */
	public static String save(MultipartFile multipartFile) throws IOException {
		SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd");
		String path = "upload"+File.separator + formater.format(new Date()) + File.separator
				+ UUID.randomUUID().toString().replaceAll("-", "")
				+ getFileExt(multipartFile.getOriginalFilename());
		path = path.replace("/",File.separator);
		File file = new File(SystemConstant.SHISHUO_CMS_ROOT + File.separator + path);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
		multipartFile.transferTo(file);
		return path;
	}

	private static void imgCut(File file, int x, int y, int desWidth, int desHeight,int rotate) {
		try {
			Image img;
			ImageFilter cropFilter;
			BufferedImage bi = ImageIO.read(file);
			int srcWidth = bi.getWidth();
			int srcHeight = bi.getHeight();
			if (srcWidth >= desWidth && srcHeight >= desHeight) {
				Image image = bi.getScaledInstance(srcWidth, srcHeight,Image.SCALE_DEFAULT);
				if(rotate!=0){
					bi = Rotate(image,rotate);
					image = bi.getScaledInstance(srcWidth, srcHeight,Image.SCALE_DEFAULT);
				}
				cropFilter = new CropImageFilter(x, y, desWidth, desHeight);
				img = Toolkit.getDefaultToolkit().createImage(
						new FilteredImageSource(image.getSource(), cropFilter));
				BufferedImage tag = new BufferedImage(desWidth, desHeight,
						BufferedImage.TYPE_INT_RGB);
				Graphics g = tag.getGraphics();
				g.drawImage(img, 0, 0, null);
				g.dispose();
				//输出文件
				ImageIO.write(tag, "JPEG", file);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static BufferedImage  Rotate(Image src, int angel) {
		int src_width = src.getWidth(null);
		int src_height = src.getHeight(null);
		// calculate the new image size
		Rectangle rect_des = CalcRotatedSize(new Rectangle(new Dimension(
				src_width, src_height)), angel);

		BufferedImage res = null;
		res = new BufferedImage(rect_des.width, rect_des.height,
				BufferedImage.TYPE_INT_RGB);
		Graphics2D g2 = res.createGraphics();
		// transform
		g2.translate((rect_des.width - src_width) / 2,
				(rect_des.height - src_height) / 2);
		g2.rotate(Math.toRadians(angel), src_width / 2, src_height / 2);

		g2.drawImage(src, null, null);
		return res;
	}

	private static Rectangle CalcRotatedSize(Rectangle src, int angel) {
		if (angel >= 90) {
			if(angel / 90 % 2 == 1){
				int temp = src.height;
				src.height = src.width;
				src.width = temp;
			}
			angel = angel % 90;
		}

		double r = Math.sqrt(src.height * src.height + src.width * src.width) / 2;
		double len = 2 * Math.sin(Math.toRadians(angel) / 2) * r;
		double angel_alpha = (Math.PI - Math.toRadians(angel)) / 2;
		double angel_dalta_width = Math.atan((double) src.height / src.width);
		double angel_dalta_height = Math.atan((double) src.width / src.height);

		int len_dalta_width = (int) (len * Math.cos(Math.PI - angel_alpha
				- angel_dalta_width));
		int len_dalta_height = (int) (len * Math.cos(Math.PI - angel_alpha
				- angel_dalta_height));
		int des_width = src.width + len_dalta_width * 2;
		int des_height = src.height + len_dalta_height * 2;
		return new java.awt.Rectangle(new Dimension(des_width, des_height));
	}

	private static void resize(File file) throws IOException {

		int w = 0;
		int h = 0;
		Image img = ImageIO.read(file);
		int width = img.getWidth(null);    // 得到源图宽
		int height = img.getHeight(null);  // 得到源图长

		if(width>1200) {
			w = 1200;
			h = (int) (height * w / width);
			// SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
			BufferedImage image = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
			image.getGraphics().drawImage(img, 0, 0, w, h, null); // 绘制缩小后的图
			//FileOutputStream out = new FileOutputStream(file); // 输出到文件流
			// 可以正常实现bmp、png、gif转jpg
			//JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			//encoder.encode(image); // JPEG编码
			//out.close();
			ImageIO.write(image, "JPEG", file);
		}
	}

	/*public String getUploadpath() {
		return uploadpath;
	}

	public void setUploadpath(String uploadpath) {
		this.uploadpath = uploadpath;
	}*/
}
