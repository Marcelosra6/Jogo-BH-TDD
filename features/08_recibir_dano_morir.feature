Feature: Recibir dano y morir
  Como jugador
  Quiero perder vida al colisionar con proyectiles enemigos
  Para que el juego termine si mi salud llega a cero

  Scenario: Proyectil enemigo impacta al jugador
    Given un proyectil enemigo colisiona con el area del jugador
    When se ejecuta "_on_area_2d_area_entered"
    Then la vida del jugador debe reducirse en 1
    And el proyectil debe eliminarse (queue_free)

  Scenario: El jugador muere al quedarse sin vida
    Given el jugador tiene 1 punto de vida
    When recibe dano de un proyectil enemigo
    Then su vida debe llegar a 0
    And "juego_terminado" debe establecerse a true
    And el arbol del juego debe pausarse

  Scenario: Bola enemiga impacta al jugador
    Given una bola enemiga colisiona con el area del jugador
    When se ejecuta "_on_area_2d_area_entered"
    Then la vida del jugador debe reducirse en 1
    And la bola debe eliminarse

  Scenario: Game Over - Pantalla de fin
    Given el juego termina (jugador sin vida o enemigo sin vida)
    Then debe congelarse la pantalla
    And debe reproducirse el sonido correspondiente (win o lose)
    And tras 2 segundos debe cargarse la escena "inicio.tscn"

  Scenario: El dano no se aplica si el juego termino
    Given el juego ya termino
    When un proyectil enemigo colisiona con el jugador
    Then la vida del jugador no debe cambiar

  Scenario: La bala enemigo se elimina al salir de la pantalla
    Given una bala enemiga fuera de los limites de la pantalla
    When se ejecuta "_process"
    Then la bala debe marcarse para eliminacion
    And esto aplica para arriba, abajo, izquierda y derecha

  Scenario: La bala enemigo permanece si esta dentro de los limites
    Given una bala enemiga en el centro de la pantalla
    When se ejecuta "_process"
    Then la bala no debe eliminarse

  Scenario: Proyectiles enemigos se mueven en la direccion asignada
    Given un proyectil enemigo con direccion DOWN
    When se ejecuta "_process"
    Then debe moverse hacia abajo
    And lo mismo aplica para cualquier direccion asignada
