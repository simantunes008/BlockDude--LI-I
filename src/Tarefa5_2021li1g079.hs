{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

-- |
-- Module      : Tarefa5_2021li1g079
-- Description : Aplicação Gráfica
--
-- Módulo para a realização da Tarefa 5 do projeto de LI1 em 2021/22.
module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Juicy (loadJuicy)
import LI12122
import Tarefa4_2021li1g079
import Mapas


data EstadoGloss = Estado {
  pngs::PNG,
  menuAtual:: Menu,
  jogoAtual::Jogo,
  jogoInicial::Jogo
}

data PNG = PNG {
  pl ::Picture,
  pr :: Picture,
  block :: Picture,
  box :: Picture,
  plb :: Picture,
  prb :: Picture,
  door :: Picture,
  menu1::Picture,
  menu2::Picture,
  back::Picture,
  nivel1::Picture,
  nivel2::Picture,
  nivel3::Picture,
  nivel4::Picture,
  nivel5::Picture,
  tutorial::Picture,
  vitoria::Picture
}

data Menu= Game Niveis| MenuPrincipal Options

data Options = Jogar | Tutorial | Teclas

data Niveis = Nivel1 | Nivel2 | Nivel3 | Nivel4 | Nivel5 | Play | Vitoria


{-| funçao que reage a todos os eventos do jogo

reageEventoGloss :: Event -> EstadoGloss -> EstadoGloss
reageEventoGloss (EventKey (SpecialKey KeyDown) Down _ _)    e@(Estado _ (MenuPrincipal Jogar) _ _) = e {menuAtual = MenuPrincipal Tutorial}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (MenuPrincipal Tutorial)_ _) = e {menuAtual =MenuPrincipal Teclas }
reageEventoGloss (EventKey (Char 'b') Down _ _)    e@(Estado _ (MenuPrincipal Teclas)_ _) = e {menuAtual =MenuPrincipal Tutorial}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (MenuPrincipal Jogar)_ _) = e {menuAtual = Game Nivel1}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Nivel1)_ _) = e {menuAtual = Game Nivel2}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Nivel2)_ _) = e {menuAtual = Game Nivel3}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Nivel4)_ _) = e {menuAtual = Game Nivel5}
reageEventoGloss (EventKey (SpecialKey KeyDown) Down _ _)    e@(Estado _ (Game Nivel1)_ _) = e {menuAtual = Game Nivel4}
reageEventoGloss (EventKey (SpecialKey KeyDown) Down _ _)    e@(Estado _ (Game Nivel2)_ _) = e {menuAtual = Game Nivel5}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Nivel3)_ _) = e {menuAtual = Game Nivel2}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Nivel2)_ _) = e {menuAtual = Game Nivel1}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Nivel5)_ _) = e {menuAtual = Game Nivel4}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Nivel4)_ _) = e {menuAtual = Game Nivel1}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Nivel5)_ _) = e {menuAtual = Game Nivel2}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (Game Nivel1)_ _) = e {menuAtual = Game Play,jogoAtual=(Jogo m1 (Jogador (17,4) Oeste False)),jogoInicial=(Jogo m1 (Jogador (17,4) Oeste False))}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (Game Nivel2)_ _) = e {menuAtual = Game Play,jogoAtual=(Jogo m2 (Jogador (18,5) Oeste False)),jogoInicial=(Jogo m2 (Jogador (18,5) Oeste False))}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (Game Nivel3)_ _) = e {menuAtual = Game Play,jogoAtual=(Jogo m3 (Jogador (9,5) Oeste False)),jogoInicial=(Jogo m3 (Jogador (9,5) Oeste False))}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (Game Nivel4)_ _) = e {menuAtual = Game Play,jogoAtual=(Jogo m4 (Jogador (11,4) Oeste False)),jogoInicial=(Jogo m4 (Jogador (11,4) Oeste False))}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (Game Nivel5)_ _) = e {menuAtual = Game Play,jogoAtual=(Jogo m5 (Jogador (13,5) Oeste False)),jogoInicial=(Jogo m5 (Jogador (13,5) Oeste False))}
reageEventoGloss (EventKey (Char 'r') Down _ _ )e@(Estado _ (Game Play)_ i)= e {jogoAtual=i}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (MenuPrincipal Tutorial)_ _) = e {menuAtual = MenuPrincipal Jogar}
reageEventoGloss (EventKey (SpecialKey KeyDown) Down _ _)    e@(Estado _ (Game Play) j _) = e {jogoAtual = moveJogador j InterageCaixa}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j i) = e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Play) j (Jogo m1 (Jogador (17,4) Oeste False))) =if checkporta (moveJogador j AndarEsquerda) 
  then e {jogoAtual= (Jogo m2 (Jogador (18,5) Oeste False)),jogoInicial=(Jogo m2 (Jogador (18,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarEsquerda}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Play) j (Jogo m2 (Jogador (18,5) Oeste False))) =if checkporta (moveJogador j AndarEsquerda) 
  then e {jogoAtual= (Jogo m3 (Jogador (9,5) Oeste False)),jogoInicial=(Jogo m3 (Jogador (9,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarEsquerda}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Play) j (Jogo m3 (Jogador (9,5) Oeste False))) =if checkporta (moveJogador j AndarEsquerda) 
  then e {jogoAtual= (Jogo m4 (Jogador (11,4) Oeste False)),jogoInicial=(Jogo m4 (Jogador (11,4) Oeste False))}
    else e {jogoAtual = moveJogador j AndarEsquerda}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Play) j (Jogo m4 (Jogador (11,4) Oeste False))) =if checkporta (moveJogador j AndarEsquerda) 
  then e {jogoAtual= (Jogo m5 (Jogador (13,5) Oeste False)),jogoInicial=(Jogo m5 (Jogador (13,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarEsquerda}

reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j (Jogo m1 (Jogador (17,4) Oeste False))) =if checkporta (moveJogador j AndarDireita) 
  then e {jogoAtual= (Jogo m2 (Jogador (18,5) Oeste False)),jogoInicial=(Jogo m2 (Jogador (18,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j (Jogo m2 (Jogador (18,5) Oeste False))) =if checkporta (moveJogador j AndarDireita) 
  then e {jogoAtual= (Jogo m3 (Jogador (9,5) Oeste False)),jogoInicial=(Jogo m3 (Jogador (9,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j (Jogo m3 (Jogador (9,5) Oeste False))) =if checkporta (moveJogador j AndarDireita) 
  then e {jogoAtual= (Jogo m4 (Jogador (11,4) Oeste False)),jogoInicial=(Jogo m4 (Jogador (11,4) Oeste False))}
    else e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j (Jogo m4 (Jogador (11,4) Oeste False))) =if checkporta (moveJogador j AndarDireita) 
  then e {jogoAtual= (Jogo m5 (Jogador (13,5) Oeste False)),jogoInicial=(Jogo m5 (Jogador (13,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Play) j (Jogo m1 (Jogador (17,4) Oeste False))) =if checkporta (moveJogador j Trepar) 
  then e {jogoAtual= (Jogo m2 (Jogador (18,5) Oeste False)),jogoInicial=(Jogo m2 (Jogador (18,5) Oeste False))}
    else e {jogoAtual = moveJogador j Trepar}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Play) j (Jogo m2 (Jogador (18,5) Oeste False))) =if checkporta (moveJogador j Trepar) 
  then e {jogoAtual= (Jogo m3 (Jogador (9,5) Oeste False)),jogoInicial=(Jogo m3 (Jogador (9,5) Oeste False))}
    else e {jogoAtual = moveJogador j Trepar}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Play) j (Jogo m3 (Jogador (9,5) Oeste False))) =if checkporta (moveJogador j Trepar) 
  then e {jogoAtual= (Jogo m4 (Jogador (11,4) Oeste False)),jogoInicial=(Jogo m4 (Jogador (11,4) Oeste False))}
    else e {jogoAtual = moveJogador j Trepar}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Play) j (Jogo m4 (Jogador (11,4) Oeste False))) =if checkporta (moveJogador j Trepar) 
  then e {jogoAtual= (Jogo m5 (Jogador (13,5) Oeste False)),jogoInicial=(Jogo m5 (Jogador (13,5) Oeste False))}
    else e {jogoAtual = moveJogador j Trepar}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Play) j (Jogo m5 (Jogador (13,5) Oeste False)) ) =if checkporta (moveJogador j Trepar) 
  then e {menuAtual =Game Vitoria}
    else e {jogoAtual = moveJogador j Trepar}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Play) j (Jogo m5 (Jogador (13,5) Oeste False)) ) =if checkporta (moveJogador j AndarEsquerda) 
  then e {menuAtual =Game Vitoria}
    else e {jogoAtual = moveJogador j AndarEsquerda}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j (Jogo m5 (Jogador (13,5) Oeste False)) ) =if checkporta (moveJogador j AndarDireita) 
  then e {menuAtual =Game Vitoria}
    else e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss _ s = s
@

-}


reageEventoGloss :: Event -> EstadoGloss -> EstadoGloss
reageEventoGloss (EventKey (SpecialKey KeyDown) Down _ _)    e@(Estado _ (MenuPrincipal Jogar) _ _) = e {menuAtual = MenuPrincipal Tutorial}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (MenuPrincipal Tutorial)_ _) = e {menuAtual =MenuPrincipal Teclas }
reageEventoGloss (EventKey (Char 'b') Down _ _)    e@(Estado _ (MenuPrincipal Teclas)_ _) = e {menuAtual =MenuPrincipal Tutorial}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (MenuPrincipal Jogar)_ _) = e {menuAtual = Game Nivel1}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Nivel1)_ _) = e {menuAtual = Game Nivel2}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Nivel2)_ _) = e {menuAtual = Game Nivel3}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Nivel4)_ _) = e {menuAtual = Game Nivel5}
reageEventoGloss (EventKey (SpecialKey KeyDown) Down _ _)    e@(Estado _ (Game Nivel1)_ _) = e {menuAtual = Game Nivel4}
reageEventoGloss (EventKey (SpecialKey KeyDown) Down _ _)    e@(Estado _ (Game Nivel2)_ _) = e {menuAtual = Game Nivel5}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Nivel3)_ _) = e {menuAtual = Game Nivel2}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Nivel2)_ _) = e {menuAtual = Game Nivel1}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Nivel5)_ _) = e {menuAtual = Game Nivel4}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Nivel4)_ _) = e {menuAtual = Game Nivel1}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Nivel5)_ _) = e {menuAtual = Game Nivel2}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (Game Nivel1)_ _) = e {menuAtual = Game Play,jogoAtual=(Jogo m1 (Jogador (17,4) Oeste False)),jogoInicial=(Jogo m1 (Jogador (17,4) Oeste False))}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (Game Nivel2)_ _) = e {menuAtual = Game Play,jogoAtual=(Jogo m2 (Jogador (18,5) Oeste False)),jogoInicial=(Jogo m2 (Jogador (18,5) Oeste False))}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (Game Nivel3)_ _) = e {menuAtual = Game Play,jogoAtual=(Jogo m3 (Jogador (9,5) Oeste False)),jogoInicial=(Jogo m3 (Jogador (9,5) Oeste False))}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (Game Nivel4)_ _) = e {menuAtual = Game Play,jogoAtual=(Jogo m4 (Jogador (11,4) Oeste False)),jogoInicial=(Jogo m4 (Jogador (11,4) Oeste False))}
reageEventoGloss (EventKey (SpecialKey KeyEnter) Down _ _)    e@(Estado _ (Game Nivel5)_ _) = e {menuAtual = Game Play,jogoAtual=(Jogo m5 (Jogador (13,5) Oeste False)),jogoInicial=(Jogo m5 (Jogador (13,5) Oeste False))}
reageEventoGloss (EventKey (Char 'r') Down _ _ )e@(Estado _ (Game Play)_ i)= e {jogoAtual=i}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (MenuPrincipal Tutorial)_ _) = e {menuAtual = MenuPrincipal Jogar}
reageEventoGloss (EventKey (SpecialKey KeyDown) Down _ _)    e@(Estado _ (Game Play) j _) = e {jogoAtual = moveJogador j InterageCaixa}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j i) = e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Play) j (Jogo m1 (Jogador (17,4) Oeste False))) =if checkporta (moveJogador j AndarEsquerda) 
  then e {jogoAtual= (Jogo m2 (Jogador (18,5) Oeste False)),jogoInicial=(Jogo m2 (Jogador (18,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarEsquerda}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Play) j (Jogo m2 (Jogador (18,5) Oeste False))) =if checkporta (moveJogador j AndarEsquerda) 
  then e {jogoAtual= (Jogo m3 (Jogador (9,5) Oeste False)),jogoInicial=(Jogo m3 (Jogador (9,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarEsquerda}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Play) j (Jogo m3 (Jogador (9,5) Oeste False))) =if checkporta (moveJogador j AndarEsquerda) 
  then e {jogoAtual= (Jogo m4 (Jogador (11,4) Oeste False)),jogoInicial=(Jogo m4 (Jogador (11,4) Oeste False))}
    else e {jogoAtual = moveJogador j AndarEsquerda}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Play) j (Jogo m4 (Jogador (11,4) Oeste False))) =if checkporta (moveJogador j AndarEsquerda) 
  then e {jogoAtual= (Jogo m5 (Jogador (13,5) Oeste False)),jogoInicial=(Jogo m5 (Jogador (13,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarEsquerda}

reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j (Jogo m1 (Jogador (17,4) Oeste False))) =if checkporta (moveJogador j AndarDireita) 
  then e {jogoAtual= (Jogo m2 (Jogador (18,5) Oeste False)),jogoInicial=(Jogo m2 (Jogador (18,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j (Jogo m2 (Jogador (18,5) Oeste False))) =if checkporta (moveJogador j AndarDireita) 
  then e {jogoAtual= (Jogo m3 (Jogador (9,5) Oeste False)),jogoInicial=(Jogo m3 (Jogador (9,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j (Jogo m3 (Jogador (9,5) Oeste False))) =if checkporta (moveJogador j AndarDireita) 
  then e {jogoAtual= (Jogo m4 (Jogador (11,4) Oeste False)),jogoInicial=(Jogo m4 (Jogador (11,4) Oeste False))}
    else e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j (Jogo m4 (Jogador (11,4) Oeste False))) =if checkporta (moveJogador j AndarDireita) 
  then e {jogoAtual= (Jogo m5 (Jogador (13,5) Oeste False)),jogoInicial=(Jogo m5 (Jogador (13,5) Oeste False))}
    else e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Play) j (Jogo m1 (Jogador (17,4) Oeste False))) =if checkporta (moveJogador j Trepar) 
  then e {jogoAtual= (Jogo m2 (Jogador (18,5) Oeste False)),jogoInicial=(Jogo m2 (Jogador (18,5) Oeste False))}
    else e {jogoAtual = moveJogador j Trepar}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Play) j (Jogo m2 (Jogador (18,5) Oeste False))) =if checkporta (moveJogador j Trepar) 
  then e {jogoAtual= (Jogo m3 (Jogador (9,5) Oeste False)),jogoInicial=(Jogo m3 (Jogador (9,5) Oeste False))}
    else e {jogoAtual = moveJogador j Trepar}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Play) j (Jogo m3 (Jogador (9,5) Oeste False))) =if checkporta (moveJogador j Trepar) 
  then e {jogoAtual= (Jogo m4 (Jogador (11,4) Oeste False)),jogoInicial=(Jogo m4 (Jogador (11,4) Oeste False))}
    else e {jogoAtual = moveJogador j Trepar}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Play) j (Jogo m4 (Jogador (11,4) Oeste False))) =if checkporta (moveJogador j Trepar) 
  then e {jogoAtual= (Jogo m5 (Jogador (13,5) Oeste False)),jogoInicial=(Jogo m5 (Jogador (13,5) Oeste False))}
    else e {jogoAtual = moveJogador j Trepar}
reageEventoGloss (EventKey (SpecialKey KeyUp) Down _ _)    e@(Estado _ (Game Play) j (Jogo m5 (Jogador (13,5) Oeste False)) ) =if checkporta (moveJogador j Trepar) 
  then e {menuAtual =Game Vitoria}
    else e {jogoAtual = moveJogador j Trepar}
reageEventoGloss (EventKey (SpecialKey KeyLeft) Down _ _)    e@(Estado _ (Game Play) j (Jogo m5 (Jogador (13,5) Oeste False)) ) =if checkporta (moveJogador j AndarEsquerda) 
  then e {menuAtual =Game Vitoria}
    else e {jogoAtual = moveJogador j AndarEsquerda}
reageEventoGloss (EventKey (SpecialKey KeyRight) Down _ _)    e@(Estado _ (Game Play) j (Jogo m5 (Jogador (13,5) Oeste False)) ) =if checkporta (moveJogador j AndarDireita) 
  then e {menuAtual =Game Vitoria}
    else e {jogoAtual = moveJogador j AndarDireita}
reageEventoGloss _ s = s

{-|funçao que verifica se a posiçao do jogador é sobreposta a porta

@
checkporta:: Jogo -> Bool
checkporta (Jogo m (Jogador (x,y) _ _)) = ((m !! y) !! x) == Porta
@

-}

checkporta:: Jogo -> Bool
checkporta (Jogo m (Jogador (x,y) _ _)) = ((m !! y) !! x) == Porta



{-|funçao que carrega todos as imagens utilizadas no jogo

@
loadPNG::IO PNG
loadPNG = do
  Just pl <- loadJuicy "textures/playerleft.png"
  Just pr <- loadJuicy "textures/playerright.png"
  Just block <- loadJuicy "textures/block.png"
  Just box <- loadJuicy "textures/box.png"
  Just plb <- loadJuicy "textures/playerleftbox.png"
  Just prb <- loadJuicy "textures/playerrightbox.png"
  Just door <- loadJuicy "textures/porta.png"
  Just menu1<-loadJuicy "textures/menuopcao1.png"
  Just menu2<-loadJuicy "textures/menuopcao2.png"
  Just back<- loadJuicy "textures/background.png"
  Just nivel1<- loadJuicy "textures/nivel1.png"
  Just nivel2<- loadJuicy "textures/nivel2.png"
  Just nivel3<- loadJuicy "textures/nivel3.png"
  Just nivel4<- loadJuicy "textures/nivel4.png"
  Just nivel5<- loadJuicy "textures/nivel5.png"
  Just tutorial<- loadJuicy "textures/tutorial.png"
  Just vitoria<- loadJuicy "textures/victory.png"
  return (PNG pl pr block box plb prb door menu1 menu2 back nivel1 nivel2 nivel3 nivel4 nivel5 tutorial vitoria)
@

-}

loadPNG::IO PNG
loadPNG = do
  Just pl <- loadJuicy "textures/playerleft.png"
  Just pr <- loadJuicy "textures/playerright.png"
  Just block <- loadJuicy "textures/block.png"
  Just box <- loadJuicy "textures/box.png"
  Just plb <- loadJuicy "textures/playerleftbox.png"
  Just prb <- loadJuicy "textures/playerrightbox.png"
  Just door <- loadJuicy "textures/porta.png"
  Just menu1<-loadJuicy "textures/menuopcao1.png"
  Just menu2<-loadJuicy "textures/menuopcao2.png"
  Just back<- loadJuicy "textures/background.png"
  Just nivel1<- loadJuicy "textures/nivel1.png"
  Just nivel2<- loadJuicy "textures/nivel2.png"
  Just nivel3<- loadJuicy "textures/nivel3.png"
  Just nivel4<- loadJuicy "textures/nivel4.png"
  Just nivel5<- loadJuicy "textures/nivel5.png"
  Just tutorial<- loadJuicy "textures/tutorial.png"
  Just vitoria<- loadJuicy "textures/victory.png"
  return (PNG pl pr block box plb prb door menu1 menu2 back nivel1 nivel2 nivel3 nivel4 nivel5 tutorial vitoria)

{-|funçao que desenha todos os estados

@
desenhaEstado::EstadoGloss->Picture
desenhaEstado (Estado p (MenuPrincipal Teclas) _ _) = tutorial p
desenhaEstado (Estado p (Game Nivel1)_ _)= nivel1 p
desenhaEstado (Estado p (Game Nivel2)_ _)= nivel2 p
desenhaEstado (Estado p (Game Nivel3)_ _)= nivel3 p
desenhaEstado (Estado p (Game Nivel4)_ _)= nivel4 p
desenhaEstado (Estado p (Game Nivel5)_ _)= nivel5 p
desenhaEstado (Estado p (MenuPrincipal Jogar) _ _) =  menu1 p
desenhaEstado (Estado p (MenuPrincipal Tutorial) _ _) =  menu2 p
desenhaEstado (Estado p (Game Play) j _)= Pictures (desenhaMapa p j)
desenhaEstado (Estado p (Game Vitoria) _ _)= vitoria p
@

-}


desenhaEstado::EstadoGloss->Picture
desenhaEstado (Estado p (MenuPrincipal Teclas) _ _) = tutorial p
desenhaEstado (Estado p (Game Nivel1)_ _)= nivel1 p
desenhaEstado (Estado p (Game Nivel2)_ _)= nivel2 p
desenhaEstado (Estado p (Game Nivel3)_ _)= nivel3 p
desenhaEstado (Estado p (Game Nivel4)_ _)= nivel4 p
desenhaEstado (Estado p (Game Nivel5)_ _)= nivel5 p
desenhaEstado (Estado p (MenuPrincipal Jogar) _ _) =  menu1 p
desenhaEstado (Estado p (MenuPrincipal Tutorial) _ _) =  menu2 p
desenhaEstado (Estado p (Game Play) j _)= Pictures (desenhaMapa p j)
desenhaEstado (Estado p (Game Vitoria) _ _)= vitoria p

{-| funçao que reage ao passar do tempo

@
reageTempoGloss::Float->EstadoGloss->EstadoGloss
reageTempoGloss _ e = e
@

-}

reageTempoGloss::Float->EstadoGloss->EstadoGloss
reageTempoGloss _ e = e


{-| dimensao do dispaly

@
dm::Display
dm = InWindow "Mario Box" (1920,960) (0,0)
@

-}

dm::Display
dm = InWindow "Mario Box" (1920,960) (0,0)

{-| frames por segundo

@
fr::Int
fr= 50
@

-}

fr::Int
fr= 50

{- | esta funcao é responsavel por juntar todas as imagens numa só

@
desenhaMapa::PNG->Jogo->[Picture]
desenhaMapa p (Jogo (h:t) (Jogador (x,y) d b))= addfundo p (Jogo (h:t) (Jogador (x,y) d b)) (vetor (h:t)) (dis ((h:t))) (fromIntegral (altura (h:t) 0))
@

-}

desenhaMapa::PNG->Jogo->[Picture]
desenhaMapa p (Jogo (h:t) (Jogador (x,y) d b))= addfundo p (Jogo (h:t) (Jogador (x,y) d b)) (vetor (h:t)) (dis ((h:t))) (fromIntegral (altura (h:t) 0))


{-|adiciona a imagem de fundo

@
addfundo::PNG->Jogo->Float->Float->Float->[Picture]
addfundo p j v d a= back p:addplayer p j v d a
@

-}

addfundo::PNG->Jogo->Float->Float->Float->[Picture]
addfundo p j v d a= back p:addplayer p j v d a



{-| desenha o jogador

@
addplayer::PNG->Jogo->Float->Float->Float->[Picture] 
addplayer p (Jogo (h:t) (Jogador (x,y) Oeste False)) v d a=Translate (((-960)+d/2)+d*(fromIntegral x)) (((a/2)*d)-(fromIntegral y)*d) (Scale v v (pl p)):desenha p (h:t) (((fromIntegral (-960))+d/2)) ((a*d)/2) v d 
addplayer p (Jogo (h:t) (Jogador (x,y) Oeste True)) v d a=Translate (((-960)+d/2)+d*(fromIntegral x)) (((a/2)*d)-(fromIntegral y)*d+(d/2)) (Scale v v (plb p)):desenha p (h:t) (((fromIntegral (-960))+d/2)) ((a*d)/2) v d 
addplayer p (Jogo (h:t) (Jogador (x,y) Este False)) v d a=Translate (((-960)+d/2)+d*(fromIntegral x)) (((a/2)*d)-(fromIntegral y)*d) (Scale v v (pr p)):desenha p (h:t) (((fromIntegral (-960))+d/2)) ((a*d)/2) v d 
addplayer p (Jogo (h:t) (Jogador (x,y) Este True)) v d a=Translate (((-960)+d/2)+d*(fromIntegral x)) (((a/2)*d)-(fromIntegral y)*d+(d/2)) (Scale v v (prb p)):desenha p (h:t) (((fromIntegral (-960))+d/2)) ((a*d)/2) v d 
@

-}




addplayer::PNG->Jogo->Float->Float->Float->[Picture] 
addplayer p (Jogo (h:t) (Jogador (x,y) Oeste False)) v d a=Translate (((-960)+d/2)+d*(fromIntegral x)) (((a/2)*d)-(fromIntegral y)*d) (Scale v v (pl p)):desenha p (h:t) (((fromIntegral (-960))+d/2)) ((a*d)/2) v d 
addplayer p (Jogo (h:t) (Jogador (x,y) Oeste True)) v d a=Translate (((-960)+d/2)+d*(fromIntegral x)) (((a/2)*d)-(fromIntegral y)*d+(d/2)) (Scale v v (plb p)):desenha p (h:t) (((fromIntegral (-960))+d/2)) ((a*d)/2) v d 
addplayer p (Jogo (h:t) (Jogador (x,y) Este False)) v d a=Translate (((-960)+d/2)+d*(fromIntegral x)) (((a/2)*d)-(fromIntegral y)*d) (Scale v v (pr p)):desenha p (h:t) (((fromIntegral (-960))+d/2)) ((a*d)/2) v d 
addplayer p (Jogo (h:t) (Jogador (x,y) Este True)) v d a=Translate (((-960)+d/2)+d*(fromIntegral x)) (((a/2)*d)-(fromIntegral y)*d+(d/2)) (Scale v v (prb p)):desenha p (h:t) (((fromIntegral (-960))+d/2)) ((a*d)/2) v d 



{-| desenha o mapa


@
desenha::PNG->Mapa->Float->Float->Float->Float->[Picture]
desenha p ([]:xs) z y v d  = desenha p xs (-960+d/2) (y-d) v d 
desenha _ [] _ _ _ _=[]
desenha p ((x:xs):ys) z y v d 
  |x==Caixa=Translate z y (Scale v v (box p))  :desenha p (xs:ys) (z+d) y v d 
  |x==Bloco=Translate z y (Scale v v (block p)):desenha p (xs:ys) (z+d) y v d 
  |x==Porta=Translate z (y+(d/2)) (Scale v v (door p)) :desenha p (xs:ys) (z+d) y v d 
  |otherwise=desenha p (xs:ys) (z+d) y v d 
@

-}



desenha::PNG->Mapa->Float->Float->Float->Float->[Picture]
desenha p ([]:xs) z y v d  = desenha p xs (-960+d/2) (y-d) v d 
desenha _ [] _ _ _ _=[]
desenha p ((x:xs):ys) z y v d 
  |x==Caixa=Translate z y (Scale v v (box p))  :desenha p (xs:ys) (z+d) y v d 
  |x==Bloco=Translate z y (Scale v v (block p)):desenha p (xs:ys) (z+d) y v d 
  |x==Porta=Translate z (y+(d/2)) (Scale v v (door p)) :desenha p (xs:ys) (z+d) y v d 
  |otherwise=desenha p (xs:ys) (z+d) y v d 






{-| calcula o comprimento do mapa

@
comprimento::Mapa->Int->Int
comprimento ([]:ys) a =a
comprimento ((x:xs):ys) a = comprimento (xs:ys) a+1
@

-}


comprimento::Mapa->Int->Int
comprimento ([]:ys) a =a
comprimento ((x:xs):ys) a = comprimento (xs:ys) a+1


{- | calcula a altura do mapa

@
altura::Mapa->Int->Int
altura [] a = a
altura (h:t) a = altura t a+1
@

-}



altura::Mapa->Int->Int
altura [] a = a
altura (h:t) a = altura t a+1




{- | calcula o tamanho do vetor pelo qual todas as imagens sao escaladas de maneira a caber no ecra com largura 1920

@
vetor::Mapa->Float
vetor m = 1920/fromIntegral (comprimento m 0)/130
@

-}

vetor::Mapa->Float
vetor m = 1920/fromIntegral (comprimento m 0)/130



{- | calcula a largura de cada imagem

@
dis::Mapa->Float
dis m = vetor m*130
@

-}

dis::Mapa->Float
dis m = vetor m*130



main :: IO ()
main = do
  load<-loadPNG
  play
    dm -- janela onde irá correr o jogo
    (makeColorI 161 173 255 72) -- côr do fundo da janela
    fr -- frame rate
    (Estado load (MenuPrincipal Jogar) (Jogo m1 (Jogador (2,3) Este False))(Jogo m1 (Jogador (2,3) Este False))) -- estado inicial
    desenhaEstado -- desenha o estado do jogo
    reageEventoGloss -- reage a um evento
    reageTempoGloss -- reage ao passar do tempo


