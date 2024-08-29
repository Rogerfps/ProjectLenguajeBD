package com.ProyectoWebRestaurante.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Item extends Plato {
    private int cantidad; // Almacenar la cantidad de items de un plato

    // Constructor sin parámetros
    public Item() {
        this.cantidad = 1; // Inicializar con una cantidad predeterminada
    }

    // Constructor que copia propiedades de un Plato
    public Item(Plato p) {
        super.setIdPlato(p.getIdPlato());
        super.setCategoria(p.getCategoria());
        super.setDescripcion(p.getDescripcion());
        super.setDetalle(p.getDetalle());
        super.setPrecio(p.getPrecio());
        super.setExistencias(p.getExistencias());
        super.setDisponible(p.isDisponible());
        super.setRutaImagen(p.getRutaImagen());

        this.cantidad = 1; // Inicializamos con 1 porque generalmente un ítem en el carrito comienza con 1 unidad
    }

    // Constructor adicional para crear un Item con una cantidad específica
    public Item(Plato p, int cantidad) {
        this(p);
        this.cantidad = cantidad;
    }
}
