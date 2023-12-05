{- |
Module      : Tarefa1_2021li1g079
Description : Validação de um potencial mapa
Copyright   : Simão Pedro Ferreira Antunes  <a100597@alunos.uminho.pt>;
            : Miguel Afonso Gramoso <a100835@alunos.uminho.pt>;

Módulo para a realização da Tarefa 1 do projeto de LI1 em 2021/22.
-}
module Tarefa1_2021li1g079 where

import LI12122

{- | Dada uma lista de de peças e as suas respetivas coordenadas a função verifica se é possível contruir um mapa com a mesma.

 = Função pricipal
@
validaPotencialMapa [] = False
validaPotencialMapa l
    |vrfPos l && vrfPorta l && vrfCaixa l && vrfEspaço l && vrfBase (ultimoBloco l) l = True
    |otherwise = False
@

 == Exemplos de utilização:
 >>> [(Porta,(0,3)),(Bloco,(0,4)),(Bloco,(1,4)),(Bloco,(2,4)),(Bloco,(3,4)),(Bloco,(4,4)),(Caixa,(4,3)),(Bloco,(5,4)),(Bloco,(6,4)),(Bloco,(6,3)),(Bloco, (6,2)),(Bloco,(6,1))]
 True

 >>> [(Bloco,(0,0)),(Porta,(0,1)),(Bloco,(0,2)),(Bloco,(1,0)),(Bloco,(1,1)),(Bloco,(1,2)),(Bloco,(2,0)),(Bloco,(2,1)),(Bloco,(2,2))]
 False
 
-}

validaPotencialMapa :: [(Peca, Coordenadas)] -- ^ Lista de peças e as suas respetivas coordenadas
 -> Bool -- ^ Resultado
validaPotencialMapa [] = False
validaPotencialMapa l
    |vrfPos l && vrfPorta l && vrfCaixa l && vrfEspaço l && vrfBase (ultimoBloco l) l = True
    |otherwise = False

-- | Verifica se há duas peças com a mesma coordenada.
vrfPos :: [(Peca,Coordenadas)] -> Bool
vrfPos [] = False
vrfPos [(p,(x,y))] = True
vrfPos ((p,(x,y)):t)
    |(x,y) `elem` pos t = False
    |otherwise = vrfPos t

-- | Verifica se há apenas uma porta na lista de peças e verifica se está bem colocada.
vrfPorta :: [(Peca,Coordenadas)] -> Bool
vrfPorta [] = False
vrfPorta ((p,(x,y)):t)
    |p == Porta && notElem p (peca t) && (Bloco,(x,y+1)) `elem` t = True
    |p /= Porta = vrfPorta (t ++ [(p,(x,y))])
    |otherwise = False

-- | Verifica se as caixas estão colocadas corretamente.
vrfCaixa :: [(Peca,Coordenadas)] -> Bool
vrfCaixa [] = False
vrfCaixa l
    |not (haCaixas l) = True
vrfCaixa ((p,(x,y)):t)
    |p == Caixa && ((Bloco,(x,y+1)) `elem` t || (Caixa,(x,y+1)) `elem` t) = True
    |p /= Caixa = vrfCaixa (t ++ [(p,(x,y))])
    |otherwise = False

-- | Verifica se há pelo menos um espaço vazio.
vrfEspaço :: [(Peca,Coordenadas)] -> Bool
vrfEspaço [] = False
vrfEspaço l = not (length l == areaMapa l && notElem Vazio (peca l))

-- | Verifica se a base está preenchida por blocos.
vrfBase :: Coordenadas -> [(Peca,Coordenadas)] -> Bool
vrfBase (x,y) l
    |maiorX l == 0 = False
    |x >= maiorX l = True
vrfBase (x,y) l
    |(x,y+1) `elem` soBlocos l = vrfBase (x,y+1) l
    |(x+1,y+1) `elem` soBlocos l = vrfBase (x+1,y+1) l
    |(x+1,y) `elem` soBlocos l = vrfBase (x+1,y) l
    |(x+1,y-1) `elem` soBlocos l = vrfBase (x+1,y-1) l
    |(x,y-1) `elem` soBlocos l = vrfBase (x,y-1) l
    |otherwise = False

-- | Transforma a lista numa lista de peças.
peca :: [(Peca,Coordenadas)] -> [Peca]
peca [] = []
peca ((p,(x,y)):t) = p : peca t

-- | Transforma a lista numa lista de coordenadas.
pos :: [(Peca,Coordenadas)] -> [Coordenadas]
pos [] = []
pos ((p,(x,y)):t) = (x,y) : pos t

-- | Devolve a maior abcissa da lista.
maiorX :: [(Peca,Coordenadas)] -> Int
maiorX [] = 0
maiorX [(p,(x,y))] = x
maiorX [(p,(x,y)),(p1,(x1,y1))] = if x >= x1 then x else x1
maiorX ((p,(x,y)):(p1,(x1,y1)):t)
    |x >= x1 = maiorX ((p,(x,y)):t)
    |otherwise = maiorX ((p1,(x1,y1)):t)

-- | Devolve a maior ordenada da listas.
maiorY :: [(Peca,Coordenadas)] -> Int
maiorY [] = 0
maiorY [(p,(x,y))] = y
maiorY [(p,(x,y)),(p1,(x1,y1))] = if y >= y1 then y else y1
maiorY ((p,(x,y)):(p1,(x1,y1)):t)
    |y >= y1 = maiorY ((p,(x,y)):t)
    |otherwise = maiorY ((p1,(x1,y1)):t)

-- | Transforma uma lista numa lista de coordenadas de Blocos.
soBlocos :: [(Peca,Coordenadas)] -> [Coordenadas]
soBlocos [] = []
soBlocos ((p,(x,y)):t) = if p == Bloco then soBlocos t ++ [(x,y)] else soBlocos t

-- | Calcula a área do mapa.
areaMapa :: [(Peca,Coordenadas)] -> Int
areaMapa [] = 0
areaMapa l = (maiorX l + 1) * (maiorY l +1)

-- | Devolve a primeira coluna de uma lista.
primeiraColuna :: [(Peca,Coordenadas)] -> [(Peca,Coordenadas)] 
primeiraColuna [] = []
primeiraColuna ((p,(x,y)):t) = if x == 0 then (p,(x,y)) : primeiraColuna t else primeiraColuna t

-- | Calcula o Bloco mais abaixo na primeira coluna do mapa.
ultimoBloco :: [(Peca,Coordenadas)] -> Coordenadas
ultimoBloco [] = (0,0)
ultimoBloco ((p,(x,y)):t) = if p == Bloco && x == 0 && y == maiorY (primeiraColuna ((p,(x,y)):t)) then (x,y) else ultimoBloco t

-- | Verifica se uma lista de peças tem pelo menos uma caixa.
haCaixas :: [(Peca,Coordenadas)] -> Bool
haCaixas [] = False
haCaixas l = Caixa `elem` peca l