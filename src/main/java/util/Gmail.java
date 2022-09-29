package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator{
	 @Override
	 protected PasswordAuthentication getPasswordAuthentication() {
		 return new PasswordAuthentication("sjhh0712@gmail.com", "lumyjnxylioxhlvj");
	 }
}
