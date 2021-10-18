/*
 Navicat Premium Data Transfer

 Source Server         : boss测试
 Source Server Type    : PostgreSQL
 Source Server Version : 100002
 Source Host           : 127.0.0.1:5432
 Source Catalog        : wos_xxljob
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 100002
 File Encoding         : 65001

 Date: 15/10/2021 16:56:35
*/

-- ----------------------------
-- Table structure for xxl_job_group
-- ----------------------------
DROP TABLE IF EXISTS "public"."xxl_job_group";
CREATE TABLE "public"."xxl_job_group" (
  "id" serial4 primary key ,
  "app_name" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "title" varchar(12) COLLATE "pg_catalog"."default" NOT NULL,
  "address_type" int2 NOT NULL DEFAULT 0,
  "address_list" text COLLATE "pg_catalog"."default",
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."xxl_job_group"."app_name" IS '执行器AppName';
COMMENT ON COLUMN "public"."xxl_job_group"."title" IS '执行器名称';
COMMENT ON COLUMN "public"."xxl_job_group"."address_type" IS '执行器地址类型：0=自动注册、1=手动录入';
COMMENT ON COLUMN "public"."xxl_job_group"."address_list" IS '执行器地址列表，多地址逗号分隔';
COMMENT ON TABLE "public"."xxl_job_group" IS '执行器信息表，维护任务执行器信息';

-- ----------------------------
-- Table structure for xxl_job_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."xxl_job_info";
CREATE TABLE "public"."xxl_job_info" (
  "id" serial4 primary key,
  "job_group" int4 NOT NULL DEFAULT 0,
  "job_desc" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "add_time" timestamp(6),
  "update_time" timestamp(6),
  "author" varchar(64) COLLATE "pg_catalog"."default",
  "alarm_email" varchar(255) COLLATE "pg_catalog"."default",
  "schedule_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "schedule_conf" varchar(128) COLLATE "pg_catalog"."default",
  "misfire_strategy" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "executor_route_strategy" varchar(50) COLLATE "pg_catalog"."default",
  "executor_handler" varchar(255) COLLATE "pg_catalog"."default",
  "executor_param" varchar(512) COLLATE "pg_catalog"."default",
  "executor_block_strategy" varchar(50) COLLATE "pg_catalog"."default",
  "executor_timeout" int4 NOT NULL DEFAULT 0,
  "executor_fail_retry_count" int4 NOT NULL DEFAULT 0,
  "glue_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "glue_source" text COLLATE "pg_catalog"."default",
  "glue_remark" varchar(128) COLLATE "pg_catalog"."default",
  "glue_updatetime" timestamp(6),
  "child_jobid" varchar(255) COLLATE "pg_catalog"."default",
  "trigger_status" int2 NOT NULL DEFAULT 0,
  "trigger_last_time" int8 NOT NULL DEFAULT 0,
  "trigger_next_time" int8 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."xxl_job_info"."job_group" IS '执行器主键ID';
COMMENT ON COLUMN "public"."xxl_job_info"."author" IS '作者';
COMMENT ON COLUMN "public"."xxl_job_info"."alarm_email" IS '报警邮件';
COMMENT ON COLUMN "public"."xxl_job_info"."schedule_type" IS '调度类型';
COMMENT ON COLUMN "public"."xxl_job_info"."schedule_conf" IS '调度配置，值含义取决于调度类型';
COMMENT ON COLUMN "public"."xxl_job_info"."misfire_strategy" IS '调度过期策略';
COMMENT ON COLUMN "public"."xxl_job_info"."executor_route_strategy" IS '执行器路由策略';
COMMENT ON COLUMN "public"."xxl_job_info"."executor_handler" IS '执行器任务handler';
COMMENT ON COLUMN "public"."xxl_job_info"."executor_param" IS '执行器任务参数';
COMMENT ON COLUMN "public"."xxl_job_info"."executor_block_strategy" IS '阻塞处理策略';
COMMENT ON COLUMN "public"."xxl_job_info"."executor_timeout" IS '任务执行超时时间，单位秒';
COMMENT ON COLUMN "public"."xxl_job_info"."executor_fail_retry_count" IS '失败重试次数';
COMMENT ON COLUMN "public"."xxl_job_info"."glue_type" IS 'GLUE类型';
COMMENT ON COLUMN "public"."xxl_job_info"."glue_source" IS 'GLUE源代码';
COMMENT ON COLUMN "public"."xxl_job_info"."glue_remark" IS 'GLUE备注';
COMMENT ON COLUMN "public"."xxl_job_info"."glue_updatetime" IS 'GLUE更新时间';
COMMENT ON COLUMN "public"."xxl_job_info"."child_jobid" IS '子任务ID，多个逗号分隔';
COMMENT ON COLUMN "public"."xxl_job_info"."trigger_status" IS '调度状态：0-停止，1-运行';
COMMENT ON COLUMN "public"."xxl_job_info"."trigger_last_time" IS '上次调度时间';
COMMENT ON COLUMN "public"."xxl_job_info"."trigger_next_time" IS '下次调度时间';
COMMENT ON TABLE "public"."xxl_job_info" IS '调度扩展信息表：用域保存XXL-JOB调度任务的扩展信息，比如任务分组、任务名、机器地址、执行器、执行入参报警邮件等等。';

-- ----------------------------
-- Table structure for xxl_job_lock
-- ----------------------------
DROP TABLE IF EXISTS "public"."xxl_job_lock";
CREATE TABLE "public"."xxl_job_lock" (
  "lock_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."xxl_job_lock"."lock_name" IS '锁名称';

-- ----------------------------
-- Table structure for xxl_job_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."xxl_job_log";
CREATE TABLE "public"."xxl_job_log" (
  "id" serial8 primary key,
  "job_group" int4 NOT NULL DEFAULT 0,
  "job_id" int4 NOT NULL DEFAULT 0,
  "executor_address" varchar(255) COLLATE "pg_catalog"."default",
  "executor_handler" varchar(255) COLLATE "pg_catalog"."default",
  "executor_param" varchar(512) COLLATE "pg_catalog"."default",
  "executor_sharding_param" varchar(20) COLLATE "pg_catalog"."default",
  "executor_fail_retry_count" int4 NOT NULL DEFAULT 0,
  "trigger_time" timestamp(6),
  "trigger_code" int4 NOT NULL DEFAULT 0,
  "trigger_msg" text COLLATE "pg_catalog"."default",
  "handle_time" timestamp(6),
  "handle_code" int4 NOT NULL DEFAULT 0,
  "handle_msg" text COLLATE "pg_catalog"."default",
  "alarm_status" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."xxl_job_log"."job_group" IS '执行器主键ID';
COMMENT ON COLUMN "public"."xxl_job_log"."job_id" IS '任务，主键ID';
COMMENT ON COLUMN "public"."xxl_job_log"."executor_address" IS '执行器地址，本次执行的地址';
COMMENT ON COLUMN "public"."xxl_job_log"."executor_handler" IS '执行器任务handler';
COMMENT ON COLUMN "public"."xxl_job_log"."executor_param" IS '执行器任务参数';
COMMENT ON COLUMN "public"."xxl_job_log"."executor_sharding_param" IS '执行器任务分片参数，格式如 1/2';
COMMENT ON COLUMN "public"."xxl_job_log"."executor_fail_retry_count" IS '失败重试次数';
COMMENT ON COLUMN "public"."xxl_job_log"."trigger_time" IS '调度-时间';
COMMENT ON COLUMN "public"."xxl_job_log"."trigger_code" IS '调度-结果';
COMMENT ON COLUMN "public"."xxl_job_log"."trigger_msg" IS '调度-日志';
COMMENT ON COLUMN "public"."xxl_job_log"."handle_time" IS '执行-时间';
COMMENT ON COLUMN "public"."xxl_job_log"."handle_code" IS '执行-状态';
COMMENT ON COLUMN "public"."xxl_job_log"."handle_msg" IS '执行-日志';
COMMENT ON COLUMN "public"."xxl_job_log"."alarm_status" IS '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';
COMMENT ON TABLE "public"."xxl_job_log" IS '日志表：用于保存xxl-job任务调度的历史信息，如调度结果、执行结果、调度入参、调度机器和执行器等';

-- ----------------------------
-- Table structure for xxl_job_log_report
-- ----------------------------
DROP TABLE IF EXISTS "public"."xxl_job_log_report";
CREATE TABLE "public"."xxl_job_log_report" (
  "id" serial4 primary key,
  "trigger_day" timestamp(6),
  "running_count" int4 NOT NULL DEFAULT 0,
  "suc_count" int4 NOT NULL DEFAULT 0,
  "fail_count" int4 NOT NULL,
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."xxl_job_log_report"."trigger_day" IS '调度-时间';
COMMENT ON COLUMN "public"."xxl_job_log_report"."running_count" IS '运行中-日志数量';
COMMENT ON COLUMN "public"."xxl_job_log_report"."suc_count" IS '执行成功-日志数量';
COMMENT ON COLUMN "public"."xxl_job_log_report"."fail_count" IS '执行失败-日志数量';
COMMENT ON TABLE "public"."xxl_job_log_report" IS '日志报表：用于存储job任务调度日志的报表，调度中心报表功能页面会用到';

-- ----------------------------
-- Table structure for xxl_job_logglue
-- ----------------------------
DROP TABLE IF EXISTS "public"."xxl_job_logglue";
CREATE TABLE "public"."xxl_job_logglue" (
  "id" serial4 primary key,
  "job_id" int4 NOT NULL DEFAULT 0,
  "glue_type" varchar(50) COLLATE "pg_catalog"."default",
  "glue_source" text COLLATE "pg_catalog"."default",
  "glue_remark" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "add_time" timestamp(6),
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."xxl_job_logglue"."job_id" IS '任务，主键ID';
COMMENT ON COLUMN "public"."xxl_job_logglue"."glue_type" IS 'GLUE类型';
COMMENT ON COLUMN "public"."xxl_job_logglue"."glue_source" IS 'GLUE源代码';
COMMENT ON COLUMN "public"."xxl_job_logglue"."glue_remark" IS 'GLUE备注';
COMMENT ON TABLE "public"."xxl_job_logglue" IS '任务GLUE日志，用于保存GLUE更新历史，用域支持GLUE的版本回溯功能';

-- ----------------------------
-- Table structure for xxl_job_registry
-- ----------------------------
DROP TABLE IF EXISTS "public"."xxl_job_registry";
CREATE TABLE "public"."xxl_job_registry" (
  "id" serial4 primary key,
  "registry_group" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "registry_key" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "registry_value" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "update_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."xxl_job_registry" IS '执行器注册表，维护在线的执行器和调度中心机器地址信息';

-- ----------------------------
-- Table structure for xxl_job_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."xxl_job_user";
CREATE TABLE "public"."xxl_job_user" (
  "id" serial4 primary key,
  "username" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "role" int2 NOT NULL DEFAULT 0,
  "permission" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."xxl_job_user"."username" IS '账号';
COMMENT ON COLUMN "public"."xxl_job_user"."password" IS '密码';
COMMENT ON COLUMN "public"."xxl_job_user"."role" IS '角色：0-普通用户、1-管理员';
COMMENT ON COLUMN "public"."xxl_job_user"."permission" IS '权限：执行器ID列表，多个逗号分割';

-- ----------------------------
-- Indexes structure for table xxl_job_log
-- ----------------------------
CREATE INDEX  ON "public"."xxl_job_log" USING btree (
  "handle_code" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX  ON "public"."xxl_job_log" USING btree (
  "trigger_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
-- ----------------------------
-- Indexes structure for table xxl_job_log_report
-- ----------------------------
CREATE INDEX  ON "public"."xxl_job_log_report" USING btree (
  "trigger_day" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Indexes structure for table xxl_job_registry
-- ----------------------------
CREATE INDEX ON "public"."xxl_job_registry" USING btree (
  "registry_group" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "registry_key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "registry_value" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Indexes structure for table xxl_job_user
-- ----------------------------
CREATE INDEX ON "public"."xxl_job_user" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

INSERT INTO xxl_job_group(id, app_name, title, address_type, address_list, update_time) VALUES (1, 'xxl-job-executor-sample', '示例执行器', 0, NULL, '2018-11-03 22:21:31' );
INSERT INTO xxl_job_info(id, job_group, job_desc, add_time, update_time, author, alarm_email, schedule_type, schedule_conf, misfire_strategy, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid) VALUES (1, 1, '测试任务1', '2018-11-03 22:21:31', '2018-11-03 22:21:31', 'XXL', '', 'CRON', '0 0 0 * * ? *', 'DO_NOTHING', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2018-11-03 22:21:31', '');
INSERT INTO xxl_job_user(id, username, password, role, permission) VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);
INSERT INTO xxl_job_lock ( lock_name) VALUES ( 'schedule_lock');
