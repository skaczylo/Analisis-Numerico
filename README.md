# Análisis Numérico — Métodos para Ecuaciones Diferenciales en MATLAB

[![MATLAB](https://img.shields.io/badge/MATLAB-R2018b%2B-orange.svg)](https://www.mathworks.com/products/matlab.html)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Implementación **desde cero**, en **MATLAB**, de los principales métodos numéricos
para la resolución de **ecuaciones diferenciales ordinarias (EDO)**: problemas de
valor inicial (PVI) y problemas de contorno. El repositorio recoge el trabajo de la
asignatura de *Análisis Numérico*, organizado como una pequeña biblioteca de métodos
acompañada de scripts de demostración, comparación y medida del error.

Los métodos están programados de forma explícita —sin apoyarse en los *solvers* de
MATLAB salvo para el arranque de algún esquema multipaso— para mostrar el
funcionamiento interno de cada algoritmo: discretización temporal, arranque de
métodos multipaso, iteración del corrector y reducción de un problema de contorno a
varios problemas de valor inicial.

---

## Tabla de contenidos

- [Métodos implementados](#métodos-implementados)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Cómo ejecutarlo](#cómo-ejecutarlo)
- [Problemas de prueba](#problemas-de-prueba)
- [Conceptos demostrados](#conceptos-demostrados)
- [Licencia](#licencia)

---

## Métodos implementados

### Métodos monopaso (one-step) · paquete `+metodosMonopaso`
Calculan `x_{n+1}` usando únicamente la información del paso anterior `x_n`.

| Método | Orden | Archivo |
|--------|:-----:|---------|
| Euler explícito | 1 | `meuler.m` |
| Euler modificado / punto medio | 2 | `meulermod.m` |
| Familia Runge–Kutta de 2 etapas (parámetros `a`, `b`) | 2 | `m_rungekuta2.m` |
| Runge–Kutta de orden 3 | 3 | `mrk3.m` |

Acompañados de utilidades de análisis: `comp2met` (compara dos métodos),
`comp2solexac` (compara un método con la solución exacta), `testmet` y `graficas`
(ejecución y representación).

### Métodos multipaso (multi-step) · `metodosMultipaso`
Reutilizan varios pasos previos; requieren un *arranque* (aquí, con `ode45`).

| Método | Archivo |
|--------|---------|
| Adams–Bashforth de 2 pasos (explícito) | `m_adambashforth2.m` |
| Punto medio / *leapfrog* | `m_puntomedio.m` |

### Métodos de predicción–corrección · paquete `+metodosPrediccionCorreccion`
Combinan un **predictor** explícito con un **corrector** implícito (esquema P(EC)).

| Esquema | Archivo |
|---------|---------|
| Predictor Adams–Bashforth 2 + corrector Adams–Moulton 2 | `m_ab2_am2.m` |
| Predictor Taylor de orden 2 + corrector Adams–Moulton 2 | `m_taylor2_am2.m` |

### Problemas de contorno · `metodosTiro`
| Método | Archivo |
|--------|---------|
| Método de tiro (*shooting*) por combinación lineal de dos PVI | `tiro.m` |

### Exámenes resueltos · `examenes`
Ejercicios de examen (mayo y junio de 2022) resueltos reutilizando los métodos
anteriores y midiendo el error frente a la solución exacta.

---

## Estructura del proyecto

```
Analisis-Numerico/
├── +metodosMonopaso/             Biblioteca (paquete) de métodos de un paso
│   ├── meuler.m                  Euler explícito
│   ├── meulermod.m              Euler modificado (RK2 punto medio)
│   ├── m_rungekuta2.m           Familia Runge–Kutta de orden 2 (a, b)
│   ├── mrk3.m                   Runge–Kutta de orden 3
│   ├── datos.m                  Problema test (sistema lineal 2D + solución exacta)
│   ├── comp2met.m              Comparar dos métodos
│   ├── comp2solexac.m         Comparar un método con la solución exacta
│   ├── graficas.m              Representación (caso escalar / R² / R³)
│   └── testmet.m              Ejecuta un método y dibuja su solución
│
├── metodosMultipaso/             Métodos multipaso + demo (main.m)
├── +metodosPrediccionCorreccion/ Esquemas predictor-corrector
├── metodosTiro/                  Método de tiro para problemas de contorno
├── examenes/                     Ejercicios de examen resueltos
│
├── main.m                        Punto de entrada (RK2 sobre el sistema test)
├── graficas.m / testmet.m        Representación y runner de la práctica
├── datos.m                       Datos del problema de la práctica
│
├── docs/                         Enunciados (PDF)
├── LICENSE
└── README.md
```

> **Sobre las carpetas con `+`.** `+metodosMonopaso` y `+metodosPrediccionCorreccion`
> son [paquetes de MATLAB](https://www.mathworks.com/help/matlab/matlab_oop/scoping-classes-with-packages.html):
> sus funciones se invocan con el espacio de nombres, p. ej.
> `metodosMonopaso.mrk3(...)`. Esto evita colisiones de nombres y permite reutilizar
> los métodos desde cualquier script del proyecto.

---

## Cómo ejecutarlo

Requiere **MATLAB** (probado en R2018b o superior; sin *toolboxes* adicionales).
Abre MATLAB con la **raíz del proyecto** como carpeta actual: así los paquetes `+...`
quedan accesibles desde cualquier script.

```matlab
cd Analisis-Numerico

% --- Práctica monopaso (sistema lineal 2D del fichero datos.m) ---
main                                              % RK2 sobre el problema test

% --- Comparar métodos monopaso entre sí o con la solución exacta ---
metodosMonopaso.comp2met(@metodosMonopaso.meuler, @metodosMonopaso.mrk3)
metodosMonopaso.comp2solexac(@metodosMonopaso.mrk3)

% --- Métodos multipaso ---
run('metodosMultipaso/main.m')

% --- Predicción-corrección ---
f = @(t,x) -2*x;
[t,x] = metodosPrediccionCorreccion.m_ab2_am2(f, [0 2], 1, 100);   % AB2 + AM2
run('+metodosPrediccionCorreccion/m_taylor2_am2.m')                % Taylor2 + AM2

% --- Problema de contorno (método de tiro) ---
run('metodosTiro/tiro.m')

% --- Ejercicios de examen ---
run('examenes/junio2022.m')
```

---

## Problemas de prueba

- **Sistema lineal 2D (práctica monopaso):**
  `x' = [-0.1·x₁ + 2·x₂ ; -2·x₁ - 0.1·x₂]`, `x(0) = [0; 1]` en `[0, 10]`.
  Solución exacta `x(t) = e^{-0.1t}·[sin(2t); cos(2t)]` (espiral amortiguada),
  que permite medir el **error global** de cada método.
- **PVI no lineal (predictor-corrector Taylor):**
  `x' = 2 + 3·cos(x·t²)`, `x(0) = 1` en `[0, 2]`.
- **PVI de examen (junio 2022):** `x' = 2x + t²`, `x(0) = 1` en `[0, 2]`,
  con solución exacta `x(t) = ¼·(5e^{2t} − 2t² − 2t − 1)`.
- **Problema de contorno (método de tiro):**
  `−x'' + (1 − t/2)·x' + x = 0`, `x'(0) = 4`, `x(1) = −3` en `[0, 1]`,
  con solución exacta `x(t) = −t² + 4t − 6`.

---

## Conceptos demostrados

- Discretización de EDO y construcción paso a paso de esquemas numéricos.
- Diferencia entre métodos **explícitos / implícitos** y **monopaso / multipaso**.
- **Arranque** de métodos multipaso a partir de un método de un paso.
- **Iteración predictor-corrector** P(EC) con correctores implícitos (Adams–Moulton).
- Resolución de **sistemas de EDO** y de **problemas de contorno** (método de tiro).
- Cálculo del **error global** en norma infinito frente a la solución exacta.
- Buenas prácticas en MATLAB: funciones reutilizables, **paquetes** (`+package`),
  *handles* de función y vectorización.

---

## Licencia

Distribuido bajo licencia **MIT**. Consulta el archivo [LICENSE](LICENSE).
