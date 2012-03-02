-- created by Oraschemadoc Fri Mar  2 05:57:53 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE INDEX "SPACEWALK"."RHN_VI_HSID_VSID_IDX" ON "SPACEWALK"."RHNVIRTUALINSTANCE" ("HOST_SYSTEM_ID", "VIRTUAL_SYSTEM_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" 
 
/
