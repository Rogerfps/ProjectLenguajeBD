package com.ProyectoWebRestaurante.controller;

import com.ProyectoWebRestaurante.domain.Plato;
import com.ProyectoWebRestaurante.service.CategoriaService;
import com.ProyectoWebRestaurante.service.PlatoService;
import com.ProyectoWebRestaurante.service.FirebaseStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/plato")
public class PlatoController {

    @Autowired
    private PlatoService platoService;
    @Autowired
    private FirebaseStorageService firebaseStorageService;
    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/listado")
    public String listado(Model model) {
        // Cambiamos el parámetro a '1' para obtener los platos disponibles
        var lista = platoService.getPlatos(1);
        model.addAttribute("platos", lista);
        model.addAttribute("totalPlatos", lista.size());
        model.addAttribute("plato", new Plato());

        var categorias = categoriaService.getCategorias(false);
        model.addAttribute("categorias", categorias);

        return "/plato/listado";
    }

    @PostMapping("/guardar")
    public String save(@ModelAttribute("plato") Plato plato, @RequestParam("imagenFile") MultipartFile imagenFile) {
        // Convertir el booleano a entero (1 o 0) antes de guardar
        plato.setDisponible(plato.isDisponible());

        // Guardar el Plato para asegurarse de que tenga un ID asignado, necesario para construir la ruta de la imagen
        platoService.save(plato);

        // Verificamos si hay una imagen para subir.
        if (!imagenFile.isEmpty()) {
            // Subimos la imagen a Firebase Storage y obtenemos la ruta.
            String ruta = firebaseStorageService.cargaImagen(imagenFile, "plato", plato.getIdPlato());

            // Establecemos la ruta de la imagen en el plato y lo guardamos nuevamente.
            plato.setRutaImagen(ruta);
            platoService.save(plato);
        }

        // Redireccionamos al listado de platos.
        return "redirect:/plato/listado";
    }

    @GetMapping("/modificar/{idPlato}")
    public String modifica(Plato plato, Model model) {
        plato = platoService.getPlato(plato);
        model.addAttribute("plato", plato);

        var categorias = categoriaService.getCategorias(false);
        model.addAttribute("categorias", categorias);

        return "plato/modifica";
    }

    @GetMapping("/eliminar/{idPlato}")
    public String elimina(Plato plato) {
        platoService.delete(plato);
        return "redirect:/plato/listado";
    }

}
