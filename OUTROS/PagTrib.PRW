#include "rwmake.ch"         

/*/
|=============================================================================|
| PROGRAMA..: PAGTRIB    | ANALISTA: Fabiano Cintra   |    DATA: 09/06/2018   |
|=============================================================================|
| DESCRICAO.: Fun��o para montagem da estrutura de arquivo de pagamento CNAB  |
|             MultiPag Bradesco.                                              |
|=============================================================================|
| USO......: P12 - Financeiro - TMC                                           |
|=============================================================================|
/*/

User Function PagTrib()     
Local _Ret := ""  

	If SEA->EA_MODELO == "16"        // DARF NORMAL         
		_cRet := StrZero(Val(SE2->E2_XCDRCDN),6)  +; // C�digo da Receita
	        	 "02"                             +; // Tipo de Inscri��o do Contribuinte
		         SM0->M0_CGC                      +; // Inscri��o do Contribuinte
		         "16"                             +; // C�digo Identifica��o do Tributo
		         GravaData(SE2->E2_XPERAPU,.F.,5) +; // Per�odo de Apura��o
	    	     StrZero(Val(SE2->E2_NUM),17)     +; // N�mero de Refer�ncia
	        	 StrZero(SE2->E2_VALOR*100,13)    +; // Valor Principal
		         StrZero(SE2->E2_XMULDFN,13)      +; // Valor da Multa
		         StrZero(SE2->E2_XJURDFN,13)      +; // Valor dos Juros/Encargos
	    	     StrZero(SE2->(E2_VALOR+E2_XMULDFN+E2_XJURDFN)*100,13)    +; // Valor Total a ser Pago
	        	 GravaData(SE2->E2_VENCREA,.F.,5)  +; // Data de Vencimento
		         Space(18)                           // Uso Febraban
	ElseIf SEA->EA_MODELO == "17"    // GPS         
		_cRet := StrZero(Val(SE2->E2_XCODGPS),6)  +; // C�digo do Pagamento              
		         "02"                             +; // Tipo de Inscri��o do Contribuinte
		         SM0->M0_CGC                      +; // Inscri��o do Contribuinte
		         "17"                             +; // C�digo Identifica��o do Tributo
	        	 SE2->E2_XCOMGPS                  +; // M�s e Ano de Compent�ncia
		         StrZero(SE2->E2_VALOR*100,13)    +; // Valor do Tributo
	    	     StrZero(SE2->E2_XOUTENT*100,13)  +; // Valor de Outras Entidades
	        	 Strzero(SE2->E2_XJURGPS*100,13)  +; // Valor da Atualiza��o Monet�ria
	        	 Space(45)                           // Uso Febraban
	ElseIf SEA->EA_MODELO == "18"        // DARF SIMPLES          
		_cRet := StrZero(Val(SE2->E2_XCDRCDS),6)  +; // C�digo da Receita
	        	 "02"                             +; // Tipo de Inscri��o do Contribuinte
		         SM0->M0_CGC                      +; // Inscri��o do Contribuinte
		         "18"                             +; // C�digo Identifica��o do Tributo
		         GravaData(SE2->E2_XAPURDS,.F.,5) +; // Per�odo de Apura��o
				 StrZero(SE2->E2_XVLRCBR*100,15)  +; // Valor da Receita Bruta Acumulada
				 StrZero(SE2->E2_XPCRCBR*100,7)   +; // Percentual da Receita Bruta Acumulada
	        	 StrZero(SE2->E2_VALOR*100,14)    +; // Valor Principal
		         StrZero(SE2->E2_XMULDFS*100,14)  +; // Valor da Multa
		         StrZero(SE2->E2_XJURDFS*100,14)  +; // Valor dos Juros/Encargos
		         Space(21)                           // Uso Febraban
	EndIf	
		
Return(_cRet)         
