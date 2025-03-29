#https://docs.syncthing.net/rest/config.html
from lxml import etree
import requests 
import os
# Get SOPS data
secrets_path = "/run/secrets/syncthing/devices/"
devices = [] 
for dir in os.listdir(secrets_path):
    devices.append(dir)



# Find API key in config.xml
tree = etree.parse('/home/vebly/.config/syncthing/config.xml') 
root = tree.getroot()

apikey_node = root.find('gui/apikey')
gui_address_node = root.find('gui/address')
apikey = apikey_node.text
gui_address = "http://" + gui_address_node.text + "/rest/"

# GET device data
header = {"X-API-Key": apikey}

get_response = requests.get(gui_address + "config/devices", headers=header)
response_data = None;
if get_response.status_code == 200:
    response_data = get_response.json()
else:
    print(f"Request failed with status code: {get_response.status_code}")


# Prepare PUT request data
request_data = None
updated_devices = [] 
if response_data != None:
    response_data_copy = response_data
    request_data = []
    for device_data in response_data_copy:
        updated = False;
        device_name = device_data["name"]
        id = None
        addresses = None
        if device_name in devices:
            id_path = secrets_path + device_name + "/id"
            if os.path.exists(id_path):
                file = open(id_path, "r")
                id = file.read()
                file.close()
                current_id = device_data["deviceID"]
                if current_id != id and id != None:
                    current_id = id
                    device_data["deviceID"]= id
                    updated = True
            if updated == True:
                request_data.append(device_data)
                updated_devices.append(device_name)


# PUT request
if request_data != None:
    response = requests.put(gui_address+ "config/devices", headers=header, json=request_data)

    if response.status_code == 200:
        print(f"Successfuly updated devices: {updated_devices}")
    else:
        print("Failed to update syncthing ids")
        print(f"Request failed with status code: {response.status_code}")

    response = requests.post(gui_address + "system/restart", headers=header)
    if response.status_code == 200:
        print(f"Applied changes")
    else:
        print("Failed to apply changes")
        print(f"Request failed with status code: {response.status_code}")
    

