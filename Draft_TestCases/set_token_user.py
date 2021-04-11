import requests
import json
import jsonpath


def get_token():
    username = "sravantesh.neogi@lexmark.com"
    password = "Password@1234"

    # Get Auth token
    auth_url = "https://idp.dev.us.cloud.onelxk.co/oauth/token"
    payload = "{\r\n  \"grant_type\": \"password\",\r\n  \"username\": \"" + str(
        username) + "\",\r\n  \"password\": \"" + str(password) + "\"\r\n}"
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

    headers['Authorization'] = auth_token
    response = requests.request("GET", org_url, headers=headers, data=payload)
    json_resonse = json.loads(response.content)
    org_id = jsonpath.jsonpath(json_resonse, 'organizationId')
    user_id = jsonpath.jsonpath(json_resonse, 'id')
    return org_id, user_id, access_token


def mobile_submit(org_id, user_id, access_token):
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

    payload = "<file contents here>"
    headers = {
        'Content-Type': 'application/octet-stream'
    }

    response=requests.request("PUT", file_link[0], headers=headers, data=payload)
    status_code=response.status_code
    return url, access_token,status_code


def get_documents(status_code,url, access_token):
  if status_code==201:
    payload = {}
    headers = {
        'Authorization': 'Bearer ' + access_token
    }

    response = requests.request("GET", url, headers=headers, data=payload)

    json_response = json.loads(response.content)
    content = jsonpath.jsonpath(json_response, 'content')
    if content == [[]]:
        print("No documents")
    else:
        content = content[0]
        title = 'name'
        lenth = len(content)
        for i in range(0, lenth):
            for key, value in content[i].items():
                if title in key:
                    print("Name of the document:", value)


# Call the required functions
org_id, user_id, access_token = get_token()
url, access_token,status_code = mobile_submit(org_id, user_id, access_token)

#get_documents(status_code,url, access_token)
