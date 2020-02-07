-- INSTANCE INFO 
set lines 200 
column INSTANCE_NAME format a13 
column HOST_NAME format a11
column VERSION format a11
column SHUTDOWN_PENDING format a16
column ACTIVE_STATE format a12

prompt _________________________
prompt INSTANCE INFO:
prompt _________________________
select INSTANCE_NAME, HOST_NAME, VERSION, STARTUP_TIME, 
       DATABASE_STATUS, SHUTDOWN_PENDING, ACTIVE_STATE 
  from v$instance;

-- _________________________
-- ASM DISKGROUPS:
-- _________________________
@$U/asm/asm_info_dg

prompt
prompt _________________________
prompt ASM DISKS (by Group#, Disk Name, Path):
prompt _________________________
select GROUP_NUMBER GROUP#, DISK_NUMBER DISK#, NAME DISK_NAME, 
       PATH, STATE, MODE_STATUS, MOUNT_STATUS, 
       round(TOTAL_MB/1024,0) TOTAL_GB, 
       round(round(TOTAL_MB/1024,0)-round(FREE_MB/1024,0),0) USED_GB,
       round(FREE_MB/1024,0) FREE_GB
  from v$asm_disk
 order by GROUP_NUMBER, DISK_NAME, PATH;

prompt
prompt _________________________
prompt ASM DISKGROUPS / DISKS:
prompt _________________________
select d.GROUP_NUMBER GROUP#, d.DISK_NUMBER DISK#, dg.NAME GROUP_NAME, d.NAME DISK_NAME, 
       d.PATH, d.STATE, d.MODE_STATUS, d.MOUNT_STATUS, dg.TYPE, 
       dg.ALLOCATION_UNIT_SIZE AU_SIZE
  from v$asm_diskgroup dg, v$asm_disk d
 where dg. GROUP_NUMBER = d. GROUP_NUMBER
 order by dg.GROUP_NUMBER, d.DISK_NUMBER, d.PATH;

prompt
prompt _________________________
prompt ASM CLIENT:
prompt _________________________
@$U/asm/asm_info_dg_clients.sql 2,1

prompt
prompt _________________________
prompt ASM OPERATIONS CURRENTLY RUNNING:
prompt _________________________
@$U/asm/asm_oper.sql
