package com.ProyectoWebRestaurante.repository;

import com.ProyectoWebRestaurante.domain.Plato;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlatoRepository extends JpaRepository<Plato, Long> {

    public List<Plato> findByCategoriaIdCategoria(Long idCategoria);
}