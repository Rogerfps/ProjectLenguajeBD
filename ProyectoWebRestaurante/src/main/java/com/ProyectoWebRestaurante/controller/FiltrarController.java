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
@RequestMapping("/filtrar")
public class FiltrarController {

    @Autowired
    private PlatoService platoService;
    @Autowired
    private CategoriaService categoriaService;

    

    @GetMapping("/listado")
    public String listado(Model model) {
        var lista = platoService.getPlatos(false);
        model.addAttribute("platos", lista);

        return "/filtrar/listado";

    }

    @PostMapping("/query1")
    public String consultaJPA(
            @RequestParam(value = "precioInf") double precioInf,
            @RequestParam(value = "precioSup") double precioSup,
            Model model) {
        var lista = platoService.consultaJPA(precioInf, precioSup);
        model.addAttribute("platos", lista);
        model.addAttribute("precioInf", precioInf);
        model.addAttribute("precioSup", precioSup);

        return "/filtrar/listado";

    }
    

}