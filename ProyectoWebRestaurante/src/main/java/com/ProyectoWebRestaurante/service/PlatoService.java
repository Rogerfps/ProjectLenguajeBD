package com.ProyectoWebRestaurante.service;

import com.ProyectoWebRestaurante.domain.Plato;
import com.ProyectoWebRestaurante.repository.PlatoRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

public interface PlatoService {
    
    /* CRUD
    CReate, Read, Update, Delete
    */
    
    // Se define la firma del método para recuperar los registros de la tabla plato en una lista
    // usando un valor entero en lugar de booleano para la disponibilidad
    public List<Plato> getPlatos(int disponible);
   
    // Se define la firma del método para recuperar UN registro de la tabla plato
    // utilizando el valor de idPlato
    public Plato getPlato(Plato plato);
    
    // Se define la firma del método para Crear o Modificar un registro 
    // Si el idPlato que pasan está null, se crea el registro
    // Si el idPlato que pasa tiene un valor, se modifica ese registro 
    public void save(Plato plato);
    
    // Se define la firma del método para Eliminar un registro
    // Se elimina el registro que tiene el idPlato
    public void delete(Plato plato);
    
    public List<Plato> consultaJPA(double precioInf, double precioSup);
    
    /*// Se define una consulta tipo SQL para recuperar los productos
    // que se encuentran en un rango de precios ordenados por descripción ascendente
    public List<Plato> consultaJPQL(double precioInf, double precioSup);
    
    // Se define una consulta tipo SQL nativa para recuperar los productos
    // que se encuentran en un rango de precios ordenados por descripción ascendente
    public List<Plato> consultaSQL(double precioInf, double precioSup); */
    
    public List<Plato> OBTENER_PLATOS_X_CATEGORIA(Long idCategoria);
}
