/*Pacotes são agrupamentos de tipos, variáveis, sub-programas*/
/*Ajudam muito na modularização e reutilização do código*/



--Criando um pacote [PACKAGE]
CREATE OR REPLACE PACKAGE TREINAMENTO AS
    FUNCTION FC_CALCULA_AREA(pbase NUMBER, paltura NUMBER)
    RETURN NUMBER;
END;

CREATE OR REPLACE PACKAGE BODY TREINAMENTO AS
--um se cria a função e no outro o corpo dela
FUNCTION FC_CALCULA_AREA (pbase NUMBER, paltura NUMBER)
    RETURN NUMBER
    IS
        BEGIN
            RETURN pbase*paltura;
        END;
END;     

SET SERVEROUTPUT ON
DECLARE varea NUMBER;
    BEGIN
        varea:= TREINAMENTO.FC_CALCULA_AREA(5,4);
        DBMS_OUTPUT.put_line(' A área da figura é : ' || varea);
    END;
    


--Criando um pacote [PACKAGE] com sobrecarga de função.
--Quando tem um nome só para duas funçoes com parametros diferentes
CREATE OR REPLACE PACKAGE TREINAMENTO AS
    cpi constant number:=3.1416;
        FUNCTION FC_CALCULA_AREA(pbase number, paltura number)
    RETURN number;
        FUNCTION FC_CALCULA_AREA(praio number)
    RETURN number;
END;

CREATE OR REPLACE PACKAGE BODY TREINAMENTO AS
    FUNCTION FC_CALCULA_AREA(pbase number, paltura number)
    RETURN number
    IS
        BEGIN
            RETURN pbase*paltura;
        END;
    
    FUNCTION FC_CALCULA_AREA(praio number)
    RETURN number
    IS
        BEGIN
            RETURN cpi*praio**2;
        END;
END;
    
set serveroutput on
DECLARE
    varea number;
BEGIN
    varea:= TREINAMENTO.FC_CALCULA_AREA(3);
    --SE TEM SÓ UM PARÂMETRO VAI NA SEGUNDA FUNCTION
    DBMS_OUTPUT.PUT_LINE('  A área da figura passando o raio é: ' || varea);
    
    varea:= TREINAMENTO.FC_CALCULA_AREA(5,4);
    --COM DOIS PARAMETROS VAI PRIMEIRA FUNCTION
    DBMS_OUTPUT.PUT_LINE(' A área da figura é : ' || varea);
END;
















