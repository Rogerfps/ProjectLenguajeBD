package com.ProyectoWebRestaurante.domain;

import com.ProyectoWebRestaurante.domain.Categoria;
import jakarta.persistence.*;
import java.io.Serializable;

import lombok.Data;

@Data
@Entity
@Table(name = "plato")
public class Plato implements Serializable {

    private static final long serialVersionUID = 1L; // Se declara nada más 

    @Id //Se define el campo clave
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_plato")
    private Long idPlato;
    //@Column(name = "id_categoria")
    //private long idCategoria;         ya no lo utilizamos gracias a la asociación
    
    private String descripcion;
    @Column(name = "detalle")
    private String detalle;
    private double precio;
    @Column(name = "existencias")
    private int existencias;
    @Column(name = "ruta_imagen")
    private String rutaImagen;
    private boolean disponible;
    
    //Para poder asociar dos clases que mapean tablas relacionadas como vimos en clase 
    @ManyToOne
    @JoinColumn(name="id_categoria")
    private Categoria categoria;

}
/*
create table DondePapa.plato (
  id_plato INT NOT NULL AUTO_INCREMENT,
  id_categoria INT NOT NULL,
  descripcion VARCHAR(30) NOT NULL,  
  detalle VARCHAR(1600) NOT NULL, 
  precio double, 
  ruta_imagen varchar(1024),
  disponible bool,
  PRIMARY KEY (id_plato),
  foreign key fk_producto_caregoria (id_categoria) references categoria(id_categoria)  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

 */
