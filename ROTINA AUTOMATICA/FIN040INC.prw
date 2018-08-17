#include 'protheus.ch'
#include 'parmtype.ch'
#Include "Tbiconn.ch"


USER FUNCTION FIN040INC()
LOCAL aArray := {}

PRIVATE lMsErroAuto := .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

aArray := { { "E1_PREFIXO"  , "AUT"             , NIL },;
            { "E1_NUM"      , "1199"            , NIL },;
            { "E1_TIPO"     , "RA"              , NIL },;
            { "E1_NATUREZ"  , "0000000001"      , NIL },;
            { "E1_CLIENTE"  , "000001"          , NIL },;
            { "E1_EMISSAO"  , CtoD("03/08/2018"), NIL },;
            { "E1_VENCTO"   , CtoD("03/08/2018"), NIL },;
            { "E1_VENCREA"  , CtoD("03/08/2018"), NIL },;
            { "E1_VALOR"    , 5000              , NIL } }

MsExecAuto( { |x,y| FINA040(x,y)} , aArray, 3)  // 3 - Inclusao, 4 - Altera��o, 5 - Exclus�o


    If lMsErroAuto
        MostraErro()
    Else
        Alert("T�tulo inclu�do com sucesso!")
    Endif

 RESET ENVIRONMENT

Return
