import os
import shutil

# array patient ids 002-015 in string
patient_ids = [str(i).zfill(3) for i in range(2, 16)]


# path to patient data
filepath = os.path.abspath(__file__)
patient_path = os.path.dirname(os.path.dirname(filepath)) + '/Patients/'

src_dir = os.path.join(patient_path, '001')
# copy patient 001
for id in patient_ids:
    dest_dir = os.path.join(patient_path, id)
    shutil.copytree(src_dir, dest_dir)
