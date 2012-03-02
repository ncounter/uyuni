-- created by Oraschemadoc Fri Mar  2 05:56:58 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE TABLE "SPACEWALK"."RHNSERVERSERVERGROUPARCHCOMPAT" 
   (	"SERVER_ARCH_ID" NUMBER NOT NULL ENABLE, 
	"SERVER_GROUP_TYPE" NUMBER NOT NULL ENABLE, 
	"CREATED" DATE DEFAULT (sysdate) NOT NULL ENABLE, 
	"MODIFIED" DATE DEFAULT (sysdate) NOT NULL ENABLE, 
	 CONSTRAINT "RHN_SSG_AC_SAID_FK" FOREIGN KEY ("SERVER_ARCH_ID")
	  REFERENCES "SPACEWALK"."RHNSERVERARCH" ("ID") ENABLE, 
	 CONSTRAINT "RHN_SSG_AC_SGT_FK" FOREIGN KEY ("SERVER_GROUP_TYPE")
	  REFERENCES "SPACEWALK"."RHNSERVERGROUPTYPE" ("ID") ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ENABLE ROW MOVEMENT 
 
/
