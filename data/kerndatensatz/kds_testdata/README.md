# kds_testdata

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
