*&---------------------------------------------------------------------*
*& Report ZOPENSQL_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zopensql_ss36.

DATA: BEGIN OF gw_cust,
        custtype TYPE scustom-custtype,
        ccount   TYPE i,
      END OF gw_cust.
DATA gt_cust LIKE TABLE OF gw_cust.


SELECT custtype COUNT(*)
  FROM scustom
  INTO TABLE gt_cust
  GROUP BY custtype.

 cl_demo_output=>display_data( gt_cust ).

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
