/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/4/13 21:02:41                           */
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
   index_name           varchar(50) not null,
   courseid             bigint not null,
   ins_id               bigint not null,
   ins_name             varchar(20),
   weight               double(6,2) not null,
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
   evaluateid           bigint not null,
   userid               bigint not null,
   lectruerid           bigint not null,
   lectruer_name        varchar(50),
   content              text comment '报告内容',
   createtime           datetime not null,
   comment              text comment '导师寄语',
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
   ins_id               bigint,
   ins_name             varchar(20),
   courseid             bigint not null comment '课程id',
   work_name            varchar(50) not null comment '作业名称',
   limit_starttime      datetime not null comment '作业提交限制开始时间',
   limit_endtime        datetime not null comment '作业提交限制结束时间',
   requirement          varchar(255) not null comment '作业要求',
   status               tinyint not null default 1 comment '状态 1未开启 2开启',
   ishas_image          tinyint not null default 0 comment '是否有图 0 否 1有',
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
   objectid             bigint not null,
   image_url            varchar(200) not null,
   createtime           datetime not null,
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
   ins_id               bigint not null,
   ins_name             varchar(20),
   userid               bigint not null,
   username             varchar(20),
   user_subject         varchar(20),
   user_phone           varchar(20),
   status               tinyint,
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
   ins_id               bigint not null,
   ins_name             varchar(20),
   userid               bigint not null,
   total_score          double(6,2) not null default 0,
   createtime           datetime,
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
   user_homework_id     bigint not null auto_increment,
   courseid             bigint not null,
   ins_id               bigint,
   ins_name             varchar(20),
   userid               bigint not null,
   work_name            varchar(100),
   createtime           datetime not null,
   score                double(6,2) not null default 0,
   status               tinyint not null default 1 comment '作业提交状态  1待提交 2待批改 3批改中 4已批改 5未提交',
   primary key (user_homework_id)
)
ENGINE = InnoDB;

alter table user_homework comment '课程下用户提交的作业答案';

/*==============================================================*/
/* Table: user_homework_details                                 */
/*==============================================================*/
create table user_homework_details
(
   homework_detail_id   bigint not null auto_increment,
   userid               bigint not null,
   user_homework_id     bigint not null,
   content              text not null,
   comment              text,
   lectruerid           bigint,
   lectruer_name        varchar(50),
   primary key (homework_detail_id)
)
ENGINE = InnoDB;

alter table user_homework_details comment '用户作业详情';

