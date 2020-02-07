--
--  $Header: /plus/v3/spam/precious/files/ACTIVE/glogin.sql,v 1.6 1995/07/25 02:33:26 cjones Exp $
--  Copyright (c) Oracle Corporation 1988, 1994, 1995.  All Rights Reserved.
--
--  SQL*Plus Global Login startup file.
--
--  This is the global login file for SQL*Plus.
--  Add any sqlplus commands here that are to be
--  executed when a user invokes sqlplus

-- Used by Trusted Oracle
column ROWLABEL format A15

-- Used for the SHOW ERRORS command
column LINE/COL format A8
column ERROR    format A65  WORD_WRAPPED

-- Used for the SHOW SGA command
column name_col_plus_show_sga format a24

-- Defaults for SHOW PARAMETERS
column name_col_plus_show_param format a36 heading NAME
column value_col_plus_show_param format a30 heading VALUE

-- For backward compatibility
set pagesize 9999

-- Defaults for SET AUTOTRACE EXPLAIN report
column id_plus_exp format 990 heading i
column parent_id_plus_exp format 990 heading p
column plan_plus_exp format a60 
column object_node_plus_exp format a8
column other_tag_plus_exp format a29
column other_plus_exp format a44

-- Set sqlplus parameters
set autocommit off
set null "NULL"
set lines 133
set long 20000
set trimspool on
set numwidth 13
set timing on
set serveroutput on size 1000000
set arraysize 100
--set numformat 999,999,999,999,999
set numformat ""

@format


-- Set sql prompt
set termout off
define _DB_NAME=IDLE
column name new_value _DB_NAME;
select upper(instance_name) name from v$instance;
define _CURR_USER=NO_USER
column user new_value _CURR_USER;
select user from dual;
--define _HOST_NAME=
--column host_name new_value _HOST_NAME
--select decode(substr(host_name, 1, 4), 'dsok', '(' || substr(host_name, 5,5) || ')', 
--                                       'usoc', '(' || substr(host_name, 8,3) || ')',
--                                       'uspn', substr(host_name, 6,3),
--                                       'uspl', substr(host_name, 6,3),
--                                       'MLAZ', 'pc'
--                                       ' '
--             ) 
--host_name from v$instance;
 
--set SQLPROMPT '&_CURR_USER@&_DB_NAME.&_HOST_NAME> '
set SQLPROMPT '&_CURR_USER@&_DB_NAME> '
clear breaks
set termout on
set feedback on

-- Set date format
alter session set nls_date_format = 'MM/DD/YYYY HH24:MI:SS';
--alter session set nls_date_format = 'YYYYMMDD';


define _SQLDIR=/home/lazarrm/sql/bin

@instance

show user
