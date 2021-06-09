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
    time.sleep(1)

def download_wait(filename):
    path_to_downloads = "C://Users//neogis//Downloads"
    while not os.path.exists(path_to_downloads + "//" + filename):
        pass
    if os.path.isfile(path_to_downloads + '//' + filename):
        return filename + " File Downloaded"

def download_wait_mac_saas(url):
    filename_us = "LPMCCloudUS_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.197.pkg"
    filename_eu = "LPMCCloudEU_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.182.pkg"
    if "us" in url:
        filename = filename_us
    else:
        filename = filename_eu
    path_to_downloads = "C://Users//neogis//Downloads"
    while not os.path.exists(path_to_downloads + "//" + filename):
        pass
    if os.path.isfile(path_to_downloads + '//' + filename):
        print("Downloaded")
        os.remove(path_to_downloads + "/" + filename)
        return filename + " File Downloaded and then deleted"


def download_wait_mac_serverless(url):
    filename_us = "LPMCServerlessUS_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.188.pkg"
    filename_eu = "LPMCServerlessEU_1.1.1417_GenDriver_1.0.66_Mac_Color_1.1.183.pkg"
    if "us" in url:
        filename = filename_us
    else:
        filename = filename_eu
    path_to_downloads = "C://Users//neogis//Downloads"
    while not os.path.exists(path_to_downloads + "//" + filename):
        pass
    if os.path.isfile(path_to_downloads + '//' + filename):
        print("Downloaded")
        os.remove(path_to_downloads + "/" + filename)
        return filename + " File Downloaded and then deleted"


def download_wait_win_saas(url):
    filename_us = "LPMC_CloudUS_2.3.981.0_UPD_2.15_Win_PCLXL_1.0.308.exe"
    filename_eu = "LPMC_CloudEU_2.3.981.0_UPD_2.15_Win_PCLXL_1.0.308.exe"
    if "us" in url:
        filename = filename_us
    else:
        filename = filename_eu
    path_to_downloads = "C://Users//neogis//Downloads"
    while not os.path.exists(path_to_downloads + "//" + filename):
        pass
    if os.path.isfile(path_to_downloads + '//' + filename):
        print("Downloaded")
        os.remove(path_to_downloads + "/" + filename)
        return filename + " File Downloaded and then deleted"


def download_wait_win_hybrid(url):
    filename_us = "LPMC_ServerlessUS_2.3.981.0_UPD_2.15_Win_PCLXL_1.0.308.exe"
    filename_eu = "LPMC_ServerlessEU_2.3.981.0_UPD_2.15_Win_PCLXL_1.0.308.exe"
    if "us" in url:
        filename = filename_us
    else:
        filename = filename_eu
    path_to_downloads = "C://Users//neogis//Downloads"
    while not os.path.exists(path_to_downloads + "//" + filename):
        pass
    if os.path.isfile(path_to_downloads + '//' + filename):
        print("Downloaded")
        os.remove(path_to_downloads + "/" + filename)
        return filename + " File Downloaded and then deleted"

