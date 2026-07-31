Feature: Interaccion con enemigo
  Como jugador
  Quiero que el jefe del nivel (demonio) tenga inteligencia artificial basica
  Para que el combate sea desafiante

  Scenario: La escena del enemigo se carga correctamente
    Given la escena "enemigo.tscn"
    When se instancia
    Then debe tener Node2D como nodo raiz

  Scenario: El enemigo se mueve autonomamente
    Given el enemigo esta en la escena de juego
    When se ejecuta "_process" con delta
    Then su posicion debe cambiar siguiendo un patron sinusoidal
    And el movimiento debe ser continuo en cada frame

  Scenario: El enemigo dispara automaticamente
    Given el enemigo esta activo en la escena
    When el temporizador de disparo llega a cero
    Then debe ejecutar un patron de disparo

  Scenario: La vida del enemigo se inicializa correctamente
    Given la partida comienza
    Then el enemigo debe tener vida maxima (10000)
    And la variable "juego_terminado" debe ser false
