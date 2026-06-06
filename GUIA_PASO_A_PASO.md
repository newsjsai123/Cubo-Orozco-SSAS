# 📘 GUÍA PASO A PASO - Proyecto SSAS Cubo_Orozco

## 🎯 Examen: Analítica de Sistemas Empresariales (NRC 7041)

**Alumno:** OROZCO  
**Visual Studio:** 2019  
**Tiempo estimado:** 30-40 minutos

---

## 📋 ÍNDICE

1. [Requisitos previos](#-requisitos-previos)
2. [PASO 1: Crear la base de datos](#-paso-1-crear-la-base-de-datos)
3. [PASO 2: Crear el proyecto SSAS](#-paso-2-crear-el-proyecto-ssas)
4. [PASO 3: Crear el Data Source](#-paso-3-crear-el-data-source-15-pts)
5. [PASO 4: Crear el Data Source View](#-paso-4-crear-el-data-source-view-15-pts)
6. [PASO 5: Crear la Dimensión Producto](#-paso-5-crear-la-dimensión-producto-37-pts)
7. [PASO 6: Crear la Dimensión Empleado](#-paso-6-crear-la-dimensión-empleado-37-pts)
8. [PASO 7: Crear la Dimensión Tiempo](#-paso-7-crear-la-dimensión-tiempo-36-pts)
9. [PASO 8: Crear el Cubo + Medidas](#-paso-8-crear-el-cubo--medidas-6-pts)
10. [PASO 9: Procesar y desplegar](#-paso-9-procesar-y-desplegar)
11. [PASO 10: Comprimir y entregar](#-paso-10-comprimir-y-entregar)

---

## ✅ REQUISITOS PREVIOS

Antes de empezar, asegúrate de tener:

- ✅ **SQL Server** (Express, Developer, etc.) corriendo en `localhost`
- ✅ **SQL Server Management Studio (SSMS)**
- ✅ **SQL Server Analysis Services** instalado en modo **Multidimensional**
- ✅ **Visual Studio 2019** Community o superior
- ✅ **Extensión SSDT - Microsoft Analysis Services Projects**

### 🔧 Instalar la extensión SSDT en Visual Studio 2019:

1. Abre **Visual Studio 2019**
2. Menú: `Extensions` → `Manage Extensions`
3. Pestaña `Online` → Buscar: **"Microsoft Analysis Services Projects"**
4. Clic en **Download**
5. **Cerrar Visual Studio** → Se instalará automáticamente
6. Reabrir Visual Studio

> 💡 También puedes descargarla aquí: https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftAnalysisServicesModelingProjects

---

## 📊 PASO 1: Crear la base de datos

1. Abrir **SQL Server Management Studio (SSMS)**
2. Conectar a `localhost`
3. Clic en **New Query** (Nueva consulta)
4. Abrir el archivo: `SQL/01_Crear_NorthwindMart.sql`
5. Copiar todo el contenido y pegarlo en la consulta
6. Presionar **F5** para ejecutar
7. Esperar ~30 segundos

**Resultado esperado:**
```
Tabla            Registros
---------------- ---------
Category_Dim     8
Product_Dim      30
Employee_Dim     9
Time_Dim         1096
Sales_Fact       2000

OK Base de datos NorthwindMart creada exitosamente!
```

---

## 🆕 PASO 2: Crear el proyecto SSAS

1. Abrir **Visual Studio 2019**
2. Menú: `File` → `New` → `Project...`
3. En el buscador escribe: **"Analysis Services"**
4. Selecciona: **"Analysis Services Multidimensional and Data Mining Project"**
5. Clic en **Next**
6. Configurar:
   - **Project name:** `Cubo_Orozco`
   - **Location:** Donde quieras (ej: `C:\Proyectos\`)
   - **Solution name:** `Cubo_Orozco` (se llena automáticamente)
7. Clic en **Create**

✅ **Resultado:** Se abre el proyecto vacío con el Solution Explorer mostrando:
```
📁 Cubo_Orozco
   📁 Data Sources
   📁 Data Source Views
   📁 Cubes
   📁 Dimensions
   📁 Mining Structures
   📁 Roles
   📁 Assemblies
   📁 Miscellaneous
```

---

## 🗄️ PASO 3: Crear el Data Source (1.5 pts)

1. En el **Solution Explorer**, clic derecho en **`Data Sources`** → **`New Data Source...`**
2. Clic en **Next** (en la pantalla de bienvenida)
3. Clic en **New...** (para crear una nueva conexión)

### Configurar la conexión:

| Campo | Valor |
|-------|-------|
| **Provider** | `Native OLE DB\SQL Server Native Client 11.0` |
| **Server name** | `localhost` |
| **Log on to the server** | Use Windows Authentication |
| **Select or enter a database name** | `NorthwindMart` |

4. Clic en **Test Connection** → Debe decir **"Test connection succeeded"** ✅
5. Clic en **OK**
6. La conexión aparece en la lista → Clic en **Next**

### Configurar la suplantación (Impersonation):

7. Seleccionar: **"Use the service account"**
8. Clic en **Next**
9. Nombre del Data Source: **`NorthwindMart`** (debe quedar exactamente así)
10. Clic en **Finish**

✅ **Resultado:** Aparece `NorthwindMart.ds` en la carpeta `Data Sources`.

---

## 👁️ PASO 4: Crear el Data Source View (1.5 pts)

1. Clic derecho en **`Data Source Views`** → **`New Data Source View...`**
2. Clic en **Next**
3. Seleccionar el Data Source: **`NorthwindMart`** → **Next**
4. **Mover las siguientes tablas a la derecha** (con el botón `>`):
   - ✅ `Category_Dim`
   - ✅ `Product_Dim`
   - ✅ `Employee_Dim`
   - ✅ `Time_Dim`
   - ✅ `Sales_Fact`
5. Clic en **Next**
6. Nombre: **`NorthwindMart DSV`**
7. Clic en **Finish**

✅ **Resultado:** Se abre el diagrama con las 5 tablas y sus relaciones (líneas conectoras).

> 💡 **Tip:** Si las relaciones no aparecen, las tablas tienen FK definidas en el script SQL, así que deberían aparecer automáticamente.

---

## 🛒 PASO 5: Crear la Dimensión Producto (3.7 pts)

1. Clic derecho en **`Dimensions`** → **`New Dimension...`**
2. Clic en **Next**
3. Seleccionar: **"Use an existing table"** → **Next**
4. Configurar:
   - **Data source view:** `NorthwindMart DSV`
   - **Main table:** `Product_Dim`
   - **Key columns:** `ProductID`
   - **Name column:** `ProductName`
5. Clic en **Next**

### Seleccionar tablas relacionadas:

6. **Marcar también:** `Category_Dim` ✅
7. Clic en **Next**

### Seleccionar atributos:

8. Marcar los siguientes atributos y **renombrarlos** en la columna `Attribute Name`:

| Source Column | Attribute Name |
|---------------|----------------|
| `Product ID` (ya viene marcado como key) | `Producto ID` |
| `Product Name` ✅ | **`ProductoNombre`** |
| `Category Name` (de Category_Dim) ✅ | **`CategoriaNombre`** |

9. Clic en **Next**
10. Nombre de la dimensión: **`Producto`**
11. Clic en **Finish**

✅ Se abre el **Dimension Designer**.

### 🌲 Crear la jerarquía `categoria_producto`:

1. En el panel central (Hierarchies), **arrastrar** el atributo **`CategoriaNombre`** desde el panel izquierdo (Attributes)
2. Debajo, arrastrar **`ProductoNombre`**
3. Hacer **clic derecho** en el título de la jerarquía (dice "Hierarchy") → **Rename** → escribir: **`categoria_producto`**

✅ Resultado visual:
```
🌲 categoria_producto
   ├── CategoriaNombre
   └── ProductoNombre
```

### 🔗 Configurar Attribute Relationships (importante para evitar warnings):

1. Clic en la pestaña **`Attribute Relationships`** (parte superior del designer)
2. Clic derecho en **`ProductoNombre`** → **New Attribute Relationship...**
3. Configurar:
   - **Source Attribute:** `ProductoNombre`
   - **Related Attribute:** `CategoriaNombre`
4. Clic en **OK**

5. **Guardar:** `Ctrl + S`

✅ **Resultado:** Dimensión Producto creada con su jerarquía.

---

## 👤 PASO 6: Crear la Dimensión Empleado (3.7 pts)

1. Clic derecho en **`Dimensions`** → **`New Dimension...`**
2. **Next** → "Use an existing table" → **Next**
3. Configurar:
   - **Main table:** `Employee_Dim`
   - **Key columns:** `EmployeeID`
   - **Name column:** `FullName`
4. **Next**
5. (No marcar tablas relacionadas) → **Next**

### Seleccionar atributos:

| Source Column | Attribute Name |
|---------------|----------------|
| `Employee ID` (key) | `Empleado ID` |
| `Country` ✅ | **`País`** |
| `City` ✅ | **`Ciudad`** |
| `Region` ✅ | **`Región`** |
| `Full Name` ✅ | **`Nombre Completo`** |

6. **Next**
7. Nombre: **`Empleado`**
8. **Finish**

### 🌲 Crear la jerarquía `empleado_pais`:

1. Arrastrar **`País`** al panel Hierarchies
2. Debajo, arrastrar **`Nombre Completo`**
3. Renombrar la jerarquía a: **`empleado_pais`**

✅ Resultado visual:
```
🌲 empleado_pais
   ├── País
   └── Nombre Completo
```

### 🔗 Attribute Relationships:

1. Pestaña **`Attribute Relationships`**
2. Clic derecho en `Nombre Completo` → **New Attribute Relationship**
3. Source: `Nombre Completo` → Related: `País`
4. OK

5. **Guardar:** `Ctrl + S`

---

## 📅 PASO 7: Crear la Dimensión Tiempo (3.6 pts)

1. Clic derecho en **`Dimensions`** → **`New Dimension...`**
2. **Next** → "Use an existing table" → **Next**
3. Configurar:
   - **Main table:** `Time_Dim`
   - **Key columns:** `TimeID`
   - **Name column:** `FullDate`
4. **Next** → (no tablas relacionadas) → **Next**

### Seleccionar atributos:

| Source Column | Attribute Name |
|---------------|----------------|
| `Time ID` (key) | `Tiempo ID` |
| `Year` ✅ | **`Año`** |
| `Quarter` ✅ | **`Trimestre`** |
| `Month` ✅ | **`Mes`** |

5. **Next**
6. Nombre: **`Tiempo`**
7. **Finish**

### 🌲 Crear la jerarquía `tiempo_calendario`:

1. Arrastrar **`Año`** al panel Hierarchies
2. Debajo, arrastrar **`Mes`**
3. Renombrar la jerarquía a: **`tiempo_calendario`**

✅ Resultado visual:
```
🌲 tiempo_calendario
   ├── Año
   └── Mes
```

### 🔗 Attribute Relationships:

1. Pestaña **`Attribute Relationships`**
2. Clic derecho en `Mes` → **New Attribute Relationship**
3. Source: `Mes` → Related: `Año`
4. OK

5. **Guardar:** `Ctrl + S`

---

## 🧊 PASO 8: Crear el Cubo + Medidas (6 pts)

1. Clic derecho en **`Cubes`** → **`New Cube...`**
2. Clic en **Next**
3. Seleccionar: **"Use existing tables"** → **Next**

### Seleccionar la tabla de hechos:

4. **Measure group tables:** marcar **`Sales_Fact`** ✅
5. Clic en **Next**

### Seleccionar las medidas:

6. **DESMARCAR TODO** primero
7. **MARCAR SOLO:**
   - ✅ `Sales Amount` (la renombraremos después)
   - ✅ `Unit Price` (la renombraremos después)

> ⚠️ **Importante:** Desmarca cualquier otra medida (como `Quantity`, `Sales Fact Count`, etc.)

8. Clic en **Next**

### Seleccionar las dimensiones existentes:

9. Marcar las 3 dimensiones:
   - ✅ `Producto`
   - ✅ `Empleado`
   - ✅ `Tiempo`
10. Clic en **Next**

### Crear nuevas dimensiones (si aparece esta pantalla):

11. **DESMARCAR TODO** (no queremos crear nuevas dimensiones)
12. Clic en **Next**

### Nombre del cubo:

13. **Cube name:** **`Cubo_Orozco`** ✅
14. Clic en **Finish**

✅ Se abre el **Cube Designer**.

### ✏️ Renombrar las medidas:

1. En el panel **Measures** (esquina superior izquierda):
   - Clic derecho en `Sales Amount` → **Rename** → escribir: **`Ventas Monto`**
   - Clic derecho en `Unit Price` → **Rename** → escribir: **`Ventas P Unitario`**

### 💰 Configurar formato de las medidas:

1. Clic en **`Ventas Monto`** → panel **Properties** (F4) →
   - **FormatString:** `Currency` (o `"$#,##0.00"`)
   - **AggregateFunction:** `Sum`

2. Clic en **`Ventas P Unitario`** → **Properties** →
   - **FormatString:** `Currency`
   - **AggregateFunction:** `Sum` (o `Average` si prefieres promedio)

3. **Guardar:** `Ctrl + S`

---

## 🚀 PASO 9: Procesar y desplegar

### 🔧 Configurar el servidor de despliegue:

1. Clic derecho en el **proyecto** (raiz: `Cubo_Orozco`) → **Properties**
2. Sección **Configuration Properties** → **Deployment**
3. Configurar:
   - **Server:** `localhost`
   - **Database:** `Cubo_Orozco`
   - **Processing Option:** `Default`
4. Clic en **OK**

### 🚀 Desplegar (Deploy):

1. Clic derecho en el **proyecto** → **Deploy**
2. Esperar... Ver el panel **Output** abajo
3. Debe terminar con: **"Deployment Completed Successfully"** ✅

### ⚙️ Procesar el cubo:

1. Clic derecho en el cubo **`Cubo_Orozco.cube`** → **Process**
2. En la ventana: clic en **Run**
3. Esperar... Debe terminar con todos los items en **"Process succeeded"** ✅
4. Clic en **Close** → **Close** otra vez

### 🔍 Probar el cubo (opcional pero recomendado):

1. Clic en la pestaña **Browser** (arriba del cube designer)
2. **Arrastrar** medidas y dimensiones al área central para ver datos
3. Ejemplo: arrastra `Ventas Monto` + `categoria_producto` para ver ventas por categoría

---

## 📦 PASO 10: Comprimir y entregar

1. **Cerrar Visual Studio 2019**
2. Ir a la carpeta del proyecto (donde lo guardaste, ej: `C:\Proyectos\Cubo_Orozco\`)
3. **Comprimir TODA la carpeta** `Cubo_Orozco` en formato **ZIP** o **RAR**
   - Clic derecho en la carpeta → **Enviar a** → **Carpeta comprimida (zip)**
   - O usar WinRAR / 7-Zip
4. Nombre del archivo: **`Cubo_Orozco.zip`**
5. **¡Entregar al profesor!** ✅

---

## 🎯 VERIFICACIÓN FINAL (Checklist 20 pts)

| Criterio | Puntos | ✅ |
|----------|--------|---|
| Data Source `NorthwindMart` creado | 1.5 | ☐ |
| Data Source View `NorthwindMart DSV` con 5 tablas | 1.5 | ☐ |
| Dimensión `Producto` con atributos `CategoriaNombre`, `ProductoNombre` | 2.0 | ☐ |
| Jerarquía `categoria_producto` (CategoriaNombre → ProductoNombre) | 1.7 | ☐ |
| Dimensión `Empleado` con atributos `País`, `Ciudad`, `Región`, `Nombre Completo` | 2.0 | ☐ |
| Jerarquía `empleado_pais` (País → Nombre Completo) | 1.7 | ☐ |
| Dimensión `Tiempo` con atributos `Año`, `Trimestre`, `Mes` | 2.0 | ☐ |
| Jerarquía `tiempo_calendario` (Año → Mes) | 1.6 | ☐ |
| Cubo `Cubo_Orozco` creado | 3.0 | ☐ |
| Medida `Ventas Monto` | 1.5 | ☐ |
| Medida `Ventas P Unitario` | 1.5 | ☐ |
| **TOTAL** | **20** | 🎯 |

---

## 🚨 SOLUCIÓN DE PROBLEMAS COMUNES

### ❌ "Cannot connect to NorthwindMart"
**Solución:** Verifica que el SQL Server esté corriendo. En SSMS conecta a `localhost` y revisa si la BD existe.

### ❌ "The dimension contains an attribute relationship error"
**Solución:** Ve a la pestaña `Attribute Relationships` de cada dimensión y crea las relaciones jerárquicas explicadas en cada paso.

### ❌ "Deployment failed - cannot connect to server"
**Solución:** Verifica que **Analysis Services** esté instalado en modo **Multidimensional** (no Tabular). Conecta a SSMS → "Connect Object Explorer" → Server type: **Analysis Services**.

### ❌ "FullName attribute is not visible"
**Solución:** La columna `FullName` es calculada (PERSISTED). Si no aparece, ve a `Data Source View` → clic derecho en `Employee_Dim` → `Refresh`.

### ❌ "No se ve la opción de proyecto Analysis Services"
**Solución:** No tienes instalada la extensión. Ve a `Extensions → Manage Extensions → Online` y busca **"Microsoft Analysis Services Projects"**.

---

## 📝 NOTAS FINALES

- 💡 **Guarda frecuentemente** con `Ctrl+S`
- 💡 Si algo falla, puedes **eliminar el elemento** y volver a crearlo (clic derecho → Delete)
- 💡 La pestaña **Browser** del cubo te permite explorar los datos como en Excel
- 💡 Si quieres, puedes hacer una **captura de pantalla** del cubo procesado para tener evidencia

---

**¡Éxito en tu examen, Orozco! 🎓✨**
