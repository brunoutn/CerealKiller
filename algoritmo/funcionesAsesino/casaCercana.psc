Algoritmo casaCercana
	Definir FILAS, COLUMNAS Como Entero
	FILAS = 4
	COLUMNAS = 5
	
	// Tablero de juego
	Definir tablero Como Caracter
	Dimension tablero[FILAS, COLUMNAS]
	
	InicializarTablero(tablero)
	MostrarTablero(tablero)
	Dimension posCasa[2]
	Dimension posEntidad[2]
	
	//POSICION HARDCODEADA, UNIFICAR CON LA UBICACION ALEATORIA
	posEntidad[0] = 1
	posEntidad[1] = 3
	casaMasCercana(posEntidad, posCasa, tablero)
FinAlgoritmo

///FUNCION A COPIAR
SubAlgoritmo casaMasCercana(posEntidad, posCasa Por Referencia, tablero)
    Definir dist Como Entero
    Definir distMen Como Entero
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
    
    Escribir "La casa más cercana está en la posición: ", FCtoPOS(posCasa[0], posCasa[1])
    Escribir "El asesino está en la posición: ", FCtoPOS(posEntidad[0], posEntidad[1])
FinSubAlgoritmo

Funcion cantMovimientos <- DistanciaEntre(A, B)
	cantMovimientos = Abs(A[0] - B[0]) + Abs(A[1] - B[1])
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

// Función para dar un numero de casilla segun fila y columna
Funcion posicion <- FCtoPOS ( fila, columna )
	posicion = fila * 5 + columna + 1
Fin Funcion

// Funcion para dar fila y columna segun numero de casilla 
SubAlgoritmo POStoFC(posicion, fila Por Referencia, columna Por Referencia)
	fila = (TRUNC((posicion - 1) / 5))+1
	columna = ((posicion - 1) % 5)+1
FinSubAlgoritmo

