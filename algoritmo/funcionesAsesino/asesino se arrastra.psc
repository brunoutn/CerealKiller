Algoritmo asesino_precario_v3
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
	
	MovimientoAsesino(tablero, posAsesino)
FinAlgoritmo



//ESTAS FUNCIONES YA ESTÁN EN EL PROGRAMA -NO AGREGAR-
Funcion posicion <- FCtoPOS ( fila, columna )
	posicion = fila * 5 + columna + 1
Fin Funcion

Funcion cantMovimientos <- DistanciaEntre(A, B)
	cantMovimientos = Abs(A[0] - B[0]) + Abs(A[1] - B[1])
FinFuncion
//NO AGREGAR NO AGREGAR NO AGREGAR NO AGREGAR NO AGREGAR














// Función para el movimiento del asesino
SubAlgoritmo MovimientoAsesino(tablero Por Referencia, posAsesino Por Referencia)
	inicio_asesino = PosicionInicialAsesino
	POStoFC(inicio_asesino, posAsesino)
	Definir casaSeleccionada Como Logico
	Definir posCasa, movimientosRestantesAsesino Como Entero
	Definir tableroAux Como Caracter
	Dimension tableroAux[3,4]
	Dimension posCasa[2]
	movimientosRestantesAsesino = 3
	
	Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1
			tableroAux[i,j] = tablero[i,j]
		FinPara
	FinPara
	
	Repetir
		casaMasCercana(posAsesino, posCasa, tableroAux)
		evaluacion <- EvaluarDetectiveEnCamino(posAsesino, posDetective, posCasa, movimientosRestantesAsesino)
		si evaluacion = Verdadero Entonces
			casaSeleccionada = Verdadero
		SiNo
			tableroAux[posCasa[0], posCasa[1]] = 'X'
		FinSi
	Mientras Que casaSeleccionada = Falso
	
	tablero[posCasa[0], posCasa[1]] = 'O'
	
	posAsesino[0] = posCasa[0]
	posAsesino[1] = posCasa[1]

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
Funcion evaluacion <- EvaluarDetectiveEnCamino(posAsesino, posDetective, posCasa, movimientosRestantes)
    Definir evaluacion Como Logico
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

SubAlgoritmo casaMasCercana(posEntidad, posCasa Por Referencia, tablero)
    Definir dist, distMen Como Entero
	distMen = 12
    Definir rand Como Entero
    Dimension posCasaAux[2]
	
    Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1
            Si tablero[i, j] = "C"
                posCasaAux[0] = i
                posCasaAux[1] = j
                dist <- DistanciaEntre(posCasaAux, posEntidad)
                
                // Si la nueva distancia es menor, actualizamos
                Si dist < distMen
                    distMen <- dist
                    posCasa[0] = posCasaAux[0]
                    posCasa[1] = posCasaAux[1]
					// Si la nueva distancia es igual, elegimos una al azar
				SiNo 
					Si dist = distMen
						rand <- azar(2)
						Si rand = 1
							posCasa[0] = i
							posCasa[1] = j
						FinSi
					FinSi
                FinSi
            FinSi
        FinPara
    FinPara
    
FinSubAlgoritmo

SubAlgoritmo POStoFC(posicion, pos Por Referencia)
	pos[0] = (TRUNC((posicion - 1) / 5))
	pos[1] = ((posicion - 1) % 5)
FinSubAlgoritmo