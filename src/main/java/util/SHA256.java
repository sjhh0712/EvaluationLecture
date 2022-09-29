package util;

import java.security.MessageDigest;

public class SHA256 {
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256"); // 사용자가 입력한 값을 SHA-256으로 적용
			byte[] salt = "Hello This is Salt.".getBytes();// SHA만 적용하면 해킹당할 가능성이 있기때문에 salt값을 적용
			digest.reset();
			digest.update(salt);// salt 적용
			byte[] chars = digest.digest(input.getBytes("UTF-8")); // 해시를 적용한 값을 문자열로 담아줌
			for(int i = 0; i < chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) {
					result.append("0");
				}
				result.append(hex);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
}
