package com.ProyectoWebRestaurante.dao;

import com.ProyectoWebRestaurante.domain.Plato;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface PlatoDao
        extends JpaRepository<Plato,Long> {
    
    //Se define una consulta tipo JPA para recuperar los productos
    //Que se encuentran en un rango de precios ordenador por descripcion acedentes
    public List<Plato> findByPrecioBetweenOrderByDescripcion(
        double precioInf, double precioSup);
    
    //Se define una consulta tipo SQL para recuperar los productos
    //Que se encuentran en un rango de precios ordenador por descripcion acedentes 
    @Query(value="SELECT p FROM Plato p WHERE p.precio BETWEEN :precioInf and :precioSup ORDER BY p.descripcion ASC")
    public List<Plato> consultaJPQL(double precioInf, double precioSup);
    
     //Se define una consulta tipo SQL nativa para recuperar los productos
    //Que se encuentran en un rango de precios ordenador por descripcion acedentes
    @Query(nativeQuery = true,value="SELECT*"+
            " FROM Plato p WHERE p.precio BETWEEN :precioInf and :precioSup ORDER BY p.descripcion ASC")
    public List<Plato> consultaSQL(double precioInf, double precioSup);
    
}
