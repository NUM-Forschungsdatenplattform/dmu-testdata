# dmu-testdata

### Install `just`

This setup is using [`just`](https://just.systems/man/en/chapter_1.html) to run project-specific commands.
To install it on your system [have a look at prepared packages list and pick one for your environment](https://just.systems/man/en/chapter_4.html).

### Clone the project

```
git clone ....
```

### Getting started

To get an overview of provided commands, type `just -l` in the root folder of this project. With `just` installed properly
you should see something like this:

```
➜  dmu-testdata just -l
Available recipes:
    all           # vhf_clean, vhf_all_unzip, vhf_upload
    vhf_01_unzip  # unzips VHF-Testdaten_01-VHF00001-VHF01000.json.zip
    vhf_02_unzip  # unzips VHF-Testdaten_01-VHF01001-VHF02000.json.zip
    vhf_03_unzip  # unzips VHF-Testdaten_01-VHF02001-VHF03000.json.zip
    vhf_04_unzip  # unzips VHF-Testdaten_01-VHF03001-VHF04000.json.zip
    vhf_05_unzip  # unzips VHF-Testdaten_01-VHF04001-VHF05000.json.zip
    vhf_06_unzip  # unzips VHF-Testdaten_01-VHF05001-VHF06000.json.zip
    vhf_07_unzip  # unzips VHF-Testdaten_01-VHF06001-VHF07000.json.zip
    vhf_08_unzip  # unzips VHF-Testdaten_01-VHF07001-VHF08000.json.zip
    vhf_09_unzip  # unzips VHF-Testdaten_01-VHF08001-VHF09000.json.zip
    vhf_10_unzip  # unzips VHF-Testdaten_01-VHF09001-VHF10000.json.zip
    vhf_all_unzip # unzips all vhf zip files in './data/kerndatensatz/vhf'
    vhf_clean     # deletes all json files in './extracted/kerndatensatz/vhf'
    vhf_upload    # uploads all json files in './extracted/kerndatensatz/vhf'
```

Start with simple commands to unzip some test data:

```
just vhf_01_unzip
```

for the first thousand data files, or you can run:

```
just vhf_all_unzip
```
To extract data from all provided zip files.

Now have a look into `./extracted/kerndatensatz/vhf`. You should see tons of json files extracted from the zips:

```
...
...
VHF-Testdaten_01-VHF09995.json  
VHF-Testdaten_01-VHF09996.json  
VHF-Testdaten_01-VHF09997.json  
VHF-Testdaten_01-VHF09998.json  
VHF-Testdaten_01-VHF09999.json  
VHF-Testdaten_01-VHF10000.json
```

