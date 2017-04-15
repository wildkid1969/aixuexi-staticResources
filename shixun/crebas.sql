/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/4/15 11:48:40                           */
/*==============================================================*/


drop table if exists course_evaluate_index;

drop table if exists course_evaluate_report;

drop table if exists course_homework;

drop table if exists object_image;

drop table if exists user_attendance;

drop table if exists user_evaluate;

drop table if exists user_evaluate_detail;

drop table if exists user_homework;

drop table if exists user_homework_detail;

/*==============================================================*/
/* Table: course_evaluate_index                                 */
/*==============================================================*/
create table course_evaluate_index
(
   evaluate_index_id    bigint not null auto_increment,
   index_name           varchar(50) not null default "" comment '评定指标',
   course_id            bigint not null default 0 comment '课程id',
   weight               decimal(6,2) not null default 0.00 comment '权重',
   score_change         decimal(6,2) not null default 0.00 comment '均分调整',
   average_score        decimal(6,2) not null default 0.00 comment '项目平均分',
   rule_details         varchar(255) not null default "" comment '指标细则',
   type                 tinyint not null default 1 comment '评定类型1 常规 2自定义',
   createtime           datetime not null default CURRENT_TIMESTAMP comment '创建时间',
   update_time          datetime not null default CURRENT_TIMESTAMP comment '更新时间',
   primary key (evaluate_index_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

alter table course_evaluate_index comment '课程评定设置的各个项目';

/*==============================================================*/
/* Table: course_evaluate_report                                */
/*==============================================================*/
create table course_evaluate_report
(
   evaluate_report_id   bigint not null auto_increment,
   course_id            bigint not null default 0 comment '课程id',
   evaluate_id          bigint not null default 0 comment 'user_evaluate表的id',
   user_id              bigint not null default 0 comment '用户id',
   content              text not null default "" comment '报告内容',
   create_time          datetime not null default CURRENT_TIMESTAMP comment '创建时间',
   update_time          datetime not null default CURRENT_TIMESTAMP comment '更新时间',
   comment              text not null default "" comment '导师寄语',
   operator_id          bigint not null default 0 comment '操作人id',
   primary key (evaluate_report_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

alter table course_evaluate_report comment '培训评定报告';

/*==============================================================*/
/* Table: course_homework                                       */
/*==============================================================*/
create table course_homework
(
   course_homework_id   bigint not null auto_increment,
   course_id            bigint not null default 0 comment '课程id',
   work_name            varchar(50) not null default "" comment '作业名称',
   limit_start_time     datetime not null default CURRENT_TIMESTAMP comment '作业提交限制开始时间',
   limit_end_time       datetime not null default CURRENT_TIMESTAMP comment '作业提交限制结束时间',
   requirement          varchar(255) not null default "" comment '作业要求',
   status               tinyint not null default 1 comment '状态 1未开启 2开启',
   create_time          datetime not null default CURRENT_TIMESTAMP comment '创建时间',
   update_time          datetime not null default CURRENT_TIMESTAMP comment '更新时间',
   operator_id          bigint not null default 0 comment '操作者id',
   primary key (course_homework_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

alter table course_homework comment '课程所属的作业';

/*==============================================================*/
/* Table: object_image                                          */
/*==============================================================*/
create table object_image
(
   image_id             bigint not null auto_increment,
   object_id            bigint not null default 0 comment '对象id根据type类型而定',
   image_url            varchar(200) not null default "" comment '图片链接',
   create_time          datetime not null default CURRENT_TIMESTAMP comment '创建时间',
   update_time          datetime not null default CURRENT_TIMESTAMP comment '更新时间',
   type                 tinyint not null default 0 comment '图片类型（对应objectid） 1课程作业要求 2作业内容 3作业点评 4评定寄语 ',
   sort                 tinyint not null default 0 comment '顺序',
   primary key (image_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

alter table object_image comment '图片资源对应表';

/*==============================================================*/
/* Table: user_attendance                                       */
/*==============================================================*/
create table user_attendance
(
   attend_id            bigint not null auto_increment,
   course_id            bigint not null default 0 comment '课程id',
   ins_id               bigint not null default 0 comment '机构id',
   ins_name             varchar(20) not null default "" comment '机构名称',
   user_id              bigint not null default 0 comment '用户id',
   user_name            varchar(20) not null default "" comment '用户真实姓名',
   user_subject         varchar(50) not null default "" comment '老师所教科目',
   user_phone           varchar(20) not null default "" comment '用户手机',
   status               tinyint not null default 0 comment '状态：1已签 2迟到',
   create_time          datetime not null default CURRENT_TIMESTAMP comment '创建时间',
   update_time          datetime not null default CURRENT_TIMESTAMP comment '更新时间',
   primary key (attend_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

alter table user_attendance comment '用户考勤签到记录';

/*==============================================================*/
/* Table: user_evaluate                                         */
/*==============================================================*/
create table user_evaluate
(
   evaluate_id          bigint not null auto_increment,
   course_id            bigint not null default 0 comment '课程id',
   ins_id               bigint not null default 0 comment '机构id',
   ins_name             varchar(20) not null default "" comment '机构名称',
   user_id              bigint not null default 0 comment '用户id',
   total_score          decimal(6,2) not null default 0.00 comment '总分',
   create_time          datetime not null default CURRENT_TIMESTAMP comment '创建时间',
   update_time          datetime not null default CURRENT_TIMESTAMP comment '更新时间',
   primary key (evaluate_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

alter table user_evaluate comment '课程下用户的评定结果表';

/*==============================================================*/
/* Table: user_evaluate_detail                                  */
/*==============================================================*/
create table user_evaluate_detail
(
   evaluate_detail_id   bigint not null auto_increment,
   evaluate_id          bigint not null default 0 comment 'user_evaluate表id',
   course_id            bigint not null default 0 comment '课程id',
   user_id              bigint not null default 0 comment '用户id',
   ins_id               bigint not null default 0 comment '机构id',
   ins_name             varchar(20) not null default "" comment '机构名称',
   evaluate_index_id    bigint not null default 0 comment 'course_evaluate_index表id',
   real_score           decimal(6,2) not null default 0.00 comment '真实得分',
   final_score          decimal(6,2) not null default 0.00 comment '最终得分',
   create_time          datetime not null default CURRENT_TIMESTAMP comment '创建时间',
   update_time          datetime not null default CURRENT_TIMESTAMP comment '更新时间',
   primary key (evaluate_detail_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

alter table user_evaluate_detail comment '课程下用户的评定详情表';

/*==============================================================*/
/* Table: user_homework                                         */
/*==============================================================*/
create table user_homework
(
   user_homework_id     bigint not null auto_increment,
   course_id            bigint not null default 0 comment '课程id',
   ins_id               bigint not null default 0 comment '机构id',
   ins_name             varchar(20) not null default "" comment '机构名称',
   user_id              bigint not null default 0 comment '用户id',
   work_name            varchar(100) not null default "" comment '作业名称',
   create_time          datetime not null default CURRENT_TIMESTAMP comment '创建时间',
   update_time          datetime not null default CURRENT_TIMESTAMP comment '更新时间',
   real_score           decimal(6,2) not null default 0.00 comment '作业实际得分',
   status               tinyint not null default 1 comment '作业提交状态  1待提交 2待批改 3批改中 4已批改 5未提交',
   primary key (user_homework_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

alter table user_homework comment '课程下用户提交的作业答案';

/*==============================================================*/
/* Table: user_homework_detail                                  */
/*==============================================================*/
create table user_homework_detail
(
   homework_detail_id   bigint not null auto_increment,
   course_id            bigint not null default 0 comment '课程id',
   user_id              bigint not null default 0 comment '用户id',
   user_homework_id     bigint not null default 0 comment 'user_homework的id',
   content              text not null default "" comment '作业答案',
   comment              text not null default "" comment '作业评语',
   operator_id          bigint not null default 0 comment '操作人id',
   create_time          datetime not null default CURRENT_TIMESTAMP comment '创建时间',
   update_time          datetime not null default CURRENT_TIMESTAMP comment '更新时间',
   primary key (homework_detail_id)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

alter table user_homework_detail comment '用户作业详情';

