#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE 'Protheus.ch'
#INCLUDE 'FWMVCDef.ch'

//------------------------------------------------------------------------
/*
EXEMPLO DE INCLUS�O MODELO 1
*/
//------------------------------------------------------------------------
/*User Function m010IncRa()
Local oModel      := Nil
Private lMsErroAuto := .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

oModel  := FwLoadModel ("MATA010")
oModel:SetOperation(MODEL_OPERATION_INSERT)
oModel:Activate()
oModel:SetValue("SB1MASTER","B1_COD"        ,"RASB101")
oModel:SetValue("SB1MASTER","B1_DESC"       ,"PRODUTO TESTE 01")
oModel:SetValue("SB1MASTER","B1_TIPO"       ,"PA")
oModel:SetValue("SB1MASTER","B1_UM"         ,"UN")
oModel:SetValue("SB1MASTER","B1_LOCPAD"     ,"01")
//oModel:SetValue("SB1MASTER","B1_LOCALIZ"    ,"N")


If oModel:VldData()
    oModel:CommitData()
     MsgInfo("Registro INCLUIDO!", "Aten��o")
Else
    VarInfo("",oModel:GetErrorMessage())
EndIf

oModel:DeActivate()
oModel:Destroy()

oModel := NIL

Return Nil*/
//------------------------------------------------------------------------
/*
EXEMPLO DE INCLUS�O MODELO 1  (Utilizando a fun��o FwMvcRotAuto apenas em car�ter did�tico)
*/
//------------------------------------------------------------------------
/*User Function m010Inc1Ra()
Local aDadoscab := {}
Local aDadosIte := {}
Local aItens := {}

Private oModel := Nil
Private lMsErroAuto := .F.
Private aRotina := {}

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "EST"

oModel := FwLoadModel ("MATA010")

//Adicionando os dados do ExecAuto cab
aAdd(aDadoscab, {"B1_COD" ,"RASB101" , Nil})
aAdd(aDadoscab, {"B1_DESC" ,"PRODUTO TESTE" , Nil})
aAdd(aDadoscab, {"B1_TIPO" ,"PA" , Nil})
aAdd(aDadoscab, {"B1_UM" ,"UN" , Nil})
aAdd(aDadoscab, {"B1_LOCPAD" ,"01" , Nil})
aAdd(aDadoscab, {"B1_LOCALIZ" ,"N" , Nil})

//Chamando a inclus�o - Modelo 1
lMsErroAuto := .F.

FWMVCRotAuto( oModel,"SB1",MODEL_OPERATION_INSERT,{{"SB1MASTER", aDadoscab}})

//Se houve erro no ExecAuto, mostra mensagem
If lMsErroAuto
 MostraErro()
//Sen�o, mostra uma mensagem de inclus�o
Else
 MsgInfo("Registro incluido!", "Aten��o")
EndIf


Return Nil
 */
//------------------------------------------------------------------------
/*
EXEMPLO DE INCLUS�O MODELO 2 (Utilizando a fun��o FwMvcRotAuto apenas em car�ter did�tico)
*/
//------------------------------------------------------------------------

User Function m010Inc2Ra()
Local aDadoscab := {}
Local aDadosIte := {}
Local aItens := {}

Private oModel := Nil
Private lMsErroAuto := .F.
Private aRotina := {}

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" //MODULO "EST"

oModel := FwLoadModel ("MATA010")

//Adicionando os dados do ExecAuto cab
aAdd(aDadoscab, {"B1_COD"       ,"RASB103"          , Nil})
aAdd(aDadoscab, {"B1_DESC"      ,"PRODUTO TESTE"    , Nil})
aAdd(aDadoscab, {"B1_TIPO"      ,"PA"               , Nil})
aAdd(aDadoscab, {"B1_UM"        ,"UN"               , Nil})
aAdd(aDadoscab, {"B1_LOCPAD"    ,"01"               , Nil})
aAdd(aDadoscab, {"B1_LOCALIZ"   ,"N"                , Nil})

//Adicionando os dados do ExecAuto Item
//Produtos alternativos (j� deve existir na base)
If "SGI" $ SuperGetMv("MV_CADPROD",,"|SA5|SBZ|SB5|DH5|SGI|")
 aAdd(aDadosIte, {"GI_PRODALT"  , "RASB100" , Nil})
 aAdd(aDadosIte, {"GI_ORDEM"    , "1"       , Nil})
 //no item o array precisa de um nivel superior.
 aAdd(aItens,aDadosIte)
EndIf

//Chamando a inclus�o - Modelo 2
lMsErroAuto := .F.

FWMVCRotAuto( oModel,"SB1",MODEL_OPERATION_INSERT,{{"SB1MASTER", aDadoscab},{"SGIDETAIL", aItens}})

If�(lMsErroAuto�==�.T.)
��������aLog�:=�oModel:GetErrorMessage()

��������For�nX�:=�1�To�Len(aLog)
������������If�!Empty(aLog[nX])
����������������sLog�+=�Alltrim(aLog[nX])�+�CRLF
������������EndIf
��������Next�nX

��������AutoGRLog(sLog)
��������MostraErro()
��������ConOut(Repl("-",�80))
��������ConOut(PadC("Teste GFEA032 finalizado com erro!",�80))
��������ConOut(PadC("Fim: "�+�Time(),�80))
��������ConOut(Repl("-",�80))
����Else
��������ConOut(Repl("-",�80))
��������ConOut(PadC("Teste GFEA032 finalizado com sucesso!",�80))
��������ConOut(PadC("Fim: "�+�Time(),�80))
��������ConOut(Repl("-",�80))
����EndIf

//Se houve erro no ExecAuto, mostra mensagem
/*If lMsErroAuto
 MostraErro()
//Sen�o, mostra uma mensagem de inclus�o
Else
 MsgInfo("Registro incluido!", "Aten��o")
EndIf*/
RESET ENVIRONMENT

Return Nil

//------------------------------------------------------------------------
/*
EXEMPLO DE ALTERA��O
*/
//------------------------------------------------------------------------
/*
User Function m010AltRa()
Local oModel := Nil
Private lMsErroAuto := .F.

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "EST"

//Posiciona
SB1->(DbSetOrder(1))
If SB1->(DbSeek(xFilial("SB1") + "RASB101"))
 oModel := FwLoadModel ("MATA010")
 oModel:SetOperation(MODEL_OPERATION_UPDATE)
 oModel:Activate()
 oModel:SetValue("SB1MASTER","B1_DESC","PRODUTO ALTERADO")

If oModel:VldData()
 oModel:CommitData()
 MsgInfo("Registro ALTERADO!", "Aten��o")
 Else
 VarInfo("",oModel:GetErrorMessage())
 EndIf

 oModel:DeActivate()
Else
 MsgInfo("Registro NAO LOCALIZADO!", "Aten��o")
EndIf

Return Nil
*/
//------------------------------------------------------------------------
/*
EXEMPLO DE EXCLUS�O
*/
//------------------------------------------------------------------------
/*
User Function m010ExcRa()
Local oModel := Nil
Private aRotina := {}

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "EST"
//Posiciona
SB1->(DbSetOrder(1))
If SB1->(DbSeek(xFilial("SB1") + "RASB101"))
 oModel := FwLoadModel ("MATA010")
 oModel:SetOperation(MODEL_OPERATION_DELETE)
 oModel:Activate()

If oModel:VldData()
 oModel:CommitData()
 MsgInfo("Registro EXCLUIDO!", "Aten��o")
 Else
 VarInfo("",oModel:GetErrorMessage())
 EndIf

 oModel:DeActivate()
Else
 MsgInfo("Registro NAO LOCALIZADO!", "Aten��o")
EndIf

Return Nil*/
