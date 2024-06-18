package com.ProyectoWebRestaurante.service.impl;

import com.ProyectoWebRestaurante.dao.PlatoDao;
import com.ProyectoWebRestaurante.domain.Plato;
import com.ProyectoWebRestaurante.service.PlatoService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PlatoServiceImpl implements PlatoService {

    @Autowired
    private PlatoDao platoDao;

    @Override
    @Transactional(readOnly = true)
    public List<Plato> getPlatos(boolean disponibles) {
        var lista = platoDao.findAll();
        if (disponibles) { 
            lista.removeIf(c -> !c.isDisponible());

        }

        return lista;
    }

    @Override
    @Transactional(readOnly = true)
    public Plato getPlato(Plato plato) {
        return platoDao.findById(plato.getIdPlato()).orElse(null);
    }

    @Override
    @Transactional
    public void save(Plato plato) {
        platoDao.save(plato);
    }

    @Override
    @Transactional
    public void delete(Plato plato) {
        platoDao.delete(plato);
    }
      @Override
    @Transactional(readOnly = true)
    public List<Plato> consultaJPA(double precioInf, double precioSup) {
        return platoDao.findByPrecioBetweenOrderByDescripcion(precioInf, precioSup);
    }

    // Se define una consulta tipo JPQL para recuperar los platos
    // Que se encuentran en un rango de precios ordenados por descripción ascendente
    @Override
    @Transactional(readOnly = true)
    public List<Plato> consultaJPQL(double precioInf, double precioSup) {
        return platoDao.consultaJPQL(precioInf, precioSup);
    }

    // Se define una consulta tipo SQL nativa para recuperar los platos
    // Que se encuentran en un rango de precios ordenados por descripción ascendente
    @Override
    @Transactional(readOnly = true)
    public List<Plato> consultaSQL(double precioInf, double precioSup) {
        return platoDao.consultaSQL(precioInf, precioSup);
    }





}