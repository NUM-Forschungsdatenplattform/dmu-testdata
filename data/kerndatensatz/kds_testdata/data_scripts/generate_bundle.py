import os
import json

def generate_header(patient):
  bundle_id = patient
  bundle_type = "transaction"
  bundle_header_str = f'{{"resourceType": "Bundle", "id": "{bundle_id}", "type": "{bundle_type}"}}'
  return bundle_header_str

def add_references(bundle_entries, ref_path):
  references = os.listdir(ref_path)
  for reference in references:
    with open(os.path.join(ref_path, reference), "r") as f:
      reference_dict = json.load(f)
      # add request
      reference_dict["request"] = {"method": "POST", "url": f"{reference_dict['resourceType']}"}
      # add fullUrl
      fullUrl = f"{reference_dict['resourceType']}/{reference_dict['id']}"
      reference_dict["fullUrl"] = fullUrl
      # add to bundle_entries
      bundle_entries.append(reference_dict)
  return bundle_entries


def generate_bundle_entries(in_path):
  # Initialize an empty list to store the BundleEntry objects
  bundle_entries = []
  # Loop through each file in the folder
  for file_name in os.listdir(in_path):
      file_path = os.path.join(in_path, file_name)
      print(file_path)
      with open(file_path, "r") as f:
          # Load the JSON file as a dictionary
          resource_dict = json.load(f)
          # Set the full URL of the BundleEntry to the file name
          fullUrl = f"{resource_dict['resourceType']}/{resource_dict['id']}"
          resource_dict["fullUrl"] = fullUrl
          # Add the BundleEntry to the list
          bundle_entries.append(resource_dict)
          resource_dict["request"] = {"method": "POST", "url": f"{resource_dict['resourceType']}"}
  
  bundle_entries = add_references(bundle_entries, ref_path)
  return bundle_entries



# Define the folder where the separate JSON files are stored
abs_path = os.path.abspath(__file__)
dir_name = os.path.dirname(abs_path)
base_path = os.path.dirname(dir_name)
ref_path = os.path.join(base_path, "references")

# get dirs in Patients
patients_dir = os.path.join(base_path, "Patients")
patients = os.listdir(patients_dir)

for patient in patients:
  bundle_header_str = generate_header(patient)
  in_path = os.path.join(base_path, f"Patients/{patient}/resources")
  outpath = os.path.join(base_path, f"Patients/{patient}/patient_{patient}.json") 
  bundle_header_dict = json.loads(bundle_header_str)

  bundle_entries = generate_bundle_entries(in_path)

  # Create a Bundle object and add the BundleEntry objects as entries
  bundle_header_dict["entry"] = bundle_entries
  # Serialize the Bundle object to JSON
  bundle_json = json.dumps(bundle_header_dict, indent=4, ensure_ascii=False)

  # Write the JSON to a file
  with open(outpath, "w") as f:
      f.write(bundle_json)

