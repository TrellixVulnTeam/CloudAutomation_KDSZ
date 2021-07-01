import win32com.client as client
import pathlib
import time


def check_email_header_text(url):
    if "us" in url:
        header_text="In addition to uploading a file, you may also e-mail it to lcp.dev1@lexmark.com to place it in your print queue."
        return header_text
    else:
        header_text = "In addition to uploading a file, you may also e-mail it to lcp.banana@lexmark.com to place it in your print queue."
        return header_text

def send_email_singleattachment_all(env,file):
    global to_address, from_address
    if 'us' in env and 'dev' in env:
        to_address="lcp.dev1@lexmark.com"
        from_address="no-reply@cloud.onelxk.co"
    elif 'eu' in env and 'dev' in env:
        to_address="lcp.banana@lexmark.com"
        from_address = "no-reply@cloud.onelxk.co"
    # elif 'us' in env and 'dev' in env:
    #     to_address="lcp.dev1@lexmark.com"
    #     from_address="no-reply@dev.cloud.onelxk.co"

    filename = "C:/Users/neogis/D Drive/FREEDOM/Python/STL_Automation/Attachments/" + file
    file_path_txt = pathlib.Path(filename)
    file_name = file_path_txt.name
    print(file_name)
    file_path_txt = str(file_path_txt.absolute())

    outlook = client.Dispatch('Outlook.Application')
    message = outlook.CreateItem(0)
    message.Display()
    message.To = to_address
    message.Subject = "Test Mail"
    message.Attachments.Add(file_path_txt)
    message.Body = "This is a email sent to verify email job submissions"
    time.sleep(5)
    message.Send()

    time.sleep(5)

    namespace = outlook.GetNameSpace('MAPI')
    inbox = namespace.GetDefaultFolder(6)
    message = inbox.Items
    last_message = message.GetLast()
    #print(last_message.SenderName)
    last_message_sender = last_message.SenderName
    #print(last_message_sender)
    email_status = last_message.Subject

    while last_message_sender not in from_address:
        time.sleep(5)
        last_message = message.GetLast()
        last_message_sender = last_message.SenderName

    if last_message_sender == from_address:
        if last_message.Subject == 'Email received - all documents processed':
            print("Email submission successful")
            body = last_message.Body
            if file_name in body:
                print("Attachment processed")
                last_message.Delete()
            else:
                print("Attachment removed")
                last_message.Delete()
        else:
            print("Email submission failed")
            last_message.Delete()
    return email_status



def blank_subject(env):
    global email_status, to_address, from_address

    if 'us' in env and 'dev' in env:
        to_address="lcp.dev2@lexmark.com"
        from_address="no-reply@cloud.onelxk.co"
    elif 'eu' in env and 'dev' in env:
        to_address="lcp.dev1@lexmark.com"
        from_address = "no-reply@cloud.onelxk.co"
    outlook = client.Dispatch('Outlook.Application')
    message = outlook.CreateItem(0)
    message.Display()
    message.To = to_address
    message.Subject = " "
    message.Body = "This is a blank subject mail"
    time.sleep(5)
    message.Send()
    time.sleep(5)

    namespace = outlook.GetNameSpace('MAPI')
    inbox = namespace.GetDefaultFolder(6)
    message = inbox.Items
    last_message = message.GetLast()
    last_message_sender = last_message.SenderName

    while last_message_sender not in from_address:
        time.sleep(5)
        last_message = message.GetLast()
        last_message_sender = last_message.SenderName
        email_status=last_message.Subject

    if last_message_sender == from_address:
        if last_message.Subject == 'Email received - all documents processed':
            print("Email submission successful")
            body = last_message.Body
            last_message_subject = "emailBody.html"
            if last_message_subject in body:
                print("Attachment processed")
            else:
                print("Attachment removed")

        else:
            print("Email submission failed")
        last_message.Delete()
    return email_status


def blank_body(env):
    global to_address, from_address
    if 'us' in env and 'dev' in env:
        to_address="lcp.dev1@lexmark.com"
        from_address="no-reply@cloud.onelxk.co"
    elif 'eu' in env and 'dev' in env:
        to_address="lcp.banana@lexmark.com"
        from_address = "no-reply@cloud.onelxk.co"
    outlook = client.Dispatch('Outlook.Application')
    message = outlook.CreateItem(0)
    message.Display()
    message.To = to_address
    message.Subject = "Blank Mail"
    message.Body = ""
    time.sleep(5)
    message.Send()
    time.sleep(5)

    namespace = outlook.GetNameSpace('MAPI')
    inbox = namespace.GetDefaultFolder(6)
    message = inbox.Items
    last_message = message.GetLast()
    last_message_sender = last_message.SenderName
    email_status = last_message.Subject

    while last_message_sender not in from_address:
        time.sleep(5)
        last_message = message.GetLast()
        last_message_sender = last_message.SenderName

    if last_message_sender == from_address:
        if last_message.Subject == 'Email received - all documents processed':
            last_message.Delete()
        else:
            print("Email submission failed")
            last_message.Delete()
    return email_status

send_email_singleattachment_all("http://dev.us.cloud.onelxk.co","Attachment.txt")