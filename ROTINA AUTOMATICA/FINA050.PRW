#INCLUDE 'PROTHEUS.CH'

USER FUNCTION FIN050EXC()
	LOCAL aArray := {}

	PRIVATE lMsErroAuto := .F.

	DbSelectArea("SE2")
	DbSetOrder(1)
	DbSeek(xFilial("SE2")+"PAG"+"0001     "+" "+"NF") //Exclus�o deve ter o registro SE2 posicionado

	aArray := { { "E2_PREFIXO" , SE2->E2_PREFIXO , NIL },;
				{ "E2_NUM"     , SE2->E2_NUM     , NIL } }

	MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aArray,, 5)  // 3 - Inclusao, 4 - Altera��o, 5 - Exclus�o

	If lMsErroAuto

		MostraErro()

	Else
		Alert("Exclus�o do T�tulo com sucesso!")
	Endif

Return
