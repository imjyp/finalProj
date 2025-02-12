package kr.or.ddit.config;

import java.util.Properties;
import jakarta.mail.internet.InternetAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MailService {

    @Autowired
    private JavaMailSender javaMailSender;
    
    private final String senderEmail = "404notcoffee@gmail.com"; 
    

    /**
     * 임시 비밀번호 메일 생성
     */
    public MimeMessage createMail(String recipientEmail, String pwd) throws MessagingException {
        MimeMessage message = javaMailSender.createMimeMessage();
        
        try {
        	 message.setFrom(new InternetAddress(senderEmail, "CAFE@BEAN")); // 발신자 설정
             message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(recipientEmail)); // 수신자 설정
            message.setSubject("🔐 CAFE@BEAN - 임시 비밀번호 안내");

            String body = "<h3>임시 비밀번호 안내</h3>";
            body += "<h1 style='color: blue;'>" + pwd + "</h1>";
            body += "<p>마이페이지에서 비밀번호를 변경해주세요.</p>";

            message.setText(body, "UTF-8", "html");
        } catch (Exception e) {
            throw new MessagingException("이메일 생성 중 오류 발생: " + e.getMessage());
        }

        return message;
    }
    
    public String sendSimpleMessage(String sendEmail, String pwd) throws MessagingException {

        MimeMessage message = createMail(sendEmail, pwd); // 메일 생성
        try {
            javaMailSender.send(message); // 메일 발송
        } catch (MailException e) {
            e.printStackTrace();
            throw new IllegalArgumentException("메일 발송 중 오류가 발생했습니다.");
        }

        return pwd; 
    }

    /**
     * 권한 변경 알림 이메일 생성
     */
    public MimeMessage createMail2(String recipientEmail) throws MessagingException {
        if (recipientEmail == null || recipientEmail.trim().isEmpty()) {
            throw new MessagingException("🚨 이메일 주소가 올바르지 않습니다. (null 또는 빈 값)");
        }

        // 공백 제거한 이메일 주소
        String cleanedEmail = recipientEmail.trim();

        MimeMessage message = javaMailSender.createMimeMessage();

        try {
            message.setFrom(new InternetAddress(senderEmail, "CAFE@BEAN")); // 발신자
            message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(cleanedEmail)); // 수신자
            message.setSubject("📢 권한 변경 안내");

            String body = "<h2>📢 권한 변경 안내</h2>";
            body += "<p>안녕하세요, " + cleanedEmail + "님.</p>";
            body += "<p>귀하의 계정 권한이 성공적으로 변경되었습니다.</p>";
            body += "<p>변경된 권한으로 <a href='http://localhost:8070/login'>로그인</a> 후 이용해 주세요.</p>";
            body += "<br/>";
            body += "<p>감사합니다.</p>";

            message.setText(body, "UTF-8", "html");
        } catch (Exception e) {
            throw new MessagingException("이메일 생성 중 오류 발생: " + e.getMessage());
        }

        return message;
    }

    /**
     * 이메일 발송
     */
    public void sendAuth(String recipientEmail) throws MessagingException {
        MimeMessage message = createMail2(recipientEmail);
        try {
            javaMailSender.send(message);
            System.out.println("✅ 권한 변경 이메일 전송 완료 -> " + recipientEmail);
        } catch (MailException e) {
            System.err.println("🚨 이메일 전송 실패 -> " + recipientEmail);
            e.printStackTrace();
            throw new MessagingException("메일 발송 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
}
