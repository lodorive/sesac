*&---------------------------------------------------------------------*
*& Report ZPROJECTION_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprojection_ss36.

DATA it_book TYPE TABLE OF zvproject_ss36.

SELECT * " <----- 7���� �÷��� ���
  FROM zvproject_ss36
  INTO TABLE it_book.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
