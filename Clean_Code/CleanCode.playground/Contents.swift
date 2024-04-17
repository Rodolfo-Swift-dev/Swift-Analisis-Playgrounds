import UIKit
import XCTest

// MARK:  CLEAN_CODE

// MARK:  1- Nombres significativos

// Bad
let a = 18
// Good
let userAge = 18

// Bad
func calculate(x: Int, y: Int) -> Int {
    return x + y
}
// Good
func adding( a: Int, b: Int) -> Int {
    return a + b
}



// MARK:  2- Funciones divididas

// Bad
func uploadAndDownloadData() {
}

// Good
func uploadData() {
}
func downloadData() {
}



// MARK:  3- Comentarios descriptivos

// Bad
func calculateDiscount(total: Double, discount: Double) -> Double {
    // Aplica descuento
    return total - (total * discount)
}

// Good
func calculatePriceWithDiscount(total: Double, discount: Double) -> Double {
    // Aplica el descuento al precio total
    return total - (total * discount)
}



// MARK:  4- Parametros nombrados de forma correcta

// Bad
func setup(_ text:String, _ subText:String) -> String {
    return ""
}

// Good
func createAlertDialog(withTitle title: String, withMsg message: String) -> String {
    return ""
}



// MARK:  5- Formato consistente

// Bad
func calc(a: Int,b: Int)->Int{
return a*b
}

// Good
func multiply(a: Int, b: Int) -> Int {
    return a * b
}



// MARK: 6- Evitar codigo duplicado. No te repitas (DRY):

func calculateRectangleArea (base: Double, height: Double) -> Double {
    return base * height
}

// Bad
func calculateTriangle(base: Double, height: Double) -> Double {
    return (base * height) / 2
}

// Good
func calculateTriangleArea(area: Double) -> Double {
    return area / 2
}

let area = calculateRectangleArea(base: 10, height: 10)
calculateTriangleArea(area: area)



// MARK: 7- Mantener funciones limpias

// Bad
var counter = 0
func incrementCounter() -> Int {
    counter += 1
    return counter
}
 
// Good
func increment(value: Int) -> Int {
    return value + 1
}



// MARK: 8- Utilizar tipos nativos de Swift

// Bad
let years: NSNumber = 18

// Good
let age: Int = 18


// MARK: 9- Limitar alcance de variables

// Bad
func discountCheck(price: Double) -> Double {
    var discount = 0.0
    if price > 100 {
        discount = 0.1
    }
    return price * (1 - discount)
}

// Good
func applyDiscount(to price: Double) -> Double {
    let discount: Double
    if price > 100 {
        discount = 0.1
    } else {
        discount = 0.0
    }
    return price * (1 - discount)
}



// MARK: 10- Testeo regular y obligatorio

// Good
func testSuma() {
    XCTAssertEqual(adding(a: 2, b: 3), 5)
}



// MARK: 11- Manejo de errores

// Bad
func divided(a: Int, b: Int) -> Int {
    return a / b
}

// Good
enum DivisionError: Error {
    case divisionByZero
}
func division(a: Int, b: Int) throws -> Int {
    guard b != 0 else {
        throw DivisionError.divisionByZero
    }
    return a / b
}



// MARK: 12- Implementacion de dependencias

// Bad
class Men {
    func getId() {
    }
    func sendEmail() {
    }
}

// Good
protocol ManagerEmail {
    func sendEmail()
}
class User {
    let managerEmail: ManagerEmail
    init(managerEmail: ManagerEmail) {
        self.managerEmail = managerEmail
    }
    func sendEmail() {
        managerEmail.sendEmail()
    }
}



// MARK: 13- Abstracciones utiles y adecuadas

// Bad
func areaTriangle(a: Double, b: Double) -> Double {
    return (a * b) / 2
}
func rectanglesArea(a: Double, b: Double) -> Double {
    return a * b
}

// Good
protocol GeometricShape {
    func calculateFigureArea() -> Double
}

struct rectangle: GeometricShape {
    let base: Double
    let height: Double
    
    init(base: Double, height: Double) {
        self.base = base
        self.height = height
    }
    func calculateFigureArea() -> Double {
        return base * height
    }
}

struct triangle: GeometricShape {
    let base: Double
    let height: Double
    
    init(base: Double, height: Double) {
        self.base = base
        self.height = height
    }
    func calculateFigureArea() -> Double {
        return (base * height) / 2
    }
}


struct circumference: GeometricShape {
    let ratio: Double
    let phi = Double.pi
    init(ratio: Double) {
        self.ratio = ratio
    }
    func calculateFigureArea() -> Double {
        return (ratio * ratio) * phi
    }
}



// MARK: 14- Refactorizacion constante

// Bad
func calculateIva(price: Double) -> Double {
    var factor = 0.0
    if price > 100 {
        factor = 0.16
    }
    return price * factor
}

// Good
func calculateTaxIva(price: Double) -> Double {
    let factorTax: Double
    if price > 100 {
        factorTax = 0.16
    } else if price > 50 {
        factorTax = 0.1
    } else {
        factorTax = 0.0
    }
    return price * factorTax
}

