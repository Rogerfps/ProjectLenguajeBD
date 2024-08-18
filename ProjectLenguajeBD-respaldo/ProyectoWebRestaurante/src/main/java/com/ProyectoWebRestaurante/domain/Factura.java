package com.ProyectoWebRestaurante.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import lombok.Data;

@Data
@Entity
@Table(name="factura")
public class Factura implements Serializable{
    private static final long serialVersionUID = 1L; // Se declara nada más 
    
    @Id //Se define el campo clave
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_factura")
    private Long idFactura;
    private Long idUsuario;
    private Date fecha;
    private Double total;
    private int estado;

    public Factura() {
    }

    public Factura(Long idUsuario) {
        this.idUsuario = idUsuario;
        this.fecha = Calendar.getInstance().getTime();
        this.estado=1;
    }
    
    
}