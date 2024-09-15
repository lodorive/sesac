*&---------------------------------------------------------------------*
*& Report ZABAP_JOIN_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_join_ss36.

TYPES: BEGIN OF ts_data,
         id       TYPE zscore_ss36-id,
         name     TYPE zstd_ss36-name,
         subject  TYPE zscore_ss36-subject,
         text     TYPE zsubject_ss36t-text,
         score    TYPE zscore_ss36-score,
       END OF ts_data.

DATA it_data TYPE TABLE OF ts_data.

** ABAP JOIN 문법
*SELECT zscore_ss36~id
*       zstd_ss36~name
*       zscore_ss36~subject
*       zscore_ss36~score
*  FROM zscore_ss36 INNER JOIN zstd_ss36
*  ON zscore_ss36~id = zstd_ss36~id "Join Condition
*  INTO TABLE it_data.

** ABAP JOIN 문법(AS 별칭)
*SELECT score~id
*     std~name
*     score~subject
*     score~score
*FROM zscore_ss36 AS score
*INNER JOIN zstd_ss36 AS std
*ON score~id = std~id "Join Condition
*INTO TABLE it_data.

* ABAP JOIN 문법(AS 별칭)
* zsubject_ss36t까지 추가해서 과목에 대한 텍스트 출력
SELECT score~id
       std~name
       score~subject
       text~text
       score~score
  FROM zscore_ss36 AS score
INNER JOIN zstd_ss36 AS std
      ON score~id = std~id "Join Condition
INNER JOIN zsubject_ss36t AS text
      ON text~subject = score~subject "Join Condition
      AND text~langu = sy-langu
INTO TABLE it_data.


cl_demo_output=>display_data( it_data ).

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
