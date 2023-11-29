import Foundation

//1.    Principio de Responsabilidad Única (SRP):
//    •    Un ejemplo en Swift podría ser tener una clase que gestiona la lógica de presentación y la lógica de red en una aplicación. Sería preferible dividir estas responsabilidades en clases separadas.
//funciones y finalidades unicas no multiples.


//    2.    Principio de Abierto/Cerrado (OCP):
//    •    Imagina una clase en Swift que maneja la generación de informes. En lugar de modificar la clase existente para admitir un nuevo formato de informe, podríamos extenderla creando una nueva clase que implemente la misma interfaz.
//abierta para extenderse pero cerrada para modificarse.

//    3.    Principio de Sustitución de Liskov (LSP):
//    •    Supongamos que tenemos una jerarquía de clases en Swift donde una subclase no puede ser utilizada de manera intercambiable con su clase base sin alterar el comportamiento esperado del programa. Este incumplimiento del principio de Liskov podría llevar a errores sutiles y dificultades en el mantenimiento.
//polimorfismo, aqui nos colaboran los protocolos que nos permite adoptar metodos iguales pero con distinta implementacion segun sean los requerimientos.

//    4.    Principio de Segregación de Interfaces (ISP):
//    •    Si tienes un protocolo en Swift que incluye muchos métodos, pero una clase solo necesita implementar algunos de esos métodos, podrías estar violando el ISP. Dividir el protocolo en protocolos más específicos podría ser una solución.
//relacionado con el primer principio de responsabilidad unica.

//    5.    Principio de Inversión de Dependencias (DIP):
//    •    Un ejemplo en Swift podría ser cambiar de depender directamente de una implementación concreta a depender de un protocolo. Si una clase depende de un protocolo, se vuelve más fácil intercambiar implementaciones y hacer que el código sea más flexible para futuros cambios.
//relacionado con el principio Liskov en donde con protocolos flexibilizamos nuestro codigo sin necesidad de modificar una clase o estructura con cada requerimiento nuevo
