package com.ProyectoWebRestaurante.controller;

import com.ProyectoWebRestaurante.domain.Categoria;
import com.ProyectoWebRestaurante.service.CategoriaService;
import com.ProyectoWebRestaurante.service.PlatoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/navegar")
public class NavegarController {

    @Autowired
    private PlatoService platoService;
    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/listado")
    public String listado(Model model) {
        var lista = platoService.getPlatos(false);
        model.addAttribute("platos", lista);

        var categorias = categoriaService.getCategorias(false);
        model.addAttribute("categorias", categorias);

        return "/navegar/listado";

    }

    @GetMapping("/listado/{idCategoria}")
    public String modifica(Categoria categoria, Model model) {
        categoria = categoriaService.getCategoria(categoria);
        var lista = categoria.getPlatos();
        model.addAttribute("platos", lista);
        var categorias = categoriaService.getCategorias(false);
        model.addAttribute("categorias", categorias);

        return "/navegar/listado";
    }

    
    
//     @GetMapping("/navegar")
//    public String listado3(Model model) {
//        var lista = platoService.getPlatos(false);
//        model.addAttribute("platos", lista);
//
//        return "navegar";
//
//    }
}