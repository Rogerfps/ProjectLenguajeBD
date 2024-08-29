package com.ProyectoWebRestaurante.service;

import com.ProyectoWebRestaurante.domain.Item;
import java.util.ArrayList;
import java.util.List;

public interface ItemService {   
    // Estructura para almacenar en memoria la lista del carrito
    List<Item> listaItems = new ArrayList<>();
    
    // Método para recuperar todos los items del carrito
    public List<Item> gets();
    
    // Método para recuperar un item específico del carrito basado en su ID
    public Item get(Item item);
    
    // Método para eliminar un item del carrito basado en su ID
    public void delete(Item item);
    
    // Método para guardar un nuevo item en el carrito o actualizar uno existente
    public void save(Item item);
    
    // Método para actualizar la información de un item existente en el carrito
    public void update(Item item);
    
    // Método para procesar el carrito (p. ej., realizar la facturación)
    public void facturar();
}
