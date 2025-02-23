Algoritmo Detective
    Definir FILAS, COLUMNAS Como Entero
    FILAS = 4
    COLUMNAS = 5
    
    Definir tablero Como Caracter
    Dimension tablero[FILAS, COLUMNAS]
    
    Definir cantTurnos, juegoEmpezado Como Entero
	cantTurnos = 3
    
	
    Repetir
        MostrarMenu()
        Escribir "Seleccione una opción: "
		Leer opPrinc

        Segun opPrinc
            1:
                InicializarTablero(tablero)
                MostrarTablero(tablero)
                Repetir
                    MostrarMenuJugar()
                    Escribir "Seleccione una opción: "
                    Leer opJugar
				
                    Segun opJugar
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
					
                Hasta Que opJugar == 3
            2:
                Escribir "Reglas del juego:"
				Escribir "tiki taka"
            3:
                Escribir "Saliendo del juego..."
            De Otro Modo:
                Escribir "Opción inválida, intente de nuevo."
        FinSegun
    Hasta Que opPrinc = 3
	
FinAlgoritmo


SubAlgoritmo EmpezarJuego()
	
FinSubAlgoritmo

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

//Funcion para ubicar al detective en el tablero, previamente habiendolo iniciado para conservar las posiciones
SubAlgoritmo ubicarJugadorEnTablero(tablero, fila, colum)
	InicializarTablero(tablero)
	tablero[fila, colum] = "D"
FinSubAlgoritmo


SubAlgoritmo MoverDetective(cantTurnos, tablero)
	Definir fila, colum Como Entero
	Definir opcionMovimiento Como Caracter
	
	Si cantTurnos == 3 Entonces
		Repetir
			Escribir "Elija un cafe para empezar:"
			Escribir "Q. Cafe en la posicion 7 del tablero"
			Escribir "E. Cafe en la posicion 14 del tablero"
			Leer opcionMovimiento
			
			Si opcionMovimiento = "q" o opcionMovimiento = "Q"
				fila = 1
				colum = 1
				ubicarJugadorEnTablero(tablero, fila, colum)
			SiNo
				Si opcionMovimiento = 'e' o opcionMovimiento = 'E' //Valido con el si para que no se ejecute el ubicado del jugador en tablero de forma innecesaria
					fila = 2
					colum = 3
					ubicarJugadorEnTablero(tablero, fila, colum)
				FinSi
			FinSi
			
		Hasta Que opcionMovimiento = 'Q' o opcionMovimiento = 'q' o opcionMovimiento = 'E' o opcionMovimiento = 'e'
		
		MostrarTablero(tablero)
	FinSi
	
	Si cantTurnos <= 3 Entonces
		Repetir
			Escribir "W. Arriba"
			Escribir "S. Abajo"
			Escribir "D. Derecha"
			Escribir "A. Izquierda"
			Escribir "X. Finalizar turno" //A evaluar si esta bien incluirla
			
			Leer opcionMovimiento
			
			Segun opcionMovimiento Hacer
				'w' o 'W': fila = fila - 1
					ubicarJugadorEnTablero(tablero, fila, colum)
					MostrarTablero(tablero)
					cantTurnos = cantTurnos - 1
				's' o 'S': fila = fila + 1
					ubicarJugadorEnTablero(tablero, fila, colum)
					MostrarTablero(tablero)
					cantTurnos = cantTurnos - 1
				'd' o 'D': colum = colum + 1
					ubicarJugadorEnTablero(tablero, fila, colum)
					MostrarTablero(tablero)
					cantTurnos = cantTurnos - 1
				'a' o 'A': colum = colum - 1
					ubicarJugadorEnTablero(tablero, fila, colum)
					MostrarTablero(tablero)
					cantTurnos = cantTurnos - 1
				'x' o 'X':
					cantTurnos = 0
				De Otro Modo:
					Escribir "Input incorrecto, vuelva a intentar"
			FinSegun
			
		Hasta Que cantTurnos == 0
	FinSi
	
FinSubAlgoritmo