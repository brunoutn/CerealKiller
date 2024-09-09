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
	Definir tablero_asesino Como Caracter
	Dimension tablero_asesino[FILAS, COLUMNAS]
	
	Definir cantTurnos, empezoJuego Como Entero
	cantTurnos = 3
	empezoJuego = 1
	Definir fila, colum, posDetective Como Entero
	
	Repetir
        MostrarMenu()
        Escribir "Seleccione una opción: "
		opPrinc <- validarn
        Segun opPrinc
            1:
                InicializarTablero(tablero)
                MostrarTablero(tablero)
				
                Repetir
					Si empezoJuego = 1
						ElegirCafe(tablero, fila, colum)
					FinSi
					
					empezoJuego = 0
                    MostrarMenuJugar()
                    Escribir "Seleccione una opción: "
                    opJugar <- validarn
					
                    Segun opJugar
                        1:
							Escribir "Opción Mover seleccionada."
							Escribir "Turnos restantes: ", cantTurnos
							MoverDetective(cantTurnos, tablero, fila, colum, empezoJuego)
                        2: 	
							Arrestar(posAsesino, posDetective, intentosRestantes)
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

SubAlgoritmo MostrarMenuJugar
    Escribir "1. Mover"
    Escribir "2. Arrestar"
    Escribir "3. Terminar"
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


///############################################################################
///############### ACA EMPIEZAN LAS FUNCIONES DEL DETECTIVE ###################
///############################################################################

SubAlgoritmo ElegirCafe(tablero por referencia, fila Por Referencia, colum Por Referencia)
	Definir opcionMovimiento Como Caracter
	
	Repetir
		Escribir "Elija un cafe para empezar:"
		Escribir "Q. Cafe en la posicion 7 del tablero"
		Escribir "E. Cafe en la posicion 14 del tablero"
		Leer opcionMovimiento
			
		Si opcionMovimiento = "q" o opcionMovimiento = "Q"
			fila = 1
			colum = 1
			Limpiar Pantalla
			ubicarJugadorEnTablero(tablero, fila, colum, casillaAnterior)
		SiNo
			Si opcionMovimiento = 'e' o opcionMovimiento = 'E' //Valido con el si para que no se ejecute el ubicado del jugador en tablero de forma innecesaria
				fila = 2
				colum = 3
				Limpiar Pantalla
				ubicarJugadorEnTablero(tablero, fila, colum, casillaAnterior)
			FinSi
		FinSi
			
	Hasta Que opcionMovimiento = 'Q' o opcionMovimiento = 'q' o opcionMovimiento = 'E' o opcionMovimiento = 'e'
		
	MostrarTablero(tablero)
FinSubAlgoritmo

///############################################################################
///########################### MOVER DETECTIVE ################################
///############################################################################

SubAlgoritmo MoverDetective(cantTurnos, tablero, fila por referencia, colum por referencia, empezoJuego)
	Definir opcionMovimiento, casillaAnterior Como Caracter
	casillaAnterior <- "N"
	
	Si cantTurnos <= 3 Entonces
		Repetir
			Escribir "W. Arriba"
			Escribir "S. Abajo"
			Escribir "D. Derecha"
			Escribir "A. Izquierda"
			Escribir "X. Finalizar turno"
			
			Leer opcionMovimiento
			
			Segun opcionMovimiento Hacer
				'w' o 'W': 
					Si fila - 1 >= 0 Entonces
						fila = fila - 1
						ubicarJugadorEnTablero(tablero, fila, colum, casillaAnterior)
						Limpiar Pantalla
						MostrarTablero(tablero)
						cantTurnos = cantTurnos - 1
					FinSi
				's' o 'S': 
					Si fila + 1 <= 3 Entonces
						fila = fila + 1
						ubicarJugadorEnTablero(tablero, fila, colum, casillaAnterior)
						Limpiar Pantalla
						MostrarTablero(tablero)
						cantTurnos = cantTurnos - 1
					FinSi
				'd' o 'D':
					Si colum + 1 <= 4 Entonces
						colum = colum + 1
						ubicarJugadorEnTablero(tablero, fila, colum, casillaAnterior)
						Limpiar Pantalla
						MostrarTablero(tablero)
						cantTurnos = cantTurnos - 1
					FinSi
				'a' o 'A': 
					Si colum - 1 >= 0 Entonces
						colum = colum - 1
						ubicarJugadorEnTablero(tablero, fila, colum, casillaAnterior)
						Limpiar Pantalla
						MostrarTablero(tablero)
						cantTurnos = cantTurnos - 1
					FinSi
				'x' o 'X':
					Limpiar Pantalla
					cantTurnos = 0
				De Otro Modo:
					Escribir "Input incorrecto, vuelva a ingresar"
			FinSegun
		Hasta Que cantTurnos == 0
		GuardarCasillaAnterior(casillaAnterior, tablero, fila, colum)
	FinSi
	
FinSubAlgoritmo


SubAlgoritmo ubicarJugadorEnTablero(tablero, fila, colum, casillaAnterior Por Referencia)
	GuardarCasillaAnterior(casillaAnterior, tablero, fila, colum)
    // Colocar al jugador "D" en la nueva posición
    tablero[fila, colum] = "D"
FinSubAlgoritmo

SubAlgoritmo GuardarCasillaAnterior(casillaAnterior Por Referencia, tablero, fila, colum)
	// Restaurar la casilla anterior con el valor original
    Para i = 0 Hasta 4-1 Con Paso 1
        Para j = 0 Hasta 5-1 Con Paso 1
            Si tablero[i, j] = "D" Entonces
                tablero[i, j] = casillaAnterior  // Restauramos el valor que había antes de colocar el jugador
            FinSi
        FinPara
    FinPara
	
    // Guardar lo que había en la nueva posición antes de colocar al jugador
    casillaAnterior = tablero[fila, colum]
FinSubAlgoritmo


///############################################################################
///############### ACA EMPIEZA LA FUNCION DE ARRESTAR ASESINO #################
///############################################################################

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

///FUNCION PARA CALCULAR DISTANCIA ENTRE POSICIONES
Funcion cantMovimientos <- DistanciaEntre(A, B)
	cantMovimientos = Abs(A[0] - B[0]) + Abs(A[1] - B[1])
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


SubAlgoritmo MostrarTablero(tablero)
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
///################### FUNCIONES PARA ESCRIBIR LETRAS #########################
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
