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

SubAlgoritmo buscarValorEnTablero(tablero, fila, colum, dato)
	Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1
			Si tablero[i,j] = dato Entonces
				fila = i;
				colum = j;
				i = 3
			FinSi
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

SubAlgoritmo ubicarJugadorEnTablero(tablero, fila, colum)
	InicializarTablero(tablero)
	tablero[fila, colum] = "J"
FinSubAlgoritmo

SubAlgoritmo MoverDetective(cantTurnos, tablero)
	Definir opcionCafe, fila, colum, opcionMovimiento Como Entero

	Si cantTurnos == 3 Entonces
		Escribir "Elija un cafe para empezar:"
		Escribir "1. Cafe en la posicion 7 del tablero"
		Escribir "2. Cafe en la posicion 14 del tablero"
		Leer opcionCafe
		Si opcionCafe = 1
			fila = 1
			colum = 1
			ubicarJugadorEnTablero(tablero, fila, colum)
		SiNo
			fila = 2
			colum = 3
			ubicarJugadorEnTablero(tablero, 2, 3)
		FinSi
		MostrarTablero(tablero)
	FinSi
	
	Si cantTurnos == 3 Entonces
		Repetir
			Escribir "1. Arriba"
			Escribir "2. Abajo"
			Escribir "3. Derecha"
			Escribir "4. Izquierda"
			Escribir "5. Volver"
			
			Leer opcionMovimiento
			
			Segun opcionMovimiento Hacer
				1: filaAnt = fila
					fila = fila - 1
					ubicarJugadorEnTablero(tablero, fila, colum)
					MostrarTablero(tablero)
					cantTurnos = cantTurnos - 1
				2: fila = fila + 1
					ubicarJugadorEnTablero(tablero, fila, colum)
					MostrarTablero(tablero)
					cantTurnos = cantTurnos - 1
				3: colum = colum + 1
					ubicarJugadorEnTablero(tablero, fila, colum)
					MostrarTablero(tablero)
					cantTurnos = cantTurnos - 1
				4: colum = colum - 1
					ubicarJugadorEnTablero(tablero, fila, colum)
					MostrarTablero(tablero)
					cantTurnos = cantTurnos - 1
			FinSegun
			
		Hasta Que cantTurnos == 0
	FinSi
	
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
    
    Definir opcionPrincipal, opcionMenuJugar, cantTurnos Como Entero
	cantTurnos = 3
    
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
                    Leer opcionMenuJugar
                    Segun opcionMenuJugar
                        1: Escribir "Opción Mover seleccionada."
							Escribir "Turnos restantes: ", cantTurnos
							MoverDetective(cantTurnos, tablero) 
                        2: // Lógica para Arrestar
                            Escribir "Opción Arrestar seleccionada."
                        3: // Terminar juego
                            Escribir "Terminando partida..."
							
                        De Otro Modo:
                            Escribir "Opción inválida, intente de nuevo."
                    FinSegun
                Hasta Que opcionMenuJugar == 3
            2:
                Escribir "Reglas del juego:"
				Escribir "tiki taka"
            3:
                Escribir "Saliendo del juego..."
            De Otro Modo:
                Escribir "Opción inválida, intente de nuevo."
        FinSegun
    Hasta Que opcionPrincipal = 3
    
FinAlgoritmo