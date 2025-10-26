package com.medicalportal.medicalportal.repository.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_DoctorSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface receptionist_DoctorScheduleRepository extends JpaRepository<receptionist_DoctorSchedule, Long> {
    
    // Find schedules by doctor ID
    List<receptionist_DoctorSchedule> findByDoctorId(Integer doctorId);
    
    // Find schedules by doctor ID and day of week
    List<receptionist_DoctorSchedule> findByDoctorIdAndDayOfWeek(Integer doctorId, String dayOfWeek);
    
    // Find available schedules by doctor ID
    List<receptionist_DoctorSchedule> findByDoctorIdAndIsAvailable(Integer doctorId, Boolean isAvailable);
    
    // Find schedules by doctor ID and day of week and availability
    List<receptionist_DoctorSchedule> findByDoctorIdAndDayOfWeekAndIsAvailable(Integer doctorId, String dayOfWeek, Boolean isAvailable);
}
