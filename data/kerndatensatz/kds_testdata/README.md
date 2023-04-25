## Test Data creation
- the data was manually created
- each patient bundle contains one resource for each profile of the basic mdoules from the MII core dataset
- the data is based on fictional short patient stories usually comprising a diagnosis and a related medication, procedure and laboratory result
- each resource was validated after creation on simplifier against the respective mii core dataset package
- for testing, the bundles were uploaded to a jpa-starter server

Testdata kds conform

## Negative Examples

- Condition: recordedDate missing
- DiagnosticReport: basedOn missing
- ObservationLab: category missing
- Encounter: period missing
- Medication: ingredient missing
- MedicationAdministration: subject missing
- MedicationStatement: effective[x] missing
- ObservationVital: value[x] missing
- Patient: Gender using wrong extension
- Prozedur: Prozedure not using OPS or SNOMED-CT codes
- ResearchSubject: Consent missing
- ServiceRequest: authoredOn missing
