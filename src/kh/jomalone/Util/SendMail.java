package kh.jomalone.Util;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {
	public void pwsendMail(String toEmail, String tempPw) {
		final String user = "gahae37"; 					// 보내는사람 아이디
		final String password = "pghpgh34215615"; 							//보내는사람 비밀번호
		
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.naver.com");			//구글 메일이면 smtp.gmail.com
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.naver.com");
		
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });
		
		try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));

            //메일 수신자
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            // Subject
            message.setSubject("JoMalone임시비밀번호 입니다."); //제목 적어주는칸
     
            // Text
    		StringBuilder sb = new StringBuilder();
    		sb.append("안녕하세요. JoMalone입니다. 고객님의 임시비밀번호는 " + tempPw + "입니다.\n");
    		sb.append("임시비밀번호로 로그인 후 마이페이지에서 비밀번호를 변경해 주시기 바랍니다.");
    		message.setText(sb.toString());
            
            // send the message
            Transport.send(message); //전송
            System.out.println("message sent successfully...");
        } catch (AddressException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
	}
	
	
	public void sendMail(String toEmail, String subject, String msg) {	//받는사람  / 제목 / 내용 
		final String user = "jomalonechoi@gmail.com"; 					// 보내는사람 아이디
		final String password = "jomalone123!@#"; 							// 보내는사람 비밀번호
		
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");			//구글계정이면  smtp.gmail.com
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

		try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));

            //수신자 설정
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail)); 

            // Subject
            message.setSubject(subject); 

            // Text
            message.setText(msg);    

            // send the message
            Transport.send(message); //// 전송
            System.out.println("message sent successfully...");
        } catch (AddressException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            
        }

	}
}
