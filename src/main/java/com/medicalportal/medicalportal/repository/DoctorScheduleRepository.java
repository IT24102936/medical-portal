package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.DoctorSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DoctorScheduleRepository extends JpaRepository<DoctorSchedule, Long> {
    
    // Find schedules by doctor ID
    List<DoctorSchedule> findByDoctorId(Long doctorId);
    
    // Find schedules by doctor ID and day of week
    List<DoctorSchedule> findByDoctorIdAndDayOfWeek(Long doctorId, String dayOfWeek);
    
    // Find available schedules by doctor ID
    List<DoctorSchedule> findByDoctorIdAndIsAvailable(Long doctorId, Boolean isAvailable);
    
    // Find schedules by doctor ID and day of week and availability
    List<DoctorSchedule> findByDoctorIdAndDayOfWeekAndIsAvailable(Long doctorId, String dayOfWeek, Boolean isAvailable);
}
