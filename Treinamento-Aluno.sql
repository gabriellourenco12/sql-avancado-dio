CREATE TABLE TB_TREINAMENTO
    (
        "ID" NUMBER(5) NOT NULL,
        "NOME" VARCHAR2(10),
        "SEXO" CHAR(1)
    );
    
INSERT INTO tb_treinamento (ID,NOME,SEXO) VALUES (2,'PEDRO','M');

ALTER TABLE "TB_TREINAMENTO" ADD CONSTRAINT "CK__TREINA_SEXO" CHECK (Sexo in ('M','F')) ENABLE;
ALTER TABLE "TB_TREINAMENTO" ADD CONSTRAINT "PK_TREINAMENTO" PRIMARY KEY ("ID") ENABLE;

ALTER TABLE "TB_TREINAMENTO" RENAME CONSTRAINT SYS_C007395 TO CK_NOT_NULL;

ALTER TABLE "TB_TREINAMENTO" DROP CONSTRAINT CK_NOT_NULL;

DROP TABLE "TB_TREINAMENTO";

UPDATE TB_LIVRO SET qtde_estoque=300 WHERE titulo='Banco de Dados';

DELETE FROM tb_funcionario WHERE nome='João';

SELECT * FROM TB_FUNCIONARIO;
SELECT NOME, SEXO FROM tb_funcionario;
SELECT NOME, SEXO FROM tb_funcionario ORDER BY SEXO;

SELECT * FROM tb_editora WHERE endereco IS NOT NULL;

/*Elimina a constraint FK_LIVRO_EDITORA da tabela TB_LIVRO*/
ALTER TABLE TB_LIVRO DROP CONSTRAINT FK_LIVRO_EDITORA;

/*Adiciona a constraint FK_LIVRO_EDITORA na tabela TB_LIVRO fazendo uma 
referência a tabela TB_EDITORA, desta forma está sendo criada uma FOREIGN KEY 
(chave estrangeira) para que exista um relacionamento entre as tabelas.*/

ALTER TABLE TB_LIVRO ADD CONSTRAINTS "FK_LIVRO_EDITORA" 
FOREIGN KEY ("ID_EDITORA") 
REFERENCES "ALUNO"."TB_EDITORA" ("ID_EDITORA") ENABLE;

/*Usando JOIN para unir duas tabelas*/
SELECT livro.titulo,
editora.descricao
FROM TB_LIVRO livro
JOIN
TB_EDITORA editora ON (livro.id_editora=editora.id_editora);

/*Desabilitando a constraint FK_LIVRO_EDITORA da tabela TB_LIVRO
para poder digitar dados "errados"*/
ALTER TABLE TB_LIVRO DISABLE CONSTRAINTS FK_LIVRO_EDITORA;

/*Usando LEFT JOIN para unir tabelas (mostra todos os itens da tabela da 
esquerda, se na da direita não tiver mostra null)*/
SELECT livro.titulo,
editora.descricao
FROM TB_LIVRO livro
LEFT JOIN
TB_EDITORA editora ON (livro.id_editora=editora.id_editora);

/*Habilitando a constraint FK_LIVRO_EDITORA da tabela TB_LIVRO*/
ALTER TABLE TB_LIVRO ENABLE CONSTRAINTS FK_LIVRO_EDITORA;

/*Desabilitando a de novo para ver o uso do right e do full"*/
ALTER TABLE TB_LIVRO DISABLE CONSTRAINTS FK_LIVRO_EDITORA;

/*Usando RIGHT JOIN para unir tabelas (mostra todos os itens da tabela da 
direita, se na da esquerda não tiver mostra null)*/
SELECT livro.titulo,
editora.descricao
FROM TB_LIVRO livro
RIGHT JOIN
TB_EDITORA editora ON (livro.id_editora=editora.id_editora);

/*Exibindo os dados de duas tabelas TB_LIVRO e TB_EDITORA 
através do comando FULL JOIN, que permite a junção entre tabelas, 
desta vez, serão exibidos todos os dados de ambas as tabelas 
tabela principal(TB_LIVRO) relacionados ou não com a tabela TB_EDITORA.*/
SELECT livro.titulo,
editora.descricao
FROM TB_LIVRO livro
FULL JOIN
TB_EDITORA editora ON (livro.id_editora=editora.id_editora);









