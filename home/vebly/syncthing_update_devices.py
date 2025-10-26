#https://docs.syncthing.net/rest/config.html
from lxml import etree
import requests 
import os
import copy

secrets_path = "/run/secrets/syncthing/"

def sops_ls(relative_folder_path):
    result = []
    try: 
        children = os.listdir(secrets_path + relative_folder_path)
        for child in children:
            result.append(child)
    except: 
        print(f"Unable to list contents of {secrets_path + relative_folder_path}")
    return result

    
def get_sops_data(relative_path):
    data = []
    try:
        with open(secrets_path + relative_path, "r") as file:
            for line in file:
                data.append(line.strip())  # Read and strip each line
    except: print(f"No secret: {relative_path}")
    finally:
        return data
        

# Get SOPS data
device_names = sops_ls("devices")
folder_names = sops_ls("folders")


# Find API key and URL in config.xml
tree = etree.parse('/home/vebly/.config/syncthing/config.xml') 
root = tree.getroot()
apikey_node = root.find('gui/apikey')
gui_address_node = root.find('gui/address')
apikey = apikey_node.text
gui_address = "http://" + gui_address_node.text + "/rest/"
header = {"X-API-Key": apikey}


# Prepare PUT request data
device_request_data = []
folder_request_data = []
updated_devices = [] 
updated_folders = [] 

DEFAULT_DEVICE_DATA = requests.get(gui_address + "config/defaults/device", headers=header).json()
DEFAULT_FOLDER_DATA = requests.get(gui_address + "config/defaults/folder", headers=header).json()
for device_name in device_names:
        device_data = copy.deepcopy(DEFAULT_DEVICE_DATA)
        deviceID = get_sops_data(f"devices/{device_name}/id") 
        if deviceID:  # Required attributes
            device_data["deviceID"] = deviceID[0]
            device_data['name'] = device_name
            addresses = get_sops_data(f"devices/{device_name}/addresses")
            if addresses:
                device_data["addresses"] += addresses
            device_request_data.append(device_data)
            updated_devices.append(device_name)


for folder_name in folder_names:
    folder_data = copy.deepcopy(DEFAULT_FOLDER_DATA)
    folder_data["id"] = folder_name
    folder_data["label"] = folder_name
    folder_path = get_sops_data(f"folders/{folder_name}/path")
    if folder_path:
        folder_data["path"] = folder_path[0]
    folder_devices_names = get_sops_data(f"folders/{folder_name}/devices")
    folder_data["devices"] = [] #Remove default folder
    for device_name in folder_devices_names:
        device_data = copy.deepcopy(DEFAULT_FOLDER_DATA["devices"][0])
        device_id = get_sops_data(f"devices/{device_name}/id")
        if device_id:
            device_data["deviceID"] = device_id[0]
        folder_data["devices"].append(device_data)
    folder_request_data.append(folder_data)
    updated_folders.append(folder_name)

# Requests
response = None
# Devices
device_update_response = None
if device_request_data is None:
    print("No devices were updated")
else:
    response = requests.put(gui_address + "config/devices", headers=header, json=device_request_data)
    if response.status_code == 200:
        print(f"Updated devices: {updated_devices}")
    else:
        print(f"Failed to update devices, {response.status_code}")

# Folders
folders_update_response = None
if folder_request_data is None:
    print("No folders were updated")
else:
    response = requests.put(gui_address + "config/folders", headers=header, json=folder_request_data)
    if response.status_code == 200:
        print(f"Updated folders: {updated_folders}")
    else:
        print(f"Failed to update folders, status code: {response.status_code}")
        print(response.text)


# Restart syncthing
response = requests.post(gui_address + "system/restart", headers=header)
if response.status_code == 200:
    print("Successfully restarted syncthing")
else:
    print(f"Failed to restart syncthing, status_code: {response.status_code}")

