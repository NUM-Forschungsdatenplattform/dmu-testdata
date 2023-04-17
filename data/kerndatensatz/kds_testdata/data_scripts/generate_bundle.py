import os
import json
# Define the folder where the separate JSON files are stored
patient = "001"
in_path = "/home/gregor/Desktop/kds_testdata/Patients/001/resources"
outpath = "/home/gregor/Desktop/kds_testdata/Patients/001/bundle.json"

bundle_header_str = '''
{
  "resourceType": "Bundle",
  "id": "bundle-123",
  "type": "transaction"
}
'''
bundle_header_dict = json.loads(bundle_header_str)
# Initialize an empty list to store the BundleEntry objects
bundle_entries = []



# Loop through each file in the folder
for file_name in os.listdir(in_path):
    file_path = os.path.join(in_path, file_name)
    with open(file_path, "r") as f:
        # Load the JSON file as a dictionary
        resource_dict = json.load(f)
        # Set the full URL of the BundleEntry to the file name
        fullUrl = f"{resource_dict['resourceType']}/{resource_dict['id']}"
        resource_dict["fullUrl"] = fullUrl
        # Add the BundleEntry to the list
        bundle_entries.append(resource_dict)
        resource_dict["request"] = {"method": "PUT", "url": f"Patient/{patient}"}

# Create a Bundle object and add the BundleEntry objects as entries
bundle_header_dict["entry"] = bundle_entries
# Serialize the Bundle object to JSON
bundle_json = json.dumps(bundle_header_dict, indent=4)

# Write the JSON to a file
with open(outpath, "w") as f:
    f.write(bundle_json)