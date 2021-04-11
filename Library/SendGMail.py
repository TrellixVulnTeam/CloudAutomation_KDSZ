import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders

from_address="stlcpmautomation@gmail.com"
to_address="sravantesh.neogi@lexmark.com"

msg=MIMEMultipart()

msg['From']=from_address
msg['To']=to_address
msg['Subject']="Mail sent using python"
body="This is a test email sent using python"

msg.attach(MIMEText(body,'plain'))
filename="Attachment.txt"
attachment=open(r"C:\Users\neogis\D Drive\FREEDOM\Python\CloudAutomation\Attachments\Attachment.txt","rb")

p=MIMEBase('application','octet-stream')

p.set_payload((attachment).read())
encoders.encode_base64(p)

p.add_header('Content-Disposition',"attachment;filename=%s" % filename)
msg.attach(p)


s=smtplib.SMTP('smtp.gmail.com',587)

s.starttls()
s.login(from_address,"Stlcpm@1234")
text=msg.as_string()

s.sendmail(from_address,to_address,text)

s.quit()



































#
# import smtplib
# from email.mime.text import MIMEText
# from email.mime.multipart import MIMEMultipart
# from email.mime.base import MIMEBase
# from email import encoders
# import os.path
#
#
# def send_email(email_recipient,
#                email_subject,
#                email_message,
#                attachment_location = ''):
#
#     email_sender = 'sravantesh.neogi@lexmark.com'
#
#     msg = MIMEMultipart()
#     msg['From'] = email_sender
#     msg['To'] = email_recipient
#     msg['Subject'] = email_subject
#
#     msg.attach(MIMEText(email_message, 'plain'))
#
#     if attachment_location != '':
#         filename = os.path.basename(attachment_location)
#         attachment = open(attachment_location, "rb")
#         part = MIMEBase('application', 'octet-stream')
#         part.set_payload(attachment.read())
#         encoders.encode_base64(part)
#         part.add_header('Content-Disposition',
#                         "attachment; filename= %s" % filename)
#         msg.attach(part)
#
#         server = smtplib.SMTP('smtp.office365.com', 587)
#         server.ehlo()
#         server.starttls()
#         server.login('sravantesh.neogi@lexmark.com', 'Hillview@69')
#         text = msg.as_string()
#         server.sendmail(email_sender, email_recipient, text)
#         print('email sent')
#         server.quit()
#
#
# send_email('sravantesh.neogi@lexmark.com',
#            'Happy New Year',
#            'We love Outlook',
#            'C:\\Users\\neogis\\D Drive\\FREEDOM\\Python\\CloudAutomation\\Attachments\\Attachment.txt')