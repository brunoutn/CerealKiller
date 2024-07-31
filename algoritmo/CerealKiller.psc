// Función para inicializar el tablero con las casillas correspondientes
SubAlgoritmo InicializarTablero(tablero)
    Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1
            Segun (i * 5 + j + 1)
                1: tablero[i, j] = "C"
                2: tablero[i, j] = "P"
                4: tablero[i, j] = "P"
                5: tablero[i, j] = "C"
                7: tablero[i, j] = "K"
                8: tablero[i, j] = "C"
                10: tablero[i, j] = "C"
                11: tablero[i, j] = "C"
                13: tablero[i, j] = "P"
                14: tablero[i, j] = "K"
                15: tablero[i, j] = "C"
                17: tablero[i, j] = "C"
                18: tablero[i, j] = "C"
                De Otro Modo: tablero[i, j] = " "
            FinSegun
        FinPara
    FinPara
FinSubAlgoritmo

SubAlgoritmo MostrarTablero(tablero)
    Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1
            Escribir Sin Saltar tablero[i, j] " |"
        FinPara
        Escribir ""
    FinPara
FinSubAlgoritmo

SubAlgoritmo MostrarMenu
    Escribir "1. Jugar"
    Escribir "2. Reglas"
    Escribir "3. Salir"
FinSubAlgoritmo

SubAlgoritmo MostrarMenuJugar
    Escribir "1. Mover"
    Escribir "2. Arrestar"
    Escribir "3. Terminar"
FinSubAlgoritmo

Algoritmo CerealKiller
    Definir CASILLA_VACIA, CASILLA_CASA, CASILLA_PARQUE, CASILLA_CAFE, CASILLA_CEREAL, CASILLA_TESTIGO, CASILLA_DETECTIVE Como Caracter
    CASILLA_VACIA = " "
    CASILLA_CASA = "C"
    CASILLA_PARQUE = "P"
    CASILLA_CAFE = "K"
    CASILLA_CEREAL = "O"
    CASILLA_TESTIGO = "T"
    CASILLA_DETECTIVE = "D"
    
    Definir FILAS, COLUMNAS Como Entero
    FILAS = 4
    COLUMNAS = 5
    
    Definir tablero Como Caracter
    Dimension tablero[FILAS, COLUMNAS]
    
    Definir opcionPrincipal, opcionJugar Como Entero
    
    Repetir
        MostrarMenu()
        Escribir "Seleccione una opción: "
        Leer opcionPrincipal
        
        Segun opcionPrincipal
            1:
                InicializarTablero(tablero)
                MostrarTablero(tablero)
                Repetir
                    MostrarMenuJugar()
                    Escribir "Seleccione una opción: "
                    Leer opcionJugar
                    Segun opcionJugar
                        1: // Lógica para Mover
                            Escribir "Opción Mover seleccionada."
                        2: // Lógica para Arrestar
                            Escribir "Opción Arrestar seleccionada."
                        3: // Terminar juego
                            Escribir "Terminando juego..."
                        De Otro Modo:
                            Escribir "Opción inválida, intente de nuevo."
                    FinSegun
                Hasta Que opcionJugar = 3
            2:
                Escribir "Reglas del juego:"
				Escribir "tiki taka"
            3:
                Escribir "Saliendo del programa..."
            De Otro Modo:
                Escribir "Opción inválida, intente de nuevo."
        FinSegun
    Hasta Que opcionPrincipal = 3
    
FinAlgoritmo