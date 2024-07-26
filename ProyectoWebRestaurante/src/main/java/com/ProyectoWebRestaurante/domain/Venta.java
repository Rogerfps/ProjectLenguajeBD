package com.ProyectoWebRestaurante.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

@Data
@Entity
@Table(name="venta")
public class Venta implements Serializable{
    private static final long serialVersionUID = 1L; // Se declara nada más 
    
    @Id //Se define el campo clave
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_venta")
    private Long idVenta;
    private Long idFactura;
    private Long idPlato;
    private double precio;
    private int cantidad;


    public Venta() {
    }

    public Venta( Long idFactura, Long idPlato, double precio, int cantidad) {
      
        this.idFactura = idFactura;
        this.idPlato = idPlato;
        this.precio = precio;
        this.cantidad = cantidad;
    }

    


    

    
    

    
    
    
    
}