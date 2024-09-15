*&---------------------------------------------------------------------*
*& Report ZBDC_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbdc_ss36.

* 화면에서 고객 이름, 고객 타이틀, 고객 언어, 국가, 할인율을
* 입력 받아 입력 데이터를 T.CODE : BC401_CALC_CRE_CUST 에게
* 전달하여 고객을 자동으로 생성해주는 프로그램을 구현 (=BDC)

DATA gw_bdc TYPE bdcdata.
DATA gt_bdc LIKE TABLE OF gw_bdc. " 데이터를 주고 받을 인터널 테이블

parameters p_name TYPE scustom-name.
PARAMETERS p_from TYPE scustom-form.
PARAMETERS p_lang TYPE scustom-langu.
PARAMETERS p_coun TYPE scustom-country.

START-OF-SELECTION.

  CLEAR gw_bdc. " 첫 번째 행 구성 완료
  gw_bdc-program = 'SAPBC401_CALD_CREATE_CUSTOMER'. " 프로그램 이름
  gw_bdc-dynpro = '0100'.
  gw_bdc-dynbegin = 'X'.
  APPEND gw_bdc TO gt_bdc.

  " 2 ~ 5번째 행은 화면에 던질 데이터로 구성
  CLEAR gw_bdc.
  gw_bdc-fnam = 'SCUSTOM-NAME'. " 던질 화면의 이름
  gw_bdc-fval = p_name. " 화면에서 입력 받은 값
  APPEND gw_bdc TO gt_bdc.

  CLEAR gw_bdc.
  gw_bdc-fnam = 'SCUSTOM-FORM'. " 던질 화면의 이름
  gw_bdc-fval = p_from. " 화면에서 입력 받은 값
  APPEND gw_bdc TO gt_bdc.

  CLEAR gw_bdc.
  gw_bdc-fnam = 'SCUSTOM-COUNTRY'. " 던질 화면의 이름
  gw_bdc-fval = p_coun. " 화면에서 입력 받은 값
  APPEND gw_bdc TO gt_bdc.

  CLEAR gw_bdc.
  gw_bdc-fnam = 'SCUSTOM-LANGU'. " 던질 화면의 이름
  gw_bdc-fval = p_lang. " 화면에서 입력 받은 값
  APPEND gw_bdc TO gt_bdc.

  " SAVE 버튼을 클릭 (화면의 값을 모두 던진 다음)
  CLEAR gw_bdc.
  gw_bdc-fnam = 'BDC_OKCODE'.
  gw_bdc-fval = 'SAVE'.
  APPEND gw_bdc TO gt_bdc.

  " 호출하기
  CALL TRANSACTION 'BC401_CALD_CRE_CUST'
             USING gt_bdc
             MODE 'N'. " N : 화면을 안 보고 집어 넣겠다
                       " A : 화면을 보고 집어넣겠다
                       " E :화면을 안 보고 집어넣을건데 에러가 뜨면 화면을 띄워서 볼게

  IF sy-subrc <> 0.
    WRITE: 'Fail...'.
  ELSE.
    WRITE: 'Created!'.
  ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
