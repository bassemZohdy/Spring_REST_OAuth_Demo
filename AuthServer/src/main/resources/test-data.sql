insert into person values (1,'firstName','lastName',3,'2008-08-22') ;
insert into person values (2,'firstName','lastName',3,'2008-08-22') ;
insert into person values (3,'firstName','lastName',3,'2008-08-22') ;
insert into person values (4,'firstName','lastName',3,'2008-08-22') ;
insert into person values (5,'firstName','lastName',3,'2008-08-22') ;
insert into person values (6,'firstName','lastName',3,'2008-08-22') ;
insert into person values (7,'firstName','lastName',3,'2008-08-22') ;
insert into person values (8,'firstName','lastName',3,'2008-08-22') ;
insert into person values (9,'firstName','lastName',3,'2008-08-22') ;
insert into person values (10,'firstName','lastName',3,'2008-08-22') ;
insert into person values (11,'firstName','lastName',3,'2008-08-22') ;
insert into person values (12,'firstName','lastName',3,'2008-08-22') ;

insert into users values ('user_01','5f4dcc3b5aa765d61d8327deb882cf99',1) ;
insert into users values ('user_02','5f4dcc3b5aa765d61d8327deb882cf99',1) ;

insert into authorities values ('user_01','ROLE_USER') ;
insert into authorities values ('user_01','ROLE_CLIENT') ;
insert into authorities values ('user_02','ROLE_USER') ;
insert into authorities values ('user_02','ROLE_CLIENT') ;
insert into authorities values ('user_02','ROLE_ADMIN') ;
insert into authorities values ('user_02','ROLE_TRUSTED_CLIENT') ;

insert into oauth_client_details values ('client1',null,null,'read,write,delete','password,authorization_code,refresh_token,implicit',null,'ROLE_CLIENT, ROLE_TRUSTED_CLIENT',null,null,null) ;





