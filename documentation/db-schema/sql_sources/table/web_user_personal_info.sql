-- created by Oraschemadoc Fri Mar  2 05:57:16 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE TABLE "SPACEWALK"."WEB_USER_PERSONAL_INFO" 
   (	"WEB_USER_ID" NUMBER NOT NULL ENABLE, 
	"PREFIX" VARCHAR2(12) DEFAULT (' ') NOT NULL ENABLE, 
	"FIRST_NAMES" VARCHAR2(128) NOT NULL ENABLE, 
	"LAST_NAME" VARCHAR2(128) NOT NULL ENABLE, 
	"GENQUAL" VARCHAR2(12), 
	"PARENT_COMPANY" VARCHAR2(128), 
	"COMPANY" VARCHAR2(128), 
	"TITLE" VARCHAR2(128), 
	"PHONE" VARCHAR2(128), 
	"FAX" VARCHAR2(128), 
	"EMAIL" VARCHAR2(128), 
	"EMAIL_UC" VARCHAR2(128), 
	"PIN" NUMBER, 
	"CREATED" DATE DEFAULT (sysdate) NOT NULL ENABLE, 
	"MODIFIED" DATE DEFAULT (sysdate) NOT NULL ENABLE, 
	"FIRST_NAMES_OL" VARCHAR2(128), 
	"LAST_NAME_OL" VARCHAR2(128), 
	"GENQUAL_OL" VARCHAR2(12), 
	"PARENT_COMPANY_OL" VARCHAR2(128), 
	"COMPANY_OL" VARCHAR2(128), 
	"TITLE_OL" VARCHAR2(128), 
	 CONSTRAINT "PERSONAL_INFO_WEB_USER_ID_FK" FOREIGN KEY ("WEB_USER_ID")
	  REFERENCES "SPACEWALK"."WEB_CONTACT" ("ID") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "WUPI_PREFIX_FK" FOREIGN KEY ("PREFIX")
	  REFERENCES "SPACEWALK"."WEB_USER_PREFIX" ("TEXT") ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ENABLE ROW MOVEMENT 
 
/
