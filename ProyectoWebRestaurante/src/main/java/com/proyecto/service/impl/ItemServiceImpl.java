
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

/**
 *
 * @author user
 */
@Service
public class ItemServiceImpl implements ItemService {

    @Override
    public List<Item> gets() {
        return listaItems;
    }
//Busca en el array list y si lo encuentra lo retorna... si no lo encuentra retorna null

    @Override
    public Item get(Item item) {
        for (Item i : listaItems) {
            if (i.getIdPlato() == item.getIdPlato()) {
                return i;
            }
        }
        return null;
    }

    @Override
    public void delete(Item item) {
        var existe = false;
        var posicion = -1;

        for (Item i : listaItems) {
            posicion++;
            if (i.getIdPlato() == item.getIdPlato()) {
                existe = true;
                break;
            }
        }
        if (existe) {
            listaItems.remove(posicion);
        }
    }

    @Override
    public void save(Item item) {
        var existe = false;
        //Busca si el item ya existe en el carrito. 
        for (Item i : listaItems) {
            if (i.getIdPlato()== item.getIdPlato()) {
                existe = true;

                if (i.getCantidad() < i.getExistencias()) {
                    i.setCantidad(i.getCantidad() + 1);
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
            if (i.getIdPlato() == item.getIdPlato()) {
                i.setCantidad(item.getCantidad());
                break;
            }
        }
    }


    @Autowired
    private UsuarioDao usuarioDao;
    @Autowired
    private PlatoDao platoDao;
    @Autowired
    private FacturaDao facturaDao;
    @Autowired
    private VentaDao ventaDao;

    @Override
    public void facturar() {
        //Debemos recuperar el usuario autenticado...

        String username;
        Object principal = SecurityContextHolder //Todo esto es para recuperar la info del usuario
                .getContext()
                .getAuthentication()
                .getPrincipal();

        if (principal instanceof UserDetails userDetails) {
            username = userDetails.getUsername();
        } else {
            username = principal.toString();
        }

        if (username.isBlank()) {
            System.out.println("username en blanco");
            return;
        }

        Usuario usuario = usuarioDao.findByUsername(username);
        if (usuario == null) {
            System.out.println("Usuario no encontrado" + username);
            return;
        }

        //Debemos generar la factura para tener idFactura
        Factura factura = new Factura(usuario.getIdUsuario());
        factura = facturaDao.save(factura);

// Debemos registrar los platos vendidos
        double total = 0;
        for (Item i : listaItems) {
            System.out.println("Procesando plato: " + i.getDescripcion());
            Venta venta = new Venta(factura.getIdFactura(),
                    i.getIdPlato(),
                    i.getPrecio(),
                    i.getCantidad());
            ventaDao.save(venta);
            Plato plato
                    = platoDao.getReferenceById(i.getIdPlato());
            plato.setExistencias(plato.getExistencias()
                    - i.getCantidad());
            platoDao.save(plato);
            total += i.getCantidad() * i.getPrecio();
        }

// Debemos actualizar la factura con la venta total
        factura.setTotal(total);
        facturaDao.save(factura);
        listaItems.clear();
        //Debemos actualizar la factura con la venta total
    }

}
