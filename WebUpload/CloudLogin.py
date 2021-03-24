import time
from pywinauto import *
import pyautogui as pg
import pywinauto
import os
import os.path


def file_name(location):
    # #Identify the Windows Browse dialog
    time.sleep(2)
    app = Application().connect(title_re="Open")
    main_dlg = app.window(title_re="Open")
    time.sleep(1)
    # #
    # #Send file name
    main_dlg.child_window(class_name="Edit").click()
    pg.write(location)
    # #
    time.sleep(2)
    main_dlg.child_window(title="&Open", class_name="Button").click()
    # pg.press('enter')
    time.sleep(3)


def sleep_call():
    time.sleep(5)


def sleep_call_2():
    time.sleep(4)


def sleep_call_1():
    time.sleep(2)


def download_wait(filename):
    path_to_downloads = "C://Users//neogis//Downloads"
    while not os.path.exists(path_to_downloads + "//" + filename):
        pass
    if os.path.isfile(path_to_downloads + '//' + filename):
        os.remove(path_to_downloads+'//'+filename)
        return filename + " File Downloaded"
