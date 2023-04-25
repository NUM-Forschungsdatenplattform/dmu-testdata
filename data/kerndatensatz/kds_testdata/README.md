# kds_testdata

## Test Data creation
- manual creation
- each patient contains one resource of each profile of the MII core dataset
- the data is based on fictional short patient stories usually comprising of a diagnosis and a realted medication, procedure and laboratory result
- each resource was validated after creation on simplifier against the respective mii core dataset package
- each bundle was uploaded to a jpa-starter server

Testdata kds conform

### NegativeBeispiele

- Condition: recordedDate fehlt
- DiagnosticReport: basedOn fehlt
- ObservationLab: category fehlt
- Encounter: period fehlt
- Medication: ingredient fehlt
- MedicationAdministration: subject fehlt
- MedicationStatement: effective[x] fehlt
- ObservationVital: value[x] fehlt
- Patient: Geschlechtsangabe 'other', aber das gender nicht 'other'
- Prozedur: Prozedur nicht mit OPS oder SNOMED-CT kodiert
- ResearchSubject: Consent fehlt
- ServiceRequest: authoredOn fehlt
