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

// Función para mostrar el tablero en pantalla
SubAlgoritmo MostrarTablero(tablero)
	Para i = 0 Hasta 4-1 Con Paso 1
		Para j = 0 Hasta 5-1 Con Paso 1
			Escribir Sin Saltar tablero[i, j]  " |"
		FinPara
		Escribir ""
	FinPara
FinSubAlgoritmo


Algoritmo CerealKiller
	
	// Constantes para los tipos de casillas
	Definir CASILLA_VACIA, CASILLA_CASA, CASILLA_PARQUE, CASILLA_CAFE, CASILLA_CEREAL, CASILLA_TESTIGO, CASILLA_DETECTIVE Como Caracter
	CASILLA_VACIA = " "
	CASILLA_CASA = "C"
	CASILLA_PARQUE = "P"
	CASILLA_CAFE = "K"
	CASILLA_CEREAL = "O"
	CASILLA_TESTIGO = "T"
	CASILLA_DETECTIVE = "D"
	
	// Dimensiones del tablero
	Definir FILAS, COLUMNAS Como Entero
	FILAS = 4
	COLUMNAS = 5
	
	// Tablero de juego
	Definir tablero Como Caracter
	Dimension tablero[FILAS, COLUMNAS]
	
	
	InicializarTablero(tablero)
	MostrarTablero(tablero)
	

// Pausa para ver el resultado
Escribir "Presiona Enter para continuar..."
Leer linea
FinAlgoritmo
