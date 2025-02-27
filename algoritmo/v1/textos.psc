Algoritmo CerealKiller
	
	Jugar
	
FinAlgoritmo





SubAlgoritmo Jugar
	Definir FILAS, COLUMNAS Como Entero
	FILAS = 4
	COLUMNAS = 5
	
	// Tablero de juego
	Definir tablero Como Caracter
	Dimension tablero[FILAS, COLUMNAS]
	
	// Tablero para guardar la posici�n del asesino
	//Definir tablero_asesino Como Caracter
	//Dimension tablero_asesino[FILAS, COLUMNAS]
	//Definir casillaAsesino Como Entero
	Dimension posAsesino[2]
	Dimension posCasilla[2]
	
	//casillaAsesino = PosicionInicialAsesino
	//POStoFC(casillaAsesino, posAsesino[0], posAsesino[1])
	
	Definir turnosDetective, intentosArresto Como Entero
	//detective
	Dimension posDetective[2]
	//Dimension posCasa[2]
	
	Definir fila, colum Como Entero
	Definir casillaAnterior Como Caracter
	Definir arrestoExitoso Como Logico
	arrestoExitoso = Falso
	
	Repetir
        MostrarMenu()
		opPrinc <- validarn
        Segun opPrinc
            1:
				Limpiar Pantalla
				finDelJuego = Falso
				turnosDetective = 4
				intentosArresto = 4
				dia = 1
				asesinatos = 0
				inicio_asesino = PosicionInicialAsesino
				POStoFC(inicio_asesino, posAsesino[0], posAsesino[1])
				
                InicializarTablero(tablero)
				MovimientoAsesino(tablero, posAsesino, posDetective, asesinatos, dia)
				
				Repetir
					//JUEGO DETECTIVE
					Limpiar Pantalla
					//Funciones detective agrupadas
					Detective(tablero, casillaAnterior, posAsesino, posDetective, turnosDetective, intentosArresto, finDelJuego, dia, asesinatos)
					turnosDetective = 3
					
					validarFin(arrestoExitoso, intentosArresto, finDelJuego, dia, asesinatos)
					Si !finDelJuego
						MovimientoAsesino(tablero, posAsesino, posDetective, asesinatos, dia)
					SiNo 
						Si intentosArresto = -1
							Escribir "Finalizando partida..." ///HACER TEXTO GRANDE
							Esperar Tecla
						SiNo 
							Si arrestoExitoso
								MostrarGoodEnd
								Esperar Tecla
							SiNo
								Si !arrestoExitoso
									MostrarBadEnd
									Esperar Tecla
								FinSi
							FinSi
						FinSi
					FinSi
					
				Hasta Que finDelJuego = Verdadero o intentosArresto = 0
			2:
                MostrarReglas()
            3:
                Escribir "Saliendo del juego..."
            De Otro Modo:
				Limpiar Pantalla
                Escribir "Opci�n inv�lida, intente de nuevo."
        FinSegun
		Limpiar Pantalla
    Hasta Que opPrinc = 3
	
FinSubAlgoritmo

///VALIDAR INPUT EN MENUS DE OPCIONES NUMERICAS
SubProceso v<-validarn
	Definir num Como texto
	Definir validarnum Como Logico
	
	Leer num
	largo<-longitud(num)
	validarnum<-Verdadero;
	
	Para i<-0 Hasta largo - 1 con paso 1 Hacer
		numunico<-Subcadena(num,i,i)
		
		si numunico <>"1" Y numunico <>'2' Y numunico <>'3' Y numunico <>'4' Y numunico <>'5' Y numunico <>'6' Y numunico <>'7' Y numunico <>'8' Y numunico <>'9' entonces
			validarnum = Falso
		FinSi
	FinPara
	
	Si validarnum = Verdadero
		v <- ConvertirANumero(num)
	FinSi
FinSubProceso

// Funci�n para dar un numero de casilla segun fila y columna
Funcion posicion <- FCtoPOS ( fila, columna )
	posicion = fila * 5 + columna + 1
Fin Funcion

// Funcion para dar fila y columna segun numero de casilla 
SubAlgoritmo POStoFC(posicion, fila Por Referencia, columna Por Referencia)
	fila = (TRUNC((posicion - 1) / 5))+1
	columna = ((posicion - 1) % 5)+1
FinSubAlgoritmo

///Funcion para evaluar motivo de fin del juego
SubAlgoritmo validarFin(arrestoExitoso Por Referencia, intentosArresto Por Referencia, finDelJuego Por Referencia, dia Por Referencia, asesinatos Por Referencia)
	Si dia <= 7 Entonces
		Si (intentosArresto = 0 y !finDelJuego) o (asesinatos = 6 y !finDelJuego) Entonces
			arrestoExitoso = Falso
			finDelJuego = Verdadero
		SiNo 
			Si finDelJuego y intentosArresto < 4	
				arrestoExitoso = Verdadero
			SiNo
				Si finDelJuego
					intentosArresto = -1
				FinSi
			FinSi
		FinSi
		
		dia = dia + 1
	SiNo
		finDeljuego = Verdadero
		arrestoExitoso = Falso
	FinSi
	
FinSubAlgoritmo

SubAlgoritmo validarCasillaAdyacente(tablero, casillaBuscar, posReferencia, posEncontrada Por Referencia, encontrado Por Referencia)
	Definir fila, columna Como Entero
    encontrado <- Falso
	
    // Buscar en casillas adyacentes (arriba, abajo, izquierda, derecha)
	Para i Desde 0 Hasta 1 Hacer
		Para j Desde 0 Hasta 1 Hacer
			Si (Abs(i) <> Abs(j)) Entonces // Evita diagonales
				fila <- posReferencia[0] + i
				columna <- posReferencia[1] + j
				
				// Validar que est� dentro del rango del tablero (4x5)
				Si fila >= 0 Y fila < 4 Y columna >= 0 Y columna < 5 Entonces
					Si tablero[fila, columna] = casillaBuscar Entonces
						posEncontrada[0] <- fila
						posEncontrada[1] <- columna
						encontrado <- Verdadero
						i = 1
					FinSi
				FinSi
			FinSi
		FinPara
	FinPara
	
	Escribir encontrado
	Esperar Tecla

FinSubAlgoritmo

///############################################################################
///############### ACA EMPIEZAN LAS FUNCIONES DEL DETECTIVE ###################
///############################################################################

SubAlgoritmo Detective(tablero Por Referencia, casillaAnterior Por Referencia, posAsesino, posDetective Por Referencia, turnos Por Referencia, intentosArresto Por Referencia, finDelJuego Por Referencia, diaActual Por Referencia, asesinatos)
	Limpiar Pantalla
	MoverDetective(tablero, casillaAnterior, posAsesino, posDetective, turnos, intentosArresto, finDelJuego, diaActual, asesinatos)
FinSubAlgoritmo

SubAlgoritmo ubicarJugadorEnTablero(tablero, casillaAnterior Por Referencia, posDetective)
	GuardarCasillaAnterior(casillaAnterior, tablero, posDetective)
    // Colocar al jugador "D" en la nueva posici�n
    tablero[posDetective[0], posDetective[1]] = "D"
FinSubAlgoritmo

SubAlgoritmo GuardarCasillaAnterior(casillaAnterior Por Referencia, tablero, posDetective)
	// Restaurar la casilla anterior con el valor original
	Definir i,j como entero
	
    Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1
            Si tablero[i, j] = "D" Entonces
                tablero[i, j] = casillaAnterior  // Restauramos el valor que hab�a antes de colocar el jugador
				i = 3
				j = 4
            FinSi
        FinPara
    FinPara
    // Guardar lo que hab�a en la nueva posici�n antes de colocar al jugador
    casillaAnterior = tablero[posDetective[0], posDetective[1]]
FinSubAlgoritmo

///############################################################################
///####################### ELECCION DE CAFE INICIAL ###########################
///############################################################################

SubAlgoritmo ElegirCafe(tablero por referencia, casillaAnterior Por Referencia, posDetective Por Referencia)
	Definir opcionMovimiento Como Caracter
	casillaAnterior <- "K"
	
	Repetir
		Limpiar Pantalla
		MostrarTablero2(tablero, 0, 0, 4, 3)
		Escribir "Elija un cafe para empezar:"
		Escribir "Q. Cafe en la posicion 7 del tablero"
		Escribir "E. Cafe en la posicion 14 del tablero"
		Escribir "X. Salir del juego"
		Leer opcionMovimiento
		
		Si opcionMovimiento = "q" o opcionMovimiento = "Q"
			posDetective[0] = 1
			posDetective[1] = 1
		SiNo
			Si opcionMovimiento = 'e' o opcionMovimiento = 'E' //Valido con el si para que no se ejecute el ubicado del jugador en tablero de forma innecesaria
				posDetective[0] = 2
				posDetective[1] = 3
			SiNo
				Si opcionMovimiento = 'x' o opcionMovimiento = 'X'
					casillaAnterior = "X"
				FinSi
			FinSi
		FinSi
		Limpiar Pantalla
	Hasta Que opcionMovimiento = 'Q' o opcionMovimiento = 'q' o opcionMovimiento = 'E' o opcionMovimiento = 'e' o opcionMovimiento = 'x' o opcionMovimiento = 'X'
	
	Si casillaAnterior <> "X"
		ubicarJugadorEnTablero(tablero, casillaAnterior, posDetective)
	FinSi
	
FinSubAlgoritmo

///############################################################################
///########################### MOVER DETECTIVE ################################
///############################################################################

////SUMAR TESTIGO
//- En el caso de que el detective comience, pase o termine su turno en el mismo o un casillero adyacente a un testigo, se le interrogar� autom�ticamente, desplegando un men� de preguntas:
//	- 1. �En qu� direcci�n est� el Asesino? (Arriba/Abajo/Izquierda/Derecha)
//	- 2. �El Asesino est� en la misma fila que el Testigo? (Si/No)
//		- 3. �El Asesino est� en la misma columna que el Testigo? (Si/No)
//			- 4. �El Asesino est� en una casa, parque o caf�? (Si/No) - 5. �El Asesino est� en un casillero Par o Impar? (Par/Impar)
SubAlgoritmo MoverDetective(tablero Por Referencia, casillaAnterior Por Referencia, posAsesino, posDetective Por Referencia, turnosDetective Por Referencia, intentosArresto Por Referencia, finDelJuego Por Referencia, diaActual Por Referencia, asesinatos)
	Definir opcionMovimiento como caracter
	
	Si turnosDetective = 4 Entonces
		ElegirCafe(tablero, casillaAnterior, posDetective)
		turnosDetective = turnosDetective - 1
	FinSi
	
	Si casillaAnterior <> "X"
		fila = posDetective[0]
		colum = posDetective[1]
		ubicarJugadorEnTablero(tablero, casillaAnterior, posDetective)
		//MostrarTablero(tablero)
		MostrarTablero2(tablero, diaActual, asesinatos, intentosArresto, turnosDetective)
		
		Repetir
			Escribir "W. Arriba"
			Escribir "S. Abajo"
			Escribir "D. Derecha"
			Escribir "A. Izquierda"
			Escribir "1. Arrestar arriba"
			Escribir "2. Arrestar abajo"
			Escribir "3. Arrestar derecha"
			Escribir "4. Arrestar izquierda"
			Escribir "5. Arrestar misma casilla"
			Escribir "X. Salir del juego"
			Escribir "Posicion asesino: ", FCtoPOS(posAsesino[0], posAsesino[1])
			Escribir "Posicion detective: ", FCtoPOS(posDetective[0], posDetective[1])
			
			Leer opcionMovimiento
			Segun opcionMovimiento Hacer
				'w' o 'W': 
					Si fila - 1 >= 0 Entonces
						fila = fila - 1
						turnosDetective = turnosDetective - 1
					FinSi
				's' o 'S': 
					Si fila + 1 <= 3 Entonces
						fila = fila + 1
						turnosDetective = turnosDetective - 1
					FinSi
				'd' o 'D':
					Si colum + 1 <= 4 Entonces
						colum = colum + 1
						turnosDetective = turnosDetective - 1
					FinSi
				'a' o 'A': 
					Si colum - 1 >= 0 Entonces
						colum = colum - 1
						turnosDetective = turnosDetective - 1
					FinSi
				'1' o '2' o '3' o '4' o '5':
					ArrestarPorOpcion(posAsesino, posDetective, turnos, intentosArresto, finDelJuego, opcionMovimiento)
					
					Si finDelJuego
						Escribir "�Asesino arrestado!"
						intentosArresto = intentosArresto - 1
					SiNo
						Escribir "Fallaste el arresto."
						intentosArresto = intentosArresto - 1
						
						Si intentosArresto = 0
							Escribir "Te quedaste sin intentos de arresto..."
						FinSi
					FinSi
					
					Escribir "Presione una tecla para continuar..."
					Esperar Tecla
				'x' o 'X':
					Limpiar Pantalla
					finDelJuego = Verdadero
				De Otro Modo:
					Escribir "Input incorrecto, vuelva a ingresar"
			FinSegun
			
			///Probar validacion para no llamar a la funcion al terminar
			Si (validarCambioPos(posDetective, fila, colum)) Entonces
				posDetective[0] = fila
				posDetective[1] = colum
				
				ubicarJugadorEnTablero(tablero, casillaAnterior, posDetective)
			FinSi
			
			Limpiar Pantalla
			
			//MostrarTablero(tablero)
			MostrarTablero2(tablero, diaActual, asesinatos, intentosArresto, turnosDetective)
			
		Hasta Que finDelJuego o turnosDetective = 0 o intentosArresto = 0
	SiNo
		finDelJuego = Verdadero
	FinSi
	
FinSubAlgoritmo

Funcion seMovio <- validarCambioPos(posDetective, fila, colum) 
	Si (posDetective[0] = fila y posDetective[1] = colum)
		seMovio = Falso
	SiNo
		seMovio = Verdadero
	FinSi
FinFuncion

///############################################################################
///################## ACA EMPIEZA LA FUNCION DE ARRESTAR ######################
///############################################################################

SubAlgoritmo ArrestarPorOpcion(posAsesino, posDetective, turnos Por Referencia, intentosArresto Por Referencia, finDeljuego Por Referencia, op)
	Si intentosArresto > 0 Entonces
		Segun op Hacer
			'1':
				Si posDetective[0] - 1 = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
					finDelJuego = Verdadero
				FinSi
			'2':
				Si posDetective[0] + 1 = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
					finDelJuego = Verdadero
				FinSi
			'3':
				Si posDetective[0] = posAsesino[0] y posDetective[1] + 1 = posAsesino[1] Entonces
					finDelJuego = Verdadero
				FinSi
			'4':
				Si posDetective[0] = posAsesino[0] y posDetective[1] - 1 = posAsesino[1] Entonces
					finDelJuego = Verdadero
				FinSi
			'5':
				Si posDetective[0] = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
					finDelJuego = Verdadero
				FinSi
		FinSegun
	FinSi
	
FinSubAlgoritmo


///FUNCION PARA CALCULAR DISTANCIA ENTRE POSICIONES
Funcion cantMovimientos <- DistanciaEntre(A, B)
	cantMovimientos = Abs(A[0] - B[0]) + Abs(A[1] - B[1])
FinFuncion

///############################################################################
///############### ACA EMPIEZAN LAS FUNCIONES DEL ASESINO ###################
///############################################################################


///############################################################################
///############# FUNCION DE POSICION PROVISIONAL PARA EL ASESINO ##############
///############################################################################

// Funci�n para darle posici�n inicial al asesino
Funcion inicio_asesino <- PosicionInicialAsesino
	Definir fila, columna Como Entero
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
	inicio_asesino = FCtoPOS(fila, columna)
FinFuncion

///############################################################################
///################# FUNCION DE MOVIMIENTO PARA EL ASESINO ####################
///############################################################################

SubAlgoritmo MovimientoAsesino(tablero Por Referencia, posAsesino Por Referencia, posDetective, asesinatos Por Referencia, dia)
	Definir casaSeleccionada, encontrado Como Logico
	encontrado = Falso
	Definir posCasa, movimientosRestantesAsesino, limite Como Entero
	//limite = 25
	Definir tableroAux Como Caracter
	Dimension tableroAux[4,5] 
	Dimension posCasa[2]
	movimientosRestantesAsesino = 3
	
	Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1
			tableroAux[i,j] = tablero[i,j]
		FinPara
	FinPara
	
	Repetir
		casaMasCercana(posAsesino, posCasa, tableroAux, tablero)
		
		evaluacion <- EvaluarDetectiveEnCamino(posAsesino, posDetective, posCasa, movimientosRestantesAsesino)
		si evaluacion = Verdadero Entonces
			casaSeleccionada = Verdadero
		SiNo
			Si dia <> 1
				tableroAux[posCasa[0], posCasa[1]] = 'X'
			FinSi
		FinSi
		
	Mientras Que casaSeleccionada = Falso
	
	Si dia <> 1
		tablero[posCasa[0], posCasa[1]] = 'O'
		asesinatos = asesinatos + 1
	FinSi
	
	posAsesino[0] = posCasa[0]
	posAsesino[1] = posCasa[1]
	
	ValidarCasillaAdyacente(tablero, "P", posAsesino, posCasilla, encontrado)
	
	Si encontrado
		
	FinSi
	
FinSubAlgoritmo

//SubAlgoritmo clonarTableroaAux(tableroAux Por Referencia, tablero) 
//	Para i = 0 Hasta 4-1 Con Paso 1
//		Para j = 0 Hasta 5-1 Con Paso 1
//			tableroAux[i,j] = tablero[i,j]
//		FinPara
//	FinPara
//FinSubAlgoritmo

/////############################################################################
///############ FUNCION PARA EVALUAR CASA MAS CERCANA AL ASESINO ##############
///############################################################################

SubAlgoritmo casaMasCercana(posEntidad, posCasa Por Referencia, tableroAux Por Referencia, tablero)
    Definir dist, distMen, rand Como Entero
	distMen = 12
    Dimension posCasaAux[2]
	
    Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1	
            Si tableroAux[i, j] = "C"
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
    
//	Si casasDisponibles = 0 Entonces
	//        posCasa[0] = 2
//		posCasa[1] = 0
//		
//		clonarTableroaAux(tableroAux, tablero)
//		Escribir "tablero clonado"
//		Esperar Tecla
	//    FinSi
	
FinSubAlgoritmo



///############################################################################
///############### FUNCION PARA EVALUAR DETECTIVE EN CAMINO ###################
///############################################################################

//Funcion para evaluar que el detective no est� en medio del camino
Funcion evaluacion <- EvaluarDetectiveEnCamino(posAsesino, posDetective, posCasa, movimientosRestantes)
    Definir evaluacion Como Logico
    evaluacion = Falso
    
    // Primera fase: Igualar columna y luego fila
    dimension asesino_temp[2]
    asesino_temp[0] = posAsesino[0] // Copia de la fila del asesino
    asesino_temp[1] = posAsesino[1] // Copia de la columna del asesino
    
    // Fase 1: Igualar la columna primero
    Mientras movimientosRestantes > 0 y asesino_temp[1] <> posCasa[1] Hacer
		distancia <- DistanciaEntre(posCasa, asesino_temp)
		
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
		
		//Escribir "Estoy aca, mov ", movimientosRestantes, " posASesino ", asesino_temp[1], " posCasa", posCasa[1]
	FinMientras
	
	// Verificar si a�n tiene movimientos y puede continuar hacia la fila
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
		
		// Si el asesino lleg� a la casa
		Si asesino_temp[0] = posCasa[0] y asesino_temp[1] = posCasa[1] Entonces
			evaluacion = Verdadero
		FinSi
		
		//Escribir "Estoy aca, mov ", movimientosRestantes, " posASesino ", asesino_temp[1], " posCasa", posCasa[1]
	FinSi
	
	// Si la primera fase fall�, intentar la segunda
	Si evaluacion = Falso Entonces
		movimientosRestantes = 3
		asesino_temp[0] = posAsesino[0] // Reiniciar la posici�n temporal del asesino
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
		
		// Verificar si a�n tiene movimientos y puede continuar hacia la columna
		Si movimientosRestantes > 0 Entonces
			Mientras movimientosRestantes > 0 y asesino_temp[1] <> posCasa[1] Hacer
				Si asesino_temp[1] < posCasa[1] Entonces
					asesino_temp[1] = asesino_temp[1] + 1 // Mover a la derecha
				SiNo Si asesino_temp[1] > posCasa[1] Entonces
						asesino_temp[1] = asesino_temp[1] - 1 // Mover a la izquierda
					FinSi
				finsi	
				movimientosRestantes = movimientosRestantes - 1
				
				// Verificar si el asesino se cruza con el detective
				Si asesino_temp[0] = posDetective[0] y asesino_temp[1] = posDetective[1] Entonces
					movimientosRestantes = -1 // Fase 2 fallida
				FinSi
			FinMientras
			
			// Si el asesino lleg� a la casa
			Si asesino_temp[0] = posCasa[0] y asesino_temp[1] = posCasa[1] Entonces
				evaluacion = Verdadero
			FinSi
		FinSi
		
	FinSi
	
	// Devolver el resultado final de evaluacion
FinFuncion

///############################################################################
///################## FUNCIONES BASICAS PARA EL TABLERO #######################
///############################################################################

SubAlgoritmo MostrarMenu
    Limpiar Pantalla
	
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                 %#@@#  %#@@%  %#@@%   %#@@%   %#@@%   #                                                                                                                                                                        *"
    Escribir "*                                                                                                                                                 #      #      #   #   #       #   #   #                                                                                                                                                                        *"
    Escribir "*                                                                                                                                                 #      %#@@   %#@@    %#@@%   %#@@%   #                                                                                                                                                                        *" 
    Escribir "*                                                                                                                                                 #      #      #   #   #       #   #   #                                                                                                                                                                        *"
    Escribir "*                                                                                                                                                 %#@@#  %#@@%  #    #  %#@@%   #   #   %#@@%                                                                                                                                                                    *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                  #   #  %#@  #      #      %#@@%   %#@@%                                                                                                                                                                       *"
    Escribir "*                                                                                                                                                  #  #   %#@  #      #      #       #   #                                                                                                                                                                       *"
    Escribir "*                                                                                                                                                  %#@    %#@  #      #      %#@@%   %#@@                                                                                                                                                                        *"
    Escribir "*                                                                                                                                                  #  #   %#@  #      #      #       #   #                                                                                                                                                                       *"
    Escribir "*                                                                                                                                                  #   #  %#@  %#@@%  %#@@%  %#@@%   #    #                                                                                                                                                                      *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                           ** MENU PRINCIPAL **                                                                                                                                                                                 *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                               1 - Jugar                                                                                                                                                                                        *"
    Escribir "*                                                                                                                                                               2 - Ver Reglas                                                                                                                                                                                   *"
    Escribir "*                                                                                                                                                               3 - Salir del juego                                                                                                                                                                              *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
FinSubAlgoritmo




SubAlgoritmo MostrarReglas
    Limpiar Pantalla
	
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                               REGLAS DEL JUEGO                                                                                                                                                                                 *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                                1. OBJETIVO:                                                                                                                                                                                    *"
    Escribir "*                                                                                                                                              - El Detective debe atrapar al Asesino antes de 6 asesinatos.                                                                                                                                                     *"
    Escribir "*                                                                                                                                              - El Asesino debe eliminar 6 v�ctimas sin ser capturado.                                                                                                                                                          *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                                2. TABLERO: MAPA 4X5                                                                                                                                                                            *"
    Escribir "*                                                                                                                                              - Casas: 1, 5, 8, 10, 11, 15, 17, 18                                                                                                                                                                              *"
    Escribir "*                                                                                                                                              - Parques: 2, 4, 13                                                                                                                                                                                               *"
    Escribir "*                                                                                                                                              - Caf�s: 7, 14                                                                                                                                                                                                    *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                                3. TURNOS Y MOVIMIENTOS                                                                                                                                                                         *"
    Escribir "*                                                                                                                                              - Asesino: Se mueve 3 casillas (horizontal/vertical).                                                                                                                                                             *"
    Escribir "*                                                                                                                                                * Puede asesinar en casas y dejar un cereal.                                                                                                                                                                    *"
    Escribir "*                                                                                                                                                * Si hay un parque cerca, deja un testigo.                                                                                                                                                                      *"
    Escribir "*                                                                                                                                              - Detective: Se mueve hasta 3 casillas por turno.                                                                                                                                                                 *"
    Escribir "*                                                                                                                                                * Elige un caf� para iniciar.                                                                                                                                                                                   *"
    Escribir "*                                                                                                                                                * Interroga testigos autom�ticamente si pasa cerca.                                                                                                                                                             *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                                4. ACCIONES DEL DETECTIVE                                                                                                                                                                       *"
    Escribir "*                                                                                                                                              - Moverse (arriba, abajo, izquierda, derecha).                                                                                                                                                                    *"
    Escribir "*                                                                                                                                              - Arrestar (en la misma casilla o adyacente).                                                                                                                                                                     *"
    Escribir "*                                                                                                                                              - Terminar turno.                                                                                                                                                                                                 *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                                5. CONDICIONES DE VICTORIA                                                                                                                                                                      *"
    Escribir "*                                                                                                                                              - Gana el Asesino si logra 6 v�ctimas o el Detective se queda sin intentos.                                                                                                                                       *"
    Escribir "*                                                                                                                                              - Gana el Detective si arresta al Asesino antes de su objetivo.                                                                                                                                                   *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                         Presione una tecla para volver al men�...                                                                                                                                                              *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Esperar Tecla
FinSubAlgoritmo

SubAlgoritmo MostrarBadEnd
	Limpiar Pantalla
	
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                 8 888888888o   8 8888888888   8 888888888o.   8 888888888o.       8 8888    d888888o. 8888888 8888888888 8 8888888888                                                                                                                          *"
    Escribir "*                                                                                                                 8 8888    `88. 8 8888         8 8888    `88.  8 8888    `^888.    8 8888  .`8888:  `88.     8 8888       8 8888                                                                                                                                *"
    Escribir "*                                                                                                                 8 8888     `88 8 8888         8 8888     `88  8 8888        `88.  8 8888  8.`8888.   Y8     8 8888       8 8888                                                                                                                                *"
    Escribir "*                                                                                                                 8 8888     ,88 8 8888         8 8888     ,88  8 8888         `88  8 8888  `8.`8888.         8 8888       8 8888                                                                                                                                *"
    Escribir "*                                                                                                                 8 8888.   ,88  8 888888888888 8 8888.   ,88   8 8888          88  8 8888   `8.`8888.        8 8888       8 888888888888                                                                                                                        *"
    Escribir "*                                                                                                                 8 888888888P   8 8888         8 888888888P    8 8888          88  8 8888    `8.`8888.       8 8888       8 8888                                                                                                                                *"
    Escribir "*                                                                                                                 8 8888         8 8888         8 8888`8b       8 8888         ,88  8 8888     `8.`8888.      8 8888       8 8888                                                                                                                                *"
    Escribir "*                                                                                                                 8 8888         8 8888         8 8888 `8b.     8 8888        ,88   8 8888 8b   `8.`8888.     8 8888       8 8888                                                                                                                                *"
    Escribir "*                                                                                                                 8 8888         8 8888         8 8888   `8b.   8 8888    ,o88P     8 8888 `8b.  ;8.`8888     8 8888       8 8888                                                                                                                                *"
    Escribir "*                                                                                                                 8 8888         8 888888888888 8 8888     `88. 8 888888888P        8 8888  `Y8888P ,88P      8 8888       8 888888888888                                                                                                                        *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                                                         Presione una tecla para continuar...                                                                                                                                                                   *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
FinSubAlgoritmo


SubAlgoritmo MostrarGoodEnd
	Limpiar Pantalla
	
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                                     ,o888888o.          .8.          b.             8          .8.            d888888o. 8888888 8888888888 8 8888888888                                                                                                                        *"
    Escribir "*                                                                                                                     8888     `88.       .888.         888o.          8         .888.         .`8888:  `88.     8 8888       8 8888                                                                                                                             *"
    Escribir "*                                                                                                                  ,8 8888       `8.     :88888.        Y88888o.       8        :88888.        8.`8888.   Y8     8 8888       8 8888                                                                                                                             *"
    Escribir "*                                                                                                                  88 8888              . `88888.       .`Y888888o.    8       . `88888.       `8.`8888.         8 8888       8 8888                                                                                                                             *"
    Escribir "*                                                                                                                  88 8888             .8. `88888.      8o. `Y888888o. 8      .8. `88888.       `8.`8888.        8 8888       8 888888888888                                                                                                                     *"
    Escribir "*                                                                                                                  88 8888            .8`8. `88888.     8`Y8o. `Y88888o8     .8`8. `88888.       `8.`8888.       8 8888       8 8888                                                                                                                             *"
    Escribir "*                                                                                                                  88 8888   8888888 .8  `8. `88888.    8   `Y8o. `Y8888    .8  `8. `88888.       `8.`8888.      8 8888       8 8888                                                                                                                             *"
    Escribir "*                                                                                                                  `8 8888       .8 .8    `8. `88888.   8      `Y8o. `Y8   .8    `8. `88888.  8b   `8.`8888.     8 8888       8 8888                                                                                                                             *"
    Escribir "*                                                                                                                     8888     ,88 .888888888. `88888.  8         `Y8o.`  .888888888. `88888. `8b.  ;8.`8888     8 8888       8 8888                                                                                                                             *"
    Escribir "*                                                                                                                      `8888888P  .8        `8. `88888. 8            `Yo .8        `8. `88888. `Y8888P ,88P      8 8888       8 888888888888                                                                                                                     *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                         Presione una tecla para continuar...                                                                                                                                                                   *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
FinSubAlgoritmo


SubAlgoritmo MostrarAsesinoArrestado
	Limpiar Pantalla
	
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "*                                                                                                      d8888                             d8b                                                                   888                  888           888                                                                                                            *"
    Escribir "*                                                                                                     d88888                             Y8P                                                                   888                  888           888                                                                                                            *"
    Escribir "*                                                                                                    d88P888                                                                                                   888                  888           888                                                                                                            *"
    Escribir "*                                                                                                   d88P 888  .d8888b   .d88b.  .d8888b  888 88888b.   .d88b.       8888b.  888d888 888d888  .d88b.  .d8888b  888888   8888b.   .d88888  .d88b.   888                                                                                                            *"
    Escribir "*                                                                                                  d88P  888  88K      d8P  Y8b 88K      888 888 \88b d88 \88b        \ 88b 888P\   888P\   d8P  Y8b 88K       888       \ 88b d88\ 888 d88\ 88b  888                                                                                                            *"
    Escribir "*                                                                                                 d88P   888  \Y8888b. 88888888 \Y8888b  888 888  888 888  888     .d888888 888     888    88888888 \ Y8888b.  888    .d888888 888  888 888  888  Y8P                                                                                                            *"
    Escribir "*                                                                                                d8888888888      X88  Y8b.         X88  888 888  888 Y88..88P     888  888 888     888    Y8b.          X88   Y88b.  888  888 Y88b 888 Y88..88P                                                                                                                 *"
    Escribir "*                                                                                               d88P     888  88888P'  \"Y8888   88888P  888 888  888  \ Y88P\"    "Y888888 888     888     \ Y8888   88888P   \Y888   Y888888   Y88888  \Y888P\  888                                                                                                            *"
    Escribir "*                                                                                                                                                                                                                                                                                                                                                                *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
    Escribir "*                                                                                                                                                         Presione una tecla para continuar...                                                                                                                                                                   *"
    Escribir "******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************"
FinSubAlgoritmo

SubAlgoritmo MostrarFinDelJuego
    Limpiar Pantalla
    Escribir "8888888888 d8b              8888888b.           888       888888                                    "
    Escribir "888        Y8P              888   Y88b          888          88b                                    "
    Escribir "888                         888    888          888          888                                    "
    Escribir "8888888    888 88888b.      888    888  .d88b.  888          888 888  888  .d88b.   .d88b.   .d88b. "
    Escribir "888        888 888  88b     888    888 d8P  Y8b 888          888 888  888 d8P  Y8b d88P 88b d88  88b"
    Escribir "888        888 888  888     888    888 88888888 888          888 888  888 88888888 888  888 888  888"
    Escribir "888        888 888  888     888  .d88P Y8b.     888          88P Y88b 888 Y8b.     Y88b 888 Y88..88P"
    Escribir "888        888 888  888     8888888P     Y8888  888          888   Y88888   Y8888    Y88888   Y88P  "
    Escribir "                                                           .d88P                        888         "
    Escribir "                                                         .d88P                     Y8b d88P         "
    Escribir "                                                        888P                         Y88P           "
    Esperar Tecla
FinSubAlgoritmo

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
				De Otro Modo: tablero[i, j] = "N"
			FinSegun
		FinPara
	FinPara
FinSubAlgoritmo

SubAlgoritmo MostrarTablero2(tablero Por Referencia, dia, asesinatos, intentosArresto, turnosDetective)
	Definir linea Como Entero
	
	Para i = 0 Hasta 4-1 Con Paso 1
		Para linea = 1 Hasta 15 Con Paso 1
            Para j = 0 Hasta 5-1 Con Paso 1
				si tablero[i, j] = 'D' Entonces
					MostrarDetective(linea)
				SiNo
					Segun tablero[i, j] Hacer
						Caso 'C':
							MostrarCasa(linea)
						Caso 'O':
							MostrarCereal(linea)
						Caso 'D':
							MostrarDetective(linea)
						Caso 'P':
							MostrarParque(linea)
						Caso 'K':
							MostrarCafe(linea)
						//Caso 'T':
						De Otro Modo:
							MostrarNada(linea)
					FinSegun
				FinSi
            FinPara
			
			Si i = 0
				Segun linea Hacer
                    1:  Escribir "  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" Sin Saltar
                    2:  Escribir "  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" Sin Saltar
                    3:  Escribir "  @@                                                                                    @@@" Sin Saltar
                    4:  Escribir "  @@                                                                                    @@@" Sin Saltar
                    6:  Escribir "  @@                                                                                    @@@" Sin Saltar 
                    5:  Escribir "  @@   D  I  A  :      ", dia, "                                                                @@@" Sin Saltar
					8:  Escribir "  @@                                                                                    @@@" sin saltar
                    7:  Escribir "  @@   A  S  E  S  I  N  A  T  O  S  :      ", asesinatos, "                                           @@@" Sin Saltar
					10: Escribir "  @@                                                                                    @@@" sin saltar
                    9:  Escribir "  @@   I  N  T  E  N  T  O  S   D  E   A  R  R  E  S  T  O  :    ", intentosArresto, "                      @@@" Sin Saltar
					12: Escribir "  @@                                                                                    @@@" sin saltar
                    11: Escribir "  @@   M  O  V  I  M  I  E  N  T  O  S   R  E  S  T  A  N  T  E  S  :    ", turnosDetective, "              @@@" Sin Saltar
                    13: Escribir "  @@                                                                                    @@@" Sin Saltar
                    14: Escribir "  @@                                                                                    @@@" Sin Saltar
                    15: Escribir "  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" Sin Saltar
                FinSegun
			FinSi
			Escribir ""
        FinPara
    FinPara
	Escribir "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|"
FinSubAlgoritmo


///############################################################################
///###################### FUNCIONES PARA CASILLAS #############################
///############################################################################

SubAlgoritmo MostrarCasa(linea)
    Segun linea Hacer
        1: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
        2: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
        3: Escribir  "@@%                          @@@|" Sin Saltar
        4: Escribir  "@@%         .=@@@@@@@@@.     @@@|" Sin Saltar
        5: Escribir  "@@%       .#@@+.             @@@|" Sin Saltar
        6: Escribir  "@@%      .@@#.               @@@|" Sin Saltar
        7: Escribir  "@@%      @@                  @@@|" Sin Saltar
        8: Escribir  "@@%      @@-                 @@@|" Sin Saltar
        9: Escribir  "@@%     .@@-                 @@@|" Sin Saltar
        10: Escribir "@@%      %@=                 @@@|" Sin Saltar
        11: Escribir "@@%      =@@-                @@@|" Sin Saltar
        12: Escribir "@@%       :@@%.              @@@|" Sin Saltar
        13: Escribir "@@%         =@@@@@@@@@@.     @@@|" Sin Saltar
        14: Escribir "@@%                          @@@|" Sin Saltar
        15: Escribir "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
    FinSegun
FinSubAlgoritmo

SubAlgoritmo MostrarCereal(linea)
    Segun linea Hacer
        1: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
        2: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
        3: Escribir  "@@%                           @@|" Sin Saltar
        4: Escribir  "@@%       .=@@@@@@@@@.        @@|" Sin Saltar
        5: Escribir  "@@%     .#@@+.        @@      @@|" Sin Saltar
        6: Escribir  "@@%    .@@#.           @@     @@|" Sin Saltar
        7: Escribir  "@@%    @@               @@    @@|" Sin Saltar
        8: Escribir  "@@%    @@-              @@    @@|" Sin Saltar
        9: Escribir  "@@%   .@@-              @@    @@|" Sin Saltar
        10: Escribir "@@%    %@=              @@    @@|" Sin Saltar
        11: Escribir "@@%    =@@-            @@     @@|" Sin Saltar
        12: Escribir "@@%     :@@%.         @@      @@|" Sin Saltar
        13: Escribir "@@%       =@@@@@@@@@@@.       @@|" Sin Saltar
        14: Escribir "@@%                           @@|" Sin Saltar
        15: Escribir "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
    FinSegun
FinSubAlgoritmo

SubAlgoritmo MostrarDetective(linea)
    Segun linea Hacer
        1: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%|" Sin Saltar
        2: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%|" Sin Saltar
        3: Escribir  "@@%                         :@@%|" Sin Saltar
        4: Escribir  "@@%      =@@@@@@@@@@*.      :@@%|" Sin Saltar
        5: Escribir  "@@%      =@%       +@@@.    :@@%|" Sin Saltar
        6: Escribir  "@@%      =@%        .+@@    :@@%|" Sin Saltar
        7: Escribir  "@@%      =@%          @@.   :@@%|" Sin Saltar
        8: Escribir  "@@%      =@%          =@%   :@@%|" Sin Saltar
        9: Escribir  "@@%      =@%          =@#   :@@%|" Sin Saltar
        10: Escribir "@@%      =@%          %@+   :@@%|" Sin Saltar
        11: Escribir "@@%      =@%        .%@#    :@@%|" Sin Saltar
        12: Escribir "@@%      =@%     .=@@@-     :@@%|" Sin Saltar
        13: Escribir "@@%      =@@@@@@@@@+        :@@%|" Sin Saltar
        14: Escribir "@@%                         :@@%|" Sin Saltar
        15: Escribir "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%|" Sin Saltar
    FinSegun
FinSubAlgoritmo

SubAlgoritmo MostrarCafe(linea)
    Segun linea Hacer
        1: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%|" Sin Saltar
        2: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%|" Sin Saltar
        3: Escribir  "@@%                         :@@%|" Sin Saltar
        4: Escribir  "@@%      .%@:     :@@#      :@@%|" Sin Saltar
        5: Escribir  "@@%      .%@:   .%@@.       :@@%|" Sin Saltar
        6: Escribir  "@@%      .%@: .=@@-         :@@%|" Sin Saltar
        7: Escribir  "@@%      .%@:.@@.           :@@%|" Sin Saltar
        8: Escribir  "@@%      .%@%@@.            :@@%|" Sin Saltar
        9: Escribir  "@@%      .%@:@@-            :@@%|" Sin Saltar
        10: Escribir "@@%      .%@: .@@%.         :@@%|" Sin Saltar
        11: Escribir "@@%      .%@:   =@@.        :@@%|" Sin Saltar
        12: Escribir "@@%      .%@:    .%@@:      :@@%|" Sin Saltar
        13: Escribir "@@%      .%@:      :@@%     :@@%|" Sin Saltar
        14: Escribir "@@%                         :@@%|" Sin Saltar
        15: Escribir "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%|" Sin Saltar
    FinSegun
FinSubAlgoritmo

SubAlgoritmo MostrarParque(linea)
    Segun linea Hacer
        1: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
        2: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
        3: Escribir  "@@%                          =@@|" Sin Saltar
        4: Escribir  "@@%        %@@@@@@@%:        =@@|" Sin Saltar
        5: Escribir  "@@%        %@=    -@@@.      =@@|" Sin Saltar
        6: Escribir  "@@%        %@=     .#@#      =@@|" Sin Saltar
        7: Escribir  "@@%        %@=     .#@#      =@@|" Sin Saltar
        8: Escribir  "@@%        %@=     -@@:      =@@|" Sin Saltar
        9: Escribir  "@@%        %@@@@@@@@#.       =@@|" Sin Saltar
        10: Escribir "@@%        %@+:              =@@|" Sin Saltar
        11: Escribir "@@%        %@=               =@@|" Sin Saltar
        12: Escribir "@@%        %@=               =@@|" Sin Saltar
        13: Escribir "@@%        %@=               =@@|" Sin Saltar
        14: Escribir "@@%                          =@@|" Sin Saltar
        15: Escribir "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
    FinSegun
FinSubAlgoritmo

SubAlgoritmo MostrarTestigo(linea)
    Segun linea Hacer
        1: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
        2: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
        3: Escribir  "@@%                          @@@|" Sin Saltar
        4: Escribir  "@@%    :%@@@@@@@@@@@@@@%%:   @@@|" Sin Saltar
        5: Escribir  "@@%            %@=           @@@|" Sin Saltar
        6: Escribir  "@@%            %@=           @@@|" Sin Saltar
        7: Escribir  "@@%            %@=           @@@|" Sin Saltar
        8: Escribir  "@@%            %@=           @@@|" Sin Saltar
        9: Escribir  "@@%            %@=           @@@|" Sin Saltar
        10: Escribir "@@%            %@=           @@@|" Sin Saltar
        11: Escribir "@@%            %@=           @@@|" Sin Saltar
        12: Escribir "@@%            %@=           @@@|" Sin Saltar
        13: Escribir "@@%            %@+           @@@|" Sin Saltar
        14: Escribir "@@%                          @@@|" Sin Saltar
        15: Escribir "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
    FinSegun
FinSubAlgoritmo

SubAlgoritmo MostrarNada(linea)
    Segun linea Hacer
        1: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
        2: Escribir  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
        3: Escribir  "@@%                          @@@|" Sin Saltar
        4: Escribir  "@@%                          @@@|" Sin Saltar
        5: Escribir  "@@%                          @@@|" Sin Saltar
        6: Escribir  "@@%                          @@@|" Sin Saltar
        7: Escribir  "@@%                          @@@|" Sin Saltar
        8: Escribir  "@@%                          @@@|" Sin Saltar
        9: Escribir  "@@%                          @@@|" Sin Saltar
        10: Escribir "@@%                          @@@|" Sin Saltar
        11: Escribir "@@%                          @@@|" Sin Saltar
        12: Escribir "@@%                          @@@|" Sin Saltar
        13: Escribir "@@%                          @@@|" Sin Saltar
        14: Escribir "@@%                          @@@|" Sin Saltar
        15: Escribir "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|" Sin Saltar
    FinSegun
FinSubAlgoritmo

