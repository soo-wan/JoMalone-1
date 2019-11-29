package kh.jomalone.Util;

import java.math.BigInteger;
import java.security.MessageDigest;

public class encrypt {
	public static String encrypt(String input) throws Exception {
	      MessageDigest digest = MessageDigest.getInstance("SHA-256");
	      digest.reset();
	      digest.update(input.getBytes("utf8"));
	      String result = String.format("%064x", new BigInteger(1, digest.digest()));
	      return result;
	   }
}
