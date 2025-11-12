import org.apache.ofbiz.service.ServiceUtil
import org.apache.ofbiz.base.util.UtilMisc
import org.apache.ofbiz.base.util.UtilProperties

// Event to send email

    // Get dispatcher & userLogin
  

    // Read values from request or hardcode
    def emailTo = parameters.emailTo ?: "test@example.com"
    def subject = parameters.subject ?: "Test Email from OFBiz"
    def body = parameters.body ?: "Hello, this is a test email sent via OFBiz."

    // Call OFBiz's sendMail service
    def result = dispatcher.runSync("sendMail", [
        userLogin  : userLogin,
        sendTo     : emailTo,
        sendFrom   : UtilProperties.getPropertyValue("general", "mail.from"), // configured in general.properties
        subject    : subject,
        body       : body,
        contentType: "text/html"
    ])
