{- |
Module      : Tarefa6_2021li1g079
Description : Resolução de um puzzle

Módulo para a realização da Tarefa 6 do projeto de LI1 em 2021/22.
-}
module Tarefa6_2021li1g079 where

import LI12122
import Tarefa4_2021li1g079

{- | Tenta resolver um Jogo num número máximo de movimentos.

@
resolveJogo :: Int -> Jogo -> Maybe [Movimento] 
resolveJogo n j  
  |n == 0 && acabaJogo j = Just []
  |n > 0 && length (aplicaMovimentos j (movimentosPossiveis j)) <= n = Just (aplicaMovimentos j (movimentosPossiveis j))
  |otherwise = Nothing
@

-}

resolveJogo :: Int -- ^ Número máximo de Movimentos
 -> Jogo -- ^ Mapa juntamente com o jogador 
 -> Maybe [Movimento] -- ^ Possível resolução do Jogo
resolveJogo n j  
  |n == 0 && acabaJogo j = Just []
  |n > 0 && length (aplicaMovimentos j (movimentosPossiveis j)) <= n = Just (aplicaMovimentos j (movimentosPossiveis j))
  |otherwise = Nothing

{- | Verifica se um Jogo está concluído.

@
acabaJogo :: Jogo -> Bool
acabaJogo (Jogo m (Jogador (x,y) d b)) = (x,y) == coordenadasPorta m
@

-}

acabaJogo :: Jogo -- ^ Mapa juntamente com o jogador  
 -> Bool -- ^ Resultado
acabaJogo (Jogo m (Jogador (x,y) d b)) = (x,y) == coordenadasPorta m

{- | Dado um mapa calcula as coordenadas da Porta.

@
coordenadasPorta :: Mapa -> Coordenadas
coordenadasPorta = coordenadasPortaAux 0 0

coordenadasPortaAux :: Int -> Int -> Mapa -> Coordenadas
coordenadasPortaAux _ _ [] = (0,0)
coordenadasPortaAux _ _ ([]:_) = (0,0)
coordenadasPortaAux p1 p2 ((x:xs):ys)
    |elem Porta (x:xs) && x == Porta = (p1,p2)
    |elem Porta (x:xs) && x /= Porta = coordenadasPortaAux (p1+1) p2 [xs]
    |otherwise = coordenadasPortaAux p1 (p2+1) ys
@

-}

coordenadasPorta :: Mapa -- ^ Lista de listas de peças
 -> Coordenadas -- ^ Devolve as coordenadas da Porta
coordenadasPorta = coordenadasPortaAux 0 0

coordenadasPortaAux :: Int -> Int -> Mapa -> Coordenadas
coordenadasPortaAux _ _ [] = (0,0)
coordenadasPortaAux _ _ ([]:_) = (0,0)
coordenadasPortaAux p1 p2 ((x:xs):ys)
    |elem Porta (x:xs) && x == Porta = (p1,p2)
    |elem Porta (x:xs) && x /= Porta = coordenadasPortaAux (p1+1) p2 [xs]
    |otherwise = coordenadasPortaAux p1 (p2+1) ys

{- | Verifica se é possível aplicar um Movimento.

@
checkmove' :: Jogo -> Movimento -> Bool
checkmove' (Jogo [] _ ) _ = False
checkmove' (Jogo ([]:_) _ ) _ = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) n False))) AndarDireita
  | not (isblock ((y : ys) : xs) (a + 1) b) && a<=length (y :ys) = True
  | isblock ((y : ys) : xs) (a + 1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) n True))) AndarDireita
  | not (isblock ((y : ys) : xs) (a + 1) b) && not(isblock ((y:ys):xs) (a+1) (b-1)) = True
  | isblock ((y : ys) : xs) (a + 1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) (Jogador (a, b) n False)) AndarEsquerda
  | not (isblock ((y : ys) : xs) (a -1) b) = True
  | isblock ((y : ys) : xs) (a -1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) n True))) AndarEsquerda
  | not (isblock ((y : ys) : xs) (a + 1) b) && not(isblock ((y:ys):xs) (a+1) (b-1)) = True
  | isblock ((y : ys) : xs) (a + 1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste False))) Trepar
  | not (isblock ((y : ys) : xs) (a -1) (b -1)) && isblock ((y:ys):xs) (a-1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) Este False))) Trepar
  | not (isblock ((y : ys) : xs) (a + 1) (b -1)) && isblock ((y:ys):xs) (a+1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) Este True))) Trepar
  | not (isblock ((y : ys) : xs) (a + 1) (b -1)) && isblock ((y:ys):xs) (a+1) b && not (isblock ((y:ys):xs) (a+1) (b-2)) = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste True))) Trepar
  | not (isblock ((y : ys) : xs) (a - 1) (b -1)) && isblock ((y:ys):xs) (a-1) b && not (isblock ((y:ys):xs) (a-1) (b-2)) = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) (Jogador (a, b) Este False)) InterageCaixa
  | isbox ((y : ys) : xs) (a + 1) b && not (isblock ((y : ys) : xs) (a +1) (b -1)) && not (isblock ((y:ys):xs) a (b-1)) = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) (Jogador (a, b) Este True)) InterageCaixa
  | isblock ((y : ys) : xs) (a + 1) b && not (isblock ((y : ys) : xs) (a +1) (b -1)) = True
  | not(isbox ((y : ys) : xs) (a + 1) b) && not (isblock ((y : ys) : xs) (a +1) (b -1)) = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False)) InterageCaixa
  | isbox ((y : ys) : xs) (a - 1) b && not (isblock ((y : ys) : xs) (a -1) (b -1)) && not (isblock ((y:ys):xs) a (b-1)) = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True)) InterageCaixa
  | isblock ((y : ys) : xs) (a - 1) b && not (isblock ((y : ys) : xs) (a -1) (b -1)) = True
  | not(isblock ((y : ys) : xs) (a - 1) b) && not (isblock ((y : ys) : xs) (a -1) (b -1)) = True
  | otherwise = False

@

-}

checkmove' :: Jogo -> Movimento -> Bool
checkmove' (Jogo [] _ ) _ = False
checkmove' (Jogo ([]:_) _ ) _ = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) n False))) AndarDireita
  | not (isblock ((y : ys) : xs) (a + 1) b) && a<=length (y :ys) = True
  | isblock ((y : ys) : xs) (a + 1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) n True))) AndarDireita
  | not (isblock ((y : ys) : xs) (a + 1) b) && not(isblock ((y:ys):xs) (a+1) (b-1)) = True
  | isblock ((y : ys) : xs) (a + 1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) (Jogador (a, b) n False)) AndarEsquerda
  | not (isblock ((y : ys) : xs) (a -1) b) = True
  | isblock ((y : ys) : xs) (a -1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) n True))) AndarEsquerda
  | not (isblock ((y : ys) : xs) (a + 1) b) && not(isblock ((y:ys):xs) (a+1) (b-1)) = True
  | isblock ((y : ys) : xs) (a + 1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste False))) Trepar
  | not (isblock ((y : ys) : xs) (a -1) (b -1)) && isblock ((y:ys):xs) (a-1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) Este False))) Trepar
  | not (isblock ((y : ys) : xs) (a + 1) (b -1)) && isblock ((y:ys):xs) (a+1) b = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) Este True))) Trepar
  | not (isblock ((y : ys) : xs) (a + 1) (b -1)) && isblock ((y:ys):xs) (a+1) b && not (isblock ((y:ys):xs) (a+1) (b-2)) = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste True))) Trepar
  | not (isblock ((y : ys) : xs) (a - 1) (b -1)) && isblock ((y:ys):xs) (a-1) b && not (isblock ((y:ys):xs) (a-1) (b-2)) = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) (Jogador (a, b) Este False)) InterageCaixa
  | isbox ((y : ys) : xs) (a + 1) b && not (isblock ((y : ys) : xs) (a +1) (b -1)) && not (isblock ((y:ys):xs) a (b-1)) = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) (Jogador (a, b) Este True)) InterageCaixa
  | isblock ((y : ys) : xs) (a + 1) b && not (isblock ((y : ys) : xs) (a +1) (b -1)) = True
  | not(isbox ((y : ys) : xs) (a + 1) b) && not (isblock ((y : ys) : xs) (a +1) (b -1)) = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False)) InterageCaixa
  | isbox ((y : ys) : xs) (a - 1) b && not (isblock ((y : ys) : xs) (a -1) (b -1)) && not (isblock ((y:ys):xs) a (b-1)) = True
  | otherwise = False
checkmove' (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True)) InterageCaixa
  | isblock ((y : ys) : xs) (a - 1) b && not (isblock ((y : ys) : xs) (a -1) (b -1)) = True
  | not(isblock ((y : ys) : xs) (a - 1) b) && not (isblock ((y : ys) : xs) (a -1) (b -1)) = True
  | otherwise = False

{- | Para um dado Jogo, verifica quais são os movimentos possíveis para o Jogador na dada posição.

@
movimentosPossiveis :: Jogo -> [[Movimento]]
movimentosPossiveis j = movimentosPossiveisAux j m
  where m = [Trepar,AndarEsquerda,AndarDireita,InterageCaixa]

movimentosPossiveisAux :: Jogo -> [Movimento] -> [[Movimento]]
movimentosPossiveisAux (Jogo [] _ ) _ = []
movimentosPossiveisAux (Jogo ([]:_) _ ) _ = []
movimentosPossiveisAux j [] = []
movimentosPossiveisAux j (h:t) = if checkmove' j h then [h] : movimentosPossiveisAux j t else movimentosPossiveisAux j t
@

-}

movimentosPossiveis :: Jogo -- ^ Mapa juntamente com o jogador 
 -> [[Movimento]] -- ^ Devolve uma lista de listas com os movimentos possíveis
movimentosPossiveis j = movimentosPossiveisAux j m
  where m = [Trepar,AndarEsquerda,AndarDireita,InterageCaixa]

movimentosPossiveisAux :: Jogo -> [Movimento] -> [[Movimento]]
movimentosPossiveisAux (Jogo [] _ ) _ = []
movimentosPossiveisAux (Jogo ([]:_) _ ) _ = []
movimentosPossiveisAux j [] = []
movimentosPossiveisAux j (h:t) = if checkmove' j h then [h] : movimentosPossiveisAux j t else movimentosPossiveisAux j t

{- | Dado um Jogo e uma lista de listas de Movimentos, devolve a lista que resolve o dado Jogo.

@
aplicaMovimentos :: Jogo -> [[Movimento]] ->[Movimento]
aplicaMovimentos j [] = []
aplicaMovimentos j a
  |null (aplicaMovimentosAux j a) = aplicaMovimentos j (aplicaMovimentosAux1 j a)
  |otherwise = aplicaMovimentosAux j a

aplicaMovimentosAux :: Jogo -> [[Movimento]] -> [Movimento]
aplicaMovimentosAux j [] = []
aplicaMovimentosAux j (h:t)
  |acabaJogo (correrMovimentos j h) = h
  |otherwise = aplicaMovimentosAux j t

aplicaMovimentosAux1 :: Jogo -> [[Movimento]] -> [[Movimento]]
aplicaMovimentosAux1 _ [] = []
aplicaMovimentosAux1 j (h:t) = aplicaMovimentosAux3 h (aplicaMovimentosAux2 (correrMovimentos j (init h)) 0 (last h)) ++ aplicaMovimentosAux1 j t

aplicaMovimentosAux2 :: Jogo -> Int -> Movimento -> [[Movimento]]
aplicaMovimentosAux2 j n m | n >= length (movimentosPossiveis(moveJogador j m)) = []
aplicaMovimentosAux2 j n m = (!!) (movimentosPossiveis(moveJogador j m)) n : aplicaMovimentosAux2 j (n+1) m

aplicaMovimentosAux3 :: [Movimento] -> [[Movimento]] -> [[Movimento]]
aplicaMovimentosAux3 _ [] = []
aplicaMovimentosAux3 m (h:t) = (m ++ h) : aplicaMovimentosAux3  m t
@

-}

aplicaMovimentos :: Jogo -- ^ Mapa juntamente com o jogador 
 -> [[Movimento]] -- ^ Lista de listas de movimentos
 ->[Movimento] -- ^ Devolve a lista vencedora
aplicaMovimentos j [] = []
aplicaMovimentos j a
  |null (aplicaMovimentosAux j a) = aplicaMovimentos j (aplicaMovimentosAux1 j a)
  |otherwise = aplicaMovimentosAux j a

aplicaMovimentosAux :: Jogo -> [[Movimento]] -> [Movimento]
aplicaMovimentosAux j [] = []
aplicaMovimentosAux j (h:t)
  |acabaJogo (correrMovimentos j h) = h
  |otherwise = aplicaMovimentosAux j t

aplicaMovimentosAux1 :: Jogo -> [[Movimento]] -> [[Movimento]]
aplicaMovimentosAux1 _ [] = []
aplicaMovimentosAux1 j (h:t) = aplicaMovimentosAux3 h (aplicaMovimentosAux2 (correrMovimentos j (init h)) 0 (last h)) ++ aplicaMovimentosAux1 j t

aplicaMovimentosAux2 :: Jogo -> Int -> Movimento -> [[Movimento]]
aplicaMovimentosAux2 j n m | n >= length (movimentosPossiveis(moveJogador j m)) = []
aplicaMovimentosAux2 j n m = (!!) (movimentosPossiveis(moveJogador j m)) n : aplicaMovimentosAux2 j (n+1) m

aplicaMovimentosAux3 :: [Movimento] -> [[Movimento]] -> [[Movimento]]
aplicaMovimentosAux3 _ [] = []
aplicaMovimentosAux3 m (h:t) = (m ++ h) : aplicaMovimentosAux3  m t