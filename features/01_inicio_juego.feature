Feature: Inicio de juego
  Como jugador
  Quiero iniciar una nueva partida desde el menu principal
  Para poder jugar al juego

  Scenario: El menu principal se carga correctamente
    Given el jugador abre la aplicacion
    Then debe ver la pantalla de menu principal
    And debe existir un boton "JUGAR"

  Scenario: Iniciar una nueva partida
    Given el jugador esta en la pantalla de menu principal
    When presiona el boton "JUGAR"
    Then la escena de juego debe cargarse
    And la partida debe comenzar con el jugador vivo y el enemigo con vida maxima

  Scenario: El boton JUGAR tiene la accion correcta
    Given la escena "inicio.tscn"
    When se instancia
    Then el boton "Button" debe tener un script adjunto
    And el script debe implementar "_on_pressed" que cambie a "juego.tscn"
