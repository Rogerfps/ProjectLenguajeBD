package com.ProyectoWebRestaurante.service.impl;

import com.ProyectoWebRestaurante.dao.FacturaDao;
import com.ProyectoWebRestaurante.dao.PlatoDao;
import com.ProyectoWebRestaurante.dao.UsuarioDao;
import com.ProyectoWebRestaurante.dao.VentaDao;
import com.ProyectoWebRestaurante.domain.Factura;
import com.ProyectoWebRestaurante.domain.Item;
import com.ProyectoWebRestaurante.domain.Plato;
import com.ProyectoWebRestaurante.domain.Usuario;
import com.ProyectoWebRestaurante.domain.Venta;
import com.ProyectoWebRestaurante.service.ItemService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class ItemServiceImpl implements ItemService {

    private static final Logger logger = LoggerFactory.getLogger(ItemServiceImpl.class);

    @Autowired
    private UsuarioDao usuarioDao;

    @Autowired
    private PlatoDao platoDao;

    @Autowired
    private FacturaDao facturaDao;

    @Autowired
    private VentaDao ventaDao;

    @Override
    public List<Item> gets() {
        return listaItems;
    }

    @Override
    public Item get(Item item) {
        for (Item i : listaItems) {
            if (i.getIdPlato().equals(item.getIdPlato())) {
                return i;
            }
        }
        return null;
    }

    @Override
    public void delete(Item item) {
        listaItems.removeIf(i -> i.getIdPlato().equals(item.getIdPlato()));
    }

    @Override
    public void save(Item item) {
        boolean existe = false;
        for (Item i : listaItems) {
            if (i.getIdPlato().equals(item.getIdPlato())) {
                existe = true;
                if (i.getCantidad() < i.getExistencias()) {
                    i.setCantidad(i.getCantidad() + 1);
                } else {
                    logger.warn("No hay suficientes existencias para el plato: " + i.getDescripcion());
                }
                break;
            }
        }
        if (!existe) {
            item.setCantidad(1);
            listaItems.add(item);
        }
    }

    @Override
    public void update(Item item) {
        for (Item i : listaItems) {
            if (i.getIdPlato().equals(item.getIdPlato())) {
                if (item.getCantidad() <= i.getExistencias()) {
                    i.setCantidad(item.getCantidad());
                } else {
                    logger.warn("No hay suficientes existencias para el plato: " + i.getDescripcion());
                }
                break;
            }
        }
    }

    @Override
    @Transactional
    public void facturar() {
        String username = getAuthenticatedUsername();
        if (username.isBlank()) {
            logger.error("El nombre de usuario está en blanco, no se puede proceder con la facturación.");
            return;
        }

        Usuario usuario = usuarioDao.findByUsername(username);
        if (usuario == null) {
            logger.error("Usuario no encontrado: " + username);
            return;
        }

        Factura factura = new Factura(usuario.getIdUsuario());
        factura = facturaDao.save(factura);

        double total = 0;
        for (Item i : listaItems) {
            logger.info("Procesando plato: " + i.getDescripcion());
            Venta venta = new Venta(factura.getIdFactura(), i.getIdPlato(), i.getPrecio(), i.getCantidad());
            ventaDao.save(venta);

            Plato plato = platoDao.getReferenceById(i.getIdPlato());
            plato.setExistencias(plato.getExistencias() - i.getCantidad());
            platoDao.save(plato);

            total += i.getCantidad() * i.getPrecio();
        }

        factura.setTotal(total);
        facturaDao.save(factura);

        listaItems.clear();
    }

    private String getAuthenticatedUsername() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails userDetails) {
            return userDetails.getUsername();
        } else {
            return principal.toString();
        }
    }
}
