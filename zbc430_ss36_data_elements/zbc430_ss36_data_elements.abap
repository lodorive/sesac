*&---------------------------------------------------------------------*
*& Report ZBC430_SS36_DATA_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc430_ss36_data_elements.

PARAMETERS: pa_fname TYPE zfirstname_ss36,
            pa_lname TYPE zlastname_ss36,
            pa_activ TYPE zassets_ss36,
            pa_liabs TYPE zliabilities_ss36.

DATA result TYPE zassets_ss36.
result = pa_activ - pa_liabs.

START-OF-SELECTION.
  WRITE:/ 'First Name:', pa_fname.
  WRITE:/ 'Last Name:', pa_lname.
  WRITE:/ 'result:', result.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
