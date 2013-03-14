  drop table if exists person;
  drop table if exists authorities;
  drop table if exists group_members;
  drop table if exists group_authorities;
  drop table if exists groups;
  drop table if exists oauth_refresh_token;
  drop table if exists oauth_access_token;
  drop table if exists oauth_client_token;
  drop table if exists oauth_client_details;
  drop table if exists oauth_code;
  drop table if exists ClientDetails;
  drop table if exists users;

  create table if not exists person(ID INTEGER NOT NULL primary key,FIRST_NAME VARCHAR(100),LAST_NAME VARCHAR(100),NUMBER INTEGER,BRITH_DATE DATE);

  create table if not exists  users(
	  username varchar(50) not null primary key,
	  password varchar(50) not null,
	  enabled boolean not null);

  create table if not exists  authorities (
	  username varchar(50) not null,
	  authority varchar(50) not null,
	  constraint fk_authorities_users foreign key(username) references users(username),
	  unique index ix_auth_username (username,authority)
	  );

	  #create unique index ix_auth_username on authorities (username,authority);


	create table if not exists groups (
	  id BIGINT AUTO_INCREMENT  primary key,
	  group_name varchar(50) not null);

	create table if not exists group_authorities (
	  group_id bigint not null,
	  authority varchar(50) not null,
	  constraint fk_group_authorities_group foreign key(group_id) references groups(id));

	create table if not exists group_members (
	  id BIGINT AUTO_INCREMENT  primary key,
	  username varchar(50) not null,
	  group_id bigint not null,
	  constraint fk_group_members_group foreign key(group_id) references groups(id));

	create table if not exists  persistent_logins (
	  username varchar(64) not null,
	  series varchar(64) primary key,
	  token varchar(64) not null,
	  last_used timestamp not null);


	create table if not exists oauth_client_details (
	  client_id VARCHAR(128) PRIMARY KEY,
	  resource_ids VARCHAR(128),
	  client_secret VARCHAR(128),
	  scope VARCHAR(128),
	  authorized_grant_types VARCHAR(128),
	  web_server_redirect_uri VARCHAR(128),
	  authorities VARCHAR(128),
	  access_token_validity INTEGER,
	  refresh_token_validity INTEGER,
	  additional_information VARCHAR(128)
	);

	create table if not exists oauth_client_token (
	  token_id VARCHAR(256),
	  token longblob,
	  authentication_id VARCHAR(256),
	  user_name VARCHAR(256),
	  client_id VARCHAR(256)
	);

	create table if not exists oauth_access_token (
	  token_id VARCHAR(256),
	  token longblob,
	  authentication_id VARCHAR(256),
	  user_name VARCHAR(256),
	  client_id VARCHAR(256),
	  authentication longblob,
	  refresh_token VARCHAR(256)
	);

	create table if not exists oauth_refresh_token (
	  token_id VARCHAR(256),
	  token longblob,
	  authentication longblob
	);

	create table if not exists oauth_code (
	  code VARCHAR(256), authentication longblob
	);

	create table if not exists ClientDetails (
	  appId VARCHAR(128) PRIMARY KEY,
	  resourceIds VARCHAR(128),
	  appSecret VARCHAR(128),
	  scope VARCHAR(128),
	  grantTypes VARCHAR(128),
	  redirectUrl VARCHAR(128),
	  authorities VARCHAR(128),
	  access_token_validity INTEGER,
	  refresh_token_validity INTEGER,
	  additionalInformation VARCHAR(256)
	);