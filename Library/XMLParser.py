import zipfile
import xml.etree.ElementTree as ET
import os
import shutil
import pyautogui as pg

# def download_wait(filename):
#     path_to_downloads = "C://Users//neogis//Downloads"
#     while not os.path.exists(path_to_downloads + "//" + filename):
#         pass
#     if os.path.isfile(path_to_downloads + '//' + filename):
#         return filename + " File Downloaded"


def delete_file(filename):
    path_to_file = "C://Users//neogis//Downloads//" + filename
    os.remove(path_to_file)


def check_values(notification_flag_original, delete_folder_check, unused_client_value, unprint_job_value,
                 late_bind_flag, print_job_value, queue_name):
    directory = "customPackage"
    zip = "customPackage.zip"

    parent = r"C:/Users/neogis/Downloads/"

    global notification_flag, delete_folder_flag
    with zipfile.ZipFile(r"C:\Users\neogis\Downloads\customPackage.zip", "r") as zip_ref:
        zip_ref.extractall(r"C:\Users\neogis\Downloads\customPackage")

    tree = ET.parse(r"C:\Users\neogis\Downloads\customPackage\configuration.xml")
    root = tree.getroot()

    for notification in root.iter('DisplayNotifications'):
        notification_flag = str(notification.text)
        if notification_flag == str(notification_flag_original).lower():
            # print(notification_flag)
            # print(str(notification_flag_original).lower())
            print("Notification set correctly to " + notification_flag)
        else:
            print("Did not configure correctly")

    for deletefolder in root.iter('DeleteEmptyUserFolders'):
        delete_folder_flag = str(deletefolder.text)

        if delete_folder_flag == str(delete_folder_check).lower():
            print("Delete folder flag set correctly to " + delete_folder_flag)
        else:
            print("Did not configure correctly")

    if str(delete_folder_check).lower() == "true":
        for deletefolderspan in root.iter('DeleteEmptyUserFoldersLifespan'):
            delete_folder_span = int(deletefolderspan.text)
            if delete_folder_span == int(unused_client_value):
                print("Delete folder value is " + str(delete_folder_span))
            else:
                print("Did not configure correctly")
    else:
        for deletefolderspan in root.iter('DeleteEmptyUserFoldersLifespan'):
            delete_folder_span = int(deletefolderspan.text)
            if delete_folder_span == 7:
                print("Default value retained for Empty User Folder span")
            else:
                print("Default value not retained for Empty User Folder span")

    for unprintspan in root.iter('UnprintedJobsLifespan'):
        unprint_job_span = int(unprintspan.text)
        if unprint_job_span == int(unprint_job_value):
            print("Print and Keep life for unprinted jobs is " + str(unprint_job_span))
        else:
            print("Not configured correctly")

    for printspan in root.iter('PrintAndKeepLifespan'):
        print_job_span = int(printspan.text)
        if print_job_span == int(print_job_value):
            print("Print and Keep life span for printed jobs is " + str(print_job_span))
        else:
            print("Not configured correctly")

    for latebinding in root.iter('LateBindingEnabled'):
        late_binding_flag = str(latebinding.text)

        if late_binding_flag == str(late_bind_flag).lower():
            print("Late Binding flag set to " + late_binding_flag)
        else:
            print("Did not configure correctly")

    for defaultqueue in root.iter('DefaultQueue'):
        default_print_queue = str(defaultqueue.text)
        if str(queue_name) == 'True':
            default__name = "LPMCloud"
        else:
            default__name = "LPMServerless"
        if default__name == default_print_queue:
            print("Default queue name set is : " + str(default_print_queue))
        else:
            print("Default queue name set is : " + str(default_print_queue))

    folder_path = os.path.join(parent, directory)
    path = os.path.join(parent, zip)

    shutil.rmtree(folder_path)
    os.remove(path)

    return "Settings completed"


def delete_folder(foldername):
    parent = r"C:/Users/neogis/D Drive/FREEDOM/Python/"
    directory = foldername + "@tmp"
    folder_path = os.path.join(parent, directory)

    os.rmdir(folder_path)


def delete_ws_folder(foldername):
    parent = r"C:/Users/neogis/.jenkins/workspace/"
    directory = foldername + "@tmp"
    folder_path = os.path.join(parent, directory)

    os.rmdir(folder_path)

def click_download_wait():
    pg.press('tab')
    pg.press('enter')

