Algoritmo CerealKiller
	
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
	Definir casillaAsesino Como Entero
	Definir posAsesino Como Entero
	Dimension posAsesino[2]
	
	//detective
	Definir posDetective Como Entero
	Dimension posDetective[2]
	
	Definir posCasa Como Entero
	Dimension posCasa[2]
	
	InicializarTablero(tablero)
	MostrarTablero(tablero)
	
	casillaAsesino = PosicionInicialAsesino
	Escribir casillaAsesino
	
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
Funcion inicio_asesino <- PosicionInicialAsesino
	Definir fila, columna Como Entero
	inicio_asesino = azar(8-1+1)+1 //ARREGLAR ALEATORIO
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

//Funcion para evaluar que el detective no esté en medio del camino
Funcion evaluacion <- EvaluarDetectiveEnCamino(posAsesino, posDetective, posCasa)
    Definir movimientosRestantes Como Entero
    Definir evaluacion Como Logico
    movimientosRestantes = 3
    evaluacion = Falso
    
    // Primera fase: Igualar columna y luego fila
    dimension asesino_temp[2]
    asesino_temp[0] = posAsesino[0] // Copia de la fila del asesino
    asesino_temp[1] = posAsesino[1] // Copia de la columna del asesino
    
    // Fase 1: Igualar la columna primero
    Mientras movimientosRestantes > 0 y asesino_temp[1] <> posCasa[1] Hacer
        Si asesino_temp[1] < posCasa[1] Entonces
            asesino_temp[1] = asesino_temp[1] + 1 // Mover a la derecha
        Sino Si asesino_temp[1] > posCasa[1] Entonces
				asesino_temp[1] = asesino_temp[1] - 1 // Mover a la izquierda
			FinSi
		FinSi
		
		// Verificar si el asesino se cruza con el detective
		Si asesino_temp[0] = posDetective[0] y asesino_temp[1] = posDetective[1] Entonces
			movimientosRestantes = -1 // Fase 1 fallida
		FinSi
		
		movimientosRestantes = movimientosRestantes - 1
	FinMientras
	
	// Verificar si aún tiene movimientos y puede continuar hacia la fila
	Si movimientosRestantes > 0 Entonces
		Mientras movimientosRestantes > 0 y asesino_temp[0] <> posCasa[0] Hacer
			Si asesino_temp[0] < posCasa[0] Entonces
				asesino_temp[0] = asesino_temp[0] + 1 // Mover hacia abajo
			Sino Si asesino_temp[0] > posCasa[0] Entonces
					asesino_temp[0] = asesino_temp[0] - 1 // Mover hacia arriba
				FinSi
			FinSi
			
			movimientosRestantes = movimientosRestantes - 1
			
			// Verificar si el asesino se cruza con el detective
			Si asesino_temp[0] = posDetective[0] y asesino_temp[1] = posDetective[1] Entonces
				movimientosRestantes = -1 // Fase 1 fallida
			FinSi
		FinMientras
		
		// Si el asesino llegó a la casa
		Si asesino_temp[0] = posCasa[0] y asesino_temp[1] = posCasa[1] Entonces
			evaluacion = Verdadero
		FinSi
	FinSi
	
	// Si la primera fase falló, intentar la segunda
	Si evaluacion = Falso Entonces
		movimientosRestantes = 3
		asesino_temp[0] = posAsesino[0] // Reiniciar la posición temporal del asesino
		asesino_temp[1] = posAsesino[1]
		
		// Fase 2: Igualar la fila primero y luego la columna
		Mientras movimientosRestantes > 0 y asesino_temp[0] <> posCasa[0] Hacer
			Si asesino_temp[0] < posCasa[0] Entonces
				asesino_temp[0] = asesino_temp[0] + 1 // Mover hacia abajo
			Sino Si asesino_temp[0] > posCasa[0] Entonces
					asesino_temp[0] = asesino_temp[0] - 1 // Mover hacia arriba
				FinSi
			FinSi
			
			// Verificar si el asesino se cruza con el detective
			Si asesino_temp[0] = posDetective[0] y asesino_temp[1] = posDetective[1] Entonces
				movimientosRestantes = -1 // Fase 2 fallida
			FinSi
			
			movimientosRestantes = movimientosRestantes - 1
		FinMientras
		
		// Verificar si aún tiene movimientos y puede continuar hacia la columna
		Si movimientosRestantes > 0 Entonces
			Mientras movimientosRestantes > 0 y asesino_temp[1] <> posCasa[1] Hacer
				Si asesino_temp[1] < posCasa[1] Entonces
					asesino_temp[1] = asesino_temp[1] + 1 // Mover a la derecha
				Sino Si asesino_temp[1] > posCasa[1] Entonces
						asesino_temp[1] = asesino_temp[1] - 1 // Mover a la izquierda
					FinSi
				finsi	
				movimientosRestantes = movimientosRestantes - 1
				
				// Verificar si el asesino se cruza con el detective
				Si asesino_temp[0] = posDetective[0] y asesino_temp[1] = posDetective[1] Entonces
					movimientosRestantes = -1 // Fase 2 fallida
				FinSi
			FinMientras
			
			// Si el asesino llegó a la casa
			Si asesino_temp[0] = posCasa[0] y asesino_temp[1] = posCasa[1] Entonces
				evaluacion = Verdadero
			FinSi
		FinSi
	FinSi
	
	// Devolver el resultado final de evaluacion
FinFuncion
