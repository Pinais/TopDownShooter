<h1 align="center"> TopDownShooter </h1>

## Versão
  | Data | Versão | Pontos | Descrição | Autores |
|:----:|:------:|:---------:|:---------:|:---------:|
| 16/01/2023 | 0.1 | Criação do Documento | Foi abordado como o jogo seria trabalhado, decidimos assistir a Video aula do [Clécio Espindola GameDev](https://www.youtube.com/@clecioespindolagamedev) de TopDownShooter e praticar o que aprendemos com um jogo nosso porém com o mesmo tema. |[Lucas Petruci](https://github.com/LucasPetruci) e [João Capello](https://github.com/Pinais) |
| 23/01/2023 | 0.2 | Adição do Documento | Realização de uma reunião para abordar os temas que estariam no jogo e realizamos o Diagrama de Classe |[Lucas Petruci](https://github.com/LucasPetruci) e [João Capello](https://github.com/Pinais) |
| 24/01/2023 | 0.3 | Primeiro dia de desenvolvimento | No dia 1 foi realizado o desenvolvimento da movimentação e da função atirar que é a responsável por usar o projétil |[Lucas Petruci](https://github.com/LucasPetruci) e [João Capello](https://github.com/Pinais) |
| 25/01/2023 | 0.4 | Segundo dia de desenvolvimento | No dia 2 adicionamos inimigos e iniciamos um sistema de pegar itens do chão, além de corrigir vários bugs que apareceram durante o processo.. |[Lucas Petruci](https://github.com/LucasPetruci) e [João Capello](https://github.com/Pinais) |
| 26/01/2023 | 0.5 | Terceiro dia de desenvolvimento | No dia 3 finalizamos as funcionalidades necessárias para o sistema de inimigos, permitindo que o jogador perca e que reinicie o jogo, adicionamos um sistema de pontuação a partir da eliminação de inimigos e adicionamos alguns elementos de interface indicadores de quantidade de vida e munição. |[Lucas Petruci](https://github.com/LucasPetruci) e [João Capello](https://github.com/Pinais) |
| 27/01/2023 | 0.6 | Quarto dia de desenvolvimento | No dia 4 adicionados atributos que diversificam a jogabilidade e possibilitam criação de diferentes inimigos, armas e evoluções. Alteramos algumas texturas para substituir os placeholders que estavam em uso. | [Lucas Petruci](https://github.com/LucasPetruci) e [João Capello](https://github.com/Pinais) |




## Inspirações e bases:

Este é um projeto de jogo 2D feito na engine Godot baseado na série de tutoriais “Godot Wave Shooter Tutorial” pelo canal [Clécio Espindola GameDev](https://www.youtube.com/@clecioespindolagamedev).
Inspirados pelo recente sucesso de jogos como “Vampire Survivors” e “20 Minutes Till Dawn”, decidimos levar o projeto adiante implementando mais recursos até torná-lo um jogo interessante.

## Tecnologias Utilizadas
- Godot Game Engine

## Status do Projeto
:construction: Projeto em construção :construction:

## Diagrama de Classe
![GameTopDownShooter](https://user-images.githubusercontent.com/99514230/215515545-f2efb926-da7f-4a2c-a52f-525a03878fc8.png)


## Funcionalidades do projeto :hammer:
- `Funcionalidade 1` `Movimentação do jogador`: O jogador poderá se movimentar em todas as direções.
- `Funcionalidade 2` `Criação do tiro e Particulas`: O jogador poderá usar o mouse esquerdo para atirar um projétil. Particulas de sangue são deixadas por inimigos quando mortos.
- `Funcionalidade 3` `Inimigos`: Por meio de Herança o jogo possui varios inimigos com IA, onde cada um possui uma vida, velocidade e recuo diferente
- `Funcionalidade 4` `Pontuação e Dificuldade`: O jogo possui um contador de pontuação que é incrementado todo vez que mata um inimigo, e um sistema de dificuldade, onde o status é alterado dependendo da dificuldade.
- `Funcionalidade 5` `Sistema de armas`: O jogo terá armas diferentes que são deixadas por inimigos mortos, e cada uma possui um tempo de recarga e dano diferente.
- `Funcionalidade 6` `Sistema de Power-ups`: A cada certo tempo irá aparecer um power-up, que pode ser pego pelo jogador e irá mudar os atributos, como velocidade do tiro e o dano por bala.


## Video do jogo 

