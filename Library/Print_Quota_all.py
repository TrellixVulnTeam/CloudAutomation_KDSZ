import requests
import json
import jsonpath
import http.client
import re

def quota_green(username,password,env):
    global document_id, setup, locale
    global identity_id
    if "us" in env and "dev" in env:
        locale = "us"
        setup = "dev"
    elif "eu" in env and "dev" in env:
        locale = "eu"
        setup = "dev"

    # Get Auth token
    auth_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/oauth/token"
    print(auth_url)
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(
        username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"
    headers = {'Content-Type': 'application/json'}
    response = requests.request("POST", auth_url, headers=headers, data=payload)
    #print(response.status_code)
    #print(response.content)
    json_response = json.loads(response.content)

    # Get Access token
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    # Get Org ID
    org_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users/email/"+username
    print(org_url)
    payload = {}
    headers = {'Authorization': ''}
    auth_token = str("Bearer " + access_token)

    headers['Authorization'] = auth_token
    response = requests.request("GET", org_url, headers=headers, data=payload)
    json_resonse = json.loads(response.content)
    org_id = jsonpath.jsonpath(json_resonse, 'organizationId')
    user_id = jsonpath.jsonpath(json_resonse, 'id')


    #def mobile_submit(org_id, user_id, access_token):
    base_url = "https://apis."+setup+"."+locale+".cloud.onelxk.co/cpm/print-management-service/v3.0/organizations"
    print(base_url)
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/documents/"

    payload = "{\n    \"name\": \"mobile.doc\",\n    \"title\": \"My mobile title\",\n    \"description\": \"A test " \
              "document to upload\",\n    \"client\": {\n        \"type\": \"mobile\",\n        \"version\": " \
              "\"1.2.11.2\",\n        \"osName\": \"ios\",\n        \"osVersion\": \"11.1.1\",\n        \"model\": " \
              "\"tablet\"\n    },\n    \"metadata\": {\n    },\n    \"requestedOptions\": [\n        {\n            " \
              "\"name\": \"duplex\",\n            \"value\": \"simplex\"\n        },\n        {\n            " \
              "\"name\": \"copies\",\n            \"value\": \"5\"\n        }\n    ]\n} "
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + access_token
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    json_response = json.loads(response.content)
    file_link = jsonpath.jsonpath(json_response, 'fileLink')
    document_id_raw=jsonpath.jsonpath(json_response, 'id')
    document_id=document_id_raw[0]
    #print(document_id)
    #print(json_response)
    #document_id=jsonpath.jsonpath(json_response, 'document_')

    payload = "<file contents here>"
    headers = {
        'Content-Type': 'application/octet-stream'
    }

    response=requests.request("PUT", file_link[0], headers=headers, data=payload)
    status_code=response.status_code


#def user_quota_status():

    # username = "sravantesh.neogi@lexmark.com"
    # password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/oauth/token"
    print(auth_url)

    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"
    headers = {'Content-Type': 'application/json'}
    response = requests.request("POST", auth_url, headers=headers, data=payload)
    json_response = json.loads(response.content)

    #Get Access token
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    # Get Org ID
    org_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users/email/"+username
    print(org_url)
    payload = {}
    headers = {'Authorization': ''}
    auth_token = str("Bearer " + access_token)

    #Get user ID
    headers['Authorization'] = auth_token
    response = requests.request("GET", org_url, headers=headers, data=payload)
    json_resonse = json.loads(response.content)
    org_id = jsonpath.jsonpath(json_resonse, 'organizationId')
    user_id = jsonpath.jsonpath(json_resonse, 'id')
    identity_id=user_id[0]

    base_url = "https://apis."+setup+"."+locale+".cloud.onelxk.co/cpm/print-management-service/v3.0/organizations"
    print(base_url)
    #get current quota status and compare with CPM Portal UI
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/quota/"
    conn = http.client.HTTPSConnection("apis."+setup+"."+locale+".cloud.onelxk.co")

    payload = ""
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + access_token
    }
    response = requests.request("GET", url, headers=headers, data=payload)
    data=response.text
    list=re.findall('\d+', data)
    total_remaining_current=list[0]
    color_remaining_current=list[2]
    print("Total original : " + total_remaining_current)
    print("Color original : " + color_remaining_current)

    user_total_impression=2
    user_color_impression=2

    #Release the mobile job
    payload = "{\n   \"type\":  \"printRelease\",\n   \"identityId\":\"" + str(user_id[0])+"\",\n   \"totalImpressions\":\"" + str(user_total_impression)+"\",\n   \"colorImpressions\":\"" + str(user_color_impression)+"\",\n   \"physicalPageCount\": 5,\n   \"duplex\": \"simplex\",\n   \"color\": true,\n   \"paperTypeId\": 5,\n   \"paperSizeId\": 5,\n   \"copyCount\": 5,\n   \"printedState\": \"\",\n   \"documentId\": \"" + str(document_id) + "\",\n   \"nUp\": 5,\n   \"staple\": \"front\",\n   \"holePunch\": \"off\",\n   \"fold\": \"trifold\",\n   \"esfAppName\": \"customESF\",\n   \"printerJobId\": \"12345\",\n   \"device\": {\n        \"serialNo\": \"DEV123456\",\n        \"ipAddress\": \"127.0.0.1\",\n        \"modelName\": \"test1\",\n        \"hostName\": \"host1\",\n        \"domainName\": \"name1\",\n        \"macAddress\": \"B8AC6F9B1157\",\n        \"capabilities\": {\n            \"duplex\": true,\n            \"color\": true,\n            \"mfp\": true,\n            \"finisher\": false\n        }\n    },\n    \"client\": {\n        \"name\": \"LexDAS\",\n        \"version\": \"2.0\"\n    }\n}"
    url_job = base_url + "/" + org_id[0] + "/jobs/"
    response = requests.request("POST", url_job, headers=headers, data=payload)

    #get new quota status and compare with CPM Portal UI
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/quota/"
    #conn = http.client.HTTPSConnection("apis.dev.us.cloud.onelxk.co")

    payload = ""
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + access_token
    }
    response = requests.request("GET", url, headers=headers, data=payload)
    data=response.text
    list_values=re.findall('\d+', data)
    total_remaining_new=list_values[0]
    color_remaining_new=list_values[2]
    print("Total New : " + total_remaining_new)
    print("Color new : " + color_remaining_new)

    check_total=int(total_remaining_current)-int(user_total_impression)
    check_color=int(color_remaining_current)-int(user_color_impression)

    #Delete job
    url_delete_job = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/documents/" + document_id
    payload=""
    requests.request("DELETE",url_delete_job,data=payload, headers=headers)
    return total_remaining_new,color_remaining_new


def quota_yellow():
    global document_id
    global identity_id
    username = "sravantesh.neogi@lexmark.com"
    password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp.dev.us.cloud.onelxk.co/oauth/token"
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(
        username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"
    headers = {'Content-Type': 'application/json'}
    response = requests.request("POST", auth_url, headers=headers, data=payload)
    #print(response.status_code)
    #print(response.content)
    json_response = json.loads(response.content)

    # Get Access token
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    # Get Org ID
    org_url = "https://idp.dev.us.cloud.onelxk.co/rest/users/email/sravantesh.neogi@lexmark.com"
    payload = {}
    headers = {'Authorization': ''}
    auth_token = str("Bearer " + access_token)

    headers['Authorization'] = auth_token
    response = requests.request("GET", org_url, headers=headers, data=payload)
    json_resonse = json.loads(response.content)
    org_id = jsonpath.jsonpath(json_resonse, 'organizationId')
    user_id = jsonpath.jsonpath(json_resonse, 'id')


    #def mobile_submit(org_id, user_id, access_token):
    base_url = "https://apis.dev.us.cloud.onelxk.co/cpm/print-management-service/v3.0/organizations"
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/documents/"

    payload = "{\n    \"name\": \"mobile.doc\",\n    \"title\": \"My mobile title\",\n    \"description\": \"A test " \
              "document to upload\",\n    \"client\": {\n        \"type\": \"mobile\",\n        \"version\": " \
              "\"1.2.11.2\",\n        \"osName\": \"ios\",\n        \"osVersion\": \"11.1.1\",\n        \"model\": " \
              "\"tablet\"\n    },\n    \"metadata\": {\n    },\n    \"requestedOptions\": [\n        {\n            " \
              "\"name\": \"duplex\",\n            \"value\": \"simplex\"\n        },\n        {\n            " \
              "\"name\": \"copies\",\n            \"value\": \"5\"\n        }\n    ]\n} "
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + access_token
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    json_response = json.loads(response.content)
    file_link = jsonpath.jsonpath(json_response, 'fileLink')
    document_id_raw=jsonpath.jsonpath(json_response, 'id')
    document_id=document_id_raw[0]


    payload = "<file contents here>"
    headers = {
        'Content-Type': 'application/octet-stream'
    }

    response=requests.request("PUT", file_link[0], headers=headers, data=payload)
    status_code=response.status_code

    username = "sravantesh.neogi@lexmark.com"
    password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp.dev.us.cloud.onelxk.co/oauth/token"
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"
    headers = {'Content-Type': 'application/json'}
    response = requests.request("POST", auth_url, headers=headers, data=payload)
    json_response = json.loads(response.content)

    # Get Access token
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    # Get Org ID
    org_url = "https://idp.dev.us.cloud.onelxk.co/rest/users/email/sravantesh.neogi@lexmark.com"
    payload = {}
    headers = {'Authorization': ''}
    auth_token = str("Bearer " + access_token)

    #Get user ID
    headers['Authorization'] = auth_token
    response = requests.request("GET", org_url, headers=headers, data=payload)
    json_resonse = json.loads(response.content)
    org_id = jsonpath.jsonpath(json_resonse, 'organizationId')
    user_id = jsonpath.jsonpath(json_resonse, 'id')
    identity_id=user_id[0]

    base_url = "https://apis.dev.us.cloud.onelxk.co/cpm/print-management-service/v3.0/organizations"

    #get current quota status and compare with CPM Portal UI
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/quota/"
    conn = http.client.HTTPSConnection("apis.dev.us.cloud.onelxk.co")

    payload = ""
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + access_token
    }
    response = requests.request("GET", url, headers=headers, data=payload)
    data=response.text
    list=re.findall('\d+', data)
    total_remaining_current=list[0]
    color_remaining_current=list[2]
    print("Total original : " + total_remaining_current)
    print("Color original : " + color_remaining_current)

    user_total_impression=int(85*int(total_remaining_current)/100)
    user_color_impression=int(85*int(color_remaining_current)/100)

    #user_total_impression=250
    #user_color_impression=250

    #Release the mobile job
    payload = "{\n   \"type\":  \"printRelease\",\n   \"identityId\":\"" + str(user_id[0])+"\",\n   \"totalImpressions\":\"" + str(user_total_impression)+"\",\n   \"colorImpressions\":\"" + str(user_color_impression)+"\",\n   \"physicalPageCount\": 5,\n   \"duplex\": \"simplex\",\n   \"color\": true,\n   \"paperTypeId\": 5,\n   \"paperSizeId\": 5,\n   \"copyCount\": 5,\n   \"printedState\": \"\",\n   \"documentId\": \"" + str(document_id) + "\",\n   \"nUp\": 5,\n   \"staple\": \"front\",\n   \"holePunch\": \"off\",\n   \"fold\": \"trifold\",\n   \"esfAppName\": \"customESF\",\n   \"printerJobId\": \"12345\",\n   \"device\": {\n        \"serialNo\": \"DEV123456\",\n        \"ipAddress\": \"127.0.0.1\",\n        \"modelName\": \"test1\",\n        \"hostName\": \"host1\",\n        \"domainName\": \"name1\",\n        \"macAddress\": \"B8AC6F9B1157\",\n        \"capabilities\": {\n            \"duplex\": true,\n            \"color\": true,\n            \"mfp\": true,\n            \"finisher\": false\n        }\n    },\n    \"client\": {\n        \"name\": \"LexDAS\",\n        \"version\": \"2.0\"\n    }\n}"
    url_job = base_url + "/" + org_id[0] + "/jobs/"
    response = requests.request("POST", url_job, headers=headers, data=payload)

    #get new quota status and compare with CPM Portal UI
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/quota/"
    #conn = http.client.HTTPSConnection("apis.dev.us.cloud.onelxk.co")

    payload = ""
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + access_token
    }
    response = requests.request("GET", url, headers=headers, data=payload)
    data=response.text
    list_values=re.findall('\d+', data)
    total_remaining_new=list_values[0]
    color_remaining_new=list_values[2]
    print("Total New : " + total_remaining_new)
    print("Color new : " + color_remaining_new)

    check_total=int(total_remaining_current)-int(user_total_impression)
    check_color=int(color_remaining_current)-int(user_color_impression)

    #Delete job
    url_delete_job = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/documents/" + document_id
    payload=""
    requests.request("DELETE",url_delete_job,data=payload, headers=headers)
    return total_remaining_new,color_remaining_new


def quota_red():
    global document_id
    global identity_id
    username = "sravantesh.neogi@lexmark.com"
    password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp.dev.us.cloud.onelxk.co/oauth/token"
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(
        username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"
    headers = {'Content-Type': 'application/json'}
    response = requests.request("POST", auth_url, headers=headers, data=payload)
    #print(response.status_code)
    #print(response.content)
    json_response = json.loads(response.content)

    # Get Access token
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    # Get Org ID
    org_url = "https://idp.dev.us.cloud.onelxk.co/rest/users/email/sravantesh.neogi@lexmark.com"
    payload = {}
    headers = {'Authorization': ''}
    auth_token = str("Bearer " + access_token)

    headers['Authorization'] = auth_token
    response = requests.request("GET", org_url, headers=headers, data=payload)
    json_resonse = json.loads(response.content)
    org_id = jsonpath.jsonpath(json_resonse, 'organizationId')
    user_id = jsonpath.jsonpath(json_resonse, 'id')


    #def mobile_submit(org_id, user_id, access_token):
    base_url = "https://apis.dev.us.cloud.onelxk.co/cpm/print-management-service/v3.0/organizations"
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/documents/"

    payload = "{\n    \"name\": \"mobile.doc\",\n    \"title\": \"My mobile title\",\n    \"description\": \"A test " \
              "document to upload\",\n    \"client\": {\n        \"type\": \"mobile\",\n        \"version\": " \
              "\"1.2.11.2\",\n        \"osName\": \"ios\",\n        \"osVersion\": \"11.1.1\",\n        \"model\": " \
              "\"tablet\"\n    },\n    \"metadata\": {\n    },\n    \"requestedOptions\": [\n        {\n            " \
              "\"name\": \"duplex\",\n            \"value\": \"simplex\"\n        },\n        {\n            " \
              "\"name\": \"copies\",\n            \"value\": \"5\"\n        }\n    ]\n} "
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + access_token
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    json_response = json.loads(response.content)
    file_link = jsonpath.jsonpath(json_response, 'fileLink')
    document_id_raw=jsonpath.jsonpath(json_response, 'id')
    document_id=document_id_raw[0]


    payload = "<file contents here>"
    headers = {
        'Content-Type': 'application/octet-stream'
    }

    response=requests.request("PUT", file_link[0], headers=headers, data=payload)
    status_code=response.status_code

    username = "sravantesh.neogi@lexmark.com"
    password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp.dev.us.cloud.onelxk.co/oauth/token"
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"
    headers = {'Content-Type': 'application/json'}
    response = requests.request("POST", auth_url, headers=headers, data=payload)
    json_response = json.loads(response.content)

    # Get Access token
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    # Get Org ID
    org_url = "https://idp.dev.us.cloud.onelxk.co/rest/users/email/sravantesh.neogi@lexmark.com"
    payload = {}
    headers = {'Authorization': ''}
    auth_token = str("Bearer " + access_token)

    #Get user ID
    headers['Authorization'] = auth_token
    response = requests.request("GET", org_url, headers=headers, data=payload)
    json_resonse = json.loads(response.content)
    org_id = jsonpath.jsonpath(json_resonse, 'organizationId')
    user_id = jsonpath.jsonpath(json_resonse, 'id')
    identity_id=user_id[0]

    base_url = "https://apis.dev.us.cloud.onelxk.co/cpm/print-management-service/v3.0/organizations"

    #get current quota status and compare with CPM Portal UI
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/quota/"
    conn = http.client.HTTPSConnection("apis.dev.us.cloud.onelxk.co")

    payload = ""
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + access_token
    }
    response = requests.request("GET", url, headers=headers, data=payload)
    data=response.text
    list=re.findall('\d+', data)
    total_remaining_current=list[0]
    color_remaining_current=list[2]
    print("Total original : " + total_remaining_current)
    print("Color original : " + color_remaining_current)

    user_total_impression=int(total_remaining_current)
    user_color_impression=int(color_remaining_current)

    #user_total_impression=1
    #user_color_impression=1

    #Release the mobile job
    payload = "{\n   \"type\":  \"printRelease\",\n   \"identityId\":\"" + str(user_id[0])+"\",\n   \"totalImpressions\":\"" + str(user_total_impression)+"\",\n   \"colorImpressions\":\"" + str(user_color_impression)+"\",\n   \"physicalPageCount\": 5,\n   \"duplex\": \"simplex\",\n   \"color\": true,\n   \"paperTypeId\": 5,\n   \"paperSizeId\": 5,\n   \"copyCount\": 5,\n   \"printedState\": \"\",\n   \"documentId\": \"" + str(document_id) + "\",\n   \"nUp\": 5,\n   \"staple\": \"front\",\n   \"holePunch\": \"off\",\n   \"fold\": \"trifold\",\n   \"esfAppName\": \"customESF\",\n   \"printerJobId\": \"12345\",\n   \"device\": {\n        \"serialNo\": \"DEV123456\",\n        \"ipAddress\": \"127.0.0.1\",\n        \"modelName\": \"test1\",\n        \"hostName\": \"host1\",\n        \"domainName\": \"name1\",\n        \"macAddress\": \"B8AC6F9B1157\",\n        \"capabilities\": {\n            \"duplex\": true,\n            \"color\": true,\n            \"mfp\": true,\n            \"finisher\": false\n        }\n    },\n    \"client\": {\n        \"name\": \"LexDAS\",\n        \"version\": \"2.0\"\n    }\n}"
    url_job = base_url + "/" + org_id[0] + "/jobs/"
    response = requests.request("POST", url_job, headers=headers, data=payload)

    #get new quota status and compare with CPM Portal UI
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/quota/"
    #conn = http.client.HTTPSConnection("apis.dev.us.cloud.onelxk.co")

    payload = ""
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + access_token
    }
    response = requests.request("GET", url, headers=headers, data=payload)
    data=response.text
    list_values=re.findall('\d+', data)
    total_remaining_new=list_values[0]
    color_remaining_new=list_values[2]
    print("Total New : " + total_remaining_new)
    print("Color new : " + color_remaining_new)

    check_total=int(total_remaining_current)-int(user_total_impression)
    check_color=int(color_remaining_current)-int(user_color_impression)

    #Delete job
    url_delete_job = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/documents/" + document_id
    payload=""
    requests.request("DELETE",url_delete_job,data=payload, headers=headers)
    return total_remaining_new,color_remaining_new

