package com.ProyectoWebRestaurante.service;

import com.ProyectoWebRestaurante.domain.Plato;
import java.util.List;

public interface PlatoService {
    
    /* CRUD
    CReate, Read, Upadate Delete
    */
    //Se define la firma del método para recuperar 
    //los registro de la tabla plato en una lista
    
    public List<Plato> getPlatos(boolean disponible);
    

   
    //Se define la firma del método para recuperar UN registro
    //de la tabla categroria el valor de idPlato
    public Plato getPlato(Plato plato);
    
    //Se define la firma del método para Crear o Modificar un registro 
    //Si el idPlato que pasan esta null, se crea el registro
    //Si el idPlato que para tienen un valor, se modifica ese registro 
    public void save(Plato plato);
    
    //Se define la firma del método para Eliminar un registro
    //Se elimina el regisro que tiene el idPlato
    public void delete(Plato plato);
    
    public List<Plato> consultaJPA( double precioInf, double precioSup);
    
    //Se define una consulta tipo SQL para recuperar los productos
    //Que se encuentran en un rango de precios ordenador por descripcion acedentes 
    
    public List<Plato> consultaJPQL(double precioInf, double precioSup);
    
     //Se define una consulta tipo SQL nativa para recuperar los productos
    //Que se encuentran en un rango de precios ordenador por descripcion acedentes
  
    public List<Plato> consultaSQL(double precioInf, double precioSup);
    

    
    
    
}
