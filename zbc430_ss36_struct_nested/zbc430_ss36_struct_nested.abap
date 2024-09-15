*&---------------------------------------------------------------------*
*& Report  SAPBC430S_STRUCT_NESTED                                     *
*&                                                                     *
*&---------------------------------------------------------------------*
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  zbc430_ss36_struct_nested                                     .

**Replace ## by Your group- or screennumber and
**uncomment the ABAP-coding
*
DATA wa_person TYPE zperson_ss36.

START-OF-SELECTION.

  wa_person-name-firstname = 'Harry'.
  wa_person-name-lastname = 'Potter'.

  wa_person-street = 'Privet Drive'.
  wa_person-nr = '3'.
  wa_person-zip = 'GB-10889'.
  wa_person-city = 'London'.

  WRITE: /  wa_person-name-firstname ,
            wa_person-name-lastname ,
            wa_person-street ,
            wa_person-nr ,
            wa_person-zip ,
            wa_person-city .

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
