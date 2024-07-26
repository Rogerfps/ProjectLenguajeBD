/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ProyectoWebRestaurante.domain;


import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper= false)
public class Item extends Plato{
    private int cantidad; //Almacenar la cantidad de items de un plato

    

    public Item(Plato p) {
        super.setIdPlato(p.getIdPlato());
        super.setCategoria(p.getCategoria());
        super.setDescripcion(p.getDescripcion());
        super.setDetalle(p.getDetalle());
        super.setPrecio(p.getPrecio());
        super.setExistencias(p.getExistencias());
        super.setDisponible(p.isDisponible());
        super.setRutaImagen(p.getRutaImagen());
        this.cantidad = 0;
    }
}
