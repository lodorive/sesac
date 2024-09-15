*&---------------------------------------------------------------------*
*& Report ZAVG_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAVG_SS36.

* AA 항공사의 고객 유형별 평균 매출
DATA: BEGIN OF gw_avg,
  custtype TYPE sbook-custtype,
  avg TYPE sbook-loccuram,
  END OF gw_avg.
DATA gt_avg LIKE TABLE OF gw_avg.

SELECT custtype AVG( loccuram )
  FROM sbook
  INTO TABLE gt_avg
  WHERE carrid = 'AA'
  GROUP BY custtype.

 cl_demo_output=>display_data( gt_avg ).

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
