DROP DATABASE ATELIE;
CREATE DATABASE ATELIE;
USE ATELIE;


CREATE TABLE FUNCIONARIOS(
	cpf VARCHAR(14),
    nome VARCHAR(50),
    endereco VARCHAR(100),
    PRIMARY KEY(cpf)
);

CREATE TABLE ATENDENTES(
	cpf_func VARCHAR(14),
    nome_usuario VARCHAR(30),
    senha VARCHAR(50),
    PRIMARY KEY(cpf_func),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIOS(cpf)
);

CREATE TABLE ALFAIATES(
    hora_extra REAL,
    comissao REAL,
    cpf_func VARCHAR(14),
    PRIMARY KEY(cpf_func),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIOS(cpf)
);

CREATE TABLE GERENTES(
    nome_usuario VARCHAR(30),
    senha VARCHAR(50),
    cpf_func VARCHAR(14),
    PRIMARY KEY(cpf_func),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIOS(cpf)
);

CREATE TABLE CLIENTES(
	cpf VARCHAR(14),
    nome VARCHAR(40),
    telefone INTEGER,
    PRIMARY KEY(cpf)
);

CREATE TABLE PEDIDOS(
	nro INTEGER,
    valor REAL,
    forma_pagamento VARCHAR(30),
    qtde_pecas INTEGER,
    descricao_ajustes VARCHAR(300),
    cpf_cliente VARCHAR(14),
    cpf_atendente VARCHAR(14),
    PRIMARY KEY(nro),
    FOREIGN KEY(cpf_cliente) REFERENCES CLIENTES(cpf),
    FOREIGN KEY(cpf_atendente) REFERENCES ATENDENTES(cpf_func)
);

CREATE TABLE ROUPAS(
	id INTEGER,
    tamanho VARCHAR(3),
    tipo_roupa VARCHAR(30),
    descricao_tecido VARCHAR(300),
    PRIMARY KEY(id)
);

CREATE TABLE CONTAS(
	nro INTEGER,
    tipo VARCHAR(30),
    valor REAL,
    situacao VARCHAR(15),
    data_vencimento DATE,
    cpf_gerente VARCHAR(14) NOT NULL,
    PRIMARY KEY(nro),
    FOREIGN KEY(cpf_gerente) REFERENCES GERENTES(cpf_func)
);

CREATE TABLE SALARIOS(
	id INTEGER,
    valor REAL,
    mes VARCHAR(15),
    situacao VARCHAR(15),
    cpf_gerente VARCHAR(14) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(cpf_gerente) REFERENCES GERENTES(cpf_func)
);

CREATE TABLE PEDIDO_TEM_ROUPA(
	id_roupa INTEGER,
	nro_pedido INTEGER,
    PRIMARY KEY(id_roupa, nro_pedido),
    FOREIGN KEY(id_roupa) REFERENCES ROUPAS(id),
    FOREIGN KEY(nro_pedido) REFERENCES PEDIDOS(nro)
);

CREATE TABLE FUNCIONARIOS_RECEBEM_SALARIOS(
	cpf_func VARCHAR(14),
    id_salario INTEGER,
    PRIMARY KEY(cpf_func, id_salario),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIOS(cpf),
    FOREIGN KEY(id_salario) REFERENCES SALARIOS(id)
);


###  INSERTS  ###

# gerentes
INSERT INTO FUNCIONARIOS (cpf, nome, endereco) values ('689.143.740-76', 'Gun Reilly', 'Avenida Rio Branco, 1884, Rio de Janeiro-RJ');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('071.765.960-77', 'Dori Ship', 'Rua Maria Luísa do Val Penteado, 450, São Paulo-SP');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('767.329.840-63', 'Von Yankeev', 'Avenida São João, 1281, Florianópolis-SC');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('405.115.780-67', 'Kimmi Fone', 'Avenida Tocantins, 271, Jataí-GO');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('176.863.280-40', 'Bibi Trubshawe', 'Travessa Antônio Ferreira, 1410, Capanema-PA');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('295.606.960-84', 'Pincas Tolliday', 'Avenida Esbertalina Barbosa Damiani, 86, São Mateus-ES');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('389.073.200-39', 'Astra Pollastro', 'Rua da Imprensa, 1606, Campo Grande-MS');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('545.038.840-34', 'Robinetta Maharg', 'Rua Frederico Moura, 954, Londrina-PR');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('419.902.660-61', 'Johannes Screwton', 'Rodovia Raposo Tavares, 1379, Cotia-SP');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('219.662.640-62', 'Georgeta Collinson', 'Avenida Governador José Malcher, 1751, Belém-PA');
# atendentes
insert into FUNCIONARIOS (cpf, nome, endereco) values ('032.323.940-43', 'Adelle Keyte', 'Rua Frederico Moura, 1028, Franca-SP');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('896.928.120-73', 'Anna-maria McSparran', 'Avenida Almirante Maximiano Fonseca, 1757, Rio Grande-RS');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('408.797.360-38', 'Rori Conrath', 'Avenida Desembargador Moreira, 1704, Fortaleza-CE');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('784.598.370-50', 'Baron Leechman', 'Rua Tenente-Coronel Cardoso, 905, Campos dos Goytacazes-RJ');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('217.595.680-66', 'Cloe Hazlegrove', 'Rua Pereira Estéfano, 643, São Paulo-SP');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('582.559.130-33', 'Allard Lelievre', 'Rua Domingos Olímpio, 631, Sobral-CE');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('704.668.050-71', 'Alla Ungerechts', 'Rua Carlos Augusto Cornelsen, 495, Curitiba-PR');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('047.601.640-14', 'Julissa Endecott', 'Rua Carlos Augusto Cornelsen, 1618, Curitiba-PR');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('255.690.250-73', 'Brod Bidnall', 'Rua Paracatu, 539, São Paulo-SP');
insert into FUNCIONARIOS (cpf, nome, endereco) values ('272.728.770-49', 'Budd Dubose', 'Rua Barão de Vitória, 433, Diadema-SP');


insert into ATENDENTES (cpf_func, nome_usuario, senha) values ('032.323.940-43' , 'claudia123', 'V7nkZ');
insert into ATENDENTES (cpf_func, nome_usuario, senha) values ('896.928.120-73', 'nelsow1', 'Y5yrQ');
insert into ATENDENTES (cpf_func, nome_usuario, senha) values ('408.797.360-38', 'iryann', 'O3Yd4');
insert into ATENDENTES (cpf_func, nome_usuario, senha) values ('784.598.370-50', 'dlewsie3', 'T3rr3');
insert into ATENDENTES (cpf_func, nome_usuario, senha) values ('217.595.680-66', 'rfeeley4', 'X2KrW');
insert into ATENDENTES (cpf_func, nome_usuario, senha) values ('582.559.130-33', 'dwelband5', 'D5Ov0');
insert into ATENDENTES (cpf_func, nome_usuario, senha) values ('704.668.050-71', 'ncuchey6', 'D0PxO');
insert into ATENDENTES (cpf_func, nome_usuario, senha) values ('047.601.640-14', 'ubroadbere7', 'R6jrF');
insert into ATENDENTES (cpf_func, nome_usuario, senha) values ('255.690.250-73', 'bkennicott8', 'T0hkW');
insert into ATENDENTES (cpf_func, nome_usuario, senha) values ('272.728.770-49', 'tlabba9', 'S6pl6');


insert into ALFAIATES (cpf_func, hora_extra, comissao) values ('989.576.580-09', 38.13, 93.21);
insert into ALFAIATES (cpf_func, hora_extra, comissao) values ('586.342.060-09', 46.55, 244.24);
insert into ALFAIATES (cpf_func, hora_extra, comissao) values ('440.598.670-39', 46.82, 45.41);
insert into ALFAIATES (cpf_func, hora_extra, comissao) values ('143.650.920-30', 17.98, 135.85);
insert into ALFAIATES (cpf_func, hora_extra, comissao) values ('898.464.100-69', 45.36, 147.90);
insert into ALFAIATES (cpf_func, hora_extra, comissao) values ('006.058.530-70', 23.74, 196.68);
insert into ALFAIATES (cpf_func, hora_extra, comissao) values ('188.363.550-05', 44.96, 52.69);
insert into ALFAIATES (cpf_func, hora_extra, comissao) values ('100.592.520-81', 48.28, 108.66);
insert into ALFAIATES (cpf_func, hora_extra, comissao) values ('085.021.270-71', 22.85, 91.11);
insert into ALFAIATES (cpf_func, hora_extra, comissao) values ('844.008.100-62', 3.75, 98.69);


insert into GERENTES (cpf_func, nome_usuario, senha) values ('689.143.740-76', 'twagnerin0', 'VGoMgZUZ9K');
insert into GERENTES (cpf_func, nome_usuario, senha) values ('071.765.960-77', 'hszymanowski1', '22Z6DMINP4tH');
insert into GERENTES (cpf_func, nome_usuario, senha) values ('767.329.840-63', 'lpeckett2', 'hwFatRESEE');
insert into GERENTES (cpf_func, nome_usuario, senha) values ('405.115.780-67', 'braleston3', 'LeLW28HM');
insert into GERENTES (cpf_func, nome_usuario, senha) values ('176.863.280-40', 'ojakobsson4', 'MeFpT0gh');
insert into GERENTES (cpf_func, nome_usuario, senha) values ('295.606.960-84', 'dmcgillivrie5', 'kyJgkHQFZe');
insert into GERENTES (cpf_func, nome_usuario, senha) values ('389.073.200-39', 'aquince6', 'FmgC0KFSH7');
insert into GERENTES (cpf_func, nome_usuario, senha) values ('545.038.840-34', 'lwhittington7', '44GdMJ');
insert into GERENTES (cpf_func, nome_usuario, senha) values ('419.902.660-61', 'jdelos8', 'udjGuwVrPn');
insert into GERENTES (cpf_func, nome_usuario, senha) values ('219.662.640-62', 'cfernanando9', '0cLDtIOv');


insert into CLIENTES (cpf, nome, telefone) values ('192.345.820-55', 'Bambi Veronique', '3257293463');
insert into CLIENTES (cpf, nome, telefone) values ('979.937.700-50', 'Geri Gozard', '5695904725');
insert into CLIENTES (cpf, nome, telefone) values ('413.186.510-69', 'Desirae Ionesco', '4455390094');
insert into CLIENTES (cpf, nome, telefone) values ('159.704.520-92', 'Lonni Ainslie', '1538977480');
insert into CLIENTES (cpf, nome, telefone) values ('411.683.580-35', 'Keriann Wellwood', '2104690417');
insert into CLIENTES (cpf, nome, telefone) values ('787.918.720-06', 'Leanora Cooney', '5696924630');
insert into CLIENTES (cpf, nome, telefone) values ('883.398.180-07', 'Steffie Ritmeyer', '6891664222');
insert into CLIENTES (cpf, nome, telefone) values ('059.853.570-58', 'Kristian Tenant', '8206447177');
insert into CLIENTES (cpf, nome, telefone) values ('879.117.570-46', 'Ailis Hedworth', '1992176556');
insert into CLIENTES (cpf, nome, telefone) values ('641.446.350-74', 'Georgena Seman', '7643411986');


insert into PEDIDOS (nro, qtde_pecas, valor, forma_pagamento, descricao_ajustes, cpf_cliente, cpf_atendente) values (1, 2, 138.9, 'crédito 2x', 'diminuir 3cm da barra da calça e adicionar 2 os bolsos em suas laterais', '192.345.820-55', '032.323.940-43');
insert into PEDIDOS (nro, qtde_pecas, valor, forma_pagamento, descricao_ajustes, cpf_cliente, cpf_atendente) values (2, 3, 71.8, 'dinheiro à vista', 'aumentar o cós do shorts em 2cm', '979.937.700-50', '896.928.120-73');
insert into PEDIDOS (nro, qtde_pecas, valor, forma_pagamento, descricao_ajustes, cpf_cliente, cpf_atendente) values (3, 4, 72.5, 'dinheiro à vista', 'apertar 3cm da cintura da calça', '413.186.510-69', '408.797.360-38');
insert into PEDIDOS (nro, qtde_pecas, valor, forma_pagamento, descricao_ajustes, cpf_cliente, cpf_atendente) values (4, 5, 296.9, 'débito 3x', 'aumentar 2cm da manga da camiseta', '159.704.520-92', '784.598.370-50');
insert into PEDIDOS (nro, qtde_pecas, valor, forma_pagamento, descricao_ajustes, cpf_cliente, cpf_atendente) values (5, 1, 39.9, 'dinheiro à vista', 'apertar o corpo da bermuda em 2cm', '411.683.580-35', '217.595.680-66');
insert into PEDIDOS (nro, qtde_pecas, valor, forma_pagamento, descricao_ajustes, cpf_cliente, cpf_atendente) values (6, 2, 77.9, 'dinheiro à vista', 'deixar 3cm da bermuda mais larga (exceto cintura)', '787.918.720-06', '582.559.130-33');
insert into PEDIDOS (nro, qtde_pecas, valor, forma_pagamento, descricao_ajustes, cpf_cliente, cpf_atendente) values (7, 3, 223.5, 'débito à vista', 'nenhum', '883.398.180-07', '704.668.050-71');
insert into PEDIDOS (nro, qtde_pecas, valor, forma_pagamento, descricao_ajustes, cpf_cliente, cpf_atendente) values (8, 4, 295.5, 'parcelado 4x', 'aumentar em 2cm as mangas do moletom', '059.853.570-58', '047.601.640-14');
insert into PEDIDOS (nro, qtde_pecas, valor, forma_pagamento, descricao_ajustes, cpf_cliente, cpf_atendente) values (9, 5, 335.0, 'parcelado 3x', 'aumentar 3cm do cós da calça e retirar seus bolsos laterais', '879.117.570-46', '255.690.250-73');
insert into PEDIDOS (nro, qtde_pecas, valor, forma_pagamento, descricao_ajustes, cpf_cliente, cpf_atendente) values (10, 1, 89.9, 'dinheiro à vista', 'nenhum', '641.446.350-74', '272.728.770-49');


insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (1, 'calça', 'P', 'jeans');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (2, 'calça', 'M', 'jeans');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (3, 'calça', 'G', 'jeans');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (4, 'camiseta', 'P', 'algodão');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (5, 'camiseta', 'M', 'algodão');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (6, 'camiseta', 'G', 'algodão');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (7, 'bermuda', 'P', 'tactel');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (8, 'bermuda', 'M', 'tactel');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (9, 'bermuda', 'G', 'tactel');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (10, 'blusa de moletom', 'P', 'algodão');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (11, 'blusa de moletom', 'M', 'algodão');
insert into ROUPAS (id, tipo_roupa, tamanho, descricao_tecido) values (12, 'blusa de moletom', 'G', 'algodão');


insert into PEDIDO_TEM_ROUPA (id_roupa, nro_pedido) values (1, 4);
insert into PEDIDO_TEM_ROUPA (id_roupa, nro_pedido) values (2, 3);
insert into PEDIDO_TEM_ROUPA (id_roupa, nro_pedido) values (3, 2);
insert into PEDIDO_TEM_ROUPA (id_roupa, nro_pedido) values (4, 1);
insert into PEDIDO_TEM_ROUPA (id_roupa, nro_pedido) values (5, 5);
insert into PEDIDO_TEM_ROUPA (id_roupa, nro_pedido) values (6, 9);
insert into PEDIDO_TEM_ROUPA (id_roupa, nro_pedido) values (7, 8);
insert into PEDIDO_TEM_ROUPA (id_roupa, nro_pedido) values (8, 7);
insert into PEDIDO_TEM_ROUPA (id_roupa, nro_pedido) values (9, 6);
insert into PEDIDO_TEM_ROUPA (id_roupa, nro_pedido) values (0, 5);


insert into CONTAS (nro, tipo, valor, situacao, data_vencimento, cpf_gerente) values (1, 'água', 268.87, 'paga', '2022/07/08', '689.143.740-76');
insert into CONTAS (nro, tipo, valor, situacao, data_vencimento, cpf_gerente) values (2, 'energia', 1158.78, 'não paga', '2022/08/24', '071.765.960-77');
insert into CONTAS (nro, tipo, valor, situacao, data_vencimento, cpf_gerente) values (3, 'internet', 50.0, 'não paga', '2022/07/21', '767.329.840-63');
insert into CONTAS (nro, tipo, valor, situacao, data_vencimento, cpf_gerente) values (4, 'compra de tecido', 1057.80, 'paga', '2022/06/13', '405.115.780-67');
insert into CONTAS (nro, tipo, valor, situacao, data_vencimento, cpf_gerente) values (5, 'água', 226.92, 'vencida', '2022/06/08', '176.863.280-40');
insert into CONTAS (nro, tipo, valor, situacao, data_vencimento, cpf_gerente) values (6, 'energia', 1456.23, 'paga', '2022/07/03', '295.606.960-84');
insert into CONTAS (nro, tipo, valor, situacao, data_vencimento, cpf_gerente) values (7, 'compra de linhas', 380.99, 'paga', '2022/06/19', '389.073.200-39');
insert into CONTAS (nro, tipo, valor, situacao, data_vencimento, cpf_gerente) values (8, 'internet', 50.0, 'paga', '2022/06/21', '545.038.840-34');
insert into CONTAS (nro, tipo, valor, situacao, data_vencimento, cpf_gerente) values (9, 'compras de ferramentas', 240.99, 'paga', '2022/06/10', '419.902.660-61');
insert into CONTAS (nro, tipo, valor, situacao, data_vencimento, cpf_gerente) values (10, 'compra de botões', 120.0, 'paga', '2022/06/24', '219.662.640-62');


insert into SALARIOS (id, valor, mes, situacao, cpf_gerente) values (1, 2700, 'janeiro', 'pago', '689.143.740-76');
insert into SALARIOS (id, valor, mes, situacao, cpf_gerente) values (2, 3400, 'janeiro', 'pago', '071.765.960-77');
insert into SALARIOS (id, valor, mes, situacao, cpf_gerente) values (3, 3000, 'janeiro', 'pago', '767.329.840-63');
insert into SALARIOS (id, valor, mes, situacao, cpf_gerente) values (4, 2700, 'fevereiro', 'pago', '405.115.780-67');
insert into SALARIOS (id, valor, mes, situacao, cpf_gerente) values (5, 3400, 'fevereiro', 'pago', '176.863.280-40');
insert into SALARIOS (id, valor, mes, situacao, cpf_gerente) values (6, 3100, 'fevereiro', 'pago', '295.606.960-84');
insert into SALARIOS (id, valor, mes, situacao, cpf_gerente) values (7, 2700, 'março', 'pago', '389.073.200-39');
insert into SALARIOS (id, valor, mes, situacao, cpf_gerente) values (8, 3400, 'março', 'pago', '545.038.840-34');
insert into SALARIOS (id, valor, mes, situacao, cpf_gerente) values (9, 3250, 'março', 'pago', '419.902.660-61');
insert into SALARIOS (id, valor, mes, situacao, cpf_gerente) values (10, 2700, 'abril', 'pago', '219.662.640-62');


insert into FUNCIONARIOS_RECEBEM_SALARIOS (id_salario, cpf_func) values (1, '689.143.740-76');
insert into FUNCIONARIOS_RECEBEM_SALARIOS (id_salario, cpf_func) values (2, '071.765.960-77');
insert into FUNCIONARIOS_RECEBEM_SALARIOS (id_salario, cpf_func) values (3, '767.329.840-63');
insert into FUNCIONARIOS_RECEBEM_SALARIOS (id_salario, cpf_func) values (4, '405.115.780-67');
insert into FUNCIONARIOS_RECEBEM_SALARIOS (id_salario, cpf_func) values (5, '176.863.280-40');
insert into FUNCIONARIOS_RECEBEM_SALARIOS (id_salario, cpf_func) values (6, '295.606.960-84');
insert into FUNCIONARIOS_RECEBEM_SALARIOS (id_salario, cpf_func) values (7, '389.073.200-39');
insert into FUNCIONARIOS_RECEBEM_SALARIOS (id_salario, cpf_func) values (8, '545.038.840-34');
insert into FUNCIONARIOS_RECEBEM_SALARIOS (id_salario, cpf_func) values (9, '419.902.660-61');
insert into FUNCIONARIOS_RECEBEM_SALARIOS (id_salario, cpf_func) values (10, '219.662.640-62');

