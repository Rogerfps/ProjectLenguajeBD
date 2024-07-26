package com.ProyectoWebRestaurante;


import java.util.Locale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@Configuration
public class ProjectConfig implements WebMvcConfigurer {

    @Bean
    public LocaleResolver localeResolver() {
        var slr = new SessionLocaleResolver();
        slr.setDefaultLocale(Locale.getDefault());
        slr.setLocaleAttributeName("session.current.locale");
        slr.setTimeZoneAttributeName("session.current.timezone");
        return slr;
    }

    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        var lci = new LocaleChangeInterceptor();
        lci.setParamName("lang");
        return lci;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registro) {
        registro.addInterceptor(localeChangeInterceptor());
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registro) {
        registro.addViewController("/").setViewName("index");
        registro.addViewController("/index").setViewName("index");
        registro.addViewController("/login").setViewName("login");
        registro.addViewController("/registro/nuevo").setViewName("registro/nuevo");
    }
    
@Bean
public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    http
        .authorizeHttpRequests(auth -> auth
            // Public paths
            .requestMatchers(
                "/", "/index", "/index2",
                "/filtrar/listado", "/filtrar/query1",
                "/carrito/listado", "/carrito/agregar/**", "/carrito/eliminar/**", "/carrito/modificar/**",
                "/registro/**", "/registro/nuevo", "/registro/salida", "/registro/activa", "/registro/recordar",
                "/navegar/listado", "/navegar/listado/**",
                "/reservacion/guardar", "/reservacion/eliminar/**", "/reservacion/modificar/**",
                "/plato/listado", "/ordenar",
                "/css/**", "/js/**", "/webjars/**"
            )
            .permitAll()

            // User-specific paths
            .requestMatchers("/facturar/carrito")
            .hasRole("USER")

            // Vendor-specific paths
            .requestMatchers("/plato/listado", "/categoria/listado")
            .hasRole("VENDEDOR")

            // Admin-exclusive paths
            .requestMatchers(
                "/categoria/listado", "/categoria/nuevo", "/categoria/modificar/**", "/categoria/eliminar/**", "/categoria/guardar",
                "/plato/nuevo", "/plato/modificar/**", "/plato/eliminar/**", "/plato/guardar", "/pruebas/**"
            )
            .hasRole("ADMIN")

            // Any other authenticated access
            .anyRequest().authenticated()
        )
        .formLogin(form -> form
            .loginPage("/login")
            .defaultSuccessUrl("/index", true)
            .permitAll()
        )
        .logout(logout -> logout
            .logoutSuccessUrl("/")
            .permitAll()
        );

    return http.build();
}


//    
//    @Bean
//    public UserDetailsService users() {
//        //Se definen 3 usurio con roles 
//        UserDetails admin = User.builder()
//                .username("juan")
//                .password("{noop}123")
//                .roles("ADMIN", "VENDEDOR", "USER")
//                .build();
//
//        UserDetails vendedor = User.builder()
//                .username("lafit")
//                .password("{noop}456")
//                .roles("VENDEDOR", "USER")
//                .build();
//
//        UserDetails cliente = User.builder()
//                .username("allan")
//                .password("{noop}789")
//                .roles("USER")
//                .build();
//
//        return new InMemoryUserDetailsManager(admin, vendedor, cliente);
//    }
//     
    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder builder) throws Exception {
        builder.userDetailsService(userDetailsService)
                .passwordEncoder(new BCryptPasswordEncoder());
    }

}
