# Revisión técnica pendiente

Este documento acompaña al código compartido. No son afirmaciones de que los sistemas estén probados; son puntos detectados al revisar la versión actual.

1. **Shop — multiplicador:** `setPriceMultiplier` guarda el multiplicador y `buy` lo asigna a `itemPrices.multiplier`, pero el cobro actual usa `itemPrices.economy` sin calcular el multiplicador. Por ahora no debe describirse como un multiplicador de precio aplicado.
2. **Inventory — consistencia:** `updateInventory` agrupa tres escrituras dentro de `pcall`, pero no revierte las escrituras anteriores si una posterior falla.
