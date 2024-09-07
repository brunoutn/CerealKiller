Algoritmo sin_titulo
	
	Dimension posAsesino[2]
	Dimension posAsesino[2]
	
FinAlgoritmo

SubAlgoritmo Arrestar(posAsesino, posDetective, intentosRestantes Por Referencia, opcionMenuJugar Por Referencia)
    Definir op Como Entero
    Repetir
        Escribir "Seleccione una casilla para intentar arrestar (o 6 para salir):"
        Escribir "1. Arriba"
        Escribir "2. Abajo"
        Escribir "3. Izquierda"
        Escribir "4. Derecha"
        Escribir "5. Misma Casilla"
        Escribir "6. Salir"
        Leer op
		si op < 1 o op > 6 Entonces
			Escribir "Ingrese una opcion valida"
		FinSi
	Hasta Que op >= 1 y op <= 6
	
	Si op >= 1 y op <= 5 Entonces
		// Intento de arresto basado en la selección del jugador
		Segun op Hacer
			1: // Arriba
				Si posDetective[0] - 1 = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
					Escribir "¡Asesino arrestado! El juego ha terminado." //PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
				FinSi
				
			2: // Abajo
				Si posDetective[0] + 1 = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
					Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
				FinSi
				
			3: // Izquierda
				Si posDetective[0] = posAsesino[0] y posDetective[1] - 1 = posAsesino[1] Entonces
					Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
				FinSi
				
			4: // Derecha
				Si posDetective[0] = posAsesino[0] y posDetective[1] + 1 = posAsesino[1] Entonces
					Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
				FinSi
				
			5: // Misma casilla
				Si posDetective[0] = posAsesino[0] y posDetective[1] = posAsesino[1] Entonces
					Escribir "¡Asesino arrestado! El juego ha terminado."//PLACEHOLDER: ARMAR FUNCIONES CORRECTAMENTE PARA GANAR EL JUEGO
				SiNo
					Escribir "Fallaste el arresto."
				FinSi
				
		FinSegun
		
		// Restar un intento de arresto
		intentosRestantes = intentosRestantes - 1
		
		opcionMenuJugar = 3
		
	SiNo
		opcionMenuJugar = 4
	FinSi
	
FinSubAlgoritmo

Funcion cantMovimientos <- DistanciaEntre(A, B)
	cantMovimientos = Abs(A[0] - B[0]) + Abs(A[1] - B[1])
FinFuncion
	