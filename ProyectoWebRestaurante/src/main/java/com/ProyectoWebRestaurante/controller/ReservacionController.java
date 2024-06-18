package com.ProyectoWebRestaurante.controller;

import com.ProyectoWebRestaurante.domain.Reservacion;
import com.ProyectoWebRestaurante.service.ReservacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/reservacion")
public class ReservacionController {

    @Autowired
    private ReservacionService reservacionService;


    @GetMapping("/listado")
    public String listado(Model model) {
        var lista = reservacionService.getReservacions();
        model.addAttribute("reservacions", lista);
        model.addAttribute("totalReservacions", lista.size());
        model.addAttribute("reservacion", new Reservacion()); 
        return "/reservacion/listado";
    }

    @PostMapping("/guardar")
    public String save(Reservacion reservacion) {
        reservacionService.save(reservacion);
        return "redirect:/reservacion/listado"; 
    }

    @GetMapping("/modificar/{idReservacion}")
    public String modifica(Reservacion reservacion, Model model) {
        reservacion = reservacionService.getReservacion(reservacion);
        model.addAttribute("reservacion", reservacion);
        return "reservacion/modifica";
    }

    @GetMapping("/eliminar/{idReservacion}")
    public String elimina(Reservacion reservacion) {
        reservacionService.delete(reservacion);
        return "redirect:/reservacion/listado";
    }

}
