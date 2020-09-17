--Tratando erros internos do Oracle (EXCEPTION)
SET SERVEROUTPUT ON
DECLARE
    vvalor1 NUMBER :=100;
    vvalor2 NUMBER :=0;

BEGIN
    vvalor1:=vvalor1/vvalor2;
    
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('VALOR 2 NÃO PODE SER ZERO');
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO NÃO IDENTIFICADO');
END;


--Tratando outros erros internos do Oracle (EXCEPTION)
--INTO __ IN SERVE PARA ALOCAR UMA INFORMAÇÃO SÓ POR VEZ, SE TIVER MAIS DÁ ERRO
SET SERVEROUTPUT ON
DECLARE
    vvalor NUMBER;

BEGIN
    SELECT preco INTO vvalor FROM TB_LIVRO
    WHERE id_livro IN (1,2);
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        --NO DATA FOUND É FUNÇÃO DE QUANDO NÃO ACHA REGISTRO
        DBMS_OUTPUT.PUT_LINE('A consulta não retornou nenhum registro');
        
        WHEN TOO_MANY_ROWS THEN
        --TOO MANY ROWS É PRA QUANDO ACHA MAIS DE UMA LINHA PRA ALGO QUE SÓ DEVIA TER UMA
        DBMS_OUTPUT.PUT_LINE (' A consulta retornou mais de um registro');
        
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE (' Erro nao identificado ocorreu');

    
END;


--Tratando erros internos do Oracle (EXCEPTION) , 
--interagindo com comandos de banco de dados com tratamento de exceção.
--os BEGIN são independentes mesmo se um dá erro o outro vai rodar
set serveroutput on
DECLARE
    vnome varchar(50);
    vsexo char(01);
BEGIN
    BEGIN
        SELECT nome,sexo INTO vnome,vsexo FROM TB_AUTOR
        WHERE id_autor in (2,3);
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
                DBMS_OUTPUT.PUT_LINE('A consulta não retornou nenhum registro');
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE (' A consulta retornou mais de um registro');
            
    END;    
        DBMS_OUTPUT.put_LINE('Nome e sexo do autor :'||vnome||'--'||vsexo);
END;


--Criando exceções de usuários
--criando os erros por assim dizer
SET SERVEROUTPUT ON
DECLARE
    vcodigo NUMBER ;
    verro varchar2(64);
    vdata date :='01.10.2010';
    DATA_INVALIDA EXCEPTION;
    
    BEGIN
        vcodigo:=100/0;
        
        IF vdata < SYSDATE THEN
            RAISE DATA_INVALIDA;
        --RAISE É PARA FORÇAR APARECER
        END IF;
        
        EXCEPTION 
            WHEN DATA_INVALIDA THEN
                DBMS_OUTPUT.PUT_LINE('Data invalida!!!');
            WHEN OTHERS THEN
                vcodigo:=SQLCODE;
                --SQL CODE retorne o número do erro mais recente
                --deve ser salvo em uma variável local
                verro:=SUBSTR(SQLERRM, 1, 64);
                --pega a descricao do erro
                DBMS_OUTPUT.PUT_LINE('Erro!!! '||vcodigo||' : ' || verro);
    END;
    


--Enviando mensagens de erro para a aplicação
--Ou seja, criando os erros
SET SERVEROUTPUT ON
DECLARE
    vdata date :='01.10.2010';
    
    BEGIN
        IF vdata < SYSDATE THEN
            RAISE_APPLICATION_ERROR (-20100,'Data anterior a data do servidor');
            --ERRO CRIADO
        END IF;
    END;


































