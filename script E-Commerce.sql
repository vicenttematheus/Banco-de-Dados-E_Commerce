CREATE DATABASE ECommerce;
use ECommerce;
CREATE TABLE cliente(
	idClient int auto_increment primary key,
    Fname varchar(15),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF)
);

alter table cliente auto_increment=1;

CREATE TABLE product(
	idProduct int auto_increment primary key,
    Pname varchar(15),
    classification_kids bool,
    category enum('Eletronico','Vestimenta','Brinquedos','Alimentos') not null,
    avaliação float default 0,
    size varchar(10)           -- size = dimensão do produto 
);

CREATE TABLE payments(	
	idclient int,
	idPayment int,
	typePayment enum('Boleto','Cartão','Dois cartões'),
	limitAvailable float,
	primary key(idClient, idPayment)
);

CREATE TABLE orders(
	idOrder int auto_increment primary key,
	idOrderClient int,
	orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
	orderDescription varchar(225),
	sendValue float default 10,
	paymentCash bool default false,
	constraint fk_ordes_client foreign key (idOrderClient) references cliente(idClient)
			on update cascade
);
CREATE TABLE productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
	quantity int default 0
);
CREATE TABLE supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char (11) not null,
    constraint unique_supplier unique (CNPJ)
);
CREATE TABLE seller(
	idSeller int auto_increment primary key,
    AbstName varchar(255) not null,
    SocialName varchar(255) not null,
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);
CREATE TABLE productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPSeller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct) 
);
CREATE TABLE productOrder(
	idPOproduct int,
	idPOorder int,
	poQuantity int default 1,
	poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
	primary key (idPOproduct, idPOorder),
	constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
	constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);
CREATE TABLE storageLocation(
	idLproduct int,
	idLstorage int,
	location varchar(255) not null,
	primary key (idLproduct, idLstorage),
	constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
	constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);
CREATE TABLE productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key(idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
	constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);
