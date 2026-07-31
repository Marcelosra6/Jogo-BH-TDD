Feature: Pausa de juego
  Como jugador
  Quiero pausar y reanudar el juego en cualquier momento
  Para poder interrumpir la partida cuando lo necesite

  Scenario: Pausar el juego con la tecla H
    Given el jugador esta en una partida activa
    When presiona la tecla "H"
    Then el arbol del juego debe estar pausado
    And la pantalla de pausa debe mostrarse con un overlay semitransparente

  Scenario: Reanudar el juego despues de pausar
    Given el juego esta pausado
    When el jugador presiona la tecla "H" nuevamente
    Then el arbol del juego debe reanudarse
    And la pantalla de pausa debe ocultarse

  Scenario: La pausa no debe activarse si el juego termino
    Given la partida ha terminado (jugador o enemigo sin vida)
    When el jugador presiona la tecla "H"
    Then el juego no debe pausarse

  Scenario: La pantalla de pausa es funcional
    Given la escena "pausa.tscn"
    When se instancia y se ejecuta "_ready"
    Then debe tener process_mode = PROCESS_MODE_ALWAYS
    And debe estar oculta inicialmente
    And debe tener un ColorRect y un Label con texto "PAUSA"
