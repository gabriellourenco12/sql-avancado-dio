--Atribuição de variáveis com o tipo %type
--ela  pega o tipo da variavel no banco de dados

SET SERVEROUTPUT ON
DECLARE
    vid_autor tb_autor.id_autor%TYPE;
    vnome tb_autor.nome%TYPE;
    vsexo tb_autor.sexo%TYPE;
    
    BEGIN
    vid_autor:=1;
    
        SELECT
            nome,sexo
        INTO
            vnome,vsexo
        FROM
            TB_AUTOR
        WHERE
            id_autoR=vid_autor;
            DBMS_OUTPUT.PUT_LINE('Nome e sexo do Autor: '||vnome||' '||vsexo);
    END;
    
    
    
--Atribuição de variáveis com o tipo %rowtype
--essa pega todos as variaveis da tabela e salva numa array
SET SERVEROUTPUT ON
DECLARE
    vregautor TB_AUTOR%ROWTYPE;
    
BEGIN
    vregautor.id_autor:=1;
    
    SELECT
        nome,sexo
    INTO
        vregautor.nome,
        vregautor.sexo
    FROM
        TB_AUTOR
    WHERE
        id_autor=vregautor.id_autor;
    
        DBMS_OUTPUT.PUT_LINE('Nome e sexo do Autor: '
        ||vregautor.nome||' '||vregautor.sexo);
    
END;



--Utilizando o ROWID
--é uma chave do próprio oracle (id)
SET SERVEROUTPUT ON
DECLARE
    vrowid UROWID;
    
BEGIN
    SELECT ROWID
    INTO
        vrowid
    FROM
        TB_EDITORA
    WHERE
        UPPER(descricao)= 'CAMPUS';
        DBMS_OUTPUT.put_line('O endereco da editora eh: '||vrowid);
END;

--Trabalhando com cursores implícitos. Reajustar os livros em 5% 
--e verificar a quantidade de registros que foram afetados.
SET SERVEROUTPUT ON
BEGIN
    UPDATE
        TB_LIVRO
    SET
        preco=preco*1.05
    WHERE
        preco>=10;
    
    IF (SQL%NOTFOUND) THEN
        DBMS_OUTPUT.PUT_LINE('Nao houve livro reajustado!!!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('A quantidade de livros reajustados foi de: '
        ||SQL%ROWCOUNT);
    END IF;
END;
    
    
/*Trabalhando com cursores explícitos. 
Apresenta o título e preço registro a registro de forma seqüencial.
O SELECT TEM O L.* PORQUE vreglivros É DO TAMANHO DO TBLIVRO */
SET SERVEROUTPUT ON
DECLARE
    vreglivros TB_LIVRO%ROWTYPE;

CURSOR clivros IS
    SELECT
        L.*
    FROM
        TB_LIVRO L
    JOIN
        TB_EDITORA E ON (L.id_editora=E.id_editora)
    WHERE
        UPPER(E.descricao) ='CAMPUS';
        
    BEGIN
            OPEN clivros;
            LOOP
            FETCH clivros INTO vreglivros;
            EXIT WHEN clivros%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('Titulos e Precos dos livros: '
            ||vreglivros.titulo||' , '||vreglivros.preco);
            END LOOP;
            CLOSE clivros;
    END;




--Cursores explícitos utilizando o FOR IN
--esse nao precisa do exit
--O FOR É INTELIGENTE PARA PASSAR OS DADOS
SET SERVEROUTPUT ON
DECLARE
    vreglivros TB_LIVRO%ROWTYPE;
    
CURSOR clivro IS
SELECT
    L.*
FROM
    TB_LIVRO L
JOIN
    TB_EDITORA E ON (L.id_editora=E.id_editora)
WHERE
    UPPER(E.descricao)='CAMPUS';
    
BEGIN
    FOR vreglivros IN clivro
    LOOP
    DBMS_OUTPUT.PUT_LINE('Titulos e Precos dos livros: '
    ||vreglivros.titulo||' , '||vreglivros.preco);
    END LOOP;
END;


--Bloqueando registros em um cursos para posterior UPDATE ou DELETE.
--NÃO DEIXA MUDAR OS DADOS DURANTE A EDICAO NO BANCO
--FOR UPDATE prende o campo e WHERE CURRENT OF prende a informação
--só você pode editar durante a execução

SET SERVEROUTPUT ON
DECLARE
    vpreco tb_livro.preco%TYPE;
    vdescricao tb_editora.descricao%TYPE;
    vpercajuste number;
    
CURSOR clivros IS
    SELECT
        L.PRECO, 
        UPPER(E.descricao)
    FROM
        TB_LIVRO L
    JOIN
        TB_EDITORA E ON (L.id_editora=E.id_editora)
        FOR UPDATE OF L.preco;

    BEGIN
        OPEN clivros;
        LOOP
            FETCH clivros INTO vpreco,vdescricao;
            EXIT WHEN clivros%NOTFOUND;
                IF vdescricao='CAMPUS' THEN
                    vpercajuste:=5;
                ELSE
                    vpercajuste:=10;
                END IF;
                UPDATE TB_LIVRO SET preco=preco + (preco*vpercajuste/100)
                WHERE
                    CURRENT OF clivros;
        END LOOP;
    END;




















