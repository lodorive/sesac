*&---------------------------------------------------------------------*
*& Report ZCLIENT_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zclient_ss36.

*DATA it TYPE TABLE OF scarr.

* CLIENT SPECIFIED : �ٸ� Ŭ���̾�Ʈ �����͸� ������ ��

*SELECT *
*  FROM scarr
*  CLIENT SPECIFIED
*  INTO TABLE it
*  WHERE mandt = '000'.
*
*cl_demo_output=>display_data( it ).

* ������ ���̺� �����װ� ����
* KR / Korean Air / KRW / http://www.koreanair.com

DATA wa TYPE zscarr_ss36.
DATA it LIKE TABLE OF wa. "���� �� ������ ���� ���ͳ� ���̺�

*wa-carrid = 'KR'.
*wa-carrname = 'Korean Air'.
*wa-currcode = 'KRW'.
*wa-url = 'http://www.koreanair.com'.
*APPEND wa TO it.
*
**INSERT zscarr_ss36 FROM wa. "�����ͺ��̽��� ����
**WRITE :/ sy-subrc, sy-dbcnt.
*
** America Airline ����, (ȭ������� 'XYZ'��)
*wa-carrid = 'UA'.
*wa-carrname = 'United Airline'.
*wa-currcode = 'USD'.
*wa-url = 'http://www.ua.com'.
*APPEND wa TO it.
*
** ACCEPTING DUPLICATE KEYS : DB Key �� �ߺ��� üũ
*INSERT zscarr_ss36
*FROM TABLE it
*ACCEPTING DUPLICATE KEYS. "�����ͺ��̽��� ����
*
*WRITE :/ sy-subrc, sy-dbcnt.

* UPDATE <���̺�> FROM <��Ʈ����> <- �� ���� �� �� SELECT�� �����ؾ� ��
*SELECT SINGLE *
*  FROM zscarr_ss36
*  INTO wa
*  WHERE carrid = 'AA'.
*
*IF sy-subrc = 0.
*  "XYZ -> USD
*  wa-currcode = 'USD'.
*  UPDATE zscarr_ss36 FROM wa.
*ENDIF.
*
*WRITE :/ sy-subrc, sy-dbcnt.

*UPDATE zscarr_ss36
*SET currcode = 'XYZ'
*WHERE carrid = 'AA'.
*
*WRITE :/ sy-subrc, sy-dbcnt.

* �����Ͱ� ������ ��
*wa-carrid = 'UA'.
*wa-currcode = 'USD'.
*MODIFY zscarr_ss36 FROM wa.

* �����Ͱ� �������� ���� ��
*wa-carrid = 'TT'.
*wa-currcode = 'USD'.
*MODIFY zscarr_ss36 FROM wa.

* �װ��� �̸��� ����� �����͸� ã�Ƽ� �װ��� �̸��� Unknown���� ����
*UPDATE zscarr_ss36
*SET carrname = 'Unknown'
*WHERE carrname = space.

* Ȩ�������� ����ִ� �װ��縦 ��� ����
*DELETE
*FROM zscarr_ss36
*WHERE url = space.

* KR ����
DELETE
FROM zscarr_ss36
WHERE carrid = 'KR'.
WRITE: sy-subrc, sy-dbcnt.

COMMIT WORK. "���� �ݿ�. Ȯ�� ���ڴ�.
ROLLBACK WORK. "DB ���� ���

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
