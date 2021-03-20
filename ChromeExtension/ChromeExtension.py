import webbrowser
import pyautogui as pg
import time

def login_job():
    webbrowser.open('https://www.google.com')  # Go to example.com
    time.sleep(10)
    pg.hotkey('ctrl','p')
    time.sleep(5)
    pg.press('enter')

    time.sleep(8)

    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    time.sleep(2)
    pg.write('sravantesh.neogi@lexmark.com')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    time.sleep(2)
    pg.press('enter')
    time.sleep(2)
    pg.write('Password@1234')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('enter')
    time.sleep(10)
    pg.hotkey('ctrl','w')
    time.sleep(5)


def chrome_copies():
    webbrowser.open('https://www.google.com')  # Go to example.com
    time.sleep(10)
    pg.hotkey('ctrl','p')
    time.sleep(5)
    pg.hotkey('shift','tab')
    pg.hotkey('shift','tab')
    pg.hotkey('shift','tab')
    pg.hotkey('shift','tab')
    # Copies making 4
    pg.press('up',presses=3)
    time.sleep(1)
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('enter')

    time.sleep(10)
    pg.hotkey('ctrl','w')
    time.sleep(5)


def chrome_color():
    webbrowser.open('https://www.google.com')  # Go to example.com
    time.sleep(10)
    pg.hotkey('ctrl','p')
    time.sleep(5)

    pg.hotkey('shift','tab')
    pg.hotkey('shift','tab')
    time.sleep(1)
    pg.press('down')
    pg.press('tab')
    pg.press('tab')
    pg.press('enter')

    time.sleep(10)
    pg.hotkey('ctrl','w')
    time.sleep(5)


def chrome_mono():
    webbrowser.open('https://www.google.com')  # Go to example.com
    time.sleep(10)
    pg.hotkey('ctrl','p')
    time.sleep(5)

    pg.hotkey('shift','tab')
    pg.hotkey('shift','tab')

    pg.press('up')
    time.sleep(1)
    pg.press('tab')
    pg.press('tab')
    pg.press('enter')

    time.sleep(10)
    pg.hotkey('ctrl','w')
    time.sleep(5)


def chrome_short():
    webbrowser.open('https://www.google.com')  # Go to example.com
    time.sleep(10)
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

    pg.press('space')

    time.sleep(1)

    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')

    pg.press('enter')
    time.sleep(1)
    pg.press('tab')

    time.sleep(1)
    pg.press('down')

    time.sleep(1)

    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    time.sleep(1)
    pg.press('enter')
    time.sleep(2)
    pg.press('tab')
    pg.press('enter')

    time.sleep(10)
    pg.hotkey('ctrl','w')
    time.sleep(5)


def chrome_long():
    webbrowser.open('https://www.google.com')  # Go to example.com
    time.sleep(10)
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
    pg.press('tab')

    pg.press('enter')
    time.sleep(1)
    pg.press('tab')

    time.sleep(1)
    pg.press('up')

    time.sleep(1)

    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    time.sleep(1)
    pg.press('enter')
    time.sleep(2)
    pg.press('tab')
    pg.press('enter')

    time.sleep(10)
    pg.hotkey('ctrl','w')
    time.sleep(5)


def chrome_simplex():
    webbrowser.open('https://www.google.com')  # Go to example.com
    time.sleep(10)
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

    pg.press('space')

    time.sleep(1)

    pg.press('tab')
    pg.press('tab')
    pg.press('tab')
    pg.press('tab')

    pg.press('enter')


    time.sleep(10)
    pg.hotkey('ctrl','w')
    time.sleep(5)


def chrome_nup(nup):

    webbrowser.open('https://www.google.com')  # Go to example.com
    time.sleep(10)
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
    nup=int(nup)
    if nup==1:
        pg.press('up')
    else:
        print(nup)
        pg.press('down',presses=1)
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

    time.sleep(10)
    pg.hotkey('ctrl','w')
    time.sleep(5)


def chrome_nup_reset():

    webbrowser.open('https://www.google.com')  # Go to example.com
    time.sleep(10)
    pg.hotkey('ctrl','p')
    time.sleep(7)

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
    pg.press('up',presses=7)
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
    pg.press('tab')
    time.sleep(2)
    pg.press('enter')

    time.sleep(10)
    pg.hotkey('ctrl','w')
    time.sleep(5)

############################################################3