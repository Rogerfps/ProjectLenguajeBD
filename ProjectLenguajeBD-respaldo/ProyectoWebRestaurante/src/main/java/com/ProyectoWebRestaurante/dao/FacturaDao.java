package com.ProyectoWebRestaurante.dao;


import com.ProyectoWebRestaurante.domain.Factura;


import org.springframework.data.jpa.repository.JpaRepository;


public interface FacturaDao
        extends JpaRepository<Factura,Long> {
   
}

    
