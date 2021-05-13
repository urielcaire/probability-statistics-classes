# DESAFIO 1 - Exercício
# Uriel Cairê Balan Calvi

library("DiagrammeR")

################################################################################
# Configurando os valores inicias do Exercício 1
adicional_expedicao_comum <- 0
adicional_expedicao_segura <- -10000
custo_recalibragem <- -50000
probabilidade_desajuste <- 0.15
probabilidade_nao_desajuste <- 1 - probabilidade_desajuste

## Probabilidade de o especialista dizer que haverá desajustes "D", dado que de
## fato haverá desajustes D: p("D"/D)
p_eD_D <- 0.9
## Probabilidade de o especialista dizer que NÃO haverá desajustes "ND", dado que
## de fato não haverá desajustes ND: p("ND"/ND)
p_eND_ND <- 0.8

###############################################################################
# Árvore de decisão sem o especialista

grViz('digraph dot{
  subgraph { 
    label = "";
    key [label=<<table border="0" cellpadding="0" cellspacing="0" cellborder="1" color= "black">
      <tr><td><b>LEGENDA</b></td></tr>
      <tr><td align="left" ><b>EC</b> = Expedição Comum</td></tr>
      <tr><td align="left" ><b>ES</b> = Expedição Segura</td></tr>
      <tr><td align="left"><b>D</b> = Desajuste</td></tr>
      <tr><td align="left" ><b>ND</b> = Não Desajuste </td></tr>
      </table>>, shape=square, color = white]
  }
  
  # Configurações de visualização
  node [style = filled]
  rankdir="LR"
  splines=true
  
  # Criação da árvore
  
  ## Criação dos nós
  NoInicial[label="", shape=square, fillcolor = MidnightBlue]
  EC[label="", shape=circle, fillcolor = Gold]
  ES[label="-10000", shape=triangle, width=1, height=1]
  
  D[label="-50000", shape=triangle, width=1, height=1]
  ND[label="-0", shape=triangle, width=1, height=1]
  
  ## Criação das conexões
  NoInicial -> EC [label="EC"];
  NoInicial -> ES [label="ES"];
  
  EC -> D[label="p(D) = 0.15"]
  EC -> ND[label="p(ND) = 0.85"]
  
}')

################################################################################
# Cálculo do Valor Esperado VE
## VE da expedição segura: -10000
VE_expedicao_segura <- adicional_expedicao_segura
## VE da expeção comum: -7500
VE_expedicao_comum <- (probabilidade_desajuste*custo_recalibragem) + 
  (probabilidade_nao_desajuste * adicional_expedicao_comum)

## VE dp menor prejuízo / Melhor decisão
VE <- max(VE_expedicao_segura, VE_expedicao_comum)
VE # Saída: -7500

################################################################################
# Cáculo do Valor Esperado da Informação Perfeita (VEIP)
## VEWIP: valor esperado em condições de certeza
VEWIP <- (adicional_expedicao_comum*probabilidade_nao_desajuste) +
  (adicional_expedicao_segura*probabilidade_desajuste)

VEIP <- VEWIP - VE
VEIP # Saída: 6000

################################################################################
# Cálculo das probabilidades

p_D <- probabilidade_desajuste
p_ND <- probabilidade_nao_desajuste

### Aplicação da Lei da Probabilidade Total
## p("ND"/D) = 1 - p("D"/D)
p_eND_D <- 1 - p_eD_D

## p("D"/ND) = 1 - p("ND"/ND)
p_eD_ND <- 1- p_eND_ND

## p("D") = (p("D"/D) * p(D)) + (p("D"/ND) * p(ND))
p_eD <- (p_eD_D * p_D) + (p_eD_ND * p_ND)

## p("ND") = (p("ND"/ND) * p(ND)) + (p("D"/ND) * p(ND))
p_eND <- (p_eND_ND * p_ND) + (p_eND_D * p_D)

### Aplicação do Teorema de Bayes
## p(D/"D") = (p("D"/D) * p(D)) / p("D")
p_D_eD <- (p_eD_D * p_D) / p_eD
## p(ND/"D") = 1 - p(D/"D")
p_ND_eD <- 1 - p_D_eD

## p(D/"ND") = [p("ND"/D) * p(D)] / p("ND")
p_D_eND <- (p_eND_D * p_D) / p_eND

## p(ND/"ND") <- 1 - p(D/"ND"
p_ND_eND <- 1 - p_D_eND

################################################################################
# Árvore de decisão com especialista

grViz('digraph probability_tree{

  # Configuração da Legenda
  subgraph { 
    label = "";
    key [label=<<table border="0" cellpadding="0" cellspacing="0" cellborder="1" color= "black">
      <tr><td><b>LEGENDA</b></td></tr>
      <tr><td align="left" ><b>EC</b> = Expedição Comum</td></tr>
      <tr><td align="left" ><b>ES</b> = Expedição Segura</td></tr>
      <tr><td align="left"><b>D</b> = Desajuste</td></tr>
      <tr><td align="left" ><b>ND</b> = Não Desajuste </td></tr>
      <tr><td align="left"><b>"D"</b> = Teste informou Desajuste</td></tr>
      <tr><td align="left" ><b>"ND"</b> = Teste informou Não Desajuste </td></tr>
      </table>>, shape=square, color = white]
  }
  
  # Configurações de visualização
  node [style = filled]
  rankdir="LR"
  splines=true
  
  InicioAbsoluto[label="", shape=square, fillcolor = MidnightBlue]
  
  # Criação da árvore com especialista
  
  ## Criação dos nós
  NoInicialEsp[label="", shape=circle, fillcolor = Gold]
  
  eD[label="", shape=square, fillcolor = MidnightBlue]
  eND[label="", shape=square, fillcolor = MidnightBlue]
  
  ### dado que o especialista apontou "D"
  eD_ES[label="-10000", shape=triangle, width=1, height=1]
  eD_EC[label="", shape=circle, fillcolor = Gold]
  
  eD_EC_D[label="-50000", shape=triangle, width=1, height=1]
  eD_EC_ND[label="-0", shape=triangle, width=1, height=1]
  
  ### dado que o especialista apontou "ND"
  eND_ES[label="-10000", shape=triangle, width=1, height=1]
  eND_EC[label="", shape=circle, fillcolor = Gold]
  
  eND_EC_D[label="-50000", shape=triangle, width=1, height=1]
  eND_EC_ND[label="-0", shape=triangle, width=1, height=1]
  
  ## Criação das conexões
  NoInicialEsp -> eD[label="p(\\"D\\")=0.305"]
  NoInicialEsp -> eND[label="p(\\"ND\\")=0.695"]
  
  eD -> eD_ES[label="ES"]
  eD -> eD_EC[label="EC"]
  eD_EC -> eD_EC_D[label="p(D/\\"D\\")=0.4426"]
  eD_EC -> eD_EC_ND[label="p(ND/\\"D\\")=0.5573"]
  
  eND -> eND_ES[label="ES"]
  eND -> eND_EC[label="EC"]
  eND_EC -> eND_EC_D[label="p(D/\\"ND\\")=0.0215"]
  eND_EC -> eND_EC_ND[label="p(ND/\\"ND\\")=0.9784"]
  
  
  
  # Criação da árvore sem especialista
  
  ## Criação dos nós
  NoInicial[label="", shape=square, fillcolor = MidnightBlue]
  EC[label="", shape=circle, fillcolor = Gold]
  ES[label="-10000", shape=triangle, width=1, height=1]
  
  D[label="-50000", shape=triangle, width=1, height=1]
  ND[label="-0", shape=triangle, width=1, height=1]
  
  ## Criação das conexões
  NoInicial -> EC [label="EC"];
  NoInicial -> ES [label="ES"];
  
  EC -> D[label="p(D) = 0.15"]
  EC -> ND[label="p(ND) = 0.85"]
  
  # Conexão absoluta
  InicioAbsoluto -> NoInicial[label="Não Consultar Teste"]
  InicioAbsoluto -> NoInicialEsp[label="Consultar Teste"]
  
}')

################################################################################
# Cáculo do Valor Esperado da Informação Imperfeita (VEII)
## Cálculo do VE quando "D"
eD_VE_ES = adicional_expedicao_segura
eD_VE_EC = (p_D_eD * custo_recalibragem) +
  (p_ND_eD * adicional_expedicao_comum)
eD_VE = max(eD_VE_ES, eD_VE_EC)
eD_VE # Saída: -10000

## Cálculo do VE quando "ND"
eND_VE_ES = adicional_expedicao_segura
eND_VE_EC = (p_D_eND * custo_recalibragem) +
  (p_ND_eND * adicional_expedicao_comum)
eND_VE = max(eND_VE_ES, eND_VE_EC)
eND_VE # Saída: -1079.137

## Cálculo do Valor Esperado de "D" e "ND"
eVE = (p_eND*eND_VE) + (p_eD*eD_VE)

## Cálculo da VEII
VEII = eVE - VE
VEII # Saída: 3700

################################################################################
# FMP básica
eventos <- 0:1
probabilidades <- c(0.85, 0.15)
tabela <- matrix(c(eventos, probabilidades), ncol=2, byrow=TRUE)
rownames(tabela) <-c("y", "p(y)")
tabela <- as.table(tabela)
colnames(tabela) <- NULL
tabela
################################################################################
eventos <- 0:1
probabilidades <- c(0.85, 0.15)
plot(eventos, probabilidades, xlab="y", ylab="p(y)", type="h", lwd=3,
     xlim = c(-1,2), ylim = c(0,1), frame.plot = FALSE, xaxs = "i", yaxs="i")
points(0:1, probabilidades, pch=16, cex=2.5)
