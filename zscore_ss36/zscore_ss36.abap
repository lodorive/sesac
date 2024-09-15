*&---------------------------------------------------------------------*
*& Report ZSCORE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSCORE_SS36.

* ȭ�鿡�� ������ �Է� �޾Ƽ� �ش� ������
* ����� �л��� ����Ʈ ��.

*PARAMETERS pa_age TYPE ZSTD_SS36-age value CHECK.
*
*WRITE:/'Listing....'.
*

* ������ �л� ���� ���̺��� ���� ��հ� �հ踦 ���ϴ� ���α׷��� �����Ͻÿ�
DATA: BEGIN OF gw_score,
    subject TYPE ZSCORE_SS36-subject,
    avg TYPE ZSCORE_SS36-score,
    sum TYPE p LENGTH 5 DECIMALS 2,
END OF gw_score.

DATA gt_score LIKE TABLE OF gw_score.

SELECT subject avg( score ) sum( score )
  FROM ZSCORE_SS36
  INTO TABLE gt_score
  GROUP BY subject.

  cl_demo_output=>display_data( gt_score ).

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
