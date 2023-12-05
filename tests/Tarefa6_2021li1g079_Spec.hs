module Tarefa6_2021li1g079_Spec where

import Test.HUnit
import Tarefa6_2021li1g079
import Fixtures
import LI12122 (Movimento(AndarEsquerda,Trepar,AndarDireita,InterageCaixa))

testsT6 =
  test
  [ "Tarefa 6 - Teste resolveJogo 5 t3e1" ~: resolveJogo 5 t3e1 ~=? Just [Trepar,AndarEsquerda,AndarEsquerda,AndarEsquerda,AndarEsquerda]
  , "Tarefa 6 - Teste resolveJogo 6 t3e2" ~: resolveJogo 6 t3e2 ~=? Just [AndarEsquerda,Trepar,AndarEsquerda,AndarEsquerda,AndarEsquerda,AndarEsquerda]
  , "Tarefa 6 - Teste resolveJogo 10 t4e1" ~: resolveJogo 10 t4e1 ~=? Just [AndarDireita,InterageCaixa,AndarDireita,AndarDireita,AndarEsquerda,InterageCaixa,Trepar,Trepar,AndarEsquerda,AndarEsquerda]
  , "Tarefa 6 - Teste resolveJogo 8 t4e2" ~: resolveJogo 8 t4e2 ~=? Just [AndarEsquerda,InterageCaixa,AndarEsquerda,InterageCaixa,Trepar,Trepar,AndarEsquerda,AndarEsquerda]
  ]