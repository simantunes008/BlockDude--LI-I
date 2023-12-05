-- |
-- Module      : Tarefa2_2021li1g079
-- Description : Construção/Desconstrução do mapa
-- Copyright   : Simão Pedro Ferreira Antunes  <a100597@alunos.uminho.pt>;
--             : Miguel Afonso Gramoso <a100835@alunos.uminho.pt>;
--
-- Módulo para a realização da Tarefa 2 do projeto de LI1 em 2021/22.
module Tarefa2_2021li1g079 (
  -- *ConstroiMapa
  constroiMapa,makeline,comprimento,altura,addvoid,makemap, 
  -- *DestroiMapa
  desconstroiMapa,destro
) where

import LI12122 ( Mapa, Coordenadas, Peca(Vazio) )

{- | Chama a funçao 'makemap' e fornece-lhe as peças de origem e o ponto de começo.

@
constroiMapa :: [(Peca, Coordenadas)] -> Mapa
constroiMapa pecas = makemap pecas 0
@

-}

constroiMapa :: [(Peca, Coordenadas)] -> Mapa
constroiMapa pecas = makemap pecas 0

{- | Separa peças de acordo com o seu y.

@
makeline :: Int -> [(Peca, Coordenadas)] -> [(Peca, Coordenadas)]
makeline _ [] = []
makeline y ((a, (b, c)) : xs)
  | y == c = (a, (b, c)) : makeline y xs
  | otherwise = makeline y xs
@

-}

makeline :: Int -> [(Peca, Coordenadas)] -> [(Peca, Coordenadas)]
makeline _ [] = []
makeline y ((a, (b, c)) : xs)
  | y == c = (a, (b, c)) : makeline y xs
  | otherwise = makeline y xs

{- | Função que calcula a maior ordenada de todos os blocos.

@
comprimento :: [(Peca, Coordenadas)] -> Int
comprimento [] = 0
comprimento [(a, (b, c))] = b
comprimento ((a, (b, c)) : (d, (e, f)) : xs)
  | b > e = comprimento ((a, (b, c)) : xs)
  | otherwise = comprimento ((d, (e, f)) : xs)
@

-}

comprimento :: [(Peca, Coordenadas)] -> Int
comprimento [] = 0
comprimento [(a, (b, c))] = b
comprimento ((a, (b, c)) : (d, (e, f)) : xs)
  | b > e = comprimento ((a, (b, c)) : xs)
  | otherwise = comprimento ((d, (e, f)) : xs)

{- | Função que calcula a maior abcissa de todos os blocos.

@
altura :: [(Peca, Coordenadas)] -> Int
altura []=0
altura [(a, (b, c))] = c
altura ((a, (b, c)) : (d, (e, f)) : xs)
  | c > f = altura ((a, (b, c)) : xs)
  | otherwise = altura ((d, (e, f)) : xs)
@

-}

altura :: [(Peca, Coordenadas)] -> Int
altura []=0
altura [(a, (b, c))] = c
altura ((a, (b, c)) : (d, (e, f)) : xs)
  | c > f = altura ((a, (b, c)) : xs)
  | otherwise = altura ((d, (e, f)) : xs)

{- | Adiciona peças vazias,para um determinado y, para as coordenadas em que nao existam blocos defenidos.

@
addvoid :: [(Peca, Coordenadas)] -> Int -> Int -> [(Peca, Coordenadas)] -> [Peca]
addvoid l x y [] = Vazio : addvoid l (x + 1) y l
addvoid l x y ((a, (b, c)) : xs)
  | x > comprimento l = []
  | y > altura l = []
  | x == b && y == c = a : addvoid l (x + 1) y ((a, (b, c)) : xs)
  | otherwise = addvoid l x y xs
@

-}

addvoid :: [(Peca, Coordenadas)] -> Int -> Int -> [(Peca, Coordenadas)] -> [Peca]
addvoid l x y [] = Vazio : addvoid l (x + 1) y l
addvoid l x y ((a, (b, c)) : xs)
  | x > comprimento l = []
  | y > altura l = []
  | x == b && y == c = a : addvoid l (x + 1) y ((a, (b, c)) : xs)
  | otherwise = addvoid l x y xs

{- | Função recursiva que permite juntar listas, devidamente preenchidas com os espaços vazios, de acordo com os  suas ordenadas.

@
makemap :: [(Peca, Coordenadas)] -> Int -> [[Peca]]
makemap l y
  | altura l == 0 = []
  | y -1 < altura l = addvoid l 0 y (makeline y l) : makemap l (y + 1)
  | otherwise = []
@

-}

makemap :: [(Peca, Coordenadas)] -> Int -> [[Peca]]
makemap l y
  | altura l == 0 = []
  | y -1 < altura l = addvoid l 0 y (makeline y l) : makemap l (y + 1)
  | otherwise = []

{- | Invoca a função 'destro', fornecendo-lhe um 'Mapa' e as coordenas para o ponto de começo.

@
desconstroiMapa :: Mapa -> [(Peca, Coordenadas)]
desconstroiMapa [] = []
desconstroiMapa ([]:_) = []
desconstroiMapa ((x:xs):ys) = destro  0 0 ((x:xs):ys)
@

-}

desconstroiMapa :: Mapa -> [(Peca, Coordenadas)]
desconstroiMapa [] = []
desconstroiMapa ([]:_) = []
desconstroiMapa ((x:xs):ys) = destro  0 0 ((x:xs):ys)

{- | Adiciona coordenadas a cada peca e remove as peças "vazias".

@
destro :: Int -> Int -> Mapa -> [(Peca, Coordenadas)]
destro _ _ [] = []
destro x y ([] : xs) = destro 0 (y + 1) xs
destro x y ((z : ys) : xs)
  | z /= Vazio = (z, (x, y)) : destro (x + 1) y (ys : xs)
  | otherwise = destro (x + 1) y (ys : xs)
@

-}

destro :: Int -> Int -> Mapa -> [(Peca, Coordenadas)]
destro _ _ [] = []
destro x y ([] : xs) = destro 0 (y + 1) xs
destro x y ((z : ys) : xs)
  | z /= Vazio = (z, (x, y)) : destro (x + 1) y (ys : xs)
  | otherwise = destro (x + 1) y (ys : xs)

