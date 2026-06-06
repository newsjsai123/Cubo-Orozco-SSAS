# 🎓 Proyecto SSAS - Cubo_Orozco

## 📋 Examen: Analítica de Sistemas Empresariales (NRC 7041)

**Alumno:** OROZCO  
**Cubo:** `Cubo_Orozco`  
**Origen de datos:** NorthwindMart  
**Puntaje total:** 20 puntos

---

## 📁 Contenido del repositorio

```
📁 Cubo-Orozco-SSAS/
│
├── 📄 README.md                          ← Este archivo (resumen general)
├── 📄 GUIA_PASO_A_PASO.md                ← Guía visual detallada de construcción
├── 📄 ENTREGA_FINAL.md                   ← Instrucciones para entregar
│
├── 📁 SQL/
│   └── 01_Crear_NorthwindMart.sql        ← Script para crear la BD con datos
│
└── 📁 Cubo_Orozco/                       ← PROYECTO SSAS (abrir en Visual Studio)
    ├── Cubo_Orozco.sln                   ← Solución de Visual Studio
    ├── Cubo_Orozco.dwproj                ← Proyecto SSAS
    ├── NorthwindMart.ds                  ← Data Source
    ├── NorthwindMart DSV.dsv             ← Data Source View
    ├── Producto.dim                      ← Dimensión Producto + jerarquía
    ├── Empleado.dim                      ← Dimensión Empleado + jerarquía
    ├── Tiempo.dim                        ← Dimensión Tiempo + jerarquía
    └── Cubo_Orozco.cube                  ← Cubo con las 2 medidas
```

---

## 🎯 Criterios de evaluación cumplidos

| Criterio | Puntos | Estado |
|----------|--------|--------|
| ✅ Data Source `NorthwindMart` | 1.5 | OK |
| ✅ Data Source View `NorthwindMart DSV` | 1.5 | OK |
| ✅ Dimensión `Producto` + jerarquía `categoria_producto` | 3.7 | OK |
| ✅ Dimensión `Empleado` + jerarquía `empleado_pais` | 3.7 | OK |
| ✅ Dimensión `Tiempo` + jerarquía `tiempo_calendario` | 3.6 | OK |
| ✅ Cubo `Cubo_Orozco` | 3.0 | OK |
| ✅ Medida `Ventas Monto` | 1.5 | OK |
| ✅ Medida `Ventas P Unitario` | 1.5 | OK |
| **TOTAL** | **20** | 🎯 |

---

## 🚀 Inicio Rápido (3 pasos)

### 1️⃣ Crear la base de datos
```bash
# Abrir SSMS, conectar a localhost y ejecutar:
SQL/01_Crear_NorthwindMart.sql
```

### 2️⃣ Abrir el proyecto en Visual Studio 2022
```bash
# Doble clic en:
Cubo_Orozco/Cubo_Orozco.sln
```

### 3️⃣ Desplegar y procesar
- Clic derecho en el proyecto → **Deploy**
- Clic derecho en el cubo → **Process** → Run

---

## 📦 Cómo entregar el examen

1. Descarga este repositorio como ZIP (botón verde **"Code" → "Download ZIP"**)
2. Extrae el ZIP
3. **Comprime SOLO la carpeta `Cubo_Orozco/`** en formato ZIP o RAR
4. Entrega el archivo comprimido a tu profesor

Ver `ENTREGA_FINAL.md` para más detalles.

---

## 📖 Documentación detallada

- 📘 **GUIA_PASO_A_PASO.md** → Guía completa de cómo construir el proyecto desde cero
- 📗 **ENTREGA_FINAL.md** → Instrucciones para la entrega final
- 📙 **SQL/01_Crear_NorthwindMart.sql** → Script SQL con datos de prueba

---

## 🛠️ Requisitos

- ✅ **SQL Server** (Express, Developer o cualquier edición) con instancia local
- ✅ **SQL Server Analysis Services** en modo **Multidimensional**
- ✅ **SQL Server Management Studio (SSMS)**
- ✅ **Visual Studio 2022** (Community)
- ✅ Extensión: **Microsoft Analysis Services Projects** (instalable desde el Marketplace)

---

## ✨ Información técnica

| Elemento | Valor |
|----------|-------|
| Servidor SQL | `localhost` |
| Base de datos | `NorthwindMart` |
| Servidor SSAS | `localhost` |
| Cubo destino | `Cubo_Orozco` |
| Lenguaje de consulta | MDX |

---

## 📝 Notas importantes

> ⚠️ **Si los archivos del proyecto SSAS (.dwproj, .ds, .dsv, .dim, .cube) generan errores al abrir en Visual Studio**, sigue la **GUIA_PASO_A_PASO.md** para construir el proyecto desde cero. Toma ~30 minutos.

> 💡 **Recomendación**: Aunque el proyecto está listo, **te recomiendo seguir la GUIA_PASO_A_PASO.md** la primera vez para que entiendas todos los conceptos y puedas explicarlos en el examen.

---

**¡Éxito en tu examen! 🎓✨**
