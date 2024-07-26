CREATE TABLE USUARIO (
    ID_USUARIO NUMBER,
    USERNAME VARCHAR2(50),
    PASSWORD VARCHAR2(50),
    NOMBRE VARCHAR2(50),
    APELLIDOS VARCHAR2(50),
    CORREO VARCHAR2(100),
    TELEFONO VARCHAR2(20),
    RUTA_IMAGEN VARCHAR2(255),
    ACTIVO VARCHAR2(10),
    CONSTRAINT usuario_pk PRIMARY KEY (ID_USUARIO)
);
COMMIT;

CREATE TABLE CATEGORIA (
    ID_CATEGORIA NUMBER,
    DESCRIPCION VARCHAR2(100),
    DISPONIBLE VARCHAR2(10),
    RUTA_IMAGEN VARCHAR2(255),
    CONSTRAINT categoria_pk PRIMARY KEY (ID_CATEGORIA)
);
COMMIT;

CREATE TABLE SEDE (
    ID_SEDE NUMBER,
    NOMBRE_SEDE VARCHAR2(100),
    DIRECCION VARCHAR2(255),
    CONSTRAINT SEDE_pk PRIMARY KEY (ID_SEDE)
);
COMMIT;

CREATE TABLE MESA (
    ID_MESA NUMBER,
    NOMBRE_MESA VARCHAR2(50),
    NUM_ESPACIOS NUMBER,
    ID_RESERVACION NUMBER,
    CONSTRAINT mesa_pk PRIMARY KEY (ID_MESA)
);
COMMIT;

CREATE TABLE RESERVACION (
    ID_RESERVACION NUMBER,
    NOMBRE VARCHAR2(50),
    HORA DATE,
    ID_MESA NUMBER,
    CONTACTO VARCHAR2(50),
    ID_SEDE NUMBER,
    CONSTRAINT reservacion_pk PRIMARY KEY (ID_RESERVACION)
);
COMMIT;

CREATE TABLE PLATO (
    ID_PLATO NUMBER,
    ID_CATEGORIA NUMBER,
    NOMBRE_PLATO VARCHAR(30),
    DETALLE VARCHAR2(255),
    PRECIO NUMBER,
    EXISTENCIAS NUMBER,
    RUTA_IMAGEN VARCHAR2(255),
    DISPONIBLE VARCHAR2(10),
    CONSTRAINT plato_pk PRIMARY KEY (ID_PLATO)
);
COMMIT;

CREATE TABLE FACTURA (
    ID_FACTURA NUMBER,
    ID_USUARIO NUMBER,
    FECHA DATE,
    TOTAL NUMBER,
    ESTADO VARCHAR2(20),
    CONSTRAINT factura_pk PRIMARY KEY (ID_FACTURA)
);
COMMIT;

CREATE TABLE VENTA (
    ID_VENTA NUMBER,
    ID_FACTURA NUMBER,
    ID_PLATO NUMBER,
    CANTIDAD NUMBER,
    CONSTRAINT venta_pk PRIMARY KEY (ID_VENTA)
);
COMMIT;

CREATE TABLE ROL (
    ID_ROL NUMBER,
    NOMBRE VARCHAR2(50),
    ID_USUARIO NUMBER,
    CONSTRAINT rol_pk PRIMARY KEY (ID_ROL)
);
COMMIT;

CREATE TABLE DIRECCION (
    ID_DIRECCION NUMBER,
    NOMBRE_DIRECCION VARCHAR2(100),
    COORDENADAS VARCHAR2(50),
    DESCRIPCION_DIRECCION VARCHAR2(255),
    CONSTRAINT direccion_pk PRIMARY KEY (ID_DIRECCION)
);
COMMIT;

ALTER TABLE MESA ADD CONSTRAINT mesa_fk_reservacion FOREIGN KEY (ID_RESERVACION) REFERENCES RESERVACION(ID_RESERVACION);
ALTER TABLE RESERVACION ADD CONSTRAINT reservacion_fk_mesa FOREIGN KEY (ID_MESA) REFERENCES MESA(ID_MESA);
ALTER TABLE RESERVACION ADD CONSTRAINT reservacion_fk_SEDE FOREIGN KEY (ID_SEDE) REFERENCES SEDE(ID_SEDE);
ALTER TABLE PLATO ADD CONSTRAINT plato_fk_categoria FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA(ID_CATEGORIA);
ALTER TABLE FACTURA ADD CONSTRAINT factura_fk_usuario FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO);
ALTER TABLE VENTA ADD CONSTRAINT venta_fk_factura FOREIGN KEY (ID_FACTURA) REFERENCES FACTURA(ID_FACTURA);
ALTER TABLE VENTA ADD CONSTRAINT venta_fk_plato FOREIGN KEY (ID_PLATO) REFERENCES PLATO(ID_PLATO);
ALTER TABLE ROL ADD CONSTRAINT rol_fk_usuario FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO);
COMMIT;

INSERT INTO MESA (ID_MESA, NOMBRE_MESA, NUM_ESPACIOS, ID_RESERVACION) VALUES (1, 'Mesa 1', 4, NULL);
INSERT INTO MESA (ID_MESA, NOMBRE_MESA, NUM_ESPACIOS, ID_RESERVACION) VALUES (2, 'Mesa 2', 6, NULL);
COMMIT;

INSERT INTO USUARIO (ID_USUARIO, USERNAME, PASSWORD, NOMBRE, APELLIDOS, CORREO, TELEFONO, RUTA_IMAGEN, ACTIVO) 
VALUES (1, 'jdoe', 'password123', 'John', 'Doe', 'jdoe@example.com', '1234567890', 'ruta1.jpg', 'Activo');
INSERT INTO USUARIO (ID_USUARIO, USERNAME, PASSWORD, NOMBRE, APELLIDOS, CORREO, TELEFONO, RUTA_IMAGEN, ACTIVO) 
VALUES (2, 'asmith', 'password456', 'Alice', 'Smith', 'asmith@example.com', '0987654321', 'ruta2.jpg', 'Activo');
COMMIT;

INSERT INTO ROL (ID_ROL, NOMBRE, ID_USUARIO) VALUES (1, 'Admin', 1);
INSERT INTO ROL (ID_ROL, NOMBRE, ID_USUARIO) VALUES (2, 'User', 2);
COMMIT;

INSERT INTO CATEGORIA (ID_CATEGORIA, DESCRIPCION, DISPONIBLE, RUTA_IMAGEN) VALUES (1, 'Entrantes', 'SI', 'ruta1.jpg');
INSERT INTO CATEGORIA (ID_CATEGORIA, DESCRIPCION, DISPONIBLE, RUTA_IMAGEN) VALUES (2, 'Principales', 'SI', 'ruta2.jpg');
COMMIT;

INSERT INTO PLATO (ID_PLATO, ID_CATEGORIA, NOMBRE_PLATO, DETALLE, PRECIO, EXISTENCIAS, RUTA_IMAGEN, DISPONIBLE) 
VALUES (1, 1, 'Ensalada', 'Ensalada mixta', 5.00, 10, 'ruta1.jpg', 'SI');
INSERT INTO PLATO (ID_PLATO, ID_CATEGORIA, NOMBRE_PLATO, DETALLE, PRECIO, EXISTENCIAS, RUTA_IMAGEN, DISPONIBLE) 
VALUES (2, 2, 'Pollo Asado', 'Pollo asado con guarniciÃ³n', 10.00, 5, 'ruta2.jpg', 'SI');
COMMIT;

INSERT INTO SEDE (ID_SEDE, NOMBRE_SEDE, DIRECCION) VALUES (1, 'Sede Central', 'DirecciÃ³n 1');
INSERT INTO SEDE (ID_SEDE, NOMBRE_SEDE, DIRECCION) VALUES (2, 'Sede Norte', 'DirecciÃ³n 2');
COMMIT;

INSERT INTO RESERVACION (ID_RESERVACION, NOMBRE, HORA, ID_MESA, CONTACTO, ID_SEDE) VALUES (1, 'Reserva 1', TO_DATE('2024-07-18 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 'contacto1', 1);
INSERT INTO RESERVACION (ID_RESERVACION, NOMBRE, HORA, ID_MESA, CONTACTO, ID_SEDE) VALUES (2, 'Reserva 2', TO_DATE('2024-07-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 'contacto2', 2);
COMMIT;

INSERT INTO FACTURA (ID_FACTURA, ID_USUARIO, FECHA, TOTAL, ESTADO) VALUES (1, 1, TO_DATE('2024-07-18', 'YYYY-MM-DD'), 15.00, 'Pagada');
INSERT INTO FACTURA (ID_FACTURA, ID_USUARIO, FECHA, TOTAL, ESTADO) VALUES (2, 2, TO_DATE('2024-07-19', 'YYYY-MM-DD'), 20.00, 'Pendiente');
COMMIT;

INSERT INTO VENTA (ID_VENTA, ID_FACTURA, ID_PLATO, CANTIDAD) VALUES (1, 1, 1, 1);
INSERT INTO VENTA (ID_VENTA, ID_FACTURA, ID_PLATO, CANTIDAD) VALUES (2, 2, 2, 2);
COMMIT;

-- 1. Procedimiento para obtener los platos disponibles
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE OBTENER_PLATOS_DISPONIBLES 
AS
BEGIN
    FOR platos_disponibles IN (SELECT descripcion FROM usuarioDondePapa.plato WHERE disponible = 1) LOOP
        DBMS_OUTPUT.PUT_LINE('Plato: ' || platos_disponibles.descripcion);
    END LOOP; 
END;

EXEC OBTENER_PLATOS_DISPONIBLES;
COMMIT;

-- 2. Procedimiento para calcular el total de una factura
CREATE OR REPLACE PROCEDURE CALCULAR_TOTAL_FACTURA (
    id_factura IN NUMBER
)
AS
	total NUMBER;
--	id_plato PLATO.ID_PLATO%TYPE;
--	precio_plato PLATO.PRECIO%TYPE;
BEGIN
--    SELECT ID_PLATO INTO id_plato FROM VENTA WHERE ID_FACTURA= id_factura;
--    SELECT PRECIO INTO precio_plato FROM PLATO WHERE ID_PLATO= id_plato;

    SELECT SUM(p.PRECIO * v.CANTIDAD)
    INTO total
    FROM VENTA v
    JOIN PLATO p ON v.ID_PLATO = p.ID_PLATO
    WHERE ID_FACTURA = id_factura;

	DBMS_OUTPUT.PUT_LINE('Total: $' || total);
END;
-- El procedimiento no compilaba correctamente, así que se se realizaron unos
-- cambios implementando la función de JOIN para cumplir su uso.
EXEC CALCULAR_TOTAL_FACTURA(2);
COMMIT;

--3. Procedimiento para obtener facturas por usuario
CREATE OR REPLACE PROCEDURE OBTENER_FACTURAS_POR_USUARIO (
    id_usuario IN USUARIO.ID_USUARIO%TYPE
) AS
BEGIN
	FOR facturas_usuario IN (SELECT * FROM FACTURA WHERE ID_USUARIO = id_usuario) LOOP
        DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Id factura: ' || facturas_usuario.ID_FACTURA);
        DBMS_OUTPUT.PUT_LINE('Id del usuario: ' || facturas_usuario.ID_USUARIO);
        DBMS_OUTPUT.PUT_LINE('Fecha de registro: ' || facturas_usuario.FECHA);
        DBMS_OUTPUT.PUT_LINE('Estado factura: ' || facturas_usuario.ESTADO);
        DBMS_OUTPUT.PUT_LINE('Total: $' || facturas_usuario.TOTAL);
		DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
	END LOOP; 
END;

EXEC OBTENER_FACTURAS_POR_USUARIO(1);
COMMIT;


--4. Procedimiento para obtener reservaciones por sede
CREATE OR REPLACE PROCEDURE OBTENER_RESERVACIONES_POR_SEDE (
    id_sede IN NUMBER
) AS
    nombre_sede VARCHAR(100);
BEGIN
    -- SELECT NOMBRE_SEDE INTO nombre_sede FROM SEDE WHERE ID_SEDE = id_sede;
    SELECT NOMBRE_SEDE INTO nombre_sede FROM SEDE WHERE ID_SEDE = id_sede AND ROWNUM = 1;
    
    FOR reservaciones_sede IN (SELECT * FROM RESERVACION WHERE ID_SEDE = id_sede) LOOP
        DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Id reservacion: ' || reservaciones_sede.ID_RESERVACION);
        DBMS_OUTPUT.PUT_LINE('Sede: ' || nombre_sede);
        DBMS_OUTPUT.PUT_LINE('A nombre de: ' || reservaciones_sede.NOMBRE);
        DBMS_OUTPUT.PUT_LINE('Hora: ' || reservaciones_sede.HORA);
        DBMS_OUTPUT.PUT_LINE('Mesa reservada: ' || reservaciones_sede.ID_MESA);
        DBMS_OUTPUT.PUT_LINE('Contacto del cliente' || reservaciones_sede.CONTACTO);
        DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
    END LOOP; 
END;
-- Similar al error del procedimiento 2, se realizaron unos cambios para que el
-- procedimiento 4 cumpla su función.
EXEC OBTENER_RESERVACIONES_POR_SEDE(1);

--5. Procedimiento para obtener ventas por plato
CREATE OR REPLACE PROCEDURE OBTENER_VENTAS_POR_PLATO (
    id_plato IN NUMBER
) AS
    nombre_plato PLATO.NOMBRE_PLATO%TYPE;
BEGIN
	SELECT NOMBRE_PLATO INTO nombre_plato FROM PLATO WHERE ID_PLATO= id_plato AND ROWNUM = 1;
    
    FOR ventas_platos IN (SELECT * FROM VENTA WHERE ID_PLATO = id_plato) LOOP
        DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Id venta: ' || ventas_platos.ID_VENTA);
        DBMS_OUTPUT.PUT_LINE('Factura de venta: ' || ventas_platos.ID_FACTURA);
        DBMS_OUTPUT.PUT_LINE('Plato: ' || NOMBRE_PLATO);
        DBMS_OUTPUT.PUT_LINE('Cantidad: ' || ventas_platos.CANTIDAD);
        DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
    END LOOP; 
END;

EXEC OBTENER_VENTAS_POR_PLATO(1);

DROP PROCEDURE OBTENER_VENTAS_POR_PLATO;
--6. Procedimiento para calcular los ingresos por sede
CREATE OR REPLACE PROCEDURE CALCULAR_INGRESOS_POR_SEDE (
    id_sede IN NUMBER
) AS
    total_ingresos NUMBER;
	nombre_sede SEDE.NOMBRE_SEDE%TYPE;
BEGIN
	SELECT NOMBRE_SEDE INTO nombre_sede FROM SEDE WHERE ID_SEDE = 1;
    
    SELECT SUM(f.TOTAL)
    INTO total_ingresos
    FROM FACTURA f
    JOIN RESERVACION r ON f.ID_FACTURA = r.ID_RESERVACION
    WHERE r.ID_SEDE = 1;

    DBMS_OUTPUT.PUT_LINE('Total de ingresos en la sede "' || nombre_sede || '": $' || total_ingresos);
END;

EXEC CALCULAR_INGRESOS_POR_SEDE(1);

--7. Procedimiento para registrar una nueva mesa
CREATE OR REPLACE PROCEDURE REGISTRAR_MESA (
    id_mesa IN NUMBER,
    nombre_mesa IN VARCHAR2,
    num_espacios IN NUMBER,
    id_reservacion IN NUMBER
) AS
    mesa_existente NUMBER;
BEGIN
    -- Aca vamos a ver si la mesa existe o no, porque si ya existe estarios duplicando la key
    SELECT COUNT(*) INTO mesa_existente
    FROM MESA
    WHERE ID_MESA = id_mesa;

    IF mesa_existente > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: El ID de la mesa ya existe.');
    ELSE
        -- Aca insertamos le mensa
        IF id_reservacion IS NULL THEN
            INSERT INTO MESA (ID_MESA, NOMBRE_MESA, NUM_ESPACIOS) 
            VALUES (id_mesa, nombre_mesa, num_espacios);
        ELSE
            INSERT INTO MESA (ID_MESA, NOMBRE_MESA, NUM_ESPACIOS, ID_RESERVACION) 
            VALUES (id_mesa, nombre_mesa, num_espacios, id_reservacion);
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('Mesa registrada exitosamente');
    END IF;
END;


BEGIN 
    REGISTRAR_MESA(3, 'Mesa 3', 4, NULL); 
END;

--8. Procedimiento para eliminar una reservacion

/*puede dar eror si no hay una reservacion con ese id*/
CREATE OR REPLACE PROCEDURE ELIMINAR_RESERVACION (
    id_reservacion IN NUMBER
) AS
BEGIN
    DELETE FROM RESERVACION
    WHERE ID_RESERVACION = id_reservacion;
    
    DBMS_OUTPUT.PUT_LINE('Reservación eliminada exitosamente');
END;


EXEC ELIMINAR_RESERVACION(1);

--9. Procedimiento para registrar una nueva sede

CREATE OR REPLACE PROCEDURE REGISTRAR_SEDE (
    id_sede IN NUMBER,
    nombre_sede IN VARCHAR2,
    direccion IN VARCHAR2
) AS
BEGIN
    INSERT INTO SEDE (ID_SEDE, NOMBRE_SEDE, DIRECCION)
    VALUES (id_sede, nombre_sede, direccion);
    
    DBMS_OUTPUT.PUT_LINE('Sede registrada exitosamente');
END;

EXEC REGISTRAR_SEDE(3, 'Sede Sur', 'Dirección 3');

--10. Procedimiento para eliminar una mesa

CREATE OR REPLACE PROCEDURE ELIMINAR_MESA (
    id_mesa IN NUMBER
) AS
BEGIN
    DELETE FROM MESA
    WHERE ID_MESA = id_mesa;

    DBMS_OUTPUT.PUT_LINE('Mesa eliminada exitosamente');
END;


BEGIN 
    ELIMINAR_MESA(2); 
END;

--11. Procedimiento para para obtener el total de ventas por usuario
CREATE OR REPLACE PROCEDURE OBTENER_TOTAL_VENTAS_POR_USUARIO (
    id_usuario IN NUMBER
) AS
    total_ventas NUMBER;
BEGIN
    SELECT SUM(f.TOTAL)
    INTO total_ventas
    FROM FACTURA f
    WHERE f.ID_USUARIO = id_usuario;

    DBMS_OUTPUT.PUT_LINE('Total de ventas para el usuario ' || id_usuario || ': $' || total_ventas);
END;


BEGIN 
    OBTENER_TOTAL_VENTAS_POR_USUARIO(1); 
END;

--12. Procedimiento para obtener el numero total de mesas y listar ID de mesas por sede

CREATE OR REPLACE PROCEDURE OBTENER_TOTAL_Y_LISTAR_MESES_POR_SEDE (
    id_sede IN NUMBER
) AS
    total_mesas NUMBER;
BEGIN
    
    SELECT COUNT(*) INTO total_mesas
    FROM MESA
    JOIN RESERVACION ON MESA.ID_RESERVACION = RESERVACION.ID_RESERVACION
    WHERE RESERVACION.ID_SEDE = id_sede;

    DBMS_OUTPUT.PUT_LINE('total de mesas en la sede con ID ' || id_sede || ': ' || total_mesas);

    
    FOR mesa IN (
        SELECT MESA.ID_MESA 
        FROM MESA
        JOIN RESERVACION ON MESA.ID_RESERVACION = RESERVACION.ID_RESERVACION
        WHERE RESERVACION.ID_SEDE = id_sede
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Mesa: ' || mesa.ID_MESA);
    END LOOP;
END;

BEGIN 
    OBTENER_TOTAL_Y_LISTAR_MESES_POR_SEDE(1); 
END;

