package com.ProyectoWebRestaurante.service.impl;

import com.ProyectoWebRestaurante.dao.UsuarioDao;
import com.ProyectoWebRestaurante.domain.Rol;
import com.ProyectoWebRestaurante.domain.Usuario;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("userDetailsService")
public class UsuarioDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UsuarioDao usuarioDao;
    
   @Autowired
private HttpSession session;


    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //Busca un usuario en la tabla de usuarios...
        Usuario usuario = usuarioDao.findByUsername(username);
        //Se valida si se recuperó un usuario
        if (usuario == null) {  //No se encontró
            throw new UsernameNotFoundException(username);
        }
        //imagen usuario
        session.removeAttribute("imagenUsuario");
        session.setAttribute("imagenUsuario",usuario.getRutaImagen());

        //Si estamos acá... entonces se encontró el usuario
        var roles = new ArrayList<GrantedAuthority>();
        
        for (Rol r: usuario.getRoles()){
            roles.add(new SimpleGrantedAuthority(r.getNombre()));
        }
        //Aca ya se tiene toda la info del usuario 
        return new User(usuario.getUsername(),usuario.getPassword(),roles);
    }

}
