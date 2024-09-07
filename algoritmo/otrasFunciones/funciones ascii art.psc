Algoritmo sin_titulo
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
	
FinAlgoritmo

SubAlgoritmo MostrarCasa(linea)
    Segun linea Hacer
        1: Escribir  ".*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:" Sin Saltar
        2: Escribir  ".*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:" Sin Saltar
        3: Escribir  ".*@@@-                        %@@@:" Sin Saltar
        4: Escribir  ".*@@@-         ..:---:.       %@@@:" Sin Saltar
        5: Escribir  ".*@@@-     ..=@@@@@@@@@.      %@@@:" Sin Saltar
        6: Escribir  ".*@@@-    .-@@@@@++==+%.      %@@@:" Sin Saltar
        7: Escribir  ".*@@@-    -@@@%-              %@@@:" Sin Saltar
        8: Escribir  ".*@@@-    %@@@=               %@@@:" Sin Saltar
        9: Escribir  ".*@@@-   .@@@@:               %@@@:" Sin Saltar
        10: Escribir ".*@@@-    @@@@+               %@@@:" Sin Saltar
        11: Escribir ".*@@@-    -@@@@+              %@@@:" Sin Saltar
        12: Escribir ".*@@@-    .=@@@@@@@@@@@.      %@@@:" Sin Saltar
        13: Escribir ".*@@@-      .=#@@@@@@@%.      %@@@:" Sin Saltar
        14: Escribir ".*@@@-                        %@@@:" Sin Saltar
        15: Escribir ".*@@@%########################@@@@:" Sin Saltar
        16: Escribir ".*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:" Sin Saltar
    FinSegun
FinSubAlgoritmo

SubAlgoritmo MostrarNada(linea)
    Segun linea Hacer
        1: Escribir  ".*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:" Sin Saltar
        2: Escribir  ".*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:" Sin Saltar
        3: Escribir  ".*@@@-                        %@@@:" Sin Saltar
        4: Escribir  ".*@@@-                        %@@@:" Sin Saltar
        5: Escribir  ".*@@@-                        %@@@:" Sin Saltar
        6: Escribir  ".*@@@-                        %@@@:" Sin Saltar
        7: Escribir  ".*@@@-                        %@@@:" Sin Saltar
        8: Escribir  ".*@@@-                        %@@@:" Sin Saltar
        9: Escribir  ".*@@@-                        %@@@:" Sin Saltar
        10: Escribir ".*@@@-                        %@@@:" Sin Saltar
        11: Escribir ".*@@@-                        %@@@:" Sin Saltar
        12: Escribir ".*@@@-                        %@@@:" Sin Saltar
        13: Escribir ".*@@@-                        %@@@:" Sin Saltar
        14: Escribir ".*@@@-                        %@@@:" Sin Saltar
        15: Escribir ".*@@@%########################@@@@:" Sin Saltar
        16: Escribir ".*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:" Sin Saltar
    FinSegun
FinSubAlgoritmo

SubAlgoritmo InicializarTablero(tablero)
	Definir operador Como Entero
	Para i = 0 Hasta 4-1 Con Paso 1
		Para j = 0 Hasta 5-1 Con Paso 1
			operador = FCtoPOS(i, j)
			Segun (operador)
				1: tablero[i, j] = "C"
				2: tablero[i, j] = "N"
				4: tablero[i, j] = "N"
				5: tablero[i, j] = "C"
				7: tablero[i, j] = "N"
				8: tablero[i, j] = "C"
				10: tablero[i, j] = "C"
				11: tablero[i, j] = "C"
				13: tablero[i, j] = "N"
				14: tablero[i, j] = "N"
				15: tablero[i, j] = "C"
				17: tablero[i, j] = "C"
				18: tablero[i, j] = "C"
				De Otro Modo: tablero[i, j] = "N"
			FinSegun
		FinPara
	FinPara
FinSubAlgoritmo

Funcion posicion <- FCtoPOS ( fila, columna )
	posicion = fila * 5 + columna + 1
Fin Funcion

SubAlgoritmo MostrarTablero(tablero)
    Definir linea Como Entero
    
	Para i = 0 Hasta 4-1 Con Paso 1
		Para linea = 1 Hasta 16 Con Paso 1
            Para j = 0 Hasta 5-1 Con Paso 1
                Si tablero[i, j] = "C" Entonces
                    MostrarCasa(linea)
                SiNo
                    MostrarNada(linea)
                FinSi
            FinPara
			Escribir ""
        FinPara
    FinPara
FinSubAlgoritmo