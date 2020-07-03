
/*-----------------training center and trainer-------------------------------*/
select concat(tcenter.id,trainer.id) as id, DATE_FORMAT(GREATEST( IFNULL(trainer.modified_date,IFNULL(trainer.created_date,'1970-01-01 12:00:00')),'1970-01-01 12:00:00'), '%Y-%m-%d %T') AS modification_time,
  trainer.id as trainer_id , tcenter.id as training_center_id, tcenter.name as training_center_name, tcenter.location training_center_location, tcenter.address as training_center_address, tcenter.email as training_center_email, tcenter.phone_no as training_center_phone, trainer.trainer_code as trainer_code, trainer.trainer_name as trainer_name, trainer.com_gender as trainer_gender,
  trainer.date_of_birth as trainer_dateofbirth, YEAR(CURDATE()) - YEAR(trainer.date_of_birth) as trainer_age,
  trainer.maritial_status as marital_status, trainer.com_nationality as trainer_nationality, trainer.email as trainer_email,
  trainer.mobile_no as trainer_phone, trainer.national_id as trainer_national_id
from com_training_center as tcenter
  left join trn_trainer as trainer on trainer.com_training_center_id=tcenter.id
where tcenter.id=7
/**---To avoid some filter problem is it best to use 2018-02-01----*/
select concat(tcenter.id,trainer.id) as id, DATE(GREATEST( IFNULL(trainer.modified_date,IFNULL(trainer.created_date,'2018-02-01 12:00:00')),'2018-02-01 12:00:00')) AS modification_time, DATE(IFNULL(trainer.created_date,'2018-02-01 12:00:00')) as enrolment_date,
  trainer.id as trainer_id , tcenter.id as training_center_id, tcenter.name as training_center_name, tcenter.location training_center_location, tcenter.address as training_center_address, tcenter.email as training_center_email, tcenter.phone_no as training_center_phone, trainer.trainer_code as trainer_code, trainer.trainer_name as trainer_name, trainer.com_gender as trainer_gender,
  trainer.date_of_birth as trainer_dateofbirth, YEAR(CURDATE()) - YEAR(trainer.date_of_birth) as trainer_age,
  trainer.maritial_status as marital_status, trainer.com_nationality as trainer_nationality, trainer.email as trainer_email,
  trainer.mobile_no as trainer_phone, trainer.national_id as trainer_national_id, designation.name as designation,
  organization.name as organization
from com_training_center as tcenter
  left join trn_trainer as trainer on trainer.com_training_center_id=tcenter.id
  left join set_up_data_com as designation on designation.id=trainer.com_designation_id
  left join set_up_data_com as organization on organization.id=trainer.com_organization_id
where tcenter.id=7

/*-----------------training center and courses and participants-------------------------------*/
select concat(tcenter.id,batch.id,enrolment.id) as id, DATE(GREATEST(IFNULL(batch.modified_date,IFNULL(
batch.created_date,'2018-02-01 12:00:00')),IFNULL(course.modified_date,IFNULL(course.created_date,'2018-02-01 12:00:00')),IFNULL(enrolment.modified_date,IFNULL(enrolment.created_date,'2018-02-01 12:00:00')),
IFNULL(participant.modified_date,IFNULL(participant.created_date,'2018-02-01 12:00:00')),'2018-02-01 12:00:00')) AS modification_time, DATE(enrolment.created_date) as enrolment_date,
  tcenter.id as training_center_id, course.id as course_id, enrolment.trn_course_id,
  tcenter.name as training_center_name, tcenter.location training_center_location, tcenter.address as training_center_address, tcenter.email as training_center_email, tcenter.phone_no as training_center_phone,
  batch.code as batch_code, batch.duration as batch_duration, batch.name as batch_name, batch.no_of_participant as bacth_no_participant, batch.no_of_participant_reg as batch_no_participant_reg, batch.training_end_date as training_end_date,
  batch.training_start_date as training_start_date, batch.trn_batch_status as batch_status,
  course.code as course_code, course.name as course_name, course.description as course_description, course.objective as course_objective,
  course.duration as course_duration,
  enrolment.certificate_issue_date, enrolment.is_certificate_issued,
  enrolment.trn_participant_status as enrolement_participant_status, participant.id as participant_id,
  participant.niport_code as participant_niport_code, participant.nid as participant_nid, participant.name as participant_name, participant.com_gender as participant_gender, participant.com_religion as participant_religion, participant.date_of_birth as participant_dateofbirth, YEAR(CURDATE()) - YEAR(participant.date_of_birth) as participant_age, participant.email as participant_email, participant.mobile_no as participant_mobile_no, designation.name as designation,
  grade.name as grade, organization.name as organization
from com_training_center as tcenter
  left join trn_batch as batch on batch.com_training_center_id=tcenter.id
  left join trn_course as course on course.id=batch.trn_course_id
  left join trn_participant_enroll as enrolment on enrolment.trn_batch_id=batch.id
  left join reg_participant as participant on participant.id=enrolment.reg_participant_id
  left join set_up_data_com as designation on designation.id=participant.com_designation_id
  left join set_up_data_com as grade on grade.id=participant.com_grade_id
  left join set_up_data_com as organization on organization.id=participant.com_organization_id
where participant.id is not null and tcenter.id=7

/*------------------------------- create trn view----------------------------------------*/
create view rtcgangni_vw
as
  select concat(tcenter.id,trainer.id) as id, DATE_FORMAT(GREATEST( IFNULL(trainer.modified_date,'1970-01-01 12:00:00'),'1970-01-01 12:00:00'), '%Y-%m-%d %T') AS modification_time,
    trainer.id as trainer_id , tcenter.id as training_center_id, tcenter.name as training_center_name, tcenter.location training_center_location, tcenter.address as training_center_address, tcenter.email as training_center_email, tcenter.phone_no as training_center_phone, trainer.trainer_code as trainer_code, trainer.trainer_name as trainer_name, trainer.com_gender as trainer_gender,
    trainer.date_of_birth as trainer_dateofbirth, YEAR(CURDATE()) - YEAR(trainer.date_of_birth) as trainer_age,
    trainer.maritial_status as marital_status, trainer.com_nationality as trainer_nationality, trainer.email as trainer_email,
    trainer.mobile_no as trainer_phone, trainer.national_id as trainer_national_id
  from com_training_center as tcenter
    left join trn_trainer as trainer on trainer.com_training_center_id=tcenter.id
  where tcenter.id=7

/*--*/
create view rtcgangni_trainees_view
AS
  select concat(tcenter.id,batch.id,enrolment.id) as id, DATE_FORMAT(GREATEST(IFNULL(batch.modified_date,'1970-01-01 12:00:00'),IFNULL(course.modified_date,'1970-01-01 12:00:00'),IFNULL(enrolment.modified_date,'1970-01-01 12:00:00'),
IFNULL(participant.modified_date,'1970-01-01 12:00:00'),'1970-01-01 12:00:00'), '%Y-%m-%d %T') AS modification_time,
    tcenter.id as training_center_id, course.id as course_id, batch.id as batch_id,
    tcenter.name as training_center_name, tcenter.location training_center_location, tcenter.address as training_center_address, tcenter.email as training_center_email, tcenter.phone_no as training_center_phone,
    batch.code as batch_code, batch.duration as batch_duration, batch.name as batch_name, batch.no_of_participant as bacth_no_participant, batch.no_of_participant_reg as batch_no_participant_reg, batch.training_end_date as training_end_date,
    batch.training_start_date as training_start_date, batch.trn_batch_status as batch_status,
    course.code, course.name as course_name, course.description as course_description, course.objective as course_objective,
    course.duration as course_duration,
    enrolment.certificate_issue_date, enrolment.is_certificate_issued, enrolment.trn_course_id,
    enrolment.trn_participant_status as enrolement_participant_status, participant.id as participant_id,
    participant.niport_code as participant_niport_code, participant.nid as participant_nid, participant.name as participant_name, participant.com_gender as participant_gender, participant.com_religion as participant_religion, participant.date_of_birth as participant_dateofbirth, YEAR(CURDATE()) - YEAR(participant.date_of_birth) as participant_age, participant.email as participant_email, participant.mobile_no as participant_mobile_no
  from com_training_center as tcenter
    left join trn_batch as batch on batch.com_training_center_id=tcenter.id
    left join trn_course as course on course.id=batch.trn_course_id
    left join trn_participant_enroll as enrolment on enrolment.trn_batch_id=batch.id
    left join reg_participant as participant on participant.id=enrolment.reg_participant_id
  where tcenter.id=7