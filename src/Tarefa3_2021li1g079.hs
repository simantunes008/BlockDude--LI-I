{- |
Module      : Tarefa3_2021li1g079
Description : Representação textual do jogo
Copyright   : Simão Pedro Ferreira Antunes  <a100597@alunos.uminho.pt>;
            : Miguel Afonso Gramoso <a100835@alunos.uminho.pt>;

Módulo para a realização da Tarefa 3 do projeto de LI1 em 2021/22.
-}
module Tarefa3_2021li1g079 where

import LI12122

instance Show Jogo where
  show j = repMapa j

{- | Dada uma lista de de peças transforma-a numa string.

@
repPeca [] = []
repPeca (p:t) 
  |p == Vazio = " " ++ repPeca t 
  |p == Bloco = "X" ++ repPeca t 
  |p == Caixa = "C" ++ repPeca t 
  |p == Porta = "P" ++ repPeca t 
  |otherwise = repPeca t
@

 == Exemplo de utilização:
 >>> [Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco]
 "P   C X"

-}

repPeca :: [Peca] -- ^ Lista de peças
 -> String -- ^ Imprime uma string
repPeca [] = []
repPeca (p:t)
  |p == Vazio = " " ++ repPeca t
  |p == Bloco = "X" ++ repPeca t
  |p == Caixa = "C" ++ repPeca t
  |p == Porta = "P" ++ repPeca t
  |otherwise = repPeca t

{- | Dado um mapa transforma-o numa string.

@
repPecas :: Mapa -> String 
repPecas [] = ""
repPecas [l] = repPeca l
repPecas (h:t) = repPeca h ++ "\n" ++ repPecas t
@

 == Exemplo de utilização:
 >>> [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco], [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco], [Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco], [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]]
 "       \n      X\n      X\nP   C X\nXXXXXXX"

-}

repPecas :: Mapa -- ^ Lista de listas de peças
 -> String -- ^ Imprime uma string
repPecas [] = ""
repPecas [l] = repPeca l
repPecas (h:t) = repPeca h ++ "\n" ++ repPecas t

{- | Dadas umas coordenadas, um jogador e uma lista de peças insere o jogador na respetiva coluna.

@
repJogador (x,y) (Jogador (x1,y1) d b) [] = ""
repJogador (x,y) (Jogador (x1,y1) d b) (h:t)
  |d == Oeste && x == x1 && h == Vazio = "<" ++ repPeca t
  |d == Este && x == x1 && h == Vazio = ">" ++ repPeca t
  |otherwise = repPeca [h] ++ repJogador (x,y) (Jogador (x1-1,y1) d b) t
@

 == Exemplo de utilização:
 >>> (0,0) (Jogador (2,_) Oeste False) [Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco]
 "P < C X

-}

repJogador :: Coordenadas -- ^ Coordenadas a ser comparadas
 -> Jogador -- ^ Jogador
 -> [Peca] -- ^ Lista de peças
 -> String -- ^ Imprime uma string
repJogador (x,y) (Jogador (x1,y1) d b) [] = ""
repJogador (x,y) (Jogador (x1,y1) d b) (h:t)
  |d == Oeste && x == x1 && h == Vazio = "<" ++ repPeca t
  |d == Este && x == x1 && h == Vazio = ">" ++ repPeca t
  |otherwise = repPeca [h] ++ repJogador (x,y) (Jogador (x1-1,y1) d b) t

{- | Dado um mapa devolve uma lista de peças e as suas respetivas coordenadas.

@
coordenadasMapa :: Mapa -> [(Peca,Coordenadas)]
coordenadasMapa m = coordenadasMapaAux m 0 0

coordenadasMapaAux :: Mapa -> Int -> Int -> [(Peca,Coordenadas)]
coordenadasMapaAux [] n1 n2 = []
coordenadasMapaAux [[]] n1 n2 = []
coordenadasMapaAux [h:t] n1 n2 = (h,(n1,n2)) : coordenadasMapaAux [t] (n1+1) n2
coordenadasMapaAux (h:t) n1 n2 = coordenadasMapaAux [h] n1 n2 ++ coordenadasMapaAux t n1 (n2+1)
@

 == Exemplo de utilização:
 >>> [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco], [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco], [Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco], [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]]
 [(Vazio,(0,0)),(Vazio,(1,0)),(Vazio,(2,0)),(Vazio,(3,0)),(Vazio,(4,0)),(Vazio,(5,0)),(Vazio,(6,0)),(Vazio,(0,1)),(Vazio,(1,1)),(Vazio,(2,1)),(Vazio,(3,1)),(Vazio,(4,1)),(Vazio,(5,1)),(Bloco,(6,1)),(Vazio,(0,2)),(Vazio,(1,2)),(Vazio,(2,2)),(Vazio,(3,2)),(Vazio,(4,2)),(Vazio,(5,2)),(Bloco,(6,2)),(Porta,(0,3)),(Vazio,(1,3)),(Vazio,(2,3)),(Vazio,(3,3)),(Caixa,(4,3)),(Vazio,(5,3)),(Bloco,(6,3)),(Bloco,(0,4)),(Bloco,(1,4)),(Bloco,(2,4)),(Bloco,(3,4)),(Bloco,(4,4)),(Bloco,(5,4)),(Bloco,(6,4))]

-}

coordenadasMapa :: Mapa -- ^ Lista de listas de peças
 -> [(Peca,Coordenadas)] -- ^ Devolve uma lista de peças e as suas respetivas coordenadas
coordenadasMapa m = coordenadasMapaAux m 0 0

coordenadasMapaAux :: Mapa -> Int -> Int -> [(Peca,Coordenadas)]
coordenadasMapaAux [] n1 n2 = []
coordenadasMapaAux [[]] n1 n2 = []
coordenadasMapaAux [h:t] n1 n2 = (h,(n1,n2)) : coordenadasMapaAux [t] (n1+1) n2
coordenadasMapaAux (h:t) n1 n2 = coordenadasMapaAux [h] n1 n2 ++ coordenadasMapaAux t n1 (n2+1)

{- | Dado um jogo coloca o jogador na posição correta caso ele esteja a "flutuar".

@
gravidade :: Jogo -> Jogo
gravidade (Jogo [] (Jogador (x,y) d b)) = Jogo [] (Jogador (x,y) d b)
gravidade (Jogo (h:t) (Jogador (x,y) d b))
  |y > length (h:t) || x > length h || x < 0 || y < 0 = Jogo (h:t) (Jogador (x,y) d b)
  |(Bloco,(x,y+1)) `elem` coordenadasMapa (h:t) || (Caixa,(x,y+1)) `elem` coordenadasMapa (h:t) = Jogo (h:t) (Jogador (x,y) d b)
  |otherwise = gravidade (Jogo (h:t) (Jogador (x,y+1) d b))
@

 == Exemplo de utilização:
 >>> (Jogador (2, 0) Oeste False) [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco], [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco], [Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco], [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]]
 (Jogador (2, 3) Oeste False) [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco], [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco], [Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco], [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]]

-}

gravidade :: Jogo -- ^ Mapa juntamente com o jogador 
 -> Jogo -- ^ Devolve um Jogo
gravidade (Jogo [] (Jogador (x,y) d b)) = Jogo [] (Jogador (x,y) d b)
gravidade (Jogo (h:t) (Jogador (x,y) d b))
  |y > length (h:t) || x > length h || x < 0 || y < 0 = Jogo (h:t) (Jogador (x,y) d b)
  |(Bloco,(x,y+1)) `elem` coordenadasMapa (h:t) || (Caixa,(x,y+1)) `elem` coordenadasMapa (h:t) = Jogo (h:t) (Jogador (x,y) d b)
  |otherwise = gravidade (Jogo (h:t) (Jogador (x,y+1) d b))

{- | Dado um jogador e um mapa insere o jogador no mapa.

@
repMapa :: Jogo -> String 
repMapa j = repMapaAux (gravidade j)

repMapaAux :: Jogo -> String
repMapaAux (Jogo [] (Jogador (x,y) d b)) = []
repMapaAux (Jogo (h:t) (Jogador (x,y) d b))
  |y > length (h:t) || x > length h || x < 0 || y < 0 = repPecas (h:t)
  |y == 0 = repJogador (0,0) (Jogador (x,y) d b) h ++ "\n" ++ repPecas t
  |y > 0 = repPeca h ++ "\n" ++ repMapaAux (Jogo t (Jogador (x,y-1) d b))
  |otherwise = repPecas t
@

 == Exemplo de utilização:
 >>> (Jogador (2, 3) Oeste False) [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio], [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco], [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco], [Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco], [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]]
 "       \n      X\n      X\nP < C X\nXXXXXXX" 
 
-}

repMapa :: Jogo -- ^ Mapa juntamente com o jogador 
 -> String -- ^ Imprime uma string
repMapa j = repMapaAux (gravidade j)

repMapaAux :: Jogo -> String
repMapaAux (Jogo [] (Jogador (x,y) d b)) = []
repMapaAux (Jogo (h:t) (Jogador (x,y) d b))
  |y > length (h:t) || x > length h || x < 0 || y < 0 = repPecas (h:t)
  |y == 0 = repJogador (0,0) (Jogador (x,y) d b) h ++ "\n" ++ repPecas t
  |y > 0 = repPeca h ++ "\n" ++ repMapaAux (Jogo t (Jogador (x,y-1) d b))
  |otherwise = repPecas t