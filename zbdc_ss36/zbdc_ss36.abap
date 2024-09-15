*&---------------------------------------------------------------------*
*& Report ZBDC_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbdc_ss36.

* ȭ�鿡�� �� �̸�, �� Ÿ��Ʋ, �� ���, ����, ��������
* �Է� �޾� �Է� �����͸� T.CODE : BC401_CALC_CRE_CUST ����
* �����Ͽ� ���� �ڵ����� �������ִ� ���α׷��� ���� (=BDC)

DATA gw_bdc TYPE bdcdata.
DATA gt_bdc LIKE TABLE OF gw_bdc. " �����͸� �ְ� ���� ���ͳ� ���̺�

parameters p_name TYPE scustom-name.
PARAMETERS p_from TYPE scustom-form.
PARAMETERS p_lang TYPE scustom-langu.
PARAMETERS p_coun TYPE scustom-country.

START-OF-SELECTION.

  CLEAR gw_bdc. " ù ��° �� ���� �Ϸ�
  gw_bdc-program = 'SAPBC401_CALD_CREATE_CUSTOMER'. " ���α׷� �̸�
  gw_bdc-dynpro = '0100'.
  gw_bdc-dynbegin = 'X'.
  APPEND gw_bdc TO gt_bdc.

  " 2 ~ 5��° ���� ȭ�鿡 ���� �����ͷ� ����
  CLEAR gw_bdc.
  gw_bdc-fnam = 'SCUSTOM-NAME'. " ���� ȭ���� �̸�
  gw_bdc-fval = p_name. " ȭ�鿡�� �Է� ���� ��
  APPEND gw_bdc TO gt_bdc.

  CLEAR gw_bdc.
  gw_bdc-fnam = 'SCUSTOM-FORM'. " ���� ȭ���� �̸�
  gw_bdc-fval = p_from. " ȭ�鿡�� �Է� ���� ��
  APPEND gw_bdc TO gt_bdc.

  CLEAR gw_bdc.
  gw_bdc-fnam = 'SCUSTOM-COUNTRY'. " ���� ȭ���� �̸�
  gw_bdc-fval = p_coun. " ȭ�鿡�� �Է� ���� ��
  APPEND gw_bdc TO gt_bdc.

  CLEAR gw_bdc.
  gw_bdc-fnam = 'SCUSTOM-LANGU'. " ���� ȭ���� �̸�
  gw_bdc-fval = p_lang. " ȭ�鿡�� �Է� ���� ��
  APPEND gw_bdc TO gt_bdc.

  " SAVE ��ư�� Ŭ�� (ȭ���� ���� ��� ���� ����)
  CLEAR gw_bdc.
  gw_bdc-fnam = 'BDC_OKCODE'.
  gw_bdc-fval = 'SAVE'.
  APPEND gw_bdc TO gt_bdc.

  " ȣ���ϱ�
  CALL TRANSACTION 'BC401_CALD_CRE_CUST'
             USING gt_bdc
             MODE 'N'. " N : ȭ���� �� ���� ���� �ְڴ�
                       " A : ȭ���� ���� ����ְڴ�
                       " E :ȭ���� �� ���� ��������ǵ� ������ �߸� ȭ���� ����� ����

  IF sy-subrc <> 0.
    WRITE: 'Fail...'.
  ELSE.
    WRITE: 'Created!'.
  ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
