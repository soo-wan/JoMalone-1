package kh.jomalone.Util;

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
	public void sendMail(String toEamil) {
		final String user = "asdf@naver.com"; 					//�߽����� �̸��� ���̵� �Է�
		final String password = ""; 							//�߽��� �̸����� �н����带 �Է�
		
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.naver.com");			//�����ϰ�� smtp.gmail.com
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

            //�����ڸ����ּ�
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEamil));

            // Subject
            message.setSubject("������ �Է��ϼ���"); //���� ������ �Է�

            // Text
            message.setText("������ �Է��ϼ���");    //���� ������ �Է�

            // send the message
            Transport.send(message); ////����
            System.out.println("message sent successfully...");
        } catch (AddressException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
	}
	
	
	public void sendMail(String toEmail, String subject, String msg) {
		final String user = "asdf@naver.com"; 					//�߽����� �̸��� ���̵� �Է�
		final String password = ""; 							//�߽��� �̸����� �н����带 �Է�
		
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.naver.com");			//�����ϰ�� smtp.gmail.com
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

            //�����ڸ����ּ�
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail)); 

            // Subject
            message.setSubject(subject); 

            // Text
            message.setText(msg);    

            // send the message
            Transport.send(message); ////����
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
