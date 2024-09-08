Proceso sin_titulo

	Escribir '* Ingrese primer número'

	numval <-validarn

	Escribir '* Ingrese segundo número'

	numval2 <-validarn

	sum = numval + numval2

	Escribir sum

FinProceso

SubProceso v<-validarn

	Definir num Como texto

	Definir  validarnum Como Logico

	Definir  validarmenos Como Logico

	sum <- 0

	Repetir

		//Escribir '* Ingrese un número'

		Leer num

		largo<-longitud(num)

		validarnum<-Verdadero;

		contpunto<-0;

		Para i<-0 Hasta largo - 1 con paso 1 Hacer

			numunico<-Subcadena(num,i,i)

			si numunico <>"1" Y numunico <>'2' Y numunico <>'3' Y numunico <>'4' Y numunico <>'5' Y numunico <>'6' Y numunico <>'7' Y numunico <>'8' Y numunico <>'9' entonces

				validarnum = Falso

			FinSi


		FinPara

		Si validarnum=Falso Entonces
			Escribir "ingrese el valor correcto"
		Fin Si

	Hasta Que validarnum=Verdadero 

	v <- ConvertirANumero(num)

FinSubProceso