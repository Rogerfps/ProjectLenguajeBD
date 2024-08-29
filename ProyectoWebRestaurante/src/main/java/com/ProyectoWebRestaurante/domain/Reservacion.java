package com.ProyectoWebRestaurante.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalTime;

import lombok.Data;

@Data
@Entity
@Table(name = "reservacion")
public class Reservacion implements Serializable {

    private static final long serialVersionUID = 1L; 

    @Id //Se define el campo clave
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reservacion")
    private Long idReservacion;
    private String nombre;
    private LocalTime hora; 
    
    @Column(name = "numero_de_mesa")
    private int numeroDeMesa;
    private String contacto;
  

}
/*
CREATE TABLE DondePapa.reservaciones (
    id_reservacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    hora TIME,
    numero_de_mesa INT
);
 */
