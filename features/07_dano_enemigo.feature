Feature: Hacer dano al enemigo
  Como jugador
  Quiero que mis balas reduzcan los puntos de vida del enemigo al impactar
  Para poder derrotarlo

  Scenario: Bala del jugador impacta al enemigo
    Given una bala del jugador colisiona con el area del enemigo
    When se ejecuta "_on_area_2d_area_entered"
    Then la vida del enemigo debe reducirse en 100
    And la bala debe eliminarse (queue_free)

  Scenario: La bala del jugador se mueve hacia arriba
    Given una bala es instanciada
    When se ejecuta "_process" con delta
    Then su posicion Y debe disminuir (moverse hacia arriba)
    And debe hacerlo en cada frame

  Scenario: La bala se elimina al salir de la pantalla
    Given una bala del jugador en posicion Y menor a -50
    When se ejecuta "_process"
    Then la bala debe marcarse para eliminacion (queue_free)

  Scenario: La bala permanece si esta dentro de los limites
    Given una bala del jugador en posicion Y mayor o igual a -50
    When se ejecuta "_process"
    Then la bala no debe eliminarse

  Scenario: La vida del enemigo se actualiza correctamente
    Given el enemigo tiene vida inicial
    When recibe dano varias veces
    Then la vida debe acumular las sustracciones
    And cuando la vida llega a 0 o menos, el juego debe terminar

  Scenario: El dano no se aplica si el juego termino
    Given el juego ya termino
    When una bala del jugador impacta al enemigo
    Then la vida del enemigo no debe cambiar
