module Tarefa1_2021li1g079_Spec where

import Test.HUnit
import LI12122
import Tarefa1_2021li1g079
import Fixtures

-- Tarefa 1
testsT1 =
  test
    [ "Tarefa 1 - Teste Valida Mapa m1r" ~: validaPotencialMapa m1 ~=? True
    , "Tarefa 1 - Teste Valida Mapa vazio" ~: validaPotencialMapa [] ~=? False
    , "Tarefa 1 - Teste Valida Mapa com 2 portas" ~: validaPotencialMapa [(Porta, (0,0)), (Porta, (1,0))] ~=?  False
    , "Tarefa 1 - Teste Valida Mapa com 1 porta a flutuar" ~: validaPotencialMapa [(Porta, (0,0)), (Bloco, (0,2)), (Bloco, (1,2))] ~=?  False
    , "Tarefa 1 - Teste Valida Mapa sem espaços vazios" ~: validaPotencialMapa [(Bloco,(0,0)),(Porta,(0,1)),(Bloco,(0,2)),(Bloco,(1,0)),(Caixa,(1,1)),(Bloco,(1,2)),(Bloco,(2,0)),(Bloco,(2,1)),(Bloco,(2,2))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa com falhas na base" ~: validaPotencialMapa [(Porta, (0,0)), (Bloco,(0,1)), (Bloco,(1,1)), (Bloco,(3,1))] ~=?  False
    , "Tarefa 1 - Teste Valida Mapa com 1 caixa a flutuar" ~: validaPotencialMapa [(Porta, (0,1)), (Bloco,(0,2)), (Bloco,(1,2)), (Bloco,(2,2)), (Bloco,(3,2)), (Caixa,(3,0))] ~=?  False
    , "Tarefa 1 - Teste Valida Mapa com 2 peças com a mesma coordenada" ~: validaPotencialMapa [(Porta,(0,0)),(Bloco,(0,1)),(Bloco,(1,1)),(Bloco,(2,1)),(Bloco,(2,1))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa m2r" ~: validaPotencialMapa m2 ~=? True
    ]