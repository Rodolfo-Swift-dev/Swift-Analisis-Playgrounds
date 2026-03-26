# 🤝 Contributing to Swift-Analisis-Playgrounds

¡Gracias por tu interés en contribuir! Este documento proporciona lineamientos para contribuir al proyecto.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [¿Cómo Puedo Contribuir?](#cómo-puedo-contribuir)
- [Guía de Estilo](#guía-de-estilo)
- [Proceso de Pull Request](#proceso-de-pull-request)
- [Reportar Bugs](#reportar-bugs)
- [Sugerir Mejoras](#sugerir-mejoras)

## 📜 Código de Conducta

Este proyecto y todos sus participantes están regidos por un código de conducta. Al participar, se espera que mantengas este código. Por favor reporta comportamientos inaceptables.

### Nuestros Estándares

- ✅ Ser respetuoso con diferentes puntos de vista
- ✅ Aceptar críticas constructivas
- ✅ Enfocarse en lo mejor para la comunidad
- ✅ Mostrar empatía hacia otros miembros

## 🎯 ¿Cómo Puedo Contribuir?

### 1. Reportar Bugs

Si encuentras un bug:

1. Verifica que no haya sido reportado anteriormente
2. Crea un issue con una descripción clara
3. Incluye pasos para reproducir el bug
4. Agrega screenshots si es posible
5. Especifica tu versión de Xcode y Swift

**Template para Bug Report:**

```markdown
**Descripción del Bug**
Descripción clara y concisa del bug.

**Pasos para Reproducir**
1. Ir a '...'
2. Ejecutar '...'
3. Ver error

**Comportamiento Esperado**
Qué esperabas que sucediera.

**Comportamiento Actual**
Qué sucedió en realidad.

**Screenshots**
Si aplica, agrega screenshots.

**Entorno:**
- Xcode: [ej. 15.0]
- Swift: [ej. 5.9]
- macOS: [ej. Sonoma 14.0]
```

### 2. Sugerir Mejoras

Para sugerir nuevas features:

1. Verifica que no exista ya como issue
2. Crea un issue describiendo la mejora
3. Explica por qué sería útil
4. Proporciona ejemplos de uso

### 3. Contribuir Código

#### Tipos de Contribuciones Bienvenidas

- 📝 **Nuevos Playgrounds**: Conceptos no cubiertos aún
- 🔧 **Mejoras a Playgrounds Existentes**: Agregar ejemplos, mejorar explicaciones
- 🐛 **Corrección de Errores**: Fix typos, errores de sintaxis
- 📚 **Documentación**: Mejorar README, agregar comentarios
- 🌍 **Traducciones**: Traducir a otros idiomas
- ✨ **Actualizar a Swift Moderno**: Usar últimas features de Swift

## 🎨 Guía de Estilo

### Swift Code Style

Seguimos las convenciones de [Swift.org API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)

#### Nombres

```swift
// ✅ Good
func calculateTotalPrice(items: [Item]) -> Double { }
let userName = "John"
class UserProfileViewController { }

// ❌ Bad
func calc(i: [Item]) -> Double { }
let un = "John"
class usrPrfVC { }
```

#### Comentarios

```swift
// ✅ Good - Comentarios descriptivos en español
// Calcula el precio total aplicando descuentos
func calculateDiscountedPrice(price: Double, discount: Double) -> Double {
    return price * (1 - discount)
}

// ❌ Bad - Comentarios vagos o en spanglish
// calcular precio
func calc(p: Double, d: Double) -> Double {
    return p * (1 - d)
}
```

#### Estructura de Playground

```swift
import Foundation

// MARK: - Título del Tema

/*
 Descripción general del concepto
 - Punto clave 1
 - Punto clave 2
 */

// MARK: Ejemplo 1: Descripción

// Código ejemplo con comentarios

// MARK: Ejemplo 2: Descripción

// Más código ejemplo
```

### Documentación

- Usa español para comentarios y documentación
- Sé claro y conciso
- Incluye ejemplos prácticos
- Usa MARK para organizar secciones

### Commits

Formato de commit messages:

```
<tipo>(<alcance>): <descripción>

[cuerpo opcional]

[footer opcional]
```

**Tipos:**
- `feat`: Nueva feature
- `fix`: Bug fix
- `docs`: Cambios en documentación
- `style`: Formateo, falta de punto y coma, etc.
- `refactor`: Refactorización de código
- `test`: Agregar tests
- `chore`: Actualizar dependencias, etc.

**Ejemplos:**

```bash
feat(closures): add advanced closure examples
fix(optionals): correct nil coalescing example
docs(readme): update installation instructions
refactor(solid): improve LSP explanation
```

## 🔄 Proceso de Pull Request

### Antes de Crear el PR

1. **Fork** el repositorio
2. **Clone** tu fork localmente
3. **Crea una rama** desde `main`:
   ```bash
   git checkout -b feature/my-new-feature
   ```
4. **Haz tus cambios** siguiendo la guía de estilo
5. **Commits** siguiendo el formato establecido
6. **Prueba** que todo funcione correctamente
7. **Push** a tu fork:
   ```bash
   git push origin feature/my-new-feature
   ```

### Crear el Pull Request

1. Ve a la página del repositorio original
2. Haz click en "New Pull Request"
3. Selecciona tu rama
4. Completa la plantilla del PR:

```markdown
## Descripción
Descripción clara de los cambios realizados.

## Tipo de Cambio
- [ ] Bug fix
- [ ] Nueva feature
- [ ] Breaking change
- [ ] Documentación

## ¿Cómo se ha Testeado?
Describe las pruebas realizadas.

## Checklist
- [ ] Mi código sigue la guía de estilo
- [ ] He agregado comentarios explicativos
- [ ] He actualizado la documentación
- [ ] Mis cambios no generan nuevos warnings
- [ ] He probado que todo funcione correctamente
```

### Después de Crear el PR

- Espera la revisión
- Responde a comentarios y sugerencias
- Realiza cambios solicitados
- Una vez aprobado, tu PR será merged

## 🐛 Reportar Bugs

### Antes de Reportar

1. ✅ Verifica que estás usando la última versión
2. ✅ Busca en issues existentes
3. ✅ Recolecta información sobre el bug

### Al Reportar

- Usa un título claro y descriptivo
- Describe los pasos exactos para reproducir
- Incluye el comportamiento esperado vs actual
- Agrega screenshots o logs si es posible
- Menciona tu entorno (Xcode, Swift, macOS)

## 💡 Sugerir Mejoras

### Formato de Sugerencia

```markdown
**¿Tu sugerencia está relacionada con un problema?**
Descripción clara del problema.

**Describe la solución que te gustaría**
Descripción clara de lo que quieres que suceda.

**Describe alternativas consideradas**
Otras soluciones o features consideradas.

**Contexto Adicional**
Cualquier otro contexto sobre la feature.
```

## 📞 Contacto

Si tienes preguntas sobre cómo contribuir:

- 📧 Abre un issue con la etiqueta `question`
- 💬 Comenta en issues o PRs existentes

---

## 🙏 Agradecimientos

¡Gracias por contribuir a Swift-Analisis-Playgrounds! Cada contribución, sin importar cuán pequeña sea, es valiosa.

---

<div align="center">

**Happy Coding! 🚀**

</div>
