package com.front.utils;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {
	 public static String getMD5Str(String str) {
	        byte[] digest = null;
	        try {
	            MessageDigest md5 = MessageDigest.getInstance("md5");
	            digest  = md5.digest(str.getBytes("utf-8"));
	        } catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	        } catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	        }
	        //16是表示转换为16进制数
	        String md5Str = new BigInteger(1, digest).toString(16);
	        return md5Str;
	    }


	 public static void main(String[] args) {
		 String md51 = MD5Util.getMD5Str("JavaEE");//JavaEE为密码：md5加密后的数据：a1212a200973d24c465cfde2c3e6b5ed
		 System.out.println("MD5Util JavaEE = " + md51);
		 String md52 = MD5Util.getMD5Str("lunan");
		 System.out.println("MD5Util lunan = " + md52);
		 String md53 = MD5Util.getMD5Str("billy");
		 System.out.println("MD5Util billy = " + md53);
	}

}
