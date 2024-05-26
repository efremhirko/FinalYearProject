package lastproject;

public class TeacherFactory {
 public static Teacher createTeacher(String fullName, String username, String password, String gender,
                                 int experience, String educationLevel, String FieldOfStudy, String email, String phone,
                                 String department, String role) {
        return new Teacher(fullName, username, password, gender, experience, educationLevel,FieldOfStudy,
                email, phone, department, role);
    
}
 
}