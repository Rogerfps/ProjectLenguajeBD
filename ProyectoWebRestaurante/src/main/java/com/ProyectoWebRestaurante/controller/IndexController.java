package com.ProyectoWebRestaurante.controller;

import com.ProyectoWebRestaurante.service.PlatoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    @Autowired
    private PlatoService platoService;

    @GetMapping("/index2")
    public String listado(Model model) {
        // Cambiamos el parámetro a '1' para indicar que queremos los platos disponibles
        var lista = platoService.getPlatos(1);
        model.addAttribute("platos", lista);
        
        return "/index2";
    }
}
