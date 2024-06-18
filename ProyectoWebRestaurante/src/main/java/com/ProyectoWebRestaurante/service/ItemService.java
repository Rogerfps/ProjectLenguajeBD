/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.ProyectoWebRestaurante.service;


import com.ProyectoWebRestaurante.domain.Item;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author user
 */
public interface ItemService {   
    //Estructura para almacenar en memoria la lista del carrito
    List<Item> listaItems = new ArrayList<>();
    
    public List<Item> gets();
    
    //Se recupera el registro que tiene el idItem pasado por parámetro
    //si no existe en la tabla se retorna null
    public Item get(Item item);
    
    //Se elimina el registro que tiene el idItem pasado por parámetro
    public void delete(Item item);
    
    //Si el objeto item tiene un idItem que existe en la tabla item
    //El registro de actualiza con la nueva información
    //Si el idItem NO existe en la tabla, se crea el registro con esa información
    public void save(Item item);
    
    public void update(Item item);
    
    public void facturar();
}
    
