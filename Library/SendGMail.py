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