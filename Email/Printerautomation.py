import lxk_printer_device
import lxk_printer_device.webservices.automation
import lxk_printer_device.ews.webglue
from lxk_universal_panel_step import UPS
from lxk_universal_panel_step.core.universal_panel_step import TextInputUsingNumpad, AndroidUPS
import lxk_universal_panel_step
import time



def printer_automation(text):
    # print(text)
    ip_address = "10.195.7.84"
    #lxk_printer_device.webservices.automation.download_panel_xml(ip_address, filename="panel.xml", path=".")

    ups = UPS(printer_ip="10.195.7.84")
    ups.initialize()

    # Job name
    # text = "Hello.txt"

    # Click PIN login
    # ups.regex('Find widget "text-id=\'STRING_IDLEBUTTON_ID_1\'" do "press"')
    ups.regex('Find widget "text-id=\'idle_text\'" do "press"')
    time.sleep(5)
    ups.regex('on text "PIN Login" do "press" ')
    ups.regex('Find widget "text-id=\'pin_login_ui_pinvalue\'" Do "wait_until_found"')

    # Click Input text to bring keypad
    ups.regex('Find widget "text-id=\'pin_login_ui_pinvalue\'" do "press"')
    ups.regex('Find widget "text-id=\'DIALOG_OK_ID\'" Do "wait_until_found"')

    # Enter PIN and login
    lxk_universal_panel_step.core.universal_panel_step.type_text("1234")
    ups.regex('Find widget "text-id=\'DIALOG_OK_ID\'" do "press"')

    # Wait till Print Release Appears
    ups.regex('On text "Print Release" Do "wait_until_found"')
    ups.regex('On text "Print Release" Do "press"')

    # Wait till list view appears
    ups.regex('on text "Print" Do "wait_until_found"')

    # Check whether the job name as defined is shown in the list. If not found refresh and check again. If present,
    # then Print.
    while True:
        try:
            # text="Hello.txt"
            ups.regex('Find Widget "resource-id=\'esf.printReleaseUi:id/action_settings\'" do "press"')
            ups.regex('On text "Refresh" do "press"')
            time.sleep(5)
            ups_command = '''In area "resource-id='esf.printReleaseUi:id/lvFragMain'" On text "{}" Do "press"'''.format(
                text)
            ups.regex(ups_command)
            ups.regex('on text "Print" do "press"')
            time.sleep(10)
            ups.regex('on text "Print" Do "wait_until_found"')
            #time.sleep(5)
            ups.regex('do "press key KEYCODE_BACK"')
            time.sleep(2)
            ups.regex('on text "sravantesh.neogi@lexmark.com" do "press" ')
            time.sleep(2)
            ups.regex('on text "Yes" do "press" ')
            print_status = 'True'
            return print_status
            #break
        except ValueError:
            print("Job name not found")
            print_status = 'False'
            return print_status




#printer_automation("Test Mail.html")
