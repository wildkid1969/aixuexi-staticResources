/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/4/14 15:37:31                           */
/*==============================================================*/


drop table if exists course_evaluate_index;

drop table if exists course_evaluate_report;

drop table if exists course_homework;

drop table if exists object_image;

drop table if exists user_attendance;

drop table if exists user_evaluate;

drop table if exists user_evaluate_detail;

drop table if exists user_homework;

drop table if exists user_homework_details;

/*==============================================================*/
/* Table: course_evaluate_index                                 */
/*==============================================================*/
create table course_evaluate_index
(
   evaluate_index_id    bigint not null auto_increment,
   index_name           varchar(50) not null comment '评定指标',
   courseid             bigint not null,
   weight               double(6,2) not null comment '权重',
   score_change         double(6,2) comment '均分调整',
   average_score        double(6,2) comment '项目平均分',
   rule_details         varchar(255),
   type                 tinyint not null default 1 comment '评定类型1 常规 2自定义',
   createtime           datetime not null,
   primary key (evaluate_index_id)
)
ENGINE = InnoDB;

alter table course_evaluate_index comment '课程评定设置的各个项目';

/*==============================================================*/
/* Table: course_evaluate_report                                */
/*==============================================================*/
create table course_evaluate_report
(
   evaluate_report_id   bigint not null auto_increment,
   courseid             bigint not null,
   evaluateid           bigint not null comment 'user_evaluate表的id',
   userid               bigint not null,
   content              text comment '报告内容',
   createtime           datetime not null,
   comment              text comment '导师寄语',
   operator_id          bigint not null default 0 comment '操作人id',
   primary key (evaluate_report_id)
)
ENGINE = InnoDB;

alter table course_evaluate_report comment '培训评定报告';

/*==============================================================*/
/* Table: course_homework                                       */
/*==============================================================*/
create table course_homework
(
   homeworkid           bigint not null auto_increment,
   courseid             bigint not null comment '课程id',
   work_name            varchar(50) not null comment '作业名称',
   limit_starttime      datetime not null comment '作业提交限制开始时间',
   limit_endtime        datetime not null comment '作业提交限制结束时间',
   requirement          varchar(255) not null comment '作业要求',
   status               tinyint not null default 1 comment '状态 1未开启 2开启',
   createtime           datetime not null,
   updatetime           datetime,
   operator_id          bigint not null default 0 comment '操作者id',
   primary key (homeworkid)
)
ENGINE = InnoDB CHARSET=utf8;

alter table course_homework comment '课程所属的作业';

/*==============================================================*/
/* Table: object_image                                          */
/*==============================================================*/
create table object_image
(
   imageid              bigint not null auto_increment,
   objectid             bigint not null comment '对象id根据type类型而定',
   image_url            varchar(200) not null comment '图片链接',
   createtime           datetime not null comment '创建时间',
   type                 tinyint not null comment '图片类型（对应objectid） 1课程作业要求 2作业内容 3作业点评 4评定寄语 ',
   primary key (imageid)
)
ENGINE = InnoDB;

alter table object_image comment '图片资源对应表';

/*==============================================================*/
/* Table: user_attendance                                       */
/*==============================================================*/
create table user_attendance
(
   attendid             bigint not null auto_increment,
   courseid             bigint not null,
   ins_id               bigint not null comment '机构id',
   ins_name             varchar(20) comment '机构名称',
   userid               bigint not null,
   username             varchar(20) comment '用户真实姓名',
   user_subject         varchar(50) comment '老师所教科目',
   user_phone           varchar(20) comment '用户手机',
   status               tinyint not null default 0 comment '状态：1已签 2迟到',
   createtime           datetime not null,
   updatetime           datetime,
   primary key (attendid)
)
ENGINE = InnoDB;

alter table user_attendance comment '用户考勤签到记录';

/*==============================================================*/
/* Table: user_evaluate                                         */
/*==============================================================*/
create table user_evaluate
(
   evaluateid           bigint not null auto_increment,
   courseid             bigint not null,
   ins_id               bigint not null comment '机构id',
   ins_name             varchar(20) comment '机构名称',
   userid               bigint not null,
   total_score          double(6,2) not null default 0 comment '总分',
   createtime           datetime not null comment '创建时间',
   primary key (evaluateid)
)
ENGINE = InnoDB;

alter table user_evaluate comment '课程下用户的评定结果表';

/*==============================================================*/
/* Table: user_evaluate_detail                                  */
/*==============================================================*/
create table user_evaluate_detail
(
   evaluate_detail_id   bigint not null auto_increment,
   evaluateid           bigint not null,
   courseid             bigint not null,
   userid               bigint not null,
   ins_id               bigint not null,
   ins_name             varchar(20),
   evaluate_index_id    bigint,
   real_score           double(6,2) not null comment '真实得分',
   final_score          double(6,2) not null comment '最终得分',
   createtime           datetime,
   primary key (evaluate_detail_id)
)
ENGINE = InnoDB;

alter table user_evaluate_detail comment '课程下用户的评定详情表';

/*==============================================================*/
/* Table: user_homework                                         */
/*==============================================================*/
create table user_homework
(
   homework_id          bigint not null auto_increment,
   courseid             bigint not null,
   ins_id               bigint not null default 0 comment '机构id',
   ins_name             varchar(20) comment '机构名称',
   userid               bigint not null,
   work_name            varchar(100) comment '作业名称',
   createtime           datetime not null comment '创建时间',
   updatetime           datetime comment '更新时间',
   real_score           double(6,2) not null default 0 comment '作业实际得分',
   status               tinyint not null default 1 comment '作业提交状态  1待提交 2待批改 3批改中 4已批改 5未提交',
   primary key (homework_id)
)
ENGINE = InnoDB;

alter table user_homework comment '课程下用户提交的作业答案';

/*==============================================================*/
/* Table: user_homework_details                                 */
/*==============================================================*/
create table user_homework_details
(
   homework_detail_id   bigint not null auto_increment,
   courseid             bigint not null,
   userid               bigint not null,
   user_homework_id     bigint not null comment 'user_homework的id',
   content              text not null comment '作业答案',
   comment              text comment '作业评语',
   operator_id          bigint not null default 0 comment '操作人id',
   primary key (homework_detail_id)
)
ENGINE = InnoDB;

alter table user_homework_details comment '用户作业详情';

