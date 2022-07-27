/*==============================================================*/
/* Table: FCT_SALE                                              */
/*==============================================================*/
CREATE TABLE FCT_SALE (
   date_id            DATE,
   product_id         NUMBER,
   customer_id        NUMBER,
   store_id           NUMBER,
   geo_id             NUMBER,
   amount             NUMBER,
   pos_transaction    VARCHAR2(20 CHAR)
)
PARTITION BY RANGE (date_id) (
    PARTITION SALES_2019 VALUES LESS THAN (to_date('01/01/2020','DD/MM/YYYY')) TABLESPACE ts_sa_fct_sales_01,
    PARTITION SALES_2020 VALUES LESS THAN (to_date('01/01/2021','DD/MM/YYYY')) TABLESPACE ts_sa_fct_sales_01,
    PARTITION SALES_2021 VALUES LESS THAN (to_date('01/01/2022','DD/MM/YYYY')) TABLESPACE ts_sa_fct_sales_01,
    PARTITION SALES_2022 VALUES LESS THAN (to_date('01/01/2023','DD/MM/YYYY')) TABLESPACE ts_sa_fct_sales_01
)
TABLESPACE ts_sa_fct_sales_01;

alter table FCT_SALE
   add constraint FK_DIM_GEN_DATE foreign key (date_id)
      references DIM_GEN_DATE (date_id);

alter table FCT_SALE
   add constraint FK_DIM_PRODUCT foreign key (product_id)
      references DIM_PRODUCT (product_id);

alter table FCT_SALE
   add constraint FK_DIM_CUSTOMER foreign key (customer_id)
      references DIM_CUSTOMER (customer_id);

alter table FCT_SALE
   add constraint FK_DIM_STORE foreign key (store_id)
      references DIM_STORE (store_id);

alter table FCT_SALE
   add constraint FK_DIM_GEO_LOCATION foreign key (geo_id)
      references DIM_GEO_LOCATION (geo_id);