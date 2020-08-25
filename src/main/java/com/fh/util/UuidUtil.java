package com.fh.util;

import java.util.UUID;

public class UuidUtil {

	public static String get32UUID() {
		//Int型数字
		Integer orderId=UUID.randomUUID().toString().hashCode();
		orderId = orderId < 0 ? -orderId : orderId; //String.hashCode() 值会为空
		return orderId.toString();

		//32位的UUID
		/*String uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");
		return uuid;*/
	}

	public static void main(String[] args) {
		System.out.println(get32UUID());
	}
}

