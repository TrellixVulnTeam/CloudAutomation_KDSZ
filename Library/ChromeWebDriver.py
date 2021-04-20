from selenium import webdriver
import webdriver_manager
from webdriver_manager.chrome import ChromeDriverManager
import zipfile
import os
from msedge.selenium_tools import Edge,EdgeOptions

def set_chromedriver():

    #webdriver.Chrome(ChromeDriverManager(version="90.0.4430.24").install())
    driver = webdriver.Chrome(executable_path=r'C:\Users\neogis\Downloads\chromedriver_win32 (2)\chromedriver.exe')
    driver.get('http://google.com/')
    #driver = webdriver.Chrome(r"C:\Users\\scmselenium\\.wdm\\drivers\\chromedriver\\win32\\90.0.4430.24\\chromedriver.exe")

    app_path = r"C:\Users\neogis\Downloads\chromedriver_win32 (2)\chromedriver.exe"
    os.environ["PATH"] += os.pathsep + app_path
    result=os.environ['PATH']
    return result

def set_edgedriver():
    options=EdgeOptions()
    options.use_chromium=True
    driver=Edge(options=options,executable_path=r"C:\Users\scmselenium\jenkins\workspace\print-management-ui\CPM_ProdValidation_Pipeline_US@2\venv\Lib\site-packages\MicrosoftWebDriver.exe")
    driver.get('http://google.com/')
    app_path = r"C:\Users\scmselenium\jenkins\workspace\print-management-ui\CPM_ProdValidation_Pipeline_US@2\venv\Lib\site-packages\MicrosoftWebDriver.exe"
    os.environ["PATH"] += os.pathsep + app_path
    result=os.environ['PATH']
    return result

set_chromedriver()