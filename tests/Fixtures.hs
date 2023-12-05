module Fixtures where

import LI12122
import LI12122 (Mapa, Jogo)

m1 :: [(Peca, Coordenadas)]
m1 =
  [ (Porta, (0, 3)),
    (Bloco, (0, 4)),
    (Bloco, (1, 4)),
    (Bloco, (2, 4)),
    (Bloco, (3, 4)),
    (Bloco, (4, 4)),
    (Caixa, (4, 3)),
    (Bloco, (5, 4)),
    (Bloco, (6, 4)),
    (Bloco, (6, 3)),
    (Bloco, (6, 2)),
    (Bloco, (6, 1))
  ]

m2 :: [(Peca, Coordenadas)]
m2 = 
  [ (Porta,(0,2)),
    (Bloco,(0,3)),
    (Bloco,(0,4)),
    (Bloco,(1,4)),
    (Bloco,(2,4)),
    (Bloco,(1,5)),
    (Bloco,(2,5)),
    (Bloco,(3,5)),
    (Bloco,(4,5)),
    (Bloco,(5,5)),
    (Bloco,(6,4)),
    (Bloco,(7,4)),
    (Bloco,(8,4)),
    (Caixa,(7,3)),
    (Caixa,(7,2)),
    (Bloco,(8,3)),
    (Bloco,(8,2)),
    (Bloco,(8,1))
  ]

m1r :: Mapa
m1r =
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

m2r :: Mapa
m2r = 
  [ [Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio],
    [Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Bloco],
    [Porta,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Bloco],
    [Bloco,Vazio,Vazio,Vazio,Vazio,Vazio,Vazio,Caixa,Bloco],
    [Vazio,Bloco,Bloco,Vazio,Vazio,Vazio,Bloco,Bloco,Bloco],
    [Vazio,Bloco,Bloco,Bloco,Bloco,Bloco,Vazio,Vazio,Vazio]
  ]

m5r :: Mapa
m5r =
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Vazio, Vazio, Bloco, Vazio, Vazio, Vazio, Bloco],
    [Porta, Vazio, Bloco, Vazio, Caixa, Vazio, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

m1e1 :: Jogo
m1e1 = Jogo m1r (Jogador (6, 0) Oeste False)

m1e2 :: Jogo
m1e2 = Jogo m1r (Jogador (2, 3) Oeste False)

m2e1 :: Jogo
m2e1 = Jogo m2r (Jogador (4, 4) Este False)

t1::Mapa
t1=
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Bloco, Vazio, Bloco, Vazio, Vazio, Bloco],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Porta, Bloco, Vazio, Bloco, Vazio, Vazio, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

t11::Mapa
t11=
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Bloco, Vazio, Bloco, Vazio, Vazio, Bloco],
    [Vazio, Vazio, Vazio, Caixa, Vazio, Vazio, Bloco],
    [Porta, Bloco, Vazio, Bloco, Vazio, Vazio, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

t1e1::Jogo 
t1e1= Jogo t1 (Jogador (2,3) Este False)

t1e2::Jogo 
t1e2= Jogo t1 (Jogador (2,3) Este True)

t1e3::Jogo
t1e3=Jogo t11 (Jogador (2,3) Este False)


t2 :: Mapa
t2 =
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Bloco, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Vazio, Bloco, Vazio, Vazio, Vazio, Caixa, Bloco],
    [Porta, Bloco, Vazio, Vazio, Caixa, Caixa, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

t21 :: Mapa
t21 =
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Vazio, Bloco, Vazio, Vazio, Vazio, Caixa, Bloco],
    [Porta, Bloco, Vazio, Vazio, Caixa, Caixa, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

t211 :: Mapa
t211 =
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Vazio, Bloco, Vazio, Vazio, Vazio, Caixa, Bloco],
    [Porta, Bloco, Caixa, Vazio, Caixa, Caixa, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

t2e1::Jogo 
t2e1= Jogo t2 (Jogador (2,3) Este False)

t2e2::Jogo
t2e2=Jogo t21 (Jogador (1,1) Este True)

t2e21::Jogo
t2e21=Jogo t211 (Jogador (1,1) Este False)

t3 :: Mapa
t3 =
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Porta, Vazio, Vazio, Vazio, Bloco, Vazio, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

t3e1 :: Jogo
t3e1 = Jogo t3 (Jogador (5,3) Oeste False)

t3e2 :: Jogo
t3e2 = Jogo t3 (Jogador (5,3) Este False)

t4 :: Mapa
t4 =
  [ [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio],
    [Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco],
    [Vazio, Vazio, Bloco, Vazio, Vazio, Vazio, Bloco],
    [Porta, Vazio, Bloco, Vazio, Caixa, Vazio, Bloco],
    [Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
  ]

t4e1 :: Jogo
t4e1 = Jogo t4 (Jogador (3,3) Oeste False)

t4e2 :: Jogo
t4e2 = Jogo t4 (Jogador (5,3) Este False)