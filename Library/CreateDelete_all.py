import requests
import json
import jsonpath
import http.client
import re

def create_user_all(username,password,env,nonadmin):
    global locale, setup
    if "us" in env and "dev" in env:
        locale = "us"
        setup = "dev"
    elif "eu" in env and "dev" in env:
        locale = "eu"
        setup = "dev"
    # username = "sravantesh.neogi@lexmark.com"
    # password = "Password@1234"
    #nonadmin="cpmautomation@test.onelxk.co"

    # Get Auth token
    auth_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/oauth/token"
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(
        username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"

    headers = {'Content-Type': 'application/json'}

    response = requests.request("POST", auth_url, headers=headers, data=payload)

    json_response = json.loads(response.content)
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    org_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users/email/sravantesh.neogi@lexmark.com"
    payload = {}

    headers = {'Authorization': ''}
    auth_token = str("Bearer " + access_token)

    headers['Authorization'] = auth_token
    headers['Content-Type'] = "application/json"

    response = requests.request("GET", org_url, headers=headers, data=payload)

    json_resonse = json.loads(response.content)
    org_id = jsonpath.jsonpath(json_resonse, 'organizationId')
    user_id = jsonpath.jsonpath(json_resonse, 'id')

    base_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users?organization_id="
    url = base_url + org_id[0]
    payload = "{\n\t\"email\": \""+str(nonadmin)+"\"," \
              "\n\t\"organization_id\": \""+str(org_id[0])+"\"," \
              "\n\t\"firstName\": \"CPM\"," \
              "\n    \"lastName\": \"\"," \
              "\n    \"displayName\": \"CPM\"," \
              "\n    \"password\": \""+str(password)+"\"\n}"
    result=requests.request("POST", url, headers=headers, data=payload)
    print(result.text)
    json_resonse = json.loads(result.content)
    user_id = jsonpath.jsonpath(json_resonse, 'id')
    print(user_id[0])
    print(result.status_code)
    base_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/role_grants"
    print(user_id[0])
    payload = "{ \n\t\"organizationId\": \""+str(org_id[0])+"\"," \
              "\n\t\"principalId\": \""+str(user_id[0])+"\"," \
              "\n\t\"roleName\": \"LPM_PRINT_RELEASE:ROLE_ADMIN\"," \
              "\n\t\"principalType\": \"User\"\n}"
    result=requests.request("POST", base_url, headers=headers, data=payload)
    print(result.status_code)
    return nonadmin


def quota_green_all(username,password,env):
    global document_id, setup, locale

    if "us" in env and "dev" in env:
        locale = "us"
        setup = "dev"
    elif "eu" in env and "dev" in env:
        locale = "eu"
        setup = "dev"
    global identity_id
    #username = "cpmautomation@test.onelxk.co"
    #password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/oauth/token"
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
    org_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users/email/cpmautomation@test.onelxk.co"
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


#def user_quota_status():

    username = "cpmautomation@test.onelxk.co"
    password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/oauth/token"
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"
    headers = {'Content-Type': 'application/json'}
    response = requests.request("POST", auth_url, headers=headers, data=payload)
    json_response = json.loads(response.content)

    # Get Access token
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    # Get Org ID
    org_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users/email/cpmautomation@test.onelxk.co"
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

    user_total_impression=1
    user_color_impression=1

    #Release the mobile job
    payload = "{\n   \"type\":  \"printRelease\",\n   \"identityId\":\"" + str(user_id[0])+"\",\n   \"totalImpressions\":\"" + str(user_total_impression)+"\",\n   \"colorImpressions\":\"" + str(user_color_impression)+"\",\n   \"physicalPageCount\": 5,\n   \"duplex\": \"simplex\",\n   \"color\": true,\n   \"paperTypeId\": 5,\n   \"paperSizeId\": 5,\n   \"copyCount\": 5,\n   \"printedState\": \"\",\n   \"documentId\": \"" + str(document_id) + "\",\n   \"nUp\": 5,\n   \"staple\": \"front\",\n   \"holePunch\": \"off\",\n   \"fold\": \"trifold\",\n   \"esfAppName\": \"customESF\",\n   \"printerJobId\": \"12345\",\n   \"device\": {\n        \"serialNo\": \"DEV123456\",\n        \"ipAddress\": \"127.0.0.1\",\n        \"modelName\": \"test1\",\n        \"hostName\": \"host1\",\n        \"domainName\": \"name1\",\n        \"macAddress\": \"B8AC6F9B1157\",\n        \"capabilities\": {\n            \"duplex\": true,\n            \"color\": true,\n            \"mfp\": true,\n            \"finisher\": false\n        }\n    },\n    \"client\": {\n        \"name\": \"LexDAS\",\n        \"version\": \"2.0\"\n    }\n}"
    url_job = base_url + "/" + org_id[0] + "/jobs/"
    response = requests.request("POST", url_job, headers=headers, data=payload)

    #get new quota status and compare with CPM Portal UI
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/quota/"
    #conn = http.client.HTTPSConnection("apis."+setup+"."+us.cloud.onelxk.co")

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


def quota_yellow_all(username,password,env):
    global document_id, setup, locale

    if "us" in env and "dev" in env:
        locale = "us"
        setup = "dev"
    elif "eu" in env and "dev" in env:
        locale = "eu"
        setup = "dev"
    global identity_id
    #username = "cpmautomation@test.onelxk.co"
    #password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/oauth/token"
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
    org_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users/email/cpmautomation@test.onelxk.co"
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


#def user_quota_status():

    username = "cpmautomation@test.onelxk.co"
    password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/oauth/token"
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"
    headers = {'Content-Type': 'application/json'}
    response = requests.request("POST", auth_url, headers=headers, data=payload)
    json_response = json.loads(response.content)

    # Get Access token
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    # Get Org ID
    org_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users/email/cpmautomation@test.onelxk.co"
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

    user_total_impression=8
    user_color_impression=8

    #Release the mobile job
    payload = "{\n   \"type\":  \"printRelease\",\n   \"identityId\":\"" + str(user_id[0])+"\",\n   \"totalImpressions\":\"" + str(user_total_impression)+"\",\n   \"colorImpressions\":\"" + str(user_color_impression)+"\",\n   \"physicalPageCount\": 5,\n   \"duplex\": \"simplex\",\n   \"color\": true,\n   \"paperTypeId\": 5,\n   \"paperSizeId\": 5,\n   \"copyCount\": 5,\n   \"printedState\": \"\",\n   \"documentId\": \"" + str(document_id) + "\",\n   \"nUp\": 5,\n   \"staple\": \"front\",\n   \"holePunch\": \"off\",\n   \"fold\": \"trifold\",\n   \"esfAppName\": \"customESF\",\n   \"printerJobId\": \"12345\",\n   \"device\": {\n        \"serialNo\": \"DEV123456\",\n        \"ipAddress\": \"127.0.0.1\",\n        \"modelName\": \"test1\",\n        \"hostName\": \"host1\",\n        \"domainName\": \"name1\",\n        \"macAddress\": \"B8AC6F9B1157\",\n        \"capabilities\": {\n            \"duplex\": true,\n            \"color\": true,\n            \"mfp\": true,\n            \"finisher\": false\n        }\n    },\n    \"client\": {\n        \"name\": \"LexDAS\",\n        \"version\": \"2.0\"\n    }\n}"
    url_job = base_url + "/" + org_id[0] + "/jobs/"
    response = requests.request("POST", url_job, headers=headers, data=payload)

    #get new quota status and compare with CPM Portal UI
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/quota/"
    #conn = http.client.HTTPSConnection("apis."+setup+"."+us.cloud.onelxk.co")

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


def quota_red_all(username,password,env):
    global document_id, setup, locale

    if "us" in env and "dev" in env:
        locale = "us"
        setup = "dev"
    elif "eu" in env and "dev" in env:
        locale = "eu"
        setup = "dev"
    global identity_id
    #username = "cpmautomation@test.onelxk.co"
    #password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/oauth/token"
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
    org_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users/email/cpmautomation@test.onelxk.co"
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


#def user_quota_status():

    username = "cpmautomation@test.onelxk.co"
    password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/oauth/token"
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"
    headers = {'Content-Type': 'application/json'}
    response = requests.request("POST", auth_url, headers=headers, data=payload)
    json_response = json.loads(response.content)

    # Get Access token
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    # Get Org ID
    org_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users/email/cpmautomation@test.onelxk.co"
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

    #get current quota status and compare with CPM Portal UI
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/quota/"
    conn = http.client.HTTPSConnection("apis."+setup+"."+".cloud.onelxk.co")

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

    user_total_impression=total_remaining_current
    user_color_impression=color_remaining_current

    #Release the mobile job
    payload = "{\n   \"type\":  \"printRelease\",\n   \"identityId\":\"" + str(user_id[0])+"\",\n   \"totalImpressions\":\"" + str(user_total_impression)+"\",\n   \"colorImpressions\":\"" + str(user_color_impression)+"\",\n   \"physicalPageCount\": 5,\n   \"duplex\": \"simplex\",\n   \"color\": true,\n   \"paperTypeId\": 5,\n   \"paperSizeId\": 5,\n   \"copyCount\": 5,\n   \"printedState\": \"\",\n   \"documentId\": \"" + str(document_id) + "\",\n   \"nUp\": 5,\n   \"staple\": \"front\",\n   \"holePunch\": \"off\",\n   \"fold\": \"trifold\",\n   \"esfAppName\": \"customESF\",\n   \"printerJobId\": \"12345\",\n   \"device\": {\n        \"serialNo\": \"DEV123456\",\n        \"ipAddress\": \"127.0.0.1\",\n        \"modelName\": \"test1\",\n        \"hostName\": \"host1\",\n        \"domainName\": \"name1\",\n        \"macAddress\": \"B8AC6F9B1157\",\n        \"capabilities\": {\n            \"duplex\": true,\n            \"color\": true,\n            \"mfp\": true,\n            \"finisher\": false\n        }\n    },\n    \"client\": {\n        \"name\": \"LexDAS\",\n        \"version\": \"2.0\"\n    }\n}"
    url_job = base_url + "/" + org_id[0] + "/jobs/"
    response = requests.request("POST", url_job, headers=headers, data=payload)

    #get new quota status and compare with CPM Portal UI
    url = base_url + "/" + org_id[0] + "/users/" + user_id[0] + "/quota/"
    #conn = http.client.HTTPSConnection("apis."+setup+"."+us.cloud.onelxk.co")

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


def delete_user_all(username,password,env,nonadmin):
    global setup, locale

    if "us" in env and "dev" in env:
        locale = "us"
        setup = "dev"
    elif "eu" in env and "dev" in env:
        locale = "eu"
        setup = "dev"
    # username = "sravantesh.neogi@lexmark.com"
    # password = "Password@1234"
    #nonadmin="cpmautomation@test.onelxk.co"
    # Get Auth token
    auth_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/oauth/token"
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(
        username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"

    headers = {'Content-Type': 'application/json'}

    response = requests.request("POST", auth_url, headers=headers, data=payload)

    json_response = json.loads(response.content)
    access_token = jsonpath.jsonpath(json_response, 'access_token')
    access_token = access_token[0]

    org_url = "https://idp."+setup+"."+locale+".cloud.onelxk.co/rest/users/email/cpmautomation@test.onelxk.co"
    payload = ''

    headers = {'Authorization': ''}
    auth_token = str("Bearer " + access_token)
    headers['Authorization'] = auth_token
    request=requests.request("DELETE", org_url, headers=headers, data=payload)
    print(request.status_code)

