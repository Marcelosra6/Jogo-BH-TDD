Feature: Cierre de juego
  Como jugador
  Quiero poder salir de la aplicacion de forma segura desde el menu
  Para cerrar el programa cuando lo desee

  Scenario: El boton SALIR existe en el menu principal
    Given el jugador esta en la pantalla de menu principal
    Then debe existir un boton "SALIR"
    And el boton debe tener un script adjunto

  Scenario: Salir del juego desde el menu principal
    Given el jugador esta en la pantalla de menu principal
    When presiona el boton "SALIR"
    Then la aplicacion debe cerrarse

  Scenario: El boton SALIR llama a quit()
    Given el script "btnSalir.gd"
    When se revisa su metodo "_on_pressed"
    Then debe llamar a "get_tree().quit()"

  Scenario: Ambos botones tienen formato consistente
    Given la escena "inicio.tscn"
    When se instancia
    Then el boton "JUGAR" debe tener texto "JUGAR"
    And el boton "SALIR" debe tener texto "SALIR"
    And ambos deben estar contenidos en un VBoxContainer
