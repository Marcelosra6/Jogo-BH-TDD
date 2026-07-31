Feature: Interaccion con personaje
  Como jugador
  Quiero controlar el movimiento de la nave y disparar proyectiles
  Para enfrentarme al enemigo

  Scenario: La escena del jugador se carga correctamente
    Given la escena "jogador.tscn"
    When se instancia
    Then debe tener Node2D como nodo raiz

  Scenario: El jugador se mueve con el mouse
    Given el jugador esta en la escena de juego
    When el mouse se mueve a una posicion
    Then la nave debe seguir la posicion del mouse

  Scenario: El jugador se mueve con el teclado (WASD)
    Given el jugador esta en la escena de juego
    When se presiona la tecla "left" o "A"
    Then la nave debe moverse hacia la izquierda
    When se presiona la tecla "right" o "D"
    Then la nave debe moverse hacia la derecha
    When se presiona la tecla "up" o "W"
    Then la nave debe moverse hacia arriba
    When se presiona la tecla "down" o "S"
    Then la nave debe moverse hacia abajo

  Scenario: El jugador dispara proyectiles
    Given el jugador esta en la escena de juego
    When presiona la tecla "ESPACIO" o hace clic
    Then se debe crear una bala en la posicion del jugador
    And la bala debe moverse hacia arriba

  Scenario: La cadencia de disparo se respeta
    Given el jugador acaba de disparar
    When intenta disparar inmediatamente
    Then no debe crearse una nueva bala hasta que el temporizador de cadencia llegue a cero

  Scenario: Las acciones de entrada estan configuradas
    Given el proyecto esta configurado
    Then deben existir las acciones "left", "right", "up", "down", "fire", "click" en InputMap
    And "left" debe estar bindeada a "A" y flecha izquierda
    And "right" debe estar bindeada a "D" y flecha derecha
    And "up" debe estar bindeada a "W" y flecha arriba
    And "down" debe estar bindeada a "S" y flecha abajo
    And "fire" debe estar bindeada a "ESPACIO"
