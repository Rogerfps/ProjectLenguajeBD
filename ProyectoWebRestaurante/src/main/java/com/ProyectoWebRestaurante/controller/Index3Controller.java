package com.ProyectoWebRestaurante.controller;


import com.ProyectoWebRestaurante.service.PlatoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller

public class Index3Controller {

    @Autowired
    private PlatoService platoService;

    @GetMapping("/index3")
    public String listado(Model model) {
    
        

        return "/index3";

    }

}
