# Revisión técnica pendiente

Este documento acompaña al código compartido. No son afirmaciones de que los sistemas estén probados; son puntos detectados al revisar la versión actual.

1. **Item — validación:** en `Item.new`, la segunda llamada a `validateData` no se asigna a `ko`. Por eso `ko` queda en `nil` y la condición `if not ok or not ko` siempre activa el uso de `defaultData`. Conviene corregir y probar esa validación antes de describirla como validación completa.
2. **Item / Shop — argumento `data`:** `Item.new` declara `data` como argumento requerido y lo usa en la validación. `Shop.Item.buy` lo llama como `Item.new(itemId, "lite")`, sin pasar ese argumento. Hay que definir el valor por defecto o pasar los datos correspondientes y probar el flujo.
3. **Shop — multiplicador:** `setPriceMultiplier` guarda el multiplicador y `buy` lo asigna a `itemPrices.multiplier`, pero el cobro actual usa `itemPrices.economy` sin calcular el multiplicador. Por ahora no debe describirse como un multiplicador de precio aplicado.
4. **Inventory — consistencia:** `updateInventory` agrupa tres escrituras dentro de `pcall`, pero no revierte las escrituras anteriores si una posterior falla. No lo describas como una operación atómica sin implementar y probar una compensación.

## Evidencia disponible

El archivo original contiene la estructura y el código de los cuatro sistemas. No se proporcionaron tests automatizados, resultados de pruebas, vídeo ni capturas de Roblox Studio. Añádelos cuando existan y puedan reproducirse.
