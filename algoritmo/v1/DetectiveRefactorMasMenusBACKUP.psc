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
	
	// Tablero para guardar la posición del asesino
	//Definir tablero_asesino Como Caracter
	//Dimension tablero_asesino[FILAS, COLUMNAS]
	//Definir casillaAsesino Como Entero
	Dimension posAsesino[2]
	inicio_asesino = PosicionInicialAsesino
	POStoFC(inicio_asesino, posAsesino[0], posAsesino[1])
	
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
        Escribir "Seleccione una opción: "
		opPrinc <- validarn
        Segun opPrinc
            1:
				Limpiar Pantalla
				finDelJuego = Falso
				turnosDetective = 4
				intentosArresto = 4
				dia = 1
				asesinatos = 0
				
                InicializarTablero(tablero)
				MovimientoAsesino(tablero, posAsesino, posDetective, asesinatos)
				
				
				Repetir
					//JUEGO DETECTIVE
					Limpiar Pantalla
					//Funciones detective agrupadas
					Detective(tablero, casillaAnterior, posAsesino, posDetective, turnosDetective, intentosArresto, finDelJuego, dia, asesinatos)
					turnosDetective = 3
//					
//					Leer opJugar
//						Segun opJugar
//							1:
//								Limpiar Pantalla
//								//Funciones detective agrupadas
//								turnosDetective = 3
//								Detective(tablero, casillaAnterior, posAsesino, posDetective, turnosDetective, intentosArresto, finDelJuego)
//							3: // Terminar juego
//								opJugar = 3
//								finDelJuego = Verdadero
//								Escribir "Terminando partida..."
//								
//							De Otro Modo:
//								Limpiar Pantalla
//								Escribir "Opción inválida, intente de nuevo."
//						FinSegun
					
					//dia = dia + 1
					//JUEGO ASESINO
					validarFin(arrestoExitoso, intentosArresto, finDelJuego, dia, asesinatos)
					
					Si !finDelJuego
						MovimientoAsesino(tablero, posAsesino, posDetective, asesinatos)
						Escribir "A"
					SiNo 
						Si !arrestoExitoso
							Escribir "PERDISTE... El asesino seguira matando y consumiendo cereales... terrible."
							Esperar Tecla
						SiNo 
							Si arrestoExitoso
								Escribir "GANASTE"
								Esperar Tecla
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
                Escribir "Opción inválida, intente de nuevo."
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

SubAlgoritmo MostrarMenu
    Escribir "1. Jugar"
    Escribir "2. Reglas"
    Escribir "3. Salir"
FinSubAlgoritmo

SubAlgoritmo MostrarReglas()
	
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

///Funcion para validar si finaliza por arresto exitoso o por quedarse sin intentos
SubAlgoritmo validarFin(arrestoExitoso Por Referencia, intentosArresto Por Referencia, finDelJuego Por Referencia, dia Por Referencia, asesinatos Por Referencia)
	Si dia <= 7 Entonces
		Si (intentosArresto = 0 y !finDelJuego) o (asesinatos = 6 y !finDelJuego) Entonces
			arrestoExitoso = Falso
			finDelJuego = Verdadero
		SiNo 
			Si finDelJuego	
				arrestoExitoso = Verdadero
			FinSi
		FinSi
		
		dia = dia + 1
	SiNo
		finDeljuego = Verdadero
		arrestoExitoso = Falso
	FinSi
	
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
    // Colocar al jugador "D" en la nueva posición
    tablero[posDetective[0], posDetective[1]] = "D"
FinSubAlgoritmo

SubAlgoritmo GuardarCasillaAnterior(casillaAnterior Por Referencia, tablero, posDetective)
	// Restaurar la casilla anterior con el valor original
	Definir i,j como entero
	
    Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1
            Si tablero[i, j] = "D" Entonces
                tablero[i, j] = casillaAnterior  // Restauramos el valor que había antes de colocar el jugador
				i = 3
				j = 4
            FinSi
        FinPara
    FinPara
    // Guardar lo que había en la nueva posición antes de colocar al jugador
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
		MostrarTablero(tablero)
		Escribir "Elija un cafe para empezar:"
		Escribir "Q. Cafe en la posicion 7 del tablero"
		Escribir "E. Cafe en la posicion 14 del tablero"
		Leer opcionMovimiento
		
		Si opcionMovimiento = "q" o opcionMovimiento = "Q"
			posDetective[0] = 1
			posDetective[1] = 1
		SiNo
			Si opcionMovimiento = 'e' o opcionMovimiento = 'E' //Valido con el si para que no se ejecute el ubicado del jugador en tablero de forma innecesaria
				posDetective[0] = 2
				posDetective[1] = 3
			FinSi
		FinSi
		Limpiar Pantalla
	Hasta Que opcionMovimiento = 'Q' o opcionMovimiento = 'q' o opcionMovimiento = 'E' o opcionMovimiento = 'e'
	
	ubicarJugadorEnTablero(tablero, casillaAnterior, posDetective)
FinSubAlgoritmo

///############################################################################
///########################### MOVER DETECTIVE ################################
///############################################################################

SubAlgoritmo MoverDetective(tablero Por Referencia, casillaAnterior Por Referencia, posAsesino, posDetective Por Referencia, turnosDetective Por Referencia, intentosArresto Por Referencia, finDelJuego Por Referencia, diaActual Por Referencia, asesinatos)
	Definir opcionMovimiento como caracter
	
	Si turnosDetective = 4 Entonces
		ElegirCafe(tablero, casillaAnterior, posDetective)
		turnosDetective = turnosDetective - 1
	FinSi
	
	fila = posDetective[0]
	colum = posDetective[1]
	ubicarJugadorEnTablero(tablero, casillaAnterior, posDetective)
	MostrarTablero(tablero)
	
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
		Escribir "Turnos restantes: ", turnosDetective
		Escribir "Intentos de arresto restantes: ", intentosArresto
		Escribir "Asesinatos: ", asesinatos
		Escribir "Dia numero: ", diaActual
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
					Escribir "¡Asesino arrestado! El juego ha terminado." //PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
					intentosArresto = intentosArresto - 1
					
					Si intentosArresto = 0
						Escribir "Te quedaste sin intentos de arresto"
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
		
		MostrarTablero(tablero)
	Hasta Que finDelJuego o turnosDetective = 0 o intentosArresto = 0
	
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

SubAlgoritmo Arrestar(posAsesino, posDetective, turnos Por Referencia, intentosArresto Por Referencia, finDelJuego Por Referencia, tablero)
    Definir op Como Caracter
	
	Si intentosArresto > 0 Entonces
		Repetir
			Escribir "Seleccione una casilla para intentar arrestar (X para volver atras):"
			Escribir "W. Arriba"
			Escribir "S. Abajo"
			Escribir "A. Izquierda"
			Escribir "D. Derecha"
			Escribir "Q. Misma Casilla"
			Escribir "X. Volver"
			
			///ESCRIBIR PARA PRUEBAS
			Escribir "Posicion asesino: ", FCtoPOS(posAsesino[0], posAsesino[1])
			Escribir "Posicion detective: ", FCtoPOS(posDetective[0], posDetective[1])
			Leer op
			
			// Intento de arresto basado en la selección del jugador
			Segun op Hacer
				'w' o 'W': // Arriba
					Si posDetective[0] - 1 = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
						Escribir "¡Asesino arrestado! El juego ha terminado." //PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
						finDelJuego = Verdadero
					SiNo
						Escribir "Fallaste el arresto."
					FinSi
					
				's' o 'S': // Abajo
					Si posDetective[0] + 1 = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
						Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
						finDelJuego = Verdadero
					SiNo
						Escribir "Fallaste el arresto."
					FinSi
					
				'a' o 'A': // Izquierda
					Si posDetective[0] = posAsesino[0] y posDetective[1] - 1 = posAsesino[1] Entonces
						Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
						finDelJuego = Verdadero
					SiNo
						Escribir "Fallaste el arresto."
					FinSi
					
				'd' o 'D': // Derecha
					Si posDetective[0] = posAsesino[0] y posDetective[1] + 1 = posAsesino[1] Entonces
						Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
						finDelJuego = Verdadero
					SiNo
						Escribir "Fallaste el arresto."
					FinSi
					
				'q' o 'Q': // Misma casilla
					Si posDetective[0] = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
						Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
						finDelJuego = Verdadero
					SiNo
						Escribir "Fallaste el arresto."
					FinSi
				De Otro Modo:
					Escribir "Opcion invalida"
			FinSegun
			
			// Restar un intento de arresto solo si la opcion elegida fue para moverse
			///TERMINAR VALIDACION
			Si op = 'w' o op = 'W' o op = 'a' o op = 'A' o op = 's' o op = 'S'
				intentosArresto = intentosArresto - 1
			FinSi
			
			Si intentosArresto = 0
				finDelJuego = Verdadero
			FinSi
			
			Si !finDeljuego
				Limpiar Pantalla
				MostrarTablero(tablero)
				Escribir "Intentos de arresto restantes: ", intentosArresto
			FinSi
			
			
		Hasta Que op = 'x' o op = 'X' o finDelJuego = Verdadero
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

// Función para darle posición inicial al asesino
Funcion inicio_asesino <- PosicionInicialAsesino
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
	inicio_asesino = FCtoPOS(fila, columna)
FinFuncion

///############################################################################
///################# FUNCION DE MOVIMIENTO PARA EL ASESINO ####################
///############################################################################

// Función para el movimiento del asesino
SubAlgoritmo MovimientoAsesino(tablero Por Referencia, posAsesino Por Referencia, posDetective, asesinatos Por Referencia)
	Definir casaSeleccionada Como Logico
	Definir posCasa, movimientosRestantesAsesino, limite Como Entero
	limite = 25
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
			tableroAux[posCasa[0], posCasa[1]] = 'X'
		FinSi
		
		limite = limite - 1
		
		Si limite = 0
			Escribir "limite alcanzado, evaluacion ", evaluacion, " posicion ", FCtoPOS(posAsesino[0], posAsesino[1])
		FinSi
		
		
	Mientras Que casaSeleccionada = Falso
	
	tablero[posCasa[0], posCasa[1]] = 'O'
	asesinatos = asesinatos + 1
	
	posAsesino[0] = posCasa[0]
	posAsesino[1] = posCasa[1]
	
FinSubAlgoritmo

SubAlgoritmo clonarTableroaAux(tableroAux Por Referencia, tablero) 
	Para i = 0 Hasta 4-1 Con Paso 1
		Para j = 0 Hasta 5-1 Con Paso 1
			tableroAux[i,j] = tablero[i,j]
		FinPara
	FinPara
FinSubAlgoritmo

/////############################################################################
///############ FUNCION PARA EVALUAR CASA MAS CERCANA AL ASESINO ##############
///############################################################################

SubAlgoritmo casaMasCercana(posEntidad, posCasa Por Referencia, tableroAux Por Referencia, tablero)
    Definir dist, distMen Como Entero
	distMen = 12
	casasDisponibles = 0
    Definir rand Como Entero
    Dimension posCasaAux[2]
	
    Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1	
            Si tableroAux[i, j] = "C"
				casasDisponibles = casasDisponibles + 1
//				Escribir "casa disponible en pos ", FCtoPos(i, j)
//				Esperar Tecla
				
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

///REVISAR QUE CAUSA QUE EVALUACION SE MANTENGA EN FALSO (POSIBLE BUCLE INFINITO)
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
		
		//Escribir "Estoy aca, mov ", movimientosRestantes, " posASesino ", asesino_temp[1], " posCasa", posCasa[1]
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
			
			// Si el asesino llegó a la casa
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

///SUMAR MENU, DIAS Y ASESINATOS AL MOSTRAR
SubAlgoritmo MostrarTablero(tablero Por Referencia)
    Definir linea Como Entero
	Para i = 0 Hasta 4-1 Con Paso 1
		Para linea = 1 Hasta 15 Con Paso 1
            Para j = 0 Hasta 5-1 Con Paso 1
				si tablero[i, j] = 'D' Entonces
					MostrarDetective(linea)
				SiNo
					Segun tablero[i, j] Hacer
						Caso 'C' o 'O': //CASO CASA
							MostrarCasa(linea)
							//Caso 'O':
							//	MostrarCereal(linea)
						Caso 'D':
							MostrarDetective(linea)
						Caso 'P':
							MostrarParque(linea)
						Caso 'K':
							MostrarCafe(linea)
						De Otro Modo:
							MostrarNada(linea)
					FinSegun
				FinSi
            FinPara
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



//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@=                          @@
//@@:                          @@
//@@:       +@@@@@@@@@%        @@
//@@:     @@@%:      *@@@.     @@
//@@:    @@#           :@@*    @@
//		@@:   @@=              @@=   @@
//		@@:  +@@               =@@   @@
//		@@:  *@@               =@@   @@
//		@@:   @@               @@*   @@
//		@@:   -@@:            @@@    @@
//			@@:    .@@@-        %@@*     @@
//			@@:      .@@@@@@@@@@@+       @@
//			@@:                          @@
//			@@:                          @@
//				@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
