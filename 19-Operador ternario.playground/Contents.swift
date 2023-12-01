import Foundation


var number1 = 2
var number2 = 4
var number3 = 2
var number4 = 6
 
//operador ternario
var result1: () = (number1 == number3) ? (number1 = 6) : (number2 = 2)
print(number1)
//operador ternario multiple consultas
var result2: () = (number1 == number3) ? (number1 = 6) : (number2 == number3) ? (number3 = 6) : (number2 = 2)


//operador ternario sin else
var result3: () = (number1 == number3) ? (number1 = 6) : ()

