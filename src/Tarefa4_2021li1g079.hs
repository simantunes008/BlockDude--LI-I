-- |
-- Module      : Tarefa4_2021li1g079
-- Description : Movimentação do personagem
-- Copyright   : Simão Pedro Ferreira Antunes  <a100597@alunos.uminho.pt>;
--             : Miguel Afonso Gramoso <a100835@alunos.uminho.pt>;
--
-- Módulo para a realização da Tarefa 4 do projeto de LI1 em 2021/22.
module Tarefa4_2021li1g079 where
import LI12122
import Mapas

{- | A função chama a funação 'checkmove' para cada movimento recebido.

@
moveJogador :: Jogo -> Movimento -> Jogo
moveJogador (Jogo [] ((Jogador (a, b) n t))) m = Jogo [] (Jogador (a, b) n t)
moveJogador (Jogo ([]:xs) ((Jogador (a, b) n t))) m = Jogo ([]:xs) (Jogador (a, b) n t)
moveJogador (Jogo ((y : ys) : xs) ((Jogador (a, b) n t))) m = case m of
  AndarDireita -> checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) AndarDireita
  AndarEsquerda -> checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) AndarEsquerda
  Trepar -> checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) Trepar
  InterageCaixa -> checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) InterageCaixa
@

-}

moveJogador :: Jogo -> Movimento -> Jogo
moveJogador (Jogo [] ((Jogador (a, b) n t))) m = Jogo [] (Jogador (a, b) n t)
moveJogador (Jogo ([]:xs) ((Jogador (a, b) n t))) m = Jogo ([]:xs) (Jogador (a, b) n t)
moveJogador (Jogo ((y : ys) : xs) ((Jogador (a, b) n t))) m = case m of
  AndarDireita -> checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) AndarDireita
  AndarEsquerda -> checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) AndarEsquerda
  Trepar -> checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) Trepar
  InterageCaixa -> checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) InterageCaixa

{- | Executa o movimento de andar para a direita.

@
andardireita :: Jogo -> Jogo
andardireita (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
andardireita (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
andardireita (Jogo ((y : ys) : xs) ((Jogador (a, b) n t)))
  |a+1<=length (y:ys) = Jogo ((y : ys) : xs) (Jogador (a + 1, fall ((y : ys) : xs) ((y : ys) : xs) (a + 1) b (a + 1) b) Este t)
  |otherwise=Jogo ((y : ys) : xs) (Jogador (a, b) n t)
@

-}

andardireita :: Jogo -> Jogo
andardireita (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
andardireita (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
andardireita (Jogo ((y : ys) : xs) ((Jogador (a, b) n t)))
  |a+1<=length (y:ys) = Jogo ((y : ys) : xs) (Jogador (a + 1, fall ((y : ys) : xs) ((y : ys) : xs) (a + 1) b (a + 1) b) Este t)
  |otherwise=Jogo ((y : ys) : xs) (Jogador (a, b) n t)

{- | Executa o movimento de andar para a esquerda.

@
andardireita :: Jogo -> Jogo
andardireita (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
andardireita (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
andardireita (Jogo ((y : ys) : xs) ((Jogador (a, b) n t)))
  |a+1<=length (y:ys) = Jogo ((y : ys) : xs) (Jogador (a + 1, fall ((y : ys) : xs) ((y : ys) : xs) (a + 1) b (a + 1) b) Este t)
  |otherwise=Jogo ((y : ys) : xs) (Jogador (a, b) n t)
@

-}

andaresquerda :: Jogo -> Jogo
andaresquerda (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
andaresquerda (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
andaresquerda (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  |a-1>=0=Jogo ((y : ys) : xs) (Jogador (a -1, fall ((y : ys) : xs) ((y : ys) : xs) (a -1) b (a -1) b) Oeste t)
  |otherwise=Jogo ((y : ys) : xs) (Jogador (a, b) n t)

{- | Executa o movimento de pegar numa caixa, quando o jogador nao transporta nenhuma.

@
pegacaixa :: Jogo -> Jogo
pegacaixa (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
pegacaixa (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
pegacaixa (Jogo ((y : ys) : xs) ((Jogador (a, b) Este t))) = Jogo (mapalinhav ((y : ys) : xs) (Jogo ((y : ys) : xs) (Jogador (a+1, b) Este True))) (Jogador (a, b) Este True)
pegacaixa (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste t))) = Jogo (mapalinhav ((y : ys) : xs) (Jogo ((y : ys) : xs) (Jogador (a-1, b) Oeste True))) (Jogador (a, b) Oeste True)
@

-}

pegacaixa :: Jogo -> Jogo
pegacaixa (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
pegacaixa (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
pegacaixa (Jogo ((y : ys) : xs) ((Jogador (a, b) Este t))) = Jogo (mapalinhav ((y : ys) : xs) (Jogo ((y : ys) : xs) (Jogador (a+1, b) Este True))) (Jogador (a, b) Este True)
pegacaixa (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste t))) = Jogo (mapalinhav ((y : ys) : xs) (Jogo ((y : ys) : xs) (Jogador (a-1, b) Oeste True))) (Jogador (a, b) Oeste True)

{- | Executa o movimento de largar uma caixa, quando o jogador transporta uma.

@
largacaixa :: Jogo -> Jogo
largacaixa (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
largacaixa (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
largacaixa (Jogo ((y : ys) : xs) ((Jogador (a, b) Este t))) = Jogo (mapalinhac ((y : ys) : xs) (Jogo ((y : ys) : xs) (Jogador (a + 1, fall ((y : ys) : xs) ((y : ys) : xs) (a + 1) b (a + 1) b) Este False))) (Jogador (a , fall ((y : ys) : xs) ((y : ys) : xs) a  b a b) Este False)
largacaixa (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste t))) = Jogo (mapalinhac ((y : ys) : xs) (Jogo ((y : ys) : xs) (Jogador (a -1, fall ((y : ys) : xs) ((y : ys) : xs) (a - 1) b (a - 1) b) Oeste False))) (Jogador (a, fall ((y : ys) : xs) ((y : ys) : xs) a  b a b) Oeste False)
@

-}

largacaixa :: Jogo -> Jogo
largacaixa (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
largacaixa (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
largacaixa (Jogo ((y : ys) : xs) ((Jogador (a, b) Este t))) = Jogo (mapalinhac ((y : ys) : xs) (Jogo ((y : ys) : xs) (Jogador (a + 1, fall ((y : ys) : xs) ((y : ys) : xs) (a + 1) b (a + 1) b) Este False))) (Jogador (a , fall ((y : ys) : xs) ((y : ys) : xs) a  b a b) Este False)
largacaixa (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste t))) = Jogo (mapalinhac ((y : ys) : xs) (Jogo ((y : ys) : xs) (Jogador (a -1, fall ((y : ys) : xs) ((y : ys) : xs) (a - 1) b (a - 1) b) Oeste False))) (Jogador (a, fall ((y : ys) : xs) ((y : ys) : xs) a  b a b) Oeste False)

{- | Calcula em que linha é necessario colocar uma caixa depois do jogador a largar.

@
mapalinhac :: Mapa -> Jogo -> Mapa
mapalinhac [] _ =  []
mapalinhac ([]:_) _ = []
mapalinhac ((_:_):_) (Jogo [] _) = []
mapalinhac ((_:_):_) (Jogo ([]:_) _) = []
mapalinhac ((i : is) : us) (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  | b /= 0 = (i : is) : mapalinhac us (Jogo ((y : ys) : xs) (Jogador (a, b -1) n t))
  | otherwise = colocacaixa (i : is) (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) : mapalinhac us (Jogo ((y : ys) : xs) (Jogador (a, b -1) n t))
@

-}

mapalinhac :: Mapa -> Jogo -> Mapa
mapalinhac [] _ =  []
mapalinhac ([]:_) _ = []
mapalinhac ((_:_):_) (Jogo [] _) = []
mapalinhac ((_:_):_) (Jogo ([]:_) _) = []
mapalinhac ((i : is) : us) (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  | b /= 0 = (i : is) : mapalinhac us (Jogo ((y : ys) : xs) (Jogador (a, b -1) n t))
  | otherwise = colocacaixa (i : is) (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) : mapalinhac us (Jogo ((y : ys) : xs) (Jogador (a, b -1) n t))

{- | Substitui um espaço "vazio", predeterminado, por uma caixa.

@
colocacaixa :: [Peca] -> Jogo -> [Peca]
colocacaixa [] _ = []
colocacaixa (_:_) (Jogo [] _) = []
colocacaixa (_:_) (Jogo ([]:_) _) = []
colocacaixa (i : is) (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  | a /= 0 = i : colocacaixa is (Jogo ((y : ys) : xs) (Jogador (a-1, b) n t))
  | otherwise = Caixa : colocacaixa is (Jogo ((y : ys) : xs) (Jogador (a-1, b) n t))
@

-}

colocacaixa :: [Peca] -> Jogo -> [Peca]
colocacaixa [] _ = []
colocacaixa (_:_) (Jogo [] _) = []
colocacaixa (_:_) (Jogo ([]:_) _) = []
colocacaixa (i : is) (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  | a /= 0 = i : colocacaixa is (Jogo ((y : ys) : xs) (Jogador (a-1, b) n t))
  | otherwise = Caixa : colocacaixa is (Jogo ((y : ys) : xs) (Jogador (a-1, b) n t))

{- | Calcula em que linha é necessario colocar uma "vazio" depois do jogador pegar numa caixa.

@
mapalinhav :: Mapa -> Jogo -> Mapa
mapalinhav [] _ = []
mapalinhav ([]:_) _ = []
mapalinhav ((_:_):_) (Jogo [] _) = []
mapalinhav ((_:_):_) (Jogo ([]:_) _) = []
mapalinhav ((i : is) : us) (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  | b /= 0 = (i : is) : mapalinhav us (Jogo ((y : ys) : xs) (Jogador (a, b -1) n t))
  | otherwise = colocavazio (i : is) (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) : mapalinhav us (Jogo ((y : ys) : xs) (Jogador (a, b -1) n t))
@

-}

mapalinhav :: Mapa -> Jogo -> Mapa
mapalinhav [] _ = []
mapalinhav ([]:_) _ = []
mapalinhav ((_:_):_) (Jogo [] _) = []
mapalinhav ((_:_):_) (Jogo ([]:_) _) = []
mapalinhav ((i : is) : us) (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  | b /= 0 = (i : is) : mapalinhav us (Jogo ((y : ys) : xs) (Jogador (a, b -1) n t))
  | otherwise = colocavazio (i : is) (Jogo ((y : ys) : xs) (Jogador (a, b) n t)) : mapalinhav us (Jogo ((y : ys) : xs) (Jogador (a, b -1) n t))

{- | Substitui uma Caixa por um "vazio", quando o jogador a pega.

@
colocavazio :: [Peca] -> Jogo -> [Peca]
colocavazio [] _ = []
colocavazio (_:_) (Jogo [] _) = []
colocavazio (_:_) (Jogo ([]:_) _) = []
colocavazio (i : is) (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  | a /= 0 = i : colocavazio is (Jogo ((y : ys) : xs) (Jogador (a-1, b) n t))
  | otherwise = Vazio : colocavazio is (Jogo ((y : ys) : xs) (Jogador (a-1, b) n t))
@

-}

colocavazio :: [Peca] -> Jogo -> [Peca]
colocavazio [] _ = []
colocavazio (_:_) (Jogo [] _) = []
colocavazio (_:_) (Jogo ([]:_) _) = []
colocavazio (i : is) (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  | a /= 0 = i : colocavazio is (Jogo ((y : ys) : xs) (Jogador (a-1, b) n t))
  | otherwise = Vazio : colocavazio is (Jogo ((y : ys) : xs) (Jogador (a-1, b) n t))

{- | Executa o movimento Trepar.

@
trepar :: Jogo -> Jogo
trepar (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
trepar (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
trepar (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  | n == Este = Jogo ((y : ys) : xs) (Jogador (a + 1, b - 1) Este t)
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a - 1, b - 1) Oeste t)
@

-}

trepar :: Jogo -> Jogo
trepar (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
trepar (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
trepar (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
  | n == Este = Jogo ((y : ys) : xs) (Jogador (a + 1, b - 1) Este t)
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a - 1, b - 1) Oeste t)

{- | Aplica gravidade ao Jogador

@
fall :: Mapa -> Mapa -> Int -> Int -> Int -> Int -> Int
fall _ [] _ _ _ _ = 0
fall _ ([]:_) _ _ _ _ = 0
fall l ((y : ys) : xs) a b x z
  | z /= -1 = fall l xs a b x (z -1)
  | x /= 0 = fall l (ys : xs) a b (x -1) z
  | otherwise = case y of
    Bloco -> length l - length ((y : ys) : xs) -1
    Caixa -> length l - length ((y : ys) : xs) -1
    Vazio -> fall l l a (b + 1) a (b + 1)
    Porta -> fall l l a (b + 1) a (b + 1)
@

-}

fall :: Mapa -> Mapa -> Int -> Int -> Int -> Int -> Int
fall _ [] _ _ _ _ = 0
fall _ ([]:_) _ _ _ _ = 0
fall l ((y : ys) : xs) a b x z
  | z /= -1 = fall l xs a b x (z -1)
  | x /= 0 = fall l (ys : xs) a b (x -1) z
  | otherwise = case y of
    Bloco -> length l - length ((y : ys) : xs) -1
    Caixa -> length l - length ((y : ys) : xs) -1
    Vazio -> fall l l a (b + 1) a (b + 1)
    Porta -> fall l l a (b + 1) a (b + 1)

{- | Verifica se uma 'Peca' é solida, se é caixa ou bloco.

@
isblock :: Mapa -> Int -> Int -> Bool
isblock []_ _ = True
isblock ([]:xs) _ _ = True
isblock ((y : ys) : xs) x z
  | z /= 0 = isblock xs x (z -1)
  | x /= 0 = isblock (ys : xs) (x -1) z
  | otherwise = case y of
    Bloco -> True
    Vazio -> False
    Caixa -> True
    Porta -> False
@

-}

isblock :: Mapa -> Int -> Int -> Bool
isblock []_ _ = True
isblock ([]:xs) _ _ = True
isblock ((y : ys) : xs) x z
  | z /= 0 = isblock xs x (z -1)
  | x /= 0 = isblock (ys : xs) (x -1) z
  | otherwise = case y of
    Bloco -> True
    Vazio -> False
    Caixa -> True
    Porta -> False

{- | Verifica se um bloco é caixa.

@
isbox :: Mapa -> Int -> Int -> Bool
isbox []_ _ = True
isbox ([]:xs) _ _ = True
isbox ((y : ys) : xs) x z
  | z /= 0 = isbox xs x (z -1)
  | x /= 0 = isbox (ys : xs) (x -1) z
  | otherwise = case y of
    Bloco -> False
    Vazio -> False
    Caixa -> True
    Porta -> False
@

-}

isbox :: Mapa -> Int -> Int -> Bool
isbox []_ _ = True
isbox ([]:xs) _ _ = True
isbox ((y : ys) : xs) x z
  | z /= 0 = isbox xs x (z -1)
  | x /= 0 = isbox (ys : xs) (x -1) z
  | otherwise = case y of
    Bloco -> False
    Vazio -> False
    Caixa -> True
    Porta -> False

{- | Verifica se os movimentos são válidos e aplica-os.

@
checkmove :: Jogo -> Movimento -> Jogo
checkmove (Jogo [] ((Jogador (a, b) n t))) m = Jogo [] (Jogador (a, b) n t)
checkmove (Jogo ([]:xs) ((Jogador (a, b) n t))) m = Jogo ([]:xs) (Jogador (a, b) n t)
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) n False))) AndarDireita
  | not (isblock ((y : ys) : xs) (a + 1) b) && a<=length (y :ys) = andardireita (Jogo ((y : ys) : xs) (Jogador (a , b) n False))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Este False)
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) n True))) AndarDireita
  | not (isblock ((y : ys) : xs) (a + 1) b) && not(isblock ((y:ys):xs) (a+1) (b-1))= andardireita (Jogo ((y : ys) : xs) (Jogador (a, b) n True))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Este True)
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) n False))) AndarEsquerda
  | not (isblock ((y : ys) : xs) (a -1) b) && a >= 0 = andaresquerda (Jogo ((y : ys) : xs) (Jogador (a, b) n False))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False)
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) n True))) AndarEsquerda
  | not (isblock ((y : ys) : xs) (a - 1) b) && not (isblock ((y:ys):xs) (a-1) (b-1)) = andaresquerda (Jogo ((y : ys) : xs) (Jogador (a, b) n True))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True)
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste False))) Trepar
  | not (isblock ((y : ys) : xs) (a -1) (b -1)) && isblock ((y:ys):xs) (a-1) b= trepar (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False))
  | otherwise= Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False)
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) Este False))) Trepar
  | not (isblock ((y : ys) : xs) (a + 1) (b -1)) && isblock ((y:ys):xs) (a+1) b= trepar (Jogo ((y : ys) : xs) (Jogador (a, b) Este False))
  | otherwise= Jogo ((y : ys) : xs) (Jogador (a, b) Este False)
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) Este True))) Trepar
  | not (isblock ((y : ys) : xs) (a + 1) (b -1)) && isblock ((y:ys):xs) (a+1) b && not (isblock ((y:ys):xs) (a+1) (b-2))= trepar (Jogo ((y : ys) : xs) (Jogador (a, b) Este True))
  | otherwise= Jogo ((y : ys) : xs) (Jogador (a, b) Este True)
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste True))) Trepar
  | not (isblock ((y : ys) : xs) (a - 1) (b -1)) && isblock ((y:ys):xs) (a-1) b && not (isblock ((y:ys):xs) (a-1) (b-2))= trepar (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True))
  | otherwise= Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True)
checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) Este False)) InterageCaixa
  | isbox ((y : ys) : xs) (a + 1) b && not (isblock ((y : ys) : xs) (a +1) (b -1)) && not (isblock ((y:ys):xs) a (b-1)) = pegacaixa (Jogo ((y : ys) : xs) (Jogador (a, b) Este True))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Este False)
checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) Este True)) InterageCaixa
  | isblock ((y : ys) : xs) (a + 1) b && not (isblock ((y : ys) : xs) (a +1) (b -1)) = largacaixa (Jogo ((y : ys) : xs) (Jogador (a, b-1) Este False))
  | not(isbox ((y : ys) : xs) (a + 1) b) && not (isblock ((y : ys) : xs) (a +1) (b -1)) = largacaixa (Jogo ((y : ys) : xs) (Jogador (a, b) Este False))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Este True)
checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False)) InterageCaixa
  | isbox ((y : ys) : xs) (a - 1) b && not (isblock ((y : ys) : xs) (a -1) (b -1)) && not (isblock ((y:ys):xs) a (b-1)) = pegacaixa (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False)
checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True)) InterageCaixa
  | isblock ((y : ys) : xs) (a - 1) b && not (isblock ((y : ys) : xs) (a -1) (b -1)) = largacaixa (Jogo ((y : ys) : xs) (Jogador (a, b-1) Oeste False))
  | not(isblock ((y : ys) : xs) (a - 1) b) && not (isblock ((y : ys) : xs) (a -1) (b -1)) = largacaixa (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True)
@

-}

checkmove :: Jogo -> Movimento -> Jogo
checkmove (Jogo [] ((Jogador (a, b) n t))) m = Jogo [] (Jogador (a, b) n t)
checkmove (Jogo ([]:xs) ((Jogador (a, b) n t))) m = Jogo ([]:xs) (Jogador (a, b) n t)
--direita sem caixa.
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) n False))) AndarDireita
  | not (isblock ((y : ys) : xs) (a + 1) b) && a<=length (y :ys) = andardireita (Jogo ((y : ys) : xs) (Jogador (a , b) n False))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Este False)
--direita com caixa.
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) n True))) AndarDireita
  | not (isblock ((y : ys) : xs) (a + 1) b) && not(isblock ((y:ys):xs) (a+1) (b-1))= andardireita (Jogo ((y : ys) : xs) (Jogador (a, b) n True))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Este True)
--esquerda sem caixa.
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) n False))) AndarEsquerda
  | not (isblock ((y : ys) : xs) (a -1) b) && a >= 0 = andaresquerda (Jogo ((y : ys) : xs) (Jogador (a, b) n False))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False)
--esquerda com caixa.
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) n True))) AndarEsquerda
  | not (isblock ((y : ys) : xs) (a - 1) b) && not (isblock ((y:ys):xs) (a-1) (b-1)) = andaresquerda (Jogo ((y : ys) : xs) (Jogador (a, b) n True))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True)
--trepar sem caixa esquerda.
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste False))) Trepar
  | not (isblock ((y : ys) : xs) (a -1) (b -1)) && isblock ((y:ys):xs) (a-1) b= trepar (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False))
  | otherwise= Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False)
--trepar sem caixa direita.
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) Este False))) Trepar
  | not (isblock ((y : ys) : xs) (a + 1) (b -1)) && isblock ((y:ys):xs) (a+1) b= trepar (Jogo ((y : ys) : xs) (Jogador (a, b) Este False))
  | otherwise= Jogo ((y : ys) : xs) (Jogador (a, b) Este False)
--trepar com caixa direita.
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) Este True))) Trepar
  | not (isblock ((y : ys) : xs) (a + 1) (b -1)) && isblock ((y:ys):xs) (a+1) b && not (isblock ((y:ys):xs) (a+1) (b-2))= trepar (Jogo ((y : ys) : xs) (Jogador (a, b) Este True))
  | otherwise= Jogo ((y : ys) : xs) (Jogador (a, b) Este True)
--trepar com caixa esquerda.
checkmove (Jogo ((y : ys) : xs) ((Jogador (a, b) Oeste True))) Trepar
  | not (isblock ((y : ys) : xs) (a - 1) (b -1)) && isblock ((y:ys):xs) (a-1) b && not (isblock ((y:ys):xs) (a-1) (b-2))= trepar (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True))
  | otherwise= Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True)
--pegar caixa direita.
checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) Este False)) InterageCaixa
  | isbox ((y : ys) : xs) (a + 1) b && not (isblock ((y : ys) : xs) (a +1) (b -1)) && not (isblock ((y:ys):xs) a (b-1)) = pegacaixa (Jogo ((y : ys) : xs) (Jogador (a, b) Este True))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Este False)
--largar caixa direita.
checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) Este True)) InterageCaixa
  | isblock ((y : ys) : xs) (a + 1) b && not (isblock ((y : ys) : xs) (a +1) (b -1)) = largacaixa (Jogo ((y : ys) : xs) (Jogador (a, b-1) Este False))
  | not(isbox ((y : ys) : xs) (a + 1) b) && not (isblock ((y : ys) : xs) (a +1) (b -1)) = largacaixa (Jogo ((y : ys) : xs) (Jogador (a, b) Este False))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Este True)
--pegar caixa esquerda.
checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False)) InterageCaixa
  | isbox ((y : ys) : xs) (a - 1) b && not (isblock ((y : ys) : xs) (a -1) (b -1)) && not (isblock ((y:ys):xs) a (b-1)) = pegacaixa (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False)
--largar caixa esquerda.
checkmove (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True)) InterageCaixa
  | isblock ((y : ys) : xs) (a - 1) b && not (isblock ((y : ys) : xs) (a -1) (b -1)) = largacaixa (Jogo ((y : ys) : xs) (Jogador (a, b-1) Oeste False))
  | not(isblock ((y : ys) : xs) (a - 1) b) && not (isblock ((y : ys) : xs) (a -1) (b -1)) = largacaixa (Jogo ((y : ys) : xs) (Jogador (a, b) Oeste False))
  | otherwise = Jogo ((y : ys) : xs) (Jogador (a, b) Oeste True)

{- | Funcao de origem, vai defenir todos os movimentos do jogador.

@
correrMovimentos :: Jogo -> [Movimento] -> Jogo
correrMovimentos (Jogo [] ((Jogador (a, b) n t))) m = Jogo [] (Jogador (a, b) n t)
correrMovimentos (Jogo ([]:xs) ((Jogador (a, b) n t))) m = Jogo ([]:xs) (Jogador (a, b) n t)
correrMovimentos (Jogo ((y : ys) : xs) ((Jogador (a, b) n t))) [] = placeplayer (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
correrMovimentos (Jogo ((y : ys) : xs) ((Jogador (a, b) n t))) (z : zs) = correrMovimentos (moveJogador (placeplayer (Jogo ((y : ys) : xs) (Jogador (a, b) n t))) z) zs
@

-}

correrMovimentos :: Jogo -> [Movimento] -> Jogo
correrMovimentos (Jogo [] ((Jogador (a, b) n t))) m = Jogo [] (Jogador (a, b) n t)
correrMovimentos (Jogo ([]:xs) ((Jogador (a, b) n t))) m = Jogo ([]:xs) (Jogador (a, b) n t)
correrMovimentos (Jogo ((y : ys) : xs) ((Jogador (a, b) n t))) [] = placeplayer (Jogo ((y : ys) : xs) (Jogador (a, b) n t))
correrMovimentos (Jogo ((y : ys) : xs) ((Jogador (a, b) n t))) (z : zs) = correrMovimentos (moveJogador (placeplayer (Jogo ((y : ys) : xs) (Jogador (a, b) n t))) z) zs

{- | Coloca o jogador numa posicao valida.

@
placeplayer :: Jogo -> Jogo
placeplayer (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
placeplayer (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
placeplayer (Jogo ((y : ys) : xs) ((Jogador (a, b) n t)))=Jogo ((y : ys) : xs) (Jogador (a,fall ((y : ys) : xs) ((y : ys) : xs) a b a  b ) n t)
@

-}

placeplayer :: Jogo -> Jogo
placeplayer (Jogo [] ((Jogador (a, b) n t))) = Jogo [] (Jogador (a, b) n t)
placeplayer (Jogo ([]:xs) ((Jogador (a, b) n t))) = Jogo ([]:xs) (Jogador (a, b) n t)
placeplayer (Jogo ((y : ys) : xs) ((Jogador (a, b) n t)))=Jogo ((y : ys) : xs) (Jogador (a,fall ((y : ys) : xs) ((y : ys) : xs) a b a  b ) n t)