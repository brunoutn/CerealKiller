Algoritmo sin_titulo
	// Constantes, dimensiones del tablero
	Definir FILAS, COLUMNAS Como Entero
	FILAS = 4
	COLUMNAS = 5
	
	// Tablero de juego
	Definir tablero Como Caracter
	Dimension tablero[FILAS, COLUMNAS]
	
	Definir tablero_asesino Como Caracter
	Dimension tablero_asesino[FILAS, COLUMNAS]
	
	Dimension posAsesino[2]
	Dimension posDetective[2]
	intentosRestantes = 3
	
	InicializarTablero(tablero)
	MostrarTablero(tablero)
	///LE DAMOS POSICION AL ASESINO
	PosicionAsesino(posAsesino)
	
	///MENSAJE PARA DEBUG, BORRAR DESPUES
	Escribir "el asesino esta en la posicion: ", FCtoPOS(posAsesino[0], posAsesino[1])
	
	Arrestar(posAsesino, posDetective, intentosRestantes)
	
FinAlgoritmo

// Función para dar un numero de casilla segun fila y columna
Funcion posicion <- FCtoPOS ( fila, columna )
	posicion = fila * 5 + columna + 1
Fin Funcion

// Funcion para dar fila y columna segun numero de casilla 
SubAlgoritmo POStoFC(posicion, fila Por Referencia, columna Por Referencia)
	fila = (TRUNC((posicion - 1) / 5))+1
	columna = ((posicion - 1) % 5)+1
FinSubAlgoritmo


///POSICION ASESINO EDITADA PARA ASIGNAR VALORES DIRECTO AL PARAMETRO
SubAlgoritmo PosicionAsesino(posAsesino Por Referencia)
	Definir fila, columna, inicio_asesino Como Entero
	inicio_asesino = azar(8)
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
	posAsesino[0] <- fila
	posAsesino[1] <- columna
	
FinSubAlgoritmo

Funcion inicio_asesino <- PosicionInicialAsesino(null)
	Definir fila, columna Como Entero
	inicio_asesino = azar(8) //ARREGLAR ALEATORIO
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
	inicio_asesino <- FCtoPOS(fila, columna)
	Escribir "el asesino esta en la posicion: ", FCtoPOS(fila, columna)
FinFuncion


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

// Función para mostrar el tablero en pantalla
SubAlgoritmo MostrarTablero(tablero)
	Para i = 0 Hasta 4-1 Con Paso 1
		Para j = 0 Hasta 5-1 Con Paso 1
			Escribir Sin Saltar tablero[i, j]  " |"
		FinPara
		Escribir ""
	FinPara
FinSubAlgoritmo

///FUNCION IMPORTANTE
SubAlgoritmo Arrestar(posAsesino, posDetective, intentosRestantes Por Referencia)
    Definir op Como Caracter
    Repetir
        Escribir "Seleccione una casilla para intentar arrestar (o X para salir):"
        Escribir "W. Arriba"
        Escribir "S. Abajo"
        Escribir "A. Izquierda"
        Escribir "D. Derecha"
        Escribir "Q. Misma Casilla"
        Escribir "X. Salir"
        Leer op
	
		// Intento de arresto basado en la selección del jugador
		Segun op Hacer
			'w' o 'W': // Arriba
				Si posDetective[0] - 1 = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
					Escribir "¡Asesino arrestado! El juego ha terminado." //PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
				FinSi
				
			's' o 'S': // Abajo
				Si posDetective[0] + 1 = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
					Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
				FinSi
				
			'a' o 'A': // Izquierda
				Si posDetective[0] = posAsesino[0] y posDetective[1] - 1 = posAsesino[1] Entonces
					Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
				FinSi
				
			'd' o 'D': // Derecha
				Si posDetective[0] = posAsesino[0] y posDetective[1] + 1 = posAsesino[1] Entonces
					Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
				FinSi
				
			'q' o 'Q': // Misma casilla
				Si posDetective[0] = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
					Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
				FinSi
				
		FinSegun
		
	Hasta Que op = 'w' o op = 'W' o op = 's' o op = 'S' o op = 'a' o op = 'A' o op = 'd' o op = 'D' o op = 'q' o op = 'Q' o op = 'x' o op = 'X'

		// Restar un intento de arresto
		intentosRestantes = intentosRestantes - 1
	
FinSubAlgoritmo

///FUNCION DISTANCIA ENTRE DOS PUNTOS
Funcion cantMovimientos <- DistanciaEntre(A, B)
	cantMovimientos = Abs(A[0] - B[0]) + Abs(A[1] - B[1])
FinFuncion
	