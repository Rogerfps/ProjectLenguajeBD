package com.ProyectoWebRestaurante.controller;

import com.ProyectoWebRestaurante.domain.Item;
import com.ProyectoWebRestaurante.domain.Plato;
import com.ProyectoWebRestaurante.service.ItemService;
import com.ProyectoWebRestaurante.service.PlatoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller

public class CarritoController {

    @Autowired
    private ItemService itemService;
    @Autowired
    private PlatoService platoSerivce;

//Este mapping se realiza desde el ícono del carrito
    @GetMapping("/carrito/agregar/{idPlato}")
    public ModelAndView agregar( Item item, Model model) {

        Item item2 = itemService.get(item);
        

        if (item2 == null) { //No existe el plato en el carrito
            Plato p = platoSerivce.getPlato(item);
            item2 = new Item(p);

        }
        itemService.save(item2);
        var lista= itemService.gets();
        var listaTotal=0;
        var carritoTotal=0;
        for(Item i: lista ){
            listaTotal+=i.getCantidad();
            carritoTotal+=(i.getCantidad()*i.getPrecio());
            
        }
        model.addAttribute("listaItems", lista);
        model.addAttribute("listaTotal", listaTotal);
        model.addAttribute("carritoTotal", carritoTotal);

        return new ModelAndView("/carrito/fragmentos :: verCarrito");

    }

    @GetMapping("/carrito/listado")
    public String listado(Model model) {
        var lista = itemService.gets();
        var listaTotal=0;
        var carritoTotal=0;
        for(Item i: lista ){
            listaTotal+=i.getCantidad();
            carritoTotal+=(i.getCantidad()*i.getPrecio());
            
        }
        model.addAttribute("listaItems", lista);
        model.addAttribute("listaTotal", listaTotal);
        model.addAttribute("carritoTotal", carritoTotal);

        return "/carrito/listado";
    }
      @GetMapping("/carrito/eliminar/{idPlato}")
      public String eliminar(Item item){
          itemService.delete(item);
          return "redirect:/carrito/listado";   
      }
      @GetMapping("/carrito/modificar/{idPlato}")
      public String modificar(Item item, Model model){
          item=itemService.get(item);
          model.addAttribute("item",item);
          
          return "/carrito/modifica";   
      }
      @PostMapping("/carrito/guardar")
      public String modificar(Item item){
          itemService.update(item);
          return"redirect:/carrito/listado"; 
      }
      
       @GetMapping("facturar/carrito")
      public String facturar(){
          //Acá va el código 
          itemService.facturar();
          return"redirect:/index3"; 
      }


}
