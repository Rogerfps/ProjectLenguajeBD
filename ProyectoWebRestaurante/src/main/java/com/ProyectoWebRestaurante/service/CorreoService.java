package com.ProyectoWebRestaurante.service;

import jakarta.mail.MessagingException;


public interface CorreoService {

    //La firma del método para enviar correos html
    public void enviarCorreoHtml(
            String para,
            String asunto,
            String contenidoHtml)
            throws MessagingException;

}
