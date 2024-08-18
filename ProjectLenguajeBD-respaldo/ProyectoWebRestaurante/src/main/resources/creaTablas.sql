DROP SCHEMA IF EXISTS DondePapa;
DROP USER IF EXISTS 'userDondePapa'@'%';

CREATE SCHEMA DondePapa;
CREATE USER 'userDondePapa'@'%' IDENTIFIED BY 'CntrDondePapa.';
GRANT ALL PRIVILEGES ON DondePapa.* TO 'userDondePapa'@'%';
FLUSH PRIVILEGES;

/*Se crea la tabla de CATEGORIAS  */
CREATE TABLE DondePapa.categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255),
    disponible BOOLEAN,
    ruta_imagen VARCHAR(1024)
);
/*Se crea la tabla de PLATOS  */
CREATE TABLE DondePapa.plato (
  id_plato INT NOT NULL AUTO_INCREMENT,
  id_categoria INT NOT NULL,
  descripcion VARCHAR(255) NOT NULL,  
  detalle VARCHAR(1600) NOT NULL, 
  precio double, 
  existencias int NOT NULL,  
  ruta_imagen varchar(1024),
  disponible bool,
  PRIMARY KEY (id_plato),
  foreign key fk_producto_caregoria (id_categoria) references categoria(id_categoria)  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE DondePapa.reservacion (
    id_reservacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    hora TIME,
    numero_de_mesa INT,
    contacto VARCHAR(255)  
);

/*Se crea la tabla de USUARIOS  */
CREATE TABLE DondePapa.usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  username varchar(20) NOT NULL,
  password varchar(512) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(1024) NULL,
  telefono VARCHAR(15) NULL,
  ruta_imagen varchar(1024),
  activo boolean,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/*se crea la tabla factura*/
create table Dondepapa.factura (
  id_factura INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  fecha date,  
  total double,
  estado int,
  PRIMARY KEY (id_factura),
  foreign key fk_factura_usuario (id_usuario) references usuario(id_usuario)  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/*Se crea la tabla de VENTAS  */
CREATE TABLE Dondepapa.venta (
  id_venta INT NOT NULL AUTO_INCREMENT,
  id_factura INT NOT NULL,
  id_plato INT NOT NULL,
  precio DOUBLE, 
  cantidad INT,
  PRIMARY KEY (id_venta),
  FOREIGN KEY fk_ventas_factura (id_factura) REFERENCES factura(id_factura),
  FOREIGN KEY fk_ventas_plato (id_plato) REFERENCES plato(id_plato)  -- Asumiendo que la referencia correcta es a una tabla plato
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


/*Se crea la tabla de rol llamada rol... igual que la clase rol */
create table DondePapa.rol (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre varchar(20),
  id_usuario int,
  PRIMARY KEY (id_rol),
  foreign key fk_rol_usuario (id_usuario) references usuario(id_usuario)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/*se crea la tabla transacciones*/
CREATE TABLE DondePapa.transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo VARCHAR(50),
    monto DECIMAL(10, 2),
    fecha DATE,
    descripcion VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

/*INSERTS*/
INSERT INTO DondePapa.categoria (descripcion, disponible, ruta_imagen) VALUES 
/*1*/('Ensaladas', true, 'https://i.blogs.es/b8b596/apertura-apaisada-ensaladas/1366_2000.jpg'),
/*2*/('Sándwiches', true, 'https://i.blogs.es/1cbc97/collage_sanwich/1366_2000.jpg'),
/*3*/('Sopas', true, 'https://i.blogs.es/4f9a7f/collage-seis-fotos-portada-dap/650_1200.jpg'),
/*4*/('Wraps', true, 'https://www.gourmet.cl/wp-content/uploads/2016/09/wrap-de-pollo.jpg-editada.jpg'),
/*5*/('Quesadillas', true, 'https://www.lechedeflorida.com/core/fileparse.php/267/urlt/BBQ-PORK-QUESADILLA-web.png'),
/*6*/('Ticos', true, 'https://i.ytimg.com/vi/VCIc5JO_6pQ/maxresdefault.jpg'),
/*7*/('Arroz', true, 'https://www.ecestaticos.com/image/clipping/1440/1080/c45466fb9f76baa6eebf80a4194592d7/los-trucos-para-que-te-quede-el-arroz-perfecto.jpg'),
/*8*/('Mariscos', true, 'https://www.eluniversal.com.mx/resizer/04M0CFm2P8H_U3CdE4co_RWqRkQ=/1100x666/cloudfront-us-east-1.images.arcpublishing.com/eluniversal/PEKLULINHNCMHM3DVNV6ORRI5M.jpg'),
/*9*/('Pastas', true, 'https://casadiromavlc.com/wp-content/uploads/2019/08/tipos-de-pastas-y-salsas-cover-1080x675.jpg'),
/*10*/('Pollos', true, 'https://s1.eestatic.com/2015/06/10/cocinillas/cocinillas_40006005_116187701_1706x960.jpg'),
/*11*/('Hamburguesas', true, 'https://cdn2.cocinadelirante.com/sites/default/files/images/2023/08/recetas-de-hamburguesas-caseras.jpg'),
/*12*/('Carnes', true, 'https://img.freepik.com/foto-gratis/carne-cruda-mesa_23-2150857912.jpg'),
/*13*/('Guarniciones', true, 'https://static.bonviveur.es/tags/las-mejores-recetas-de-guarniciones.jpg'),
/*14*/('Especial', true, 'https://previews.123rf.com/images/acceptphoto/acceptphoto1703/acceptphoto170300049/73290879-variedad-de-platos-especiales-en-peque%C3%B1as-placas-blancas.jpg'),
/*15*/('Para Picar', true, 'https://hips.hearstapps.com/hmg-prod/images/huevos-rellenos-de-hummus-1552479730.jpg'),
/*16*/('Bocas del mar', true, 'https://www.bocasdelmar.com/wp-content/uploads/2019/01/eatandrink2.jpg'),
/*17*/('tacos gallos', true, 'https://www.cocinatis.com/archivos/202207/tacos-mexicanos-con-pico-gallo_large_16x9.jpg'),
/*18*/('Bocas y tierra tica', true, 'https://media-cdn.tripadvisor.com/media/photo-s/1b/4e/54/49/plato-de-bocas-surtido.jpg'),
/*19*/('Bocas clasicas', true, 'https://enbocacr.com/wp-content/uploads/2023/06/platos-enboca-2023-1.jpg'),
/*20*/('Bebidas Donde Papá', true, 'https://aprende.com/wp-content/uploads/2022/10/bebidas-naturales.jpg'),
/*21*/('Licores', true, 'https://thefoodtech.com/wp-content/uploads/2020/05/productos-diaego.jpg'),
/*22*/('Postres', true, 'https://i.blogs.es/1c733d/postres/1366_2000.jpg');

INSERT INTO DondePapa.plato (descripcion, detalle, precio,existencias, id_categoria, disponible, ruta_imagen) VALUES 
('Ensalada César', 'Con quesito parmesano y cuadritos de pan tostado con nuestro pollo grill.', 4500,10, 1 , true, 'https://www.gourmet.cl/wp-content/uploads/2016/09/Ensalada_C%C3%A9sar-web-553x458.jpg'),
('Ensalada Caprese', 'ensalada italiana de san pelegrino resaltada por rodajas de tomate y el sabor de la albahaca fresca.', 4500, 10,1, true, 'https://i.blogs.es/5ca73e/ensalada-caprese-rehacer-pakus-dap/1366_2000.jpg'),
('Ensalada Pescado', 'Ensalada con cuadritos de pan tostado con nuestro empanizado, al ajillo o grill', 4500, 10,1, true, 'https://www.recetasnestle.com.do/sites/default/files/srh_recipes/47b45c7192d1d88acff53e7064202d4f.jpg'),
('Sándwich de Pollo', 'Con pan ciabatta, nuestro sándwich de pollo, lechuga, tomate y deliciosas salsa clásicas', 3700, 10,2, true, 'https://images.aws.nestle.recipes/original/0dcdbe631b092077fd7e411236c4b06d_sandwich_de_pollo_a_las_finas_hierbas_-_mx_ponte_bien.jpg'),
('Sándwich de Jamón y Queso', 'Deliciosa crepa de pollo en su salsa blanca', 3200,10, 2, true, 'https://www.comedera.com/wp-content/uploads/2021/03/sandwich-de-jamon-y-queso.jpg'),
('Sándwich de Carne', 'Con pan ciabatta, nuestro sándwich de jamón y queso, lechuga, tomate y deliciosas salsa clásicas.', 4000, 10,2, true, 'https://www.gourmet.cl/wp-content/uploads/2016/05/Sandwich-de-Carne-Mechada-con-cebolla-caramelizada-y-tomates-asados.jpg'),
('Sopa Azteca', 'la sopa de tomate por excelencia traída directo de méxico por papá.', 4000, 10,3, true, 'https://cdn0.recetasgratis.net/es/posts/6/0/5/sopa_azteca_35506_600_square.jpg'),
('Sopa de Mariscos', 'Compuesta por mariscos frescos, y el toque esencial de papá.', 4500, 10,3, true, 'https://www.comedera.com/wp-content/uploads/2018/03/sopa-de-marisco.jpg'),
('Sopa de Pollo', 'Para sacarnos de cualquier apuro, la sopa curativa clásica.', 3300,10,3, true, 'https://especiasmontero.com/wp-content/uploads/2018/02/CaldoDePollo-1.jpg'),
('Sopa de Rabo', 'Sacando lo mejor de los ingredientes traemos la sopa preferida de papá.', 4000,10,3, true, 'https://rumbameats.com/wp-content/uploads/2019/07/Hervido-de-_rabo-by-enrilemoine-7.jpg'),
('Sopa de Mondongo', 'Sopa tradicional de la tierra costarricense para un antojo de antaño.', 3500,10,3, true, 'https://recetasdemicolombia.com/wp-content/uploads/2020/08/mondongo-500x375.jpg'),
('Wrap de Pollo y Bacon', 'Wrap relleno de pollo empanizado, delicioso tocino y nuestra salsa mayonesa chipotle.', 3500,10,4, true, 'https://i.pinimg.com/736x/72/86/1b/72861baeaccca244bf2fee091a7dc675.jpg'),
('Wrap corvina', 'Wrap con pescado empanizado y nuestra clásica salsa tártara.', 3500,10,4, true, 'https://i.pinimg.com/736x/f5/f7/9a/f5f79aa520c59e342d7c08a8fe3e9174.jpg'),
('Quesadillia Crêpe', 'Deliciosa crepa de pollo en su sala blanca.', 3500,10,5, true, 'https://thasneen.com/cooking/wp-content/uploads/2017/06/Indian-style-Quesadilla.jpg'),
('Quesadillias de Pollo o Carne ', 'Con dos quesos, mozzarela y cheddar, disfrútalas como quieras!', 3700,10,5, true, 'https://i.ytimg.com/vi/7J5JqSOP-1s/maxresdefault.jpg'),
('Quesadillias mixtas ', 'Mezcla de los dos mundos, pollo y carne en uno solo.', 4000,10,5, true, 'https://assets.unileversolutions.com/recipes-v2/231998.jpg'),
('Casados', 'Clásico plato que todos los ticos reconocemos, salvador de tandas, escoge entre mechada, pescado, pollo, chuleta o bistec.', 3500,10,6, true, 'https://upload.wikimedia.org/wikipedia/commons/0/08/Casado_costarricense.png'),
('Chifrijo', 'Para los amantes de la combinación del chicharrón, frijoles y arroz, servido con el clásico oro verde y tortillitas para que amarre.', 3500,10,6, true, 'https://okdiario.com/img/2020/05/07/receta-de-costa-rica_-chifrijo-1.jpg'),
('Chicharrones', 'El sabor de Puriscal hasta tu mesa, servido con yuca frita y ensalada a lo tico.El sabor de Puriscal hasta tu mesa, servido con yuca frita y ensalada a lo tico.', 3800,10,6, true, 'https://www.cocinatis.com/archivos/202308/ctis1012-receta-chicharrones-de-cerdo-andaluces-1280x720x80xX.jpg'),
('Lengua en Salsa', 'Atrévete a probar nuestra suave lengua en salsa de tomate, calla hasta los más bocónes con su sabor.', 4800,10,6, true, 'https://www.recetascostarica.com/base/stock/Recipe/272-image/272-image_web.jpg'),
('Patitas de Cerdo', 'Patitas de cerdo con frijolitos blancos, plato lleno de puro sabor donde mi tata.', 4000,10,6, true, 'https://www.nutricienta.com/imagenes/alimentos/alimento-nutricienta-manitas-de-cerdo.jpg'),
('Patacones', 'Perfecto para quitarse esas ganas de comer a lo tico, nuestros patacones vienen con carne mechada, frijoles molidos y pico de gallo.', 3700,10,6, true, 'https://www.semana.com/resizer/D-Lcez1Rj4bSIUHKyMk9rwDRIMY=/1280x720/smart/filters:format(jpg):quality(80)/cloudfront-us-east-1.images.arcpublishing.com/semana/CUVSFJ3V5ZEWVLBJ76BASDV2PY.jpg'),
('Rice and Beans', 'Limón presente en el menú de papá, pollo en salsa caribeña con ensalada y maduros con el inigualable rice and beans.', 4500,10,6, true, 'https://www.allrecipes.com/thmb/YywjEMDfUzEtxUR_8i_B_4dd-7o=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/211325-b6b1befbb1644f9b93e66eee74dbe07f.jpg'),
('Chilli Relleno', 'Relleno de carne molida, un excelente plato para el buen tico.', 4200,10,6, true, 'https://www.jennieo.com/wp-content/uploads/2019/11/image-recipe_turkey-and-spinach-chile-relleno-with-fresh-tomato-sauce.jpg'),
('Arroz con Carne', 'Arroz directo de la casa compuesto por una combinación perfecta de arroz y carne.', 4000,10,7, true, 'https://recetacubana.com/wp-content/uploads/2019/12/receta-Arroz-con-Carne-de-Cerdo.jpg'),
('Arroz con Pollo', 'Arroz con el pollo desmechado clásico, haciendo de este un plato típico delicioso.', 3700,10,7, true, 'https://img.bekiacocina.com/cocina/0000/179-h.jpg'),
('Arroz con Marinera', 'Elaborado con los mariscos más frescos seleccionados por papá.', 4500,10,7, true, 'https://www.elespectador.com/resizer/iSDLgK_Xt86uhsXCmvAN_Jp0Elk=/1200x675/filters:quality(60):format(jpeg)/cloudfront-us-east-1.images.arcpublishing.com/elespectador/QT2HQD77JJGDTIYXU4COEHGIRE.jpg'),
('Arroz con Camarones', 'Arroz con camarones de alta calidad para saciar los paladares hambrientos.', 4500,10,7, true, 'https://www.recetasnestle.com.ec/sites/default/files/srh_recipes/b5761ed0a862a8c3ae9980304cd22ded.jpg'),
('Pomodoro', 'Nuestra pasta en salsa de tomate con delicioso queso mozzarella.', 3500,10,9, true, 'https://supermancooks.com/wp-content/uploads/2023/03/pasta-pomodoro-featured.jpg'),
('Bolognese', 'Deliciosa pasta con queso mozzarella, salsa de tomate y carne molida.', 3800,10,9, true, 'https://feelgoodfoodie.net/wp-content/uploads/2023/04/Pasta-Bolognese-TIMG.jpg'),
('Marinera', 'Salsa de tomate o salsa blanca con mariscos o solo camarones.', 4500,10,9, true, 'https://newmansown.com/wp-content/uploads/2022/03/shrimp-marinara-with-pasta.png'),
('Alfredo', 'Pasta con jamón y hongos en salsa blanca.', 4000,10,9, true, 'https://images.aws.nestle.recipes/resized/cc72869fabfc2bdfa036fd1fe0e2bad8_creamy_alfredo_pasta_long_left_1080_850.jpg'),
('Filet de Corvina', 'Filet de corvina al grill, al ajillo o empanizado.', 4800,10,8, true, 'https://pronacatqma.com/images/com_yoorecipe/banner_superior/8264_1.jpg'),
('Corvina Entera', 'Nuestra especial corvina entera sin espinas lista para ti.', 6700,10,8, true, 'https://canalcocina.es/medias/images/1101_CocContigo_CorvinaHorno.jpg'),
('Pargo Entero', 'Pargo entero fresco para los que quieran recordar los días de playa.', 5800,10,8, true, 'https://d1uz88p17r663j.cloudfront.net/original/cd153cfbb9d153b1786c7d45adac52b2_Pargo-rojo-al-sarten.png'),
('Corvina Entera a la Caribeña', 'Nuestra especial corvina entera acompañada de salsa caribeña y camarones.', 8700,10,8, true, 'https://media-cdn.tripadvisor.com/media/photo-s/18/2f/ec/5f/corvina-entera-frita.jpg'),
('Camarones', 'Jugosos camarones empanizados o al ajillo para los fanáticos del mar.', 4700,10,8, true, 'https://cloudfront-us-east-1.images.arcpublishing.com/elespectador/WFY4CMXRGZD3TA2FXSRPU7UDOA.jpg'),
('Mariscada', 'Mix de mariscos frescos cocinados al ajillo creando un platillo colorido.', 4500,10,8, true, 'https://imag.bonviveur.com/mariscada-gallega.jpg'),
('Mejillones', 'Mejillones noruegos al ajillo seleccionados por papá.', 4800,10,8, true, 'https://coyomar.es/wp-content/uploads/2022/06/Como-cocer-mejillones-1024x768.jpg'),
('Pollo al Grill', 'Nuestro especial pollo, tratado por la mano de nuestros chefs, a la parrilla.', 4000,10,10, true, 'https://storage.googleapis.com/fitia-api-bucket/media/images/recipe_images/1006680.jpg'),
('Pollo al la Jalapeña', 'Pollo parrillero con ganas de más fuego, bañado en nuestra salsa especial de jalapeños.', 4500,10,10, true, 'https://i.ytimg.com/vi/ChLkloORDfU/maxresdefault.jpg'),
('Pollo Cordon Bleu', 'Nuestro pollo en un platillo fabuloso, cordon bleu bañado en salsa blanca.', 4000,10,10, true, 'https://i.ytimg.com/vi/i2fwv6beoT8/maxresdefault.jpg'),
('Hamburguesa Donde Papá', 'Exquisita hamburguesa de papá, pulled pork BBQ, pepinillos, bacon, aros de cebolla.', 4800,10,11, true, 'https://delination.com/wp-content/uploads/2022/11/Hamburguesa-casera-de-res-con-papas-850x550.jpeg'),
('Hamburguesa de Pollo', 'Una de las mejores hamburguesas para los fans del pollo a la parrilla.', 4500,10,11, true, 'https://www.comedera.com/wp-content/uploads/2023/07/Hamburguesa-de-pollo-picante.jpg'),
('Hamburguesa con Queso', 'Hamburguesa con queso de papá, para saborear a gusto.', 3500,10,11, true, 'https://pronacatqma.com/images/com_yoorecipe/banner_superior/18096_1.jpg'),
('Hamburgueza de Pescado', 'Hamburguesa de pescado con salsa tártara, lechuga y queso amarillo, solo... donde papá.', 4200,10,11, true, 'https://editorialtelevisa.brightspotcdn.com/wp-content/uploads/2020/03/recetas-con-filete-de-pescado-fa%25CC%2581ciles-hamburguesa.jpg'),
('Costillas', 'Costilla de cerdo cocinada especialmente 3 horas por nuestros chefs.', 4800,10,14, true, 'https://t1.uc.ltmcdn.com/es/posts/3/9/5/como_hacer_costillas_bbq_en_sarten_50593_orig.jpg'),
('Churrasco ', 'Este delicioso corte proviene de la falda de la res, cortado transversalmente, tratado por papá.', 5800,10,12, true, 'https://cdn0.recetasgratis.net/es/posts/2/3/1/churrasco_a_lo_pobre_77132_orig.jpg'),
('Churrasco a la Jalapeña ', 'Churrasco en nuestra salsa especial a la jalapeña para darle su perfecto toque picante.', 6500,10,12, true, 'https://media-cdn.tripadvisor.com/media/photo-m/1280/29/75/59/9e/churrasco-tipico.jpg'),
('Lomito ', 'Destacado por su suavidad natural, este corte de características jugosas puede saciar a cualquiera.', 6200,10,12, true, 'https://www.clarin.com/2021/07/26/u-aUfp64d_1200x0__1.jpg'),
('Lomito a la jalapeña', 'Para aquellos que quieran probar la parrilla de papá, el suave lomito en combinación con nuestro toque a la jalapeña.', 6800,10,12, true, 'https://media-cdn.tripadvisor.com/media/photo-s/11/0c/bc/c4/puntas-de-lomito-a-la.jpg'),
('Puré', 'Suave y cremoso puré de papas, hecho con papas seleccionadas y un toque de mantequilla, ideal para complementar cualquier plato principal. Servido caliente', 1000,10,13, true, 'https://images.aws.nestle.recipes/original/892d65cba81876ed7c340ae9ce7663d3_DCS_MARZO_INSTAGRAM-04.jpg'),
('Vegetales', 'Mix de vegetales de temporada, cocidos al vapor para preservar su frescura y sabor natural. Una opción saludable y colorida.', 1000,10,13, true, 'https://cdn.aarp.net/content/aarpe/es/home/salud/vida-saludable/info-2023/comer-vegetales-verduras-crudos-o-cocidos/_jcr_content/root/container_main/container_body_main/container_body1/container_body_cf/container_image/articlecontentfragment/cfimage.coreimg.50.932.jpeg/content/dam/aarp/health/healthy-living/2023/07/1140-colorfulrawveggies-esp.jpg'),
('Papas asadas', 'Papas asadas hasta lograr una piel crujiente y un interior suave, sazonadas con hierbas finas y un toque de aceite de oliva.', 1000,10,13, true, 'https://www.gourmet.cl/wp-content/uploads/2014/09/Papas-Asadas.jpg'),
('Arroz', 'Arroz blanco esponjoso, cocido a la perfección, un básico indispensable para acompañar una variedad de platos.', 1000,10,13, true, 'https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/05bab5cb-f8b6-487d-a509-f38031ea2708/Derivates/142b07d0-cedc-44f8-8569-e0222afab308.jpg'),
('Papas fritas', 'Papas fritas doradas y crujientes, cortadas a mano y fritas en aceite de alta calidad, con un toque de sal marina para realzar su sabor.', 1000,10,13, true, 'https://phantom-marca.unidadeditorial.es/813d16708dc72860fd3cf319c9a245b5/resize/828/f/jpg/assets/multimedia/imagenes/2023/08/04/16911461030527.jpg'),
('Yuca Frita', 'Yuqitas a lo tico, fritas apenas para un gusto.', 1800,10,15, true, 'https://mexicanappetizersandmore.com/wp-content/uploads/Yuca-Frita-1-12.jpg'),
('Patacones', 'Patacones clásicos con frijoles molidos y pico de gallo.', 1800,10,15, true, 'https://images.hola.com/imagenes/cocina/recetas/20200320163599/receta-patacones-platano/0-800-862/patacones-adobe-m.jpg'),
('Aros de Cebolla', 'Aros de cebolla crujientes por y por dentro!', 2200,10,15, true, 'https://images.hola.com/imagenes/cocina/recetas/20220209204312/aros-cebolla-crujientes/1-49-243/aros-cebolla-adobe-t.jpg'),
('Papas Gajo', 'El estilo de papas facoritas de papá, pide las que quieres.', 2200,10,15, true, 'https://www.paulinacocina.net/wp-content/uploads/2023/11/receta-de-papas-gajo-Paulina-Cocina-Recetas.jpg'),
('Papas Francesas', 'Papas fritas apenas para acompañar tu comida.', 1800,10,15, true, 'https://www.paulinacocina.net/wp-content/uploads/2015/08/P1140112-e1439267676931.jpg'),
('Palitos de Queso', 'Palitos de queso mozzarella, de la mejor compañia que puedas tener.', 2200,10,15, true, 'https://mandolina.co/wp-content/uploads/2023/06/deditos-de-queso-1200x900.png'),
('Gallos de salchichón', 'Deliciosos gallos de salchicho.', 2000,10,17, true, 'https://tortiricascentroamerica.com/wp-content/uploads/2016/01/receta-tortiricas-gallitos-faciles.png'),
('Gallos de Chorizo', 'Deliciosos gallos de chorizo.', 2000,10,17, true, 'https://cloudfront-us-east-1.images.arcpublishing.com/gruponacion/QZ7BD6VNOVFFPDH7VAWWQTRFTY.jpg'),
('Tacos ', 'Deliciosos tacos.', 2000,10,17, true, 'https://www.comedera.com/wp-content/uploads/2017/08/tacos-al-pastor-receta.jpg'),
('Tacos de Camaron', 'Deliciosos tacos de camaron.', 2700,10,17, true, 'https://t2.uc.ltmcdn.com/es/posts/2/8/1/como_hacer_tacos_de_camaron_enchilado_51182_orig.jpg'),
('Frijoles Blancos', 'Clásicos frijoles blancos cocidos a la perfección, suaves y llenos de sabor casero', 1000,10,18, true, 'https://cdn0.recetasgratis.net/es/posts/7/2/8/sopa_de_frijoles_blancos_9827_600_square.jpg'),
('Frijoles tiernos', 'Tiernos frijoles verdes sazonados, el complemento perfecto para cualquier comida.', 1000,10,18, true, 'https://www.recetascostarica.com/base/stock/Recipe/322-image/322-image_web.jpg'),
('Sopa de Rabo', 'Rico caldo de rabo de res, cocinado lentamente para extraer todo su sabor y textura suculenta.', 1000,10,18, true, 'https://img-global.cpcdn.com/recipes/cec4a759fb426896/400x400cq70/photo.jpg'),
('Sopa Mondongo', 'Tradicional sopa mondongo, rica en sabores y con un toque de hierbas aromáticas', 1000,10,18, true, 'https://d1kxxrc2vqy8oa.cloudfront.net/wp-content/uploads/2019/02/24204837/RFB-1502-3-sopademondongo.jpg'),
('Morcilla', 'Morcilla tierna y jugosa, una verdadera delicia para los amantes de la comida tica.', 1000,10,18, true, 'https://elpais.com/especiales-branded/la-despensa/2020/ingredientes-de-la-morcilla-sin-sangre/img/1589360875_961507_1589361487_noticia_normal.jpg'),
('Pejibayes', 'Pejibayes cocidos servidos con una pizca de sal, un snack saludable y delicioso', 1000,10,18, true, 'https://www.nacion.com/resizer/NOoBl1-IpFPQNnOc154_IFSeCJ8=/1440x0/filters:format(jpg):quality(70)/arc-anglerfish-arc2-prod-gruponacion.s3.amazonaws.com/public/GZSHV4LJJBCIJNXJRVIQZP7NUQ.jpg'),
('Patitas de Cerdo', 'Patitas de cerdo cocinadas hasta quedar tiernas, bañadas en una salsa criolla.', 1000,10,18, true, 'https://www.cocinarygozar.com/wp-content/uploads/2017/06/patas-de-puerco-en-escabeche.jpg'),
('Rice & Beans', 'El clásico caribeño: arroz con frijoles cocidos en leche de coco, acompañado de especias y hierbas.', 1000,10,18, true, 'https://buenprovecho.hn/wp-content/uploads/2019/06/rice-and-beans-e1562018432431.jpg'),
('Ceviche', 'Frescos trozos de pescado marinados en limón con cebolla, cilantro y chile.', 1000,10,16, true, 'https://cdn0.recetasgratis.net/es/posts/7/4/1/ceviche_peruano_18147_600_square.jpg'),
('Pulpo al Ajillo', 'Suave pulpo cocido al ajillo con un toque de mantequilla de ajo, tierno y lleno de sabor.', 1000,10,16, true, 'https://okdiario.com/img/2018/04/03/pulpo-ajillo.jpg'),
('Calamares', 'Aritos de calamar empanizados y fritos hasta quedar crujientes, servidos con salsa tártara', 1000,10,16, true, 'https://i.blogs.es/848be1/calamares-fritos-andaluza/1366_2000.jpg'),
('Camarones', 'Boquitas de camarones fritos, perfectos para empezar tu comida con un toque marino.', 1000,10,16, true, 'https://cdn.aarp.net/content/dam/aarp/food/modern-kitchen/2023/10/1140-omi-hopper-camarones-al-ajillo-esp.jpg'),
('Sopa de Mariscos', 'Una sopa repleta de mariscos en un caldo rico y sazonado, una delicia en cada cucharada.', 1000,10,16, true, 'https://www.comedera.com/wp-content/uploads/2018/03/sopa-de-marisco.jpg'),
('Sustancia', 'Caldo intenso de carne con verduras, un reconfortante inicio para cualquier comida.', 1000,10,19, true, 'https://cdn0.recetasgratis.net/es/posts/4/2/8/caldo_de_res_con_verduras_76824_orig.jpg'),
('Alitas', 'Alitas de pollo bañadas en salsa BBQ, pegajosas y deliciosas.', 1000,10,19, true, 'https://cdn2.cocinadelirante.com/sites/default/files/images/2024/04/receta-casera-de-alitas-picantes.jpg'),
('Chicharrón', 'Crujientes trozos de chicharrón, perfectos para picar entre amigos.', 1000,10,19, true, 'https://peopleenespanol.com/thmb/U1oN6pODNHzyjSlzd5mvUHOC498=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/249249137_466807254660902_7206085377735433302_n-2000-f3a63198788946ceb836ca100ee6bc66.jpg'),
('Costilla', 'Tiernas costillas bañadas en salsa de barbacoa, un deleite para el paladar.', 1000,10,19, true, 'https://www.comedera.com/wp-content/uploads/2016/08/costillas-al-horno.jpg'),
('Carnitas Mexicanas', 'Jugosas tiras de pollo con pimientos y cebolla, servidas en tortillas calientes."', 1000,10,19, true, 'https://cdn0.recetasgratis.net/es/posts/4/7/7/carnitas_de_puerco_36774_600.jpg'),
('Chicharrón de Pescado', 'Trozos de pescado frito al estilo chicharrón, ligeros y crujientes.', 1000,10,19, true, 'https://www.recetas-ecuatorianas.com/base/stock/Recipe/271-image-14-chicharron-de-pescado/271-image-14-chicharron-de-pescado_web.jpg'),
('Pachifrijo', 'Una combinación ganadora de chicharrón y frijoles, con un toque de pico de gallo.', 1000,10,19, true, 'https://www.comedera.com/wp-content/uploads/2022/10/chifrijo.jpg'),
('Coctel Piña Colada', 'Un clásico tropical de ron, crema de coco y jugo de piña, servido helado y decorado con un trozo de piña.', 1000,10,21, true, 'https://coctelia.com/wp-content/uploads/2018/05/pina-colada-coctel-2.jpg'),
('Coctel Bloody Mary', 'Vodka mezclado con jugo de tomate, salsa Worcestershire, jugo de limón y especias, perfecto para el brunch.', 1000,10,21, true, 'https://mejorconsalud.as.com/wp-content/uploads/2022/03/tomates-cherry-bloody-mary.jpg'),
('Coctel Mojito', 'Refrescante mezcla de ron, menta fresca, azúcar, lima y soda, ideal para refrescarse en días calurosos', 1000,10,21, true, 'https://cdn.recetasderechupete.com/wp-content/uploads/2020/02/Mojito-bar.jpg'),
('Coctel Margarita', 'Tequila, triple sec y jugo de lima, servido en un vaso con borde de sal para un toque clásico.', 1000,10,21, true, 'https://www.recetasderechupete.com/wp-content/uploads/2020/06/Margarita.jpg'),
('Coctel Sangría', 'Vino tinto mezclado con frutas frescas, un toque de brandy y un chorrito de soda, servido frío.', 1000,10,21, true, 'https://i.blogs.es/3ff0fb/sangria-20dap/450_1000.jpg'),
('Coctel Daikirí', 'Ron blanco, jugo de lima y azúcar, batido y servido frío, un homenaje a los clásicos', 1000,10,21, true, 'https://cdn.recetasderechupete.com/wp-content/uploads/2020/02/Daiquiri-c%C3%B3ctel.jpg'),
('Coctel Gin Tonic', 'Gin combinado con agua tónica y una rodaja de lima o pepino, un cóctel simple pero sofisticado.', 1000,10,21, true, 'https://recetasdecocina.elmundo.es/wp-content/uploads/2022/05/gin-tonic.jpg'),
('Shots Beso de Chocolate', 'hot dulce con licor de chocolate y un toque de crema, perfecto para los amantes del dulce.', 1000,10,21, true, 'https://editorialtelevisa.brightspotcdn.com/wp-content/uploads/2021/01/postres-con-chocolate.jpg'),
('Shots Chili-guaro', 'Una mezcla ardiente de guaro y jugo de limón con un golpe de chile picante, no apto para tímidos.', 1000,10,21, true, 'https://www.nosara.com/wp-content/uploads/2020/04/chiliguaro-costa-rica-2.jpg'),
('Shots Mamadita', 'Shot suave y frutal, ideal para empezar la noche con un toque dulce.', 1000,10,21, true, 'https://cdn0.recetasgratis.net/es/posts/7/5/5/blow_job_shot_6557_orig.jpg'),
('shot Sunrise', 'Vibrante y colorido, con tequila, jugo de naranja y un toque de granadina, como un amanecer en tu paladar.', 1000,10,21, true, 'https://cdn.tipsybartender.com/tipsybartender/jpg//wp-content/uploads/2018/01/TequilaSunriseShotThumb.jpg'),
('Coca-Cola', 'Sabrosa Coca-Cola', 1000,10,20, true, 'https://cdn-3.expansion.mx/dims4/default/1b14363/2147483647/strip/true/crop/2096x1430+0+0/resize/1200x819!/format/webp/quality/60/?url=https%3A%2F%2Fcdn-3.expansion.mx%2F95%2F6c%2F722abfb544dcb4a46b9ca967a1ef%2Fistock-499925476.jpg'),
('Agua', 'vaso de agua', 1000,10,20, true, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Trinkglas%2C_Tumbler-Form.jpg/220px-Trinkglas%2C_Tumbler-Form.jpg'),
('Te frio', 'vaso de Te Frio ', 1000,10,20, true, 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/NCI_iced_tea.jpg/240px-NCI_iced_tea.jpg'),
('Limonada', 'vaso de limonada ', 1000,10,20, true, 'https://imagenes.20minutos.es/files/image_1920_1080/uploads/imagenes/2022/07/18/limonada-casera-americana.jpeg'),
('Te de la casa', 'vaso de limonada ', 1000,10,20, true, 'https://i.blogs.es/8649ca/photo-1571934811356-5cc061b6821f/450_1000.jpg'),
('Cafe frio', 'taza de cafe frio ', 1000,10,20, true, 'https://cdn2.cocinadelirante.com/680x400/filters:format(jpg):quality(75)/sites/default/files/images/2020/03/como-hacer-un-cafe-con-leche-cremoso.jpg'),
('Fresa', 'vaso de fresa ', 1000,10,20, true, 'https://cdn7.kiwilimon.com/recetaimagen/20155/11685.jpg'),
('Crepa de Nutella clasica', 'Deliciosa Crepa de Nutella ', 3700,10,22, true, 'https://i.ytimg.com/vi/gBqpRHP70Hk/hqdefault.jpg'),
('Crepa Suzette', 'Deliciosa Crepa de suzette ', 3700,10,22, true, 'https://wickedkitchen.com/wp-content/uploads/2023/02/vegan-crepes.jpg'),
('Churchill', 'Delicioso Churchill ', 3700,10,22, true, 'https://goplaya.cr/blog/wp-content/uploads/2020/01/CHURCHILL_RIO-DE-JANEIRO-1024x768.jpg'),
('Copa de helado', 'Deliciosa Copa de helado ', 1500,10,22, true, 'https://content-cocina.lecturas.com/medio/2018/11/23/copa_de_helado_con_flan_32e73edb_600x600.jpg'),
('Cheesecake', 'Delicioso cheescake ', 2400,10,22, true, 'https://www.recetasnestlecam.com/sites/default/files/srh_recipes/07892f02f7c57b83d5703b4ee924221e.jpg'),
('Brownie', 'Delicioso cheescake ', 2200,10,22, true, 'https://images.hola.com/imagenes/cocina/recetas/20190806147074/receta-brownie-galletas-oreo/0-707-861/receta-brownie-oreo-chocolate-m.jpg');


/*Se insertan 3 registros en la tabla cliente como ejemplo */
INSERT INTO DondePapa.usuario (id_usuario, username,password,nombre, apellidos, correo, telefono,ruta_imagen,activo) VALUES 
(1,'juan','$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.','Juan', 'Castro Mora',    'jcastro@gmail.com',    '4556-8978', 'https://img.freepik.com/foto-gratis/chico-guapo-seguro-posando-contra-pared-blanca_176420-32936.jpg',true),
(2,'lafit','$2a$10$GkEj.ZzmQa/aEfDmtLIh3udIH5fMphx/35d0EYeqZL5uzgCJ0lQRi','Chuty',  'Villalobos', 'chutyvillalobos@gmail.com', '5456-8789','https://pbs.twimg.com/media/EahiQBxX0AEud1m.jpg',true),
(3,'allan','$2a$10$koGR7eS22Pv5KdaVJKDcge04ZB53iMiw76.UjHPY.XyVYlYqXnPbO','Allan', 'Allan Loria',     'allanlafit@gmail.com',      '7898-8936','https://www.diarioextra.com/files/Dnews/images/detail/500526_allanvillalobos.jpg',true);


INSERT INTO DondePapa.reservacion (nombre, hora, numero_de_mesa, contacto) VALUES 
('Juan', '14:30:00', 1, '88269654'),
('María', '13:00:00', 2, '88269655'),
('José', '20:00:00', 3, '88269656');


insert into Dondepapa.rol (id_rol, nombre, id_usuario) values
 (1,'ROLE_ADMIN',1), (2,'ROLE_VENDEDOR',1), (3,'ROLE_USER',1),
 (4,'ROLE_VENDEDOR',2), (5,'ROLE_USER',2),
 (6,'ROLE_USER',3);

INSERT INTO Dondepapa.factura (id_factura,id_usuario,fecha,total,estado) VALUES
(1,1,'2024-01-05',211560,2),
(2,2,'2024-01-07',554340,2),
(3,3,'2024-01-07',871000,2),
(4,1,'2024-01-15',244140,1),
(5,2,'2024-01-17',414800,1),
(6,3,'2024-01-21',420000,1);

INSERT INTO Dondepapa.venta (id_venta,id_factura,id_plato,precio,cantidad) values
(1,1,5,45000,3),
(2,1,9,15780,2),
(3,1,10,15000,3),
(4,2,5,45000,1),
(5,2,14,154000,3),
(6,2,9,15780,3),
(7,3,14,154000,1),
(8,3,6,57000,1),
(9,3,15,330000,2),
(10,1,6,57000,2),
(11,1,8,27600,3),
(12,1,9,15780,3),
(13,2,8,27600,3),
(14,2,14,154000,2),
(15,2,3,24000,1),
(16,3,15,330000,1),
(17,3,12,45000,1),
(18,3,10,15000,3);