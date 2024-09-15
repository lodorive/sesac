*&---------------------------------------------------------------------*
*& Report ZBC400_USERINFO__SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_USERINFO_SS36.

PARAMETERS p_user TYPE BAPIBNAME-BAPIBNAME.

CALL FUNCTION 'BAPI_USER_DISPLAY'
  EXPORTING
    username       = p_user.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
