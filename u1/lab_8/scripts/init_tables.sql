/*==============================================================*/
/* Table: DIM_CUSTOMER                                          */
/*==============================================================*/
create table DIM_CUSTOMER (
   "customer_id"        NUMBER                not null,
   "name"               VARCHAR2(150 CHAR),
   "first_name"         VARCHAR2(50 CHAR),
   "last_name"          VARCHAR2(50 CHAR),
   "phone"              VARCHAR2(50 CHAR),
   "country"            VARCHAR2(50 CHAR),
   "email"              VARCHAR2(100 CHAR),
   "birthday"           DATE,
   constraint PK_DIM_CUSTOMER primary key ("customer_id")
) tablespace ts_sa_dim_customers_01;

/*==============================================================*/
/* Table: DIM_GEN_DATE                                          */
/*==============================================================*/
create table DIM_GEN_DATE (
   "date_id"            DATE                  not null,
   "day_name"           VARCHAR2(44),
   "day_number_in_week" VARCHAR2(1),
   "day_number_in_month" VARCHAR2(2),
   "day_number_in_year" VARCHAR2(3),
   "calendar_week_number" VARCHAR2(1),
   "week_ending_date"   DATE,
   "calendar_month_number" VARCHAR2(2),
   "days_in_cal_month"  VARCHAR2(2),
   "end_of_cal_month"   DATE,
   "calendar_month_name" VARCHAR2(32),
   "days_in_cal_quarter" NUMBER,
   "beg_of_cal_quarter" DATE,
   "end_of_cal_quarter" DATE,
   "calendar_quarter_number" VARCHAR2(1),
   "calendar_year"      VARCHAR2(4),
   "days_in_cal_year"   NUMBER,
   "beg_of_cal_year"    DATE,
   "end_of_cal_year"    DATE,
   constraint PK_DIM_GEN_DATE primary key ("date_id")
)tablespace ts_sa_dim_products_01;

/*==============================================================*/
/* Table: DIM_GEO_LOCATION                                      */
/*==============================================================*/
create table DIM_GEO_LOCATION (
   "geo_id"             NUMBER                not null,
   "geo_group_id"       NUMBER,
   "geo_group_desc"     VARCHAR2(200),
   "geo_sub_group_id"   NUMBER,
   "geo_sub_group_desc" VARCHAR2(200),
   "geo_system_code"    NUMBER,
   "geo_system_desc"    VARCHAR2(200),
   "geo_region_id"      NUMBER,
   "geo_region_desc"    VARCHAR2(200),
   "geo_country_code_a2" VARCHAR2(200),
   "geo_country_code_a3" VARCHAR2(200),
   "geo_country_id"     NUMBER,
   "geo_country_desc"   VARCHAR2(200),
   constraint PK_DIM_GEO_LOCATION primary key ("geo_id")
) tablespace ts_sa_dim_products_01;

/*==============================================================*/
/* Table: DIM_PRODUCT_SCD                                       */
/*==============================================================*/
create table DIM_PRODUCT_SCD (
   "product_id"         NUMBER                not null,
   "sku_num"            VARCHAR2(50 CHAR),
   "eff_time"           DATE,
   "exp_time"           DATE,
   "price"              NUMBER,
   "description"        VARCHAR2(100 CHAR),
   "type"               VARCHAR2(25 CHAR),
   "brand"              VARCHAR2(80 CHAR),
   "producer_country"   VARCHAR2(50 CHAR),
   "volume"             NUMBER,
   "shelf_width"        NUMBER,
   "shelf_hight"        NUMBER,
   "shelf_depth"        NUMBER,
   "package"            VARCHAR2(50 CHAR),
   "package_color"      VARCHAR2(50 CHAR),
   "package_reusable"   VARCHAR2(50 CHAR),
   "taste"              VARCHAR2(80 CHAR),
   "alcohol"            NUMBER,
   constraint PK_DIM_PRODUCT_SCD primary key ("product_id")
) tablespace ts_sa_dim_products_01;

/*==============================================================*/
/* Table: DIM_STORE                                             */
/*==============================================================*/
create table DIM_STORE (
   "store_id"           NUMBER                not null,
   "adress"             VARCHAR2(50 CHAR),
   "country"            VARCHAR2(50 CHAR),
   "region"             VARCHAR2(50 CHAR),
   "city"               VARCHAR2(50 CHAR),
   "phone"              VARCHAR2(20 CHAR),
   constraint PK_DIM_STORE primary key ("store_id")
)tablespace ts_sa_dim_products_01;

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