package com.ProyectoWebRestaurante.dao;


import com.ProyectoWebRestaurante.domain.Venta;

import org.springframework.data.jpa.repository.JpaRepository;


public interface VentaDao
        extends JpaRepository<Venta,Long> {
    
    
  
}

    
