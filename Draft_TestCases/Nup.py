import webbrowser
from pywinauto import *
import pyautogui as pg
import time
import sys
from pywinauto import keyboard



def nup(nup):

    webbrowser.open('https://www.google.com')  # Go to example.com
    time.sleep(5)
    pg.hotkey('ctrl','p')
    time.sleep(5)

    pg.hotkey('shift','tab')
    time.sleep(1)
    pg.press('enter')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')


    pg.press('enter')
    time.sleep(1)
    pg.press('tab')

    pg.press('tab')
    time.sleep(1)
    pg.press(str(nup))
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    time.sleep(1)
    pg.press('enter')
    time.sleep(1)
    pg.press('tab')
    time.sleep(1)
    pg.press('enter')




############################################################3