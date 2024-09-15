*&---------------------------------------------------------------------*
*& Report ZBC430_SS36_STRUCT_DEEP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC430_SS36_STRUCT_DEEP.

* Exercise4

DATA wa_person TYPE ZPERSON_SS36.
*DATA wa_phone TYPE STR_PHONE.
DATA wa_phone LIKE LINE OF wa_person-phone.

START-OF-SELECTION.

  wa_person-name-firstname = 'Harry'.
  wa_person-name-lastname = 'Potter'.

  wa_person-street = 'Privet Drive'.
  wa_person-nr = '3'.
  wa_person-zip = 'GB-10889'.
  wa_person-city = 'London'.

  wa_phone-p_number = '010-1234-5678'.
  wa_phone-p_type = 'type..'.
  INSERT wa_phone INTO TABLE wa_person-phone.


  WRITE: /  wa_person-name-firstname ,
            wa_person-name-lastname ,
            wa_person-street ,
            wa_person-nr ,
            wa_person-zip ,
            wa_person-city.

  LOOP AT wa_person-phone INTO wa_phone.

    WRITE:/
    wa_phone-p_number,
    wa_phone-p_type.

    ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
