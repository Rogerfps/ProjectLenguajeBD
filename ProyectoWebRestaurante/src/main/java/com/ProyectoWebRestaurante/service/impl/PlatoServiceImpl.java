package com.ProyectoWebRestaurante.service.impl;

import com.ProyectoWebRestaurante.dao.PlatoDao;
import com.ProyectoWebRestaurante.domain.Plato;
import com.ProyectoWebRestaurante.service.PlatoService;
import com.ProyectoWebRestaurante.repository.PlatoRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PlatoServiceImpl implements PlatoService {

    @Autowired
    private PlatoDao platoDao;
    
    @Autowired
    private PlatoRepository platoRepository;

    @Override
    @Transactional(readOnly = true)
    public List<Plato> getPlatos(int disponible) {
        var lista = platoDao.findAll();
        if (disponible == 1) { 
            lista.removeIf(c -> c.getDisponible() != 1);
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

    /*
    @Override
    @Transactional(readOnly = true)
    public List<Plato> consultaJPQL(double precioInf, double precioSup) {
        return platoDao.consultaJPQL(precioInf, precioSup);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Plato> consultaSQL(double precioInf, double precioSup) {
        return platoDao.consultaSQL(precioInf, precioSup);
    } */
    
    @Override
    public List<Plato> OBTENER_PLATOS_X_CATEGORIA(Long idCategoria) {
        return platoRepository.findByCategoriaIdCategoria(idCategoria);
    }
}
