package com.ProyectoWebRestaurante.service.impl;

import com.ProyectoWebRestaurante.dao.ReservacionDao;
import com.ProyectoWebRestaurante.domain.Reservacion;
import com.ProyectoWebRestaurante.service.ReservacionService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReservacionServiceImpl implements ReservacionService {

    @Autowired
    private ReservacionDao reservacionDao;


    @Transactional(readOnly = true)
    public List<Reservacion> getReservacions() {
        var lista = reservacionDao.findAll();
        
        return lista;
    }

    @Override
    @Transactional(readOnly = true)
    public Reservacion getReservacion(Reservacion reservacion) {
        return reservacionDao.findById(reservacion.getIdReservacion()).orElse(null);
    }

    @Override
    @Transactional
    public void save(Reservacion reservacion) {
        reservacionDao.save(reservacion);
    }

    @Override
    @Transactional
    public void delete(Reservacion reservacion) {
        reservacionDao.delete(reservacion);
    }

   

}
