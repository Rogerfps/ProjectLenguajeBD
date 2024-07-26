package com.ProyectoWebRestaurante.service;

import com.ProyectoWebRestaurante.domain.Categoria;
import java.util.List;

public interface CategoriaService {

    /* CRUD
    CReate, Read, Upadate Delete
    */
    //Se define la firma del método para recuperar 
    //los registro de la tabla categoria en una lista

    public List<Categoria> getCategorias(boolean disponible);

    //Se define la firma del método para recuperar UN registro
    //de la tabla categroria el valor de idCategoria
    public Categoria getCategoria(Categoria categoria);

    //Se define la firma del método para Crear o Modificar un registro 
    //Si el idCategoria que pasan esta null, se crea el registro
    //Si el idCategoria que para tienen un valor, se modifica ese registro 
    public void save(Categoria categoria);

    //Se define la firma del método para Eliminar un registro
    //Se elimina el regisro que tiene el idCategoria
    public void delete(Categoria categoria);

}