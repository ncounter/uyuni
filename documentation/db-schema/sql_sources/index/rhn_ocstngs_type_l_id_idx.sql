-- created by Oraschemadoc Fri Mar  2 05:57:35 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE INDEX "SPACEWALK"."RHN_OCSTNGS_TYPE_L_ID_IDX" ON "SPACEWALK"."RHNORGCHANNELSETTINGSTYPE" ("LABEL", "ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" 
 
/
