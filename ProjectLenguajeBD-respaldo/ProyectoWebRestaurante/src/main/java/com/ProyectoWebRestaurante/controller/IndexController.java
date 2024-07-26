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
        var lista = platoService.getPlatos(true);
        model.addAttribute("platos", lista);
        

        return "/index2";

    }

}
