package com.ProyectoWebRestaurante.dao;

import com.ProyectoWebRestaurante.domain.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoriaDao extends JpaRepository<Categoria, Long> {
    // Aquí, ya tienes disponibles todos los métodos básicos de CRUD, incluidos save() y deleteById() heredados de JpaRepository.
    // No necesitas definir save(Plato categoria) ni delete(Long categoria).
}
