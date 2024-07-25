package com.ProyectoWebRestaurante.service;

import org.springframework.web.multipart.MultipartFile;

public interface FirebaseStorageService {

    public String cargaImagen(MultipartFile archivoLocalCliente,
            String carpeta,
            Long id);

    //El BuketName es el <id_del_proyecto> + ".appspot.com"
    final String BucketName = "dondepapa-6ba64.appspot.com"; //una especie de url 

    //Esta es la ruta básica de este proyecto Techshop
    final String rutaSuperiorStorage = "DondePapa";

    //Ubicación donde se encuentra el archivo de configuración Json
    final String rutaJsonFile = "firebase";

    //El nombre del archivo Json
    final String archivoJsonFile = "dondepapa-6ba64-firebase-adminsdk-j2jfh-ade94910ad.json";
}
