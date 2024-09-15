*&---------------------------------------------------------------------*
*&  Include           MZBC410_SOLUTION_SS36E01
*&---------------------------------------------------------------------*
LOAD-OF-PROGRAM.
  GET PARAMETER ID:
    'CAR' FIELD sdyn_conn-carrid,
    'CON' FIELD sdyn_conn-connid,
    'DAY' FIELD sdyn_conn-fldate.

SELECT SINGLE *
  FROM sflight
  INTO wa_sflight
  WHERE carrid = sdyn_conn-carrid
  AND connid = sdyn_conn-connid
  AND fldate = sdyn_conn-fldate.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
