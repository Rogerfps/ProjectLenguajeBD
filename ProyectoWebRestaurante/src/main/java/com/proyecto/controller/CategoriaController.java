package com.ProyectoWebRestaurante.controller;

import com.ProyectoWebRestaurante.domain.Categoria;
import com.ProyectoWebRestaurante.domain.Plato;
import com.ProyectoWebRestaurante.service.CategoriaService;
import com.ProyectoWebRestaurante.service.FirebaseStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/categoria")
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;
    @Autowired
    private FirebaseStorageService firebaseStorageService;

    @GetMapping("/listado")
    public String listado(Model model) {
        var lista = categoriaService.getCategorias(false);
        model.addAttribute("categorias", lista);
        model.addAttribute("totalCategorias", lista.size());
        model.addAttribute("categoria", new Categoria());
        return "/categoria/listado";
    }

    @PostMapping("/guardar")
    public String save(Categoria categoria,
            @RequestParam("imagenFile") MultipartFile imagenFile) {
        // Primero, guardamos la categoría para asegurarnos de que tenga un ID.
        categoriaService.save(categoria);

        // Verificamos si hay una imagen para subir.
        if (!imagenFile.isEmpty()) {
            // Subimos la imagen a Firebase Storage y obtenemos la ruta.
            String ruta = firebaseStorageService.cargaImagen(imagenFile, "categoria", categoria.getIdCategoria());

            // Establecemos la ruta de la imagen en la categoría y la guardamos nuevamente.
            categoria.setRutaImagen(ruta);
            categoriaService.save(categoria);
        }

        // Redireccionamos al listado de categorías.
        return "redirect:/categoria/listado";
    }

   

    @GetMapping("/modificar/{idCategoria}")
    public String modifica(Categoria categoria, Model model) {
        categoria = categoriaService.getCategoria(categoria);
        model.addAttribute("categoria", categoria);
        return "categoria/modifica";
    }

    @GetMapping("/eliminar/{idCategoria}")
    public String elimina(Categoria categoria) {
        categoriaService.delete(categoria);
        return "redirect:/categoria/listado";
    }

}
