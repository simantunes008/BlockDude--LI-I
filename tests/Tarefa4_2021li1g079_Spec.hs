module Tarefa4_2021li1g079_Spec where

import Test.HUnit
import LI12122
import Tarefa3_2021li1g079
import Tarefa4_2021li1g079
import Fixtures

testsT4 =
  test
    [ "Tarefa 4 - Teste Move m1e1 Oeste" ~: Jogo m1r (Jogador (5, 3) Oeste False) ~=?  moveJogador m1e1 AndarEsquerda
    , "Tarefa 4 - Teste Move m1e1 Este" ~: Jogo m1r (Jogador (6, 0) Este False) ~=?  moveJogador m1e1 AndarDireita
    , "Tarefa 4 - Teste Move m1e1 Trepar" ~: m1e1 ~=? moveJogador m1e1 Trepar
    , "Tarefa 4 - Teste Move m1e1 InterageCaixa" ~: m1e1 ~=?  moveJogador m1e1 InterageCaixa
    , "Tarefa 4 - Teste Move t2e2 cair caixa" ~:t2e21 ~=? moveJogador t2e2 InterageCaixa
    , "Tarefa 4 - Teste Move t1e3 meter caixa na diagonal" ~:t1e3 ~=? moveJogador t1e2 InterageCaixa
    , "Tarefa 4 - Teste movimentos m1e1" ~: m1e2 ~=?  correrMovimentos m1e1 [AndarEsquerda, Trepar, AndarEsquerda, AndarEsquerda]
    , "Tarefa 4 - Teste movimentos m1e2 Caixa1" ~: Jogo
        [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Porta, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
        ]
        (Jogador (3, 3) Este True) ~=?  correrMovimentos m1e2 [AndarDireita, InterageCaixa]
    , "Tarefa 4 - Teste movimentos m1e2 Caixa2" ~:
      Jogo
        [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Porta, Caixa, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
        ]
        (Jogador (2, 3) Oeste False) ~=?  correrMovimentos m1e2 [AndarDireita, InterageCaixa, AndarEsquerda, InterageCaixa]
    ,"Tarefa 4-Trepar invalido, devido a caixa" ~:Jogo t1 (Jogador (2,3) Este True) ~=? moveJogador t1e2 Trepar
    ,"Tarefa 4-Trepar valido" ~:Jogo t1 (Jogador (3,2) Este False) ~=? moveJogador t1e1 Trepar
    ,"Tarefa 4-andar invalido" ~:Jogo t1 (Jogador (2,3) Oeste False) ~=? moveJogador t1e1 AndarEsquerda
    ,"Tarefa 4 - Teste movimentos para fazer escada" ~:
      Jogo
        [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
        , [Vazio, Bloco, Vazio, Vazio, Vazio, Vazio, Bloco]
        , [Vazio, Bloco, Caixa, Vazio, Vazio, Vazio, Bloco]
        , [Porta, Bloco, Caixa, Caixa, Vazio, Vazio, Bloco]
        , [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
        ]
        (Jogador (1, 0) Oeste False) ~=?  correrMovimentos t2e1 [AndarDireita,Trepar, InterageCaixa, AndarEsquerda, InterageCaixa,AndarDireita,InterageCaixa,AndarDireita,Trepar,AndarEsquerda,InterageCaixa,AndarDireita,InterageCaixa,AndarEsquerda,Trepar,InterageCaixa,Trepar,Trepar]
    ,"Tarefa 4-Trepar invalido, devido a caixa" ~:Jogo t1 (Jogador (2,3) Este True) ~=? moveJogador t1e2 Trepar
    ,"Tarefa 4 cair" ~:Jogo m1r (Jogador (2,3) Este False) ~=? correrMovimentos (Jogo m1r (Jogador (2,0) Este False)) []
    
    ]
  