#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

### loads the '.env' file
set dotenv-load

### some variables
vhf_01 := "VHF-Testdaten_01-VHF00001-VHF01000.json.zip"
vhf_02 := "VHF-Testdaten_01-VHF01001-VHF02000.json.zip"
vhf_03 := "VHF-Testdaten_01-VHF02001-VHF03000.json.zip"
vhf_04 := "VHF-Testdaten_01-VHF03001-VHF04000.json.zip"
vhf_05 := "VHF-Testdaten_01-VHF04001-VHF05000.json.zip"
vhf_06 := "VHF-Testdaten_01-VHF05001-VHF06000.json.zip"
vhf_07 := "VHF-Testdaten_01-VHF06001-VHF07000.json.zip"
vhf_08 := "VHF-Testdaten_01-VHF07001-VHF08000.json.zip"
vhf_09 := "VHF-Testdaten_01-VHF08001-VHF09000.json.zip"
vhf_10 := "VHF-Testdaten_01-VHF09001-VHF10000.json.zip"

vhf_folder := "./data/kerndatensatz/vhf"
vhf_extracted := "./extracted/kerndatensatz/vhf"

### commands

# vhf_clean, vhf_all_unzip, vhf_upload
all: vhf_clean vhf_all_unzip vhf_upload

# unzips all vhf zip files in './data/kerndatensatz/vhf'
vhf_all_unzip: vhf_01_unzip vhf_02_unzip vhf_03_unzip vhf_04_unzip vhf_05_unzip vhf_06_unzip vhf_07_unzip vhf_08_unzip vhf_09_unzip vhf_10_unzip

# unzips VHF-Testdaten_01-VHF00001-VHF01000.json.zip
vhf_01_unzip:
    unzip {{vhf_folder}}/{{vhf_01}} -d {{vhf_extracted}}

# unzips VHF-Testdaten_01-VHF01001-VHF02000.json.zip
vhf_02_unzip:
    unzip {{vhf_folder}}/{{vhf_02}} -d {{vhf_extracted}}

# unzips VHF-Testdaten_01-VHF02001-VHF03000.json.zip
vhf_03_unzip:
    unzip {{vhf_folder}}/{{vhf_03}} -d {{vhf_extracted}}

# unzips VHF-Testdaten_01-VHF03001-VHF04000.json.zip
vhf_04_unzip:
    unzip {{vhf_folder}}/{{vhf_04}} -d {{vhf_extracted}}

# unzips VHF-Testdaten_01-VHF04001-VHF05000.json.zip
vhf_05_unzip:
    unzip {{vhf_folder}}/{{vhf_05}} -d {{vhf_extracted}}

# unzips VHF-Testdaten_01-VHF05001-VHF06000.json.zip
vhf_06_unzip:
    unzip {{vhf_folder}}/{{vhf_06}} -d {{vhf_extracted}}

# unzips VHF-Testdaten_01-VHF06001-VHF07000.json.zip
vhf_07_unzip:
    unzip {{vhf_folder}}/{{vhf_07}} -d {{vhf_extracted}}

# unzips VHF-Testdaten_01-VHF07001-VHF08000.json.zip
vhf_08_unzip:
    unzip {{vhf_folder}}/{{vhf_08}} -d {{vhf_extracted}}

# unzips VHF-Testdaten_01-VHF08001-VHF09000.json.zip
vhf_09_unzip:
    unzip {{vhf_folder}}/{{vhf_09}} -d {{vhf_extracted}}

# unzips VHF-Testdaten_01-VHF09001-VHF10000.json.zip
vhf_10_unzip:
    unzip {{vhf_folder}}/{{vhf_10}} -d {{vhf_extracted}}

# deletes all json files in './extracted/kerndatensatz/vhf'
vhf_clean:
    #!/usr/bin/env bash
    find {{vhf_extracted}} -type f -name '*.json' -delete

# uploads all json files in './extracted/kerndatensatz/vhf'
vhf_upload:
    #!/usr/bin/env bash
    set -euo pipefail
    TOKEN=NOT_SET

    if [ $OAUTH_ENABLED ]; then

        if [ -r $HOME/.dmu/credentials ]; then
            
            export $(xargs < $HOME/.dmu/credentials)
            
            echo "OAUTH IS ENABLED, CREDENTIALS EXISTS, FETCH TOKEN ..."
            echo "USE IAM_TOKEN_ENDPOINT_URL : $IAM_TOKEN_ENDPOINT_URL"
            
            response=$(curl $FETCH_TOKEN_CURL_OPTIONS POST "$IAM_TOKEN_ENDPOINT_URL" \
            --header 'Content-Type: application/x-www-form-urlencoded' \
            --data-urlencode "client_id=$client_id" \
            --data-urlencode "client_secret=$client_secret" \
            --data-urlencode 'grant_type=client_credentials')
            
            TOKEN=$(jq -r '.access_token' <<< "${response}")
            
            echo "TOKEN SUCCESSFULLY SET ..."
        else
            echo "UNABLE TO FIND 'credentials' FILE, ABORT ..."
            exit 1
        fi
    else
        echo "OAUTH IS NOT ENABLED, NO TOKEN FETCHED ..."
    fi

    FILES=("{{vhf_extracted}}"/*.json)
    count=0
    for fhirBundle in "${FILES[@]}"; do
    echo "Sending Testdata bundle $fhirBundle ..."
    curl $UPLOAD_CURL_OPTIONS -X POST -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d @"$fhirBundle" "$FHIR_STORE_URL"
    count=$((count + 1))
    echo $count
    if [[ "$count" -eq 1000 ]]
    then
        count=0
        sleep 5
    fi
    done
