--Utilizando o comando condicional (CASE )
SET SERVEROUTPUT ON
DECLARE
    vtotalquant number;
    
BEGIN
    SELECT sum(quantidade) INTO vtotalquant
    FROM TB_ITENS_PEDIDO;
    
    CASE
    WHEN vtotalquant <=200 THEN
        DBMS_OUTPUT.PUT_line (' O estoque esta proximo do mínimo: '||vtotalquant) ;
    WHEN vtotalquant <=300 THEN
        DBMS_OUTPUT.PUT_line (' O estoque esta completo: '||vtotalquant) ;
    ELSE
        DBMS_OUTPUT.PUT_line (' O estoque esta em excesso: '||vtotalquant);
    END CASE;
END;


--Utilizando comando de iteração (LOOP)
SET SERVEROUTPUT ON
DECLARE
    vrepeticao number :=0 ;
    BEGIN
    LOOP
    vrepeticao:=vrepeticao+1;
        IF vrepeticao >5 THEN
            EXIT;
        END IF;
    DBMS_OUTPUT.PUT_line (' IMPRESSAO : '||vrepeticao);
    END LOOP;
END;


--Utilizando comando de iteração (WHILE )
SET SERVEROUTPUT ON
DECLARE
    vrepeticao number :=0 ;
BEGIN
    WHILE vrepeticao<5 LOOP
    vrepeticao:=vrepeticao+1;
    DBMS_OUTPUT.PUT_line (' IMPRESSAO : '||vrepeticao);
    END LOOP;
END;


--Utilizando comando de iteração (LOOP-FOR )
SET SERVEROUTPUT ON
DECLARE
    vrepeticao number :=0 ;
BEGIN
    FOR vrepeticao IN 1..5 LOOP
    DBMS_OUTPUT.PUT_line (' IMPRESSAO : '||vrepeticao);
    END LOOP;
END;


--Interagindo comandos de banco de dados com bloco anônimo
SET SERVEROUTPUT ON
DECLARE
    vid_autor INT;
    vnome varchar(50);
    vsexo char(01);
BEGIN
    vid_autor:=1;
    SELECT
        nome,
        sexo
    INTO
        vnome,
        vsexo
    FROM
        TB_AUTOR
    WHERE
        ID_AUTOR= vid_autor;
        DBMS_OUTPUT.PUT_line (' Nome e sexo do autor: '||vnome||' --- '||vsexo);
END;


--Manipulando valores nulos

SET SERVEROUTPUT ON
DECLARE
    vid_autor INT;
    vid_autor2 INT;
    vnome varchar(50);
    vsexo char(01);
BEGIN
    vid_autor:=1;
    vid_autor2:=NULL;
    vid_autor:=NVL(vid_autor,vid_autor2);
    SELECT
        nome,
        sexo
    INTO
        vnome,
        vsexo
    FROM
        TB_AUTOR
    WHERE
        ID_AUTOR= vid_autor;
        DBMS_OUTPUT.PUT_line (' Nome e sexo do autor: '||vnome||' --- '||vsexo);
END;



















