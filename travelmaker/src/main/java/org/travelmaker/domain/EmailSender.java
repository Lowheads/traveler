package org.travelmaker.domain;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;

public class EmailSender {

	 @Autowired
     protected JavaMailSender  mailSender;
     public void SendEmail(Email email) throws Exception { // 이메일 발송
          
    	 // 임시 비밀번호 메일
         MimeMessage msg = mailSender.createMimeMessage();
         try {
             msg.setSubject(email.getSubject()); // 제목
             msg.setText(email.getContent()); // 내용
             msg.setRecipients(MimeMessage.RecipientType.TO , InternetAddress.parse(email.getReceiver())); //받는이
            
         }catch(MessagingException e) {
             System.out.println("MessagingException");
             e.printStackTrace();
         }
         try {
             mailSender.send(msg);
         }catch(MailException e) {
             System.out.println("MailException발생");
             e.printStackTrace();
         }
     }
}
