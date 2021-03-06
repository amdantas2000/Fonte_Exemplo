#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

User Function MyMata410()

Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local aArea  := {}
Local nX     := 0
Local nY     := 0
Local cDoc   := ""
Local lOk    := .T.

PRIVATE lMsErroAuto := .F.
//****************************************************************
//* Abertura do ambiente
//****************************************************************
ConOut(Repl("-",80))
ConOut(PadC("Teste de Inclusao de 5 pedidos de venda  com 10 itens cada",80))
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT" TABLES "SC5","SC6","SA1","SA2","SB1","SB2","SF4"
//RPCSetEnv("99", "10")
		//aArea := GetArea()

//****************************************************************
//* Verificacao do ambiente para teste
//****************************************************************
dbSelectArea("SB1")
dbSetOrder(1)
If !SB1->(MsSeek(xFilial("SB1")+"SERV0001       "))
    lOk := .F.
    ConOut("Cadastrar produto: SERV0001       ")
EndIf
dbSelectArea("SF4")
dbSetOrder(1)
If !SF4->(MsSeek(xFilial("SF4")+"503"))
    lOk := .F.
    ConOut("Cadastrar TES: 503")
EndIf
dbSelectArea("SE4")
dbSetOrder(1)
If !SE4->(MsSeek(xFilial("SE4")+"001"))
    lOk := .F.
    ConOut("Cadastrar condicao de pagamento: 001")
EndIf
If !SB1->(MsSeek(xFilial("SB1")+"SERV0001       "))
    lOk := .F.
    ConOut("Cadastrar produto: SERV0001       ")
EndIf
dbSelectArea("SA1")
dbSetOrder(1)
If !SA1->(MsSeek(xFilial("SA1")+"CLNT24"))
    lOk := .F.
    ConOut("Cadastrar cliente: CLNT24")
EndIf
If lOk
    ConOut("Inicio: "+Time())
    For nY := 1 To 2
        cDoc := GetSxeNum("SC5","C5_NUM")
        RollBAckSx8()
        aCabec := {}
        aItens := {}
        aadd(aCabec,{"C5_NUM"       ,cDoc           ,Nil})
        aadd(aCabec,{"C5_TIPO"      ,"C"            ,Nil})
        aadd(aCabec,{"C5_CLIENTE"   ,SA1->A1_COD    ,Nil})
        aadd(aCabec,{"C5_LOJACLI"   ,SA1->A1_LOJA   ,Nil})
        aadd(aCabec,{"C5_LOJAENT"   ,SA1->A1_LOJA   ,Nil})
        aadd(aCabec,{"C5_CONDPAG"   ,SE4->E4_CODIGO ,Nil})
        aadd(aCabec,{"C5_MOEDA"     ,2              ,Nil})
        aadd(aCabec,{"C5_TXMOEDA"   ,4.06           ,Nil})
        aadd(aCabec,{"C5_TPCOMPL"   ,"1"           ,Nil})





        /*If cPaisLoc == "PTG"
            aadd(aCabec,{"C5_DECLEXP","TESTE",Nil})
        Endif*/
        //For nX := 1 To 5
            aLinha := {}
            aadd(aLinha,{"C6_ITEM",StrZero(nX,2),Nil})
            aadd(aLinha,{"C6_PRODUTO",SB1->B1_COD,Nil})
            aadd(aLinha,{"C6_QTDVEN",0,Nil})
            aadd(aLinha,{"C6_PRCVEN",60,Nil})
            aadd(aLinha,{"C6_PRUNIT",0,Nil})
            aadd(aLinha,{"C6_VALOR",60,Nil})
            aadd(aLinha,{"C6_TES","503",Nil})
             aadd(aLinha,{"C6_NFORI","4567",Nil})
              aadd(aLinha,{"C6_SERIORI ","NF",Nil})
               aadd(aLinha,{"C6_ITEMORI","01",Nil})

            aadd(aItens,aLinha)
        //Next nX
        //****************************************************************
        //* Teste de Inclusao
        //****************************************************************
        //MATA410(aCabec,aItens,3)
         MsExecAuto({|x, y, z| MATA410(x, y, z)}, aCabec, aItens,3)
        If !lMsErroAuto
            ConOut("Incluido com sucesso! "+cDoc)
        Else
            ConOut("Erro na inclusao!")
            MostraErro()
        EndIf
    Next nY
    ConOut("Fim  : "+Time())
Endif
   /*
    //****************************************************************
    //* Teste de alteracao
    //****************************************************************
    aCabec := {}
    aItens := {}
    aadd(aCabec,{"C5_NUM",cDoc,Nil})
    aadd(aCabec,{"C5_TIPO","N",Nil})
    aadd(aCabec,{"C5_CLIENTE",SA1->A1_COD,Nil})
    aadd(aCabec,{"C5_LOJACLI",SA1->A1_LOJA,Nil})
    aadd(aCabec,{"C5_LOJAENT",SA1->A1_LOJA,Nil})
    aadd(aCabec,{"C5_CONDPAG",SE4->E4_CODIGO,Nil})
    If cPaisLoc == "PTG"
        aadd(aCabec,{"C5_DECLEXP","TESTE",Nil})
    Endif
    For nX := 1 To 30
        aLinha := {}
        aadd(aLinha,{"LINPOS","C6_ITEM",StrZero(nX,2)})
        aadd(aLinha,{"AUTDELETA","N",Nil})
        aadd(aLinha,{"C6_PRODUTO",SB1->B1_COD,Nil})
        aadd(aLinha,{"C6_QTDVEN",2,Nil})
        aadd(aLinha,{"C6_PRCVEN",100,Nil})
        aadd(aLinha,{"C6_PRUNIT",100,Nil})
        aadd(aLinha,{"C6_VALOR",200,Nil})
        aadd(aLinha,{"C6_TES","501",Nil})
        aadd(aItens,aLinha)
    Next nX
    ConOut(PadC("Teste de alteracao",80))
    ConOut("Inicio: "+Time())
    MATA410(aCabec,aItens,4)
    ConOut("Fim  : "+Time())
    ConOut(Repl("-",80))
    //****************************************************************
    //* Teste de Exclusao
    //****************************************************************
    ConOut(PadC("Teste de exclusao",80))
    ConOut("Inicio: "+Time())
    MATA410(aCabec,aItens,5)
    If !lMsErroAuto
        ConOut("Exclusao com sucesso! "+cDoc)
    Else
        ConOut("Erro na exclusao!")
    EndIf
    ConOut("Fim  : "+Time())
    ConOut(Repl("-",80))
EndIf*/
RESET ENVIRONMENT
//	RestArea(aArea)
//	RPCClearEnv()
Return(.T.)
