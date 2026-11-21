# JekaVSX — Roblox Backend Portfolio

Desarrollo sistemas backend para Roblox con **Luau**. Actualmente trabajo en una place privada de pruebas; no es un juego publicado.

## Sistemas disponibles

| Sistema | Qué contiene | Código |
|---|---|---|
| **Item** | Datos por objeto, métodos específicos y generación de identidad. | [`Item`](src/ReplicatedStorage/Shared/Systems/Item/) |
| **Economy** | Operaciones `set`, `increment` y `decrement` sobre monedas del jugador. | [`Economy.luau`](src/ServerStorage/Systems/Economy.luau) |
| **Inventory** | Alta, eliminación y reducción de cantidad; organiza referencias por clave, tipo y rareza. | [`Inventory.luau`](src/ServerStorage/Systems/Inventory.luau) |
| **Shop** | Código inicial para consultar precios, cobrar y añadir objetos al inventario. | [`Shop/Item.luau`](src/ServerStorage/Systems/Shop/Item.luau) |

## Cómo está organizado

```text
src/
├── ReplicatedStorage/
│   └── Shared/Systems/Item/
│       ├── init.luau
│       ├── Data/stick.luau
│       └── Methods/stick.luau
└── ServerStorage/Systems/
    ├── Economy.luau
    ├── Inventory.luau
    └── Shop/Item.luau
```

Los módulos se han separado según la estructura de Roblox que compartí. El proyecto también utiliza dependencias propias o externas (`PlayerState` y `rbx-cryptography`) que no están incluidas aquí; por eso este repositorio no es un proyecto independiente listo para ejecutar.

## Evidencia y estado

El código fuente de cada módulo está disponible en `src/`. La place se utiliza para pruebas de desarrollo. Por ahora no incluyo tests automatizados, métricas, capturas ni un vídeo de demostración, así que no presento estos sistemas como producción ni como sistemas ya validados a escala.

[`docs/REVISION_TECNICA.md`](docs/REVISION_TECNICA.md). [`docs/PRUEBAS_PENDIENTES.md`](docs/PRUEBAS_PENDIENTES.md) 

## Próximos sistemas

- [ ] Sistema nuevo: pendiente
- [ ] Sistema nuevo: pendiente
- [ ] Sistema nuevo: pendiente

## Contacto

- **Discord:** pendiente de añadir
- **GitHub:** JekaVSX
