-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--PROYECTO 2- LENGUAJES DE BASES DE DATOS - JUAN PABLO VINDAS SUAREZ, SEBASTIAN SEGURA SAENZ, ROGER FERNANDO PEREIRA SANCHES, MATIAS VARGAS UMA�A
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


/*Creacion del usuario y asignacion de roles*/
--Asignacion de permisos para crear el usuario 
alter session set "_ORACLE_SCRIPT"=true;

--Creacion del usuario
CREATE USER usuarioDondePapa IDENTIFIED BY "4567.";

--Asignacion de permisos de usuario 
GRANT CONNECT, RESOURCE TO usuarioDondePapa;
GRANT DBA TO usuarioDondePapa;
GRANT CREATE SESSION TO usuarioDondePapa;

/*Creacion de tablas*/

-- Crear la tabla de categor�as
CREATE TABLE categoria (
    id_categoria NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descripcion VARCHAR2(255),
    disponible NUMBER(1),
    ruta_imagen VARCHAR2(1024)
);

SELECT * FROM CATEGORIA;

-- Crear la tabla de platos
CREATE TABLE plato (
    id_plato NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_categoria NUMBER NOT NULL,
    descripcion VARCHAR2(255) NOT NULL,
    detalle VARCHAR2(1600) NOT NULL,
    precio NUMBER,
    existencias NUMBER NOT NULL,
    ruta_imagen VARCHAR2(1024),
    disponible NUMBER(1)
);

-- Crear la tabla de reservaciones
CREATE TABLE reservacion (
    id_reservacion NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(255),
    hora DATE,
    numero_de_mesa NUMBER,
    contacto VARCHAR2(255)
);

-- Crear la tabla de usuarios
CREATE TABLE usuario (
    id_usuario NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    username VARCHAR2(20) NOT NULL,
    password VARCHAR2(512) NOT NULL,
    nombre VARCHAR2(20) NOT NULL,
    apellidos VARCHAR2(30) NOT NULL,
    correo VARCHAR2(1024),
    telefono VARCHAR2(15),
    ruta_imagen VARCHAR2(1024),
    activo NUMBER(1)
);

-- Crear la tabla de facturas
CREATE TABLE factura (
    id_factura NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER NOT NULL,
    fecha DATE,
    total NUMBER,
    estado NUMBER
);

-- Crear la tabla de ventas
CREATE TABLE venta (
    id_venta NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_factura NUMBER NOT NULL,
    id_plato NUMBER NOT NULL,
    precio NUMBER,
    cantidad NUMBER
);

-- Crear la tabla de roles
CREATE TABLE rol (
    id_rol NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(20),
    id_usuario NUMBER
);

SELECT * FROM usuario;

AL


-- Crear la tabla de transacciones
CREATE TABLE transacciones (
    id_transaccion NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER NOT NULL,
    tipo VARCHAR2(50),
    monto NUMBER(10, 2),
    fecha DATE,
    descripcion VARCHAR2(255)
);

/*Asignacion de claves primarios y foraneas*/


-- Tabla plato
ALTER TABLE plato
ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);

-- Tabla factura
ALTER TABLE factura
ADD CONSTRAINT fk_factura_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);

-- Tabla venta
ALTER TABLE venta
ADD CONSTRAINT fk_ventas_factura FOREIGN KEY (id_factura) REFERENCES factura(id_factura);
ALTER TABLE venta
ADD CONSTRAINT fk_ventas_plato FOREIGN KEY (id_plato) REFERENCES plato(id_plato);

-- Tabla rol
ALTER TABLE rol
ADD CONSTRAINT fk_rol_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);

-- Tabla transacciones
ALTER TABLE transacciones
ADD CONSTRAINT fk_transacciones_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


-- Inserts en la tabla categoria
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('S�ndwiches', 1, 'https://i.blogs.es/1cbc97/collage_sanwich/1366_2000.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Sopas', 1, 'https://i.blogs.es/4f9a7f/collage-seis-fotos-portada-dap/650_1200.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Wraps', 1, 'https://www.gourmet.cl/wp-content/uploads/2016/09/wrap-de-pollo.jpg-editada.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Quesadillas', 1, 'https://www.lechedeflorida.com/core/fileparse.php/267/urlt/BBQ-PORK-QUESADILLA-web.png');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Ticos', 1, 'https://i.ytimg.com/vi/VCIc5JO_6pQ/maxresdefault.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Arroz', 1, 'https://www.ecestaticos.com/image/clipping/1440/1080/c45466fb9f76baa6eebf80a4194592d7/los-trucos-para-que-te-quede-el-arroz-perfecto.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Mariscos', 1, 'https://www.eluniversal.com.mx/resizer/04M0CFm2P8H_U3CdE4co_RWqRkQ=/1100x666/cloudfront-us-east-1.images.arcpublishing.com/eluniversal/PEKLULINHNCMHM3DVNV6ORRI5M.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Pastas', 1, 'https://casadiromavlc.com/wp-content/uploads/2019/08/tipos-de-pastas-y-salsas-cover-1080x675.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Pollos', 1, 'https://s1.eestatic.com/2015/06/10/cocinillas/cocinillas_40006005_116187701_1706x960.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Hamburguesas', 1, 'https://cdn2.cocinadelirante.com/sites/default/files/images/2023/08/recetas-de-hamburguesas-caseras.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Carnes', 1, 'https://img.freepik.com/foto-gratis/carne-cruda-mesa_23-2150857912.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Guarniciones', 1, 'https://static.bonviveur.es/tags/las-mejores-recetas-de-guarniciones.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Especial', 1, 'https://previews.123rf.com/images/acceptphoto/acceptphoto1703/acceptphoto170300049/73290879-variedad-de-platos-especiales-en-peque%C3%B1as-placas-blancas.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Para Picar', 1, 'https://hips.hearstapps.com/hmg-prod/images/huevos-rellenos-de-hummus-1552479730.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Bocas del mar', 1, 'https://www.bocasdelmar.com/wp-content/uploads/2019/01/eatandrink2.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('tacos gallos', 1, 'https://www.cocinatis.com/archivos/202207/tacos-mexicanos-con-pico-gallo_large_16x9.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Bocas y tierra tica', 1, 'https://media-cdn.tripadvisor.com/media/photo-s/1b/4e/54/49/plato-de-bocas-surtido.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Bocas clasicas', 1, 'https://enbocacr.com/wp-content/uploads/2023/06/platos-enboca-2023-1.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Bebidas Donde Pap�', 1, 'https://aprende.com/wp-content/uploads/2022/10/bebidas-naturales.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Licores', 1, 'https://thefoodtech.com/wp-content/uploads/2020/05/productos-diaego.jpg');
INSERT INTO categoria (descripcion, disponible, ruta_imagen) VALUES ('Postres', 1, 'https://i.blogs.es/1c733d/postres/1366_2000.jpg');


-- Inserts en la tabla plato
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Ensalada C�sar', 'Con quesito parmesano y cuadritos de pan tostado con nuestro pollo grill.', 4500, 10, 1, 1, 'https://www.gourmet.cl/wp-content/uploads/2016/09/Ensalada_C%C3%A9sar-web-553x458.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Ensalada Caprese', 'Ensalada italiana de san pelegrino resaltada por rodajas de tomate y el sabor de la albahaca fresca.', 4500, 10, 1, 1, 'https://i.blogs.es/5ca73e/ensalada-caprese-rehacer-pakus-dap/1366_2000.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Ensalada Pescado', 'Ensalada con cuadritos de pan tostado con nuestro empanizado, al ajillo o grill', 4500, 10, 1, 1, 'https://www.recetasnestle.com.do/sites/default/files/srh_recipes/47b45c7192d1d88acff53e7064202d4f.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('S�ndwich de Pollo', 'Con pan ciabatta, nuestro s�ndwich de pollo, lechuga, tomate y deliciosas salsa cl�sicas', 3700, 10, 2, 1, 'https://images.aws.nestle.recipes/original/0dcdbe631b092077fd7e411236c4b06d_sandwich_de_pollo_a_las_finas_hierbas_-_mx_ponte_bien.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('S�ndwich de Jam�n y Queso', 'Deliciosa crepa de pollo en su salsa blanca', 3200, 10, 2, 1, 'https://www.comedera.com/wp-content/uploads/2021/03/sandwich-de-jamon-y-queso.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('S�ndwich de Carne', 'Con pan ciabatta, nuestro s�ndwich de jam�n y queso, lechuga, tomate y deliciosas salsa cl�sicas.', 4000, 10, 2, 1, 'https://www.gourmet.cl/wp-content/uploads/2016/05/Sandwich-de-Carne-Mechada-con-cebolla-caramelizada-y-tomates-asados.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Sopa Azteca', 'La sopa de tomate por excelencia tra�da directo de M�xico por pap�.', 4000, 10, 3, 1, 'https://cdn0.recetasgratis.net/es/posts/6/0/5/sopa_azteca_35506_600_square.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Sopa de Mariscos', 'Compuesta por mariscos frescos, y el toque esencial de pap�.', 4500, 10, 3, 1, 'https://www.comedera.com/wp-content/uploads/2018/03/sopa-de-marisco.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Sopa de Pollo', 'Para sacarnos de cualquier apuro, la sopa curativa cl�sica.', 3300, 10, 3, 1, 'https://especiasmontero.com/wp-content/uploads/2018/02/CaldoDePollo-1.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Sopa de Rabo', 'Sacando lo mejor de los ingredientes traemos la sopa preferida de pap�.', 4000, 10, 3, 1, 'https://rumbameats.com/wp-content/uploads/2019/07/Hervido-de-_rabo-by-enrilemoine-7.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Sopa de Mondongo', 'Sopa tradicional de la tierra costarricense para un antojo de anta�o.', 3500, 10, 3, 1, 'https://recetasdemicolombia.com/wp-content/uploads/2020/08/mondongo-500x375.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Wrap de Pollo y Bacon', 'Wrap relleno de pollo empanizado, delicioso tocino y nuestra salsa mayonesa chipotle.', 3500, 10, 4, 1, 'https://i.pinimg.com/736x/72/86/1b/72861baeaccca244bf2fee091a7dc675.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Wrap corvina', 'Wrap con pescado empanizado y nuestra cl�sica salsa t�rtara.', 3500, 10, 4, 1, 'https://i.pinimg.com/736x/f5/f7/9a/f5f79aa520c59e342d7c08a8fe3e9174.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Quesadillia Cr�pe', 'Deliciosa crepa de pollo en su sala blanca.', 3500, 10, 5, 1, 'https://thasneen.com/cooking/wp-content/uploads/2017/06/Indian-style-Quesadilla.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Quesadillias de Pollo o Carne ', 'Con dos quesos, mozzarella y cheddar, disfr�talas como quieras!', 3700, 10, 5, 1, 'https://i.ytimg.com/vi/7J5JqSOP-1s/maxresdefault.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Quesadillias mixtas ', 'Mezcla de los dos mundos, pollo y carne en uno solo.', 4000, 10, 5, 1, 'https://assets.unileversolutions.com/recipes-v2/231998.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Casados', 'Cl�sico plato que todos los ticos reconocemos, salvador de tandas, escoge entre mechada, pescado, pollo, chuleta o bistec.', 3500, 10, 6, 1, 'https://upload.wikimedia.org/wikipedia/commons/0/08/Casado_costarricense.png');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Chifrijo', 'Para los amantes de la combinaci�n del chicharr�n, frijoles y arroz, servido con el cl�sico oro verde y tortillitas para que amarre.', 3500, 10, 6, 1, 'https://okdiario.com/img/2020/05/07/receta-de-costa-rica_-chifrijo-1.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Chicharrones', 'El sabor de Puriscal hasta tu mesa, servido con yuca frita y ensalada a lo tico.', 3800, 10, 6, 1, 'https://www.cocinatis.com/archivos/202308/ctis1012-receta-chicharrones-de-cerdo-andaluces-1280x720x80xX.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Lengua en Salsa', 'Atr�vete a probar nuestra suave lengua en salsa de tomate, calla hasta los m�s boc�nes con su sabor.', 4800, 10, 6, 1, 'https://www.recetascostarica.com/base/stock/Recipe/272-image/272-image_web.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Patitas de Cerdo', 'Patitas de cerdo con frijolitos blancos, plato lleno de puro sabor donde mi tata.', 4000, 10, 6, 1, 'https://www.nutricienta.com/imagenes/alimentos/alimento-nutricienta-manitas-de-cerdo.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Patacones', 'Perfecto para quitarse esas ganas de comer a lo tico, nuestros patacones vienen con carne mechada, frijoles molidos y pico de gallo.', 3700, 10, 6, 1, 'https://www.semana.com/resizer/D-Lcez1Rj4bSIUHKyMk9rwDRIMY=/1280x720/smart/filters:format(jpg):quality(80)/cloudfront-us-east-1.images.arcpublishing.com/semana/CUVSFJ3V5ZEWVLBJ76BASDV2PY.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Rice and Beans', 'Lim�n presente en el men� de pap�, pollo en salsa caribe�a con ensalada y maduros con el inigualable rice and beans.', 4500, 10, 6, 1, 'https://www.allrecipes.com/thmb/YywjEMDfUzEtxUR_8i_B_4dd-7o=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/211325-b6b1befbb1644f9b93e66eee74dbe07f.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Chilli Relleno', 'Relleno de carne molida, un excelente plato para el buen tico.', 4200, 10, 6, 1, 'https://www.jennieo.com/wp-content/uploads/2019/11/image-recipe_turkey-and-spinach-chile-relleno-with-fresh-tomato-sauce.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Arroz con Carne', 'Arroz directo de la casa compuesto por una combinaci�n perfecta de arroz y carne.', 4000, 10, 7, 1, 'https://recetacubana.com/wp-content/uploads/2019/12/receta-Arroz-con-Carne-de-Cerdo.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Arroz con Pollo', 'Arroz con el pollo desmechado cl�sico, haciendo de este un plato t�pico delicioso.', 3700, 10, 7, 1, 'https://img.bekiacocina.com/cocina/0000/179-h.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Arroz con Marinera', 'Elaborado con los mariscos m�s frescos seleccionados por pap�.', 4500, 10, 7, 1, 'https://www.elespectador.com/resizer/iSDLgK_Xt86uhsXCmvAN_Jp0Elk=/1200x675/filters:quality(60):format(jpeg)/cloudfront-us-east-1.images.arcpublishing.com/elespectador/QT2HQD77JJGDTIYXU4COEHGIRE.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Arroz con Camarones', 'Arroz con camarones de alta calidad para saciar los paladares hambrientos.', 4500, 10, 7, 1, 'https://www.recetasnestle.com.ec/sites/default/files/srh_recipes/b5761ed0a862a8c3ae9980304cd22ded.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Pomodoro', 'Nuestra pasta en salsa de tomate con delicioso queso mozzarella.', 3500, 10, 9, 1, 'https://supermancooks.com/wp-content/uploads/2023/03/pasta-pomodoro-featured.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Bolognese', 'Deliciosa pasta con queso mozzarella, salsa de tomate y carne molida.', 3800, 10, 9, 1, 'https://feelgoodfoodie.net/wp-content/uploads/2023/04/Pasta-Bolognese-TIMG.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Marinera', 'Salsa de tomate o salsa blanca con mariscos o solo camarones.', 4500, 10, 9, 1, 'https://newmansown.com/wp-content/uploads/2022/03/shrimp-marinara-with-pasta.png');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Alfredo', 'Pasta con jam�n y hongos en salsa blanca.', 4000, 10, 9, 1, 'https://images.aws.nestle.recipes/resized/cc72869fabfc2bdfa036fd1fe0e2bad8_creamy_alfredo_pasta_long_left_1080_850.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Filet de Corvina', 'Filet de corvina al grill, al ajillo o empanizado.', 4800, 10, 8, 1, 'https://pronacatqma.com/images/com_yoorecipe/banner_superior/8264_1.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Corvina Entera', 'Nuestra especial corvina entera sin espinas lista para ti.', 6700, 10, 8, 1, 'https://canalcocina.es/medias/images/1101_CocContigo_CorvinaHorno.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Pargo Entero', 'Pargo entero fresco para los que quieran recordar los d�as de playa.', 5800, 10, 8, 1, 'https://d1uz88p17r663j.cloudfront.net/original/cd153cfbb9d153b1786c7d45adac52b2_Pargo-rojo-al-sarten.png');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Corvina Entera a la Caribe�a', 'Nuestra especial corvina entera acompa�ada de salsa caribe�a y camarones.', 8700, 10, 8, 1, 'https://media-cdn.tripadvisor.com/media/photo-s/18/2f/ec/5f/corvina-entera-frita.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Camarones', 'Jugosos camarones empanizados o al ajillo para los fan�ticos del mar.', 4700, 10, 8, 1, 'https://cloudfront-us-east-1.images.arcpublishing.com/elespectador/WFY4CMXRGZD3TA2FXSRPU7UDOA.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Mariscada', 'Mix de mariscos frescos cocinados al ajillo creando un platillo colorido.', 4500, 10, 8, 1, 'https://imag.bonviveur.com/mariscada-gallega.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Mejillones', 'Mejillones noruegos al ajillo seleccionados por pap�.', 4800, 10, 8, 1, 'https://coyomar.es/wp-content/uploads/2022/06/Como-cocer-mejillones-1024x768.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Pollo al Grill', 'Nuestro especial pollo, tratado por la mano de nuestros chefs, a la parrilla.', 4000, 10, 10, 1, 'https://storage.googleapis.com/fitia-api-bucket/media/images/recipe_images/1006680.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Pollo a la Jalape�a', 'Pollo parrillero con ganas de m�s fuego, ba�ado en nuestra salsa especial de jalape�os.', 4500, 10, 10, 1, 'https://i.ytimg.com/vi/ChLkloORDfU/maxresdefault.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Pollo Cordon Bleu', 'Nuestro pollo en un platillo fabuloso, cordon bleu ba�ado en salsa blanca.', 4000, 10, 10, 1, 'https://i.ytimg.com/vi/i2fwv6beoT8/maxresdefault.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Hamburguesa Donde Pap�', 'Exquisita hamburguesa de pap�, pulled pork BBQ, pepinillos, bacon, aros de cebolla.', 4800, 10, 11, 1, 'https://delination.com/wp-content/uploads/2022/11/Hamburguesa-casera-de-res-con-papas-850x550.jpeg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Hamburguesa de Pollo', 'Una de las mejores hamburguesas para los fans del pollo a la parrilla.', 4500, 10, 11, 1, 'https://www.comedera.com/wp-content/uploads/2023/07/Hamburguesa-de-pollo-picante.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Hamburguesa con Queso', 'Hamburguesa con queso de pap�, para saborear a gusto.', 3500, 10, 11, 1, 'https://pronacatqma.com/images/com_yoorecipe/banner_superior/18096_1.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Hamburguesa de Pescado', 'Hamburguesa de pescado con salsa t�rtara, lechuga y queso amarillo, solo... donde pap�.', 4200, 10, 11, 1, 'https://editorialtelevisa.brightspotcdn.com/wp-content/uploads/2020/03/recetas-con-filete-de-pescado-fa%25CC%2581ciles-hamburguesa.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Costillas', 'Costilla de cerdo cocinada especialmente 3 horas por nuestros chefs.', 4800, 10, 14, 1, 'https://t1.uc.ltmcdn.com/es/posts/3/9/5/como_hacer_costillas_bbq_en_sarten_50593_orig.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Churrasco ', 'Este delicioso corte proviene de la falda de la res, cortado transversalmente, tratado por pap�.', 5800, 10, 12, 1, 'https://cdn0.recetasgratis.net/es/posts/2/3/1/churrasco_a_lo_pobre_77132_orig.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Churrasco a la Jalape�a ', 'Churrasco en nuestra salsa especial a la jalape�a para darle su perfecto toque picante.', 6500, 10, 12, 1, 'https://media-cdn.tripadvisor.com/media/photo-m/1280/29/75/59/9e/churrasco-tipico.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Lomito ', 'Destacado por su suavidad natural, este corte de caracter�sticas jugosas puede saciar a cualquiera.', 6200, 10, 12, 1, 'https://www.clarin.com/2021/07/26/u-aUfp64d_1200x0__1.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Lomito a la jalape�a', 'Para aquellos que quieran probar la parrilla de pap�, el suave lomito en combinaci�n con nuestro toque a la jalape�a.', 6800, 10, 12, 1, 'https://media-cdn.tripadvisor.com/media/photo-s/11/0c/bc/c4/puntas-de-lomito-a-la.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Pur�', 'Suave y cremoso pur� de papas, hecho con papas seleccionadas y un toque de mantequilla, ideal para complementar cualquier plato principal. Servido caliente', 1000, 10, 13, 1, 'https://images.aws.nestle.recipes/original/892d65cba81876ed7c340ae9ce7663d3_DCS_MARZO_INSTAGRAM-04.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Vegetales', 'Mix de vegetales de temporada, cocidos al vapor para preservar su frescura y sabor natural. Una opci�n saludable y colorida.', 1000, 10, 13, 1, 'https://cdn.aarp.net/content/aarpe/es/home/salud/vida-saludable/info-2023/comer-vegetales-verduras-crudos-o-cocidos/_jcr_content/root/container_main/container_body_main/container_body1/container_body_cf/container_image/articlecontentfragment/cfimage.coreimg.50.932.jpeg/content/dam/aarp/health/healthy-living/2023/07/1140-colorfulrawveggies-esp.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Papas asadas', 'Papas asadas hasta lograr una piel crujiente y un interior suave, sazonadas con hierbas finas y un toque de aceite de oliva.', 1000, 10, 13, 1, 'https://www.gourmet.cl/wp-content/uploads/2014/09/Papas-Asadas.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Arroz', 'Arroz blanco esponjoso, cocido a la perfecci�n, un b�sico indispensable para acompa�ar una variedad de platos.', 1000, 10, 13, 1, 'https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/05bab5cb-f8b6-487d-a509-f38031ea2708/Derivates/142b07d0-cedc-44f8-8569-e0222afab308.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Papas fritas', 'Papas fritas doradas y crujientes, cortadas a mano y fritas en aceite de alta calidad, con un toque de sal marina para realzar su sabor.', 1000, 10, 13, 1, 'https://phantom-marca.unidadeditorial.es/813d16708dc72860fd3cf319c9a245b5/resize/828/f/jpg/assets/multimedia/imagenes/2023/08/04/16911461030527.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Yuca Frita', 'Yuqitas a lo tico, fritas apenas para un gusto.', 1800, 10, 15, 1, 'https://mexicanappetizersandmore.com/wp-content/uploads/Yuca-Frita-1-12.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Patacones', 'Patacones cl�sicos con frijoles molidos y pico de gallo.', 1800, 10, 15, 1, 'https://images.hola.com/imagenes/cocina/recetas/20200320163599/receta-patacones-platano/0-800-862/patacones-adobe-m.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Aros de Cebolla', 'Aros de cebolla crujientes por fuera y por dentro!', 2200, 10, 15, 1, 'https://images.hola.com/imagenes/cocina/recetas/20220209204312/aros-cebolla-crujientes/1-49-243/aros-cebolla-adobe-t.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Papas Gajo', 'El estilo de papas favoritas de pap�, pide las que quieres.', 2200, 10, 15, 1, 'https://www.paulinacocina.net/wp-content/uploads/2023/11/receta-de-papas-gajo-Paulina-Cocina-Recetas.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Papas Francesas', 'Papas fritas apenas para acompa�ar tu comida.', 1800, 10, 15, 1, 'https://www.paulinacocina.net/wp-content/uploads/2015/08/P1140112-e1439267676931.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Palitos de Queso', 'Palitos de queso mozzarella, de la mejor compa��a que puedas tener.', 2200, 10, 15, 1, 'https://mandolina.co/wp-content/uploads/2023/06/deditos-de-queso-1200x900.png');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Gallos de salchich�n', 'Deliciosos gallos de salchich�n.', 2000, 10, 17, 1, 'https://tortiricascentroamerica.com/wp-content/uploads/2016/01/receta-tortiricas-gallitos-faciles.png');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Gallos de Chorizo', 'Deliciosos gallos de chorizo.', 2000, 10, 17, 1, 'https://cloudfront-us-east-1.images.arcpublishing.com/gruponacion/QZ7BD6VNOVFFPDH7VAWWQTRFTY.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Tacos ', 'Deliciosos tacos.', 2000, 10, 17, 1, 'https://www.comedera.com/wp-content/uploads/2017/08/tacos-al-pastor-receta.jpg');
INSERT INTO plato (descripcion, detalle, precio, existencias, id_categoria, disponible, ruta_imagen) VALUES ('Tacos de Camaron', 'Deliciosos tacos de camaron.', 2700, 10, 17, 1, 'https://t2.uc.ltmcdn.com/es/posts/2/8/1/como_hacer_tacos_de_camaron_enchilado_51182_orig.jpg');


-- Inserts en la tabla reservacion
INSERT INTO reservacion (nombre, hora, numero_de_mesa, contacto) VALUES ('Juan', TO_DATE('14:30:00', 'HH24:MI:SS'), 1, '88269654');
INSERT INTO reservacion (nombre, hora, numero_de_mesa, contacto) VALUES ('Mar�a', TO_DATE('13:00:00', 'HH24:MI:SS'), 2, '88269655');
INSERT INTO reservacion (nombre, hora, numero_de_mesa, contacto) VALUES ('Jos�', TO_DATE('20:00:00', 'HH24:MI:SS'), 3, '88269656');


-- Inserts en la tabla usuario
INSERT INTO usuario (username, password, nombre, apellidos, correo, telefono, ruta_imagen, activo) VALUES ('juan', '123', 'Juan', 'Castro Mora', 'jcastro@gmail.com', '4556-8978', 'https://img.freepik.com/foto-gratis/chico-guapo-seguro-posando-contra-pared-blanca_176420-32936.jpg', 1);
INSERT INTO usuario (username, password, nombre, apellidos, correo, telefono, ruta_imagen, activo) VALUES ('lafit', '456', 'Chuty', 'Villalobos', 'chutyvillalobos@gmail.com', '5456-8789', 'https://pbs.twimg.com/media/EahiQBxX0AEud1m.jpg', 1);
INSERT INTO usuario (username, password, nombre, apellidos, correo, telefono, ruta_imagen, activo) VALUES ('allan', '789', 'Allan', 'Allan Loria', 'allanlafit@gmail.com', '7898-8936', 'https://www.diarioextra.com/files/Dnews/images/detail/500526_allanvillalobos.jpg', 1);

-- Inserts en la tabla rol
INSERT INTO rol (nombre, id_usuario) VALUES ('ROLE_ADMIN', 1);
INSERT INTO rol (nombre, id_usuario) VALUES ('ROLE_VENDEDOR', 2);
INSERT INTO rol (nombre, id_usuario) VALUES ('ROLE_USER', 3);


-- Inserts en la tabla factura
INSERT INTO factura (id_usuario, fecha, total, estado) VALUES (1, TO_DATE('2024-01-05', 'YYYY-MM-DD'), 211560, 2);
INSERT INTO factura (id_usuario, fecha, total, estado) VALUES (2, TO_DATE('2024-01-07', 'YYYY-MM-DD'), 554340, 2);
INSERT INTO factura (id_usuario, fecha, total, estado) VALUES (3, TO_DATE('2024-01-07', 'YYYY-MM-DD'), 871000, 2);
INSERT INTO factura (id_usuario, fecha, total, estado) VALUES (1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 244140, 1);
INSERT INTO factura (id_usuario, fecha, total, estado) VALUES (2, TO_DATE('2024-01-17', 'YYYY-MM-DD'), 414800, 1);
INSERT INTO factura (id_usuario, fecha, total, estado) VALUES (3, TO_DATE('2024-01-21', 'YYYY-MM-DD'), 420000, 1);


-- Inserts en la tabla venta
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (1, 5, 45000, 3);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (2, 9, 15780, 2);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (3, 10, 15000, 3);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (1, 2, 45000, 1);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (2, 14, 154000, 3);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (2, 9, 15780, 3);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (3, 14, 154000, 1);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (3, 6, 57000, 1);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (3, 15, 330000, 2);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (1, 6, 57000, 2);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (1, 8, 27600, 3);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (1, 9, 15780, 3);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (2, 8, 27600, 3);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (2, 14, 154000, 2);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (2, 3, 24000, 1);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (3, 15, 330000, 1);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (3, 12, 45000, 1);
INSERT INTO venta (id_factura, id_plato, precio, cantidad) VALUES (3, 10, 15000, 3);


/*Procesos Almacenados*/




/*Vistas*/

--Vista #1 para mostrar todos los platos disponibles por categoria a la que pertencen
CREATE OR REPLACE VIEW vista_platos_disponibles AS
SELECT 
    p.id_plato,
    p.descripcion AS plato_descripcion,
    p.detalle,
    p.precio,
    p.existencias,
    p.ruta_imagen,
    c.descripcion AS categoria_descripcion,
    p.disponible
FROM 
    plato p
JOIN 
    categoria c ON p.id_categoria = c.id_categoria
WHERE 
    p.disponible = 1;

--Vista #2 Muestra informaci�n adicional sobre los usuarios que las realizaron.informaci�n adicional sobre los usuarios que las realizaron.
CREATE OR REPLACE VIEW vista_facturas_con_usuarios AS
SELECT 
    f.id_factura,
    f.fecha,
    f.total,
    f.estado,
    u.nombre,
    u.apellidos,
    u.correo,
    u.telefono
FROM 
    factura f
JOIN 
    usuario u ON f.id_usuario = u.id_usuario;
    
--Vista #3 Esta vista muestra las ventas realizadas, incluyendo informaci�n del plato vendido y la factura asociada.
CREATE OR REPLACE VIEW vista_ventas_detalles AS
SELECT 
    v.id_venta,
    f.fecha,
    p.descripcion AS plato_descripcion,
    p.precio,
    v.cantidad,
    v.precio AS precio_venta,
    f.total AS total_factura
FROM 
    venta v
JOIN 
    factura f ON v.id_factura = f.id_factura
JOIN 
    plato p ON v.id_plato = p.id_plato;

--Vista #4 Esta vista muestra los usuarios junto con los roles asignados a cada uno.
CREATE OR REPLACE VIEW vista_usuarios_roles AS
SELECT 
    u.id_usuario,
    u.username,
    u.nombre,
    u.apellidos,
    r.nombre AS rol
FROM 
    usuario u
JOIN 
    rol r ON u.id_usuario = r.id_usuario;

--Vista #5 Esta vista muestra todas las reservaciones con informaci�n de contacto.
CREATE OR REPLACE VIEW vista_reservaciones AS
SELECT 
    r.id_reservacion,
    r.nombre,
    r.hora,
    r.numero_de_mesa,
    r.contacto
FROM 
    reservacion r;

----------------------
SELECT
    s.sid AS session_id,
    s.serial# AS session_serial#,
    o.object_name,
    o.object_type,
    s.blocking_session
FROM
    v$lock l
JOIN
    v$session s
ON
    l.sid = s.sid
JOIN
    dba_objects o
ON
    l.id1 = o.object_id
WHERE
    l.block = 1;








