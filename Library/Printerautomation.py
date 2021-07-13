import lxk_printer_device
import lxk_printer_device.webservices.automation
import lxk_printer_device.ews.webglue
from lxk_universal_panel_step import UPS
from lxk_universal_panel_step.core.universal_panel_step import TextInputUsingNumpad, AndroidUPS
import lxk_universal_panel_step
import time


def printer_automation(ip,pin,text):


    #ip_address = "10.195.6.123"
    print(ip)
    ups = UPS(printer_ip=ip)
    ups.initialize()
    time.sleep(2)
    ups.regex('do "press key KEYCODE_HOME"')
    time.sleep(5)

    # Click PIN login
    # ups.regex('Find widget "text-id=\'STRING_IDLEBUTTON_ID_1\'" do "press"')
    #ups.regex('Find widget "text-id=\'idle_text\'" do "press"')
    #time.sleep(5)
    ups.regex('on text "PIN Login" do "press" ')
    ups.regex('Find widget "text-id=\'pin_login_ui_pinvalue\'" Do "wait_until_found"')
    time.sleep(10)
    # Click Input text to bring keypad
    ups.regex('Find widget "text-id=\'pin_login_ui_pinvalue\'" do "press"')
    ups.regex('Find widget "text-id=\'DIALOG_OK_ID\'" Do "wait_until_found"')
    time.sleep(10)
    # Enter PIN and login
    lxk_universal_panel_step.core.universal_panel_step.type_text(pin)
    ups.regex('Find widget "text-id=\'DIALOG_OK_ID\'" do "press"')
    time.sleep(5)

    # Wait till Print Release Appears
    ups.regex('On text "Print Release" Do "wait_until_found"')
    ups.regex('On text "Print Release" Do "press"')
    time.sleep(10)
    # Wait till list view appears
    ups.regex('on text "Print" Do "wait_until_found"')

    # Check whether the job name as defined is shown in the list. If not found refresh and check again. If present,
    # then Print.
    while True:
        try:
            # text="Hello.txt"
            #ups.regex('Find Widget "resource-id=\'esf.printReleaseUi:id/action_settings\'" do "press"')
            #ups.regex('On text "Refresh" do "press"')
            time.sleep(7)
            ups_command = '''In area "resource-id='esf.printReleaseUi:id/lvFragMain'" On text "{}" Do "press"'''.format(
                text)
            ups.regex(ups_command)
            ups.regex('on text "Print" do "press"')
            time.sleep(10)
            ups.regex('on text "Print" Do "wait_until_found"')
            time.sleep(5)
            ups.regex('do "press key KEYCODE_BACK"')
            time.sleep(5)
            ups.regex('on text "sravantesh.neogi@lexmark.com" do "press" ')
            time.sleep(5)
            ups.regex('on text "Yes" do "press" ')
            time.sleep(2)
            print_status = 'True'
            return print_status
            #break
        except ValueError:
            print("Job name not found")
            print_status = 'False'
            return print_status

def printer_automation_delegate(user,ip,pin,text):
    #ip_address = "10.195.6.123"
    print(ip)
    ups = UPS(printer_ip=ip)
    ups.initialize()
    time.sleep(2)
    ups.regex('do "press key KEYCODE_HOME"')
    time.sleep(2)

    # Click PIN login
    # ups.regex('Find widget "text-id=\'STRING_IDLEBUTTON_ID_1\'" do "press"')
    #ups.regex('Find widget "text-id=\'idle_text\'" do "press"')
    #time.sleep(5)
    ups.regex('on text "PIN Login" do "press" ')
    ups.regex('Find widget "text-id=\'pin_login_ui_pinvalue\'" Do "wait_until_found"')
    time.sleep(2)
    # Click Input text to bring keypad
    ups.regex('Find widget "text-id=\'pin_login_ui_pinvalue\'" do "press"')
    ups.regex('Find widget "text-id=\'DIALOG_OK_ID\'" Do "wait_until_found"')
    time.sleep(2)
    # Enter PIN and login
    lxk_universal_panel_step.core.universal_panel_step.type_text(pin)
    ups.regex('Find widget "text-id=\'DIALOG_OK_ID\'" do "press"')
    time.sleep(2)

    # Wait till Print Release Appears
    ups.regex('On text "Print Release" Do "wait_until_found"')
    ups.regex('On text "Print Release" Do "press"')
    time.sleep(2)
    # Wait till list view appears
    #ups.regex('on text "Print" Do "wait_until_found"')

    # Check whether the job name as defined is shown in the list. If not found refresh and check again. If present,
    # then Print.
    while True:
        try:
            # text="Hello.txt"
            #ups.regex('Find Widget "resource-id=\'esf.printReleaseUi:id/action_settings\'" do "press"')
            #ups.regex('On text "Refresh" do "press"')
            time.sleep(2)
            #ups.regex('on text "sravantesh.neogi@lexmark.com" do "press"')
            ups.regex('on text "{}" Do "press"'.format(user))
            time.sleep(2)
            ups_command = '''In area "resource-id='esf.printReleaseUi:id/lvFragMain'" On text "{}" Do "press"'''.format(text)
            ups.regex(ups_command)
            ups.regex('on text "Print" do "press"')
            time.sleep(2)
            ups.regex('on text "Print" Do "wait_until_found"')
            time.sleep(2)
            ups.regex('do "press key KEYCODE_BACK"')
            time.sleep(2)
            ups.regex('on text "user_pallabi@test.onelxk.co" do "press" ')
            time.sleep(2)
            ups.regex('on text "Yes" do "press" ')
            time.sleep(2)
            print_status = 'True'
            return print_status
            #break
        except ValueError:
            print("Error in delegates")
            print_status = 'False'
            time.sleep(2)
            ups.regex('do "press key KEYCODE_BACK"')
            time.sleep(2)
            ups.regex('on text "user_pallabi@test.onelxk.co" do "press" ')
            time.sleep(2)
            ups.regex('on text "Yes" do "press" ')
            time.sleep(2)
            return print_status


def printer_automation_printkeep(ip,pin,text,state):


    #ip_address = "10.195.6.123"
    print(ip)
    ups = UPS(printer_ip=ip)
    ups.initialize()
    time.sleep(2)
    ups.regex('do "press key KEYCODE_HOME"')
    time.sleep(5)

    # Click PIN login
    # ups.regex('Find widget "text-id=\'STRING_IDLEBUTTON_ID_1\'" do "press"')
    #ups.regex('Find widget "text-id=\'idle_text\'" do "press"')
    #time.sleep(5)
    ups.regex('on text "PIN Login" do "press" ')
    ups.regex('Find widget "text-id=\'pin_login_ui_pinvalue\'" Do "wait_until_found"')
    time.sleep(2)
    # Click Input text to bring keypad
    ups.regex('Find widget "text-id=\'pin_login_ui_pinvalue\'" do "press"')
    ups.regex('Find widget "text-id=\'DIALOG_OK_ID\'" Do "wait_until_found"')
    time.sleep(2)
    # Enter PIN and login
    lxk_universal_panel_step.core.universal_panel_step.type_text(pin)
    ups.regex('Find widget "text-id=\'DIALOG_OK_ID\'" do "press"')
    time.sleep(2)

    # Wait till Print Release Appears
    ups.regex('On text "Print Release" Do "wait_until_found"')
    ups.regex('On text "Print Release" Do "press"')
    time.sleep(2)
    # Wait till list view appears
    ups.regex('on text "Print" Do "wait_until_found"')

    # Check whether the job name as defined is shown in the list. If not found refresh and check again. If present,
    # then Print.
    while True:
        try:
            # text="Hello.txt"
            time.sleep(2)
            ups_command = '''In area "resource-id='esf.printReleaseUi:id/lvFragMain'" On text "{}" Do "press"'''.format(
                text)
            ups.regex(ups_command)
            ups.regex('Find Widget "resource-id=\'esf.printReleaseUi:id/action_settings\'" do "press"')
            ups_command='''Find widget "resource-id=\'esf.printReleaseUi:id/mnuPrintAndKeep\'" Do "verify enabled='{}'"'''.format(state)
            ups.regex(ups_command)
            status_message="Print and Keep is shown correctly and state is " + state
            print(status_message)
            print_status="True"
            ups.regex('do "press key KEYCODE_BACK"')
            time.sleep(1)
            ups.regex('on text "sravantesh.neogi@lexmark.com" do "press" ')
            time.sleep(1)
            ups.regex('on text "Yes" do "press" ')
            time.sleep(1)
            return print_status

        except ValueError:
            status_message="Print and Keep is incorrectly set and state is not " + state
            print(status_message)
            print_status="False"
            ups.regex('do "press key KEYCODE_BACK"')
            time.sleep(1)
            ups.regex('on text "sravantesh.neogi@lexmark.com" do "press" ')
            time.sleep(1)
            ups.regex('on text "Yes" do "press" ')
            time.sleep(1)
            return print_status

#quota_status=printer_automation_printkeep("10.195.6.123","1234","Hello_email.txt","true")
#print(quota_status)