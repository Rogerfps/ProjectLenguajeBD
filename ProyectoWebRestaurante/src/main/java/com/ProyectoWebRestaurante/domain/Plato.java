package com.ProyectoWebRestaurante.domain;

import com.ProyectoWebRestaurante.domain.Categoria;
import jakarta.persistence.*;
import java.io.Serializable;

import lombok.Data;

@Data
@Entity
@Table(name = "plato")
public class Plato implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_plato")
    private Long idPlato;

    private String descripcion;

    @Column(name = "detalle")
    private String detalle;

    private double precio;

    @Column(name = "existencias")
    private int existencias;

    @Column(name = "ruta_imagen")
    private String rutaImagen;

    // Cambiamos boolean a int para reflejar la lógica de 1/0 en la base de datos
    @Column(name = "disponible")
    private int disponible;

    @ManyToOne
    @JoinColumn(name = "id_categoria")
    private Categoria categoria;

    // Método para facilitar el uso del campo como booleano en Java
    public boolean isDisponible() {
        return this.disponible == 1;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible ? 1 : 0;
    }
}
