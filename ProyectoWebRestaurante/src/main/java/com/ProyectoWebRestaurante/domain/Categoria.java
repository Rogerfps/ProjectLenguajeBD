package com.ProyectoWebRestaurante.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;

@Data
@Entity
@Table(name = "categoria") 
public class Categoria implements Serializable {
    private static final long serialVersionUID = 1L; 

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_categoria")
    private Long idCategoria;

    private String descripcion;

    @Column(name = "disponible") 
    private boolean disponible;
    
     @Column(name = "ruta_imagen")
    private String rutaImagen;
     
     
     @OneToMany
     @JoinColumn(name="id_categoria", updatable = false)
     private List<Plato>platos;
}

/*
create table DondePapa.categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(30) NOT NULL,
  ruta_imagen varchar(1024),
  disponible bool,
  PRIMARY KEY (id_categoria))
*/
