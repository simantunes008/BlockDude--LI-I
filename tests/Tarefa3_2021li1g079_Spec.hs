module Tarefa3_2021li1g079_Spec where

import Test.HUnit
import Tarefa3_2021li1g079
import Fixtures

testsT3 =
  test
    [ "Tarefa 3 - Teste Imprime Jogo m1e1" ~: "      <\n      X\n      X\nP   C X\nXXXXXXX" ~=?  show m1e1
    , "Tarefa 3 - Teste Imprime Jogo m1e2" ~: "       \n      X\n      X\nP < C X\nXXXXXXX" ~=?  show m1e2
    , "Tarefa 3 - Teste Imprime Jogo m2e1" ~: "         \n        X\nP      CX\nX      CX\n XX > XXX\n XXXXX   " ~=?  show m2e1
    ]