*&---------------------------------------------------------------------*
*& Report ZFLAT_STRUCTURE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zflat_structure_ss36.

DATA gs_student TYPE zstudent_ss36.

* 1/È«±æµ¿/24/99.00 ¼³Á¤
gs_student-stdid = 1.
gs_student-stdname = 'È«±æµ¿'.
gs_student-stdage = 24.
gs_student-stdscore = '99.00'.

WRITE:/ gs_student-stdid,
        gs_student-stdname,
        gs_student-stdage,
        gs_student-stdscore.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
