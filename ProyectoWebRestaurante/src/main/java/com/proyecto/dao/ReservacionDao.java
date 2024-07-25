package com.ProyectoWebRestaurante.dao;

import com.ProyectoWebRestaurante.domain.Reservacion;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservacionDao
        extends JpaRepository<Reservacion,Long> {
    
}
