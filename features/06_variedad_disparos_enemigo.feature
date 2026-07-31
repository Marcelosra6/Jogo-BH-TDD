Feature: Variedad de disparos de enemigo
  Como jugador
  Quiero que el enemigo alterne entre tres patrones de proyectiles
  Para que el combate sea impredecible y variado

  Scenario: Disparo 1 - Rafaga hacia abajo en abanico
    Given el enemigo ejecuta "disparo1()"
    Then se debe activar el estado de disparo secuencial
    And "ctdBalas" debe ser un valor aleatorio entre 20 y 30
    And cada bala debe dispararse hacia abajo con un angulo de abanico

  Scenario: Disparo 1 - Las balas se crean secuencialmente
    Given el estado de disparo1 esta activo
    When se ejecuta "disparar_siguiente_bala()"
    Then se debe crear una bala en la posicion del enemigo
    And la bala debe tener una direccion distinta de cero
    And el temporizador entre balas debe reiniciarse a 0.16s

  Scenario: Disparo 2 - Rafaga circular de 60 balas
    Given el enemigo ejecuta "disparo2()"
    Then se deben crear 60 balas en el padre
    And cada bala debe tener una direccion unica rotada cada 30 grados
    And el disparo debe ser instantaneo (no estado secuencial)

  Scenario: Disparo 3 - Bolas de energia secuenciales
    Given el enemigo ejecuta "disparo3()"
    Then "disparos_bola_restantes" debe disminuir en 1
    And se debe iniciar la secuencia de 3 bolas grandes
    And cada bola debe crearse con un intervalo de 0.5 segundos
    And las bolas deben moverse en direccion hacia abajo

  Scenario: Disparo 3 - No se dispara si no quedan bolas
    Given "disparos_bola_restantes" es 0
    When el enemigo ejecuta "disparo3()"
    Then no debe crearse ninguna bola

  Scenario: Los patrones se alternan ciclicamente
    Given el enemigo esta en "_process"
    When el temporizador de disparo llega a cero
    Then "disparo1()" debe ejecutarse siempre
    And "disparo2()" debe ejecutarse con 67% de probabilidad
    And "disparo3()" debe ejecutarse con 40% de probabilidad
