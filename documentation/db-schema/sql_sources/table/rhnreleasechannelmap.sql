-- created by Oraschemadoc Fri Mar  2 05:56:53 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE TABLE "SPACEWALK"."RHNRELEASECHANNELMAP" 
   (	"PRODUCT" VARCHAR2(64) NOT NULL ENABLE, 
	"VERSION" VARCHAR2(64) NOT NULL ENABLE, 
	"RELEASE" VARCHAR2(64) NOT NULL ENABLE, 
	"CHANNEL_ARCH_ID" NUMBER NOT NULL ENABLE, 
	"CHANNEL_ID" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "RHN_RCM_PVA_DEF_UNIQ" UNIQUE ("PRODUCT", "VERSION", "CHANNEL_ARCH_ID", "RELEASE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "RHN_RCM_CAID_FK" FOREIGN KEY ("CHANNEL_ARCH_ID")
	  REFERENCES "SPACEWALK"."RHNCHANNELARCH" ("ID") ENABLE, 
	 CONSTRAINT "RHN_RCM_CID_FK" FOREIGN KEY ("CHANNEL_ID")
	  REFERENCES "SPACEWALK"."RHNCHANNEL" ("ID") ON DELETE CASCADE ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ENABLE ROW MOVEMENT 
 
/
