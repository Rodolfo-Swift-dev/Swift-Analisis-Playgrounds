//Operador ternario
//
//Es una expresión con tres partes:
//condición ? valorSiEsVerdadera : valorSiEsFalsa
//
//La condición debe ser Bool y las dos ramas deben producir tipos compatibles.
//Solo se evalúa la rama elegida, pero ambas ramas son obligatorias: no existe un
//operador ternario “sin else”.

let firstNumber = 8
let secondNumber = 4

let greaterNumber = firstNumber > secondNumber ? firstNumber : secondNumber
print(greaterNumber)

let isAuthenticated = true
let screenTitle = isAuthenticated ? "Inicio" : "Iniciar sesión"
print(screenTitle)

//El ternario funciona mejor para seleccionar valores simples. No conviene utilizarlo
//para mutaciones con resultado Void ni encadenar varias condiciones difíciles de leer.
//Para decisiones con más de dos caminos, if/else o switch expresan mejor la intención.

let score = 82
let grade: String

if score >= 90 {
    grade = "Excelente"
} else if score >= 60 {
    grade = "Aprobado"
} else {
    grade = "Reprobado"
}

print(grade)
