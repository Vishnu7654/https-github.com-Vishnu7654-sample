Provider  port:9990
=====================

CREATE DATABASE replica;

CREATE EXTENSION pglogical;

CREATE TABLE log(id int primary key,name text,location char(30));

SELECT pglogical.create_node(
    node_name := 'provider',
    dsn := 'host=localhost port=9990 dbname=replica'
);

select pglogical.replication_set_add_table(set_name := 'default', relation := 'log' , synchronize_data := 'true');

INSERT INTO log  VALUES (101,'vishnu','chennai');

INSERT INTO log VALUES (102,'vardhan','bangalore');
 
INSERT INTO log VALUES (103,'vishanth','tirupathi');
 
INSERT INTO log VALUES (104,'tarak','kadapa');
 
INSERT INTO log VALUES (105,'siddu','hyderabad');


 Subscriber port:9991
======================

CREATE DATABASE replica;

CREATE EXTENSION pglogical;

CREATE TABLE log(id int primary key,name text,location char(30));

SELECT pglogical.create_node(node_name := 'subscriber', dsn := 'host=localhost port=9991 dbname=replica');

SELECT pglogical.create_subscription(subscription_name := 'subscription',provider_dsn := 'host=locahost port=9990 dbname=replica');

SELECT * FROM log;
