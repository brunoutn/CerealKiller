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
	
	// Constantes, dimensiones del tablero
	Definir FILAS, COLUMNAS Como Entero
	FILAS = 4
	COLUMNAS = 5
	
	// Tablero de juego
	Definir tablero Como Caracter
	Dimension tablero[FILAS, COLUMNAS]
	
	// Tablero para guardar la posición del asesino
	Definir tablero_asesino Como Caracter
	Dimension tablero_asesino[FILAS, COLUMNAS]
	
	InicializarTablero(tablero)
	MostrarTablero(tablero)
	
	// Pausa para ver el resultado
	Escribir "Presiona Enter para continuar..."
	Leer linea
FinAlgoritmo

// Función para inicializar el tablero con las casillas correspondientes
SubAlgoritmo InicializarTablero(tablero)
	Definir operador Como Entero
	Para i = 0 Hasta 4-1 Con Paso 1
		Para j = 0 Hasta 5-1 Con Paso 1
			operador = FCtoPOS(i, j)
			Segun (operador)
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

// Función para dar un numero de casilla segun fila y columna
Funcion posicion <- FCtoPOS ( fila, columna )
	posicion = fila * 5 + columna + 1
Fin Funcion

// Funcion para dar fila y columna segun numero de casilla 
SubAlgoritmo POStoFC(posicion, fila Por Referencia, columna Por Referencia)
	fila = (TRUNC((posicion - 1) / 5))+1
	columna = ((posicion - 1) % 5)+1
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

// Función para el movimiento del asesino
SubAlgoritmo MovimientoAsesino(tablero, tablero_asesino)
	
FinSubAlgoritmo

// Función para darle posición inicial al asesino
Funcion inicio_asesino <- PosicionInicialAsesino(null)
	Definir fila, columna Como Entero
	inicio_asesino = azar(8)+1 //ARREGLAR ALEATORIO
	Segun (inicio_asesino)
		1: 	fila = 0
			columna = 0
			
		2: 	fila = 0
			columna = 4
			
		3: 	fila = 1
			columna = 2
			
		4:  fila = 1
			columna = 4
			
		5:  fila = 2
			columna = 0
			
		6: 	fila = 2
			columna = 4
			
		7:	fila = 3
			columna = 1
			
		8: 	fila = 3
			columna = 2
	FinSegun
	inicio_asesino = FCtoPOS(fila, columna)
FinFuncion

