drop table previous_application;
drop table installments_payments;
drop table credit_card_balance;
drop table bureau_balance;
drop table bureau;
drop table POS_Cash_balance;
drop table application_train;


create table application_train(
	 SK_ID_CURR        char(6),
     Target            char(1) check(target in ('1', '0')),
     NAME_CONTRACT_TYPE    VARCHAR(15) check(NAME_CONTRACT_TYPE in ('Cash loans', 'Revolving loans', 'Sold')),
     CODE_GENDER        char(1) check(CODE_GENDER in ('M', 'F')),
     FLAG_OWN_CAR        char(1) check(FLAG_OWN_CAR in ('Y', 'N')),
     FLAG_OWN_REALTY    char(1) check(FLAG_OWN_REALTY in ('Y', 'N')),
     CNT_CHILDREN        numeric(10,0),
     AMT_INCOME_TOTAL         numeric(10,2),
     AMT_CREDIT        numeric(10,2),
     AMT_ANNUITY        numeric(10,2),
     primary key(SK_ID_CURR)
);

create table POS_Cash_balance(
	SK_ID_PREV				char(7),
	SK_ID_CURR				char(6),
	MONTHS_BALANCE			numeric(2,0) check(MONTHS_BALANCE <= 0),
	CNT_INSTALLMENT			numeric(2,0) check(CNT_INSTALLMENT >= 0),
	CNT_INSTALLMENT_FUTURE	numeric(2,0) check(CNT_INSTALLMENT_FUTURE >= 0),
	NAME_CONTRACT			VARCHAR(9) check(NAME_CONTRACT in ('Active', 'Completed', 'Signed', 'Approved')),
	SK_DPD					char(5),
	SK_DPD_DEF				char(5),
	primary key(SK_ID_PREV),
	foreign key(SK_ID_CURR) references application_train (SK_ID_CURR)
			on delete set null
);

create table bureau(
	SK_ID_CURR				char(6),
	SK_ID_BUREAU			char(7),
	CREDIT_ACTIVE			varchar(6) check(CREDIT_ACTIVE in ('Closed', 'Active', 'Sold')),
	CREDIT_CURRENCY			varchar(10) check(CREDIT_CURRENCY in ('currency 1', 'currency 2')),
	DAYS_CREDIT				numeric(4,0) check(DAYS_CREDIT <= 0),
	CREDIT_DAY_OVERDUE		varchar(9),
	DAYS_CREDIT_ENDDATE		varchar(9),
	DAYS_ENDDATE_FACT		varchar(9),
	AMT_CREDIT_MAX_OVERDUE	varchar(9),
	CNT_CREDIT_PROLONG		numeric(1,0) check(CNT_CREDIT_PROLONG >= 0 and CNT_CREDIT_PROLONG <= 9),
	primary key(SK_ID_BUREAU),
	foreign key(SK_ID_CURR) references application_train (SK_ID_CURR)
			on delete set null
);

create table bureau_balance(
	SK_ID_BUREAU			char(7),
	MONTHS_BALANCE			numeric(2,0) check(MONTHS_BALANCE <= 0),
	STATUS					char(1),
	foreign key(SK_ID_BUREAU) references bureau (SK_ID_BUREAU)
			on delete set null
);

create table credit_card_balance(
	SK_ID_PREV					char(7),
	SK_ID_CURR					char(6),
	MONTHS_BALANCE				numeric(8,0) check(MONTHS_BALANCE <= 0),
	AMT_BALANCE					numeric(8,2),
	AMT_CREDIT_LIMIT_ACTUAL		numeric(8,0), check(AMT_CREDIT_LIMIT_ACTUAL >= 0),
	AMT_DRAWINGS_ATM_CURRENT	varchar(10),
	AMT_DRAWINGS_CURRENT		varchar(10),
	AMT_DRAWINGS_OTHER_CURRENT	varchar(10),
	AMT_DRAWINGS_POS_CURRENT	varchar(10),
	AMT_INST_MIN_REGULARITY		numeric(8,2),
	foreign key(SK_ID_PREV) references POS_Cash_balance (SK_ID_PREV)
			on delete set null,
	foreign key(SK_ID_CURR) references application_train (SK_ID_CURR)
			on delete set null
);

create table installments_payments(
	SK_ID_PREV					char(7),
	SK_ID_CURR					char(6),
	NUM_INSTALMENT_VERSION		numeric(6,0) check(NUM_INSTALMENT_VERSION >= 0),
	NUM_INSTALMENT_NUMBER		numeric(6,0) check(NUM_INSTALMENT_NUMBER >= 0),
	DAYS_INSTALMENT				numeric(4,0) check(DAYS_INSTALMENT <= 0),
	DAYS_ENTRY_PAYMENT			numeric(4,0) check(DAYS_ENTRY_PAYMENT <= 0),
	AMT_INSTALMENT				numeric(9,0),
	AMT_PAYMENT					numeric(9,0),
	foreign key(SK_ID_PREV) references POS_Cash_balance (SK_ID_PREV)
			on delete set null,
	foreign key(SK_ID_CURR) references application_train (SK_ID_CURR)
			on delete set null
);

create table previous_application(
	SK_ID_PREV					char(7),
	SK_ID_CURR					char(6),
	NAME_CONTRACT_TYPE    		VARCHAR(15) check(NAME_CONTRACT_TYPE in ('Cash loans', 'Revolving loans', 'Consumer loans')),
	AMT_ANNUITY        			varchar(10),
	AMT_APPLICATION				varchar(10),
	AMT_CREDIT					varchar(10),
	AMT_DOWN_PAYMENT			varchar(10),
	AMT_GOODS_PRICE				varchar(10),
	WEEKDAY_APPR_PROCESS_START	varchar(9) check(WEEKDAY_APPR_PROCESS_START in ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY')),
	HOUR_APPR_PROCESS_START		NUMERIC(2,0),
	foreign key(SK_ID_PREV) references POS_Cash_balance (SK_ID_PREV)
			on delete set null,
	foreign key(SK_ID_CURR) references application_train (SK_ID_CURR)
			on delete set null


	
)